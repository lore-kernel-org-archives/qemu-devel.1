Received: from eggs.gnu.org ([2001:4830:134:3::10]:50869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gT4QH-0005ah-GY
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 07:31:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gT4QG-0008QZ-H8
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 07:31:01 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gT4QG-0008Pd-9J
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 07:31:00 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat,  1 Dec 2018 12:30:52 +0000
Message-Id: <20181201123056.432-2-peter.maydell@linaro.org>
In-Reply-To: <20181201123056.432-1-peter.maydell@linaro.org>
References: <20181201123056.432-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC 1/5] ui/cocoa: Ensure we have the iothread lock
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
Cc: patches@linaro.org, John Arbuckle <programmingkidx@gmail.com>, Berkus Decker <berkus@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Roman Bolshakov <r.bolshakov@yadro.com>

The Cocoa UI should run on the main thread; this is enforced
in OSX Mojave. In order to be able to run on the main thread,
we need to make sure we hold the iothread lock whenever we
call into various QEMU UI midlayer functions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 ui/cocoa.m | 83 ++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 59 insertions(+), 24 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index ecf12bfc2e4..9148ecdeb4c 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -117,6 +117,21 @@ bool stretch_video;
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
@@ -294,6 +309,7 @@ static void handleAnyDeviceErrors(Error * err)
 - (void) toggleFullScreen:(id)sender;
 - (void) handleMonitorInput:(NSEvent *)event;
 - (void) handleEvent:(NSEvent *)event;
+- (void) handleEventLocked:(NSEvent *)event;
 - (void) setAbsoluteEnabled:(BOOL)tIsAbsoluteEnabled;
 /* The state surrounding mouse grabbing is potentially confusing.
  * isAbsoluteEnabled tracks qemu_input_is_absolute() [ie "is the emulated
@@ -632,8 +648,14 @@ QemuCocoaView *cocoaView;
 
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
@@ -928,15 +950,18 @@ QemuCocoaView *cocoaView;
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
 
@@ -1198,13 +1223,17 @@ QemuCocoaView *cocoaView;
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
@@ -1220,9 +1249,11 @@ QemuCocoaView *cocoaView;
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
 
@@ -1254,16 +1285,18 @@ QemuCocoaView *cocoaView;
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
@@ -1402,7 +1435,9 @@ QemuCocoaView *cocoaView;
     // get the throttle percentage
     throttle_pct = [sender tag];
 
-    cpu_throttle_set(throttle_pct);
+    with_iothread_lock(^{
+        cpu_throttle_set(throttle_pct);
+    });
     COCOA_DEBUG("cpu throttling at %d%c\n", cpu_throttle_get_percentage(), '%');
 }
 
-- 
2.19.2
