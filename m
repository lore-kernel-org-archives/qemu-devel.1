Received: from eggs.gnu.org ([2001:4830:134:3::10]:56842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70U-0001a6-5k
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70R-0004BM-LM
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:46 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 27 Sep 2017 17:43:13 +1000
Message-Id: <20170927074316.4454-24-david@gibson.dropbear.id.au>
In-Reply-To: <20170927074316.4454-1-david@gibson.dropbear.id.au>
References: <20170927074316.4454-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 23/26] mac_dbdma: QOMify
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

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/misc/macio/mac_dbdma.c  | 59 ++++++++++++++++++++++++++++++++++++++--------
 include/hw/ppc/mac_dbdma.h |  6 +++++
 2 files changed, 55 insertions(+), 10 deletions(-)

diff --git a/hw/misc/macio/mac_dbdma.c b/hw/misc/macio/mac_dbdma.c
index 979517263f..302f131c0e 100644
--- a/hw/misc/macio/mac_dbdma.c
+++ b/hw/misc/macio/mac_dbdma.c
@@ -851,13 +851,14 @@ static const VMStateDescription vmstate_dbdma = {
     }
 };
 
-static void dbdma_reset(void *opaque)
+static void mac_dbdma_reset(DeviceState *d)
 {
-    DBDMAState *s = opaque;
+    DBDMAState *s = MAC_DBDMA(d);
     int i;
 
-    for (i = 0; i < DBDMA_CHANNELS; i++)
+    for (i = 0; i < DBDMA_CHANNELS; i++) {
         memset(s->channels[i].regs, 0, DBDMA_SIZE);
+    }
 }
 
 static void dbdma_unassigned_rw(DBDMA_io *io)
@@ -888,9 +889,22 @@ static void dbdma_unassigned_flush(DBDMA_io *io)
 void* DBDMA_init (MemoryRegion **dbdma_mem)
 {
     DBDMAState *s;
-    int i;
+    SysBusDevice *sbd;
+
+    s = MAC_DBDMA(object_new(TYPE_MAC_DBDMA));
+    object_property_set_bool(OBJECT(s), true, "realized", NULL);
+
+    sbd = SYS_BUS_DEVICE(s);
+    *dbdma_mem = sysbus_mmio_get_region(sbd, 0);
 
-    s = g_malloc0(sizeof(DBDMAState));
+    return s;
+}
+
+static void mac_dbdma_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    DBDMAState *s = MAC_DBDMA(obj);
+    int i;
 
     for (i = 0; i < DBDMA_CHANNELS; i++) {
         DBDMA_channel *ch = &s->channels[i];
@@ -901,12 +915,37 @@ void* DBDMA_init (MemoryRegion **dbdma_mem)
         ch->io.channel = ch;
     }
 
-    memory_region_init_io(&s->mem, NULL, &dbdma_ops, s, "dbdma", 0x1000);
-    *dbdma_mem = &s->mem;
-    vmstate_register(NULL, -1, &vmstate_dbdma, s);
-    qemu_register_reset(dbdma_reset, s);
+    memory_region_init_io(&s->mem, obj, &dbdma_ops, s, "dbdma", 0x1000);
+    sysbus_init_mmio(sbd, &s->mem);
+}
+
+static void mac_dbdma_realize(DeviceState *dev, Error **errp)
+{
+    DBDMAState *s = MAC_DBDMA(dev);
 
     s->bh = qemu_bh_new(DBDMA_run_bh, s);
+}
 
-    return s;
+static void mac_dbdma_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = mac_dbdma_realize;
+    dc->reset = mac_dbdma_reset;
+    dc->vmsd = &vmstate_dbdma;
 }
+
+static const TypeInfo mac_dbdma_type_info = {
+    .name = TYPE_MAC_DBDMA,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(DBDMAState),
+    .instance_init = mac_dbdma_init,
+    .class_init = mac_dbdma_class_init
+};
+
+static void mac_dbdma_register_types(void)
+{
+    type_register_static(&mac_dbdma_type_info);
+}
+
+type_init(mac_dbdma_register_types)
diff --git a/include/hw/ppc/mac_dbdma.h b/include/hw/ppc/mac_dbdma.h
index 21bd66f3c9..4bc6274656 100644
--- a/include/hw/ppc/mac_dbdma.h
+++ b/include/hw/ppc/mac_dbdma.h
@@ -26,6 +26,7 @@
 #include "exec/memory.h"
 #include "qemu/iov.h"
 #include "sysemu/dma.h"
+#include "hw/sysbus.h"
 
 typedef struct DBDMA_io DBDMA_io;
 
@@ -160,6 +161,8 @@ typedef struct DBDMA_channel {
 } DBDMA_channel;
 
 typedef struct {
+    SysBusDevice parent_obj;
+
     MemoryRegion mem;
     DBDMA_channel channels[DBDMA_CHANNELS];
     QEMUBH *bh;
@@ -173,4 +176,7 @@ void DBDMA_register_channel(void *dbdma, int nchan, qemu_irq irq,
 void DBDMA_kick(DBDMAState *dbdma);
 void* DBDMA_init (MemoryRegion **dbdma_mem);
 
+#define TYPE_MAC_DBDMA "mac-dbdma"
+#define MAC_DBDMA(obj) OBJECT_CHECK(DBDMAState, (obj), TYPE_MAC_DBDMA)
+
 #endif
-- 
2.13.5
