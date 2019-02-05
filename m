Received: from eggs.gnu.org ([209.51.188.92]:42554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqyQq-0007N5-Pf
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:58:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqyQm-0006Fl-Ux
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:58:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39015)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gqyQd-00067V-4T
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:58:12 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  5 Feb 2019 11:57:50 +0100
Message-Id: <20190205105758.4230-7-kraxel@redhat.com>
In-Reply-To: <20190205105758.4230-1-kraxel@redhat.com>
References: <20190205105758.4230-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 06/14] ui/egl-helpers: Augment parameter list of
 egl_texture_blend() to convey scales of viewport
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Chen Zhang <tgfbeta@me.com>

From: Chen Zhang <tgfbeta@me.com>

This would help gtk-egl display showing scaled DMABuf cursor images when
gtk window was zoomed. A default scale of (1.0, 1.0) was presumed for
call sites where no scaling is needed.

Signed-off-by: Chen Zhang <tgfbeta@me.com>
Message-id: 23B229B3-3095-4DFB-8369-866784808D30@me.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/egl-helpers.h | 2 +-
 ui/egl-headless.c        | 3 ++-
 ui/egl-helpers.c         | 9 +++++----
 ui/gtk-egl.c             | 3 ++-
 ui/spice-display.c       | 2 +-
 5 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index 3fc656a7ba..b976cb8728 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -27,7 +27,7 @@ void egl_fb_read(void *dst, egl_fb *src);
 
 void egl_texture_blit(QemuGLShader *gls, egl_fb *dst, egl_fb *src, bool flip);
 void egl_texture_blend(QemuGLShader *gls, egl_fb *dst, egl_fb *src, bool flip,
-                       int x, int y);
+                       int x, int y, double scale_x, double scale_y);
 
 #ifdef CONFIG_OPENGL_DMABUF
 
diff --git a/ui/egl-headless.c b/ui/egl-headless.c
index 519e7bad32..e67b47aeff 100644
--- a/ui/egl-headless.c
+++ b/ui/egl-headless.c
@@ -142,7 +142,8 @@ static void egl_scanout_flush(DisplayChangeListener *dcl,
         egl_texture_blit(edpy->gls, &edpy->blit_fb, &edpy->guest_fb,
                          !edpy->y_0_top);
         egl_texture_blend(edpy->gls, &edpy->blit_fb, &edpy->cursor_fb,
-                          !edpy->y_0_top, edpy->pos_x, edpy->pos_y);
+                          !edpy->y_0_top, edpy->pos_x, edpy->pos_y,
+                          1.0, 1.0);
     } else {
         /* no cursor -> use simple framebuffer blit */
         egl_fb_blit(&edpy->blit_fb, &edpy->guest_fb, edpy->y_0_top);
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 5e115b3fb4..e90eef8c9c 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -120,14 +120,15 @@ void egl_texture_blit(QemuGLShader *gls, egl_fb *dst, egl_fb *src, bool flip)
 }
 
 void egl_texture_blend(QemuGLShader *gls, egl_fb *dst, egl_fb *src, bool flip,
-                       int x, int y)
+                       int x, int y, double scale_x, double scale_y)
 {
     glBindFramebuffer(GL_FRAMEBUFFER_EXT, dst->framebuffer);
+    int w = scale_x * src->width;
+    int h = scale_y * src->height;
     if (flip) {
-        glViewport(x, y, src->width, src->height);
+        glViewport(x, y, w, h);
     } else {
-        glViewport(x, dst->height - src->height - y,
-                   src->width, src->height);
+        glViewport(x, dst->height - h - y, w, h);
     }
     glEnable(GL_TEXTURE_2D);
     glBindTexture(GL_TEXTURE_2D, src->texture);
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index afd17148c0..42801b688b 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -278,7 +278,8 @@ void gd_egl_scanout_flush(DisplayChangeListener *dcl,
                          vc->gfx.y0_top);
         egl_texture_blend(vc->gfx.gls, &vc->gfx.win_fb, &vc->gfx.cursor_fb,
                           vc->gfx.y0_top,
-                          vc->gfx.cursor_x, vc->gfx.cursor_y);
+                          vc->gfx.cursor_x, vc->gfx.cursor_y,
+                          vc->gfx.scale_x, vc->gfx.scale_y);
     } else {
         egl_fb_blit(&vc->gfx.win_fb, &vc->gfx.guest_fb, !vc->gfx.y0_top);
     }
diff --git a/ui/spice-display.c b/ui/spice-display.c
index 52f8cb5ae1..aea6f6ebce 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -1090,7 +1090,7 @@ static void qemu_spice_gl_update(DisplayChangeListener *dcl,
         egl_texture_blit(ssd->gls, &ssd->blit_fb, &ssd->guest_fb,
                          !y_0_top);
         egl_texture_blend(ssd->gls, &ssd->blit_fb, &ssd->cursor_fb,
-                          !y_0_top, x, y);
+                          !y_0_top, x, y, 1.0, 1.0);
         glFlush();
     }
 
-- 
2.9.3
