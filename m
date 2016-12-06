Received: from eggs.gnu.org ([2001:4830:134:3::10]:60740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fabian@lesniak-it.de>) id 1cEKyU-0005oc-Sh
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:00:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fabian@lesniak-it.de>) id 1cEKyQ-0007lB-6G
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:00:22 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:57319)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fabian@lesniak-it.de>)
	id 1cEKyP-0007k7-S6
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:00:18 -0500
From: Fabian Lesniak <fabian@lesniak-it.de>
Date: Tue,  6 Dec 2016 20:00:06 +0100
Message-Id: <20161206190007.7539-3-fabian@lesniak-it.de>
In-Reply-To: <20161206190007.7539-1-fabian@lesniak-it.de>
References: <20161206190007.7539-1-fabian@lesniak-it.de>
Subject: [Qemu-devel] [PATCH v3 2/3] ps2: add support for mice with
 extra/side buttons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fabian Lesniak <fabian@lesniak-it.de>

This enables the ps2 controller to process mouse events for buttons 4 and 5.
Additionally, distinct definitions for the ps2 mouse button state are
introduced. The legacy definitions from console.h are not used anymore.

Signed-off-by: Fabian Lesniak <fabian@lesniak-it.de>
---
 hw/input/ps2.c         | 8 +++++---
 include/hw/input/ps2.h | 6 ++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 0d14de0..598cc86 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -871,9 +871,11 @@ static void ps2_mouse_event(DeviceState *dev, QemuConsole *src,
                             InputEvent *evt)
 {
     static const int bmap[INPUT_BUTTON__MAX] = {
-        [INPUT_BUTTON_LEFT]   = MOUSE_EVENT_LBUTTON,
-        [INPUT_BUTTON_MIDDLE] = MOUSE_EVENT_MBUTTON,
-        [INPUT_BUTTON_RIGHT]  = MOUSE_EVENT_RBUTTON,
+        [INPUT_BUTTON_LEFT]   = PS2_MOUSE_BUTTON_LEFT,
+        [INPUT_BUTTON_MIDDLE] = PS2_MOUSE_BUTTON_MIDDLE,
+        [INPUT_BUTTON_RIGHT]  = PS2_MOUSE_BUTTON_RIGHT,
+        [INPUT_BUTTON_SIDE]   = PS2_MOUSE_BUTTON_SIDE,
+        [INPUT_BUTTON_EXTRA]  = PS2_MOUSE_BUTTON_EXTRA,
     };
     PS2MouseState *s = (PS2MouseState *)dev;
     InputMoveEvent *move;
diff --git a/include/hw/input/ps2.h b/include/hw/input/ps2.h
index b9ceee4..0fec91c 100644
--- a/include/hw/input/ps2.h
+++ b/include/hw/input/ps2.h
@@ -25,6 +25,12 @@
 #ifndef HW_PS2_H
 #define HW_PS2_H
 
+#define PS2_MOUSE_BUTTON_LEFT   0x01
+#define PS2_MOUSE_BUTTON_MIDDLE 0x02
+#define PS2_MOUSE_BUTTON_RIGHT  0x04
+#define PS2_MOUSE_BUTTON_SIDE   0x08
+#define PS2_MOUSE_BUTTON_EXTRA  0x10
+
 /* ps2.c */
 void *ps2_kbd_init(void (*update_irq)(void *, int), void *update_arg);
 void *ps2_mouse_init(void (*update_irq)(void *, int), void *update_arg);
-- 
2.10.2
