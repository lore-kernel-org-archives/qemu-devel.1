Received: from eggs.gnu.org ([2001:4830:134:3::10]:42217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d2cvn-0006cl-CY
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:17:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d2cvm-0007RW-GF
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:17:27 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 24 Apr 2017 14:17:04 +0200
Message-Id: <20170424121708.31953-10-kraxel@redhat.com>
In-Reply-To: <20170424121708.31953-1-kraxel@redhat.com>
References: <20170424121708.31953-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 09/13] exynos: make display updates thread safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, "open list:Exynos" <qemu-arm@nongnu.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20170421091632.30900-7-kraxel@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/exynos4210_fimd.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index e5be713406..fd0b2bec65 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -1263,6 +1263,7 @@ static void exynos4210_fimd_update(void *opaque)
     Exynos4210fimdState *s = (Exynos4210fimdState *)opaque;
     DisplaySurface *surface;
     Exynos4210fimdWindow *w;
+    DirtyBitmapSnapshot *snap;
     int i, line;
     hwaddr fb_line_addr, inc_size;
     int scrn_height;
@@ -1291,10 +1292,12 @@ static void exynos4210_fimd_update(void *opaque)
             memory_region_sync_dirty_bitmap(w->mem_section.mr);
             host_fb_addr = w->host_fb_addr;
             fb_line_addr = w->mem_section.offset_within_region;
+            snap = memory_region_snapshot_and_clear_dirty(w->mem_section.mr,
+                    fb_line_addr, inc_size * scrn_height, DIRTY_MEMORY_VGA);
 
             for (line = 0; line < scrn_height; line++) {
-                is_dirty = memory_region_get_dirty(w->mem_section.mr,
-                            fb_line_addr, scrn_width, DIRTY_MEMORY_VGA);
+                is_dirty = memory_region_snapshot_get_dirty(w->mem_section.mr,
+                            snap, fb_line_addr, scrn_width);
 
                 if (s->invalidate || is_dirty) {
                     if (first_line == -1) {
@@ -1309,9 +1312,7 @@ static void exynos4210_fimd_update(void *opaque)
                 fb_line_addr += inc_size;
                 is_dirty = false;
             }
-            memory_region_reset_dirty(w->mem_section.mr,
-                w->mem_section.offset_within_region,
-                w->fb_len, DIRTY_MEMORY_VGA);
+            g_free(snap);
             blend = true;
         }
     }
-- 
2.9.3
