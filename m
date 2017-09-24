Received: from eggs.gnu.org ([2001:4830:134:3::10]:57150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dw8Cb-0002gb-E8
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 10:48:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dw8Ca-0002H1-DD
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 10:48:13 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 24 Sep 2017 15:47:41 +0100
Message-Id: <1506264466-28252-3-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1506264466-28252-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1506264466-28252-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 2/7] mac_dbdma: QOMify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/macio/mac_dbdma.c  |   59 ++++++++++++++++++++++++++++++++++++--------
 include/hw/ppc/mac_dbdma.h |    6 +++++
 2 files changed, 55 insertions(+), 10 deletions(-)

diff --git a/hw/misc/macio/mac_dbdma.c b/hw/misc/macio/mac_dbdma.c
index 9795172..302f131 100644
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
index 21bd66f..4bc6274 100644
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
1.7.10.4
