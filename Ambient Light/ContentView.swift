//
//  ContentView.swift
//  Ambient Light
//
//  Created by Steve Ledsworth on 8/16/21.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView : View {
    @State var text: String = "test"
    
    var body: some View {
        print(text)
        return ZStack {
            ARViewContainer(text: $text).edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
                Text(text)
                    .monospacedDigit()
                    .bold()
                    .padding()
                    .frame(width: 200)
                    .background(.bar)
                    .cornerRadius(16)
                Spacer()
            }
        }
    }
}

class Coordinator: NSObject, ARSessionDelegate {

    @Binding var text: String

    init(text: Binding<String>) {
        _text = text
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        let ambientLight = session.currentFrame?.lightEstimate?.ambientIntensity
        if let light = ambientLight?.exponent {
//            print(light.description)
            text = light.description
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    @Binding var text: String

    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        arView.session.configuration?.isLightEstimationEnabled = true
        
        // Load the "Box" scene from the "Experience" Reality File
//        let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
//        arView.scene.anchors.append(boxAnchor)
        
        arView.session.delegate = context.coordinator
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
//        uiView.text = text
    }
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
