Received: from eggs.gnu.org ([2001:4830:134:3::10]:35824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO5-00040Z-RS
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:54:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO4-00074s-QU
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:54:53 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gXSO4-00071P-Ij
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:54:52 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO3-0007HS-Bd
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 14:54:51 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 14:54:18 +0000
Message-Id: <20181213145445.17935-11-peter.maydell@linaro.org>
In-Reply-To: <20181213145445.17935-1-peter.maydell@linaro.org>
References: <20181213145445.17935-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/37] milkymist-softusb: Convert sysbus init
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
milkymist_softusb_class_init().

Cc: michael@walle.cc

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20181130093852.20739-9-maozhongyi@cmss.chinamobile.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/input/milkymist-softusb.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/input/milkymist-softusb.c b/hw/input/milkymist-softusb.c
index ef8f47cd834..8766a17d9e0 100644
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
2.19.2
