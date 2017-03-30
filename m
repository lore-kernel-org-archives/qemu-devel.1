Received: from eggs.gnu.org ([2001:4830:134:3::10]:35659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1ctaEX-0003xY-2j
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:35:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1ctaET-00027I-0v
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:35:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:58476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1ctaES-00025C-RM
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:35:20 -0400
From: Alexander Graf <agraf@suse.de>
Date: Thu, 30 Mar 2017 15:35:38 +0200
Message-Id: <1490880938-90331-1-git-send-email-agraf@suse.de>
Subject: [Qemu-devel] [PATCH] input: Add trace events for polled keyboard
 input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

When driving QEMU from the outside, we have basically no chance to
determine how quickly the guest OS picks up key events, so we usually
have to limit ourselves to very slow keyboard presses to make sure
the guest always has enough chance to pick them up.

This patch adds trace events for when the guest polls for HID keyboard
events. That way we can be reasonably safely assume that the guest
handled that one key event and can type the next.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 hw/input/hid.c         | 26 +++++++++++++++++++++++++-
 hw/input/trace-events  |  2 ++
 include/hw/input/hid.h |  6 ++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/hw/input/hid.c b/hw/input/hid.c
index fa9cc4c..b68f597 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -228,7 +228,7 @@ static void hid_keyboard_event(DeviceState *dev, QemuConsole *src,
 {
     HIDState *hs = (HIDState *)dev;
     int scancodes[3], i, count;
-    int slot;
+    int slot = -1;
     InputKeyEvent *key = evt->u.key.data;
 
     count = qemu_input_key_value_to_scancode(key->key,
@@ -241,6 +241,13 @@ static void hid_keyboard_event(DeviceState *dev, QemuConsole *src,
     for (i = 0; i < count; i++) {
         slot = (hs->head + hs->n) & QUEUE_MASK; hs->n++;
         hs->kbd.keycodes[slot] = scancodes[i];
+        hs->kbd.poll_trigger[slot] = NULL;
+    }
+
+    if (slot != -1) {
+        hs->kbd.poll_trigger[slot] = g_new(HIDPollTrigger, 1);
+        hs->kbd.poll_trigger[slot]->key = *key->key;
+        hs->kbd.poll_trigger[slot]->down = key->down;
     }
     hs->event(hs);
 }
@@ -256,6 +263,23 @@ static void hid_keyboard_process_keycode(HIDState *hs)
     slot = hs->head & QUEUE_MASK; QUEUE_INCR(hs->head); hs->n--;
     keycode = hs->kbd.keycodes[slot];
 
+    /* Trace polled key events */
+    if (hs->kbd.poll_trigger[slot]) {
+        HIDPollTrigger *t = hs->kbd.poll_trigger[slot];
+        switch (t->key.type) {
+        case KEY_VALUE_KIND_NUMBER:
+            trace_hid_kbd_key_nr_polled(t->key.u.number.data, t->down);
+            break;
+        case KEY_VALUE_KIND_QCODE:
+            trace_hid_kbd_key_qt_polled(t->key.u.qcode.data, t->down);
+            break;
+        default:
+            break;
+        }
+        g_free(t);
+        hs->kbd.poll_trigger[slot] = NULL;
+    }
+
     key = keycode & 0x7f;
     index = key | ((hs->kbd.modifiers & (1 << 8)) >> 1);
     hid_code = hid_usage_keys[index];
diff --git a/hw/input/trace-events b/hw/input/trace-events
index f3bfbed..7a6b5ff 100644
--- a/hw/input/trace-events
+++ b/hw/input/trace-events
@@ -24,6 +24,8 @@ milkymist_softusb_pulse_irq(void) "Pulse IRQ"
 
 # hw/input/hid.c
 hid_kbd_queue_full(void) "queue full"
+hid_kbd_key_nr_polled(uint64_t value, bool down) "val %#"PRIx64" down %d"
+hid_kbd_key_qt_polled(uint64_t value, bool down) "val %#"PRIx64" down %d"
 
 # hw/input/virtio
 virtio_input_queue_full(void) "queue full"
diff --git a/include/hw/input/hid.h b/include/hw/input/hid.h
index 2127c7c..ff9541e 100644
--- a/include/hw/input/hid.h
+++ b/include/hw/input/hid.h
@@ -25,8 +25,14 @@ typedef struct HIDMouseState {
     int mouse_grabbed;
 } HIDMouseState;
 
+typedef struct HIDPollTrigger {
+    KeyValue key;
+    bool down;
+} HIDPollTrigger;
+
 typedef struct HIDKeyboardState {
     uint32_t keycodes[QUEUE_LENGTH];
+    HIDPollTrigger *poll_trigger[QUEUE_LENGTH];
     uint16_t modifiers;
     uint8_t leds;
     uint8_t key[16];
-- 
1.8.5.6
