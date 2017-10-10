Received: from eggs.gnu.org ([2001:4830:134:3::10]:38028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e1v01-000470-G4
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:55:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e1uzr-0007Va-PM
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:55:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e1uzr-0007UD-EG
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:54:59 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 10 Oct 2017 15:54:51 +0200
Message-Id: <20171010135453.6704-5-kraxel@redhat.com>
In-Reply-To: <20171010135453.6704-1-kraxel@redhat.com>
References: <20171010135453.6704-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 4/6] egl-helpers: add dmabuf import support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, Gerd Hoffmann <kraxel@redhat.com>

Add helper function to import a dma-buf as opengl texture.
Also add a helper to release the texture again.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/egl-helpers.h |  3 +++
 ui/egl-helpers.c         | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index 81cb255de0..4924fe560d 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -33,6 +33,9 @@ extern EGLContext qemu_egl_rn_ctx;
 int egl_rendernode_init(const char *rendernode);
 int egl_get_fd_for_texture(uint32_t tex_id, EGLint *stride, EGLint *fourcc);
 
+void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf);
+void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf);
+
 #endif
 
 EGLSurface qemu_egl_init_surface_x11(EGLContext ectx, Window win);
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index cde9965dea..e7ee337d7e 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -19,6 +19,7 @@
 #include <dirent.h>
 
 #include "qemu/error-report.h"
+#include "ui/console.h"
 #include "ui/egl-helpers.h"
 
 EGLDisplay *qemu_egl_display;
@@ -241,6 +242,51 @@ int egl_get_fd_for_texture(uint32_t tex_id, EGLint *stride, EGLint *fourcc)
     return fd;
 }
 
+void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf)
+{
+    EGLImageKHR image = EGL_NO_IMAGE_KHR;
+    EGLint attrs[] = {
+        EGL_DMA_BUF_PLANE0_FD_EXT,      dmabuf->fd,
+        EGL_DMA_BUF_PLANE0_PITCH_EXT,   dmabuf->stride,
+        EGL_DMA_BUF_PLANE0_OFFSET_EXT,  0,
+        EGL_WIDTH,                      dmabuf->width,
+        EGL_HEIGHT,                     dmabuf->height,
+        EGL_LINUX_DRM_FOURCC_EXT,       dmabuf->fourcc,
+        EGL_NONE, /* end of list */
+    };
+
+    if (dmabuf->texture != 0) {
+        return;
+    }
+
+    image = eglCreateImageKHR(qemu_egl_display,
+                              EGL_NO_CONTEXT,
+                              EGL_LINUX_DMA_BUF_EXT,
+                              NULL, attrs);
+    if (image == EGL_NO_IMAGE_KHR) {
+        error_report("eglCreateImageKHR failed");
+        return;
+    }
+
+    glGenTextures(1, &dmabuf->texture);
+    glBindTexture(GL_TEXTURE_2D, dmabuf->texture);
+    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
+    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
+
+    glEGLImageTargetTexture2DOES(GL_TEXTURE_2D, (GLeglImageOES)image);
+    eglDestroyImageKHR(qemu_egl_display, image);
+}
+
+void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf)
+{
+    if (dmabuf->texture == 0) {
+        return;
+    }
+
+    glDeleteTextures(1, &dmabuf->texture);
+    dmabuf->texture = 0;
+}
+
 #endif /* CONFIG_OPENGL_DMABUF */
 
 /* ---------------------------------------------------------------------- */
-- 
2.9.3
