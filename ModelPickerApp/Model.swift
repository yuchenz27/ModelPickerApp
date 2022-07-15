//
//  Model.swift
//  ModelPickerApp
//
//  Created by Yuchen Zhang on 2022/7/15.
//

import UIKit
import RealityKit
import Combine

class Model {
    var modelName: String
    var image: UIImage
    var modelEntity: ModelEntity?
    
    private var cancellable: AnyCancellable? = nil
    
    init(modelName: String) {
        self.modelName = modelName
        self.image = UIImage(named: modelName)!
        
        let filename = modelName + ".usdz"
        self.cancellable = ModelEntity.loadModelAsync(named: filename)
            .sink(receiveCompletion: { loadCompletion in
                // Handle error
                print("DEBUG: Unable to load model entity for model name: \(self.modelName)")
            }, receiveValue: { modelEntity in
                // Get our model entity
                self.modelEntity = modelEntity
                print("DEBUG: Successfully loaded model entity for model name: \(self.modelName)")
            })
    }
}
