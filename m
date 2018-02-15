Received: from eggs.gnu.org ([2001:4830:134:3::10]:34700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBBb-0008G3-2W
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:30:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBBW-0004Je-RQ
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:30:19 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:38242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBBW-0004JQ-DX
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:30:14 -0500
Received: by mail-qt0-x244.google.com with SMTP id k13so10473363qtg.5
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 20:30:14 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 01:28:52 -0300
Message-Id: <20180215042900.16078-23-f4bug@amsat.org>
In-Reply-To: <20180215042900.16078-1-f4bug@amsat.org>
References: <20180215042900.16078-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 22/30] hw/display: use the BYTE-based
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>

It ease code review, unit is explicit.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/display/cirrus_vga.c |  9 ++++-----
 hw/display/g364fb.c     |  2 +-
 hw/display/qxl.c        | 26 +++++++++++---------------
 hw/display/vga-isa-mm.c |  4 ++--
 hw/display/vga.c        |  4 ++--
 hw/display/virtio-gpu.c |  3 +--
 hw/display/vmware_vga.c |  2 +-
 hw/display/xenfb.c      |  2 +-
 8 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 138ae961b9..e888056d75 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -2218,7 +2218,7 @@ static inline void cirrus_cursor_compute_yrange(CirrusVGAState *s)
     uint32_t content;
     int y, y_min, y_max;
 
-    src = s->vga.vram_ptr + s->real_vram_size - 16 * 1024;
+    src = s->vga.vram_ptr + s->real_vram_size - 16 * K_BYTE;
     if (s->vga.sr[0x12] & CIRRUS_CURSOR_LARGE) {
         src += (s->vga.sr[0x13] & 0x3c) * 256;
         y_min = 64;
@@ -2347,7 +2347,7 @@ static void cirrus_cursor_draw_line(VGACommonState *s1, uint8_t *d1, int scr_y)
         return;
     }
 
-    src = s->vga.vram_ptr + s->real_vram_size - 16 * 1024;
+    src = s->vga.vram_ptr + s->real_vram_size - 16 * K_BYTE;
     if (s->vga.sr[0x12] & CIRRUS_CURSOR_LARGE) {
         src += (s->vga.sr[0x13] & 0x3c) * 256;
         src += (scr_y - s->vga.hw_cursor_y) * 16;
@@ -2995,8 +2995,7 @@ static void cirrus_init_common(CirrusVGAState *s, Object *owner,
 
     /* I/O handler for LFB */
     memory_region_init_io(&s->cirrus_linear_io, owner, &cirrus_linear_io_ops, s,
-                          "cirrus-linear-io", s->vga.vram_size_mb
-                                              * 1024 * 1024);
+                          "cirrus-linear-io", s->vga.vram_size_mb * M_BYTE);
     memory_region_set_flush_coalesced(&s->cirrus_linear_io);
 
     /* I/O handler for LFB */
@@ -3013,7 +3012,7 @@ static void cirrus_init_common(CirrusVGAState *s, Object *owner,
     memory_region_set_flush_coalesced(&s->cirrus_mmio_io);
 
     s->real_vram_size =
-        (s->device_id == CIRRUS_ID_CLGD5446) ? 4096 * 1024 : 2048 * 1024;
+        (s->device_id == CIRRUS_ID_CLGD5446) ? 4 * M_BYTE : 2 * M_BYTE;
 
     /* XXX: s->vga.vram_size must be a power of two */
     s->cirrus_addr_mask = s->real_vram_size - 1;
diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index 819f8be05d..009f07333b 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -510,7 +510,7 @@ static void g364fb_sysbus_reset(DeviceState *d)
 
 static Property g364fb_sysbus_properties[] = {
     DEFINE_PROP_UINT32("vram_size", G364SysBusState, g364.vram_size,
-    8 * 1024 * 1024),
+                       8 * M_BYTE),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index a71714ccb4..4863f894ad 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2012,11 +2012,11 @@ static void qxl_init_ramsize(PCIQXLDevice *qxl)
     if (qxl->vgamem_size_mb > 256) {
         qxl->vgamem_size_mb = 256;
     }
-    qxl->vgamem_size = qxl->vgamem_size_mb * 1024 * 1024;
+    qxl->vgamem_size = qxl->vgamem_size_mb * M_BYTE;
 
     /* vga ram (bar 0, total) */
     if (qxl->ram_size_mb != -1) {
-        qxl->vga.vram_size = qxl->ram_size_mb * 1024 * 1024;
+        qxl->vga.vram_size = qxl->ram_size_mb * M_BYTE;
     }
     if (qxl->vga.vram_size < qxl->vgamem_size * 2) {
         qxl->vga.vram_size = qxl->vgamem_size * 2;
@@ -2024,7 +2024,7 @@ static void qxl_init_ramsize(PCIQXLDevice *qxl)
 
     /* vram32 (surfaces, 32bit, bar 1) */
     if (qxl->vram32_size_mb != -1) {
-        qxl->vram32_size = qxl->vram32_size_mb * 1024 * 1024;
+        qxl->vram32_size = qxl->vram32_size_mb * M_BYTE;
     }
     if (qxl->vram32_size < 4096) {
         qxl->vram32_size = 4096;
@@ -2032,7 +2032,7 @@ static void qxl_init_ramsize(PCIQXLDevice *qxl)
 
     /* vram (surfaces, 64bit, bar 4+5) */
     if (qxl->vram_size_mb != -1) {
-        qxl->vram_size = (uint64_t)qxl->vram_size_mb * 1024 * 1024;
+        qxl->vram_size = (uint64_t)qxl->vram_size_mb * M_BYTE;
     }
     if (qxl->vram_size < qxl->vram32_size) {
         qxl->vram_size = qxl->vram32_size;
@@ -2134,13 +2134,10 @@ static void qxl_realize_common(PCIQXLDevice *qxl, Error **errp)
     }
 
     /* print pci bar details */
-    dprint(qxl, 1, "ram/%s: %d MB [region 0]\n",
-           qxl->id == 0 ? "pri" : "sec",
-           qxl->vga.vram_size / (1024*1024));
-    dprint(qxl, 1, "vram/32: %" PRIx64 "d MB [region 1]\n",
-           qxl->vram32_size / (1024*1024));
-    dprint(qxl, 1, "vram/64: %" PRIx64 "d MB %s\n",
-           qxl->vram_size / (1024*1024),
+    dprint(qxl, 1, "ram/%s: %llu MB [region 0]\n",
+           qxl->id == 0 ? "pri" : "sec", qxl->vga.vram_size / M_BYTE);
+    dprint(qxl, 1, "vram/32: %llu MB [region 1]\n", qxl->vram32_size / M_BYTE);
+    dprint(qxl, 1, "vram/64: %llu MB %s\n", qxl->vram_size / M_BYTE,
            qxl->vram32_size < qxl->vram_size ? "[region 4]" : "[unmapped]");
 
     qxl->ssd.qxl.base.sif = &qxl_interface.base;
@@ -2167,7 +2164,7 @@ static void qxl_realize_primary(PCIDevice *dev, Error **errp)
     qxl->id = 0;
     qxl_init_ramsize(qxl);
     vga->vbe_size = qxl->vgamem_size;
-    vga->vram_size_mb = qxl->vga.vram_size >> 20;
+    vga->vram_size_mb = qxl->vga.vram_size / M_BYTE;
     vga_common_init(vga, OBJECT(dev), true);
     vga_init(vga, OBJECT(dev),
              pci_address_space(dev), pci_address_space_io(dev), false);
@@ -2392,9 +2389,8 @@ static VMStateDescription qxl_vmstate = {
 
 static Property qxl_properties[] = {
         DEFINE_PROP_UINT32("ram_size", PCIQXLDevice, vga.vram_size,
-                           64 * 1024 * 1024),
-        DEFINE_PROP_UINT64("vram_size", PCIQXLDevice, vram32_size,
-                           64 * 1024 * 1024),
+                           64 * M_BYTE),
+        DEFINE_PROP_UINT64("vram_size", PCIQXLDevice, vram32_size, 64 * M_BYTE),
         DEFINE_PROP_UINT32("revision", PCIQXLDevice, revision,
                            QXL_DEFAULT_REVISION),
         DEFINE_PROP_UINT32("debug", PCIQXLDevice, debug, 0),
diff --git a/hw/display/vga-isa-mm.c b/hw/display/vga-isa-mm.c
index e887b45651..79a5950144 100644
--- a/hw/display/vga-isa-mm.c
+++ b/hw/display/vga-isa-mm.c
@@ -27,7 +27,7 @@
 #include "vga_int.h"
 #include "ui/pixel_ops.h"
 
-#define VGA_RAM_SIZE (8192 * 1024)
+#define VGA_RAM_SIZE (8 * M_BYTE)
 
 typedef struct ISAVGAMMState {
     VGACommonState vga;
@@ -130,7 +130,7 @@ int isa_vga_mm_init(hwaddr vram_base,
 
     s = g_malloc0(sizeof(*s));
 
-    s->vga.vram_size_mb = VGA_RAM_SIZE >> 20;
+    s->vga.vram_size_mb = VGA_RAM_SIZE / M_BYTE;
     vga_common_init(&s->vga, NULL, true);
     vga_mm_init(s, vram_base, ctrl_base, it_shift, address_space);
 
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 28f298b342..8f4527b3a0 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -721,7 +721,7 @@ uint32_t vbe_ioport_read_data(void *opaque, uint32_t addr)
             val = s->vbe_regs[s->vbe_index];
         }
     } else if (s->vbe_index == VBE_DISPI_INDEX_VIDEO_MEMORY_64K) {
-        val = s->vbe_size / (64 * 1024);
+        val = s->vbe_size / (64 * K_BYTE);
     } else {
         val = 0;
     }
@@ -2175,7 +2175,7 @@ void vga_common_init(VGACommonState *s, Object *obj, bool global_vmstate)
 
     s->vram_size_mb = uint_clamp(s->vram_size_mb, 1, 512);
     s->vram_size_mb = pow2ceil(s->vram_size_mb);
-    s->vram_size = s->vram_size_mb << 20;
+    s->vram_size = s->vram_size_mb * M_BYTE;
 
     if (!s->vbe_size) {
         s->vbe_size = s->vram_size;
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 6658f6c6a6..7a378a4596 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1309,8 +1309,7 @@ static const VMStateDescription vmstate_virtio_gpu = {
 
 static Property virtio_gpu_properties[] = {
     DEFINE_PROP_UINT32("max_outputs", VirtIOGPU, conf.max_outputs, 1),
-    DEFINE_PROP_SIZE("max_hostmem", VirtIOGPU, conf.max_hostmem,
-                     256 * 1024 * 1024),
+    DEFINE_PROP_SIZE("max_hostmem", VirtIOGPU, conf.max_hostmem, 256 * M_BYTE),
 #ifdef CONFIG_VIRGL
     DEFINE_PROP_BIT("virgl", VirtIOGPU, conf.flags,
                     VIRTIO_GPU_FLAG_VIRGL_ENABLED, true),
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index bd3e8b3586..8609f9c0bc 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -565,7 +565,7 @@ static inline int vmsvga_fifo_length(struct vmsvga_state_s *s)
         s->fifo_next >= SVGA_FIFO_SIZE) {
         return 0;
     }
-    if (s->fifo_max < s->fifo_min + 10 * 1024) {
+    if (s->fifo_max < s->fifo_min + 10 * K_BYTE) {
         return 0;
     }
 
diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index f5afcc0358..1ae660519a 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -889,7 +889,7 @@ static int fb_initialise(struct XenDevice *xendev)
 	return rc;
 
     fb_page = fb->c.page;
-    rc = xenfb_configure_fb(fb, videoram * 1024 * 1024U,
+    rc = xenfb_configure_fb(fb, videoram * M_BYTE,
 			    fb_page->width, fb_page->height, fb_page->depth,
 			    fb_page->mem_length, 0, fb_page->line_length);
     if (rc != 0)
-- 
2.16.1
