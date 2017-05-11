Received: from eggs.gnu.org ([2001:4830:134:3::10]:43302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d8pJm-000346-1Y
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:43:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d8pJk-0005BH-Lm
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:43:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d8pJk-0005A7-Cs
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:43:48 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 11 May 2017 16:43:37 +0200
Message-Id: <20170511144339.13027-3-kraxel@redhat.com>
In-Reply-To: <20170511144339.13027-1-kraxel@redhat.com>
References: <20170511144339.13027-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/4] tcx: make display updates thread safe
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
Message-id: 1494449551-20227-3-git-send-email-mark.cave-ayland@ilande.co.uk
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/tcx.c | 68 ++++++++++++++++++++------------------------------------
 1 file changed, 24 insertions(+), 44 deletions(-)

diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 0e66dcd055..6593c1d6af 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -104,36 +104,23 @@ static void tcx_set_dirty(TCXState *s, ram_addr_t addr, int len)
     }
 }
 
-static int tcx_check_dirty(TCXState *s, ram_addr_t addr, int len)
+static int tcx_check_dirty(TCXState *s, DirtyBitmapSnapshot *snap,
+                           ram_addr_t addr, int len)
 {
     int ret;
 
-    ret = memory_region_get_dirty(&s->vram_mem, addr, len, DIRTY_MEMORY_VGA);
+    ret = memory_region_snapshot_get_dirty(&s->vram_mem, snap, addr, len);
 
     if (s->depth == 24) {
-        ret |= memory_region_get_dirty(&s->vram_mem,
-                                       s->vram24_offset + addr * 4, len * 4,
-                                       DIRTY_MEMORY_VGA);
-        ret |= memory_region_get_dirty(&s->vram_mem,
-                                       s->cplane_offset + addr * 4, len * 4,
-                                       DIRTY_MEMORY_VGA);
+        ret |= memory_region_snapshot_get_dirty(&s->vram_mem, snap,
+                                       s->vram24_offset + addr * 4, len * 4);
+        ret |= memory_region_snapshot_get_dirty(&s->vram_mem, snap,
+                                       s->cplane_offset + addr * 4, len * 4);
     }
 
     return ret;
 }
 
-static void tcx_reset_dirty(TCXState *s, ram_addr_t addr, int len)
-{
-    memory_region_reset_dirty(&s->vram_mem, addr, len, DIRTY_MEMORY_VGA);
-
-    if (s->depth == 24) {
-        memory_region_reset_dirty(&s->vram_mem, s->vram24_offset + addr * 4,
-                                  len * 4, DIRTY_MEMORY_VGA);
-        memory_region_reset_dirty(&s->vram_mem, s->cplane_offset + addr * 4,
-                                  len * 4, DIRTY_MEMORY_VGA);
-    }
-}
-
 static void update_palette_entries(TCXState *s, int start, int end)
 {
     DisplaySurface *surface = qemu_console_surface(s->con);
@@ -233,7 +220,8 @@ static void tcx_update_display(void *opaque)
 {
     TCXState *ts = opaque;
     DisplaySurface *surface = qemu_console_surface(ts->con);
-    ram_addr_t page, page_min, page_max;
+    ram_addr_t page;
+    DirtyBitmapSnapshot *snap = NULL;
     int y, y_start, dd, ds;
     uint8_t *d, *s;
 
@@ -243,22 +231,20 @@ static void tcx_update_display(void *opaque)
 
     page = 0;
     y_start = -1;
-    page_min = -1;
-    page_max = 0;
     d = surface_data(surface);
     s = ts->vram;
     dd = surface_stride(surface);
     ds = 1024;
 
     memory_region_sync_dirty_bitmap(&ts->vram_mem);
+    snap = memory_region_snapshot_and_clear_dirty(&ts->vram_mem, 0x0,
+                                             memory_region_size(&ts->vram_mem),
+                                             DIRTY_MEMORY_VGA);
+
     for (y = 0; y < ts->height; y++, page += ds) {
-        if (tcx_check_dirty(ts, page, ds)) {
+        if (tcx_check_dirty(ts, snap, page, ds)) {
             if (y_start < 0)
                 y_start = y;
-            if (page < page_min)
-                page_min = page;
-            if (page > page_max)
-                page_max = page;
 
             tcx_draw_line32(ts, d, s, ts->width);
             if (y >= ts->cursy && y < ts->cursy + 32 && ts->cursx < ts->width) {
@@ -280,17 +266,15 @@ static void tcx_update_display(void *opaque)
         dpy_gfx_update(ts->con, 0, y_start,
                        ts->width, y - y_start);
     }
-    /* reset modified pages */
-    if (page_max >= page_min) {
-        tcx_reset_dirty(ts, page_min, page_max - page_min);
-    }
+    g_free(snap);
 }
 
 static void tcx24_update_display(void *opaque)
 {
     TCXState *ts = opaque;
     DisplaySurface *surface = qemu_console_surface(ts->con);
-    ram_addr_t page, page_min, page_max;
+    ram_addr_t page;
+    DirtyBitmapSnapshot *snap = NULL;
     int y, y_start, dd, ds;
     uint8_t *d, *s;
     uint32_t *cptr, *s24;
@@ -301,8 +285,6 @@ static void tcx24_update_display(void *opaque)
 
     page = 0;
     y_start = -1;
-    page_min = -1;
-    page_max = 0;
     d = surface_data(surface);
     s = ts->vram;
     s24 = ts->vram24;
@@ -311,14 +293,15 @@ static void tcx24_update_display(void *opaque)
     ds = 1024;
 
     memory_region_sync_dirty_bitmap(&ts->vram_mem);
+    snap = memory_region_snapshot_and_clear_dirty(&ts->vram_mem, 0x0,
+                                             memory_region_size(&ts->vram_mem),
+                                             DIRTY_MEMORY_VGA);
+
     for (y = 0; y < ts->height; y++, page += ds) {
-        if (tcx_check_dirty(ts, page, ds)) {
+        if (tcx_check_dirty(ts, snap, page, ds)) {
             if (y_start < 0)
                 y_start = y;
-            if (page < page_min)
-                page_min = page;
-            if (page > page_max)
-                page_max = page;
+
             tcx24_draw_line32(ts, d, s, ts->width, cptr, s24);
             if (y >= ts->cursy && y < ts->cursy+32 && ts->cursx < ts->width) {
                 tcx_draw_cursor32(ts, d, y, ts->width);
@@ -341,10 +324,7 @@ static void tcx24_update_display(void *opaque)
         dpy_gfx_update(ts->con, 0, y_start,
                        ts->width, y - y_start);
     }
-    /* reset modified pages */
-    if (page_max >= page_min) {
-        tcx_reset_dirty(ts, page_min, page_max - page_min);
-    }
+    g_free(snap);
 }
 
 static void tcx_invalidate_display(void *opaque)
-- 
2.9.3
