Received: from eggs.gnu.org ([2001:4830:134:3::10]:47301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d69fG-0005CL-3x
	for qemu-devel@nongnu.org; Thu, 04 May 2017 01:50:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d69fD-0005Ql-O6
	for qemu-devel@nongnu.org; Thu, 04 May 2017 01:50:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d69fD-0005QN-Hv
	for qemu-devel@nongnu.org; Thu, 04 May 2017 01:50:55 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  4 May 2017 07:50:40 +0200
Message-Id: <20170504055040.31904-4-kraxel@redhat.com>
In-Reply-To: <20170504055040.31904-1-kraxel@redhat.com>
References: <20170504055040.31904-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 3/3] input: Add trace event for empty keyboard
 queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>

From: Alexander Graf <agraf@suse.de>

When driving QEMU from the outside, we have basically no chance to
determine how quickly the guest OS picks up key events, so we usually
have to limit ourselves to very slow keyboard presses to make sure
the guest always has enough chance to pick them up.

This patch adds a trace events when the keyboarde queue is drained.
An external driver can use that as hint that new keys can be pressed.

Signed-off-by: Alexander Graf <agraf@suse.de>
Message-id: 1490883775-94658-1-git-send-email-agraf@suse.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/input/hid.c        | 4 ++++
 hw/input/trace-events | 1 +
 2 files changed, 5 insertions(+)

diff --git a/hw/input/hid.c b/hw/input/hid.c
index fa9cc4c616..93887ecc43 100644
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
index f3bfbede5c..5a87818b49 100644
--- a/hw/input/trace-events
+++ b/hw/input/trace-events
@@ -24,6 +24,7 @@ milkymist_softusb_pulse_irq(void) "Pulse IRQ"
 
 # hw/input/hid.c
 hid_kbd_queue_full(void) "queue full"
+hid_kbd_queue_empty(void) "queue empty"
 
 # hw/input/virtio
 virtio_input_queue_full(void) "queue full"
-- 
2.9.3
