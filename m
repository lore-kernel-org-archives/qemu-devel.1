Received: from eggs.gnu.org ([2001:4830:134:3::10]:37965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYahd-00053b-Iv
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:50:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYaha-0001Td-UA
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:50:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cYaha-0001Se-IM
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:50:38 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 31 Jan 2017 16:50:24 +0100
Message-Id: <1485877831-28786-5-git-send-email-kraxel@redhat.com>
In-Reply-To: <1485877831-28786-1-git-send-email-kraxel@redhat.com>
References: <1485877831-28786-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL v2 04/11] vnc: track LED state separately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pierre Ossman <ossman@cendio.se>, Gerd Hoffmann <kraxel@redhat.com>

From: Pierre Ossman <ossman@cendio.se>

Piggy-backing on the modifier state array made it difficult to send
out updates at the proper times.

Signed-off-by: Pierre Ossman <ossman@cendio.se>
Message-id: 5aa28297d665cee24ddab26bbf4633e4252f97b6.1483978442.git.ossman@cendio.se
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc.c | 59 ++++++++++++++++-------------------------------------------
 ui/vnc.h |  3 ++-
 2 files changed, 18 insertions(+), 44 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 29aa9c4..cf9b597 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1231,8 +1231,6 @@ void vnc_disconnect_finish(VncState *vs)
         vnc_update_server_surface(vs->vd);
     }
 
-    if (vs->vd->lock_key_sync)
-        qemu_remove_led_event_handler(vs->led);
     vnc_unlock_output(vs);
 
     qemu_mutex_destroy(&vs->output_mutex);
@@ -1665,69 +1663,39 @@ static void press_key(VncState *vs, int keysym)
     qemu_input_event_send_key_delay(vs->vd->key_delay_ms);
 }
 
-static int current_led_state(VncState *vs)
-{
-    int ledstate = 0;
-
-    if (vs->modifiers_state[0x46]) {
-        ledstate |= QEMU_SCROLL_LOCK_LED;
-    }
-    if (vs->modifiers_state[0x45]) {
-        ledstate |= QEMU_NUM_LOCK_LED;
-    }
-    if (vs->modifiers_state[0x3a]) {
-        ledstate |= QEMU_CAPS_LOCK_LED;
-    }
-
-    return ledstate;
-}
-
 static void vnc_led_state_change(VncState *vs)
 {
-    int ledstate = 0;
-
     if (!vnc_has_feature(vs, VNC_FEATURE_LED_STATE)) {
         return;
     }
 
-    ledstate = current_led_state(vs);
     vnc_lock_output(vs);
     vnc_write_u8(vs, VNC_MSG_SERVER_FRAMEBUFFER_UPDATE);
     vnc_write_u8(vs, 0);
     vnc_write_u16(vs, 1);
     vnc_framebuffer_update(vs, 0, 0, 1, 1, VNC_ENCODING_LED_STATE);
-    vnc_write_u8(vs, ledstate);
+    vnc_write_u8(vs, vs->vd->ledstate);
     vnc_unlock_output(vs);
     vnc_flush(vs);
 }
 
 static void kbd_leds(void *opaque, int ledstate)
 {
-    VncState *vs = opaque;
-    int caps, num, scr;
-    bool has_changed = (ledstate != current_led_state(vs));
+    VncDisplay *vd = opaque;
+    VncState *client;
 
     trace_vnc_key_guest_leds((ledstate & QEMU_CAPS_LOCK_LED),
                              (ledstate & QEMU_NUM_LOCK_LED),
                              (ledstate & QEMU_SCROLL_LOCK_LED));
 
-    caps = ledstate & QEMU_CAPS_LOCK_LED ? 1 : 0;
-    num  = ledstate & QEMU_NUM_LOCK_LED  ? 1 : 0;
-    scr  = ledstate & QEMU_SCROLL_LOCK_LED ? 1 : 0;
-
-    if (vs->modifiers_state[0x3a] != caps) {
-        vs->modifiers_state[0x3a] = caps;
-    }
-    if (vs->modifiers_state[0x45] != num) {
-        vs->modifiers_state[0x45] = num;
-    }
-    if (vs->modifiers_state[0x46] != scr) {
-        vs->modifiers_state[0x46] = scr;
+    if (ledstate == vd->ledstate) {
+        return;
     }
 
-    /* Sending the current led state message to the client */
-    if (has_changed) {
-        vnc_led_state_change(vs);
+    vd->ledstate = ledstate;
+
+    QTAILQ_FOREACH(client, &vd->clients, next) {
+        vnc_led_state_change(client);
     }
 }
 
@@ -3087,8 +3055,6 @@ void vnc_start_protocol(VncState *vs)
     vnc_write(vs, "RFB 003.008\n", 12);
     vnc_flush(vs);
     vnc_read_when(vs, protocol_version, 12);
-    if (vs->vd->lock_key_sync)
-        vs->led = qemu_add_led_event_handler(kbd_leds, vs);
 
     vs->mouse_mode_notifier.notify = check_pointer_type_change;
     qemu_add_mouse_mode_change_notifier(&vs->mouse_mode_notifier);
@@ -3195,6 +3161,9 @@ static void vnc_display_close(VncDisplay *vd)
     }
     g_free(vd->tlsaclname);
     vd->tlsaclname = NULL;
+    if (vd->lock_key_sync) {
+        qemu_remove_led_event_handler(vd->led);
+    }
 }
 
 int vnc_display_password(const char *id, const char *password)
@@ -3762,6 +3731,10 @@ void vnc_display_open(const char *id, Error **errp)
     }
 #endif
     vd->lock_key_sync = lock_key_sync;
+    if (lock_key_sync) {
+        vd->led = qemu_add_led_event_handler(kbd_leds, vd);
+    }
+    vd->ledstate = 0;
     vd->key_delay_ms = key_delay_ms;
 
     device_id = qemu_opt_get(opts, "display");
diff --git a/ui/vnc.h b/ui/vnc.h
index d20b154..d8c9de5 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -154,6 +154,8 @@ struct VncDisplay
     DisplayChangeListener dcl;
     kbd_layout_t *kbd_layout;
     int lock_key_sync;
+    QEMUPutLEDEntry *led;
+    int ledstate;
     int key_delay_ms;
     QemuMutex mutex;
 
@@ -304,7 +306,6 @@ struct VncState
     size_t read_handler_expect;
     /* input */
     uint8_t modifiers_state[256];
-    QEMUPutLEDEntry *led;
 
     bool abort;
     QemuMutex output_mutex;
-- 
1.8.3.1
