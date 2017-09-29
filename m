Received: from eggs.gnu.org ([2001:4830:134:3::10]:41414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dxsQr-00073J-Pu
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 06:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dxsQm-0005fI-Ui
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 06:22:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dxsQm-0005eG-Mv
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 06:22:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 279D72CA4
	for <qemu-devel@nongnu.org>; Fri, 29 Sep 2017 10:22:03 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 29 Sep 2017 12:21:58 +0200
Message-Id: <20170929102201.15408-3-kraxel@redhat.com>
In-Reply-To: <20170929102201.15408-1-kraxel@redhat.com>
References: <20170929102201.15408-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/5] egl: misc framebuffer helper improvements.
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
List-ID: <qemu-devel.nongnu.org>

Rename the functions to to say "setup" instead of "create" because they
support being called multiple times on the same egl framebuffer.

Properly delete unused textures, update function interfaces to support
this.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20170927115031.12063-1-kraxel@redhat.com
---
 include/ui/egl-helpers.h |  5 +++--
 ui/egl-headless.c        |  6 +++---
 ui/egl-helpers.c         | 26 ++++++++++++++++++--------
 ui/gtk-egl.c             |  4 ++--
 ui/gtk-gl-area.c         |  4 ++--
 ui/sdl2-gl.c             |  4 ++--
 6 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index be8908737c..81cb255de0 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -18,8 +18,9 @@ typedef struct egl_fb {
 
 void egl_fb_destroy(egl_fb *fb);
 void egl_fb_setup_default(egl_fb *fb, int width, int height);
-void egl_fb_create_for_tex(egl_fb *fb, int width, int height, GLuint texture);
-void egl_fb_create_new_tex(egl_fb *fb, int width, int height);
+void egl_fb_setup_for_tex(egl_fb *fb, int width, int height,
+                          GLuint texture, bool delete);
+void egl_fb_setup_new_tex(egl_fb *fb, int width, int height);
 void egl_fb_blit(egl_fb *dst, egl_fb *src, bool flip);
 void egl_fb_read(void *dst, egl_fb *src);
 
diff --git a/ui/egl-headless.c b/ui/egl-headless.c
index 809bfde99c..12ad64e995 100644
--- a/ui/egl-headless.c
+++ b/ui/egl-headless.c
@@ -54,14 +54,14 @@ static void egl_scanout_texture(DisplayChangeListener *dcl,
     edpy->y_0_top = backing_y_0_top;
 
     /* source framebuffer */
-    egl_fb_create_for_tex(&edpy->guest_fb,
-                          backing_width, backing_height, backing_id);
+    egl_fb_setup_for_tex(&edpy->guest_fb,
+                         backing_width, backing_height, backing_id, false);
 
     /* dest framebuffer */
     if (edpy->blit_fb.width  != backing_width ||
         edpy->blit_fb.height != backing_height) {
         egl_fb_destroy(&edpy->blit_fb);
-        egl_fb_create_new_tex(&edpy->blit_fb, backing_width, backing_height);
+        egl_fb_setup_new_tex(&edpy->blit_fb, backing_width, backing_height);
     }
 }
 
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index bb19a5eeca..cde9965dea 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -26,16 +26,23 @@ EGLConfig qemu_egl_config;
 
 /* ------------------------------------------------------------------ */
 
+static void egl_fb_delete_texture(egl_fb *fb)
+{
+    if (!fb->delete_texture) {
+        return;
+    }
+
+    glDeleteTextures(1, &fb->texture);
+    fb->delete_texture = false;
+}
+
 void egl_fb_destroy(egl_fb *fb)
 {
     if (!fb->framebuffer) {
         return;
     }
 
-    if (fb->delete_texture) {
-        glDeleteTextures(1, &fb->texture);
-        fb->delete_texture = false;
-    }
+    egl_fb_delete_texture(fb);
     glDeleteFramebuffers(1, &fb->framebuffer);
 
     fb->width = 0;
@@ -51,11 +58,15 @@ void egl_fb_setup_default(egl_fb *fb, int width, int height)
     fb->framebuffer = 0; /* default framebuffer */
 }
 
-void egl_fb_create_for_tex(egl_fb *fb, int width, int height, GLuint texture)
+void egl_fb_setup_for_tex(egl_fb *fb, int width, int height,
+                          GLuint texture, bool delete)
 {
+    egl_fb_delete_texture(fb);
+
     fb->width = width;
     fb->height = height;
     fb->texture = texture;
+    fb->delete_texture = delete;
     if (!fb->framebuffer) {
         glGenFramebuffers(1, &fb->framebuffer);
     }
@@ -65,7 +76,7 @@ void egl_fb_create_for_tex(egl_fb *fb, int width, int height, GLuint texture)
                               GL_TEXTURE_2D, fb->texture, 0);
 }
 
-void egl_fb_create_new_tex(egl_fb *fb, int width, int height)
+void egl_fb_setup_new_tex(egl_fb *fb, int width, int height)
 {
     GLuint texture;
 
@@ -74,8 +85,7 @@ void egl_fb_create_new_tex(egl_fb *fb, int width, int height)
     glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width, height,
                  0, GL_BGRA, GL_UNSIGNED_BYTE, 0);
 
-    egl_fb_create_for_tex(fb, width, height, texture);
-    fb->delete_texture = true;
+    egl_fb_setup_for_tex(fb, width, height, texture, true);
 }
 
 void egl_fb_blit(egl_fb *dst, egl_fb *src, bool flip)
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 0d5cab2bc8..0f0d35e041 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -190,8 +190,8 @@ void gd_egl_scanout_texture(DisplayChangeListener *dcl,
                    vc->gfx.esurface, vc->gfx.ectx);
 
     gtk_egl_set_scanout_mode(vc, true);
-    egl_fb_create_for_tex(&vc->gfx.guest_fb, backing_width, backing_height,
-                          backing_id);
+    egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_height,
+                         backing_id, false);
 }
 
 void gd_egl_scanout_flush(DisplayChangeListener *dcl,
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 18b298fc21..01ebf2c7de 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -185,8 +185,8 @@ void gd_gl_area_scanout_texture(DisplayChangeListener *dcl,
     }
 
     gtk_gl_area_set_scanout_mode(vc, true);
-    egl_fb_create_for_tex(&vc->gfx.guest_fb, backing_width, backing_height,
-                          backing_id);
+    egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_height,
+                         backing_id, false);
 }
 
 void gd_gl_area_scanout_flush(DisplayChangeListener *dcl,
diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index dcad3d0d26..9110491ee5 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -207,8 +207,8 @@ void sdl2_gl_scanout_texture(DisplayChangeListener *dcl,
     SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
 
     sdl2_set_scanout_mode(scon, true);
-    egl_fb_create_for_tex(&scon->guest_fb, backing_width, backing_height,
-                          backing_id);
+    egl_fb_setup_for_tex(&scon->guest_fb, backing_width, backing_height,
+                         backing_id, false);
 }
 
 void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
-- 
2.9.3
