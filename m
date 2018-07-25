Received: from eggs.gnu.org ([2001:4830:134:3::10]:39631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fiIik-0003F6-0B
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:16:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fiIig-0006co-W1
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:16:45 -0400
Received: from mail.ispras.ru ([83.149.199.45]:36876)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fiIig-0006bG-Le
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:16:42 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Wed, 25 Jul 2018 15:16:43 +0300
Message-ID: <20180725121643.12867.61576.stgit@pasha-VirtualBox>
In-Reply-To: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
References: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v5 20/24] ps2: prevent changing irq state on
 save and load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, thomas.dullien@googlemail.com, pbonzini@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

Commit 2858ab09e6f708e381fc1a1cc87e747a690c4884 changed
PS/2 keyboard/mouse buffers to the standard size. However, its state
may change when migrating from the old buffer size and therefore irq needs
updating. But this change made wrong, because it throws the whole queue
if there are too much data instead of cropping it.

That commit also updates irq (because the queue state may change).
But updating the irq may change the VM state (and determinism of
the execution). E.g., when replaying the execution, one may save
the VM state and the state of the interrupt controller will be updated
at the moment of saving, instead of using the recorded update events.

This patch makes the queue update deterministic: it removes the update_irq
call and crops the queue to prevent losing the characters and changing
the required irq status.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 hw/input/ps2.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index fdfcadf..6c43fc2 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -914,7 +914,12 @@ static void ps2_common_post_load(PS2State *s)
     uint8_t tmp_data[PS2_QUEUE_SIZE];
 
     /* set the useful data buffer queue size, < PS2_QUEUE_SIZE */
-    size = (q->count < 0 || q->count > PS2_QUEUE_SIZE) ? 0 : q->count;
+    size = q->count;
+    if (q->count < 0) {
+        size = 0;
+    } else if (q->count > PS2_QUEUE_SIZE) {
+        size = PS2_QUEUE_SIZE;
+    }
 
     /* move the queue elements to the start of data array */
     for (i = 0; i < size; i++) {
@@ -929,7 +934,6 @@ static void ps2_common_post_load(PS2State *s)
     q->rptr = 0;
     q->wptr = (size == PS2_QUEUE_SIZE) ? 0 : size;
     q->count = size;
-    s->update_irq(s->update_arg, q->count != 0);
 }
 
 static void ps2_kbd_reset(void *opaque)
