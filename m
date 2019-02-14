Received: from eggs.gnu.org ([209.51.188.92]:46110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guEML-000297-HI
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:35:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guEFw-0003ya-Ow
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:28:38 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guEFs-0003lG-Vk
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:28:35 -0500
Received: by mail-wr1-x442.google.com with SMTP id l5so4766616wrw.6
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 02:28:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 10:28:10 +0000
Message-Id: <20190214102816.3393-2-peter.maydell@linaro.org>
In-Reply-To: <20190214102816.3393-1-peter.maydell@linaro.org>
References: <20190214102816.3393-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/7] ui/cocoa: Ensure we have the iothread
 lock when calling into QEMU
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

The Cocoa UI should run on the main thread; this is enforced
in OSX Mojave. In order to be able to run on the main thread,
we need to make sure we hold the iothread lock whenever we
call into various QEMU UI midlayer functions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 ui/cocoa.m | 83 ++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 59 insertions(+), 24 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index e2567d6946..2931c751fd 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -129,6 +129,21 @@
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
@@ -306,6 +321,7 @@ - (void) ungrabMouse;
 - (void) toggleFullScreen:(id)sender;
 - (void) handleMonitorInput:(NSEvent *)event;
 - (void) handleEvent:(NSEvent *)event;
+- (void) handleEventLocked:(NSEvent *)event;
 - (void) setAbsoluteEnabled:(BOOL)tIsAbsoluteEnabled;
 /* The state surrounding mouse grabbing is potentially confusing.
  * isAbsoluteEnabled tracks qemu_input_is_absolute() [ie "is the emulated
@@ -649,8 +665,14 @@ - (void) handleMonitorInput:(NSEvent *)event
 
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
@@ -945,15 +967,18 @@ - (QEMUScreen) gscreen {return screen;}
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
 
@@ -1215,13 +1240,17 @@ - (void)removePause
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
@@ -1237,9 +1266,11 @@ - (void)ejectDeviceMedia:(id)sender
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
 
@@ -1271,16 +1302,18 @@ - (void)changeDeviceMedia:(id)sender
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
@@ -1419,7 +1452,9 @@ - (void)adjustSpeed:(id)sender
     // get the throttle percentage
     throttle_pct = [sender tag];
 
-    cpu_throttle_set(throttle_pct);
+    with_iothread_lock(^{
+        cpu_throttle_set(throttle_pct);
+    });
     COCOA_DEBUG("cpu throttling at %d%c\n", cpu_throttle_get_percentage(), '%');
 }
 
-- 
2.17.2 (Apple Git-113)
