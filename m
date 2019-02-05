Received: from eggs.gnu.org ([209.51.188.92]:42598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqyQs-0007P4-Tr
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:58:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqyQr-0006IN-2U
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:58:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gqyQq-0006BI-NT
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:58:24 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  5 Feb 2019 11:57:56 +0100
Message-Id: <20190205105758.4230-13-kraxel@redhat.com>
In-Reply-To: <20190205105758.4230-1-kraxel@redhat.com>
References: <20190205105758.4230-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/14] kbd-state: use state tracker for vnc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Use the new keyboard state tracked for vnc.  Allows to drop the
vnc-specific modifier state tracking code.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-id: 20190122092814.14919-7-kraxel@redhat.com
---
 ui/vnc.h |   5 ++-
 ui/vnc.c | 120 ++++++++++++++++++---------------------------------------=
------
 2 files changed, 35 insertions(+), 90 deletions(-)

diff --git a/ui/vnc.h b/ui/vnc.h
index a86e0610e8..81daa7a0eb 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -44,6 +44,7 @@
 #include "keymaps.h"
 #include "vnc-palette.h"
 #include "vnc-enc-zrle.h"
+#include "ui/kbd-state.h"
=20
 // #define _VNC_DEBUG 1
=20
@@ -155,7 +156,7 @@ struct VncDisplay
     int lock_key_sync;
     QEMUPutLEDEntry *led;
     int ledstate;
-    int key_delay_ms;
+    QKbdState *kbd;
     QemuMutex mutex;
=20
     QEMUCursor *cursor;
@@ -326,8 +327,6 @@ struct VncState
=20
     VncReadEvent *read_handler;
     size_t read_handler_expect;
-    /* input */
-    uint8_t modifiers_state[256];
=20
     bool abort;
     QemuMutex output_mutex;
diff --git a/ui/vnc.c b/ui/vnc.c
index 6002d09407..8e52b999b8 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -59,7 +59,6 @@ static QTAILQ_HEAD(, VncDisplay) vnc_displays =3D
     QTAILQ_HEAD_INITIALIZER(vnc_displays);
=20
 static int vnc_cursor_define(VncState *vs);
-static void vnc_release_modifiers(VncState *vs);
 static void vnc_update_throttle_offset(VncState *vs);
=20
 static void vnc_set_share_mode(VncState *vs, VncShareMode mode)
@@ -1267,7 +1266,7 @@ void vnc_disconnect_finish(VncState *vs)
     vnc_sasl_client_cleanup(vs);
 #endif /* CONFIG_VNC_SASL */
     audio_del(vs);
-    vnc_release_modifiers(vs);
+    qkbd_state_lift_all_keys(vs->vd->kbd);
=20
     if (vs->mouse_mode_notifier.notify !=3D NULL) {
         qemu_remove_mouse_mode_change_notifier(&vs->mouse_mode_notifier)=
;
@@ -1756,26 +1755,10 @@ static void pointer_event(VncState *vs, int butto=
n_mask, int x, int y)
     qemu_input_event_sync();
 }
=20
-static void reset_keys(VncState *vs)
+static void press_key(VncState *vs, QKeyCode qcode)
 {
-    int i;
-    for(i =3D 0; i < 256; i++) {
-        if (vs->modifiers_state[i]) {
-            qemu_input_event_send_key_number(vs->vd->dcl.con, i, false);
-            qemu_input_event_send_key_delay(vs->vd->key_delay_ms);
-            vs->modifiers_state[i] =3D 0;
-        }
-    }
-}
-
-static void press_key(VncState *vs, int keysym)
-{
-    int keycode =3D keysym2scancode(vs->vd->kbd_layout, keysym,
-                                  false, false, false) & SCANCODE_KEYMAS=
K;
-    qemu_input_event_send_key_number(vs->vd->dcl.con, keycode, true);
-    qemu_input_event_send_key_delay(vs->vd->key_delay_ms);
-    qemu_input_event_send_key_number(vs->vd->dcl.con, keycode, false);
-    qemu_input_event_send_key_delay(vs->vd->key_delay_ms);
+    qkbd_state_key_event(vs->vd->kbd, qcode, true);
+    qkbd_state_key_event(vs->vd->kbd, qcode, false);
 }
=20
 static void vnc_led_state_change(VncState *vs)
@@ -1816,32 +1799,20 @@ static void kbd_leds(void *opaque, int ledstate)
=20
 static void do_key_event(VncState *vs, int down, int keycode, int sym)
 {
+    QKeyCode qcode =3D qemu_input_key_number_to_qcode(keycode);
+
     /* QEMU console switch */
-    switch(keycode) {
-    case 0x2a:                          /* Left Shift */
-    case 0x36:                          /* Right Shift */
-    case 0x1d:                          /* Left CTRL */
-    case 0x9d:                          /* Right CTRL */
-    case 0x38:                          /* Left ALT */
-    case 0xb8:                          /* Right ALT */
-        if (down)
-            vs->modifiers_state[keycode] =3D 1;
-        else
-            vs->modifiers_state[keycode] =3D 0;
-        break;
-    case 0x02 ... 0x0a: /* '1' to '9' keys */
-        if (vs->vd->dcl.con =3D=3D NULL &&
-            down && vs->modifiers_state[0x1d] && vs->modifiers_state[0x3=
8]) {
+    switch (qcode) {
+    case Q_KEY_CODE_1 ... Q_KEY_CODE_9: /* '1' to '9' keys */
+        if (vs->vd->dcl.con =3D=3D NULL && down &&
+            qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_CTRL) &&
+            qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_ALT)) {
             /* Reset the modifiers sent to the current console */
-            reset_keys(vs);
-            console_select(keycode - 0x02);
+            qkbd_state_lift_all_keys(vs->vd->kbd);
+            console_select(qcode - Q_KEY_CODE_1);
             return;
         }
-        break;
-    case 0x3a:                        /* CapsLock */
-    case 0x45:                        /* NumLock */
-        if (down)
-            vs->modifiers_state[keycode] ^=3D 1;
+    default:
         break;
     }
=20
@@ -1856,16 +1827,14 @@ static void do_key_event(VncState *vs, int down, =
int keycode, int sym)
            toggles numlock away from the VNC window.
         */
         if (keysym_is_numlock(vs->vd->kbd_layout, sym & 0xFFFF)) {
-            if (!vs->modifiers_state[0x45]) {
+            if (!qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_NUMLOCK))=
 {
                 trace_vnc_key_sync_numlock(true);
-                vs->modifiers_state[0x45] =3D 1;
-                press_key(vs, 0xff7f);
+                press_key(vs, Q_KEY_CODE_NUM_LOCK);
             }
         } else {
-            if (vs->modifiers_state[0x45]) {
+            if (qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_NUMLOCK)) =
{
                 trace_vnc_key_sync_numlock(false);
-                vs->modifiers_state[0x45] =3D 0;
-                press_key(vs, 0xff7f);
+                press_key(vs, Q_KEY_CODE_NUM_LOCK);
             }
         }
     }
@@ -1878,30 +1847,25 @@ static void do_key_event(VncState *vs, int down, =
int keycode, int sym)
            toggles capslock away from the VNC window.
         */
         int uppercase =3D !!(sym >=3D 'A' && sym <=3D 'Z');
-        int shift =3D !!(vs->modifiers_state[0x2a] | vs->modifiers_state=
[0x36]);
-        int capslock =3D !!(vs->modifiers_state[0x3a]);
+        bool shift =3D qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_SHI=
FT);
+        bool capslock =3D qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_=
CAPSLOCK);
         if (capslock) {
             if (uppercase =3D=3D shift) {
                 trace_vnc_key_sync_capslock(false);
-                vs->modifiers_state[0x3a] =3D 0;
-                press_key(vs, 0xffe5);
+                press_key(vs, Q_KEY_CODE_CAPS_LOCK);
             }
         } else {
             if (uppercase !=3D shift) {
                 trace_vnc_key_sync_capslock(true);
-                vs->modifiers_state[0x3a] =3D 1;
-                press_key(vs, 0xffe5);
+                press_key(vs, Q_KEY_CODE_CAPS_LOCK);
             }
         }
     }
=20
-    if (qemu_console_is_graphic(NULL)) {
-        qemu_input_event_send_key_number(vs->vd->dcl.con, keycode, down)=
;
-        qemu_input_event_send_key_delay(vs->vd->key_delay_ms);
-    } else {
-        bool numlock =3D vs->modifiers_state[0x45];
-        bool control =3D (vs->modifiers_state[0x1d] ||
-                        vs->modifiers_state[0x9d]);
+    qkbd_state_key_event(vs->vd->kbd, qcode, down);
+    if (!qemu_console_is_graphic(NULL)) {
+        bool numlock =3D qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_N=
UMLOCK);
+        bool control =3D qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_C=
TRL);
         /* QEMU console emulation */
         if (down) {
             switch (keycode) {
@@ -2002,27 +1966,6 @@ static void do_key_event(VncState *vs, int down, i=
nt keycode, int sym)
     }
 }
=20
-static void vnc_release_modifiers(VncState *vs)
-{
-    static const int keycodes[] =3D {
-        /* shift, control, alt keys, both left & right */
-        0x2a, 0x36, 0x1d, 0x9d, 0x38, 0xb8,
-    };
-    int i, keycode;
-
-    if (!qemu_console_is_graphic(NULL)) {
-        return;
-    }
-    for (i =3D 0; i < ARRAY_SIZE(keycodes); i++) {
-        keycode =3D keycodes[i];
-        if (!vs->modifiers_state[keycode]) {
-            continue;
-        }
-        qemu_input_event_send_key_number(vs->vd->dcl.con, keycode, false=
);
-        qemu_input_event_send_key_delay(vs->vd->key_delay_ms);
-    }
-}
-
 static const char *code2name(int keycode)
 {
     return QKeyCode_str(qemu_input_key_number_to_qcode(keycode));
@@ -2030,9 +1973,9 @@ static const char *code2name(int keycode)
=20
 static void key_event(VncState *vs, int down, uint32_t sym)
 {
-    bool shift =3D vs->modifiers_state[0x2a] || vs->modifiers_state[0x36=
];
-    bool altgr =3D vs->modifiers_state[0xb8];
-    bool ctrl  =3D vs->modifiers_state[0x1d] || vs->modifiers_state[0x9d=
];
+    bool shift =3D qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_SHIFT);
+    bool altgr =3D qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_ALTGR);
+    bool ctrl  =3D qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_CTRL);
     int keycode;
     int lsym =3D sym;
=20
@@ -3259,6 +3202,7 @@ void vnc_display_init(const char *id, Error **errp)
=20
     vd->dcl.ops =3D &dcl_ops;
     register_displaychangelistener(&vd->dcl);
+    vd->kbd =3D qkbd_state_init(vd->dcl.con);
 }
=20
=20
@@ -3995,7 +3939,6 @@ void vnc_display_open(const char *id, Error **errp)
         vd->led =3D qemu_add_led_event_handler(kbd_leds, vd);
     }
     vd->ledstate =3D 0;
-    vd->key_delay_ms =3D key_delay_ms;
=20
     device_id =3D qemu_opt_get(opts, "display");
     if (device_id) {
@@ -4012,10 +3955,13 @@ void vnc_display_open(const char *id, Error **err=
p)
     }
=20
     if (con !=3D vd->dcl.con) {
+        qkbd_state_free(vd->kbd);
         unregister_displaychangelistener(&vd->dcl);
         vd->dcl.con =3D con;
         register_displaychangelistener(&vd->dcl);
+        vd->kbd =3D qkbd_state_init(vd->dcl.con);
     }
+    qkbd_state_set_delay(vd->kbd, key_delay_ms);
=20
     if (saddr =3D=3D NULL) {
         goto cleanup;
--=20
2.9.3
