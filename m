Received: from eggs.gnu.org ([2001:4830:134:3::10]:41525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1epFFK-0004aH-MD
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:26:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1epFFJ-0005VH-K6
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:26:50 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 23 Feb 2018 16:26:37 +0100
Message-Id: <20180223152640.11459-3-pbonzini@redhat.com>
In-Reply-To: <20180223152640.11459-1-pbonzini@redhat.com>
References: <20180223152640.11459-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/5] ide: push end_transfer callback to
 ide_transfer_halt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, Peter Lieven <pl@kamp.de>, Kevin Wolf <kwolf@redhat.com>

The callback must be invoked once we get out of the DRQ phase; because
all end_transfer_funcs end up invoking ide_transfer_stop, call it there.
While at it, remove the "notify" argument from ide_transfer_halt; the
code can simply be moved to ide_transfer_stop.

Old PATA controllers have no end_transfer callback, so there is no change
there.  For AHCI the end_transfer_func already called ide_transfer_stop
so the effect is that the PIO FIS is written before the D2H FIS rather
than after, which is arguably an improvement.

However, ahci_end_transfer is now called _after_ the DRQ_STAT has been
cleared, so remove the status check in ahci_end_transfer; it was only
there to ensure the FIS was not written more than once, and this cannot
happen anymore.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ide/ahci.c |  7 ++-----
 hw/ide/core.c | 15 +++++++--------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 937bad55fb..c3c6843b76 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1326,12 +1326,9 @@ out:
 static void ahci_end_transfer(IDEDMA *dma)
 {
     AHCIDevice *ad = DO_UPCAST(AHCIDevice, dma, dma);
-    IDEState *s = &ad->port.ifs[0];
 
-    if (!(s->status & DRQ_STAT)) {
-        /* done with PIO send/receive */
-        ahci_write_fis_pio(ad, le32_to_cpu(ad->cur_cmd->status));
-    }
+    /* done with PIO send/receive */
+    ahci_write_fis_pio(ad, le32_to_cpu(ad->cur_cmd->status));
 }
 
 static void ahci_start_dma(IDEDMA *dma, IDEState *s,
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 92f4424dc3..c4710a6f55 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -544,7 +544,6 @@ void ide_transfer_start(IDEState *s, uint8_t *buf, int size,
     }
     s->bus->dma->ops->start_transfer(s->bus->dma);
     end_transfer_func(s);
-    s->bus->dma->ops->end_transfer(s->bus->dma);
 }
 
 static void ide_cmd_done(IDEState *s)
@@ -555,26 +554,26 @@ static void ide_cmd_done(IDEState *s)
 }
 
 static void ide_transfer_halt(IDEState *s,
-                              void(*end_transfer_func)(IDEState *),
-                              bool notify)
+                              void(*end_transfer_func)(IDEState *))
 {
     s->end_transfer_func = end_transfer_func;
     s->data_ptr = s->io_buffer;
     s->data_end = s->io_buffer;
     s->status &= ~DRQ_STAT;
-    if (notify) {
-        ide_cmd_done(s);
-    }
 }
 
 void ide_transfer_stop(IDEState *s)
 {
-    ide_transfer_halt(s, ide_transfer_stop, true);
+    ide_transfer_halt(s, ide_transfer_stop);
+    if (s->bus->dma->ops->end_transfer) {
+        s->bus->dma->ops->end_transfer(s->bus->dma);
+    }
+    ide_cmd_done(s);
 }
 
 static void ide_transfer_cancel(IDEState *s)
 {
-    ide_transfer_halt(s, ide_transfer_cancel, false);
+    ide_transfer_halt(s, ide_transfer_cancel);
 }
 
 int64_t ide_get_sector(IDEState *s)
-- 
2.14.3
