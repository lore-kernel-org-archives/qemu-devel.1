Received: from eggs.gnu.org ([209.51.188.92]:55581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glaJ5-0008I2-KJ
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:12:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glaJ4-0000nL-Nh
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:12:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1glaJ4-0000lt-I5
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:12:06 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 21 Jan 2019 15:11:51 +0100
Message-Id: <20190121141152.948-6-kraxel@redhat.com>
In-Reply-To: <20190121141152.948-1-kraxel@redhat.com>
References: <20190121141152.948-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/5] egl-helpers.h: do not depend on X11 Window
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, Alexander Kanavin <alex.kanavin@gmail.com>

From: Alexander Kanavin <alex.kanavin@gmail.com>

It was assumed that mesa provides the necessary X11 includes,
but it is not always the case, as it can be configured without x11 suppor=
t.

Signed-off-by: Alexander Kanavin <alex.kanavin@gmail.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20190116113751.17177-1-alex.kanavin@gmail.com

[ kraxel: codestyle fix (long line) ]

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/egl-helpers.h | 2 +-
 ui/egl-helpers.c         | 4 ++--
 ui/gtk-egl.c             | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index 9db7293bdb..3fc656a7ba 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -43,7 +43,7 @@ void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf);
=20
 #endif
=20
-EGLSurface qemu_egl_init_surface_x11(EGLContext ectx, Window win);
+EGLSurface qemu_egl_init_surface_x11(EGLContext ectx, EGLNativeWindowTyp=
e win);
=20
 int qemu_egl_init_dpy_x11(EGLNativeDisplayType dpy, DisplayGLMode mode);
 int qemu_egl_init_dpy_mesa(EGLNativeDisplayType dpy, DisplayGLMode mode)=
;
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 4f475142fc..5e115b3fb4 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -273,14 +273,14 @@ void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf)
=20
 /* ---------------------------------------------------------------------=
- */
=20
-EGLSurface qemu_egl_init_surface_x11(EGLContext ectx, Window win)
+EGLSurface qemu_egl_init_surface_x11(EGLContext ectx, EGLNativeWindowTyp=
e win)
 {
     EGLSurface esurface;
     EGLBoolean b;
=20
     esurface =3D eglCreateWindowSurface(qemu_egl_display,
                                       qemu_egl_config,
-                                      (EGLNativeWindowType)win, NULL);
+                                      win, NULL);
     if (esurface =3D=3D EGL_NO_SURFACE) {
         error_report("egl: eglCreateWindowSurface failed");
         return NULL;
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 5420c2362b..afd17148c0 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -54,7 +54,8 @@ void gd_egl_init(VirtualConsole *vc)
     }
=20
     vc->gfx.ectx =3D qemu_egl_init_ctx();
-    vc->gfx.esurface =3D qemu_egl_init_surface_x11(vc->gfx.ectx, x11_win=
dow);
+    vc->gfx.esurface =3D qemu_egl_init_surface_x11
+        (vc->gfx.ectx, (EGLNativeWindowType)x11_window);
=20
     assert(vc->gfx.esurface);
 }
--=20
2.9.3
