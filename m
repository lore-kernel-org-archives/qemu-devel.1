Received: from eggs.gnu.org ([2001:4830:134:3::10]:42194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZI3-0004hF-Tl
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZI0-0007tr-Pt
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:27 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33691)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1elZI0-0007tW-G9
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:24 -0500
Received: by mail-wr0-x244.google.com with SMTP id s5so18383028wra.0
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 04:02:24 -0800 (PST)
Received: from 640k.lan ([82.84.102.245])
	by smtp.gmail.com with ESMTPSA id f9sm6870298wmf.12.2018.02.13.04.02.22
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 13 Feb 2018 04:02:22 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Feb 2018 13:00:50 +0100
Message-Id: <1518523252-49106-47-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
References: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 46/48] memory: hide
 memory_region_sync_dirty_bitmap behind DirtyBitmapSnapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Simplify the users of memory_region_snapshot_and_clear_dirty, so
that they do not have to call memory_region_sync_dirty_bitmap
explicitly.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/display/cg3.c             |  1 -
 hw/display/exynos4210_fimd.c |  1 -
 hw/display/framebuffer.c     |  1 -
 hw/display/g364fb.c          |  1 -
 hw/display/sm501.c           |  1 -
 hw/display/tcx.c             |  2 --
 hw/display/vga.c             |  6 ------
 include/exec/memory.h        | 11 -----------
 memory.c                     | 39 ++++++++++++++++++++-------------------
 9 files changed, 20 insertions(+), 43 deletions(-)

diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index cafd9f4..6fff485 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -108,7 +108,6 @@ static void cg3_update_display(void *opaque)
     data = (uint32_t *)surface_data(surface);
 
     if (!s->full_update) {
-        memory_region_sync_dirty_bitmap(&s->vram_mem);
         snap = memory_region_snapshot_and_clear_dirty(&s->vram_mem, 0x0,
                                               memory_region_size(&s->vram_mem),
                                               DIRTY_MEMORY_VGA);
diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index 86e37e9..f011ea5 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -1289,7 +1289,6 @@ static void exynos4210_fimd_update(void *opaque)
             scrn_width = w->virtpage_width;
             /* Total width of virtual screen page in bytes */
             inc_size = scrn_width + w->virtpage_offsize;
-            memory_region_sync_dirty_bitmap(w->mem_section.mr);
             host_fb_addr = w->host_fb_addr;
             fb_line_addr = w->mem_section.offset_within_region;
             snap = memory_region_snapshot_and_clear_dirty(w->mem_section.mr,
diff --git a/hw/display/framebuffer.c b/hw/display/framebuffer.c
index d7310d2..36e3db1 100644
--- a/hw/display/framebuffer.c
+++ b/hw/display/framebuffer.c
@@ -83,7 +83,6 @@ void framebuffer_update_display(
     if (!mem) {
         return;
     }
-    memory_region_sync_dirty_bitmap(mem);
 
     addr = mem_section->offset_within_region;
     src = memory_region_get_ram_ptr(mem) + addr;
diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index 86452de..819f8be 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -246,7 +246,6 @@ static void g364fb_update_display(void *opaque)
         qemu_console_resize(s->con, s->width, s->height);
     }
 
-    memory_region_sync_dirty_bitmap(&s->mem_vram);
     if (s->ctla & CTLA_FORCE_BLANK) {
         g364fb_draw_blank(s);
     } else if (s->depth == 8) {
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 134cbed..f4bb33c 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1508,7 +1508,6 @@ static void sm501_update_display(void *opaque)
     }
 
     /* draw each line according to conditions */
-    memory_region_sync_dirty_bitmap(&s->local_mem_region);
     snap = memory_region_snapshot_and_clear_dirty(&s->local_mem_region,
               offset, width * height * src_bpp, DIRTY_MEMORY_VGA);
     for (y = 0, offset = 0; y < height; y++, offset += width * src_bpp) {
diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index daa93e0..b2786ee 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -236,7 +236,6 @@ static void tcx_update_display(void *opaque)
     dd = surface_stride(surface);
     ds = 1024;
 
-    memory_region_sync_dirty_bitmap(&ts->vram_mem);
     snap = memory_region_snapshot_and_clear_dirty(&ts->vram_mem, 0x0,
                                              memory_region_size(&ts->vram_mem),
                                              DIRTY_MEMORY_VGA);
@@ -292,7 +291,6 @@ static void tcx24_update_display(void *opaque)
     dd = surface_stride(surface);
     ds = 1024;
 
-    memory_region_sync_dirty_bitmap(&ts->vram_mem);
     snap = memory_region_snapshot_and_clear_dirty(&ts->vram_mem, 0x0,
                                              memory_region_size(&ts->vram_mem),
                                              DIRTY_MEMORY_VGA);
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 6e78a4e..28f298b 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1444,11 +1444,6 @@ static bool vga_scanline_invalidated(VGACommonState *s, int y)
     return s->invalidated_y_table[y >> 5] & (1 << (y & 0x1f));
 }
 
-void vga_sync_dirty_bitmap(VGACommonState *s)
-{
-    memory_region_sync_dirty_bitmap(&s->vram);
-}
-
 void vga_dirty_log_start(VGACommonState *s)
 {
     memory_region_set_log(&s->vram, true, DIRTY_MEMORY_VGA);
@@ -1638,7 +1633,6 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
     y1 = 0;
 
     if (!full_update) {
-        vga_sync_dirty_bitmap(s);
         if (s->line_compare < height) {
             /* split screen mode */
             region_start = 0;
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 6779d14..fff9b1d 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1136,17 +1136,6 @@ bool memory_region_snapshot_get_dirty(MemoryRegion *mr,
                                       hwaddr addr, hwaddr size);
 
 /**
- * memory_region_sync_dirty_bitmap: Synchronize a region's dirty bitmap with
- *                                  any external TLBs (e.g. kvm)
- *
- * Flushes dirty information from accelerators such as kvm and vhost-net
- * and makes it available to users of the memory API.
- *
- * @mr: the region being flushed.
- */
-void memory_region_sync_dirty_bitmap(MemoryRegion *mr);
-
-/**
  * memory_region_reset_dirty: Mark a range of pages as clean, for a specified
  *                            client.
  *
diff --git a/memory.c b/memory.c
index 9e75bb9..8ed809c 100644
--- a/memory.c
+++ b/memory.c
@@ -1971,25 +1971,7 @@ void memory_region_set_dirty(MemoryRegion *mr, hwaddr addr,
                                         memory_region_get_dirty_log_mask(mr));
 }
 
-DirtyBitmapSnapshot *memory_region_snapshot_and_clear_dirty(MemoryRegion *mr,
-                                                            hwaddr addr,
-                                                            hwaddr size,
-                                                            unsigned client)
-{
-    assert(mr->ram_block);
-    return cpu_physical_memory_snapshot_and_clear_dirty(
-                memory_region_get_ram_addr(mr) + addr, size, client);
-}
-
-bool memory_region_snapshot_get_dirty(MemoryRegion *mr, DirtyBitmapSnapshot *snap,
-                                      hwaddr addr, hwaddr size)
-{
-    assert(mr->ram_block);
-    return cpu_physical_memory_snapshot_get_dirty(snap,
-                memory_region_get_ram_addr(mr) + addr, size);
-}
-
-void memory_region_sync_dirty_bitmap(MemoryRegion *mr)
+static void memory_region_sync_dirty_bitmap(MemoryRegion *mr)
 {
     MemoryListener *listener;
     AddressSpace *as;
@@ -2017,6 +1999,25 @@ void memory_region_sync_dirty_bitmap(MemoryRegion *mr)
     }
 }
 
+DirtyBitmapSnapshot *memory_region_snapshot_and_clear_dirty(MemoryRegion *mr,
+                                                            hwaddr addr,
+                                                            hwaddr size,
+                                                            unsigned client)
+{
+    assert(mr->ram_block);
+    memory_region_sync_dirty_bitmap(mr);
+    return cpu_physical_memory_snapshot_and_clear_dirty(
+                memory_region_get_ram_addr(mr) + addr, size, client);
+}
+
+bool memory_region_snapshot_get_dirty(MemoryRegion *mr, DirtyBitmapSnapshot *snap,
+                                      hwaddr addr, hwaddr size)
+{
+    assert(mr->ram_block);
+    return cpu_physical_memory_snapshot_get_dirty(snap,
+                memory_region_get_ram_addr(mr) + addr, size);
+}
+
 void memory_region_set_readonly(MemoryRegion *mr, bool readonly)
 {
     if (mr->readonly != readonly) {
-- 
1.8.3.1
