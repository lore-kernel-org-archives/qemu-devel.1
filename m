Received: from eggs.gnu.org ([2001:4830:134:3::10]:37490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWd-0002bR-TR
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:54:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWY-0004D4-Pw
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:54:07 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cQYWY-00045M-Ix
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:54:02 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWI-0001MD-KE
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:53:46 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jan 2017 11:53:25 +0000
Message-Id: <1483962824-29185-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
References: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 02/21] hw/char: QOM'ify exynos4210_uart.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: xiaoqiang zhao <zxq_yx_007@163.com>

Drop the old Sysbus init and use instance_init and
DeviceClass::realize instead

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/exynos4210_uart.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index 571c324..820d1ab 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -629,22 +629,26 @@ DeviceState *exynos4210_uart_create(hwaddr addr,
     return dev;
 }
 
-static int exynos4210_uart_init(SysBusDevice *dev)
+static void exynos4210_uart_init(Object *obj)
 {
+    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
     Exynos4210UartState *s = EXYNOS4210_UART(dev);
 
     /* memory mapping */
-    memory_region_init_io(&s->iomem, OBJECT(s), &exynos4210_uart_ops, s,
+    memory_region_init_io(&s->iomem, obj, &exynos4210_uart_ops, s,
                           "exynos4210.uart", EXYNOS4210_UART_REGS_MEM_SIZE);
     sysbus_init_mmio(dev, &s->iomem);
 
     sysbus_init_irq(dev, &s->irq);
+}
+
+static void exynos4210_uart_realize(DeviceState *dev, Error **errp)
+{
+    Exynos4210UartState *s = EXYNOS4210_UART(dev);
 
     qemu_chr_fe_set_handlers(&s->chr, exynos4210_uart_can_receive,
                              exynos4210_uart_receive, exynos4210_uart_event,
                              s, NULL, true);
-
-    return 0;
 }
 
 static Property exynos4210_uart_properties[] = {
@@ -658,9 +662,8 @@ static Property exynos4210_uart_properties[] = {
 static void exynos4210_uart_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = exynos4210_uart_init;
+    dc->realize = exynos4210_uart_realize;
     dc->reset = exynos4210_uart_reset;
     dc->props = exynos4210_uart_properties;
     dc->vmsd = &vmstate_exynos4210_uart;
@@ -670,6 +673,7 @@ static const TypeInfo exynos4210_uart_info = {
     .name          = TYPE_EXYNOS4210_UART,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(Exynos4210UartState),
+    .instance_init = exynos4210_uart_init,
     .class_init    = exynos4210_uart_class_init,
 };
 
-- 
2.7.4
