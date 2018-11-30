Received: from eggs.gnu.org ([2001:4830:134:3::10]:38524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gSfGj-0006B1-Oa
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:39:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gSfGg-0002T1-94
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:39:29 -0500
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:33834)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gSfGf-0002N0-CT
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:39:26 -0500
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Fri, 30 Nov 2018 17:38:39 +0800
Message-Id: <20181130093852.20739-9-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181130093852.20739-1-maozhongyi@cmss.chinamobile.com>
References: <20181130093852.20739-1-maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 08/21] milkymist-softusb: Convert sysbus
 init function to realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, michael@walle.cc, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

Use DeviceClass rather than SysBusDeviceClass in
milkymist_softusb_class_init().

Cc: michael@walle.cc

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/input/milkymist-softusb.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/input/milkymist-softusb.c b/hw/input/milkymist-softusb.c
index ef8f47cd83..8766a17d9e 100644
--- a/hw/input/milkymist-softusb.c
+++ b/hw/input/milkymist-softusb.c
@@ -245,32 +245,31 @@ static void milkymist_softusb_reset(DeviceState *d)
     s->regs[R_CTRL] = CTRL_RESET;
 }
 
-static int milkymist_softusb_init(SysBusDevice *dev)
+static void milkymist_softusb_realize(DeviceState *dev, Error **errp)
 {
     MilkymistSoftUsbState *s = MILKYMIST_SOFTUSB(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
-    sysbus_init_irq(dev, &s->irq);
+    sysbus_init_irq(sbd, &s->irq);
 
     memory_region_init_io(&s->regs_region, OBJECT(s), &softusb_mmio_ops, s,
                           "milkymist-softusb", R_MAX * 4);
-    sysbus_init_mmio(dev, &s->regs_region);
+    sysbus_init_mmio(sbd, &s->regs_region);
 
     /* register pmem and dmem */
     memory_region_init_ram_nomigrate(&s->pmem, OBJECT(s), "milkymist-softusb.pmem",
                            s->pmem_size, &error_fatal);
     vmstate_register_ram_global(&s->pmem);
     s->pmem_ptr = memory_region_get_ram_ptr(&s->pmem);
-    sysbus_init_mmio(dev, &s->pmem);
+    sysbus_init_mmio(sbd, &s->pmem);
     memory_region_init_ram_nomigrate(&s->dmem, OBJECT(s), "milkymist-softusb.dmem",
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
@@ -296,9 +295,8 @@ static Property milkymist_softusb_properties[] = {
 static void milkymist_softusb_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = milkymist_softusb_init;
+    dc->realize = milkymist_softusb_realize;
     dc->reset = milkymist_softusb_reset;
     dc->vmsd = &vmstate_milkymist_softusb;
     dc->props = milkymist_softusb_properties;
-- 
2.17.1
