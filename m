Received: from eggs.gnu.org ([2001:4830:134:3::10]:51609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1d1J80-0005em-Uo
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 16:56:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1d1J7x-00050J-Ro
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 16:56:36 -0400
Message-Id: <0bc0181d69d59a060b1cb65042c4ce2f6aec514e.1492721026.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1492721026.git.balaton@eik.bme.hu>
References: <cover.1492721026.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Thu, 20 Apr 2017 22:43:46 +0200
Subject: [Qemu-devel] [PATCH v5 04/13] sm501: QOMify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

Adding vmstate saving is not in this patch because the state structure
will be changed in further patches, then another patch will add
vmstate descriptor after those changes.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---

v2: Add memory regions to device state instead of allocating them
v3: Added reset function and make sure to use adjusted mem size when
    creating local mem region (also print a warning when mem size was
    adjusted)
v4: Replace warning for corrected memory size with a hard error

 hw/display/sm501.c   | 170 +++++++++++++++++++++++++++++++++++++--------------
 hw/sh4/r2d.c         |  11 +++-
 include/hw/devices.h |   5 --
 3 files changed, 133 insertions(+), 53 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 6e74200..571a7e6 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -59,8 +59,8 @@
 #define SM501_DPRINTF(fmt, ...) do {} while (0)
 #endif
 
-
 #define MMIO_BASE_OFFSET 0x3e00000
+#define MMIO_SIZE 0x200000
 
 /* SM501 register definitions taken from "linux/include/linux/sm501-regs.h" */
 
@@ -465,6 +465,10 @@ typedef struct SM501State {
     uint32_t local_mem_size_index;
     uint8_t *local_mem;
     MemoryRegion local_mem_region;
+    MemoryRegion mmio_region;
+    MemoryRegion system_config_region;
+    MemoryRegion disp_ctrl_region;
+    MemoryRegion twoD_engine_region;
     uint32_t last_width;
     uint32_t last_height;
 
@@ -1404,21 +1408,8 @@ static const GraphicHwOps sm501_ops = {
     .gfx_update  = sm501_update_display,
 };
 
-void sm501_init(MemoryRegion *address_space_mem, uint32_t base,
-                uint32_t local_mem_bytes, qemu_irq irq, Chardev *chr)
+static void sm501_reset(SM501State *s)
 {
-    SM501State *s;
-    DeviceState *dev;
-    MemoryRegion *sm501_system_config = g_new(MemoryRegion, 1);
-    MemoryRegion *sm501_disp_ctrl = g_new(MemoryRegion, 1);
-    MemoryRegion *sm501_2d_engine = g_new(MemoryRegion, 1);
-
-    /* allocate management data region */
-    s = g_new0(SM501State, 1);
-    s->base = base;
-    s->local_mem_size_index = get_local_mem_size_index(local_mem_bytes);
-    SM501_DPRINTF("local mem size=%x. index=%d\n", get_local_mem_size(s),
-                  s->local_mem_size_index);
     s->system_control = 0x00100000; /* 2D engine FIFO empty */
     /* Bits 17 (SH), 7 (CDR), 6:5 (Test), 2:0 (Bus) are all supposed
      * to be determined at reset by GPIO lines which set config bits.
@@ -1429,51 +1420,138 @@ void sm501_init(MemoryRegion *address_space_mem, uint32_t base,
      *  BUS = 0 : Hitachi SH3/SH4
      */
     s->misc_control = SM501_MISC_DAC_POWER;
+    s->gpio_31_0_control = 0;
+    s->gpio_63_32_control = 0;
+    s->dram_control = 0;
     s->arbitration_control = 0x05146732;
+    s->irq_mask = 0;
+    s->misc_timing = 0;
+    s->power_mode_control = 0;
     s->dc_panel_control = 0x00010000; /* FIFO level 3 */
     s->dc_crt_control = 0x00010000;
+    s->twoD_control = 0;
+}
 
-    /* allocate local memory */
-    memory_region_init_ram(&s->local_mem_region, NULL, "sm501.local",
-                           local_mem_bytes, &error_fatal);
+static void sm501_init(SM501State *s, DeviceState *dev, uint32_t base,
+                       uint32_t local_mem_bytes)
+{
+    s->base = base;
+    s->local_mem_size_index = get_local_mem_size_index(local_mem_bytes);
+    SM501_DPRINTF("sm501 local mem size=%x. index=%d\n", get_local_mem_size(s),
+                  s->local_mem_size_index);
+
+    /* local memory */
+    memory_region_init_ram(&s->local_mem_region, OBJECT(dev), "sm501.local",
+                           get_local_mem_size(s), &error_fatal);
     vmstate_register_ram_global(&s->local_mem_region);
     memory_region_set_log(&s->local_mem_region, true, DIRTY_MEMORY_VGA);
     s->local_mem = memory_region_get_ram_ptr(&s->local_mem_region);
-    memory_region_add_subregion(address_space_mem, base, &s->local_mem_region);
-
-    /* map mmio */
-    memory_region_init_io(sm501_system_config, NULL, &sm501_system_config_ops,
-                          s, "sm501-system-config", 0x6c);
-    memory_region_add_subregion(address_space_mem, base + MMIO_BASE_OFFSET,
-                                sm501_system_config);
-    memory_region_init_io(sm501_disp_ctrl, NULL, &sm501_disp_ctrl_ops, s,
+
+    /* mmio */
+    memory_region_init(&s->mmio_region, OBJECT(dev), "sm501.mmio", MMIO_SIZE);
+    memory_region_init_io(&s->system_config_region, OBJECT(dev),
+                          &sm501_system_config_ops, s,
+                          "sm501-system-config", 0x6c);
+    memory_region_add_subregion(&s->mmio_region, SM501_SYS_CONFIG,
+                                &s->system_config_region);
+    memory_region_init_io(&s->disp_ctrl_region, OBJECT(dev),
+                          &sm501_disp_ctrl_ops, s,
                           "sm501-disp-ctrl", 0x1000);
-    memory_region_add_subregion(address_space_mem,
-                                base + MMIO_BASE_OFFSET + SM501_DC,
-                                sm501_disp_ctrl);
-    memory_region_init_io(sm501_2d_engine, NULL, &sm501_2d_engine_ops, s,
+    memory_region_add_subregion(&s->mmio_region, SM501_DC,
+                                &s->disp_ctrl_region);
+    memory_region_init_io(&s->twoD_engine_region, OBJECT(dev),
+                          &sm501_2d_engine_ops, s,
                           "sm501-2d-engine", 0x54);
-    memory_region_add_subregion(address_space_mem,
-                                base + MMIO_BASE_OFFSET + SM501_2D_ENGINE,
-                                sm501_2d_engine);
+    memory_region_add_subregion(&s->mmio_region, SM501_2D_ENGINE,
+                                &s->twoD_engine_region);
+
+    /* create qemu graphic console */
+    s->con = graphic_console_init(DEVICE(dev), 0, &sm501_ops, s);
+}
+
+#define TYPE_SYSBUS_SM501 "sysbus-sm501"
+#define SYSBUS_SM501(obj) \
+    OBJECT_CHECK(SM501SysBusState, (obj), TYPE_SYSBUS_SM501)
+
+typedef struct {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+    SM501State state;
+    uint32_t vram_size;
+    uint32_t base;
+    void *chr_state;
+} SM501SysBusState;
+
+static void sm501_realize_sysbus(DeviceState *dev, Error **errp)
+{
+    SM501SysBusState *s = SYSBUS_SM501(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    DeviceState *usb_dev;
+
+    sm501_init(&s->state, dev, s->base, s->vram_size);
+    if (get_local_mem_size(&s->state) != s->vram_size) {
+        error_setg(errp, "Invalid VRAM size, nearest valid size is %" PRIu32,
+                   get_local_mem_size(&s->state));
+        return;
+    }
+    sysbus_init_mmio(sbd, &s->state.local_mem_region);
+    sysbus_init_mmio(sbd, &s->state.mmio_region);
 
     /* bridge to usb host emulation module */
-    dev = qdev_create(NULL, "sysbus-ohci");
-    qdev_prop_set_uint32(dev, "num-ports", 2);
-    qdev_prop_set_uint64(dev, "dma-offset", base);
-    qdev_init_nofail(dev);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0,
-                    base + MMIO_BASE_OFFSET + SM501_USB_HOST);
-    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
+    usb_dev = qdev_create(NULL, "sysbus-ohci");
+    qdev_prop_set_uint32(usb_dev, "num-ports", 2);
+    qdev_prop_set_uint64(usb_dev, "dma-offset", s->base);
+    qdev_init_nofail(usb_dev);
+    memory_region_add_subregion(&s->state.mmio_region, SM501_USB_HOST,
+                       sysbus_mmio_get_region(SYS_BUS_DEVICE(usb_dev), 0));
+    sysbus_pass_irq(sbd, SYS_BUS_DEVICE(usb_dev));
 
     /* bridge to serial emulation module */
-    if (chr) {
-        serial_mm_init(address_space_mem,
-                       base + MMIO_BASE_OFFSET + SM501_UART0, 2,
+    if (s->chr_state) {
+        serial_mm_init(&s->state.mmio_region, SM501_UART0, 2,
                        NULL, /* TODO : chain irq to IRL */
-                       115200, chr, DEVICE_NATIVE_ENDIAN);
+                       115200, s->chr_state, DEVICE_NATIVE_ENDIAN);
     }
+}
 
-    /* create qemu graphic console */
-    s->con = graphic_console_init(DEVICE(dev), 0, &sm501_ops, s);
+static Property sm501_sysbus_properties[] = {
+    DEFINE_PROP_UINT32("vram-size", SM501SysBusState, vram_size, 0),
+    DEFINE_PROP_UINT32("base", SM501SysBusState, base, 0),
+    DEFINE_PROP_PTR("chr-state", SM501SysBusState, chr_state),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void sm501_reset_sysbus(DeviceState *dev)
+{
+    SM501SysBusState *s = SYSBUS_SM501(dev);
+    sm501_reset(&s->state);
 }
+
+static void sm501_sysbus_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = sm501_realize_sysbus;
+    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
+    dc->desc = "SM501 Multimedia Companion";
+    dc->props = sm501_sysbus_properties;
+    dc->reset = sm501_reset_sysbus;
+    /* Note: pointer property "chr-state" may remain null, thus
+     * no need for dc->cannot_instantiate_with_device_add_yet = true;
+     */
+}
+
+static const TypeInfo sm501_sysbus_info = {
+    .name          = TYPE_SYSBUS_SM501,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(SM501SysBusState),
+    .class_init    = sm501_sysbus_class_init,
+};
+
+static void sm501_register_types(void)
+{
+    type_register_static(&sm501_sysbus_info);
+}
+
+type_init(sm501_register_types)
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 6d06968..8f520ce 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -277,8 +277,15 @@ static void r2d_init(MachineState *machine)
     sysbus_connect_irq(busdev, 2, irq[PCI_INTC]);
     sysbus_connect_irq(busdev, 3, irq[PCI_INTD]);
 
-    sm501_init(address_space_mem, 0x10000000, SM501_VRAM_SIZE,
-               irq[SM501], serial_hds[2]);
+    dev = qdev_create(NULL, "sysbus-sm501");
+    busdev = SYS_BUS_DEVICE(dev);
+    qdev_prop_set_uint32(dev, "vram-size", SM501_VRAM_SIZE);
+    qdev_prop_set_uint32(dev, "base", 0x10000000);
+    qdev_prop_set_ptr(dev, "chr-state", serial_hds[2]);
+    qdev_init_nofail(dev);
+    sysbus_mmio_map(busdev, 0, 0x10000000);
+    sysbus_mmio_map(busdev, 1, 0x13e00000);
+    sysbus_connect_irq(busdev, 0, irq[SM501]);
 
     /* onboard CF (True IDE mode, Master only). */
     dinfo = drive_get(IF_IDE, 0, 0);
diff --git a/include/hw/devices.h b/include/hw/devices.h
index 7475b71..861ddea 100644
--- a/include/hw/devices.h
+++ b/include/hw/devices.h
@@ -62,9 +62,4 @@ void tc6393xb_gpio_out_set(TC6393xbState *s, int line,
 qemu_irq *tc6393xb_gpio_in_get(TC6393xbState *s);
 qemu_irq tc6393xb_l3v_get(TC6393xbState *s);
 
-/* sm501.c */
-void sm501_init(struct MemoryRegion *address_space_mem, uint32_t base,
-                uint32_t local_mem_bytes, qemu_irq irq,
-                Chardev *chr);
-
 #endif
-- 
2.7.4
