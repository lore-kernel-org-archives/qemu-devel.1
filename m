Received: from eggs.gnu.org ([2001:4830:134:3::10]:36332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYYhB-00039P-Bb
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:42:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYYh6-0005yr-GQ
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:42:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cYYh6-0005yU-AS
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:42:00 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 31 Jan 2017 14:41:38 +0100
Message-Id: <1485870106-25016-3-git-send-email-kraxel@redhat.com>
In-Reply-To: <1485870106-25016-1-git-send-email-kraxel@redhat.com>
References: <1485870106-25016-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 02/10] ps2: add support for mice with extra/side
 buttons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fabian Lesniak <fabian@lesniak-it.de>, Gerd Hoffmann <kraxel@redhat.com>

From: Fabian Lesniak <fabian@lesniak-it.de>

This enables the ps2 controller to process mouse events for buttons 4 and 5.
Additionally, distinct definitions for the ps2 mouse button state are
introduced. The legacy definitions from console.h are not used anymore.

Signed-off-by: Fabian Lesniak <fabian@lesniak-it.de>
Message-id: 20161206190007.7539-3-fabian@lesniak-it.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/input/ps2.c         | 8 +++++---
 include/hw/input/ps2.h | 6 ++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 8485a4e..1d3a440 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -881,9 +881,11 @@ static void ps2_mouse_event(DeviceState *dev, QemuConsole *src,
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
1.8.3.1
