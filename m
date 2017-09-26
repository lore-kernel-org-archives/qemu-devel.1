Received: from eggs.gnu.org ([2001:4830:134:3::10]:42591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=435739c2e=owen.smith@citrix.com>)
	id 1dwrBF-0005sP-Dd
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:49:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=435739c2e=owen.smith@citrix.com>)
	id 1dwrBD-00041g-CZ
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:49:49 -0400
Received: from smtp.citrix.com ([66.165.176.89]:54430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=435739c2e=owen.smith@citrix.com>)
	id 1dwrBD-00040M-4J
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:49:47 -0400
From: Owen Smith <owen.smith@citrix.com>
Date: Tue, 26 Sep 2017 14:43:38 +0000
Message-ID: <1506437019-17946-3-git-send-email-owen.smith@citrix.com>
In-Reply-To: <1506437019-17946-1-git-send-email-owen.smith@citrix.com>
References: <1506437019-17946-1-git-send-email-owen.smith@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/3 v4] xenfb: Use Input Handlers directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sstabellini@kernel.org, anthony.perard@citrix.com, kraxel@redhat.com
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Owen Smith <owen.smith@citrix.com>

Avoid the unneccessary calls through the input-legacy.c file by
using the qemu_input_handler_*() calls directly. This did require
reworking the event and sync handlers to use the reverse mapping
from qcode to linux using qemu_input_qcode_to_linux().
Removes the scancode2linux mapping, and supporting documention.

Signed-off-by: Owen Smith <owen.smith@citrix.com>
---
 hw/display/xenfb.c | 289 ++++++++++++++++++++++++-----------------------------
 1 file changed, 133 insertions(+), 156 deletions(-)

diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index df8b78f..33361b4 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -27,6 +27,7 @@
 #include "qemu/osdep.h"
 
 #include "hw/hw.h"
+#include "ui/input.h"
 #include "ui/console.h"
 #include "hw/xen/xen_backend.h"
 
@@ -51,9 +52,10 @@ struct common {
 struct XenInput {
     struct common c;
     int abs_pointer_wanted; /* Whether guest supports absolute pointer */
-    int button_state;       /* Last seen pointer button state */
-    int extended;
-    QEMUPutMouseEntry *qmouse;
+    QemuInputHandlerState *qkbd;
+    QemuInputHandlerState *qmou;
+    int mouse_axes[INPUT_AXIS__MAX];
+    int mouse_wheel;
 };
 
 #define UP_QUEUE 8
@@ -119,79 +121,6 @@ static void common_unbind(struct common *c)
 }
 
 /* -------------------------------------------------------------------- */
-
-#if 0
-/*
- * These two tables are not needed any more, but left in here
- * intentionally as documentation, to show how scancode2linux[]
- * was generated.
- *
- * Tables to map from scancode to Linux input layer keycode.
- * Scancodes are hardware-specific.  These maps assumes a
- * standard AT or PS/2 keyboard which is what QEMU feeds us.
- */
-const unsigned char atkbd_set2_keycode[512] = {
-
-     0, 67, 65, 63, 61, 59, 60, 88,  0, 68, 66, 64, 62, 15, 41,117,
-     0, 56, 42, 93, 29, 16,  2,  0,  0,  0, 44, 31, 30, 17,  3,  0,
-     0, 46, 45, 32, 18,  5,  4, 95,  0, 57, 47, 33, 20, 19,  6,183,
-     0, 49, 48, 35, 34, 21,  7,184,  0,  0, 50, 36, 22,  8,  9,185,
-     0, 51, 37, 23, 24, 11, 10,  0,  0, 52, 53, 38, 39, 25, 12,  0,
-     0, 89, 40,  0, 26, 13,  0,  0, 58, 54, 28, 27,  0, 43,  0, 85,
-     0, 86, 91, 90, 92,  0, 14, 94,  0, 79,124, 75, 71,121,  0,  0,
-    82, 83, 80, 76, 77, 72,  1, 69, 87, 78, 81, 74, 55, 73, 70, 99,
-
-      0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
-    217,100,255,  0, 97,165,  0,  0,156,  0,  0,  0,  0,  0,  0,125,
-    173,114,  0,113,  0,  0,  0,126,128,  0,  0,140,  0,  0,  0,127,
-    159,  0,115,  0,164,  0,  0,116,158,  0,150,166,  0,  0,  0,142,
-    157,  0,  0,  0,  0,  0,  0,  0,155,  0, 98,  0,  0,163,  0,  0,
-    226,  0,  0,  0,  0,  0,  0,  0,  0,255, 96,  0,  0,  0,143,  0,
-      0,  0,  0,  0,  0,  0,  0,  0,  0,107,  0,105,102,  0,  0,112,
-    110,111,108,112,106,103,  0,119,  0,118,109,  0, 99,104,119,  0,
-
-};
-
-const unsigned char atkbd_unxlate_table[128] = {
-
-      0,118, 22, 30, 38, 37, 46, 54, 61, 62, 70, 69, 78, 85,102, 13,
-     21, 29, 36, 45, 44, 53, 60, 67, 68, 77, 84, 91, 90, 20, 28, 27,
-     35, 43, 52, 51, 59, 66, 75, 76, 82, 14, 18, 93, 26, 34, 33, 42,
-     50, 49, 58, 65, 73, 74, 89,124, 17, 41, 88,  5,  6,  4, 12,  3,
-     11,  2, 10,  1,  9,119,126,108,117,125,123,107,115,116,121,105,
-    114,122,112,113,127, 96, 97,120,  7, 15, 23, 31, 39, 47, 55, 63,
-     71, 79, 86, 94,  8, 16, 24, 32, 40, 48, 56, 64, 72, 80, 87,111,
-     19, 25, 57, 81, 83, 92, 95, 98, 99,100,101,103,104,106,109,110
-
-};
-#endif
-
-/*
- * for (i = 0; i < 128; i++) {
- *     scancode2linux[i] = atkbd_set2_keycode[atkbd_unxlate_table[i]];
- *     scancode2linux[i | 0x80] = atkbd_set2_keycode[atkbd_unxlate_table[i] | 0x80];
- * }
- */
-static const unsigned char scancode2linux[512] = {
-      0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
-     16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
-     32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
-     48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63,
-     64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79,
-     80, 81, 82, 83, 99,  0, 86, 87, 88,117,  0,  0, 95,183,184,185,
-      0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
-     93,  0,  0, 89,  0,  0, 85, 91, 90, 92,  0, 94,  0,124,121,  0,
-
-      0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
-    165,  0,  0,  0,  0,  0,  0,  0,  0,163,  0,  0, 96, 97,  0,  0,
-    113,140,164,  0,166,  0,  0,  0,  0,  0,255,  0,  0,  0,114,  0,
-    115,  0,150,  0,  0, 98,255, 99,100,  0,  0,  0,  0,  0,  0,  0,
-      0,  0,  0,  0,  0,119,119,102,103,104,  0,105,112,106,118,107,
-    108,109,110,111,  0,  0,  0,  0,  0,  0,  0,125,126,127,116,142,
-      0,  0,  0,143,  0,217,156,173,128,159,158,157,155,226,  0,112,
-      0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
-};
-
 /* Send an event to the keyboard frontend driver */
 static int xenfb_kbd_event(struct XenInput *xenfb,
 			   union xenkbd_in_event *event)
@@ -260,87 +189,126 @@ static int xenfb_send_position(struct XenInput *xenfb,
     return xenfb_kbd_event(xenfb, &event);
 }
 
-/*
- * Send a key event from the client to the guest OS
- * QEMU gives us a raw scancode from an AT / PS/2 style keyboard.
- * We have to turn this into a Linux Input layer keycode.
- *
- * Extra complexity from the fact that with extended scancodes
- * (like those produced by arrow keys) this method gets called
- * twice, but we only want to send a single event. So we have to
- * track the '0xe0' scancode state & collapse the extended keys
- * as needed.
- *
- * Wish we could just send scancodes straight to the guest which
- * already has code for dealing with this...
- */
-static void xenfb_key_event(void *opaque, int scancode)
+static void xenfb_key_event(DeviceState *dev, QemuConsole *src,
+                            InputEvent *evt)
 {
-    struct XenInput *xenfb = opaque;
-    int down = 1;
-
-    if (scancode == 0xe0) {
-	xenfb->extended = 1;
-	return;
-    } else if (scancode & 0x80) {
-	scancode &= 0x7f;
-	down = 0;
+    struct XenInput *in = (struct XenInput *)dev;
+    InputKeyEvent *key = evt->u.key.data;
+    int qcode = qemu_input_key_value_to_qcode(key->key);
+
+    if (qcode) {
+        unsigned int lnx = qemu_input_qcode_to_linux(qcode);
+        if (lnx) {
+            xenfb_send_key(in, key->down, lnx);
+        }
     }
-    if (xenfb->extended) {
-	scancode |= 0x80;
-	xenfb->extended = 0;
+}
+
+static void xenfb_mouse_event(DeviceState *dev, QemuConsole *src,
+                              InputEvent *evt)
+{
+    struct XenInput *in = (struct XenInput *)dev;
+    InputBtnEvent *btn;
+    InputMoveEvent *move;
+
+    switch (evt->type) {
+    case INPUT_EVENT_KIND_BTN:
+        btn = evt->u.btn.data;
+        switch (btn->button) {
+        case INPUT_BUTTON_LEFT:
+            xenfb_send_key(in, btn->down, BTN_LEFT);
+            break;
+        case INPUT_BUTTON_RIGHT:
+            xenfb_send_key(in, btn->down, BTN_LEFT + 1);
+            break;
+        case INPUT_BUTTON_MIDDLE:
+            xenfb_send_key(in, btn->down, BTN_LEFT + 2);
+            break;
+        case INPUT_BUTTON_WHEEL_UP:
+            if (btn->down) {
+                in->mouse_wheel--;
+            }
+            break;
+        case INPUT_BUTTON_WHEEL_DOWN:
+            if (btn->down) {
+                in->mouse_wheel++;
+            }
+            break;
+        default:
+            break;
+        }
+        break;
+    case INPUT_EVENT_KIND_ABS:
+        move = evt->u.abs.data;
+        in->mouse_axes[move->axis] = move->value;
+        break;
+    case INPUT_EVENT_KIND_REL:
+        move = evt->u.rel.data;
+        in->mouse_axes[move->axis] += move->value;
+        break;
+    default:
+        break;
     }
-    xenfb_send_key(xenfb, down, scancode2linux[scancode]);
 }
 
-/*
- * Send a mouse event from the client to the guest OS
- *
- * The QEMU mouse can be in either relative, or absolute mode.
- * Movement is sent separately from button state, which has to
- * be encoded as virtual key events. We also don't actually get
- * given any button up/down events, so have to track changes in
- * the button state.
- */
-static void xenfb_mouse_event(void *opaque,
-			      int dx, int dy, int dz, int button_state)
+static void xenfb_mouse_sync(DeviceState *dev)
 {
-    struct XenInput *xenfb = opaque;
-    QemuConsole *con = qemu_console_lookup_by_index(0);
-    DisplaySurface *surface;
-    int dw, dh, i;
+    struct XenInput *in = (struct XenInput *)dev;
+    int dx, dy, dz;
 
-    if (!con) {
-        xen_pv_printf(&xenfb->c.xendev, 0, "No QEMU console available");
-        return;
-    }
+    dx = in->mouse_axes[INPUT_AXIS_X];
+    dy = in->mouse_axes[INPUT_AXIS_Y];
+    dz = in->mouse_wheel;
+
+    trace_xenfb_mouse_event(in, dx, dy, dz, 0,
+                            in->abs_pointer_wanted);
+
+    if (in->abs_pointer_wanted) {
+        QemuConsole *con = qemu_console_lookup_by_index(0);
+        DisplaySurface *surface;
+        int dw, dh;
+
+        if (!con) {
+            xen_pv_printf(&in->c.xendev, 0, "No QEMU console available");
+            return;
+        }
+
+        surface = qemu_console_surface(con);
+        dw = surface_width(surface);
+        dh = surface_height(surface);
+
+        dx = dx * (dw - 1) / 0x7fff;
+        dy = dy * (dh - 1) / 0x7fff;
 
-    surface = qemu_console_surface(con);
-    dw = surface_width(surface);
-    dh = surface_height(surface);
-
-    trace_xenfb_mouse_event(opaque, dx, dy, dz, button_state,
-                            xenfb->abs_pointer_wanted);
-    if (xenfb->abs_pointer_wanted)
-	xenfb_send_position(xenfb,
-			    dx * (dw - 1) / 0x7fff,
-			    dy * (dh - 1) / 0x7fff,
-			    dz);
-    else
-	xenfb_send_motion(xenfb, dx, dy, dz);
-
-    for (i = 0 ; i < 8 ; i++) {
-	int lastDown = xenfb->button_state & (1 << i);
-	int down = button_state & (1 << i);
-	if (down == lastDown)
-	    continue;
-
-	if (xenfb_send_key(xenfb, down, BTN_LEFT+i) < 0)
-	    return;
+        xenfb_send_position(in, dx, dy, dz);
+    } else {
+        xenfb_send_motion(in, dx, dy, dz);
+
+        in->mouse_axes[INPUT_AXIS_X] = 0;
+        in->mouse_axes[INPUT_AXIS_Y] = 0;
     }
-    xenfb->button_state = button_state;
+
+    in->mouse_wheel = 0;
 }
 
+static QemuInputHandler xenfb_keyboard = {
+    .name  = "Xen PVFB Keyboard",
+    .mask  = INPUT_EVENT_MASK_KEY,
+    .event = xenfb_key_event,
+};
+static QemuInputHandler xenfb_abs_mouse = {
+    .name  = "Xen PVFB Absolute Mouse",
+    .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_ABS,
+    .event = xenfb_mouse_event,
+    .sync  = xenfb_mouse_sync
+};
+static QemuInputHandler xenfb_rel_mouse = {
+    .name  = "Xen PVFB Mouse",
+    .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_REL,
+    .event = xenfb_mouse_event,
+    .sync  = xenfb_mouse_sync,
+};
+
 static int input_init(struct XenDevice *xendev)
 {
     xenstore_write_be_int(xendev, "feature-abs-pointer", 1);
@@ -356,7 +324,6 @@ static int input_initialise(struct XenDevice *xendev)
     if (rc != 0)
 	return rc;
 
-    qemu_add_kbd_event_handler(xenfb_key_event, in);
     return 0;
 }
 
@@ -369,24 +336,34 @@ static void input_connected(struct XenDevice *xendev)
         in->abs_pointer_wanted = 0;
     }
 
-    if (in->qmouse) {
-        qemu_remove_mouse_event_handler(in->qmouse);
+    if (in->qkbd) {
+        qemu_input_handler_unregister(in->qkbd);
+    }
+    if (in->qmou) {
+        qemu_input_handler_unregister(in->qmou);
     }
     trace_xenfb_input_connected(xendev, in->abs_pointer_wanted);
-    in->qmouse = qemu_add_mouse_event_handler(xenfb_mouse_event, in,
-					      in->abs_pointer_wanted,
-					      "Xen PVFB Mouse");
+
+    in->qkbd = qemu_input_handler_register((DeviceState *)in, &xenfb_keyboard);
+    in->qmou = qemu_input_handler_register((DeviceState *)in,
+        (in->abs_pointer_wanted ? &xenfb_abs_mouse : &xenfb_rel_mouse));
+
+    qemu_input_handler_activate(in->qkbd);
+    qemu_input_handler_activate(in->qmou);
 }
 
 static void input_disconnect(struct XenDevice *xendev)
 {
     struct XenInput *in = container_of(xendev, struct XenInput, c.xendev);
 
-    if (in->qmouse) {
-	qemu_remove_mouse_event_handler(in->qmouse);
-	in->qmouse = NULL;
+    if (in->qkbd) {
+        qemu_input_handler_unregister(in->qkbd);
+        in->qkbd = NULL;
+    }
+    if (in->qmou) {
+        qemu_input_handler_unregister(in->qmou);
+        in->qmou = NULL;
     }
-    qemu_add_kbd_event_handler(NULL, NULL);
     common_unbind(&in->c);
 }
 
-- 
2.1.4
