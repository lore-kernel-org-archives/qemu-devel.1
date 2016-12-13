Received: from eggs.gnu.org ([2001:4830:134:3::10]:36132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ossman@cendio.se>) id 1cGmqQ-0002vH-0I
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:10:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ossman@cendio.se>) id 1cGmqO-0006TG-KD
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:10:10 -0500
Received: from lists.cendio.se ([2a00:801:107:f000::b]:45340
	helo=mail.cendio.se)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ossman@cendio.se>) id 1cGmqO-0006PX-EP
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:10:08 -0500
References: <f460049b-211e-194b-d4c3-a3cc34e4d289@cendio.se>
	<1481616362.27088.74.camel@redhat.com>
From: Pierre Ossman <ossman@cendio.se>
Message-ID: <7ba29954-e3ad-529c-9978-b10d2788f9e4@cendio.se>
Date: Tue, 13 Dec 2016 14:10:04 +0100
MIME-Version: 1.0
In-Reply-To: <1481616362.27088.74.camel@redhat.com>
Content-Type: multipart/mixed; boundary="------------7EC3A6B0E202B4CFC700A638"
Subject: Re: [Qemu-devel] VNC LED state buggy, interop issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

This is a multi-part message in MIME format.
--------------7EC3A6B0E202B4CFC700A638
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 13/12/16 09:06, Gerd Hoffmann wrote:
>>   b) Remove the assumption from the code and the protocol.
>
> Patches are welcome.
>

I was just aiming for a consensus on the intended behaviour, rather than=20
fix the bug right now. :)
But all right, attached patch is an attempt.

Btw, is there any client that implements this extension yet? I couldn't=20
find anything.

Regards
--=20
Pierre Ossman           Software Development
Cendio AB		http://cendio.com
Teknikringen 8		http://twitter.com/ThinLinc
583 30 Link=C3=B6ping	http://facebook.com/ThinLinc
Phone: +46-13-214600	http://plus.google.com/+CendioThinLinc

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

--------------7EC3A6B0E202B4CFC700A638
Content-Type: text/x-patch;
 name="0001-vnc-track-LED-state-separately.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-vnc-track-LED-state-separately.patch"

>From c27ac2026c84d7fd0da2c27a7ebe08f4359cc977 Mon Sep 17 00:00:00 2001
From: Pierre Ossman <ossman@cendio.se>
Date: Tue, 13 Dec 2016 14:03:18 +0100
Subject: [PATCH] vnc: track LED state separately

Piggy-backing on the modifier state array made it difficult to send
out updates at the proper times.

Signed-off-by: Pierre Ossman <ossman@cendio.se>
---
 ui/vnc.c | 56 +++++++++++++-------------------------------------------
 ui/vnc.h |  3 ++-
 2 files changed, 15 insertions(+), 44 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 2c28a59..c449a7d 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1231,8 +1231,6 @@ void vnc_disconnect_finish(VncState *vs)
         vnc_update_server_surface(vs->vd);
     }
 
-    if (vs->vd->lock_key_sync)
-        qemu_remove_led_event_handler(vs->led);
     vnc_unlock_output(vs);
 
     qemu_mutex_destroy(&vs->output_mutex);
@@ -1665,69 +1663,38 @@ static void press_key(VncState *vs, int keysym)
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
+    if (ledstate != vd->ledstate)
+        return;
 
-    if (vs->modifiers_state[0x3a] != caps) {
-        vs->modifiers_state[0x3a] = caps;
-    }
-    if (vs->modifiers_state[0x45] != num) {
-        vs->modifiers_state[0x45] = num;
-    }
-    if (vs->modifiers_state[0x46] != scr) {
-        vs->modifiers_state[0x46] = scr;
-    }
+    vd->ledstate = ledstate;
 
-    /* Sending the current led state message to the client */
-    if (has_changed) {
-        vnc_led_state_change(vs);
+    QTAILQ_FOREACH(client, &vd->clients, next) {
+        vnc_led_state_change(client);
     }
 }
 
@@ -3083,8 +3050,6 @@ void vnc_start_protocol(VncState *vs)
     vnc_write(vs, "RFB 003.008\n", 12);
     vnc_flush(vs);
     vnc_read_when(vs, protocol_version, 12);
-    if (vs->vd->lock_key_sync)
-        vs->led = qemu_add_led_event_handler(kbd_leds, vs);
 
     vs->mouse_mode_notifier.notify = check_pointer_type_change;
     qemu_add_mouse_mode_change_notifier(&vs->mouse_mode_notifier);
@@ -3191,6 +3156,8 @@ static void vnc_display_close(VncDisplay *vd)
     }
     g_free(vd->tlsaclname);
     vd->tlsaclname = NULL;
+    if (vd->lock_key_sync)
+        qemu_remove_led_event_handler(vd->led);
 }
 
 int vnc_display_password(const char *id, const char *password)
@@ -3758,6 +3725,9 @@ void vnc_display_open(const char *id, Error **errp)
     }
 #endif
     vd->lock_key_sync = lock_key_sync;
+    if (lock_key_sync)
+        vd->led = qemu_add_led_event_handler(kbd_leds, vd);
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
2.7.4


--------------7EC3A6B0E202B4CFC700A638--
