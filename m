Received: from eggs.gnu.org ([2001:4830:134:3::10]:36480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eoCrt-000544-On
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:42:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eoCrr-0000TU-Jq
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:42:21 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue, 20 Feb 2018 18:41:49 +0000
Message-Id: <20180220184159.16483-2-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180220184159.16483-1-mark.cave-ayland@ilande.co.uk>
References: <20180220184159.16483-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv2 01/11] macio: embed DBDMA device directly
 within macio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

The current recommendation is to embed subdevices directly within their container
device, so do this for the DBDMA device.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/macio/macio.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 024f8557ab..7174135c8b 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -42,7 +42,7 @@ typedef struct MacIOState
 
     MemoryRegion bar;
     CUDAState cuda;
-    DBDMAState *dbdma;
+    DBDMAState dbdma;
     MemoryRegion *pic_mem;
     MemoryRegion *escc_mem;
     uint64_t frequency;
@@ -129,12 +129,12 @@ static void macio_common_realize(PCIDevice *d, Error **errp)
     SysBusDevice *sysbus_dev;
     Error *err = NULL;
 
-    object_property_set_bool(OBJECT(s->dbdma), true, "realized", &err);
+    object_property_set_bool(OBJECT(&s->dbdma), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
         return;
     }
-    sysbus_dev = SYS_BUS_DEVICE(s->dbdma);
+    sysbus_dev = SYS_BUS_DEVICE(&s->dbdma);
     memory_region_add_subregion(&s->bar, 0x08000,
                                 sysbus_mmio_get_region(sysbus_dev, 0));
 
@@ -161,7 +161,7 @@ static void macio_realize_ide(MacIOState *s, MACIOIDEState *ide,
     sysbus_connect_irq(sysbus_dev, 0, irq0);
     sysbus_connect_irq(sysbus_dev, 1, irq1);
     qdev_prop_set_uint32(DEVICE(ide), "channel", dmaid);
-    object_property_set_link(OBJECT(ide), OBJECT(s->dbdma), "dbdma", errp);
+    object_property_set_link(OBJECT(ide), OBJECT(&s->dbdma), "dbdma", errp);
     macio_ide_register_dma(ide);
 
     object_property_set_bool(OBJECT(ide), true, "realized", errp);
@@ -344,8 +344,9 @@ static void macio_instance_init(Object *obj)
     qdev_set_parent_bus(DEVICE(&s->cuda), sysbus_get_default());
     object_property_add_child(obj, "cuda", OBJECT(&s->cuda), NULL);
 
-    s->dbdma = MAC_DBDMA(object_new(TYPE_MAC_DBDMA));
-    object_property_add_child(obj, "dbdma", OBJECT(s->dbdma), NULL);
+    object_initialize(&s->dbdma, sizeof(s->dbdma), TYPE_MAC_DBDMA);
+    qdev_set_parent_bus(DEVICE(&s->dbdma), sysbus_get_default());
+    object_property_add_child(obj, "dbdma", OBJECT(&s->dbdma), NULL);
 }
 
 static const VMStateDescription vmstate_macio_oldworld = {
-- 
2.11.0
