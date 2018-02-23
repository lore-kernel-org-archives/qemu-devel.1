Received: from eggs.gnu.org ([2001:4830:134:3::10]:41530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1epFFK-0004aM-PI
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:26:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1epFFJ-0005VQ-Mw
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:26:50 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 23 Feb 2018 16:26:36 +0100
Message-Id: <20180223152640.11459-2-pbonzini@redhat.com>
In-Reply-To: <20180223152640.11459-1-pbonzini@redhat.com>
References: <20180223152640.11459-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] ide: push call to end_transfer_func out of
 start_transfer callback
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

Split the PIO transfer across two callbacks, thus pushing the (possibly
recursive) call to end_transfer_func up one level and out of the
AHCI-specific code.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ide/ahci.c             | 7 ++++++-
 hw/ide/core.c             | 9 ++++++---
 include/hw/ide/internal.h | 1 +
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index e22d7be05f..937bad55fb 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1321,8 +1321,12 @@ out:
 
     /* Update number of transferred bytes, destroy sglist */
     dma_buf_commit(s, size);
+}
 
-    s->end_transfer_func(s);
+static void ahci_end_transfer(IDEDMA *dma)
+{
+    AHCIDevice *ad = DO_UPCAST(AHCIDevice, dma, dma);
+    IDEState *s = &ad->port.ifs[0];
 
     if (!(s->status & DRQ_STAT)) {
         /* done with PIO send/receive */
@@ -1444,6 +1448,7 @@ static const IDEDMAOps ahci_dma_ops = {
     .restart = ahci_restart,
     .restart_dma = ahci_restart_dma,
     .start_transfer = ahci_start_transfer,
+    .end_transfer = ahci_end_transfer,
     .prepare_buf = ahci_dma_prepare_buf,
     .commit_buf = ahci_commit_buf,
     .rw_buf = ahci_dma_rw_buf,
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 257b429381..92f4424dc3 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -532,16 +532,19 @@ static void ide_clear_retry(IDEState *s)
 void ide_transfer_start(IDEState *s, uint8_t *buf, int size,
                         EndTransferFunc *end_transfer_func)
 {
-    s->end_transfer_func = end_transfer_func;
     s->data_ptr = buf;
     s->data_end = buf + size;
     ide_set_retry(s);
     if (!(s->status & ERR_STAT)) {
         s->status |= DRQ_STAT;
     }
-    if (s->bus->dma->ops->start_transfer) {
-        s->bus->dma->ops->start_transfer(s->bus->dma);
+    if (!s->bus->dma->ops->start_transfer) {
+        s->end_transfer_func = end_transfer_func;
+        return;
     }
+    s->bus->dma->ops->start_transfer(s->bus->dma);
+    end_transfer_func(s);
+    s->bus->dma->ops->end_transfer(s->bus->dma);
 }
 
 static void ide_cmd_done(IDEState *s)
diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 88212f59df..efaabbd815 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -445,6 +445,7 @@ struct IDEState {
 struct IDEDMAOps {
     DMAStartFunc *start_dma;
     DMAVoidFunc *start_transfer;
+    DMAVoidFunc *end_transfer;
     DMAInt32Func *prepare_buf;
     DMAu32Func *commit_buf;
     DMAIntFunc *rw_buf;
-- 
2.14.3
