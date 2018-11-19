Received: from eggs.gnu.org ([2001:4830:134:3::10]:52704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiMP-0001mW-14
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:09:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiML-0002u6-Ki
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:09:00 -0500
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:5335)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiMK-0002ol-Rq
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:08:57 -0500
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Mon, 19 Nov 2018 20:08:05 +0800
Message-Id: <20181119120820.29878-8-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH 07/22] gpio/puv3_gpio: Convert sysbus init
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
puv3_gpio_class_init().

Cc: gxt@mprc.pku.edu.cn

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
---
 hw/gpio/puv3_gpio.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/hw/gpio/puv3_gpio.c b/hw/gpio/puv3_gpio.c
index 445afccf9f..bd6fc43aae 100644
--- a/hw/gpio/puv3_gpio.c
+++ b/hw/gpio/puv3_gpio.c
@@ -99,7 +99,7 @@ static const MemoryRegionOps puv3_gpio_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static int puv3_gpio_init(SysBusDevice *dev)
+static void puv3_gpio_realize(DeviceState *dev, Error **errp)
 {
     PUV3GPIOState *s = PUV3_GPIO(dev);
 
@@ -107,28 +107,26 @@ static int puv3_gpio_init(SysBusDevice *dev)
     s->reg_GPDR = 0;
 
     /* FIXME: these irqs not handled yet */
-    sysbus_init_irq(dev, &s->irq[PUV3_IRQS_GPIOLOW0]);
-    sysbus_init_irq(dev, &s->irq[PUV3_IRQS_GPIOLOW1]);
-    sysbus_init_irq(dev, &s->irq[PUV3_IRQS_GPIOLOW2]);
-    sysbus_init_irq(dev, &s->irq[PUV3_IRQS_GPIOLOW3]);
-    sysbus_init_irq(dev, &s->irq[PUV3_IRQS_GPIOLOW4]);
-    sysbus_init_irq(dev, &s->irq[PUV3_IRQS_GPIOLOW5]);
-    sysbus_init_irq(dev, &s->irq[PUV3_IRQS_GPIOLOW6]);
-    sysbus_init_irq(dev, &s->irq[PUV3_IRQS_GPIOLOW7]);
-    sysbus_init_irq(dev, &s->irq[PUV3_IRQS_GPIOHIGH]);
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[PUV3_IRQS_GPIOLOW0]);
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[PUV3_IRQS_GPIOLOW1]);
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[PUV3_IRQS_GPIOLOW2]);
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[PUV3_IRQS_GPIOLOW3]);
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[PUV3_IRQS_GPIOLOW4]);
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[PUV3_IRQS_GPIOLOW5]);
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[PUV3_IRQS_GPIOLOW6]);
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[PUV3_IRQS_GPIOLOW7]);
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[PUV3_IRQS_GPIOHIGH]);
 
     memory_region_init_io(&s->iomem, OBJECT(s), &puv3_gpio_ops, s, "puv3_gpio",
             PUV3_REGS_OFFSET);
-    sysbus_init_mmio(dev, &s->iomem);
-
-    return 0;
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
 }
 
 static void puv3_gpio_class_init(ObjectClass *klass, void *data)
 {
-    SysBusDeviceClass *sdc = SYS_BUS_DEVICE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
-    sdc->init = puv3_gpio_init;
+    dc->realize = puv3_gpio_realize;
 }
 
 static const TypeInfo puv3_gpio_info = {
-- 
2.17.1
