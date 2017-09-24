Received: from eggs.gnu.org ([2001:4830:134:3::10]:57215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dw8Ce-0002jU-88
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 10:48:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dw8Cd-0002K8-9a
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 10:48:16 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 24 Sep 2017 15:47:45 +0100
Message-Id: <1506264466-28252-7-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1506264466-28252-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1506264466-28252-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 6/7] mac_dbdma: change DBDMA_register_channel
 to a MAC_DBDMA type method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

Using this we can change the MACIO_IDE instance to register the channel
itself via a type method instead of requiring a separate
DBDMA_register_channel() function.

As a consequence of this it is now possible to remove the old external
macio_ide_register_dma() function.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ide/macio.c             |   12 ++++++------
 hw/misc/macio/mac_dbdma.c  |    9 +++++----
 hw/misc/macio/macio.c      |    1 -
 include/hw/ppc/mac_dbdma.h |    9 ++++-----
 4 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index ce194c6..b296017 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -411,12 +411,18 @@ static const IDEDMAOps dbdma_ops = {
 static void macio_ide_realizefn(DeviceState *dev, Error **errp)
 {
     MACIOIDEState *s = MACIO_IDE(dev);
+    DBDMAState *dbdma;
 
     ide_init2(&s->bus, s->ide_irq);
 
     /* Register DMA callbacks */
     s->dma.ops = &dbdma_ops;
     s->bus.dma = &s->dma;
+
+    /* Register DBDMA channel */
+    dbdma = MAC_DBDMA(object_property_get_link(OBJECT(dev), "dbdma", errp));
+    dbdma->register_channel(dbdma, s->channel, s->dma_irq,
+                            pmac_ide_transfer, pmac_ide_flush, s);
 }
 
 static void pmac_ide_irq(void *opaque, int n, int level)
@@ -497,10 +503,4 @@ void macio_ide_init_drives(MACIOIDEState *s, DriveInfo **hd_table)
     }
 }
 
-void macio_ide_register_dma(MACIOIDEState *s)
-{
-    DBDMA_register_channel(s->dbdma, s->channel, s->dma_irq,
-                           pmac_ide_transfer, pmac_ide_flush, s);
-}
-
 type_init(macio_ide_register_types)
diff --git a/hw/misc/macio/mac_dbdma.c b/hw/misc/macio/mac_dbdma.c
index 0eddf2e..addb97d 100644
--- a/hw/misc/macio/mac_dbdma.c
+++ b/hw/misc/macio/mac_dbdma.c
@@ -557,11 +557,10 @@ void DBDMA_kick(DBDMAState *dbdma)
     qemu_bh_schedule(dbdma->bh);
 }
 
-void DBDMA_register_channel(void *dbdma, int nchan, qemu_irq irq,
-                            DBDMA_rw rw, DBDMA_flush flush,
-                            void *opaque)
+static void
+dbdma_register_channel(DBDMAState *s, int nchan, qemu_irq irq,
+                       DBDMA_rw rw, DBDMA_flush flush, void *opaque)
 {
-    DBDMAState *s = dbdma;
     DBDMA_channel *ch = &s->channels[nchan];
 
     DBDMA_DPRINTFCH(ch, "DBDMA_register_channel 0x%x\n", nchan);
@@ -903,6 +902,8 @@ static void mac_dbdma_init(Object *obj)
 
     memory_region_init_io(&s->mem, obj, &dbdma_ops, s, "dbdma", 0x1000);
     sysbus_init_mmio(sbd, &s->mem);
+
+    s->register_channel = dbdma_register_channel;
 }
 
 static void mac_dbdma_realize(DeviceState *dev, Error **errp)
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 9aa7e75..533331a 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -161,7 +161,6 @@ static void macio_realize_ide(MacIOState *s, MACIOIDEState *ide,
     sysbus_connect_irq(sysbus_dev, 1, irq1);
     qdev_prop_set_uint32(DEVICE(ide), "channel", dmaid);
     object_property_set_link(OBJECT(ide), OBJECT(s->dbdma), "dbdma", errp);
-    macio_ide_register_dma(ide);
 
     object_property_set_bool(OBJECT(ide), true, "realized", errp);
 }
diff --git a/include/hw/ppc/mac_dbdma.h b/include/hw/ppc/mac_dbdma.h
index 26cc469..d6a38c5 100644
--- a/include/hw/ppc/mac_dbdma.h
+++ b/include/hw/ppc/mac_dbdma.h
@@ -160,19 +160,18 @@ typedef struct DBDMA_channel {
     dbdma_cmd current;
 } DBDMA_channel;
 
-typedef struct {
+typedef struct DBDMAState {
     SysBusDevice parent_obj;
 
     MemoryRegion mem;
     DBDMA_channel channels[DBDMA_CHANNELS];
     QEMUBH *bh;
+
+    void (*register_channel)(struct DBDMAState *s, int nchan, qemu_irq irq,
+                             DBDMA_rw rw, DBDMA_flush flush, void *opaque);
 } DBDMAState;
 
 /* Externally callable functions */
-
-void DBDMA_register_channel(void *dbdma, int nchan, qemu_irq irq,
-                            DBDMA_rw rw, DBDMA_flush flush,
-                            void *opaque);
 void DBDMA_kick(DBDMAState *dbdma);
 
 #define TYPE_MAC_DBDMA "mac-dbdma"
-- 
1.7.10.4
