Received: from eggs.gnu.org ([2001:4830:134:3::10]:49637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1et8bo-0002EL-4e
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 04:10:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1et8bj-0000Sc-2D
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 04:10:08 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56152 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1et8bi-0000Rh-Tf
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 04:10:02 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 975494040859
	for <qemu-devel@nongnu.org>; Tue,  6 Mar 2018 09:09:57 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  6 Mar 2018 10:09:50 +0100
Message-Id: <20180306090951.22932-6-kraxel@redhat.com>
In-Reply-To: <20180306090951.22932-1-kraxel@redhat.com>
References: <20180306090951.22932-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 5/6] ui/gtk-egl: add scanout_dmabuf support
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

Add support for dmabuf scanouts to gtk-egl.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/gtk.h |  4 ++++
 ui/gtk-egl.c     | 23 +++++++++++++++++++++++
 ui/gtk.c         |  2 ++
 3 files changed, 29 insertions(+)

diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index f6dafc5961..84c992c227 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -113,6 +113,10 @@ void gd_egl_scanout_texture(DisplayChangeListener *dcl,
                             uint32_t backing_height,
                             uint32_t x, uint32_t y,
                             uint32_t w, uint32_t h);
+void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
+                           QemuDmaBuf *dmabuf);
+void gd_egl_release_dmabuf(DisplayChangeListener *dcl,
+                           QemuDmaBuf *dmabuf);
 void gd_egl_scanout_flush(DisplayChangeListener *dcl,
                           uint32_t x, uint32_t y, uint32_t w, uint32_t h);
 void gtk_egl_init(void);
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index eb86c26a1d..2c83c22d04 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -194,6 +194,29 @@ void gd_egl_scanout_texture(DisplayChangeListener *dcl,
                          backing_id, false);
 }
 
+void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
+                           QemuDmaBuf *dmabuf)
+{
+#ifdef CONFIG_OPENGL_DMABUF
+    egl_dmabuf_import_texture(dmabuf);
+    if (!dmabuf->texture) {
+        return;
+    }
+
+    gd_egl_scanout_texture(dcl, dmabuf->texture,
+                           false, dmabuf->width, dmabuf->height,
+                           0, 0, dmabuf->width, dmabuf->height);
+#endif
+}
+
+void gd_egl_release_dmabuf(DisplayChangeListener *dcl,
+                           QemuDmaBuf *dmabuf)
+{
+#ifdef CONFIG_OPENGL_DMABUF
+    egl_dmabuf_release_texture(dmabuf);
+#endif
+}
+
 void gd_egl_scanout_flush(DisplayChangeListener *dcl,
                           uint32_t x, uint32_t y, uint32_t w, uint32_t h)
 {
diff --git a/ui/gtk.c b/ui/gtk.c
index 4a1622b887..cf2061d716 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -744,6 +744,8 @@ static const DisplayChangeListenerOps dcl_egl_ops = {
     .dpy_gl_ctx_get_current  = qemu_egl_get_current_context,
     .dpy_gl_scanout_disable  = gd_egl_scanout_disable,
     .dpy_gl_scanout_texture  = gd_egl_scanout_texture,
+    .dpy_gl_scanout_dmabuf   = gd_egl_scanout_dmabuf,
+    .dpy_gl_release_dmabuf   = gd_egl_release_dmabuf,
     .dpy_gl_update           = gd_egl_scanout_flush,
 };
 
-- 
2.9.3
