Received: from eggs.gnu.org ([2001:4830:134:3::10]:35726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO2-0003vc-QS
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:54:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO1-00070O-SX
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:54:50 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gXSO1-0006zA-Iv
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:54:49 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO0-0007G8-LD
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 14:54:48 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 14:54:13 +0000
Message-Id: <20181213145445.17935-6-peter.maydell@linaro.org>
In-Reply-To: <20181213145445.17935-1-peter.maydell@linaro.org>
References: <20181213145445.17935-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/37] char/grlib_apbuart: Convert sysbus init
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
grlib_apbuart_class_init().

Cc: chouteau@adacore.com
Cc: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20181130093852.20739-4-maozhongyi@cmss.chinamobile.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/grlib_apbuart.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index bac11bec58d..e1d258b6112 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -239,9 +239,10 @@ static const MemoryRegionOps grlib_apbuart_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static int grlib_apbuart_init(SysBusDevice *dev)
+static void grlib_apbuart_realize(DeviceState *dev, Error **errp)
 {
     UART *uart = GRLIB_APB_UART(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
     qemu_chr_fe_set_handlers(&uart->chr,
                              grlib_apbuart_can_receive,
@@ -249,14 +250,12 @@ static int grlib_apbuart_init(SysBusDevice *dev)
                              grlib_apbuart_event,
                              NULL, uart, NULL, true);
 
-    sysbus_init_irq(dev, &uart->irq);
+    sysbus_init_irq(sbd, &uart->irq);
 
     memory_region_init_io(&uart->iomem, OBJECT(uart), &grlib_apbuart_ops, uart,
                           "uart", UART_REG_SIZE);
 
-    sysbus_init_mmio(dev, &uart->iomem);
-
-    return 0;
+    sysbus_init_mmio(sbd, &uart->iomem);
 }
 
 static void grlib_apbuart_reset(DeviceState *d)
@@ -280,9 +279,8 @@ static Property grlib_apbuart_properties[] = {
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
2.19.2
