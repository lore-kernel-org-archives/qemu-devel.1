Received: from eggs.gnu.org ([2001:4830:134:3::10]:46577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dL3Am-0005SY-7M
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:57:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dL3Aj-0002JI-RV
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:57:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dL3Aj-0002Ic-Jo
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:57:01 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 14 Jun 2017 09:56:49 +0200
Message-Id: <20170614075653.26420-2-kraxel@redhat.com>
In-Reply-To: <20170614075653.26420-1-kraxel@redhat.com>
References: <20170614075653.26420-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/5] Improve Cocoa modifier key handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ian McKellar <ianloic@google.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Ian McKellar via Qemu-devel <qemu-devel@nongnu.org>

I had two problems with QEMU on macOS:
 1) Sometimes when alt-tabbing to QEMU it would act as if the 'a' key
    was pressed so I'd get 'aaaaaaaaa....'.
 2) Using Sikuli to programatically send keys to the QEMU window text
    like "foo_bar" would come out as "fooa-bar".

They looked similar and after much digging the problem turned out to be
the same. When QEMU's ui/cocoa.m received an NSFlagsChanged NSEvent it
looked at the keyCode to determine what modifier key changed. This
usually works fine but sometimes the keyCode is 0 and the app should
instead be looking at the modifierFlags bitmask. Key code 0 is the 'a'
key.

I added code that handles keyCode == 0 differently. It checks the
modifierFlags and if they differ from QEMU's idea of which modifier
keys are currently pressed it toggles those changed keys.

This fixes my problems and seems work fine.

Signed-off-by: Ian McKellar <ianloic@google.com>
Message-id: 20170526233816.47627-1-ianloic@google.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/cocoa.m | 60 ++++++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 12 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 004ec2711c..1f010d3ae7 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -52,6 +52,8 @@
 /* macOS 10.12 deprecated many constants, #define the new names for older SDKs */
 #if MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_12
 #define NSEventMaskAny                  NSAnyEventMask
+#define NSEventModifierFlagCapsLock     NSAlphaShiftKeyMask
+#define NSEventModifierFlagShift        NSShiftKeyMask
 #define NSEventModifierFlagCommand      NSCommandKeyMask
 #define NSEventModifierFlagControl      NSControlKeyMask
 #define NSEventModifierFlagOption       NSAlternateKeyMask
@@ -268,7 +270,7 @@ static void handleAnyDeviceErrors(Error * err)
     NSWindow *fullScreenWindow;
     float cx,cy,cw,ch,cdx,cdy;
     CGDataProviderRef dataProviderRef;
-    int modifiers_state[256];
+    BOOL modifiers_state[256];
     BOOL isMouseGrabbed;
     BOOL isFullscreen;
     BOOL isAbsoluteEnabled;
@@ -536,18 +538,59 @@ QemuCocoaView *cocoaView;
     }
 }
 
+- (void) toggleModifier: (int)keycode {
+    // Toggle the stored state.
+    modifiers_state[keycode] = !modifiers_state[keycode];
+    // Send a keyup or keydown depending on the state.
+    qemu_input_event_send_key_qcode(dcl->con, keycode, modifiers_state[keycode]);
+}
+
+- (void) toggleStatefulModifier: (int)keycode {
+    // Toggle the stored state.
+    modifiers_state[keycode] = !modifiers_state[keycode];
+    // Generate keydown and keyup.
+    qemu_input_event_send_key_qcode(dcl->con, keycode, true);
+    qemu_input_event_send_key_qcode(dcl->con, keycode, false);
+}
+
 - (void) handleEvent:(NSEvent *)event
 {
     COCOA_DEBUG("QemuCocoaView: handleEvent\n");
 
     int buttons = 0;
-    int keycode;
+    int keycode = 0;
     bool mouse_event = false;
     NSPoint p = [event locationInWindow];
 
     switch ([event type]) {
         case NSEventTypeFlagsChanged:
-            keycode = cocoa_keycode_to_qemu([event keyCode]);
+            if ([event keyCode] == 0) {
+                // When the Cocoa keyCode is zero that means keys should be
+                // synthesized based on the values in in the eventModifiers
+                // bitmask.
+
+                if (qemu_console_is_graphic(NULL)) {
+                    NSEventModifierFlags modifiers = [event modifierFlags];
+
+                    if (!!(modifiers & NSEventModifierFlagCapsLock) != !!modifiers_state[Q_KEY_CODE_CAPS_LOCK]) {
+                        [self toggleStatefulModifier:Q_KEY_CODE_CAPS_LOCK];
+                    }
+                    if (!!(modifiers & NSEventModifierFlagShift) != !!modifiers_state[Q_KEY_CODE_SHIFT]) {
+                        [self toggleModifier:Q_KEY_CODE_SHIFT];
+                    }
+                    if (!!(modifiers & NSEventModifierFlagControl) != !!modifiers_state[Q_KEY_CODE_CTRL]) {
+                        [self toggleModifier:Q_KEY_CODE_CTRL];
+                    }
+                    if (!!(modifiers & NSEventModifierFlagOption) != !!modifiers_state[Q_KEY_CODE_ALT]) {
+                        [self toggleModifier:Q_KEY_CODE_ALT];
+                    }
+                    if (!!(modifiers & NSEventModifierFlagCommand) != !!modifiers_state[Q_KEY_CODE_META_L]) {
+                        [self toggleModifier:Q_KEY_CODE_META_L];
+                    }
+                }
+            } else {
+                keycode = cocoa_keycode_to_qemu([event keyCode]);
+            }
 
             if ((keycode == Q_KEY_CODE_META_L || keycode == Q_KEY_CODE_META_R)
                && !isMouseGrabbed) {
@@ -559,16 +602,9 @@ QemuCocoaView *cocoaView;
                 // emulate caps lock and num lock keydown and keyup
                 if (keycode == Q_KEY_CODE_CAPS_LOCK ||
                     keycode == Q_KEY_CODE_NUM_LOCK) {
-                    qemu_input_event_send_key_qcode(dcl->con, keycode, true);
-                    qemu_input_event_send_key_qcode(dcl->con, keycode, false);
+                    [self toggleStatefulModifier:keycode];
                 } else if (qemu_console_is_graphic(NULL)) {
-                    if (modifiers_state[keycode] == 0) { // keydown
-                        qemu_input_event_send_key_qcode(dcl->con, keycode, true);
-                        modifiers_state[keycode] = 1;
-                    } else { // keyup
-                        qemu_input_event_send_key_qcode(dcl->con, keycode, false);
-                        modifiers_state[keycode] = 0;
-                    }
+                  [self toggleModifier:keycode];
                 }
             }
 
-- 
2.9.3
