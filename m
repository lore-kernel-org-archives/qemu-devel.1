Received: from eggs.gnu.org ([2001:4830:134:3::10]:52731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiMP-0001mh-Kn
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:09:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiMO-0002xg-12
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:09:01 -0500
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:14291)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiMM-0002oT-JO
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:08:59 -0500
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Mon, 19 Nov 2018 20:08:03 +0800
Message-Id: <20181119120820.29878-6-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH 05/22] display/g364fb: Convert sysbus init
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
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, pbonzini@redhat.com, kraxel@redhat.com, f4bug@amsat.org, alistair.francis@wdc.com, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

Use DeviceClass rather than SysBusDeviceClass in
g364fb_sysbus_class_init().

Cc: pbonzini@redhat.com
Cc: kraxel@redhat.com
Cc: f4bug@amsat.org
Cc: alistair.francis@wdc.com

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
---
 hw/display/g364fb.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index 8ad7e5d824..e7f67088b0 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -489,18 +489,15 @@ typedef struct {
     G364State g364;
 } G364SysBusState;
 
-static int g364fb_sysbus_init(SysBusDevice *sbd)
+static void g364fb_sysbus_realize(DeviceState *dev, Error **errp)
 {
-    DeviceState *dev = DEVICE(sbd);
     G364SysBusState *sbs = G364(dev);
     G364State *s = &sbs->g364;
 
     g364fb_init(dev, s);
-    sysbus_init_irq(sbd, &s->irq);
-    sysbus_init_mmio(sbd, &s->mem_ctrl);
-    sysbus_init_mmio(sbd, &s->mem_vram);
-
-    return 0;
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mem_ctrl);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mem_vram);
 }
 
 static void g364fb_sysbus_reset(DeviceState *d)
@@ -518,9 +515,8 @@ static Property g364fb_sysbus_properties[] = {
 static void g364fb_sysbus_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = g364fb_sysbus_init;
+    dc->realize = g364fb_sysbus_realize;
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
     dc->desc = "G364 framebuffer";
     dc->reset = g364fb_sysbus_reset;
-- 
2.17.1
