Received: from eggs.gnu.org ([2001:4830:134:3::10]:45523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e7OAg-0004In-Ne
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 12:04:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e7OAc-0004m0-3B
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 12:04:46 -0400
Received: from chuckie.co.uk ([82.165.15.123]:58440
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1e7OAb-0004kD-Rh
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 12:04:42 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed, 25 Oct 2017 16:59:24 +0100
Message-Id: <1508947167-5304-11-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1508947167-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1508947167-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv4 10/13] sparc32_dma: make lance device child
 of ledma device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This makes it possible to reference the lance device from the ledma device as
required.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 hw/dma/sparc32_dma.c           |   22 ++++++++++++++++++++++
 hw/sparc/sun4m.c               |   31 +++++++------------------------
 include/hw/sparc/sparc32_dma.h |    3 +++
 3 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index 6009b94..d4cff74 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -340,11 +340,33 @@ static void sparc32_ledma_device_init(Object *obj)
     s->is_ledma = 1;
 }
 
+static void sparc32_ledma_device_realize(DeviceState *dev, Error **errp)
+{
+    DeviceState *d;
+    NICInfo *nd = &nd_table[0];
+
+    qemu_check_nic_model(nd, TYPE_LANCE);
+
+    d = qdev_create(NULL, TYPE_LANCE);
+    object_property_add_child(OBJECT(dev), "lance", OBJECT(d), errp);
+    qdev_set_nic_properties(d, nd);
+    qdev_prop_set_ptr(d, "dma", dev);
+    qdev_init_nofail(d);
+}
+
+static void sparc32_ledma_device_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = sparc32_ledma_device_realize;
+}
+
 static const TypeInfo sparc32_ledma_device_info = {
     .name          = TYPE_SPARC32_LEDMA_DEVICE,
     .parent        = TYPE_SPARC32_DMA_DEVICE,
     .instance_size = sizeof(LEDMADeviceState),
     .instance_init = sparc32_ledma_device_init,
+    .class_init    = sparc32_ledma_device_class_init,
 };
 
 static void sparc32_dma_register_types(void)
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 4626c85..ae486a4 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -321,26 +321,6 @@ static void *sparc32_dma_init(hwaddr daddr, void *iommu, int is_ledma)
     return s;
 }
 
-static void lance_init(NICInfo *nd, hwaddr leaddr,
-                       void *dma_opaque, qemu_irq irq)
-{
-    DeviceState *dev;
-    SysBusDevice *s;
-    qemu_irq reset;
-
-    qemu_check_nic_model(&nd_table[0], "lance");
-
-    dev = qdev_create(NULL, "lance");
-    qdev_set_nic_properties(dev, nd);
-    qdev_prop_set_ptr(dev, "dma", dma_opaque);
-    qdev_init_nofail(dev);
-    s = SYS_BUS_DEVICE(dev);
-    sysbus_mmio_map(s, 0, leaddr);
-    sysbus_connect_irq(s, 0, irq);
-    reset = qdev_get_gpio_in(dev, 0);
-    qdev_connect_gpio_out(dma_opaque, 0, reset);
-}
-
 static DeviceState *slavio_intctl_init(hwaddr addr,
                                        hwaddr addrg,
                                        qemu_irq **parent_irq)
@@ -819,7 +799,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
     const char *cpu_model = machine->cpu_model;
     unsigned int i;
     void *iommu, *nvram;
-    DeviceState *espdma, *esp, *ledma;
+    DeviceState *espdma, *esp, *ledma, *lance;
     SysBusDevice *sbd;
     qemu_irq *cpu_irqs[MAX_CPUS], slavio_irq[32], slavio_cpu_irq[MAX_CPUS];
     qemu_irq fdc_tc;
@@ -894,6 +874,12 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
     sbd = SYS_BUS_DEVICE(ledma);
     sysbus_connect_irq(sbd, 0, slavio_irq[16]);
 
+    lance = DEVICE(object_resolve_path_component(OBJECT(ledma), "lance"));
+    sbd = SYS_BUS_DEVICE(lance);
+    sysbus_mmio_map(sbd, 0, hwdef->le_base);
+    sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(ledma, 0));
+    qdev_connect_gpio_out(ledma, 0, qdev_get_gpio_in(lance, 0));
+
     if (graphic_depth != 8 && graphic_depth != 24) {
         error_report("Unsupported depth: %d", graphic_depth);
         exit (1);
@@ -945,9 +931,6 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
         empty_slot_init(hwdef->sx_base, 0x2000);
     }
 
-    lance_init(&nd_table[0], hwdef->le_base, ledma,
-               qdev_get_gpio_in(ledma, 0));
-
     nvram = m48t59_init(slavio_irq[0], hwdef->nvram_base, 0, 0x2000, 1968, 8);
 
     slavio_timer_init_all(hwdef->counter_base, slavio_irq[19], slavio_cpu_irq, smp_cpus);
diff --git a/include/hw/sparc/sparc32_dma.h b/include/hw/sparc/sparc32_dma.h
index 365160f..5e39d81 100644
--- a/include/hw/sparc/sparc32_dma.h
+++ b/include/hw/sparc/sparc32_dma.h
@@ -3,6 +3,7 @@
 
 #include "hw/sysbus.h"
 #include "hw/scsi/esp.h"
+#include "hw/net/lance.h"
 
 #define DMA_REGS 4
 
@@ -39,6 +40,8 @@ typedef struct ESPDMADeviceState {
 
 typedef struct LEDMADeviceState {
     DMADeviceState parent_obj;
+
+    SysBusPCNetState *lance;
 } LEDMADeviceState;
 
 /* sparc32_dma.c */
-- 
1.7.10.4
