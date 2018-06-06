Received: from eggs.gnu.org ([2001:4830:134:3::10]:38407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fQdop-0000jU-S1
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:10:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fQdoo-0000lA-6e
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:10:03 -0400
From: John Snow <jsnow@redhat.com>
Date: Wed,  6 Jun 2018 15:09:51 -0400
Message-Id: <20180606190955.20845-4-jsnow@redhat.com>
In-Reply-To: <20180606190955.20845-1-jsnow@redhat.com>
References: <20180606190955.20845-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 3/7] ide: push end_transfer_func out of
 start_transfer callback, rename callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

Now that end_transfer_func is a tail call in ahci_start_transfer,
formalize the fact that the callback (of which ahci_start_transfer is
the sole implementation) takes care of the transfer too: rename it to
pio_transfer and, if it is present, call the end_transfer_func as soon
as it returns.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c             | 13 ++++++-------
 hw/ide/core.c             |  8 +++++---
 hw/ide/trace-events       |  2 +-
 include/hw/ide/internal.h |  2 +-
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 5871333686..89127f5fb6 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1279,8 +1279,8 @@ out:
     return 0;
 }
 
-/* DMA dev <-> ram */
-static void ahci_start_transfer(IDEDMA *dma)
+/* Transfer PIO data between RAM and device */
+static void ahci_pio_transfer(IDEDMA *dma)
 {
     AHCIDevice *ad = DO_UPCAST(AHCIDevice, dma, dma);
     IDEState *s = &ad->port.ifs[0];
@@ -1304,9 +1304,9 @@ static void ahci_start_transfer(IDEDMA *dma)
         has_sglist = 1;
     }
 
-    trace_ahci_start_transfer(ad->hba, ad->port_no, is_write ? "writ" : "read",
-                              size, is_atapi ? "atapi" : "ata",
-                              has_sglist ? "" : "o");
+    trace_ahci_pio_transfer(ad->hba, ad->port_no, is_write ? "writ" : "read",
+                            size, is_atapi ? "atapi" : "ata",
+                            has_sglist ? "" : "o");
 
     if (has_sglist && size) {
         if (is_write) {
@@ -1321,7 +1321,6 @@ static void ahci_start_transfer(IDEDMA *dma)
 out:
     /* declare that we processed everything */
     s->data_ptr = s->data_end;
-    s->end_transfer_func(s);
 }
 
 static void ahci_start_dma(IDEDMA *dma, IDEState *s,
@@ -1437,7 +1436,7 @@ static const IDEDMAOps ahci_dma_ops = {
     .start_dma = ahci_start_dma,
     .restart = ahci_restart,
     .restart_dma = ahci_restart_dma,
-    .start_transfer = ahci_start_transfer,
+    .pio_transfer = ahci_pio_transfer,
     .prepare_buf = ahci_dma_prepare_buf,
     .commit_buf = ahci_commit_buf,
     .rw_buf = ahci_dma_rw_buf,
diff --git a/hw/ide/core.c b/hw/ide/core.c
index cc9ca28c33..1a6cb337bf 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -526,16 +526,18 @@ static void ide_clear_retry(IDEState *s)
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
+    if (!s->bus->dma->ops->pio_transfer) {
+        s->end_transfer_func = end_transfer_func;
+        return;
     }
+    s->bus->dma->ops->pio_transfer(s->bus->dma);
+    end_transfer_func(s);
 }
 
 static void ide_cmd_done(IDEState *s)
diff --git a/hw/ide/trace-events b/hw/ide/trace-events
index 5c0e59ec42..153a7a62c9 100644
--- a/hw/ide/trace-events
+++ b/hw/ide/trace-events
@@ -101,7 +101,7 @@ handle_cmd_badport(void *s, int port) "ahci(%p)[%d]: guest accessed unused port"
 handle_cmd_badfis(void *s, int port) "ahci(%p)[%d]: guest provided an invalid cmd FIS"
 handle_cmd_badmap(void *s, int port, uint64_t len) "ahci(%p)[%d]: dma_memory_map failed, 0x%02"PRIx64" != 0x80"
 handle_cmd_unhandled_fis(void *s, int port, uint8_t b0, uint8_t b1, uint8_t b2) "ahci(%p)[%d]: unhandled FIS type. cmd_fis: 0x%02x-%02x-%02x"
-ahci_start_transfer(void *s, int port, const char *rw, uint32_t size, const char *tgt, const char *sgl) "ahci(%p)[%d]: %sing %d bytes on %s w/%s sglist"
+ahci_pio_transfer(void *s, int port, const char *rw, uint32_t size, const char *tgt, const char *sgl) "ahci(%p)[%d]: %sing %d bytes on %s w/%s sglist"
 ahci_start_dma(void *s, int port) "ahci(%p)[%d]: start dma"
 ahci_dma_prepare_buf(void *s, int port, int32_t io_buffer_size, int32_t limit) "ahci(%p)[%d]: prepare buf limit=%"PRId32" prepared=%"PRId32
 ahci_dma_prepare_buf_fail(void *s, int port) "ahci(%p)[%d]: sglist population failed"
diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 88212f59df..f3de6f9b73 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -444,7 +444,7 @@ struct IDEState {
 
 struct IDEDMAOps {
     DMAStartFunc *start_dma;
-    DMAVoidFunc *start_transfer;
+    DMAVoidFunc *pio_transfer;
     DMAInt32Func *prepare_buf;
     DMAu32Func *commit_buf;
     DMAIntFunc *rw_buf;
-- 
2.14.3
