Received: from eggs.gnu.org ([2001:4830:134:3::10]:42111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d2cvj-0006ab-R2
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:17:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d2cvf-0007OL-QT
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:17:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d2cvf-0007ND-HE
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:17:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 992839D0D7
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 12:17:17 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 24 Apr 2017 14:17:05 +0200
Message-Id: <20170424121708.31953-11-kraxel@redhat.com>
In-Reply-To: <20170424121708.31953-1-kraxel@redhat.com>
References: <20170424121708.31953-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 10/13] g364fb: make display updates thread safe
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
Message-id: 20170421091632.30900-8-kraxel@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/g364fb.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index 8cdc205dd9..86557d14a9 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -64,17 +64,8 @@ typedef struct G364State {
 
 static inline int check_dirty(G364State *s, ram_addr_t page)
 {
-    return memory_region_get_dirty(&s->mem_vram, page, G364_PAGE_SIZE,
-                                   DIRTY_MEMORY_VGA);
-}
-
-static inline void reset_dirty(G364State *s,
-                               ram_addr_t page_min, ram_addr_t page_max)
-{
-    memory_region_reset_dirty(&s->mem_vram,
-                              page_min,
-                              page_max + G364_PAGE_SIZE - page_min - 1,
-                              DIRTY_MEMORY_VGA);
+    return memory_region_test_and_clear_dirty(&s->mem_vram, page, G364_PAGE_SIZE,
+                                              DIRTY_MEMORY_VGA);
 }
 
 static void g364fb_draw_graphic8(G364State *s)
@@ -83,7 +74,7 @@ static void g364fb_draw_graphic8(G364State *s)
     int i, w;
     uint8_t *vram;
     uint8_t *data_display, *dd;
-    ram_addr_t page, page_min, page_max;
+    ram_addr_t page;
     int x, y;
     int xmin, xmax;
     int ymin, ymax;
@@ -114,8 +105,6 @@ static void g364fb_draw_graphic8(G364State *s)
     }
 
     page = 0;
-    page_min = (ram_addr_t)-1;
-    page_max = 0;
 
     x = y = 0;
     xmin = s->width;
@@ -137,9 +126,6 @@ static void g364fb_draw_graphic8(G364State *s)
         if (check_dirty(s, page)) {
             if (y < ymin)
                 ymin = ymax = y;
-            if (page_min == (ram_addr_t)-1)
-                page_min = page;
-            page_max = page;
             if (x < xmin)
                 xmin = x;
             for (i = 0; i < G364_PAGE_SIZE; i++) {
@@ -196,10 +182,7 @@ static void g364fb_draw_graphic8(G364State *s)
                 ymax = y;
         } else {
             int dy;
-            if (page_min != (ram_addr_t)-1) {
-                reset_dirty(s, page_min, page_max);
-                page_min = (ram_addr_t)-1;
-                page_max = 0;
+            if (xmax || ymax) {
                 dpy_gfx_update(s->con, xmin, ymin,
                                xmax - xmin + 1, ymax - ymin + 1);
                 xmin = s->width;
@@ -219,9 +202,8 @@ static void g364fb_draw_graphic8(G364State *s)
     }
 
 done:
-    if (page_min != (ram_addr_t)-1) {
+    if (xmax || ymax) {
         dpy_gfx_update(s->con, xmin, ymin, xmax - xmin + 1, ymax - ymin + 1);
-        reset_dirty(s, page_min, page_max);
     }
 }
 
-- 
2.9.3
