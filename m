Received: from eggs.gnu.org ([2001:4830:134:3::10]:35812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO5-000407-Fl
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:54:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO4-00074Q-Hl
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:54:53 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gXSO4-0006w2-7L
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:54:52 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO2-0007HC-QL
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 14:54:50 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 14:54:17 +0000
Message-Id: <20181213145445.17935-10-peter.maydell@linaro.org>
In-Reply-To: <20181213145445.17935-1-peter.maydell@linaro.org>
References: <20181213145445.17935-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/37] gpio/puv3_gpio: Convert sysbus init
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

From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Use DeviceClass rather than SysBusDeviceClass in
puv3_gpio_class_init().

Cc: gxt@mprc.pku.edu.cn
Cc: peter.maydell@linaro.org

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20181130093852.20739-8-maozhongyi@cmss.chinamobile.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/gpio/puv3_gpio.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/hw/gpio/puv3_gpio.c b/hw/gpio/puv3_gpio.c
index 445afccf9f5..33241b8564c 100644
--- a/hw/gpio/puv3_gpio.c
+++ b/hw/gpio/puv3_gpio.c
@@ -99,36 +99,35 @@ static const MemoryRegionOps puv3_gpio_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static int puv3_gpio_init(SysBusDevice *dev)
+static void puv3_gpio_realize(DeviceState *dev, Error **errp)
 {
     PUV3GPIOState *s = PUV3_GPIO(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
     s->reg_GPLR = 0;
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
+    sysbus_init_irq(sbd, &s->irq[PUV3_IRQS_GPIOLOW0]);
+    sysbus_init_irq(sbd, &s->irq[PUV3_IRQS_GPIOLOW1]);
+    sysbus_init_irq(sbd, &s->irq[PUV3_IRQS_GPIOLOW2]);
+    sysbus_init_irq(sbd, &s->irq[PUV3_IRQS_GPIOLOW3]);
+    sysbus_init_irq(sbd, &s->irq[PUV3_IRQS_GPIOLOW4]);
+    sysbus_init_irq(sbd, &s->irq[PUV3_IRQS_GPIOLOW5]);
+    sysbus_init_irq(sbd, &s->irq[PUV3_IRQS_GPIOLOW6]);
+    sysbus_init_irq(sbd, &s->irq[PUV3_IRQS_GPIOLOW7]);
+    sysbus_init_irq(sbd, &s->irq[PUV3_IRQS_GPIOHIGH]);
 
     memory_region_init_io(&s->iomem, OBJECT(s), &puv3_gpio_ops, s, "puv3_gpio",
             PUV3_REGS_OFFSET);
-    sysbus_init_mmio(dev, &s->iomem);
-
-    return 0;
+    sysbus_init_mmio(sbd, &s->iomem);
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
2.19.2
