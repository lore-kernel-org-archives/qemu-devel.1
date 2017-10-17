Received: from eggs.gnu.org ([2001:4830:134:3::10]:52344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e4Pp0-0005Q5-11
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 07:14:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e4Poq-0001tf-HE
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 07:14:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e4Poq-0001sl-BN
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 07:13:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7CB8737E7A
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 11:13:55 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 17 Oct 2017 13:13:49 +0200
Message-Id: <20171017111350.8176-6-kraxel@redhat.com>
In-Reply-To: <20171017111350.8176-1-kraxel@redhat.com>
References: <20171017111350.8176-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 5/6] egl-helpers: add egl_texture_blit and
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
Cc: Gerd Hoffmann <kraxel@redhat.com>

egl_texture_blit() blits a texture, simliar to egl_fb_blit() but by
rendering the texture to the screen instead of using a framebuffer blit.

egl_texture_blend() renders a texture with alpha blending, will be used
to render the cursor to the screen.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20171010135453.6704-6-kraxel@redhat.com
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
