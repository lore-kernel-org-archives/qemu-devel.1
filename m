Received: from eggs.gnu.org ([2001:4830:134:3::10]:54130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cvLcY-00026g-KI
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:23:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cvLcT-0002DD-VH
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:23:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cvLcT-0002Bs-My
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:23:25 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  4 Apr 2017 12:23:12 +0200
Message-Id: <20170404102315.24923-8-kraxel@redhat.com>
In-Reply-To: <20170404102315.24923-1-kraxel@redhat.com>
References: <20170404102315.24923-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 07/10] cg3: make display updates thread safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/display/cg3.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index 6e19da0..9996567 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -95,7 +95,8 @@ static void cg3_update_display(void *opaque)
     uint32_t dval;
     int x, y, y_start;
     unsigned int width, height;
-    ram_addr_t page, page_min, page_max;
+    ram_addr_t page;
+    DirtyBitmapSnapshot *snap = NULL;
 
     if (surface_bits_per_pixel(surface) != 32) {
         return;
@@ -104,29 +105,32 @@ static void cg3_update_display(void *opaque)
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
+                                                      memory_region_size(&s->vram_mem),
+                                                      DIRTY_MEMORY_VGA);
+    }
+    
     for (y = 0; y < height; y++) {
-        int update = s->full_update;
+        int update;
 
         page = y * width;
-        update |= memory_region_get_dirty(&s->vram_mem, page, width - 1,
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
@@ -146,15 +150,12 @@ static void cg3_update_display(void *opaque)
     if (y_start >= 0) {
         dpy_gfx_update(s->con, 0, y_start, s->width, y - y_start);
     }
-    if (page_max >= page_min) {
-        memory_region_reset_dirty(&s->vram_mem,
-                              page_min, page_max - page_min, DIRTY_MEMORY_VGA);
-    }
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
