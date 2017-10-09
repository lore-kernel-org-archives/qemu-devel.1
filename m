Received: from eggs.gnu.org ([2001:4830:134:3::10]:56664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e1fGu-0004Fq-PS
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 17:07:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e1fGs-0006cq-Ol
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 17:07:32 -0400
Received: from chuckie.co.uk ([82.165.15.123]:40560
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1e1fGs-0006cR-HP
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 17:07:30 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Mon,  9 Oct 2017 22:07:02 +0100
Message-Id: <1507583223-14819-8-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1507583223-14819-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1507583223-14819-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 7/8] sparc32_dma: introduce new SPARC32_DMA
 type container object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

Create a new SPARC32_DMA container object (including an appropriate container
memory region) and add instances of the SPARC32_ESPDMA_DEVICE and
SPARC32_LEDMA_DEVICE as child objects. Also update sun4m.c to resolve the
child objects accordingly.

Since the sun4m IOMMU is already QOMified we can find a reference to
it using object_resolve_path_type() allowing us to completely remove all external
references to the iommu pointer.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/dma/sparc32_dma.c           |   56 ++++++++++++++++++++++++++++++++++++++++
 hw/sparc/sun4m.c               |   18 ++++++-------
 include/hw/sparc/sparc32_dma.h |   12 +++++++++
 3 files changed, 77 insertions(+), 9 deletions(-)

diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index b817472..c7aa4a4 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -30,6 +30,7 @@
 #include "hw/sparc/sparc32_dma.h"
 #include "hw/sparc/sun4m.h"
 #include "hw/sysbus.h"
+#include "qapi/error.h"
 #include "trace.h"
 
 /*
@@ -321,11 +322,66 @@ static const TypeInfo sparc32_ledma_device_info = {
     .instance_init = sparc32_ledma_device_init,
 };
 
+static void sparc32_dma_init(Object *obj)
+{
+    SPARC32DMAState *s = SPARC32_DMA(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    memory_region_init(&s->dmamem, OBJECT(s), "dma", DMA_SIZE + DMA_ETH_SIZE);
+    sysbus_init_mmio(sbd, &s->dmamem);
+}
+
+static void sparc32_dma_realize(DeviceState *dev, Error **errp)
+{
+    SPARC32DMAState *s = SPARC32_DMA(dev);
+    DeviceState *d;
+    SysBusDevice *sbd;
+    Object *iommu;
+
+    iommu = object_resolve_path_type("", TYPE_SUN4M_IOMMU, NULL);
+    if (!iommu) {
+        error_setg(errp, "unable to locate sun4m IOMMU device");
+        return;
+    }
+
+    d = qdev_create(NULL, TYPE_SPARC32_ESPDMA_DEVICE);
+    object_property_set_link(OBJECT(d), iommu, "iommu", errp);
+    object_property_add_child(OBJECT(s), "espdma", OBJECT(d), errp);
+    qdev_init_nofail(d);
+    sbd = SYS_BUS_DEVICE(d);
+    memory_region_add_subregion(&s->dmamem, 0x0,
+                                sysbus_mmio_get_region(sbd, 0));
+
+    d = qdev_create(NULL, TYPE_SPARC32_LEDMA_DEVICE);
+    object_property_set_link(OBJECT(d), iommu, "iommu", errp);
+    object_property_add_child(OBJECT(s), "ledma", OBJECT(d), errp);
+    qdev_init_nofail(d);
+    sbd = SYS_BUS_DEVICE(d);
+    memory_region_add_subregion(&s->dmamem, 0x10,
+                                sysbus_mmio_get_region(sbd, 0));
+}
+
+static void sparc32_dma_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = sparc32_dma_realize;
+}
+
+static const TypeInfo sparc32_dma_info = {
+    .name          = TYPE_SPARC32_DMA,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(SPARC32DMAState),
+    .instance_init = sparc32_dma_init,
+    .class_init    = sparc32_dma_class_init,
+};
+
 static void sparc32_dma_register_types(void)
 {
     type_register_static(&sparc32_dma_device_info);
     type_register_static(&sparc32_espdma_device_info);
     type_register_static(&sparc32_ledma_device_info);
+    type_register_static(&sparc32_dma_info);
 }
 
 type_init(sparc32_dma_register_types)
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 12d36b5..b220694 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -307,13 +307,12 @@ static void *iommu_init(hwaddr addr, uint32_t version, qemu_irq irq)
     return s;
 }
 
-static void *sparc32_dma_init(hwaddr daddr, void *iommu, int is_ledma)
+static void *sparc32_dma_init(hwaddr daddr)
 {
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_create(NULL, is_ledma ? "sparc32-ledma" : "sparc32-espdma");
-    object_property_set_link(OBJECT(dev), OBJECT(iommu), "iommu", &error_abort);
+    dev = qdev_create(NULL, TYPE_SPARC32_DMA);
     qdev_init_nofail(dev);
     s = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(s, 0, daddr);
@@ -818,8 +817,8 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
     DeviceState *slavio_intctl;
     const char *cpu_model = machine->cpu_model;
     unsigned int i;
-    void *iommu, *nvram;
-    DeviceState *espdma, *ledma;
+    void *nvram;
+    DeviceState *dma, *espdma, *ledma;
     SysBusDevice *sbd;
     qemu_irq *cpu_irqs[MAX_CPUS], slavio_irq[32], slavio_cpu_irq[MAX_CPUS];
     qemu_irq esp_reset, dma_enable;
@@ -869,8 +868,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
         afx_init(hwdef->afx_base);
     }
 
-    iommu = iommu_init(hwdef->iommu_base, hwdef->iommu_version,
-                       slavio_irq[30]);
+    iommu_init(hwdef->iommu_base, hwdef->iommu_version, slavio_irq[30]);
 
     if (hwdef->iommu_pad_base) {
         /* On the real hardware (SS-5, LX) the MMU is not padded, but aliased.
@@ -880,11 +878,13 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
         empty_slot_init(hwdef->iommu_pad_base,hwdef->iommu_pad_len);
     }
 
-    espdma = sparc32_dma_init(hwdef->dma_base, iommu, 0);
+    dma = sparc32_dma_init(hwdef->dma_base);
+
+    espdma = DEVICE(object_resolve_path_component(OBJECT(dma), "espdma"));
     sbd = SYS_BUS_DEVICE(espdma);
     sysbus_connect_irq(sbd, 0, slavio_irq[18]);
 
-    ledma = sparc32_dma_init(hwdef->dma_base + 16ULL, iommu, 1);
+    ledma = DEVICE(object_resolve_path_component(OBJECT(dma), "ledma"));
     sbd = SYS_BUS_DEVICE(ledma);
     sysbus_connect_irq(sbd, 0, slavio_irq[16]);
 
diff --git a/include/hw/sparc/sparc32_dma.h b/include/hw/sparc/sparc32_dma.h
index df7491d..131d4de 100644
--- a/include/hw/sparc/sparc32_dma.h
+++ b/include/hw/sparc/sparc32_dma.h
@@ -38,6 +38,18 @@ typedef struct LEDMADeviceState {
     DMADeviceState parent_obj;
 } LEDMADeviceState;
 
+#define TYPE_SPARC32_DMA "sparc32-dma"
+#define SPARC32_DMA(obj) OBJECT_CHECK(SPARC32DMAState, (obj), \
+                                      TYPE_SPARC32_DMA)
+
+typedef struct SPARC32DMAState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion dmamem;
+    ESPDMADeviceState *espdma;
+    LEDMADeviceState *ledma;
+} SPARC32DMAState;
+
 /* sparc32_dma.c */
 void ledma_memory_read(void *opaque, hwaddr addr,
                        uint8_t *buf, int len, int do_bswap);
-- 
1.7.10.4
