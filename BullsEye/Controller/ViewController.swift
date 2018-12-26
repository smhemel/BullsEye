//
//  ViewController.swift
//  BullsEye
//
//  Created by S M HEMEL on 26/12/18.
//  Copyright © 2018 S M HEMEL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    
    
    var score = 0
    var round = 0
    var targetValue = 0
    var currentValue = 0

    @IBOutlet weak var targetNumberLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var slidertrack: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentValue = lroundf(slidertrack.value)
        startNewGame()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slidertrack.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slidertrack.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = UIImage(named: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage?.resizableImage(withCapInsets: insets)
        slidertrack.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")
        let trackRightResizable = trackRightImage?.resizableImage(withCapInsets: insets)
        slidertrack.setMaximumTrackImage(trackRightResizable, for: .normal)
        
    }
    @IBAction func starButtonPressed(_ sender: Any) {
        score = 0
        round = 0
        startNewGame()
    }
    func updateLabels() {
        targetNumberLabel.text = String(targetValue)
        roundLabel.text = String(round)
        scoreLabel.text = String(score)
    }
    
    func startNewGame() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slidertrack.value = Float(currentValue)
        updateLabels()
    }
    
    @IBAction func hitMeButtonPressed(_ sender: Any) {
        
        let difference = abs(targetValue-currentValue)
        var points = 100-difference
        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference <= 5 {
            title = "You Almost had it!"
            points += 50
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        
        score += points
        let message = "Your scored \(points) points."
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Awesome", style: .default) { (action) in
            self.startNewGame()
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
}

