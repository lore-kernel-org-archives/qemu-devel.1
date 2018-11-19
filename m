Received: from eggs.gnu.org ([2001:4830:134:3::10]:52722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiMP-0001mf-5Y
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:09:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiMM-0002vQ-EA
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:09:01 -0500
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:7323)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiML-0002s9-Lu
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:08:58 -0500
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Mon, 19 Nov 2018 20:08:17 +0800
Message-Id: <20181119120820.29878-20-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH 19/22] usb/tusb6010: Convert sysbus init
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
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, kraxel@redhat.com, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

Use DeviceClass rather than SysBusDeviceClass in
tusb6010_class_init().

Cc: kraxel@redhat.com

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
---
 hw/usb/tusb6010.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/hw/usb/tusb6010.c b/hw/usb/tusb6010.c
index a2128024c1..0712281c42 100644
--- a/hw/usb/tusb6010.c
+++ b/hw/usb/tusb6010.c
@@ -808,29 +808,26 @@ static void tusb6010_reset(DeviceState *dev)
     musb_reset(s->musb);
 }
 
-static int tusb6010_init(SysBusDevice *sbd)
+static void tusb6010_realize(DeviceState *dev, Error **errp)
 {
-    DeviceState *dev = DEVICE(sbd);
     TUSBState *s = TUSB(dev);
 
     s->otg_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, tusb_otg_tick, s);
     s->pwr_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, tusb_power_tick, s);
     memory_region_init_io(&s->iomem[1], OBJECT(s), &tusb_async_ops, s,
                           "tusb-async", UINT32_MAX);
-    sysbus_init_mmio(sbd, &s->iomem[0]);
-    sysbus_init_mmio(sbd, &s->iomem[1]);
-    sysbus_init_irq(sbd, &s->irq);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem[0]);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem[1]);
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
     qdev_init_gpio_in(dev, tusb6010_irq, musb_irq_max + 1);
     s->musb = musb_init(dev, 1);
-    return 0;
 }
 
 static void tusb6010_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = tusb6010_init;
+    dc->realize = tusb6010_realize;
     dc->reset = tusb6010_reset;
 }
 
-- 
2.17.1
