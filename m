Received: from eggs.gnu.org ([2001:4830:134:3::10]:54513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cN8JU-0000wX-3s
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 20:18:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cN8JT-0008UB-7Y
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 20:18:24 -0500
From: xiaoqiang zhao <zxq_yx_007@163.com>
Date: Sat, 31 Dec 2016 09:18:07 +0800
Message-Id: <20161231011808.4037-2-zxq_yx_007@163.com>
In-Reply-To: <20161231011808.4037-1-zxq_yx_007@163.com>
References: <20161231011808.4037-1-zxq_yx_007@163.com>
Subject: [Qemu-devel] [PATCH 1/2] hw/char: QOM'ify exynos4210_uart.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: i.mitsyanko@gmail.com, pbonzini@redhat.com, qemu-arm@nongnu.org, chouteau@adacore.com

Drop the old Sysbus init and use instance_init and
DeviceClass::realize instead

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
---
 hw/char/exynos4210_uart.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index 571c324004..820d1abeb9 100644
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
2.11.0
