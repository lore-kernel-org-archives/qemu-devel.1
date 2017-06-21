Received: from eggs.gnu.org ([2001:4830:134:3::10]:44394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dNfbf-0005M6-Jl
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 09:23:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dNfbd-0003Ye-W4
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 09:23:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dNfbd-0003Y6-Mx
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 09:23:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C2EA75BEC9
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 13:23:36 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 21 Jun 2017 15:23:35 +0200
Message-Id: <20170621132340.27686-2-kraxel@redhat.com>
In-Reply-To: <20170621132340.27686-1-kraxel@redhat.com>
References: <20170621132340.27686-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/6] egl-helpers: add helpers to handle opengl
 framebuffers
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

Add a collection of egl_fb_*() helper functions to manage and use opengl
framebuffers, which is a common pattern in UI code with opengl support.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20170614084149.31314-2-kraxel@redhat.com
---
 include/ui/egl-helpers.h | 15 ++++++++++
 ui/egl-helpers.c         | 76 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index c785d60e91..be8908737c 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -8,6 +8,21 @@
 extern EGLDisplay *qemu_egl_display;
 extern EGLConfig qemu_egl_config;
 
+typedef struct egl_fb {
+    int width;
+    int height;
+    GLuint texture;
+    GLuint framebuffer;
+    bool delete_texture;
+} egl_fb;
+
+void egl_fb_destroy(egl_fb *fb);
+void egl_fb_setup_default(egl_fb *fb, int width, int height);
+void egl_fb_create_for_tex(egl_fb *fb, int width, int height, GLuint texture);
+void egl_fb_create_new_tex(egl_fb *fb, int width, int height);
+void egl_fb_blit(egl_fb *dst, egl_fb *src, bool flip);
+void egl_fb_read(void *dst, egl_fb *src);
+
 #ifdef CONFIG_OPENGL_DMABUF
 
 extern int qemu_egl_rn_fd;
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 4a4d3370ee..bb19a5eeca 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -24,6 +24,82 @@
 EGLDisplay *qemu_egl_display;
 EGLConfig qemu_egl_config;
 
+/* ------------------------------------------------------------------ */
+
+void egl_fb_destroy(egl_fb *fb)
+{
+    if (!fb->framebuffer) {
+        return;
+    }
+
+    if (fb->delete_texture) {
+        glDeleteTextures(1, &fb->texture);
+        fb->delete_texture = false;
+    }
+    glDeleteFramebuffers(1, &fb->framebuffer);
+
+    fb->width = 0;
+    fb->height = 0;
+    fb->texture = 0;
+    fb->framebuffer = 0;
+}
+
+void egl_fb_setup_default(egl_fb *fb, int width, int height)
+{
+    fb->width = width;
+    fb->height = height;
+    fb->framebuffer = 0; /* default framebuffer */
+}
+
+void egl_fb_create_for_tex(egl_fb *fb, int width, int height, GLuint texture)
+{
+    fb->width = width;
+    fb->height = height;
+    fb->texture = texture;
+    if (!fb->framebuffer) {
+        glGenFramebuffers(1, &fb->framebuffer);
+    }
+
+    glBindFramebuffer(GL_FRAMEBUFFER_EXT, fb->framebuffer);
+    glFramebufferTexture2DEXT(GL_FRAMEBUFFER_EXT, GL_COLOR_ATTACHMENT0_EXT,
+                              GL_TEXTURE_2D, fb->texture, 0);
+}
+
+void egl_fb_create_new_tex(egl_fb *fb, int width, int height)
+{
+    GLuint texture;
+
+    glGenTextures(1, &texture);
+    glBindTexture(GL_TEXTURE_2D, texture);
+    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width, height,
+                 0, GL_BGRA, GL_UNSIGNED_BYTE, 0);
+
+    egl_fb_create_for_tex(fb, width, height, texture);
+    fb->delete_texture = true;
+}
+
+void egl_fb_blit(egl_fb *dst, egl_fb *src, bool flip)
+{
+    GLuint y1, y2;
+
+    glBindFramebuffer(GL_READ_FRAMEBUFFER, src->framebuffer);
+    glBindFramebuffer(GL_DRAW_FRAMEBUFFER, dst->framebuffer);
+    glViewport(0, 0, dst->width, dst->height);
+    y1 = flip ? src->height : 0;
+    y2 = flip ? 0 : src->height;
+    glBlitFramebuffer(0, y1, src->width, y2,
+                      0, 0, dst->width, dst->height,
+                      GL_COLOR_BUFFER_BIT, GL_LINEAR);
+}
+
+void egl_fb_read(void *dst, egl_fb *src)
+{
+    glBindFramebuffer(GL_READ_FRAMEBUFFER, src->framebuffer);
+    glReadBuffer(GL_COLOR_ATTACHMENT0_EXT);
+    glReadPixels(0, 0, src->width, src->height,
+                 GL_BGRA, GL_UNSIGNED_BYTE, dst);
+}
+
 /* ---------------------------------------------------------------------- */
 
 #ifdef CONFIG_OPENGL_DMABUF
-- 
2.9.3
