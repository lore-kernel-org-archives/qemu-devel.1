Received: from eggs.gnu.org ([2001:4830:134:3::10]:36900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faHs8-0001k7-9U
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:45:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faHs5-0004yA-1Q
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:45:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1faHs4-0004xh-PE
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:45:16 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BEA06308626D
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 09:45:15 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  3 Jul 2018 11:45:08 +0200
Message-Id: <20180703094508.25987-5-kraxel@redhat.com>
In-Reply-To: <20180703094508.25987-1-kraxel@redhat.com>
References: <20180703094508.25987-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 4/4] vga: disable global_vmstate for 3.0+
 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Move global_vmstate from vga_common_init() parameter to VGACommonState
field.  Set global_vmstate to true for isa vga devices, so nothing
changes here.  virtio-vga and secondary-vga already set global_vmstate
to false so no change here either.  All other pci vga devices get a new
global-vmstate property, defaulting to false.  A compat property flips
it to true for older machine types.

With this in place you don't get a vmstate section naming conflict any
more when adding multiple pci vga devices to your vm.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-Id: <20180702163345.17892-1-kraxel@redhat.com>
---
 hw/display/vga_int.h    |  3 ++-
 include/hw/compat.h     | 16 ++++++++++++++++
 hw/display/cirrus_vga.c |  9 ++++++---
 hw/display/qxl.c        |  3 ++-
 hw/display/vga-isa-mm.c |  3 ++-
 hw/display/vga-isa.c    |  3 ++-
 hw/display/vga-pci.c    |  5 +++--
 hw/display/vga.c        |  4 ++--
 hw/display/virtio-vga.c |  2 +-
 hw/display/vmware_vga.c |  4 +++-
 10 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
index f8fcf62a56..339661bc01 100644
--- a/hw/display/vga_int.h
+++ b/hw/display/vga_int.h
@@ -133,6 +133,7 @@ typedef struct VGACommonState {
     bool full_update_gfx;
     bool big_endian_fb;
     bool default_endian_fb;
+    bool global_vmstate;
     /* hardware mouse cursor support */
     uint32_t invalidated_y_table[VGA_MAX_HEIGHT / 32];
     uint32_t hw_cursor_x;
@@ -157,7 +158,7 @@ static inline int c6_to_8(int v)
     return (v << 2) | (b << 1) | b;
 }
 
-void vga_common_init(VGACommonState *s, Object *obj, bool global_vmstate);
+void vga_common_init(VGACommonState *s, Object *obj);
 void vga_init(VGACommonState *s, Object *obj, MemoryRegion *address_space,
               MemoryRegion *address_space_io, bool init_vga_ports);
 MemoryRegion *vga_init_io(VGACommonState *s, Object *obj,
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 44d5964060..c08f4040bb 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -10,6 +10,22 @@
         .driver   = "hda-audio",\
         .property = "use-timer",\
         .value    = "false",\
+    },{\
+        .driver   = "cirrus-vga",\
+        .property = "global-vmstate",\
+        .value    = "true",\
+    },{\
+        .driver   = "VGA",\
+        .property = "global-vmstate",\
+        .value    = "true",\
+    },{\
+        .driver   = "vmware-svga",\
+        .property = "global-vmstate",\
+        .value    = "true",\
+    },{\
+        .driver   = "qxl-vga",\
+        .property = "global-vmstate",\
+        .value    = "true",\
     },
 
 #define HW_COMPAT_2_11 \
diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 138ae961b9..1d050621f1 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -3048,7 +3048,8 @@ static void isa_cirrus_vga_realizefn(DeviceState *dev, Error **errp)
                    s->vram_size_mb);
         return;
     }
-    vga_common_init(s, OBJECT(dev), true);
+    s->global_vmstate = true;
+    vga_common_init(s, OBJECT(dev));
     cirrus_init_common(&d->cirrus_vga, OBJECT(dev), CIRRUS_ID_CLGD5430, 0,
                        isa_address_space(isadev),
                        isa_address_space_io(isadev));
@@ -3062,7 +3063,7 @@ static Property isa_cirrus_vga_properties[] = {
     DEFINE_PROP_UINT32("vgamem_mb", struct ISACirrusVGAState,
                        cirrus_vga.vga.vram_size_mb, 4),
     DEFINE_PROP_BOOL("blitter", struct ISACirrusVGAState,
-                       cirrus_vga.enable_blitter, true),
+                     cirrus_vga.enable_blitter, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -3105,7 +3106,7 @@ static void pci_cirrus_vga_realize(PCIDevice *dev, Error **errp)
          return;
      }
      /* setup VGA */
-     vga_common_init(&s->vga, OBJECT(dev), true);
+     vga_common_init(&s->vga, OBJECT(dev));
      cirrus_init_common(s, OBJECT(dev), device_id, 1, pci_address_space(dev),
                         pci_address_space_io(dev));
      s->vga.con = graphic_console_init(DEVICE(dev), 0, s->vga.hw_ops, &s->vga);
@@ -3134,6 +3135,8 @@ static Property pci_vga_cirrus_properties[] = {
                        cirrus_vga.vga.vram_size_mb, 4),
     DEFINE_PROP_BOOL("blitter", struct PCICirrusVGAState,
                      cirrus_vga.enable_blitter, true),
+    DEFINE_PROP_BOOL("global-vmstate", struct PCICirrusVGAState,
+                     cirrus_vga.vga.global_vmstate, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index a71714ccb4..3f740d7aa3 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2168,7 +2168,7 @@ static void qxl_realize_primary(PCIDevice *dev, Error **errp)
     qxl_init_ramsize(qxl);
     vga->vbe_size = qxl->vgamem_size;
     vga->vram_size_mb = qxl->vga.vram_size >> 20;
-    vga_common_init(vga, OBJECT(dev), true);
+    vga_common_init(vga, OBJECT(dev));
     vga_init(vga, OBJECT(dev),
              pci_address_space(dev), pci_address_space_io(dev), false);
     portio_list_init(&qxl->vga_port_list, OBJECT(dev), qxl_vga_portio_list,
@@ -2410,6 +2410,7 @@ static Property qxl_properties[] = {
 #endif
         DEFINE_PROP_UINT32("xres", PCIQXLDevice, xres, 0),
         DEFINE_PROP_UINT32("yres", PCIQXLDevice, yres, 0),
+        DEFINE_PROP_BOOL("global-vmstate", PCIQXLDevice, vga.global_vmstate, false),
         DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/display/vga-isa-mm.c b/hw/display/vga-isa-mm.c
index e887b45651..d2d6b32abf 100644
--- a/hw/display/vga-isa-mm.c
+++ b/hw/display/vga-isa-mm.c
@@ -131,7 +131,8 @@ int isa_vga_mm_init(hwaddr vram_base,
     s = g_malloc0(sizeof(*s));
 
     s->vga.vram_size_mb = VGA_RAM_SIZE >> 20;
-    vga_common_init(&s->vga, NULL, true);
+    s->vga.global_vmstate = true;
+    vga_common_init(&s->vga, NULL);
     vga_mm_init(s, vram_base, ctrl_base, it_shift, address_space);
 
     s->vga.con = graphic_console_init(NULL, 0, s->vga.hw_ops, s);
diff --git a/hw/display/vga-isa.c b/hw/display/vga-isa.c
index 469834add5..fa44242e0d 100644
--- a/hw/display/vga-isa.c
+++ b/hw/display/vga-isa.c
@@ -58,7 +58,8 @@ static void vga_isa_realizefn(DeviceState *dev, Error **errp)
     MemoryRegion *vga_io_memory;
     const MemoryRegionPortio *vga_ports, *vbe_ports;
 
-    vga_common_init(s, OBJECT(dev), true);
+    s->global_vmstate = true;
+    vga_common_init(s, OBJECT(dev));
     s->legacy_address_space = isa_address_space(isadev);
     vga_io_memory = vga_init_io(s, OBJECT(dev), &vga_ports, &vbe_ports);
     isa_register_portio_list(isadev, &d->portio_vga,
diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index 1ea559762a..e9e62eac70 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -222,7 +222,7 @@ static void pci_std_vga_realize(PCIDevice *dev, Error **errp)
     bool qext = false;
 
     /* vga + console init */
-    vga_common_init(s, OBJECT(dev), true);
+    vga_common_init(s, OBJECT(dev));
     vga_init(s, OBJECT(dev), pci_address_space(dev), pci_address_space_io(dev),
              true);
 
@@ -265,7 +265,7 @@ static void pci_secondary_vga_realize(PCIDevice *dev, Error **errp)
     bool qext = false;
 
     /* vga + console init */
-    vga_common_init(s, OBJECT(dev), false);
+    vga_common_init(s, OBJECT(dev));
     s->con = graphic_console_init(DEVICE(dev), 0, s->hw_ops, s);
 
     /* mmio bar */
@@ -308,6 +308,7 @@ static Property vga_pci_properties[] = {
     DEFINE_PROP_BIT("mmio", PCIVGAState, flags, PCI_VGA_FLAG_ENABLE_MMIO, true),
     DEFINE_PROP_BIT("qemu-extended-regs",
                     PCIVGAState, flags, PCI_VGA_FLAG_ENABLE_QEXT, true),
+    DEFINE_PROP_BOOL("global-vmstate", PCIVGAState, vga.global_vmstate, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/display/vga.c b/hw/display/vga.c
index ed476e4e80..c82e6d240a 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -2163,7 +2163,7 @@ static inline uint32_t uint_clamp(uint32_t val, uint32_t vmin, uint32_t vmax)
     return val;
 }
 
-void vga_common_init(VGACommonState *s, Object *obj, bool global_vmstate)
+void vga_common_init(VGACommonState *s, Object *obj)
 {
     int i, j, v, b;
 
@@ -2202,7 +2202,7 @@ void vga_common_init(VGACommonState *s, Object *obj, bool global_vmstate)
     s->is_vbe_vmstate = 1;
     memory_region_init_ram_nomigrate(&s->vram, obj, "vga.vram", s->vram_size,
                            &error_fatal);
-    vmstate_register_ram(&s->vram, global_vmstate ? NULL : DEVICE(obj));
+    vmstate_register_ram(&s->vram, s->global_vmstate ? NULL : DEVICE(obj));
     xen_register_framebuffer(&s->vram);
     s->vram_ptr = memory_region_get_ram_ptr(&s->vram);
     s->get_bpp = vga_get_bpp;
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index 97db6c3372..8d3d9e14a7 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -106,7 +106,7 @@ static void virtio_vga_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 
     /* init vga compat bits */
     vga->vram_size_mb = 8;
-    vga_common_init(vga, OBJECT(vpci_dev), false);
+    vga_common_init(vga, OBJECT(vpci_dev));
     vga_init(vga, OBJECT(vpci_dev), pci_address_space(&vpci_dev->pci_dev),
              pci_address_space_io(&vpci_dev->pci_dev), true);
     pci_register_bar(&vpci_dev->pci_dev, 0,
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index bd3e8b3586..39f4d40801 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1241,7 +1241,7 @@ static void vmsvga_init(DeviceState *dev, struct vmsvga_state_s *s,
                            &error_fatal);
     s->fifo_ptr = memory_region_get_ram_ptr(&s->fifo_ram);
 
-    vga_common_init(&s->vga, OBJECT(dev), true);
+    vga_common_init(&s->vga, OBJECT(dev));
     vga_init(&s->vga, OBJECT(dev), address_space, io, true);
     vmstate_register(NULL, 0, &vmstate_vga_common, &s->vga);
     s->new_depth = 32;
@@ -1321,6 +1321,8 @@ static void pci_vmsvga_realize(PCIDevice *dev, Error **errp)
 static Property vga_vmware_properties[] = {
     DEFINE_PROP_UINT32("vgamem_mb", struct pci_vmsvga_state_s,
                        chip.vga.vram_size_mb, 16),
+    DEFINE_PROP_BOOL("global-vmstate", struct pci_vmsvga_state_s,
+                     chip.vga.global_vmstate, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.9.3
