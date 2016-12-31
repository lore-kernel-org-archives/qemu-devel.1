Received: from eggs.gnu.org ([2001:4830:134:3::10]:54542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cN8JW-0000xx-1E
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 20:18:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cN8JV-0008VP-4F
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 20:18:25 -0500
From: xiaoqiang zhao <zxq_yx_007@163.com>
Date: Sat, 31 Dec 2016 09:18:08 +0800
Message-Id: <20161231011808.4037-3-zxq_yx_007@163.com>
In-Reply-To: <20161231011808.4037-1-zxq_yx_007@163.com>
References: <20161231011808.4037-1-zxq_yx_007@163.com>
Subject: [Qemu-devel] [PATCH 2/2] hw/char: QOM'ify grlib_apbuart.c
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
 hw/char/grlib_apbuart.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index db686e6a6f..620b801f34 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -239,24 +239,28 @@ static const MemoryRegionOps grlib_apbuart_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static int grlib_apbuart_init(SysBusDevice *dev)
+static void grlib_apbuart_init(Object *obj)
 {
+    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
     UART *uart = GRLIB_APB_UART(dev);
 
-    qemu_chr_fe_set_handlers(&uart->chr,
-                             grlib_apbuart_can_receive,
-                             grlib_apbuart_receive,
-                             grlib_apbuart_event,
-                             uart, NULL, true);
-
     sysbus_init_irq(dev, &uart->irq);
 
-    memory_region_init_io(&uart->iomem, OBJECT(uart), &grlib_apbuart_ops, uart,
+    memory_region_init_io(&uart->iomem, obj, &grlib_apbuart_ops, uart,
                           "uart", UART_REG_SIZE);
 
     sysbus_init_mmio(dev, &uart->iomem);
+}
 
-    return 0;
+static void grlib_apbuart_realize(DeviceState *dev, Error **errp)
+{
+    UART *uart = GRLIB_APB_UART(dev);
+
+    qemu_chr_fe_set_handlers(&uart->chr,
+                             grlib_apbuart_can_receive,
+                             grlib_apbuart_receive,
+                             grlib_apbuart_event,
+                             uart, NULL, true);
 }
 
 static void grlib_apbuart_reset(DeviceState *d)
@@ -280,9 +284,8 @@ static Property grlib_apbuart_properties[] = {
 static void grlib_apbuart_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = grlib_apbuart_init;
+    dc->realize = grlib_apbuart_realize;
     dc->reset = grlib_apbuart_reset;
     dc->props = grlib_apbuart_properties;
 }
@@ -291,6 +294,7 @@ static const TypeInfo grlib_apbuart_info = {
     .name          = TYPE_GRLIB_APB_UART,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(UART),
+    .instance_init = grlib_apbuart_init,
     .class_init    = grlib_apbuart_class_init,
 };
 
-- 
2.11.0
