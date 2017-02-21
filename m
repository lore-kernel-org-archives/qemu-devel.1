Received: from eggs.gnu.org ([2001:4830:134:3::10]:33483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg6sz-0000rc-1Z
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:37:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg6sw-0006A1-0C
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:37:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cg6sv-00069H-Oj
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:37:25 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC109326BB
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 09:37:25 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Feb 2017 10:37:19 +0100
Message-Id: <1487669841-13668-5-git-send-email-kraxel@redhat.com>
In-Reply-To: <1487669841-13668-1-git-send-email-kraxel@redhat.com>
References: <1487669841-13668-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 4/6] spice: add scanout_disable support
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
 ui/spice-display.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/ui/spice-display.c b/ui/spice-display.c
index b80a9f3..23ccf2a 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -928,6 +928,17 @@ static QEMUGLContext qemu_spice_gl_create_context(DisplayChangeListener *dcl,
     return qemu_egl_create_context(dcl, params);
 }
 
+static void qemu_spice_gl_scanout_disable(DisplayChangeListener *dcl)
+{
+    SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
+
+    dprint(1, "%s: no framebuffer\n", __func__);
+    spice_qxl_gl_scanout(&ssd->qxl, -1, 0, 0, 0, 0, false);
+    qemu_spice_gl_monitor_config(ssd, 0, 0, 0, 0);
+    ssd->have_surface = false;
+    ssd->have_scanout = false;
+}
+
 static void qemu_spice_gl_scanout_texture(DisplayChangeListener *dcl,
                                           uint32_t tex_id,
                                           bool y_0_top,
@@ -940,27 +951,21 @@ static void qemu_spice_gl_scanout_texture(DisplayChangeListener *dcl,
     EGLint stride = 0, fourcc = 0;
     int fd = -1;
 
-    if (tex_id) {
-        fd = egl_get_fd_for_texture(tex_id, &stride, &fourcc);
-        if (fd < 0) {
-            fprintf(stderr, "%s: failed to get fd for texture\n", __func__);
-            return;
-        }
-        dprint(1, "%s: %dx%d (stride %d, fourcc 0x%x)\n", __func__,
-               w, h, stride, fourcc);
-    } else {
-        dprint(1, "%s: no texture (no framebuffer)\n", __func__);
+    assert(tex_id);
+    fd = egl_get_fd_for_texture(tex_id, &stride, &fourcc);
+    if (fd < 0) {
+        fprintf(stderr, "%s: failed to get fd for texture\n", __func__);
+        return;
     }
-
-    assert(!tex_id || fd >= 0);
+    dprint(1, "%s: %dx%d (stride %d, fourcc 0x%x)\n", __func__,
+           w, h, stride, fourcc);
 
     /* note: spice server will close the fd */
     spice_qxl_gl_scanout(&ssd->qxl, fd, backing_width, backing_height,
                          stride, fourcc, y_0_top);
-    ssd->have_surface = false;
-    ssd->have_scanout = (tex_id != 0);
-
     qemu_spice_gl_monitor_config(ssd, x, y, w, h);
+    ssd->have_surface = false;
+    ssd->have_scanout = true;
 }
 
 static void qemu_spice_gl_update(DisplayChangeListener *dcl,
@@ -993,6 +998,7 @@ static const DisplayChangeListenerOps display_listener_gl_ops = {
     .dpy_gl_ctx_make_current = qemu_egl_make_context_current,
     .dpy_gl_ctx_get_current  = qemu_egl_get_current_context,
 
+    .dpy_gl_scanout_disable  = qemu_spice_gl_scanout_disable,
     .dpy_gl_scanout_texture  = qemu_spice_gl_scanout_texture,
     .dpy_gl_update           = qemu_spice_gl_update,
 };
-- 
1.8.3.1
