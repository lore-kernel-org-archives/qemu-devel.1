Received: from eggs.gnu.org ([2001:4830:134:3::10]:56932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70W-0001cq-Ad
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70U-0004DZ-4R
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:48 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 27 Sep 2017 17:43:14 +1000
Message-Id: <20170927074316.4454-25-david@gibson.dropbear.id.au>
In-Reply-To: <20170927074316.4454-1-david@gibson.dropbear.id.au>
References: <20170927074316.4454-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 24/26] mac_dbdma: remove DBDMA_init() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, mark.cave-ayland@ilande.co.uk, balaton@eik.bme.hu, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Instead we can now instantiate the MAC_DBDMA object directly within the
macio device. We also add the DBDMA device as a child property so that
it is possible to retrieve later.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/misc/macio/mac_dbdma.c  | 14 --------------
 hw/misc/macio/macio.c      | 16 ++++++++++++----
 include/hw/ppc/mac_dbdma.h |  1 -
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/hw/misc/macio/mac_dbdma.c b/hw/misc/macio/mac_dbdma.c
index 302f131c0e..0eddf2e700 100644
--- a/hw/misc/macio/mac_dbdma.c
+++ b/hw/misc/macio/mac_dbdma.c
@@ -886,20 +886,6 @@ static void dbdma_unassigned_flush(DBDMA_io *io)
                   __func__, ch->channel);
 }
 
-void* DBDMA_init (MemoryRegion **dbdma_mem)
-{
-    DBDMAState *s;
-    SysBusDevice *sbd;
-
-    s = MAC_DBDMA(object_new(TYPE_MAC_DBDMA));
-    object_property_set_bool(OBJECT(s), true, "realized", NULL);
-
-    sbd = SYS_BUS_DEVICE(s);
-    *dbdma_mem = sysbus_mmio_get_region(sbd, 0);
-
-    return s;
-}
-
 static void mac_dbdma_init(Object *obj)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 5d57f45dc6..f459f17f2f 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -41,7 +41,7 @@ typedef struct MacIOState
 
     MemoryRegion bar;
     CUDAState cuda;
-    void *dbdma;
+    DBDMAState *dbdma;
     MemoryRegion *pic_mem;
     MemoryRegion *escc_mem;
     uint64_t frequency;
@@ -127,10 +127,15 @@ static void macio_common_realize(PCIDevice *d, Error **errp)
     MacIOState *s = MACIO(d);
     SysBusDevice *sysbus_dev;
     Error *err = NULL;
-    MemoryRegion *dbdma_mem;
 
-    s->dbdma = DBDMA_init(&dbdma_mem);
-    memory_region_add_subregion(&s->bar, 0x08000, dbdma_mem);
+    object_property_set_bool(OBJECT(s->dbdma), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_dev = SYS_BUS_DEVICE(s->dbdma);
+    memory_region_add_subregion(&s->bar, 0x08000,
+                                sysbus_mmio_get_region(sysbus_dev, 0));
 
     object_property_set_bool(OBJECT(&s->cuda), true, "realized", &err);
     if (err) {
@@ -334,6 +339,9 @@ static void macio_instance_init(Object *obj)
     object_initialize(&s->cuda, sizeof(s->cuda), TYPE_CUDA);
     qdev_set_parent_bus(DEVICE(&s->cuda), sysbus_get_default());
     object_property_add_child(obj, "cuda", OBJECT(&s->cuda), NULL);
+
+    s->dbdma = MAC_DBDMA(object_new(TYPE_MAC_DBDMA));
+    object_property_add_child(obj, "dbdma", OBJECT(s->dbdma), NULL);
 }
 
 static const VMStateDescription vmstate_macio_oldworld = {
diff --git a/include/hw/ppc/mac_dbdma.h b/include/hw/ppc/mac_dbdma.h
index 4bc6274656..26cc469de4 100644
--- a/include/hw/ppc/mac_dbdma.h
+++ b/include/hw/ppc/mac_dbdma.h
@@ -174,7 +174,6 @@ void DBDMA_register_channel(void *dbdma, int nchan, qemu_irq irq,
                             DBDMA_rw rw, DBDMA_flush flush,
                             void *opaque);
 void DBDMA_kick(DBDMAState *dbdma);
-void* DBDMA_init (MemoryRegion **dbdma_mem);
 
 #define TYPE_MAC_DBDMA "mac-dbdma"
 #define MAC_DBDMA(obj) OBJECT_CHECK(DBDMAState, (obj), TYPE_MAC_DBDMA)
-- 
2.13.5
