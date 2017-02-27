Received: from eggs.gnu.org ([2001:4830:134:3::10]:41574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ciO0i-0002RF-9R
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:18:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ciO0h-0002mt-AK
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:18:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ciO0h-0002mM-4m
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:18:51 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5BD704E4D6
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 16:18:51 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 27 Feb 2017 17:18:39 +0100
Message-Id: <1488212323-26882-6-git-send-email-kraxel@redhat.com>
In-Reply-To: <1488212323-26882-1-git-send-email-kraxel@redhat.com>
References: <1488212323-26882-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/9] sdl2: add scanout_disable support
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
Message-id: 1487669841-13668-6-git-send-email-kraxel@redhat.com
---
 include/ui/sdl2.h |  1 +
 ui/sdl2-gl.c      | 16 +++++++++++-----
 ui/sdl2.c         |  1 +
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
index 2de792f..aaf226c 100644
--- a/include/ui/sdl2.h
+++ b/include/ui/sdl2.h
@@ -62,6 +62,7 @@ int sdl2_gl_make_context_current(DisplayChangeListener =
*dcl,
                                  QEMUGLContext ctx);
 QEMUGLContext sdl2_gl_get_current_context(DisplayChangeListener *dcl);
=20
+void sdl2_gl_scanout_disable(DisplayChangeListener *dcl);
 void sdl2_gl_scanout_texture(DisplayChangeListener *dcl,
                              uint32_t backing_id,
                              bool backing_y_0_top,
diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index e25aa3b..1cd77e2 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -184,6 +184,17 @@ QEMUGLContext sdl2_gl_get_current_context(DisplayCha=
ngeListener *dcl)
     return (QEMUGLContext)sdlctx;
 }
=20
+void sdl2_gl_scanout_disable(DisplayChangeListener *dcl)
+{
+    struct sdl2_console *scon =3D container_of(dcl, struct sdl2_console,=
 dcl);
+
+    assert(scon->opengl);
+    scon->w =3D 0;
+    scon->h =3D 0;
+    scon->tex_id =3D 0;
+    sdl2_set_scanout_mode(scon, false);
+}
+
 void sdl2_gl_scanout_texture(DisplayChangeListener *dcl,
                              uint32_t backing_id,
                              bool backing_y_0_top,
@@ -204,11 +215,6 @@ void sdl2_gl_scanout_texture(DisplayChangeListener *=
dcl,
=20
     SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
=20
-    if (scon->tex_id =3D=3D 0 || scon->w =3D=3D 0 || scon->h =3D=3D 0) {
-        sdl2_set_scanout_mode(scon, false);
-        return;
-    }
-
     sdl2_set_scanout_mode(scon, true);
     if (!scon->fbo_id) {
         glGenFramebuffers(1, &scon->fbo_id);
diff --git a/ui/sdl2.c b/ui/sdl2.c
index febda80..faf9bdf 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -733,6 +733,7 @@ static const DisplayChangeListenerOps dcl_gl_ops =3D =
{
     .dpy_gl_ctx_destroy      =3D sdl2_gl_destroy_context,
     .dpy_gl_ctx_make_current =3D sdl2_gl_make_context_current,
     .dpy_gl_ctx_get_current  =3D sdl2_gl_get_current_context,
+    .dpy_gl_scanout_disable  =3D sdl2_gl_scanout_disable,
     .dpy_gl_scanout_texture  =3D sdl2_gl_scanout_texture,
     .dpy_gl_update           =3D sdl2_gl_scanout_flush,
 };
--=20
1.8.3.1
