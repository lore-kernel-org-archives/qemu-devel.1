Received: from eggs.gnu.org ([2001:4830:134:3::10]:40175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cbSey-0005ti-Sn
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 08:51:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cbSev-0001zh-UM
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 08:51:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cbSev-0001z2-Mn
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 08:51:45 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E775C80479
	for <qemu-devel@nongnu.org>; Wed,  8 Feb 2017 13:51:44 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed,  8 Feb 2017 14:51:32 +0100
Message-Id: <1486561893-26470-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] vga: replace debug printf with trace points
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/trace-events |  6 ++++++
 hw/display/vga.c        | 27 ++++-----------------------
 2 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/hw/display/trace-events b/hw/display/trace-events
index aadb612..26910e2 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -119,3 +119,9 @@ qxl_set_client_capabilities_unsupported_by_revision(int qid, int revision) "%d r
 qxl_render_blit(int32_t stride, int32_t left, int32_t right, int32_t top, int32_t bottom) "stride=%d [%d, %d, %d, %d]"
 qxl_render_guest_primary_resized(int32_t width, int32_t height, int32_t stride, int32_t bytes_pp, int32_t bits_pp) "%dx%d, stride %d, bpp %d, depth %d"
 qxl_render_update_area_done(void *cookie) "%p"
+
+# hw/display/vga.c
+vga_std_read_io(uint32_t addr, uint32_t val) "addr 0x%x, val 0x%x"
+vga_std_write_io(uint32_t addr, uint32_t val) "addr 0x%x, val 0x%x"
+vga_vbe_read(uint32_t index, uint32_t val) "index 0x%x, val 0x%x"
+vga_vbe_write(uint32_t index, uint32_t val) "index 0x%x, val 0x%x"
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 2a88b3c..69c3e1d 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -34,12 +34,9 @@
 #include "hw/xen/xen.h"
 #include "trace.h"
 
-//#define DEBUG_VGA
 //#define DEBUG_VGA_MEM
 //#define DEBUG_VGA_REG
 
-//#define DEBUG_BOCHS_VBE
-
 /* 16 state changes per vertical frame @60 Hz */
 #define VGA_TEXT_CURSOR_PERIOD_MS       (1000 * 2 * 16 / 60)
 
@@ -428,9 +425,7 @@ uint32_t vga_ioport_read(void *opaque, uint32_t addr)
             break;
         }
     }
-#if defined(DEBUG_VGA)
-    printf("VGA: read addr=0x%04x data=0x%02x\n", addr, val);
-#endif
+    trace_vga_std_read_io(addr, val);
     return val;
 }
 
@@ -443,9 +438,7 @@ void vga_ioport_write(void *opaque, uint32_t addr, uint32_t val)
     if (vga_ioport_invalid(s, addr)) {
         return;
     }
-#ifdef DEBUG_VGA
-    printf("VGA: write addr=0x%04x data=0x%02x\n", addr, val);
-#endif
+    trace_vga_std_write_io(addr, val);
 
     switch(addr) {
     case VGA_ATT_W:
@@ -733,9 +726,7 @@ uint32_t vbe_ioport_read_data(void *opaque, uint32_t addr)
     } else {
         val = 0;
     }
-#ifdef DEBUG_BOCHS_VBE
-    printf("VBE: read index=0x%x val=0x%x\n", s->vbe_index, val);
-#endif
+    trace_vga_vbe_read(s->vbe_index, val);
     return val;
 }
 
@@ -750,9 +741,7 @@ void vbe_ioport_write_data(void *opaque, uint32_t addr, uint32_t val)
     VGACommonState *s = opaque;
 
     if (s->vbe_index <= VBE_DISPI_INDEX_NB) {
-#ifdef DEBUG_BOCHS_VBE
-        printf("VBE: write index=0x%x val=0x%x\n", s->vbe_index, val);
-#endif
+        trace_vga_vbe_write(s->vbe_index, val);
         switch(s->vbe_index) {
         case VBE_DISPI_INDEX_ID:
             if (val == VBE_DISPI_ID0 ||
@@ -1543,17 +1532,9 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
                     height, format, s->line_offset,
                     s->vram_ptr + (s->start_addr * 4));
             dpy_gfx_replace_surface(s->con, surface);
-#ifdef DEBUG_VGA
-            printf("VGA: Using shared surface for depth=%d swap=%d\n",
-                   depth, byteswap);
-#endif
         } else {
             qemu_console_resize(s->con, disp_width, height);
             surface = qemu_console_surface(s->con);
-#ifdef DEBUG_VGA
-            printf("VGA: Using shadow surface for depth=%d swap=%d\n",
-                   depth, byteswap);
-#endif
         }
         s->last_scr_width = disp_width;
         s->last_scr_height = height;
-- 
1.8.3.1
