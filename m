Received: from eggs.gnu.org ([2001:4830:134:3::10]:45586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cL48g-0000oc-3c
	for qemu-devel@nongnu.org; Sun, 25 Dec 2016 03:26:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cL48d-0001Ay-0a
	for qemu-devel@nongnu.org; Sun, 25 Dec 2016 03:26:42 -0500
Received: from m12-11.163.com ([220.181.12.11]:45836)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cL48c-0001A9-5o
	for qemu-devel@nongnu.org; Sun, 25 Dec 2016 03:26:38 -0500
From: xiaoqiang zhao <zxq_yx_007@163.com>
Date: Sun, 25 Dec 2016 16:25:59 +0800
Message-Id: <20161225082559.2095-1-zxq_yx_007@163.com>
Subject: [Qemu-devel] [PATCH] hw/display: QOM'ify g364fb.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Drop the old Sysbus init and use instance_init and
DeviceClass::realize instead

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
---
 hw/display/g364fb.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index 70ef2c7453..7a0fe48dd5 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -504,18 +504,24 @@ typedef struct {
     G364State g364;
 } G364SysBusState;
 
-static int g364fb_sysbus_init(SysBusDevice *sbd)
+static void g364fb_sysbus_init(Object *obj)
 {
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     DeviceState *dev = DEVICE(sbd);
     G364SysBusState *sbs = G364(dev);
     G364State *s = &sbs->g364;
 
-    g364fb_init(dev, s);
     sysbus_init_irq(sbd, &s->irq);
     sysbus_init_mmio(sbd, &s->mem_ctrl);
     sysbus_init_mmio(sbd, &s->mem_vram);
+}
 
-    return 0;
+static void g364fb_sysbus_realize(DeviceState *dev, Error **errp)
+{
+    G364SysBusState *sbs = G364(dev);
+    G364State *s = &sbs->g364;
+
+    g364fb_init(dev, s);
 }
 
 static void g364fb_sysbus_reset(DeviceState *d)
@@ -534,9 +540,8 @@ static Property g364fb_sysbus_properties[] = {
 static void g364fb_sysbus_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = g364fb_sysbus_init;
+    dc->realize = g364fb_sysbus_realize;
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
     dc->desc = "G364 framebuffer";
     dc->reset = g364fb_sysbus_reset;
@@ -548,6 +553,7 @@ static const TypeInfo g364fb_sysbus_info = {
     .name          = TYPE_G364,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(G364SysBusState),
+    .instance_init = g364fb_sysbus_init,
     .class_init    = g364fb_sysbus_class_init,
 };
 
-- 
2.11.0
