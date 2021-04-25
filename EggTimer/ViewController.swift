//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes = [
        "Soft": 1,
        "Medium": 2,
        "Hard": 3
    ]
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var timer = Timer()
    let path = Bundle.main.path(forResource: "alarm_sound.mp3", ofType: nil)!
    var audioPlayer: AVAudioPlayer?
    
    @IBAction func hardnessButtonPressed(_ sender: UIButton) {
        
        timer.invalidate()
        progressBar.progress = 0
        let hardnessSelected = sender.currentTitle!
        label.text = "Please wait while your \(hardnessSelected) Eggs are getting ready."
        let totalTimeNeeded = eggTimes[hardnessSelected]! * 60
        var timePassed = 0
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
        }catch{
            print("Error while loading sound file. \(error)")
        }
        
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            //print("Time Passed: \(timePassed) seconds.")
            timePassed += Int(timer.timeInterval)
            
            self.progressBar.progress = Float(timePassed) / Float(totalTimeNeeded)
            
            if timePassed >= totalTimeNeeded {
                self.label.text = "Your \(hardnessSelected) Eggs are Ready!!!"
                self.audioPlayer?.play()
                timer.invalidate()
            }
        }
        
    }
    
}
