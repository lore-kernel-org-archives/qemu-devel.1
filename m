Received: from eggs.gnu.org ([2001:4830:134:3::10]:41575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ciO0i-0002RG-9d
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:18:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ciO0h-0002mh-5J
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:18:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ciO0g-0002mA-WC
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:18:51 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 369503B716
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 16:18:51 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 27 Feb 2017 17:18:40 +0100
Message-Id: <1488212323-26882-7-git-send-email-kraxel@redhat.com>
In-Reply-To: <1488212323-26882-1-git-send-email-kraxel@redhat.com>
References: <1488212323-26882-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 6/9] gtk-egl: add scanout_disable support
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
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 1487669841-13668-7-git-send-email-kraxel@redhat.com
---
 include/ui/gtk.h |  1 +
 ui/gtk-egl.c     | 15 ++++++++++-----
 ui/gtk.c         |  1 +
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index 408e21b..ca9a226 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -103,6 +103,7 @@ void gd_egl_switch(DisplayChangeListener *dcl,
                    DisplaySurface *surface);
 QEMUGLContext gd_egl_create_context(DisplayChangeListener *dcl,
                                     QEMUGLParams *params);
+void gd_egl_scanout_disable(DisplayChangeListener *dcl);
 void gd_egl_scanout_texture(DisplayChangeListener *dcl,
                             uint32_t backing_id,
                             bool backing_y_0_top,
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index d5541c3..d53288f 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -170,6 +170,16 @@ QEMUGLContext gd_egl_create_context(DisplayChangeLis=
tener *dcl,
     return qemu_egl_create_context(dcl, params);
 }
=20
+void gd_egl_scanout_disable(DisplayChangeListener *dcl)
+{
+    VirtualConsole *vc =3D container_of(dcl, VirtualConsole, gfx.dcl);
+
+    vc->gfx.w =3D 0;
+    vc->gfx.h =3D 0;
+    vc->gfx.tex_id =3D 0;
+    gtk_egl_set_scanout_mode(vc, false);
+}
+
 void gd_egl_scanout_texture(DisplayChangeListener *dcl,
                             uint32_t backing_id, bool backing_y_0_top,
                             uint32_t backing_width, uint32_t backing_hei=
ght,
@@ -188,11 +198,6 @@ void gd_egl_scanout_texture(DisplayChangeListener *d=
cl,
     eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
                    vc->gfx.esurface, vc->gfx.ectx);
=20
-    if (vc->gfx.tex_id =3D=3D 0 || vc->gfx.w =3D=3D 0 || vc->gfx.h =3D=3D=
 0) {
-        gtk_egl_set_scanout_mode(vc, false);
-        return;
-    }
-
     gtk_egl_set_scanout_mode(vc, true);
     if (!vc->gfx.fbo_id) {
         glGenFramebuffers(1, &vc->gfx.fbo_id);
diff --git a/ui/gtk.c b/ui/gtk.c
index 1dd0b53..640ff84 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -688,6 +688,7 @@ static const DisplayChangeListenerOps dcl_egl_ops =3D=
 {
     .dpy_gl_ctx_destroy      =3D qemu_egl_destroy_context,
     .dpy_gl_ctx_make_current =3D gd_egl_make_current,
     .dpy_gl_ctx_get_current  =3D qemu_egl_get_current_context,
+    .dpy_gl_scanout_disable  =3D gd_egl_scanout_disable,
     .dpy_gl_scanout_texture  =3D gd_egl_scanout_texture,
     .dpy_gl_update           =3D gd_egl_scanout_flush,
 };
--=20
1.8.3.1
