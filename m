Received: from eggs.gnu.org ([2001:4830:134:3::10]:35636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ek6Br-0006Sv-Uq
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 05:46:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ek6Bo-0006IM-To
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 05:45:59 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57840 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ek6Bo-0006HX-Ne
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 05:45:56 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0FF5B8182D3D
	for <qemu-devel@nongnu.org>; Fri,  9 Feb 2018 10:45:54 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  9 Feb 2018 11:45:44 +0100
Message-Id: <20180209104546.29401-3-pbonzini@redhat.com>
In-Reply-To: <20180209104546.29401-1-pbonzini@redhat.com>
References: <20180209104546.29401-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] memory: hide
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
Cc: dgilbert@redhat.com

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
index cafd9f47ef..6fff4852c5 100644
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
index 86e37e93e9..f011ea5b00 100644
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
index d7310d25f2..36e3db189a 100644
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
index 86452de780..819f8be05d 100644
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
index 134cbed607..f4bb33c279 100644
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
index daa93e0929..b2786ee8d0 100644
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
index 6e78a4e156..28f298b342 100644
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
index 6779d14a7b..fff9b1d871 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1135,17 +1135,6 @@ bool memory_region_snapshot_get_dirty(MemoryRegion *mr,
                                       DirtyBitmapSnapshot *snap,
                                       hwaddr addr, hwaddr size);
 
-/**
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
 /**
  * memory_region_reset_dirty: Mark a range of pages as clean, for a specified
  *                            client.
diff --git a/memory.c b/memory.c
index 9e75bb9526..8ed809c62b 100644
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
2.14.3
