Received: from eggs.gnu.org ([2001:4830:134:3::10]:50610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1ctayF-000806-RJ
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:22:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1ctayC-0003FX-HO
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:22:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:36840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1ctayC-0003F0-BZ
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:22:36 -0400
From: Alexander Graf <agraf@suse.de>
Date: Thu, 30 Mar 2017 16:22:55 +0200
Message-Id: <1490883775-94658-1-git-send-email-agraf@suse.de>
Subject: [Qemu-devel] [PATCH] input: Add trace event for empty keyboard queue
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

This patch adds a trace events when the keyboarde queue is drained.
An external driver can use that as hint that new keys can be pressed.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 hw/input/hid.c        | 4 ++++
 hw/input/trace-events | 1 +
 2 files changed, 5 insertions(+)

diff --git a/hw/input/hid.c b/hw/input/hid.c
index fa9cc4c..93887ec 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -256,6 +256,10 @@ static void hid_keyboard_process_keycode(HIDState *hs)
     slot = hs->head & QUEUE_MASK; QUEUE_INCR(hs->head); hs->n--;
     keycode = hs->kbd.keycodes[slot];
 
+    if (!hs->n) {
+        trace_hid_kbd_queue_empty();
+    }
+
     key = keycode & 0x7f;
     index = key | ((hs->kbd.modifiers & (1 << 8)) >> 1);
     hid_code = hid_usage_keys[index];
diff --git a/hw/input/trace-events b/hw/input/trace-events
index f3bfbed..5a87818 100644
--- a/hw/input/trace-events
+++ b/hw/input/trace-events
@@ -24,6 +24,7 @@ milkymist_softusb_pulse_irq(void) "Pulse IRQ"
 
 # hw/input/hid.c
 hid_kbd_queue_full(void) "queue full"
+hid_kbd_queue_empty(void) "queue empty"
 
 # hw/input/virtio
 virtio_input_queue_full(void) "queue full"
-- 
1.8.5.6
