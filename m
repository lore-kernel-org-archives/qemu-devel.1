Received: from eggs.gnu.org ([2001:4830:134:3::10]:48052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fRNf5-0007mz-GE
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 16:07:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fRNf2-0006vg-9s
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 16:07:03 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri,  8 Jun 2018 22:05:52 +0200
Message-Id: <20180608200558.386-8-laurent@vivier.eu>
In-Reply-To: <20180608200558.386-1-laurent@vivier.eu>
References: <20180608200558.386-1-laurent@vivier.eu>
Subject: [Qemu-devel] [RFC 07/13] hw/m68k: add Nubus support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, qemu-block@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Laurent Vivier <laurent@vivier.eu>

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/Makefile.objs         |   1 +
 hw/display/macfb.c       |  67 +++++++++++-
 hw/nubus/Makefile.objs   |   4 +
 hw/nubus/mac.c           | 112 +++++++++++++++++++
 hw/nubus/nubus-bridge.c  |  34 ++++++
 hw/nubus/nubus-bus.c     |  60 +++++++++++
 hw/nubus/nubus-device.c  | 275 +++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/nubus/mac.h   |  24 +++++
 include/hw/nubus/nubus.h |  89 +++++++++++++++
 include/qemu/typedefs.h  |   2 +
 10 files changed, 663 insertions(+), 5 deletions(-)
 create mode 100644 hw/nubus/Makefile.objs
 create mode 100644 hw/nubus/mac.c
 create mode 100644 hw/nubus/nubus-bridge.c
 create mode 100644 hw/nubus/nubus-bus.c
 create mode 100644 hw/nubus/nubus-device.c
 create mode 100644 include/hw/nubus/mac.h
 create mode 100644 include/hw/nubus/nubus.h

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index a19c1417ed..8c97b4b97b 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -35,6 +35,7 @@ devices-dirs-$(CONFIG_SOFTMMU) += watchdog/
 devices-dirs-$(CONFIG_SOFTMMU) += xen/
 devices-dirs-$(CONFIG_MEM_HOTPLUG) += mem/
 devices-dirs-$(CONFIG_SOFTMMU) += smbios/
+devices-dirs-$(CONFIG_NUBUS) += nubus/
 devices-dirs-y += core/
 common-obj-y += $(devices-dirs-y)
 obj-y += $(devices-dirs-y)
diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index b2dd300a80..295fd0fc8a 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -14,9 +14,12 @@
 #include "hw/sysbus.h"
 #include "ui/console.h"
 #include "ui/pixel_ops.h"
+#include "hw/nubus/nubus.h"
+
+#define VIDEO_BASE 0x00001000
+#define DAFB_BASE  0x00800000
 
 struct MacfbState {
-    SysBusDevice busdev;
     MemoryRegion mem_vram;
     MemoryRegion mem_ctrl;
     QemuConsole *con;
@@ -219,10 +222,10 @@ static void macfb_init(DeviceState *dev, MacfbState *s)
 
     s->con = graphic_console_init(dev, 0, &macfb_ops, s);
 
-    memory_region_init_io(&s->mem_ctrl, NULL, &macfb_ctrl_ops, s, "ctrl",
+    memory_region_init_io(&s->mem_ctrl, NULL, &macfb_ctrl_ops, s, "macfb-ctrl",
                           0x1000);
-    memory_region_init_ram_ptr(&s->mem_vram, NULL, "vram", MACFB_VRAM_SIZE,
-                               s->vram);
+    memory_region_init_ram_ptr(&s->mem_vram, NULL, "macfb-vram",
+                               MACFB_VRAM_SIZE, s->vram);
     vmstate_register_ram(&s->mem_vram, dev);
     memory_region_set_coalescing(&s->mem_vram);
 }
@@ -232,6 +235,11 @@ typedef struct {
     MacfbState macfb;
 } MacfbSysBusState;
 
+typedef struct {
+    NubusDevice busdev;
+    MacfbState macfb;
+} MacfbNubusState;
+
 static int macfb_sysbus_init(SysBusDevice *dev)
 {
     MacfbState *s =  &MACFB(dev)->macfb;
@@ -243,12 +251,34 @@ static int macfb_sysbus_init(SysBusDevice *dev)
     return 0;
 }
 
+const uint8_t macfb_rom[] = {
+    255, 0, 0, 0,
+};
+
+static int macfb_nubus_init(NubusDevice *dev)
+{
+    MacfbState *s = &DO_UPCAST(MacfbNubusState, busdev, dev)->macfb;
+
+    macfb_init(DEVICE(dev), s);
+    nubus_add_slot_mmio(dev, DAFB_BASE, &s->mem_ctrl);
+    nubus_add_slot_mmio(dev, VIDEO_BASE, &s->mem_vram);
+    nubus_register_rom(dev, macfb_rom, sizeof(macfb_rom), 1, 9, 0xf);
+
+    return 0;
+}
+
 static void macfb_sysbus_reset(DeviceState *d)
 {
     MacfbSysBusState *s = MACFB(d);
     macfb_reset(&s->macfb);
 }
 
+static void macfb_nubus_reset(DeviceState *d)
+{
+    MacfbNubusState *s = DO_UPCAST(MacfbNubusState, busdev.qdev, d);
+    macfb_reset(&s->macfb);
+}
+
 static Property macfb_sysbus_properties[] = {
     DEFINE_PROP_UINT32("width", MacfbSysBusState, macfb.width, 640),
     DEFINE_PROP_UINT32("height", MacfbSysBusState, macfb.height, 480),
@@ -256,18 +286,37 @@ static Property macfb_sysbus_properties[] = {
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
     SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
     k->init = macfb_sysbus_init;
-    dc->desc = "Macintosh framebuffer";
+    dc->desc = "SysBus Macintosh framebuffer";
     dc->reset = macfb_sysbus_reset;
     dc->vmsd = &vmstate_macfb;
     dc->props = macfb_sysbus_properties;
 }
 
+static void macfb_nubus_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    NubusDeviceClass *k = NUBUS_DEVICE_CLASS(klass);
+
+    k->init = macfb_nubus_init;
+    dc->desc = "Nubus Macintosh framebuffer";
+    dc->reset = macfb_nubus_reset;
+    dc->vmsd = &vmstate_macfb;
+    dc->props = macfb_nubus_properties;
+}
+
 static TypeInfo macfb_sysbus_info = {
     .name          = TYPE_MACFB,
     .parent        = TYPE_SYS_BUS_DEVICE,
@@ -275,9 +324,17 @@ static TypeInfo macfb_sysbus_info = {
     .class_init    = macfb_sysbus_class_init,
 };
 
+static TypeInfo macfb_nubus_info = {
+    .name          = "nubus-macfb",
+    .parent        = TYPE_NUBUS_DEVICE,
+    .instance_size = sizeof(MacfbNubusState),
+    .class_init    = macfb_nubus_class_init,
+};
+
 static void macfb_register_types(void)
 {
     type_register_static(&macfb_sysbus_info);
+    type_register_static(&macfb_nubus_info);
 }
 
 type_init(macfb_register_types)
diff --git a/hw/nubus/Makefile.objs b/hw/nubus/Makefile.objs
new file mode 100644
index 0000000000..812c8ea92f
--- /dev/null
+++ b/hw/nubus/Makefile.objs
@@ -0,0 +1,4 @@
+common-obj-y += nubus-device.o
+common-obj-y += nubus-bus.o
+common-obj-y += nubus-bridge.o
+common-obj-$(CONFIG_MAC) += mac.o
diff --git a/hw/nubus/mac.c b/hw/nubus/mac.c
new file mode 100644
index 0000000000..ba366d3705
--- /dev/null
+++ b/hw/nubus/mac.c
@@ -0,0 +1,112 @@
+/*
+ *  Copyright (c) 2013-2018 Laurent Vivier <laurent@vivier.eu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "hw/nubus/mac.h"
+
+static void mac_nubus_slot_write(void *opaque, hwaddr addr, uint64_t val,
+                                       unsigned int size)
+{
+}
+
+
+static uint64_t mac_nubus_slot_read(void *opaque, hwaddr addr,
+                                    unsigned int size)
+{
+    return 0;
+}
+
+static const MemoryRegionOps mac_nubus_slot_ops = {
+    .read  = mac_nubus_slot_read,
+    .write = mac_nubus_slot_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
+};
+
+static void mac_nubus_super_slot_write(void *opaque, hwaddr addr, uint64_t val,
+                                       unsigned int size)
+{
+}
+
+static uint64_t mac_nubus_super_slot_read(void *opaque, hwaddr addr,
+                                          unsigned int size)
+{
+    return 0;
+}
+
+static const MemoryRegionOps mac_nubus_super_slot_ops = {
+    .read  = mac_nubus_super_slot_read,
+    .write = mac_nubus_super_slot_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
+};
+
+static int mac_nubus_initfn(SysBusDevice *dev)
+{
+    MacNubusState *s = DO_UPCAST(MacNubusState, sysbus_dev, dev);
+    MemoryRegion *super_slot_io = g_malloc(sizeof(MemoryRegion));;
+    MemoryRegion *slot_io = g_malloc(sizeof(MemoryRegion));
+
+    memory_region_init_io(super_slot_io, NULL, &mac_nubus_super_slot_ops,
+                          s, "nubus-super-slots",
+                          NUBUS_SUPER_SLOT_NB * NUBUS_SUPER_SLOT_SIZE);
+
+    memory_region_init_io(slot_io, NULL, &mac_nubus_slot_ops,
+                          s, "nubus-slots",
+                          NUBUS_SLOT_NB * NUBUS_SLOT_SIZE);
+
+    sysbus_init_mmio(dev, super_slot_io);
+    sysbus_init_mmio(dev, slot_io);
+
+    s->bus = nubus_bus_new(DEVICE(s), super_slot_io, slot_io);
+
+    return 0;
+}
+
+static void mac_nubus_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
+
+    k->init = mac_nubus_initfn;
+    dc->desc = "Nubus bridge";
+}
+
+static const TypeInfo mac_nubus_type_info = {
+    .name          = TYPE_MAC_NUBUS_BRIDGE,
+    .parent        = TYPE_NUBUS_BRIDGE,
+    .instance_size = sizeof(MacNubusState),
+    .class_init    = mac_nubus_class_init,
+};
+
+
+NubusBus *nubus_mac_new(hwaddr super_slot_base, hwaddr slot_base)
+{
+    DeviceState *dev;
+
+    dev = qdev_create(NULL, TYPE_MAC_NUBUS_BRIDGE);
+    qdev_init_nofail(dev);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, super_slot_base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, slot_base);
+
+    return MAC_NUBUS_BRIDGE(dev)->bus;
+}
+
+static void mac_nubus_register_types(void)
+{
+    type_register_static(&mac_nubus_type_info);
+}
+
+type_init(mac_nubus_register_types)
diff --git a/hw/nubus/nubus-bridge.c b/hw/nubus/nubus-bridge.c
new file mode 100644
index 0000000000..cd8c6a91eb
--- /dev/null
+++ b/hw/nubus/nubus-bridge.c
@@ -0,0 +1,34 @@
+/*
+ * QEMU Macintosh Nubus
+ *
+ * Copyright (c) 2013-2018 Laurent Vivier <laurent@vivier.eu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "hw/nubus/nubus.h"
+
+static void nubus_bridge_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->fw_name = "nubus";
+}
+
+static const TypeInfo nubus_bridge_info = {
+    .name          = TYPE_NUBUS_BRIDGE,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(SysBusDevice),
+    .class_init    = nubus_bridge_class_init,
+};
+
+static void nubus_register_types(void)
+{
+    type_register_static(&nubus_bridge_info);
+}
+
+type_init(nubus_register_types)
diff --git a/hw/nubus/nubus-bus.c b/hw/nubus/nubus-bus.c
new file mode 100644
index 0000000000..fd1344e554
--- /dev/null
+++ b/hw/nubus/nubus-bus.c
@@ -0,0 +1,60 @@
+/*
+ * QEMU Macintosh Nubus
+ *
+ * Copyright (c) 2013-2018 Laurent Vivier <laurent@vivier.eu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "hw/nubus/nubus.h"
+
+static NubusBus *nubus;
+
+static void nubus_bus_initfn(Object *obj)
+{
+    NubusBus *bus = NUBUS_BUS(obj);;
+    bus->current_slot = NUBUS_FIRST_SLOT;
+}
+
+static void nubus_bus_class_init(ObjectClass *klass, void *data)
+{
+}
+
+static const TypeInfo nubus_bus_info = {
+    .name = TYPE_NUBUS_BUS,
+    .parent = TYPE_BUS,
+    .instance_size = sizeof(NubusBus),
+    .instance_init = nubus_bus_initfn,
+    .class_init = nubus_bus_class_init,
+};
+
+NubusBus *nubus_bus_new(DeviceState *dev, MemoryRegion *super_slot_io,
+                       MemoryRegion *slot_io)
+{
+    if (nubus) {
+        fprintf(stderr, "Can't create a second Nubus bus\n");
+        return NULL;
+    }
+
+    if (NULL == dev) {
+        dev = qdev_create(NULL, "nubus-bridge");
+        qdev_init_nofail(dev);
+    }
+
+    nubus = NUBUS_BUS(qbus_create(TYPE_NUBUS_BUS, dev, NULL));
+
+    nubus->super_slot_io = super_slot_io;
+    nubus->slot_io = slot_io;
+
+    return nubus;
+}
+
+static void nubus_register_types(void)
+{
+    type_register_static(&nubus_bus_info);
+}
+
+type_init(nubus_register_types)
diff --git a/hw/nubus/nubus-device.c b/hw/nubus/nubus-device.c
new file mode 100644
index 0000000000..0c8023d46a
--- /dev/null
+++ b/hw/nubus/nubus-device.c
@@ -0,0 +1,275 @@
+/*
+ * QEMU Macintosh Nubus
+ *
+ * Copyright (c) 2013-2018 Laurent Vivier <laurent@vivier.eu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "hw/nubus/nubus.h"
+
+/* The Format Block Structure */
+
+#define FBLOCK_DIRECTORY_OFFSET 0
+#define FBLOCK_LENGTH           4
+#define FBLOCK_CRC              8
+#define FBLOCK_REVISION_LEVEL   12
+#define FBLOCK_FORMAT           13
+#define FBLOCK_TEST_PATTERN     14
+#define FBLOCK_RESERVED         18
+#define FBLOCK_BYTE_LANES       19
+
+#define FBLOCK_SIZE             20
+
+#    define FBLOCK_PATTERN_VAL  0x5a932bc7
+
+static uint64_t nubus_fblock_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    NubusDevice *dev = opaque;
+    uint64_t val;
+
+#define BYTE(v, b) (((v) >> (24 - 8 * (b))) & 0xff)
+    switch (addr) {
+    case FBLOCK_BYTE_LANES:
+        val = dev->byte_lanes;
+        val |= (val ^ 0xf) << 4;
+        break;
+    case FBLOCK_RESERVED:
+        val = 0x00;
+        break;
+    case FBLOCK_TEST_PATTERN...FBLOCK_TEST_PATTERN + 3:
+        val = BYTE(FBLOCK_PATTERN_VAL, addr - FBLOCK_TEST_PATTERN);
+        break;
+    case FBLOCK_FORMAT:
+        val = dev->rom_format;
+        break;
+    case FBLOCK_REVISION_LEVEL:
+        val = dev->rom_rev;
+        break;
+    case FBLOCK_CRC...FBLOCK_CRC + 3:
+        val = BYTE(dev->rom_crc, addr - FBLOCK_CRC);
+        break;
+    case FBLOCK_LENGTH...FBLOCK_LENGTH + 3:
+        val = BYTE(dev->rom_length, addr - FBLOCK_LENGTH);
+        break;
+    case FBLOCK_DIRECTORY_OFFSET...FBLOCK_DIRECTORY_OFFSET + 3:
+        val = BYTE(dev->directory_offset, addr - FBLOCK_DIRECTORY_OFFSET);
+        break;
+    default:
+        val = 0;
+        break;
+    }
+    return val;
+}
+
+static void nubus_fblock_write(void *opaque, hwaddr addr, uint64_t val,
+                               unsigned int size)
+{
+    /* READ-ONLY */
+}
+
+static const MemoryRegionOps nubus_format_block_ops = {
+    .read = nubus_fblock_read,
+    .write = nubus_fblock_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    }
+};
+
+static void nubus_register_format_block(NubusDevice *dev)
+{
+    char fblock_name[27];
+    NubusBus *bus = nubus_bus_from_device(dev);
+
+    sprintf(fblock_name, "nubus-slot-%d-format-block", dev->slot_nb);
+
+    hwaddr fblock_offset = (dev->slot_nb + 1) * NUBUS_SLOT_SIZE - FBLOCK_SIZE;
+    memory_region_init_io(&dev->fblock_io, NULL, &nubus_format_block_ops,
+                          dev, fblock_name, FBLOCK_SIZE);
+    memory_region_add_subregion(bus->slot_io, fblock_offset,
+                                &dev->fblock_io);
+}
+
+NubusDevice *nubus_create(NubusBus *bus, const char *name)
+{
+    DeviceState *dev;
+    NubusDevice *d;
+
+    if (!bus) {
+        hw_error("Tried to create nubus device %s with no nubus bus present.",
+                 name);
+    }
+
+    if (bus->current_slot < NUBUS_FIRST_SLOT ||
+        bus->current_slot > NUBUS_LAST_SLOT) {
+        fprintf(stderr, "Cannot register nubus card '%s', not enough slot\n",
+                name);
+        return NULL;
+    }
+
+    dev = qdev_create(&bus->qbus, name);
+
+    d = NUBUS_DEVICE(dev);
+    d->slot_nb = bus->current_slot++;
+    nubus_register_format_block(d);
+
+    return d;
+}
+
+NubusDevice *nubus_try_create(NubusBus *bus, const char *name)
+{
+    DeviceState *dev;
+    NubusDevice *d;
+
+    if (!bus) {
+        hw_error("Tried to create nubus device %s with no nubus bus present.",
+                 name);
+    }
+
+    if (bus->current_slot < NUBUS_FIRST_SLOT ||
+        bus->current_slot > NUBUS_LAST_SLOT) {
+        fprintf(stderr, "Cannot register nubus card '%s', not enough slot\n",
+                name);
+        return NULL;
+    }
+
+    dev = qdev_try_create(&bus->qbus, name);
+    if (!dev) {
+        return NULL;
+    }
+
+    d = NUBUS_DEVICE(dev);
+    d->slot_nb = bus->current_slot++;
+    nubus_register_format_block(d);
+
+    return d;
+}
+
+NubusDevice *nubus_create_simple(NubusBus *bus, const char *name)
+{
+    NubusDevice *dev;
+
+    dev = nubus_create(bus, name);
+    qdev_init_nofail(&dev->qdev);
+
+    return dev;
+}
+
+void nubus_add_slot_mmio(NubusDevice *dev,
+                         hwaddr offset,
+                         MemoryRegion *subregion)
+{
+    NubusBus *bus = nubus_bus_from_device(dev);
+    hwaddr slot_offset = dev->slot_nb * NUBUS_SLOT_SIZE + offset;
+    memory_region_add_subregion(bus->slot_io, slot_offset, subregion);
+}
+
+void nubus_add_super_slot_mmio(NubusDevice *dev,
+                               hwaddr offset,
+                               MemoryRegion *subregion)
+{
+    NubusBus *bus = nubus_bus_from_device(dev);
+    hwaddr slot_offset = (dev->slot_nb - 6) * NUBUS_SUPER_SLOT_SIZE + offset;
+    memory_region_add_subregion(bus->super_slot_io, slot_offset, subregion);
+}
+
+static void mac_nubus_rom_write(void *opaque, hwaddr addr, uint64_t val,
+                                       unsigned int size)
+{
+}
+
+static uint64_t mac_nubus_rom_read(void *opaque, hwaddr addr,
+                                    unsigned int size)
+{
+    NubusDevice *dev = opaque;
+
+    return dev->rom[addr];
+}
+
+static const MemoryRegionOps mac_nubus_rom_ops = {
+    .read  = mac_nubus_rom_read,
+    .write = mac_nubus_rom_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
+};
+
+
+void nubus_register_rom(NubusDevice *dev, const uint8_t *rom, uint32_t size,
+                        int revision, int format, uint8_t byte_lanes)
+{
+    NubusBus *bus = nubus_bus_from_device(dev);
+    hwaddr rom_offset;
+    char rom_name[18];
+
+    /* FIXME : really compute CRC */
+    dev->rom_length = 0;
+    dev->rom_crc = 0;
+
+    dev->rom_rev = revision;
+    dev->rom_format = format;
+
+    dev->byte_lanes = byte_lanes;
+    dev->directory_offset = -size;
+
+    /* ROM */
+
+    dev->rom = rom;
+    sprintf(rom_name, "nubus-slot-%d-rom", dev->slot_nb);
+    memory_region_init_io(&dev->rom_io, NULL, &mac_nubus_rom_ops,
+                          dev, rom_name, size);
+    memory_region_set_readonly(&dev->rom_io, true);
+
+    rom_offset = (dev->slot_nb + 1) * NUBUS_SLOT_SIZE - FBLOCK_SIZE +
+                 dev->directory_offset;
+    memory_region_add_subregion(bus->slot_io, rom_offset, &dev->rom_io);
+
+}
+
+
+static void nubus_device_init(Object *obj)
+{
+}
+
+static int nubus_qdev_init(DeviceState *qdev)
+{
+    NubusDevice *dev = NUBUS_DEVICE(qdev);
+    NubusDeviceClass *klass = NUBUS_DEVICE_GET_CLASS(dev);
+
+    if (klass->init) {
+        return klass->init(dev);
+    }
+
+    return 0;
+}
+
+static void nubus_device_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *k = DEVICE_CLASS(klass);
+    k->init = nubus_qdev_init;
+    k->bus_type = TYPE_NUBUS_BUS;
+}
+
+static const TypeInfo nubus_device_type_info = {
+    .name = TYPE_NUBUS_DEVICE,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(NubusDevice),
+    .instance_init = nubus_device_init,
+    .abstract = true,
+    .class_size = sizeof(NubusDeviceClass),
+    .class_init = nubus_device_class_init,
+};
+
+static void nubus_register_types(void)
+{
+    type_register_static(&nubus_device_type_info);
+}
+
+type_init(nubus_register_types)
diff --git a/include/hw/nubus/mac.h b/include/hw/nubus/mac.h
new file mode 100644
index 0000000000..502d35ba9d
--- /dev/null
+++ b/include/hw/nubus/mac.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (c) 2013-2018 Laurent Vivier <laurent@vivier.eu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef HW_NUBUS_MAC_H
+#define HW_NUBUS_MAC_H
+
+#include "hw/nubus/nubus.h"
+
+#define TYPE_MAC_NUBUS_BRIDGE "mac-nubus-bridge"
+#define MAC_NUBUS_BRIDGE(obj) OBJECT_CHECK(MacNubusState, (obj), \
+                                           TYPE_MAC_NUBUS_BRIDGE)
+
+typedef struct MacNubusState {
+    SysBusDevice sysbus_dev;
+    NubusBus *bus;
+} MacNubusState;
+
+NubusBus *nubus_mac_new(hwaddr super_slot_base, hwaddr slot_base);
+#endif
diff --git a/include/hw/nubus/nubus.h b/include/hw/nubus/nubus.h
new file mode 100644
index 0000000000..c0cbbfea33
--- /dev/null
+++ b/include/hw/nubus/nubus.h
@@ -0,0 +1,89 @@
+/*
+ * Copyright (c) 2013-2018 Laurent Vivier <laurent@vivier.eu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef HW_NUBUS_NUBUS_H
+#define HW_NUBUS_NUBUS_H
+
+#include "hw/qdev.h"
+#include "exec/address-spaces.h"
+
+#define NUBUS_SUPER_SLOT_SIZE 0x10000000U
+#define NUBUS_SUPER_SLOT_NB   0x9
+
+#define NUBUS_SLOT_SIZE       0x01000000
+#define NUBUS_SLOT_NB         0xF
+
+#define NUBUS_FIRST_SLOT      0x9
+#define NUBUS_LAST_SLOT       0xF
+
+#define TYPE_NUBUS_DEVICE "nubus-device"
+#define NUBUS_DEVICE(obj) \
+     OBJECT_CHECK(NubusDevice, (obj), TYPE_NUBUS_DEVICE)
+#define NUBUS_DEVICE_CLASS(klass) \
+     OBJECT_CLASS_CHECK(NubusDeviceClass, (klass), TYPE_NUBUS_DEVICE)
+#define NUBUS_DEVICE_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(NubusDeviceClass, (obj), TYPE_NUBUS_DEVICE)
+
+#define TYPE_NUBUS_BUS "nubus-bus"
+#define NUBUS_BUS(obj) OBJECT_CHECK(NubusBus, (obj), TYPE_NUBUS_BUS)
+
+#define TYPE_NUBUS_BRIDGE "nubus-bridge"
+#define NUBUS_BRIDGE(obj) OBJECT_CHECK(NubusBridge, (obj), TYPE_NUBUS_BRIDGE)
+
+typedef struct NubusDeviceClass {
+    DeviceClass parent_class;
+    int (*init)(NubusDevice *dev);
+} NubusDeviceClass;
+
+struct NubusBus {
+    BusState qbus;
+    int current_slot;
+    MemoryRegion *super_slot_io;
+    MemoryRegion *slot_io;
+    qemu_irq *irqs;
+};
+
+struct NubusDevice {
+    DeviceState qdev;
+
+    int slot_nb;
+
+    /* Format Block */
+
+    MemoryRegion fblock_io;
+
+    uint32_t rom_length;
+    uint32_t rom_crc;
+    uint8_t rom_rev;
+    uint8_t rom_format;
+    uint8_t byte_lanes;
+    int32_t directory_offset;
+
+    /* ROM */
+
+    MemoryRegion rom_io;
+    const uint8_t *rom;
+};
+
+NubusBus *nubus_bus_new(DeviceState *dev, MemoryRegion *super_slot_io,
+                       MemoryRegion *slot_io);
+NubusDevice *nubus_try_create(NubusBus *bus, const char *name);
+NubusDevice *nubus_create_simple(NubusBus *bus, const char *name);
+NubusDevice *nubus_create(NubusBus *bus, const char *name);
+void nubus_add_slot_mmio(NubusDevice *dev, hwaddr offset,
+                         MemoryRegion *subregion);
+void nubus_add_super_slot_mmio(NubusDevice *dev, hwaddr offset,
+                               MemoryRegion *subregion);
+void nubus_register_rom(NubusDevice *dev, const uint8_t *rom, uint32_t size,
+                        int revision, int format, uint8_t byte_lanes);
+
+static inline NubusBus *nubus_bus_from_device(NubusDevice *d)
+{
+    return NUBUS_BUS(qdev_get_parent_bus(DEVICE(d)));
+}
+#endif
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 325c72de33..91a50fe954 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -43,6 +43,8 @@ typedef struct I2SCodec I2SCodec;
 typedef struct ISABus ISABus;
 typedef struct ISADevice ISADevice;
 typedef struct IsaDma IsaDma;
+typedef struct NubusBus NubusBus;
+typedef struct NubusDevice NubusDevice;
 typedef struct MACAddr MACAddr;
 typedef struct MachineClass MachineClass;
 typedef struct MachineState MachineState;
-- 
2.14.4
