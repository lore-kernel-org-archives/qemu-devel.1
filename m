Received: from eggs.gnu.org ([2001:4830:134:3::10]:44846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etrVL-0008Gp-NY
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 04:06:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etrVF-0005iQ-Mo
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 04:06:27 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50056 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1etrVF-0005i0-I2
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 04:06:21 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3CA448424D
	for <qemu-devel@nongnu.org>; Thu,  8 Mar 2018 09:06:21 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  8 Mar 2018 10:06:17 +0100
Message-Id: <20180308090618.30147-4-kraxel@redhat.com>
In-Reply-To: <20180308090618.30147-1-kraxel@redhat.com>
References: <20180308090618.30147-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/3] spice: add cursor_dmabuf support
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

Add support for cursor dmabufs.  qemu has to render the cursor for
that, so in case a cursor is present qemu allocates a new dmabuf, blits
the scanout, blends in the pointer and passes on the new dmabuf to
spice-server.  Without cursor qemu continues to simply pass on the
scanout dmabuf as-is.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/spice-display.h |   9 ++++
 ui/spice-display.c         | 114 +++++++++++++++++++++++++++++++++++++++++++--
 ui/trace-events            |   3 ++
 3 files changed, 121 insertions(+), 5 deletions(-)

diff --git a/include/ui/spice-display.h b/include/ui/spice-display.h
index 6b5c73b21c..87a84a59d4 100644
--- a/include/ui/spice-display.h
+++ b/include/ui/spice-display.h
@@ -122,6 +122,15 @@ struct SimpleSpiceDisplay {
     int gl_updates;
     bool have_scanout;
     bool have_surface;
+
+    QemuDmaBuf *guest_dmabuf;
+    bool guest_dmabuf_refresh;
+    bool render_cursor;
+
+    egl_fb guest_fb;
+    egl_fb blit_fb;
+    egl_fb cursor_fb;
+    bool have_hot;
 #endif
 };
 
diff --git a/ui/spice-display.c b/ui/spice-display.c
index 4c33c92ae5..fe734821dd 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -941,25 +941,126 @@ static void qemu_spice_gl_scanout_dmabuf(DisplayChangeListener *dcl,
 {
     SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
 
-    /* note: spice server will close the fd, so hand over a dup */
-    spice_qxl_gl_scanout(&ssd->qxl, dup(dmabuf->fd),
-                         dmabuf->width, dmabuf->height,
-                         dmabuf->stride, dmabuf->fourcc, false);
-    qemu_spice_gl_monitor_config(ssd, 0, 0, dmabuf->width, dmabuf->height);
+    ssd->guest_dmabuf = dmabuf;
+    ssd->guest_dmabuf_refresh = true;
+
     ssd->have_surface = false;
     ssd->have_scanout = true;
 }
 
+static void qemu_spice_gl_cursor_dmabuf(DisplayChangeListener *dcl,
+                                        QemuDmaBuf *dmabuf, bool have_hot,
+                                        uint32_t hot_x, uint32_t hot_y)
+{
+    SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
+
+    ssd->have_hot = have_hot;
+    ssd->hot_x = hot_x;
+    ssd->hot_y = hot_y;
+
+    trace_qemu_spice_gl_cursor(ssd->qxl.id, dmabuf != NULL, have_hot);
+    if (dmabuf) {
+        egl_dmabuf_import_texture(dmabuf);
+        if (!dmabuf->texture) {
+            return;
+        }
+        egl_fb_setup_for_tex(&ssd->cursor_fb, dmabuf->width, dmabuf->height,
+                             dmabuf->texture, false);
+    } else {
+        egl_fb_destroy(&ssd->cursor_fb);
+    }
+}
+
+static void qemu_spice_gl_cursor_position(DisplayChangeListener *dcl,
+                                          uint32_t pos_x, uint32_t pos_y)
+{
+    SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
+
+    ssd->ptr_x = pos_x;
+    ssd->ptr_y = pos_y;
+}
+
+static void qemu_spice_gl_release_dmabuf(DisplayChangeListener *dcl,
+                                         QemuDmaBuf *dmabuf)
+{
+    SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
+
+    if (ssd->guest_dmabuf == dmabuf) {
+        ssd->guest_dmabuf = NULL;
+        ssd->guest_dmabuf_refresh = false;
+    }
+    egl_dmabuf_release_texture(dmabuf);
+}
+
 static void qemu_spice_gl_update(DisplayChangeListener *dcl,
                                  uint32_t x, uint32_t y, uint32_t w, uint32_t h)
 {
     SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
+    EGLint stride = 0, fourcc = 0;
+    bool render_cursor = false;
+    bool y_0_top = false; /* FIXME */
     uint64_t cookie;
+    int fd;
 
     if (!ssd->have_scanout) {
         return;
     }
 
+    if (ssd->cursor_fb.texture) {
+        render_cursor = true;
+    }
+    if (ssd->render_cursor != render_cursor) {
+        ssd->render_cursor = render_cursor;
+        ssd->guest_dmabuf_refresh = true;
+        egl_fb_destroy(&ssd->blit_fb);
+    }
+
+    if (ssd->guest_dmabuf_refresh) {
+        QemuDmaBuf *dmabuf = ssd->guest_dmabuf;
+        if (render_cursor) {
+            egl_dmabuf_import_texture(dmabuf);
+            if (!dmabuf->texture) {
+                return;
+            }
+
+            /* source framebuffer */
+            egl_fb_setup_for_tex(&ssd->guest_fb,
+                                 dmabuf->width, dmabuf->height,
+                                 dmabuf->texture, false);
+
+            /* dest framebuffer */
+            if (ssd->blit_fb.width  != dmabuf->width ||
+                ssd->blit_fb.height != dmabuf->height) {
+                trace_qemu_spice_gl_render_dmabuf(ssd->qxl.id, dmabuf->width,
+                                                  dmabuf->height);
+                egl_fb_destroy(&ssd->blit_fb);
+                egl_fb_setup_new_tex(&ssd->blit_fb,
+                                     dmabuf->width, dmabuf->height);
+                fd = egl_get_fd_for_texture(ssd->blit_fb.texture,
+                                            &stride, &fourcc);
+                spice_qxl_gl_scanout(&ssd->qxl, fd,
+                                     dmabuf->width, dmabuf->height,
+                                     stride, fourcc, false);
+            }
+        } else {
+            trace_qemu_spice_gl_forward_dmabuf(ssd->qxl.id,
+                                               dmabuf->width, dmabuf->height);
+            /* note: spice server will close the fd, so hand over a dup */
+            spice_qxl_gl_scanout(&ssd->qxl, dup(dmabuf->fd),
+                                 dmabuf->width, dmabuf->height,
+                                 dmabuf->stride, dmabuf->fourcc, false);
+        }
+        qemu_spice_gl_monitor_config(ssd, 0, 0, dmabuf->width, dmabuf->height);
+        ssd->guest_dmabuf_refresh = false;
+    }
+
+    if (render_cursor) {
+        egl_texture_blit(ssd->gls, &ssd->blit_fb, &ssd->guest_fb,
+                         !y_0_top);
+        egl_texture_blend(ssd->gls, &ssd->blit_fb, &ssd->cursor_fb,
+                          !y_0_top, ssd->ptr_x, ssd->ptr_y);
+        glFlush();
+    }
 
     trace_qemu_spice_gl_update(ssd->qxl.id, w, h, x, y);
     qemu_spice_gl_block(ssd, true);
@@ -984,6 +1085,9 @@ static const DisplayChangeListenerOps display_listener_gl_ops = {
     .dpy_gl_scanout_disable  = qemu_spice_gl_scanout_disable,
     .dpy_gl_scanout_texture  = qemu_spice_gl_scanout_texture,
     .dpy_gl_scanout_dmabuf   = qemu_spice_gl_scanout_dmabuf,
+    .dpy_gl_cursor_dmabuf    = qemu_spice_gl_cursor_dmabuf,
+    .dpy_gl_cursor_position  = qemu_spice_gl_cursor_position,
+    .dpy_gl_release_dmabuf   = qemu_spice_gl_release_dmabuf,
     .dpy_gl_update           = qemu_spice_gl_update,
 };
 
diff --git a/ui/trace-events b/ui/trace-events
index 518e950a01..a957f363f1 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -83,6 +83,9 @@ qemu_spice_ui_info(int qid, uint32_t width, uint32_t height) "%d %dx%d"
 qemu_spice_gl_surface(int qid, uint32_t w, uint32_t h, uint32_t fourcc) "%d %dx%d, fourcc 0x%x"
 qemu_spice_gl_scanout_disable(int qid) "%d"
 qemu_spice_gl_scanout_texture(int qid, uint32_t w, uint32_t h, uint32_t fourcc) "%d %dx%d, fourcc 0x%x"
+qemu_spice_gl_cursor(int qid, bool enabled, bool hotspot) "%d enabled %d, hotspot %d"
+qemu_spice_gl_forward_dmabuf(int qid, uint32_t width, uint32_t height) "%d %dx%d"
+qemu_spice_gl_render_dmabuf(int qid, uint32_t width, uint32_t height) "%d %dx%d"
 qemu_spice_gl_update(int qid, uint32_t x, uint32_t y, uint32_t w, uint32_t h) "%d +%d+%d %dx%d"
 
 # ui/keymaps.c
-- 
2.9.3
