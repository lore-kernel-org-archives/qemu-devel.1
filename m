Received: from eggs.gnu.org ([2001:4830:134:3::10]:46333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cPQJh-0006RP-Ad
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cPQJf-0008O7-Ao
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cPQJf-0008NC-3S
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:03 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  6 Jan 2017 09:55:43 +0100
Message-Id: <1483692945-9866-16-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
References: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 15/17] wctablet: switch to new input interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: avg.tolik@gmail.com, Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/wctablet.c | 65 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 53 insertions(+), 12 deletions(-)

diff --git a/backends/wctablet.c b/backends/wctablet.c
index 29b75b4..7263671 100644
--- a/backends/wctablet.c
+++ b/backends/wctablet.c
@@ -66,6 +66,7 @@ uint8_t WC_FULL_CONFIG_STRING[WC_FULL_CONFIG_STRING_LENGTH + 1] = {
 /* This structure is used to save private info for Wacom Tablet. */
 typedef struct {
     CharDriverState *chr;
+    QemuInputHandlerState *hs;
 
     /* Query string from serial */
     uint8_t query[100];
@@ -76,6 +77,9 @@ typedef struct {
     int outlen;
 
     int line_speed;
+    int axis[INPUT_AXIS__MAX];
+    bool btns[INPUT_BUTTON__MAX];
+
 } TabletState;
 
 static void wctablet_chr_accept_input(CharDriverState *chr);
@@ -105,19 +109,16 @@ static void wctablet_reset(TabletState *tablet)
     tablet->outlen = 0;
 }
 
-static void wctablet_event(void *opaque, int x,
-                           int y, int dz, int buttons_state)
+static void wctablet_queue_event(TabletState *tablet)
 {
-    CharDriverState *chr = (CharDriverState *) opaque;
-    TabletState *tablet = (TabletState *) chr->opaque;
     uint8_t codes[8] = { 0xe0, 0, 0, 0, 0, 0, 0 };
 
     if (tablet->line_speed != 9600) {
         return;
     }
 
-    int newX = x * 0.1537;
-    int nexY = y * 0.1152;
+    int newX = tablet->axis[INPUT_AXIS_X] * 0.1537;
+    int nexY = tablet->axis[INPUT_AXIS_Y] * 0.1152;
 
     codes[0] = codes[0] | WC_H2(newX);
     codes[1] = codes[1] | WC_M7(newX);
@@ -127,13 +128,51 @@ static void wctablet_event(void *opaque, int x,
     codes[4] = codes[4] | WC_M7(nexY);
     codes[5] = codes[5] | WC_L7(nexY);
 
-    if (buttons_state == 0x01) {
+    if (tablet->btns[INPUT_BUTTON_LEFT]) {
         codes[0] = 0xa0;
     }
 
     wctablet_queue_output(tablet, codes, 7);
 }
 
+static void wctablet_input_event(DeviceState *dev, QemuConsole *src,
+                                InputEvent *evt)
+{
+    TabletState *tablet = (TabletState *)dev;
+    InputMoveEvent *move;
+    InputBtnEvent *btn;
+
+    switch (evt->type) {
+    case INPUT_EVENT_KIND_ABS:
+        move = evt->u.abs.data;
+        tablet->axis[move->axis] = move->value;
+        break;
+
+    case INPUT_EVENT_KIND_BTN:
+        btn = evt->u.btn.data;
+        tablet->btns[btn->button] = btn->down;
+        break;
+
+    default:
+        /* keep gcc happy */
+        break;
+    }
+}
+
+static void wctablet_input_sync(DeviceState *dev)
+{
+    TabletState *tablet = (TabletState *)dev;
+
+    wctablet_queue_event(tablet);
+}
+
+static QemuInputHandler wctablet_handler = {
+    .name  = "QEMU Wacome Pen Tablet",
+    .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_ABS,
+    .event = wctablet_input_event,
+    .sync  = wctablet_input_sync,
+};
+
 static void wctablet_chr_accept_input(CharDriverState *chr)
 {
     TabletState *tablet = (TabletState *) chr->opaque;
@@ -253,8 +292,11 @@ static int wctablet_chr_ioctl(CharDriverState *s, int cmd, void *arg)
 
 static void wctablet_chr_free(struct CharDriverState *chr)
 {
-    g_free (chr->opaque);
-    g_free (chr);
+    TabletState *tablet = (TabletState *) chr->opaque;
+
+    qemu_input_handler_unregister(tablet->hs);
+    g_free(chr->opaque);
+    g_free(chr);
 }
 
 static CharDriverState *qemu_chr_open_wctablet(const char *id,
@@ -286,9 +328,8 @@ static CharDriverState *qemu_chr_open_wctablet(const char *id,
     chr->opaque = tablet;
     tablet->chr = chr;
 
-    qemu_add_mouse_event_handler(wctablet_event, chr, 1,
-                                 "QEMU Wacome Pen Tablet");
-
+    tablet->hs = qemu_input_handler_register((DeviceState *)tablet,
+                                             &wctablet_handler);
     return chr;
 }
 
-- 
1.8.3.1
