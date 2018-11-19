Received: from eggs.gnu.org ([2001:4830:134:3::10]:52716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiMP-0001mc-4e
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:09:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiMN-0002wl-FM
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:09:00 -0500
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:21647)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiML-0002oa-Rc
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:08:59 -0500
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Mon, 19 Nov 2018 20:08:01 +0800
Message-Id: <20181119120820.29878-4-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH 03/22] char/grlib_apbuart: Convert sysbus init
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
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, chouteau@adacore.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

Use DeviceClass rather than SysBusDeviceClass in
grlib_apbuart_class_init().

Cc: chouteau@adacore.com
Cc: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
---
 hw/char/grlib_apbuart.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index bac11bec58..e73ecf2ea5 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -239,7 +239,7 @@ static const MemoryRegionOps grlib_apbuart_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static int grlib_apbuart_init(SysBusDevice *dev)
+static void grlib_apbuart_realize(DeviceState *dev, Error **errp)
 {
     UART *uart = GRLIB_APB_UART(dev);
 
@@ -249,14 +249,12 @@ static int grlib_apbuart_init(SysBusDevice *dev)
                              grlib_apbuart_event,
                              NULL, uart, NULL, true);
 
-    sysbus_init_irq(dev, &uart->irq);
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &uart->irq);
 
     memory_region_init_io(&uart->iomem, OBJECT(uart), &grlib_apbuart_ops, uart,
                           "uart", UART_REG_SIZE);
 
-    sysbus_init_mmio(dev, &uart->iomem);
-
-    return 0;
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &uart->iomem);
 }
 
 static void grlib_apbuart_reset(DeviceState *d)
@@ -280,9 +278,8 @@ static Property grlib_apbuart_properties[] = {
 static void grlib_apbuart_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = grlib_apbuart_init;
+    dc->realize = grlib_apbuart_realize;
     dc->reset = grlib_apbuart_reset;
     dc->props = grlib_apbuart_properties;
 }
-- 
2.17.1
