Received: from eggs.gnu.org ([2001:4830:134:3::10]:54784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cN8K5-0001QK-Mz
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 20:19:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cN8K4-0000LU-Ic
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 20:19:01 -0500
Received: from m12-14.163.com ([220.181.12.14]:45685)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cN8K3-0000Kh-VL
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 20:19:00 -0500
From: xiaoqiang zhao <zxq_yx_007@163.com>
Date: Sat, 31 Dec 2016 09:18:47 +0800
Message-Id: <20161231011847.4153-6-zxq_yx_007@163.com>
In-Reply-To: <20161231011847.4153-1-zxq_yx_007@163.com>
References: <20161231011847.4153-1-zxq_yx_007@163.com>
Subject: [Qemu-devel] [PATCH 5/5] hw/input: QOM'ify milkymist-softusb.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: michael@walle.cc

split the old SysBus init function into an instance_init
and Device realize function

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
---
 hw/input/milkymist-softusb.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/hw/input/milkymist-softusb.c b/hw/input/milkymist-softusb.c
index 40dfca157f..2afbca8a9c 100644
--- a/hw/input/milkymist-softusb.c
+++ b/hw/input/milkymist-softusb.c
@@ -245,32 +245,37 @@ static void milkymist_softusb_reset(DeviceState *d)
     s->regs[R_CTRL] = CTRL_RESET;
 }
 
-static int milkymist_softusb_init(SysBusDevice *dev)
+static void milkymist_softusb_init(Object *obj)
 {
+    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
     MilkymistSoftUsbState *s = MILKYMIST_SOFTUSB(dev);
 
     sysbus_init_irq(dev, &s->irq);
 
-    memory_region_init_io(&s->regs_region, OBJECT(s), &softusb_mmio_ops, s,
+    memory_region_init_io(&s->regs_region, obj, &softusb_mmio_ops, s,
                           "milkymist-softusb", R_MAX * 4);
     sysbus_init_mmio(dev, &s->regs_region);
+}
+
+static void milkymist_softusb_realize(DeviceState *dev, Error **errp)
+{
+    MilkymistSoftUsbState *s = MILKYMIST_SOFTUSB(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
     /* register pmem and dmem */
     memory_region_init_ram(&s->pmem, OBJECT(s), "milkymist-softusb.pmem",
                            s->pmem_size, &error_fatal);
     vmstate_register_ram_global(&s->pmem);
     s->pmem_ptr = memory_region_get_ram_ptr(&s->pmem);
-    sysbus_init_mmio(dev, &s->pmem);
+    sysbus_init_mmio(sbd, &s->pmem);
     memory_region_init_ram(&s->dmem, OBJECT(s), "milkymist-softusb.dmem",
                            s->dmem_size, &error_fatal);
     vmstate_register_ram_global(&s->dmem);
     s->dmem_ptr = memory_region_get_ram_ptr(&s->dmem);
-    sysbus_init_mmio(dev, &s->dmem);
+    sysbus_init_mmio(sbd, &s->dmem);
 
     hid_init(&s->hid_kbd, HID_KEYBOARD, softusb_kbd_hid_datain);
     hid_init(&s->hid_mouse, HID_MOUSE, softusb_mouse_hid_datain);
-
-    return 0;
 }
 
 static const VMStateDescription vmstate_milkymist_softusb = {
@@ -296,9 +301,8 @@ static Property milkymist_softusb_properties[] = {
 static void milkymist_softusb_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = milkymist_softusb_init;
+    dc->realize = milkymist_softusb_realize;
     dc->reset = milkymist_softusb_reset;
     dc->vmsd = &vmstate_milkymist_softusb;
     dc->props = milkymist_softusb_properties;
@@ -308,6 +312,7 @@ static const TypeInfo milkymist_softusb_info = {
     .name          = TYPE_MILKYMIST_SOFTUSB,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(MilkymistSoftUsbState),
+    .instance_init = milkymist_softusb_init,
     .class_init    = milkymist_softusb_class_init,
 };
 
-- 
2.11.0
