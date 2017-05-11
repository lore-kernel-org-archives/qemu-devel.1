Received: from eggs.gnu.org ([2001:4830:134:3::10]:43351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d8pJq-00039Q-AG
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d8pJk-0005At-De
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:43:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d8pJk-00059n-54
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:43:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 255968049D
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 14:43:47 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 11 May 2017 16:43:38 +0200
Message-Id: <20170511144339.13027-4-kraxel@redhat.com>
In-Reply-To: <20170511144339.13027-1-kraxel@redhat.com>
References: <20170511144339.13027-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 3/4] sm501: make display updates thread safe
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
Message-id: 20170509111928.30935-1-kraxel@redhat.com
---
 hw/display/sm501.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 2094adbc9c..9d254ef2e1 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1414,6 +1414,7 @@ static void sm501_update_display(void *opaque)
 {
     SM501State *s = (SM501State *)opaque;
     DisplaySurface *surface = qemu_console_surface(s->con);
+    DirtyBitmapSnapshot *snap;
     int y, c_x = 0, c_y = 0;
     int crt = (s->dc_crt_control & SM501_DC_CRT_CONTROL_SEL) ? 1 : 0;
     int width = get_width(s, crt);
@@ -1425,9 +1426,7 @@ static void sm501_update_display(void *opaque)
     draw_hwc_line_func *draw_hwc_line = NULL;
     int full_update = 0;
     int y_start = -1;
-    ram_addr_t page_min = ~0l;
-    ram_addr_t page_max = 0l;
-    ram_addr_t offset;
+    ram_addr_t offset = 0;
     uint32_t *palette;
     uint8_t hwc_palette[3 * 3];
     uint8_t *hwc_src = NULL;
@@ -1479,17 +1478,17 @@ static void sm501_update_display(void *opaque)
 
     /* draw each line according to conditions */
     memory_region_sync_dirty_bitmap(&s->local_mem_region);
+    snap = memory_region_snapshot_and_clear_dirty(&s->local_mem_region,
+              offset, width * height * src_bpp, DIRTY_MEMORY_VGA);
     for (y = 0, offset = 0; y < height; y++, offset += width * src_bpp) {
         int update, update_hwc;
-        ram_addr_t page0 = offset;
-        ram_addr_t page1 = offset + width * src_bpp - 1;
 
         /* check if hardware cursor is enabled and we're within its range */
         update_hwc = draw_hwc_line && c_y <= y && y < c_y + SM501_HWC_HEIGHT;
         update = full_update || update_hwc;
         /* check dirty flags for each line */
-        update |= memory_region_get_dirty(&s->local_mem_region, page0,
-                                          page1 - page0, DIRTY_MEMORY_VGA);
+        update |= memory_region_snapshot_get_dirty(&s->local_mem_region, snap,
+                                                   offset, width * src_bpp);
 
         /* draw line and change status */
         if (update) {
@@ -1507,12 +1506,6 @@ static void sm501_update_display(void *opaque)
             if (y_start < 0) {
                 y_start = y;
             }
-            if (page0 < page_min) {
-                page_min = page0;
-            }
-            if (page1 > page_max) {
-                page_max = page1;
-            }
         } else {
             if (y_start >= 0) {
                 /* flush to display */
@@ -1521,18 +1514,12 @@ static void sm501_update_display(void *opaque)
             }
         }
     }
+    g_free(snap);
 
     /* complete flush to display */
     if (y_start >= 0) {
         dpy_gfx_update(s->con, 0, y_start, width, y - y_start);
     }
-
-    /* clear dirty flags */
-    if (page_min != ~0l) {
-        memory_region_reset_dirty(&s->local_mem_region,
-                                  page_min, page_max + TARGET_PAGE_SIZE,
-                                  DIRTY_MEMORY_VGA);
-    }
 }
 
 static const GraphicHwOps sm501_ops = {
-- 
2.9.3
