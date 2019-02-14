Received: from eggs.gnu.org ([209.51.188.92]:46222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guEMJ-0002Bg-Op
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:35:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guEGN-0004pn-Ff
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:29:05 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guEGN-0003ql-5l
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:29:03 -0500
Received: by mail-wm1-x341.google.com with SMTP id h22so3953734wmb.0
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 02:28:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 10:28:14 +0000
Message-Id: <20190214102816.3393-6-peter.maydell@linaro.org>
In-Reply-To: <20190214102816.3393-1-peter.maydell@linaro.org>
References: <20190214102816.3393-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 5/7] ui/cocoa: Don't call NSApp sendEvent
 directly from handleEvent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, John Arbuckle <programmingkidx@gmail.com>, Roman Bolshakov <r.bolshakov@yadro.com>, Berkus Decker <berkus@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Ben Hekster <ben.hekster@foghorn.io>, BALATON Zoltan <balaton@eik.bme.hu>

Currently the handleEvent method will directly call the NSApp
sendEvent method for any events that we want to let OSX deal
with. When we rearrange the event handling code, the way that
we say "let OSX have this event" is going to change. Prepare
for that by refactoring so that handleEvent returns a flag
indicating whether it consumed the event.

Suggested-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
New patch in v2
---
 ui/cocoa.m | 49 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 2d943b6e2a..5a84e1aea7 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -129,8 +129,9 @@
 NSTextField *pauseLabel;
 NSArray * supportedImageFileTypes;
 
-// Utility function to run specified code block with iothread lock held
+// Utility functions to run specified code block with iothread lock held
 typedef void (^CodeBlock)(void);
+typedef bool (^BoolCodeBlock)(void);
 
 static void with_iothread_lock(CodeBlock block)
 {
@@ -144,6 +145,21 @@ static void with_iothread_lock(CodeBlock block)
     }
 }
 
+static bool bool_with_iothread_lock(BoolCodeBlock block)
+{
+    bool locked = qemu_mutex_iothread_locked();
+    bool val;
+    
+    if (!locked) {
+        qemu_mutex_lock_iothread();
+    }
+    val = block();
+    if (!locked) {
+        qemu_mutex_unlock_iothread();
+    }
+    return val;
+}
+
 // Mac to QKeyCode conversion
 const int mac_to_qkeycode_map[] = {
     [kVK_ANSI_A] = Q_KEY_CODE_A,
@@ -320,8 +336,8 @@ - (void) grabMouse;
 - (void) ungrabMouse;
 - (void) toggleFullScreen:(id)sender;
 - (void) handleMonitorInput:(NSEvent *)event;
-- (void) handleEvent:(NSEvent *)event;
-- (void) handleEventLocked:(NSEvent *)event;
+- (bool) handleEvent:(NSEvent *)event;
+- (bool) handleEventLocked:(NSEvent *)event;
 - (void) setAbsoluteEnabled:(BOOL)tIsAbsoluteEnabled;
 /* The state surrounding mouse grabbing is potentially confusing.
  * isAbsoluteEnabled tracks qemu_input_is_absolute() [ie "is the emulated
@@ -664,15 +680,16 @@ - (void) handleMonitorInput:(NSEvent *)event
     }
 }
 
-- (void) handleEvent:(NSEvent *)event
+- (bool) handleEvent:(NSEvent *)event
 {
-    with_iothread_lock(^{
-        [self handleEventLocked:event];
+    return bool_with_iothread_lock(^{
+        return [self handleEventLocked:event];
     });
 }
 
-- (void) handleEventLocked:(NSEvent *)event
+- (bool) handleEventLocked:(NSEvent *)event
 {
+    /* Return true if we handled the event, false if it should be given to OSX */
     COCOA_DEBUG("QemuCocoaView: handleEvent\n");
     int buttons = 0;
     int keycode = 0;
@@ -743,8 +760,7 @@ - (void) handleEventLocked:(NSEvent *)event
                 if (keycode == Q_KEY_CODE_F) {
                     switched_to_fullscreen = true;
                 }
-                [NSApp sendEvent:event];
-                return;
+                return false;
             }
 
             // default
@@ -759,12 +775,12 @@ - (void) handleEventLocked:(NSEvent *)event
                         // enable graphic console
                         case '1' ... '9':
                             console_select(key - '0' - 1); /* ascii math */
-                            return;
+                            return true;
 
                         // release the mouse grab
                         case 'g':
                             [self ungrabMouse];
-                            return;
+                            return true;
                     }
                 }
             }
@@ -781,7 +797,7 @@ - (void) handleEventLocked:(NSEvent *)event
             // don't pass the guest a spurious key-up if we treated this
             // command-key combo as a host UI action
             if (!isMouseGrabbed && ([event modifierFlags] & NSEventModifierFlagCommand)) {
-                return;
+                return true;
             }
 
             if (qemu_console_is_graphic(NULL)) {
@@ -875,7 +891,7 @@ - (void) handleEventLocked:(NSEvent *)event
             mouse_event = false;
             break;
         default:
-            [NSApp sendEvent:event];
+            return false;
     }
 
     if (mouse_event) {
@@ -911,10 +927,11 @@ - (void) handleEventLocked:(NSEvent *)event
                 qemu_input_queue_rel(dcl->con, INPUT_AXIS_Y, (int)[event deltaY]);
             }
         } else {
-            [NSApp sendEvent:event];
+            return false;
         }
         qemu_input_event_sync();
     }
+    return true;
 }
 
 - (void) grabMouse
@@ -1749,7 +1766,9 @@ static void cocoa_refresh(DisplayChangeListener *dcl)
         event = [NSApp nextEventMatchingMask:NSEventMaskAny untilDate:distantPast
                         inMode: NSDefaultRunLoopMode dequeue:YES];
         if (event != nil) {
-            [cocoaView handleEvent:event];
+            if (![cocoaView handleEvent:event]) {
+                [NSApp sendEvent:event];
+            }
         }
     } while(event != nil);
     [pool release];
-- 
2.17.2 (Apple Git-113)
