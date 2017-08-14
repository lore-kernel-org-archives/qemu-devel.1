Received: from eggs.gnu.org ([2001:4830:134:3::10]:48079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhEoi-0006Zw-N5
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 08:50:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhEof-0003wS-Bt
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 08:50:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dhEoe-0003vr-R2
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 08:49:57 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9265625A784
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 12:49:55 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 14 Aug 2017 13:49:27 +0100
Message-Id: <20170814124927.30134-13-berrange@redhat.com>
In-Reply-To: <20170814124927.30134-1-berrange@redhat.com>
References: <20170814124927.30134-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 12/12] display: convert XenInput keyboard to
 keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Replace the scancode2linux table with an automatically
generated table. In doing so, the XenFB keyboard
handler is also converted to the modern InputEvent
framework.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 hw/display/xenfb.c | 133 ++++++++++++-----------------------------------------
 1 file changed, 30 insertions(+), 103 deletions(-)

diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index df8b78f6f4..b4668dfce4 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -28,6 +28,7 @@
 
 #include "hw/hw.h"
 #include "ui/console.h"
+#include "ui/input.h"
 #include "hw/xen/xen_backend.h"
 
 #include <xen/event_channel.h>
@@ -52,7 +53,7 @@ struct XenInput {
     struct common c;
     int abs_pointer_wanted; /* Whether guest supports absolute pointer */
     int button_state;       /* Last seen pointer button state */
-    int extended;
+    QemuInputHandlerState *qkbd;
     QEMUPutMouseEntry *qmouse;
 };
 
@@ -120,78 +121,6 @@ static void common_unbind(struct common *c)
 
 /* -------------------------------------------------------------------- */
 
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
@@ -260,37 +189,21 @@ static int xenfb_send_position(struct XenInput *xenfb,
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
+    struct XenInput *xenfb = container_of(dev, struct XenInput,
+                                          c.xendev.qdev);
+    InputKeyEvent *key = evt->u.key.data;
+    int qcode;
 
-    if (scancode == 0xe0) {
-	xenfb->extended = 1;
-	return;
-    } else if (scancode & 0x80) {
-	scancode &= 0x7f;
-	down = 0;
-    }
-    if (xenfb->extended) {
-	scancode |= 0x80;
-	xenfb->extended = 0;
+    assert(evt->type == INPUT_EVENT_KIND_KEY);
+
+    qcode = qemu_input_key_value_to_qcode(key->key);
+    if (qcode < qemu_input_map_qcode_to_linux_len) {
+        xenfb_send_key(xenfb, key->down,
+                       qemu_input_map_qcode_to_linux[qcode]);
     }
-    xenfb_send_key(xenfb, down, scancode2linux[scancode]);
 }
 
 /*
@@ -347,6 +260,12 @@ static int input_init(struct XenDevice *xendev)
     return 0;
 }
 
+static QemuInputHandler xenfb_keyboard_handler = {
+    .name  = "Xen FB Keyboard",
+    .mask  = INPUT_EVENT_MASK_KEY,
+    .event = xenfb_key_event,
+};
+
 static int input_initialise(struct XenDevice *xendev)
 {
     struct XenInput *in = container_of(xendev, struct XenInput, c.xendev);
@@ -356,7 +275,6 @@ static int input_initialise(struct XenDevice *xendev)
     if (rc != 0)
 	return rc;
 
-    qemu_add_kbd_event_handler(xenfb_key_event, in);
     return 0;
 }
 
@@ -376,6 +294,12 @@ static void input_connected(struct XenDevice *xendev)
     in->qmouse = qemu_add_mouse_event_handler(xenfb_mouse_event, in,
 					      in->abs_pointer_wanted,
 					      "Xen PVFB Mouse");
+
+    if (in->qkbd) {
+        qemu_input_handler_unregister(in->qkbd);
+    }
+    in->qkbd = qemu_input_handler_register((DeviceState *)in,
+                                           &xenfb_keyboard_handler);
 }
 
 static void input_disconnect(struct XenDevice *xendev)
@@ -386,7 +310,10 @@ static void input_disconnect(struct XenDevice *xendev)
 	qemu_remove_mouse_event_handler(in->qmouse);
 	in->qmouse = NULL;
     }
-    qemu_add_kbd_event_handler(NULL, NULL);
+    if (in->qkbd) {
+        qemu_input_handler_unregister(in->qkbd);
+        in->qkbd = NULL;
+    }
     common_unbind(&in->c);
 }
 
-- 
2.13.3
