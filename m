Received: from eggs.gnu.org ([209.51.188.92]:52459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0qmy-0004MZ-6A
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:50:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0qmx-0005gV-3h
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:50:04 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:32899)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h0qmw-0005fk-SW
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:50:03 -0500
Received: by mail-wr1-x435.google.com with SMTP id i12so6325037wrw.0
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 08:50:02 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	x74sm7238018wmf.22.2019.03.04.08.50.00 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 04 Mar 2019 08:50:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Mar 2019 16:49:52 +0000
Message-Id: <20190304164958.9362-2-peter.maydell@linaro.org>
In-Reply-To: <20190304164958.9362-1-peter.maydell@linaro.org>
References: <20190304164958.9362-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/7] ui/cocoa: Ensure we have the iothread lock
 when calling into QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The Cocoa UI should run on the main thread; this is enforced
in OSX Mojave. In order to be able to run on the main thread,
we need to make sure we hold the iothread lock whenever we
call into various QEMU UI midlayer functions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Tested-by: Roman Bolshakov <r.bolshakov@yadro.com>
Message-id: 20190225102433.22401-2-peter.maydell@linaro.org
Message-id: 20190214102816.3393-2-peter.maydell@linaro.org
---
 ui/cocoa.m | 91 ++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 65 insertions(+), 26 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index e2567d69466..f1171c48654 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -129,6 +129,21 @@ bool stretch_video;
 NSTextField *pauseLabel;
 NSArray * supportedImageFileTypes;
 
+// Utility function to run specified code block with iothread lock held
+typedef void (^CodeBlock)(void);
+
+static void with_iothread_lock(CodeBlock block)
+{
+    bool locked = qemu_mutex_iothread_locked();
+    if (!locked) {
+        qemu_mutex_lock_iothread();
+    }
+    block();
+    if (!locked) {
+        qemu_mutex_unlock_iothread();
+    }
+}
+
 // Mac to QKeyCode conversion
 const int mac_to_qkeycode_map[] = {
     [kVK_ANSI_A] = Q_KEY_CODE_A,
@@ -306,6 +321,7 @@ static void handleAnyDeviceErrors(Error * err)
 - (void) toggleFullScreen:(id)sender;
 - (void) handleMonitorInput:(NSEvent *)event;
 - (void) handleEvent:(NSEvent *)event;
+- (void) handleEventLocked:(NSEvent *)event;
 - (void) setAbsoluteEnabled:(BOOL)tIsAbsoluteEnabled;
 /* The state surrounding mouse grabbing is potentially confusing.
  * isAbsoluteEnabled tracks qemu_input_is_absolute() [ie "is the emulated
@@ -649,8 +665,14 @@ QemuCocoaView *cocoaView;
 
 - (void) handleEvent:(NSEvent *)event
 {
-    COCOA_DEBUG("QemuCocoaView: handleEvent\n");
+    with_iothread_lock(^{
+        [self handleEventLocked:event];
+    });
+}
 
+- (void) handleEventLocked:(NSEvent *)event
+{
+    COCOA_DEBUG("QemuCocoaView: handleEvent\n");
     int buttons = 0;
     int keycode = 0;
     bool mouse_event = false;
@@ -945,15 +967,18 @@ QemuCocoaView *cocoaView;
  */
 - (void) raiseAllKeys
 {
-    int index;
     const int max_index = ARRAY_SIZE(modifiers_state);
 
-   for (index = 0; index < max_index; index++) {
-       if (modifiers_state[index]) {
-           modifiers_state[index] = 0;
-           qemu_input_event_send_key_qcode(dcl->con, index, false);
-       }
-   }
+    with_iothread_lock(^{
+        int index;
+
+        for (index = 0; index < max_index; index++) {
+            if (modifiers_state[index]) {
+                modifiers_state[index] = 0;
+                qemu_input_event_send_key_qcode(dcl->con, index, false);
+            }
+        }
+    });
 }
 @end
 
@@ -1178,7 +1203,9 @@ QemuCocoaView *cocoaView;
 /* Pause the guest */
 - (void)pauseQEMU:(id)sender
 {
-    qmp_stop(NULL);
+    with_iothread_lock(^{
+        qmp_stop(NULL);
+    });
     [sender setEnabled: NO];
     [[[sender menu] itemWithTitle: @"Resume"] setEnabled: YES];
     [self displayPause];
@@ -1187,7 +1214,9 @@ QemuCocoaView *cocoaView;
 /* Resume running the guest operating system */
 - (void)resumeQEMU:(id) sender
 {
-    qmp_cont(NULL);
+    with_iothread_lock(^{
+        qmp_cont(NULL);
+    });
     [sender setEnabled: NO];
     [[[sender menu] itemWithTitle: @"Pause"] setEnabled: YES];
     [self removePause];
@@ -1215,13 +1244,17 @@ QemuCocoaView *cocoaView;
 /* Restarts QEMU */
 - (void)restartQEMU:(id)sender
 {
-    qmp_system_reset(NULL);
+    with_iothread_lock(^{
+        qmp_system_reset(NULL);
+    });
 }
 
 /* Powers down QEMU */
 - (void)powerDownQEMU:(id)sender
 {
-    qmp_system_powerdown(NULL);
+    with_iothread_lock(^{
+        qmp_system_powerdown(NULL);
+    });
 }
 
 /* Ejects the media.
@@ -1237,9 +1270,11 @@ QemuCocoaView *cocoaView;
         return;
     }
 
-    Error *err = NULL;
-    qmp_eject(true, [drive cStringUsingEncoding: NSASCIIStringEncoding],
-              false, NULL, false, false, &err);
+    __block Error *err = NULL;
+    with_iothread_lock(^{
+        qmp_eject(true, [drive cStringUsingEncoding: NSASCIIStringEncoding],
+                  false, NULL, false, false, &err);
+    });
     handleAnyDeviceErrors(err);
 }
 
@@ -1271,16 +1306,18 @@ QemuCocoaView *cocoaView;
             return;
         }
 
-        Error *err = NULL;
-        qmp_blockdev_change_medium(true,
-                                   [drive cStringUsingEncoding:
-                                          NSASCIIStringEncoding],
-                                   false, NULL,
-                                   [file cStringUsingEncoding:
-                                         NSASCIIStringEncoding],
-                                   true, "raw",
-                                   false, 0,
-                                   &err);
+        __block Error *err = NULL;
+        with_iothread_lock(^{
+            qmp_blockdev_change_medium(true,
+                                       [drive cStringUsingEncoding:
+                                                  NSASCIIStringEncoding],
+                                       false, NULL,
+                                       [file cStringUsingEncoding:
+                                                 NSASCIIStringEncoding],
+                                       true, "raw",
+                                       false, 0,
+                                       &err);
+        });
         handleAnyDeviceErrors(err);
     }
 }
@@ -1419,7 +1456,9 @@ QemuCocoaView *cocoaView;
     // get the throttle percentage
     throttle_pct = [sender tag];
 
-    cpu_throttle_set(throttle_pct);
+    with_iothread_lock(^{
+        cpu_throttle_set(throttle_pct);
+    });
     COCOA_DEBUG("cpu throttling at %d%c\n", cpu_throttle_get_percentage(), '%');
 }
 
-- 
2.20.1
