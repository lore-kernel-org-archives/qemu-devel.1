Received: from eggs.gnu.org ([2001:4830:134:3::10]:33077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gH7mb-0005GP-QV
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:40:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gH7mX-0006j7-Gi
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:40:41 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Mon, 29 Oct 2018 13:39:57 +0000
Message-Id: <20181029134000.11157-9-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20181029134000.11157-1-mark.cave-ayland@ilande.co.uk>
References: <20181029134000.11157-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH v5 08/11] hw/m68k: add Nubus support for macfb
 video card
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, jasowang@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, hpoussin@reactos.org, kraxel@redhat.com, pbonzini@redhat.com, afaerber@suse.de, aurelien@aurel32.net, laurent@vivier.eu

Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/display/macfb.c         | 56 ++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/display/macfb.h | 21 +++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index 61ba2e9e15..458e268d86 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -15,6 +15,7 @@
 #include "hw/sysbus.h"
 #include "ui/console.h"
 #include "ui/pixel_ops.h"
+#include "hw/nubus/nubus.h"
 #include "hw/display/macfb.h"
 #include "qapi/error.h"
 
@@ -380,12 +381,38 @@ static void macfb_sysbus_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &ms->mem_vram);
 }
 
+const uint8_t macfb_rom[] = {
+    255, 0, 0, 0,
+};
+
+static void macfb_nubus_realize(DeviceState *dev, Error **errp)
+{
+    NubusDevice *nd = NUBUS_DEVICE(dev);
+    MacfbNubusState *s = NUBUS_MACFB(dev);
+    MacfbNubusDeviceClass *ndc = MACFB_NUBUS_GET_CLASS(dev);
+    MacfbState *ms = &s->macfb;
+
+    ndc->parent_realize(dev, errp);
+
+    macfb_common_realize(dev, ms, errp);
+    memory_region_add_subregion(&nd->slot_mem, DAFB_BASE, &ms->mem_ctrl);
+    memory_region_add_subregion(&nd->slot_mem, VIDEO_BASE, &ms->mem_vram);
+
+    nubus_register_rom(nd, macfb_rom, sizeof(macfb_rom), 1, 9, 0xf);
+}
+
 static void macfb_sysbus_reset(DeviceState *d)
 {
     MacfbSysBusState *s = MACFB(d);
     macfb_reset(&s->macfb);
 }
 
+static void macfb_nubus_reset(DeviceState *d)
+{
+    MacfbNubusState *s = NUBUS_MACFB(d);
+    macfb_reset(&s->macfb);
+}
+
 static Property macfb_sysbus_properties[] = {
     DEFINE_PROP_UINT32("width", MacfbSysBusState, macfb.width, 640),
     DEFINE_PROP_UINT32("height", MacfbSysBusState, macfb.height, 480),
@@ -393,6 +420,13 @@ static Property macfb_sysbus_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static Property macfb_nubus_properties[] = {
+    DEFINE_PROP_UINT32("width", MacfbNubusState, macfb.width, 640),
+    DEFINE_PROP_UINT32("height", MacfbNubusState, macfb.height, 480),
+    DEFINE_PROP_UINT8("depth", MacfbNubusState, macfb.depth, 8),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void macfb_sysbus_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -404,6 +438,19 @@ static void macfb_sysbus_class_init(ObjectClass *klass, void *data)
     dc->props = macfb_sysbus_properties;
 }
 
+static void macfb_nubus_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    MacfbNubusDeviceClass *ndc = MACFB_NUBUS_DEVICE_CLASS(klass);
+
+    device_class_set_parent_realize(dc, macfb_nubus_realize,
+                                    &ndc->parent_realize);
+    dc->desc = "Nubus Macintosh framebuffer";
+    dc->reset = macfb_nubus_reset;
+    dc->vmsd = &vmstate_macfb;
+    dc->props = macfb_nubus_properties;
+}
+
 static TypeInfo macfb_sysbus_info = {
     .name          = TYPE_MACFB,
     .parent        = TYPE_SYS_BUS_DEVICE,
@@ -411,9 +458,18 @@ static TypeInfo macfb_sysbus_info = {
     .class_init    = macfb_sysbus_class_init,
 };
 
+static TypeInfo macfb_nubus_info = {
+    .name          = TYPE_NUBUS_MACFB,
+    .parent        = TYPE_NUBUS_DEVICE,
+    .instance_size = sizeof(MacfbNubusState),
+    .class_init    = macfb_nubus_class_init,
+    .class_size    = sizeof(MacfbNubusDeviceClass),
+};
+
 static void macfb_register_types(void)
 {
     type_register_static(&macfb_sysbus_info);
+    type_register_static(&macfb_nubus_info);
 }
 
 type_init(macfb_register_types)
diff --git a/include/hw/display/macfb.h b/include/hw/display/macfb.h
index 3fe2592735..26367ae2c4 100644
--- a/include/hw/display/macfb.h
+++ b/include/hw/display/macfb.h
@@ -40,4 +40,25 @@ typedef struct {
     MacfbState macfb;
 } MacfbSysBusState;
 
+#define MACFB_NUBUS_DEVICE_CLASS(class) \
+    OBJECT_CLASS_CHECK(MacfbNubusDeviceClass, (class), TYPE_NUBUS_MACFB)
+#define MACFB_NUBUS_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(MacfbNubusDeviceClass, (obj), TYPE_NUBUS_MACFB)
+
+typedef struct MacfbNubusDeviceClass {
+    DeviceClass parent_class;
+
+    DeviceRealize parent_realize;
+} MacfbNubusDeviceClass;
+
+#define TYPE_NUBUS_MACFB "nubus-macfb"
+#define NUBUS_MACFB(obj) \
+    OBJECT_CHECK(MacfbNubusState, (obj), TYPE_NUBUS_MACFB)
+
+typedef struct {
+    NubusDevice busdev;
+
+    MacfbState macfb;
+} MacfbNubusState;
+
 #endif
-- 
2.11.0
