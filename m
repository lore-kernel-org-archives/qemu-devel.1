Received: from eggs.gnu.org ([2001:4830:134:3::10]:35024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cPJ3L-0003G4-4n
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 20:10:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cPJ3H-00080z-NH
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 20:10:42 -0500
Received: from m12-14.163.com ([220.181.12.14]:34902)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cPJ3G-0007sk-PM
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 20:10:39 -0500
From: xiaoqiang zhao <zxq_yx_007@163.com>
Date: Fri,  6 Jan 2017 09:10:23 +0800
Message-Id: <20170106011023.24057-1-zxq_yx_007@163.com>
Subject: [Qemu-devel] [PATCH v2] hw/display: QOM'ify g364fb.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, hpoussin@reactos.org

Drop the old Sysbus init and use instance_init and
DeviceClass::realize instead

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
---
 hw/display/g364fb.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index 70ef2c7453..7e2b3abe79 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -482,19 +482,6 @@ static const GraphicHwOps g364fb_ops = {
     .gfx_update  = g364fb_update_display,
 };
 
-static void g364fb_init(DeviceState *dev, G364State *s)
-{
-    s->vram = g_malloc0(s->vram_size);
-
-    s->con = graphic_console_init(dev, 0, &g364fb_ops, s);
-
-    memory_region_init_io(&s->mem_ctrl, NULL, &g364fb_ctrl_ops, s, "ctrl", 0x180000);
-    memory_region_init_ram_ptr(&s->mem_vram, NULL, "vram",
-                               s->vram_size, s->vram);
-    vmstate_register_ram(&s->mem_vram, dev);
-    memory_region_set_log(&s->mem_vram, true, DIRTY_MEMORY_VGA);
-}
-
 #define TYPE_G364 "sysbus-g364"
 #define G364(obj) OBJECT_CHECK(G364SysBusState, (obj), TYPE_G364)
 
@@ -504,18 +491,33 @@ typedef struct {
     G364State g364;
 } G364SysBusState;
 
-static int g364fb_sysbus_init(SysBusDevice *sbd)
+static void g364fb_init(Object *obj)
 {
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     DeviceState *dev = DEVICE(sbd);
     G364SysBusState *sbs = G364(dev);
     G364State *s = &sbs->g364;
 
-    g364fb_init(dev, s);
     sysbus_init_irq(sbd, &s->irq);
+
+    memory_region_init_io(&s->mem_ctrl, NULL, &g364fb_ctrl_ops,
+                          s, "ctrl", 0x180000);
     sysbus_init_mmio(sbd, &s->mem_ctrl);
-    sysbus_init_mmio(sbd, &s->mem_vram);
+}
 
-    return 0;
+static void g364fb_realize(DeviceState *dev, Error **errp)
+{
+    G364SysBusState *sbs = G364(dev);
+    G364State *s = &sbs->g364;
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    s->vram = g_malloc0(s->vram_size);
+    s->con = graphic_console_init(dev, 0, &g364fb_ops, s);
+    memory_region_init_ram_ptr(&s->mem_vram, NULL, "vram",
+                               s->vram_size, s->vram);
+    vmstate_register_ram(&s->mem_vram, dev);
+    memory_region_set_log(&s->mem_vram, true, DIRTY_MEMORY_VGA);
+    sysbus_init_mmio(sbd, &s->mem_vram);
 }
 
 static void g364fb_sysbus_reset(DeviceState *d)
@@ -534,9 +536,8 @@ static Property g364fb_sysbus_properties[] = {
 static void g364fb_sysbus_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = g364fb_sysbus_init;
+    dc->realize = g364fb_realize;
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
     dc->desc = "G364 framebuffer";
     dc->reset = g364fb_sysbus_reset;
@@ -548,6 +549,7 @@ static const TypeInfo g364fb_sysbus_info = {
     .name          = TYPE_G364,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(G364SysBusState),
+    .instance_init = g364fb_init,
     .class_init    = g364fb_sysbus_class_init,
 };
 
-- 
2.11.0
