Received: from eggs.gnu.org ([2001:4830:134:3::10]:33669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1caN1B-0000Am-2Z
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 08:38:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1caN17-0003Hc-VJ
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 08:38:13 -0500
Received: from m12-14.163.com ([220.181.12.14]:60843)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1caN17-0003Ei-B6
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 08:38:09 -0500
From: xiaoqiang zhao <zxq_yx_007@163.com>
Date: Sun,  5 Feb 2017 21:37:21 +0800
Message-Id: <20170205133727.23424-4-zxq_yx_007@163.com>
In-Reply-To: <20170205133727.23424-1-zxq_yx_007@163.com>
References: <20170205133727.23424-1-zxq_yx_007@163.com>
Subject: [Qemu-devel] [RESEND PATCH 3/9] hw/dma: QOM'ify sun4m_iommu.c
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

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
---
 hw/dma/sun4m_iommu.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/dma/sun4m_iommu.c b/hw/dma/sun4m_iommu.c
index b3cbc54c23..335ef63cbc 100644
--- a/hw/dma/sun4m_iommu.c
+++ b/hw/dma/sun4m_iommu.c
@@ -349,17 +349,16 @@ static void iommu_reset(DeviceState *d)
     s->regs[IOMMU_MASK_ID] = IOMMU_TS_MASK;
 }
 
-static int iommu_init1(SysBusDevice *dev)
+static void iommu_init(Object *obj)
 {
-    IOMMUState *s = SUN4M_IOMMU(dev);
+    IOMMUState *s = SUN4M_IOMMU(obj);
+    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
 
     sysbus_init_irq(dev, &s->irq);
 
-    memory_region_init_io(&s->iomem, OBJECT(s), &iommu_mem_ops, s, "iommu",
+    memory_region_init_io(&s->iomem, obj, &iommu_mem_ops, s, "iommu",
                           IOMMU_NREGS * sizeof(uint32_t));
     sysbus_init_mmio(dev, &s->iomem);
-
-    return 0;
 }
 
 static Property iommu_properties[] = {
@@ -370,9 +369,7 @@ static Property iommu_properties[] = {
 static void iommu_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = iommu_init1;
     dc->reset = iommu_reset;
     dc->vmsd = &vmstate_iommu;
     dc->props = iommu_properties;
@@ -382,6 +379,7 @@ static const TypeInfo iommu_info = {
     .name          = TYPE_SUN4M_IOMMU,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(IOMMUState),
+    .instance_init = iommu_init,
     .class_init    = iommu_class_init,
 };
 
-- 
2.11.0
