Received: from eggs.gnu.org ([2001:4830:134:3::10]:57157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dw8Cb-0002gw-M1
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 10:48:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dw8Ca-0002HK-IX
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 10:48:13 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 24 Sep 2017 15:47:46 +0100
Message-Id: <1506264466-28252-8-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1506264466-28252-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1506264466-28252-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 7/7] mac_dbdma: change DBDMA_kick to a
 MAC_DBDMA type method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

With this we can now remove the last external method used to interface
between macio and DBDMA.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ide/macio.c             |    3 ++-
 hw/misc/macio/mac_dbdma.c  |   19 ++++++++++---------
 include/hw/ppc/mac_dbdma.h |    4 +---
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index b296017..6f7f286 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -384,6 +384,7 @@ static void ide_dbdma_start(IDEDMA *dma, IDEState *s,
                             BlockCompletionFunc *cb)
 {
     MACIOIDEState *m = container_of(dma, MACIOIDEState, dma);
+    DBDMAState *dbdma = (DBDMAState *)m->dbdma;
 
     s->io_buffer_index = 0;
     if (s->drive_kind == IDE_CD) {
@@ -399,7 +400,7 @@ static void ide_dbdma_start(IDEDMA *dma, IDEState *s,
     MACIO_DPRINTF("-------------------------\n");
 
     m->dma_active = true;
-    DBDMA_kick(m->dbdma);
+    dbdma->kick(dbdma);
 }
 
 static const IDEDMAOps dbdma_ops = {
diff --git a/hw/misc/macio/mac_dbdma.c b/hw/misc/macio/mac_dbdma.c
index addb97d..f8375db 100644
--- a/hw/misc/macio/mac_dbdma.c
+++ b/hw/misc/macio/mac_dbdma.c
@@ -301,6 +301,11 @@ wait:
         channel_run(ch);
 }
 
+static void dbdma_kick(DBDMAState *dbdma)
+{
+    qemu_bh_schedule(dbdma->bh);
+}
+
 static void start_output(DBDMA_channel *ch, int key, uint32_t addr,
                         uint16_t req_count, int is_last)
 {
@@ -381,7 +386,7 @@ static void load_word(DBDMA_channel *ch, int key, uint32_t addr,
     next(ch);
 
 wait:
-    DBDMA_kick(dbdma_from_ch(ch));
+    dbdma_kick(dbdma_from_ch(ch));
 }
 
 static void store_word(DBDMA_channel *ch, int key, uint32_t addr,
@@ -413,7 +418,7 @@ static void store_word(DBDMA_channel *ch, int key, uint32_t addr,
     next(ch);
 
 wait:
-    DBDMA_kick(dbdma_from_ch(ch));
+    dbdma_kick(dbdma_from_ch(ch));
 }
 
 static void nop(DBDMA_channel *ch)
@@ -430,7 +435,7 @@ static void nop(DBDMA_channel *ch)
     conditional_branch(ch);
 
 wait:
-    DBDMA_kick(dbdma_from_ch(ch));
+    dbdma_kick(dbdma_from_ch(ch));
 }
 
 static void stop(DBDMA_channel *ch)
@@ -552,11 +557,6 @@ static void DBDMA_run_bh(void *opaque)
     DBDMA_DPRINTF("<- DBDMA_run_bh\n");
 }
 
-void DBDMA_kick(DBDMAState *dbdma)
-{
-    qemu_bh_schedule(dbdma->bh);
-}
-
 static void
 dbdma_register_channel(DBDMAState *s, int nchan, qemu_irq irq,
                        DBDMA_rw rw, DBDMA_flush flush, void *opaque)
@@ -686,7 +686,7 @@ static void dbdma_control_write(DBDMA_channel *ch)
 
     /* If active, make sure the BH gets to run */
     if (status & ACTIVE) {
-        DBDMA_kick(dbdma_from_ch(ch));
+        dbdma_kick(dbdma_from_ch(ch));
     }
 }
 
@@ -904,6 +904,7 @@ static void mac_dbdma_init(Object *obj)
     sysbus_init_mmio(sbd, &s->mem);
 
     s->register_channel = dbdma_register_channel;
+    s->kick = dbdma_kick;
 }
 
 static void mac_dbdma_realize(DeviceState *dev, Error **errp)
diff --git a/include/hw/ppc/mac_dbdma.h b/include/hw/ppc/mac_dbdma.h
index d6a38c5..a30f8d8 100644
--- a/include/hw/ppc/mac_dbdma.h
+++ b/include/hw/ppc/mac_dbdma.h
@@ -169,11 +169,9 @@ typedef struct DBDMAState {
 
     void (*register_channel)(struct DBDMAState *s, int nchan, qemu_irq irq,
                              DBDMA_rw rw, DBDMA_flush flush, void *opaque);
+    void (*kick)(struct DBDMAState *s);
 } DBDMAState;
 
-/* Externally callable functions */
-void DBDMA_kick(DBDMAState *dbdma);
-
 #define TYPE_MAC_DBDMA "mac-dbdma"
 #define MAC_DBDMA(obj) OBJECT_CHECK(DBDMAState, (obj), TYPE_MAC_DBDMA)
 
-- 
1.7.10.4
