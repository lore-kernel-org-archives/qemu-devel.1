Received: from eggs.gnu.org ([2001:4830:134:3::10]:57156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dw8Cb-0002gv-Lq
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 10:48:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dw8Ca-0002HU-LY
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 10:48:13 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 24 Sep 2017 15:47:43 +0100
Message-Id: <1506264466-28252-5-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1506264466-28252-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1506264466-28252-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 4/7] macio: pass channel into MACIOIDEState via
 qdev property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

One of the reasons macio_ide_register_dma() needs to exist is because the
channel id isn't passed into the MACIO_IDE object. Pass in the channel id
using a qdev property to remove this requirement.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ide/macio.c        |   10 ++++++++--
 hw/misc/macio/macio.c |    4 +++-
 hw/ppc/mac.h          |    4 ++--
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index 18ae952..19d5f5a 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -452,12 +452,18 @@ static void macio_ide_initfn(Object *obj)
     s->ide_irq = qemu_allocate_irq(pmac_ide_irq, s, 1);
 }
 
+static Property macio_ide_properties[] = {
+    DEFINE_PROP_UINT32("channel", MACIOIDEState, channel, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void macio_ide_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = macio_ide_realizefn;
     dc->reset = macio_ide_reset;
+    dc->props = macio_ide_properties;
     dc->vmsd = &vmstate_pmac;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
@@ -487,10 +493,10 @@ void macio_ide_init_drives(MACIOIDEState *s, DriveInfo **hd_table)
     }
 }
 
-void macio_ide_register_dma(MACIOIDEState *s, void *dbdma, int channel)
+void macio_ide_register_dma(MACIOIDEState *s, void *dbdma)
 {
     s->dbdma = dbdma;
-    DBDMA_register_channel(dbdma, channel, s->dma_irq,
+    DBDMA_register_channel(dbdma, s->channel, s->dma_irq,
                            pmac_ide_transfer, pmac_ide_flush, s);
 }
 
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index f459f17..41b377e 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -159,7 +159,9 @@ static void macio_realize_ide(MacIOState *s, MACIOIDEState *ide,
     sysbus_dev = SYS_BUS_DEVICE(ide);
     sysbus_connect_irq(sysbus_dev, 0, irq0);
     sysbus_connect_irq(sysbus_dev, 1, irq1);
-    macio_ide_register_dma(ide, s->dbdma, dmaid);
+    qdev_prop_set_uint32(DEVICE(ide), "channel", dmaid);
+    macio_ide_register_dma(ide, s->dbdma);
+
     object_property_set_bool(OBJECT(ide), true, "realized", errp);
 }
 
diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index 300fc8a..b3a26c4 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -131,7 +131,7 @@ typedef struct MACIOIDEState {
     /*< private >*/
     SysBusDevice parent_obj;
     /*< public >*/
-
+    uint32_t channel;
     qemu_irq real_ide_irq;
     qemu_irq real_dma_irq;
     qemu_irq ide_irq;
@@ -147,7 +147,7 @@ typedef struct MACIOIDEState {
 } MACIOIDEState;
 
 void macio_ide_init_drives(MACIOIDEState *ide, DriveInfo **hd_table);
-void macio_ide_register_dma(MACIOIDEState *ide, void *dbdma, int channel);
+void macio_ide_register_dma(MACIOIDEState *ide, void *dbdma);
 
 void macio_init(PCIDevice *dev,
                 MemoryRegion *pic_mem,
-- 
1.7.10.4
