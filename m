Received: from eggs.gnu.org ([2001:4830:134:3::10]:37950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e1uzu-00045O-R4
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:55:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e1uzs-0007WM-Ai
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:55:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e1uzs-0007V8-52
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:55:00 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 10 Oct 2017 15:54:52 +0200
Message-Id: <20171010135453.6704-6-kraxel@redhat.com>
In-Reply-To: <20171010135453.6704-1-kraxel@redhat.com>
References: <20171010135453.6704-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 5/6] egl-helpers: add egl_texture_blit and
 egl_texture_blend
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

egl_texture_blit() blits a texture, simliar to egl_fb_blit() but by
rendering the texture to the screen instead of using a framebuffer blit.

egl_texture_blend() renders a texture with alpha blending, will be used
to render the cursor to the screen.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/egl-helpers.h |  4 ++++
 ui/egl-helpers.c         | 27 +++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index 4924fe560d..747233ce58 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -24,6 +24,10 @@ void egl_fb_setup_new_tex(egl_fb *fb, int width, int height);
 void egl_fb_blit(egl_fb *dst, egl_fb *src, bool flip);
 void egl_fb_read(void *dst, egl_fb *src);
 
+void egl_texture_blit(QemuGLShader *gls, egl_fb *dst, egl_fb *src, bool flip);
+void egl_texture_blend(QemuGLShader *gls, egl_fb *dst, egl_fb *src, bool flip,
+                       int x, int y);
+
 #ifdef CONFIG_OPENGL_DMABUF
 
 extern int qemu_egl_rn_fd;
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index e7ee337d7e..5fa60ef4e8 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -111,6 +111,33 @@ void egl_fb_read(void *dst, egl_fb *src)
                  GL_BGRA, GL_UNSIGNED_BYTE, dst);
 }
 
+void egl_texture_blit(QemuGLShader *gls, egl_fb *dst, egl_fb *src, bool flip)
+{
+    glBindFramebuffer(GL_FRAMEBUFFER_EXT, dst->framebuffer);
+    glViewport(0, 0, dst->width, dst->height);
+    glEnable(GL_TEXTURE_2D);
+    glBindTexture(GL_TEXTURE_2D, src->texture);
+    qemu_gl_run_texture_blit(gls, flip);
+}
+
+void egl_texture_blend(QemuGLShader *gls, egl_fb *dst, egl_fb *src, bool flip,
+                       int x, int y)
+{
+    glBindFramebuffer(GL_FRAMEBUFFER_EXT, dst->framebuffer);
+    if (flip) {
+        glViewport(x, y, src->width, src->height);
+    } else {
+        glViewport(x, dst->height - src->height - y,
+                   src->width, src->height);
+    }
+    glEnable(GL_TEXTURE_2D);
+    glBindTexture(GL_TEXTURE_2D, src->texture);
+    glEnable(GL_BLEND);
+    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
+    qemu_gl_run_texture_blit(gls, flip);
+    glDisable(GL_BLEND);
+}
+
 /* ---------------------------------------------------------------------- */
 
 #ifdef CONFIG_OPENGL_DMABUF
-- 
2.9.3
