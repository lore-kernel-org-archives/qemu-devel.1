Received: from eggs.gnu.org ([209.51.188.92]:59267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glsVw-0006Ht-KB
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:38:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glsM3-0003Qo-MF
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:28:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1glsM3-0003QZ-EG
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:28:23 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B07CE81F0D
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 09:28:22 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 22 Jan 2019 10:28:12 +0100
Message-Id: <20190122092814.14919-7-kraxel@redhat.com>
In-Reply-To: <20190122092814.14919-1-kraxel@redhat.com>
References: <20190122092814.14919-1-kraxel@redhat.com>
Subject: [Qemu-devel] [RFC PATCH v3 6/8] kbd-state: use state tracker for vnc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

Use the new keyboard state tracked for vnc.  Allows to drop the
vnc-specific modifier state tracking code.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc.h |   5 ++-
 ui/vnc.c | 120 ++++++++++++++++++---------------------------------------------
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
 
 // #define _VNC_DEBUG 1
 
@@ -155,7 +156,7 @@ struct VncDisplay
     int lock_key_sync;
     QEMUPutLEDEntry *led;
     int ledstate;
-    int key_delay_ms;
+    QKbdState *kbd;
     QemuMutex mutex;
 
     QEMUCursor *cursor;
@@ -326,8 +327,6 @@ struct VncState
 
     VncReadEvent *read_handler;
     size_t read_handler_expect;
-    /* input */
-    uint8_t modifiers_state[256];
 
     bool abort;
     QemuMutex output_mutex;
diff --git a/ui/vnc.c b/ui/vnc.c
index 9e4b2beb71..a9fe166ee8 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -59,7 +59,6 @@ static QTAILQ_HEAD(, VncDisplay) vnc_displays =
     QTAILQ_HEAD_INITIALIZER(vnc_displays);
 
 static int vnc_cursor_define(VncState *vs);
-static void vnc_release_modifiers(VncState *vs);
 static void vnc_update_throttle_offset(VncState *vs);
 
 static void vnc_set_share_mode(VncState *vs, VncShareMode mode)
@@ -1248,7 +1247,7 @@ void vnc_disconnect_finish(VncState *vs)
     vnc_sasl_client_cleanup(vs);
 #endif /* CONFIG_VNC_SASL */
     audio_del(vs);
-    vnc_release_modifiers(vs);
+    qkbd_state_lift_all_keys(vs->vd->kbd);
 
     if (vs->mouse_mode_notifier.notify != NULL) {
         qemu_remove_mouse_mode_change_notifier(&vs->mouse_mode_notifier);
@@ -1737,26 +1736,10 @@ static void pointer_event(VncState *vs, int button_mask, int x, int y)
     qemu_input_event_sync();
 }
 
-static void reset_keys(VncState *vs)
+static void press_key(VncState *vs, QKeyCode qcode)
 {
-    int i;
-    for(i = 0; i < 256; i++) {
-        if (vs->modifiers_state[i]) {
-            qemu_input_event_send_key_number(vs->vd->dcl.con, i, false);
-            qemu_input_event_send_key_delay(vs->vd->key_delay_ms);
-            vs->modifiers_state[i] = 0;
-        }
-    }
-}
-
-static void press_key(VncState *vs, int keysym)
-{
-    int keycode = keysym2scancode(vs->vd->kbd_layout, keysym,
-                                  false, false, false) & SCANCODE_KEYMASK;
-    qemu_input_event_send_key_number(vs->vd->dcl.con, keycode, true);
-    qemu_input_event_send_key_delay(vs->vd->key_delay_ms);
-    qemu_input_event_send_key_number(vs->vd->dcl.con, keycode, false);
-    qemu_input_event_send_key_delay(vs->vd->key_delay_ms);
+    qkbd_state_key_event(vs->vd->kbd, qcode, true);
+    qkbd_state_key_event(vs->vd->kbd, qcode, false);
 }
 
 static void vnc_led_state_change(VncState *vs)
@@ -1797,32 +1780,20 @@ static void kbd_leds(void *opaque, int ledstate)
 
 static void do_key_event(VncState *vs, int down, int keycode, int sym)
 {
+    QKeyCode qcode = qemu_input_key_number_to_qcode(keycode);
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
-            vs->modifiers_state[keycode] = 1;
-        else
-            vs->modifiers_state[keycode] = 0;
-        break;
-    case 0x02 ... 0x0a: /* '1' to '9' keys */
-        if (vs->vd->dcl.con == NULL &&
-            down && vs->modifiers_state[0x1d] && vs->modifiers_state[0x38]) {
+    switch (qcode) {
+    case Q_KEY_CODE_1 ... Q_KEY_CODE_9: /* '1' to '9' keys */
+        if (vs->vd->dcl.con == NULL && down &&
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
-            vs->modifiers_state[keycode] ^= 1;
+    default:
         break;
     }
 
@@ -1837,16 +1808,14 @@ static void do_key_event(VncState *vs, int down, int keycode, int sym)
            toggles numlock away from the VNC window.
         */
         if (keysym_is_numlock(vs->vd->kbd_layout, sym & 0xFFFF)) {
-            if (!vs->modifiers_state[0x45]) {
+            if (!qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_NUMLOCK)) {
                 trace_vnc_key_sync_numlock(true);
-                vs->modifiers_state[0x45] = 1;
-                press_key(vs, 0xff7f);
+                press_key(vs, Q_KEY_CODE_NUM_LOCK);
             }
         } else {
-            if (vs->modifiers_state[0x45]) {
+            if (qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_NUMLOCK)) {
                 trace_vnc_key_sync_numlock(false);
-                vs->modifiers_state[0x45] = 0;
-                press_key(vs, 0xff7f);
+                press_key(vs, Q_KEY_CODE_NUM_LOCK);
             }
         }
     }
@@ -1859,30 +1828,25 @@ static void do_key_event(VncState *vs, int down, int keycode, int sym)
            toggles capslock away from the VNC window.
         */
         int uppercase = !!(sym >= 'A' && sym <= 'Z');
-        int shift = !!(vs->modifiers_state[0x2a] | vs->modifiers_state[0x36]);
-        int capslock = !!(vs->modifiers_state[0x3a]);
+        bool shift = qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_SHIFT);
+        bool capslock = qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_CAPSLOCK);
         if (capslock) {
             if (uppercase == shift) {
                 trace_vnc_key_sync_capslock(false);
-                vs->modifiers_state[0x3a] = 0;
-                press_key(vs, 0xffe5);
+                press_key(vs, Q_KEY_CODE_CAPS_LOCK);
             }
         } else {
             if (uppercase != shift) {
                 trace_vnc_key_sync_capslock(true);
-                vs->modifiers_state[0x3a] = 1;
-                press_key(vs, 0xffe5);
+                press_key(vs, Q_KEY_CODE_CAPS_LOCK);
             }
         }
     }
 
-    if (qemu_console_is_graphic(NULL)) {
-        qemu_input_event_send_key_number(vs->vd->dcl.con, keycode, down);
-        qemu_input_event_send_key_delay(vs->vd->key_delay_ms);
-    } else {
-        bool numlock = vs->modifiers_state[0x45];
-        bool control = (vs->modifiers_state[0x1d] ||
-                        vs->modifiers_state[0x9d]);
+    qkbd_state_key_event(vs->vd->kbd, qcode, down);
+    if (!qemu_console_is_graphic(NULL)) {
+        bool numlock = qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_NUMLOCK);
+        bool control = qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_CTRL);
         /* QEMU console emulation */
         if (down) {
             switch (keycode) {
@@ -1983,27 +1947,6 @@ static void do_key_event(VncState *vs, int down, int keycode, int sym)
     }
 }
 
-static void vnc_release_modifiers(VncState *vs)
-{
-    static const int keycodes[] = {
-        /* shift, control, alt keys, both left & right */
-        0x2a, 0x36, 0x1d, 0x9d, 0x38, 0xb8,
-    };
-    int i, keycode;
-
-    if (!qemu_console_is_graphic(NULL)) {
-        return;
-    }
-    for (i = 0; i < ARRAY_SIZE(keycodes); i++) {
-        keycode = keycodes[i];
-        if (!vs->modifiers_state[keycode]) {
-            continue;
-        }
-        qemu_input_event_send_key_number(vs->vd->dcl.con, keycode, false);
-        qemu_input_event_send_key_delay(vs->vd->key_delay_ms);
-    }
-}
-
 static const char *code2name(int keycode)
 {
     return QKeyCode_str(qemu_input_key_number_to_qcode(keycode));
@@ -2011,9 +1954,9 @@ static const char *code2name(int keycode)
 
 static void key_event(VncState *vs, int down, uint32_t sym)
 {
-    bool shift = vs->modifiers_state[0x2a] || vs->modifiers_state[0x36];
-    bool altgr = vs->modifiers_state[0xb8];
-    bool ctrl  = vs->modifiers_state[0x1d] || vs->modifiers_state[0x9d];
+    bool shift = qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_SHIFT);
+    bool altgr = qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_ALTGR);
+    bool ctrl  = qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_CTRL);
     int keycode;
     int lsym = sym;
 
@@ -3240,6 +3183,7 @@ void vnc_display_init(const char *id, Error **errp)
 
     vd->dcl.ops = &dcl_ops;
     register_displaychangelistener(&vd->dcl);
+    vd->kbd = qkbd_state_init(vd->dcl.con);
 }
 
 
@@ -3976,7 +3920,6 @@ void vnc_display_open(const char *id, Error **errp)
         vd->led = qemu_add_led_event_handler(kbd_leds, vd);
     }
     vd->ledstate = 0;
-    vd->key_delay_ms = key_delay_ms;
 
     device_id = qemu_opt_get(opts, "display");
     if (device_id) {
@@ -3993,10 +3936,13 @@ void vnc_display_open(const char *id, Error **errp)
     }
 
     if (con != vd->dcl.con) {
+        qkbd_state_free(vd->kbd);
         unregister_displaychangelistener(&vd->dcl);
         vd->dcl.con = con;
         register_displaychangelistener(&vd->dcl);
+        vd->kbd = qkbd_state_init(vd->dcl.con);
     }
+    qkbd_state_set_delay(vd->kbd, key_delay_ms);
 
     if (saddr == NULL) {
         goto cleanup;
-- 
2.9.3
