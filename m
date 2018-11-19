Received: from eggs.gnu.org ([2001:4830:134:3::10]:52718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiMP-0001me-5Q
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:09:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiMN-0002wy-Go
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:09:01 -0500
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:21648)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiMM-0002od-L9
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:08:59 -0500
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Mon, 19 Nov 2018 20:08:08 +0800
Message-Id: <20181119120820.29878-11-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH 10/22] intc/puv3_intc: Convert sysbus init
 function to realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, gxt@mprc.pku.edu.cn, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

Use DeviceClass rather than SysBusDeviceClass in
puv3_intc_class_init().

Cc: gxt@mprc.pku.edu.cn

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
---
 hw/intc/puv3_intc.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/hw/intc/puv3_intc.c b/hw/intc/puv3_intc.c
index ef8488aacc..dfef505c47 100644
--- a/hw/intc/puv3_intc.c
+++ b/hw/intc/puv3_intc.c
@@ -101,29 +101,25 @@ static const MemoryRegionOps puv3_intc_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static int puv3_intc_init(SysBusDevice *sbd)
+static void puv3_intc_realize(DeviceState *dev, Error **errp)
 {
-    DeviceState *dev = DEVICE(sbd);
     PUV3INTCState *s = PUV3_INTC(dev);
 
     qdev_init_gpio_in(dev, puv3_intc_handler, PUV3_IRQS_NR);
-    sysbus_init_irq(sbd, &s->parent_irq);
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->parent_irq);
 
     s->reg_ICMR = 0;
     s->reg_ICPR = 0;
 
     memory_region_init_io(&s->iomem, OBJECT(s), &puv3_intc_ops, s, "puv3_intc",
                           PUV3_REGS_OFFSET);
-    sysbus_init_mmio(sbd, &s->iomem);
-
-    return 0;
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
 }
 
 static void puv3_intc_class_init(ObjectClass *klass, void *data)
 {
-    SysBusDeviceClass *sdc = SYS_BUS_DEVICE_CLASS(klass);
-
-    sdc->init = puv3_intc_init;
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    dc->realize = puv3_intc_realize;
 }
 
 static const TypeInfo puv3_intc_info = {
-- 
2.17.1
