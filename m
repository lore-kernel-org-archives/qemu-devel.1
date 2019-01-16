Received: from eggs.gnu.org ([209.51.188.92]:48351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.kanavin@gmail.com>) id 1gjjX2-0007DL-Bg
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:38:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.kanavin@gmail.com>) id 1gjjWz-0007rR-4T
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:38:50 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:37285)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.kanavin@gmail.com>)
	id 1gjjWp-0006pZ-Bs
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:38:41 -0500
Received: by mail-lj1-x243.google.com with SMTP id t18-v6so5165203ljd.4
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 03:38:00 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 16 Jan 2019 12:37:51 +0100
Message-Id: <20190116113751.17177-1-alex.kanavin@gmail.com>
Subject: [Qemu-devel] [PATCH] egl-helpers.h: do not depend on X11 Window
 type, use EGLNativeWindowType
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexander Kanavin <alex.kanavin@gmail.com>

It was assumed that mesa provides the necessary X11 includes,
but it is not always the case, as it can be configured without x11 support.

Signed-off-by: Alexander Kanavin <alex.kanavin@gmail.com>
---
 include/ui/egl-helpers.h | 2 +-
 ui/egl-helpers.c         | 4 ++--
 ui/gtk-egl.c             | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index 9db7293bdb..3fc656a7ba 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -43,7 +43,7 @@ void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf);
 
 #endif
 
-EGLSurface qemu_egl_init_surface_x11(EGLContext ectx, Window win);
+EGLSurface qemu_egl_init_surface_x11(EGLContext ectx, EGLNativeWindowType win);
 
 int qemu_egl_init_dpy_x11(EGLNativeDisplayType dpy, DisplayGLMode mode);
 int qemu_egl_init_dpy_mesa(EGLNativeDisplayType dpy, DisplayGLMode mode);
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 4f475142fc..5e115b3fb4 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -273,14 +273,14 @@ void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf)
 
 /* ---------------------------------------------------------------------- */
 
-EGLSurface qemu_egl_init_surface_x11(EGLContext ectx, Window win)
+EGLSurface qemu_egl_init_surface_x11(EGLContext ectx, EGLNativeWindowType win)
 {
     EGLSurface esurface;
     EGLBoolean b;
 
     esurface = eglCreateWindowSurface(qemu_egl_display,
                                       qemu_egl_config,
-                                      (EGLNativeWindowType)win, NULL);
+                                      win, NULL);
     if (esurface == EGL_NO_SURFACE) {
         error_report("egl: eglCreateWindowSurface failed");
         return NULL;
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 5420c2362b..1f9411626a 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -54,7 +54,7 @@ void gd_egl_init(VirtualConsole *vc)
     }
 
     vc->gfx.ectx = qemu_egl_init_ctx();
-    vc->gfx.esurface = qemu_egl_init_surface_x11(vc->gfx.ectx, x11_window);
+    vc->gfx.esurface = qemu_egl_init_surface_x11(vc->gfx.ectx, (EGLNativeWindowType)x11_window);
 
     assert(vc->gfx.esurface);
 }
-- 
2.17.1
