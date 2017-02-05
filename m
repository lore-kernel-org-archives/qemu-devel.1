Received: from eggs.gnu.org ([2001:4830:134:3::10]:33677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1caN1B-0000At-4b
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 08:38:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1caN17-0003HS-Us
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 08:38:13 -0500
Received: from m12-14.163.com ([220.181.12.14]:60852)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1caN17-0003Ew-Ag
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 08:38:09 -0500
From: xiaoqiang zhao <zxq_yx_007@163.com>
Date: Sun,  5 Feb 2017 21:37:20 +0800
Message-Id: <20170205133727.23424-3-zxq_yx_007@163.com>
In-Reply-To: <20170205133727.23424-1-zxq_yx_007@163.com>
References: <20170205133727.23424-1-zxq_yx_007@163.com>
Subject: [Qemu-devel] [RESEND PATCH 2/9] hw/dma: QOM'ify sparc32_dma.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com

Drop the old SysBus init function and use instance_init
and an realize function

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
---
 hw/dma/sparc32_dma.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index 9d545e412e..ef4c6a93c8 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -270,23 +270,28 @@ static const VMStateDescription vmstate_dma = {
     }
 };
 
-static int sparc32_dma_init1(SysBusDevice *sbd)
+static void sparc32_dma_init(Object *obj)
 {
-    DeviceState *dev = DEVICE(sbd);
-    DMAState *s = SPARC32_DMA(dev);
-    int reg_size;
+    DeviceState *dev = DEVICE(obj);
+    DMAState *s = SPARC32_DMA(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
     sysbus_init_irq(sbd, &s->irq);
 
-    reg_size = s->is_ledma ? DMA_ETH_SIZE : DMA_SIZE;
-    memory_region_init_io(&s->iomem, OBJECT(s), &dma_mem_ops, s,
-                          "dma", reg_size);
     sysbus_init_mmio(sbd, &s->iomem);
 
     qdev_init_gpio_in(dev, dma_set_irq, 1);
     qdev_init_gpio_out(dev, s->gpio, 2);
+}
 
-    return 0;
+static void sparc32_dma_realize(DeviceState *dev, Error **errp)
+{
+    DMAState *s = SPARC32_DMA(dev);
+    int reg_size;
+
+    reg_size = s->is_ledma ? DMA_ETH_SIZE : DMA_SIZE;
+    memory_region_init_io(&s->iomem, OBJECT(dev), &dma_mem_ops, s,
+                          "dma", reg_size);
 }
 
 static Property sparc32_dma_properties[] = {
@@ -298,12 +303,11 @@ static Property sparc32_dma_properties[] = {
 static void sparc32_dma_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = sparc32_dma_init1;
     dc->reset = dma_reset;
     dc->vmsd = &vmstate_dma;
     dc->props = sparc32_dma_properties;
+    dc->realize = sparc32_dma_realize;
     /* Reason: pointer property "iommu_opaque" */
     dc->cannot_instantiate_with_device_add_yet = true;
 }
@@ -312,6 +316,7 @@ static const TypeInfo sparc32_dma_info = {
     .name          = TYPE_SPARC32_DMA,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(DMAState),
+    .instance_init = sparc32_dma_init,
     .class_init    = sparc32_dma_class_init,
 };
 
-- 
2.11.0
