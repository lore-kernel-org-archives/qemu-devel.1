Received: from eggs.gnu.org ([2001:4830:134:3::10]:37088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d1UgF-0001wX-PC
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:16:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d1UgD-0001Fl-Ee
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:16:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:2753)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d1UgD-0001Ec-64
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:16:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 341D67D0E9
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 09:16:40 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 21 Apr 2017 11:16:32 +0200
Message-Id: <20170421091632.30900-10-kraxel@redhat.com>
In-Reply-To: <20170421091632.30900-1-kraxel@redhat.com>
References: <20170421091632.30900-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 9/9] sm501: make display updates thread safe
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
 hw/display/sm501.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 040a0b93f2..1987a537c0 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1259,6 +1259,7 @@ static inline int get_depth_index(DisplaySurface *surface)
 static void sm501_draw_crt(SM501State * s)
 {
     DisplaySurface *surface = qemu_console_surface(s->con);
+    DirtyBitmapSnapshot *snap;
     int y;
     int width = (s->dc_crt_h_total & 0x00000FFF) + 1;
     int height = (s->dc_crt_v_total & 0x00000FFF) + 1;
@@ -1274,8 +1275,6 @@ static void sm501_draw_crt(SM501State * s)
     draw_hwc_line_func * draw_hwc_line = NULL;
     int full_update = 0;
     int y_start = -1;
-    ram_addr_t page_min = ~0l;
-    ram_addr_t page_max = 0l;
     ram_addr_t offset = 0;
 
     /* choose draw_line function */
@@ -1326,15 +1325,15 @@ static void sm501_draw_crt(SM501State * s)
 
     /* draw each line according to conditions */
     memory_region_sync_dirty_bitmap(&s->local_mem_region);
+    snap = memory_region_snapshot_and_clear_dirty(&s->local_mem_region,
+              offset, width * height * src_bpp, DIRTY_MEMORY_VGA);
     for (y = 0; y < height; y++) {
 	int update_hwc = draw_hwc_line ? within_hwc_y_range(s, y, 1) : 0;
 	int update = full_update || update_hwc;
-        ram_addr_t page0 = offset;
-        ram_addr_t page1 = offset + width * src_bpp - 1;
 
 	/* check dirty flags for each line */
-        update = memory_region_get_dirty(&s->local_mem_region, page0,
-                                         page1 - page0, DIRTY_MEMORY_VGA);
+        update = memory_region_snapshot_get_dirty(&s->local_mem_region, snap,
+                                                  offset, width * src_bpp);
 
 	/* draw line and change status */
 	if (update) {
@@ -1351,10 +1350,6 @@ static void sm501_draw_crt(SM501State * s)
 
 	    if (y_start < 0)
 		y_start = y;
-	    if (page0 < page_min)
-		page_min = page0;
-	    if (page1 > page_max)
-		page_max = page1;
 	} else {
 	    if (y_start >= 0) {
 		/* flush to display */
@@ -1366,17 +1361,11 @@ static void sm501_draw_crt(SM501State * s)
 	src += width * src_bpp;
 	offset += width * src_bpp;
     }
+    g_free(snap);
 
     /* complete flush to display */
     if (y_start >= 0)
         dpy_gfx_update(s->con, 0, y_start, width, y - y_start);
-
-    /* clear dirty flags */
-    if (page_min != ~0l) {
-	memory_region_reset_dirty(&s->local_mem_region,
-                                  page_min, page_max + TARGET_PAGE_SIZE,
-                                  DIRTY_MEMORY_VGA);
-    }
 }
 
 static void sm501_update_display(void *opaque)
-- 
2.9.3
