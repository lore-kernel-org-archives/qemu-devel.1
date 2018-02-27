Received: from eggs.gnu.org ([2001:4830:134:3::10]:39883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqdc2-000641-H3
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 06:40:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqdbz-0001eL-5h
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 06:40:02 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49294 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eqdby-0001eF-Vl
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 06:39:59 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 85C224015A45
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 11:39:58 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 27 Feb 2018 12:39:55 +0100
Message-Id: <20180227113957.17461-2-kraxel@redhat.com>
In-Reply-To: <20180227113957.17461-1-kraxel@redhat.com>
References: <20180227113957.17461-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] spice: drop dprint() debug logging
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

Some calls are deleted, some are converted into tracepoints.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/spice-display.c | 75 ++++++++++++++++--------------------------------------
 ui/trace-events    |  9 +++++++
 2 files changed, 31 insertions(+), 53 deletions(-)

diff --git a/ui/spice-display.c b/ui/spice-display.c
index 98ccdfb687..f3ae6beb3d 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -26,20 +26,8 @@
 
 #include "ui/spice-display.h"
 
-static int debug = 0;
 bool spice_opengl;
 
-static void GCC_FMT_ATTR(2, 3) dprint(int level, const char *fmt, ...)
-{
-    va_list args;
-
-    if (level <= debug) {
-        va_start(args, fmt);
-        vfprintf(stderr, fmt, args);
-        va_end(args);
-    }
-}
-
 int qemu_spice_rect_is_empty(const QXLRect* r)
 {
     return r->top == r->bottom || r->left == r->right;
@@ -322,8 +310,6 @@ void qemu_spice_create_host_memslot(SimpleSpiceDisplay *ssd)
 {
     QXLDevMemSlot memslot;
 
-    dprint(1, "%s/%d:\n", __func__, ssd->qxl.id);
-
     memset(&memslot, 0, sizeof(memslot));
     memslot.slot_group_id = MEMSLOT_GROUP_HOST;
     memslot.virt_end = ~0;
@@ -347,10 +333,6 @@ void qemu_spice_create_host_primary(SimpleSpiceDisplay *ssd)
         ssd->buf = g_malloc(ssd->bufsize);
     }
 
-    dprint(1, "%s/%d: %ux%u (size %" PRIu64 "/%d)\n", __func__, ssd->qxl.id,
-           surface_width(ssd->ds), surface_height(ssd->ds),
-           surface_size, ssd->bufsize);
-
     surface.format     = SPICE_SURFACE_FMT_32_xRGB;
     surface.width      = surface_width(ssd->ds);
     surface.height     = surface_height(ssd->ds);
@@ -366,8 +348,6 @@ void qemu_spice_create_host_primary(SimpleSpiceDisplay *ssd)
 
 void qemu_spice_destroy_host_primary(SimpleSpiceDisplay *ssd)
 {
-    dprint(1, "%s/%d:\n", __func__, ssd->qxl.id);
-
     qemu_spice_destroy_primary_surface(ssd, 0, QXL_SYNC);
 }
 
@@ -389,8 +369,7 @@ void qemu_spice_display_update(SimpleSpiceDisplay *ssd,
 {
     QXLRect update_area;
 
-    dprint(2, "%s/%d: x %d y %d w %d h %d\n", __func__,
-           ssd->qxl.id, x, y, w, h);
+    trace_qemu_spice_display_update(ssd->qxl.id, x, y, w, h);
     update_area.left = x,
     update_area.right = x + w;
     update_area.top = y;
@@ -413,8 +392,10 @@ void qemu_spice_display_switch(SimpleSpiceDisplay *ssd,
         surface_height(surface) == pixman_image_get_height(ssd->surface) &&
         surface_format(surface) == pixman_image_get_format(ssd->surface)) {
         /* no-resize fast path: just swap backing store */
-        dprint(1, "%s/%d: fast (%dx%d)\n", __func__, ssd->qxl.id,
-               surface_width(surface), surface_height(surface));
+        trace_qemu_spice_display_surface(ssd->qxl.id,
+                                         surface_width(surface),
+                                         surface_height(surface),
+                                         true);
         qemu_mutex_lock(&ssd->lock);
         ssd->ds = surface;
         pixman_image_unref(ssd->surface);
@@ -427,11 +408,10 @@ void qemu_spice_display_switch(SimpleSpiceDisplay *ssd,
     }
 
     /* full mode switch */
-    dprint(1, "%s/%d: full (%dx%d -> %dx%d)\n", __func__, ssd->qxl.id,
-           ssd->surface ? pixman_image_get_width(ssd->surface)  : 0,
-           ssd->surface ? pixman_image_get_height(ssd->surface) : 0,
-           surface ? surface_width(surface)  : 0,
-           surface ? surface_height(surface) : 0);
+    trace_qemu_spice_display_surface(ssd->qxl.id,
+                                     surface_width(surface),
+                                     surface_height(surface),
+                                     false);
 
     memset(&ssd->dirty, 0, sizeof(ssd->dirty));
     if (ssd->surface) {
@@ -495,7 +475,6 @@ void qemu_spice_cursor_refresh_bh(void *opaque)
 
 void qemu_spice_display_refresh(SimpleSpiceDisplay *ssd)
 {
-    dprint(3, "%s/%d:\n", __func__, ssd->qxl.id);
     graphic_hw_update(ssd->dcl.con);
 
     qemu_mutex_lock(&ssd->lock);
@@ -505,10 +484,10 @@ void qemu_spice_display_refresh(SimpleSpiceDisplay *ssd)
     }
     qemu_mutex_unlock(&ssd->lock);
 
+    trace_qemu_spice_display_refresh(ssd->qxl.id, ssd->notify);
     if (ssd->notify) {
         ssd->notify = 0;
         qemu_spice_wakeup(ssd);
-        dprint(2, "%s/%d: notify\n", __func__, ssd->qxl.id);
     }
 }
 
@@ -516,21 +495,17 @@ void qemu_spice_display_refresh(SimpleSpiceDisplay *ssd)
 
 static void interface_attach_worker(QXLInstance *sin, QXLWorker *qxl_worker)
 {
-    SimpleSpiceDisplay *ssd = container_of(sin, SimpleSpiceDisplay, qxl);
-
-    dprint(1, "%s/%d:\n", __func__, ssd->qxl.id);
+    /* nothing to do */
 }
 
 static void interface_set_compression_level(QXLInstance *sin, int level)
 {
-    dprint(1, "%s/%d:\n", __func__, sin->id);
     /* nothing to do */
 }
 
 #if SPICE_NEEDS_SET_MM_TIME
 static void interface_set_mm_time(QXLInstance *sin, uint32_t mm_time)
 {
-    dprint(3, "%s/%d:\n", __func__, sin->id);
     /* nothing to do */
 }
 #endif
@@ -554,8 +529,6 @@ static int interface_get_command(QXLInstance *sin, QXLCommandExt *ext)
     SimpleSpiceUpdate *update;
     int ret = false;
 
-    dprint(3, "%s/%d:\n", __func__, ssd->qxl.id);
-
     qemu_mutex_lock(&ssd->lock);
     update = QTAILQ_FIRST(&ssd->updates);
     if (update != NULL) {
@@ -570,7 +543,6 @@ static int interface_get_command(QXLInstance *sin, QXLCommandExt *ext)
 
 static int interface_req_cmd_notification(QXLInstance *sin)
 {
-    dprint(2, "%s/%d:\n", __func__, sin->id);
     return 1;
 }
 
@@ -582,7 +554,6 @@ static void interface_release_resource(QXLInstance *sin,
     SimpleSpiceCursor *cursor;
     QXLCommandExt *ext;
 
-    dprint(2, "%s/%d:\n", __func__, ssd->qxl.id);
     ext = (void *)(intptr_t)(rext.info->id);
     switch (ext->cmd.type) {
     case QXL_CMD_DRAW:
@@ -603,8 +574,6 @@ static int interface_get_cursor_command(QXLInstance *sin, QXLCommandExt *ext)
     SimpleSpiceDisplay *ssd = container_of(sin, SimpleSpiceDisplay, qxl);
     int ret;
 
-    dprint(3, "%s/%d:\n", __func__, ssd->qxl.id);
-
     qemu_mutex_lock(&ssd->lock);
     if (ssd->ptr_define) {
         *ext = ssd->ptr_define->ext;
@@ -623,7 +592,6 @@ static int interface_get_cursor_command(QXLInstance *sin, QXLCommandExt *ext)
 
 static int interface_req_cursor_notification(QXLInstance *sin)
 {
-    dprint(2, "%s:\n", __func__);
     return 1;
 }
 
@@ -680,7 +648,7 @@ static void interface_set_client_capabilities(QXLInstance *sin,
                                               uint8_t client_present,
                                               uint8_t caps[58])
 {
-    dprint(3, "%s:\n", __func__);
+    /* nothing to do */
 }
 
 static int interface_client_monitors_config(QXLInstance *sin,
@@ -705,9 +673,9 @@ static int interface_client_monitors_config(QXLInstance *sin,
         info.width  = mc->monitors[head].width;
         info.height = mc->monitors[head].height;
     }
+
+    trace_qemu_spice_ui_info(ssd->qxl.id, info.width, info.height);
     dpy_set_ui_info(ssd->dcl.con, &info);
-    dprint(1, "%s/%d: size %dx%d\n", __func__, ssd->qxl.id,
-           info.width, info.height);
     return 1;
 }
 
@@ -902,9 +870,10 @@ static void spice_gl_switch(DisplayChangeListener *dcl,
             return;
         }
 
-        dprint(1, "%s: %dx%d (stride %d/%d, fourcc 0x%x)\n", __func__,
-               surface_width(ssd->ds), surface_height(ssd->ds),
-               surface_stride(ssd->ds), stride, fourcc);
+        trace_qemu_spice_gl_surface(ssd->qxl.id,
+                                    surface_width(ssd->ds),
+                                    surface_height(ssd->ds),
+                                    fourcc);
 
         /* note: spice server will close the fd */
         spice_qxl_gl_scanout(&ssd->qxl, fd,
@@ -932,7 +901,7 @@ static void qemu_spice_gl_scanout_disable(DisplayChangeListener *dcl)
 {
     SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
 
-    dprint(1, "%s: no framebuffer\n", __func__);
+    trace_qemu_spice_gl_scanout_disable(ssd->qxl.id);
     spice_qxl_gl_scanout(&ssd->qxl, -1, 0, 0, 0, 0, false);
     qemu_spice_gl_monitor_config(ssd, 0, 0, 0, 0);
     ssd->have_surface = false;
@@ -957,8 +926,7 @@ static void qemu_spice_gl_scanout_texture(DisplayChangeListener *dcl,
         fprintf(stderr, "%s: failed to get fd for texture\n", __func__);
         return;
     }
-    dprint(1, "%s: %dx%d (stride %d, fourcc 0x%x)\n", __func__,
-           w, h, stride, fourcc);
+    trace_qemu_spice_gl_scanout_texture(ssd->qxl.id, w, h, fourcc);
 
     /* note: spice server will close the fd */
     spice_qxl_gl_scanout(&ssd->qxl, fd, backing_width, backing_height,
@@ -978,7 +946,8 @@ static void qemu_spice_gl_update(DisplayChangeListener *dcl,
         return;
     }
 
-    dprint(2, "%s: %dx%d+%d+%d\n", __func__, w, h, x, y);
+
+    trace_qemu_spice_gl_update(ssd->qxl.id, w, h, x, y);
     qemu_spice_gl_block(ssd, true);
     cookie = (uintptr_t)qxl_cookie_new(QXL_COOKIE_TYPE_GL_DRAW_DONE, 0);
     spice_qxl_gl_draw_async(&ssd->qxl, x, y, w, h, cookie);
diff --git a/ui/trace-events b/ui/trace-events
index 861b68a305..518e950a01 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -75,6 +75,15 @@ qemu_spice_create_primary_surface(int qid, uint32_t sid, void *surface, int asyn
 qemu_spice_destroy_primary_surface(int qid, uint32_t sid, int async) "%d sid=%u async=%d"
 qemu_spice_wakeup(uint32_t qid) "%d"
 qemu_spice_create_update(uint32_t left, uint32_t right, uint32_t top, uint32_t bottom) "lr %d -> %d,  tb -> %d -> %d"
+qemu_spice_display_update(int qid, uint32_t x, uint32_t y, uint32_t w, uint32_t h) "%d +%d+%d %dx%d"
+qemu_spice_display_surface(int qid, uint32_t w, uint32_t h, int fast) "%d %dx%d, fast %d"
+qemu_spice_display_refresh(int qid, int notify) "%d notify %d"
+qemu_spice_ui_info(int qid, uint32_t width, uint32_t height) "%d %dx%d"
+
+qemu_spice_gl_surface(int qid, uint32_t w, uint32_t h, uint32_t fourcc) "%d %dx%d, fourcc 0x%x"
+qemu_spice_gl_scanout_disable(int qid) "%d"
+qemu_spice_gl_scanout_texture(int qid, uint32_t w, uint32_t h, uint32_t fourcc) "%d %dx%d, fourcc 0x%x"
+qemu_spice_gl_update(int qid, uint32_t x, uint32_t y, uint32_t w, uint32_t h) "%d +%d+%d %dx%d"
 
 # ui/keymaps.c
 keymap_parse(const char *file) "file %s"
-- 
2.9.3
