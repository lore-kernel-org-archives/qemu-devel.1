Received: from eggs.gnu.org ([2001:4830:134:3::10]:43278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d8pJl-00033R-6r
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d8pJk-0005Ac-68
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:43:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d8pJj-00059f-U5
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:43:48 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 11 May 2017 16:43:36 +0200
Message-Id: <20170511144339.13027-2-kraxel@redhat.com>
In-Reply-To: <20170511144339.13027-1-kraxel@redhat.com>
References: <20170511144339.13027-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/4] cg3: make display updates thread safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Gerd Hoffmann <kraxel@redhat.com>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-id: 1494449551-20227-2-git-send-email-mark.cave-ayland@ilande.co.uk
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/cg3.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index 7ef8a96496..1de15a1d34 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -94,7 +94,8 @@ static void cg3_update_display(void *opaque)
     uint32_t dval;
     int x, y, y_start;
     unsigned int width, height;
-    ram_addr_t page, page_min, page_max;
+    ram_addr_t page;
+    DirtyBitmapSnapshot *snap = NULL;
 
     if (surface_bits_per_pixel(surface) != 32) {
         return;
@@ -103,29 +104,32 @@ static void cg3_update_display(void *opaque)
     height = s->height;
 
     y_start = -1;
-    page_min = -1;
-    page_max = 0;
-    page = 0;
     pix = memory_region_get_ram_ptr(&s->vram_mem);
     data = (uint32_t *)surface_data(surface);
 
-    memory_region_sync_dirty_bitmap(&s->vram_mem);
+    if (!s->full_update) {
+        memory_region_sync_dirty_bitmap(&s->vram_mem);
+        snap = memory_region_snapshot_and_clear_dirty(&s->vram_mem, 0x0,
+                                              memory_region_size(&s->vram_mem),
+                                              DIRTY_MEMORY_VGA);
+    }
+
     for (y = 0; y < height; y++) {
-        int update = s->full_update;
+        int update;
 
         page = (ram_addr_t)y * width;
-        update |= memory_region_get_dirty(&s->vram_mem, page, width,
-                                          DIRTY_MEMORY_VGA);
+
+        if (s->full_update) {
+            update = 1;
+        } else {
+            update = memory_region_snapshot_get_dirty(&s->vram_mem, snap, page,
+                                                      width);
+        }
+
         if (update) {
             if (y_start < 0) {
                 y_start = y;
             }
-            if (page < page_min) {
-                page_min = page;
-            }
-            if (page > page_max) {
-                page_max = page;
-            }
 
             for (x = 0; x < width; x++) {
                 dval = *pix++;
@@ -134,7 +138,7 @@ static void cg3_update_display(void *opaque)
             }
         } else {
             if (y_start >= 0) {
-                dpy_gfx_update(s->con, 0, y_start, s->width, y - y_start);
+                dpy_gfx_update(s->con, 0, y_start, width, y - y_start);
                 y_start = -1;
             }
             pix += width;
@@ -143,17 +147,14 @@ static void cg3_update_display(void *opaque)
     }
     s->full_update = 0;
     if (y_start >= 0) {
-        dpy_gfx_update(s->con, 0, y_start, s->width, y - y_start);
-    }
-    if (page_max >= page_min) {
-        memory_region_reset_dirty(&s->vram_mem,
-                              page_min, page_max - page_min, DIRTY_MEMORY_VGA);
+        dpy_gfx_update(s->con, 0, y_start, width, y - y_start);
     }
     /* vsync interrupt? */
     if (s->regs[0] & CG3_CR_ENABLE_INTS) {
         s->regs[1] |= CG3_SR_PENDING_INT;
         qemu_irq_raise(s->irq);
     }
+    g_free(snap);
 }
 
 static void cg3_invalidate_display(void *opaque)
-- 
2.9.3
