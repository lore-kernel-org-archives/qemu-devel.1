Received: from eggs.gnu.org ([2001:4830:134:3::10]:41046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ianloic@google.com>) id 1dCrfR-0005E0-42
	for qemu-devel@nongnu.org; Mon, 22 May 2017 14:02:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ianloic@google.com>) id 1dCrfN-0006tk-49
	for qemu-devel@nongnu.org; Mon, 22 May 2017 14:02:53 -0400
Received: from mail-pf0-x233.google.com ([2607:f8b0:400e:c00::233]:32776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ianloic@google.com>) id 1dCrfM-0006tg-T5
	for qemu-devel@nongnu.org; Mon, 22 May 2017 14:02:49 -0400
Received: by mail-pf0-x233.google.com with SMTP id e193so89455777pfh.0
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 11:02:48 -0700 (PDT)
From: Ian McKellar <ianloic@google.com>
Date: Mon, 22 May 2017 11:02:17 -0700
Message-Id: <20170522180217.18234-1-ianloic@google.com>
Subject: [Qemu-devel] [PATCH 1/1] Improve Cocoa modifier key handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ian McKellar <ianloic@google.com>

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
---
 ui/cocoa.m | 48 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 207555edf7..e645befa13 100644
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
@@ -536,6 +538,16 @@ QemuCocoaView *cocoaView;
     }
 }
 
+- (void) toggleModifier: (int)keycode {
+    if (modifiers_state[keycode] == 0) { // keydown
+        qemu_input_event_send_key_qcode(dcl->con, keycode, true);
+        modifiers_state[keycode] = 1;
+    } else { // keyup
+        qemu_input_event_send_key_qcode(dcl->con, keycode, false);
+        modifiers_state[keycode] = 0;
+    }
+}
+
 - (void) handleEvent:(NSEvent *)event
 {
     COCOA_DEBUG("QemuCocoaView: handleEvent\n");
@@ -547,7 +559,33 @@ QemuCocoaView *cocoaView;
 
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
+                        [self toggleModifier:Q_KEY_CODE_CAPS_LOCK];
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
@@ -562,13 +600,7 @@ QemuCocoaView *cocoaView;
                     qemu_input_event_send_key_qcode(dcl->con, keycode, true);
                     qemu_input_event_send_key_qcode(dcl->con, keycode, false);
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
2.11.0.390.gc69c2f50cf-goog
