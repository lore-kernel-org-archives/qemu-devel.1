Received: from eggs.gnu.org ([2001:4830:134:3::10]:43917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gK0Ne-00058w-RH
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:22:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gK0Nb-0004f7-Gm
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:22:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gK0Nb-0004eL-8c
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:22:47 -0500
Date: Tue, 6 Nov 2018 13:22:44 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181106122244.24zi7f23uvn7t6sf@sirius.home.kraxel.org>
References: <bf58421d-e1be-4e42-b155-cb4faa366b98@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <bf58421d-e1be-4e42-b155-cb4faa366b98@me.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] gtk: Fix mouse offset in scaled gtk-gl
 display for VFIO/iGVT-g DMA Buf mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chen Zhang <tgfbeta@icloud.com>
Cc: qemu-devel@nongnu.org

On Wed, Oct 31, 2018 at 06:24:56AM +0000, Chen Zhang wrote:
> The issue was reported as in=A0https://bugs.launchpad.net/qemu/+bug/179=
3859
>=20
> When an OpenGL accelerated GTK window is used for iGVT-g DMA Buf device=
,
> window scaling would cause guest cursor to move in undesirable velocity=
.
>=20
> To fix this usability issue, the gtk mouse motion events was modified t=
o
> scale the position of event to match the coordinates=A0of the scaled GL
> surface.

Hmm, we already have logic in place to deal with that.  I suspect the
root cause is simply that the scale_{x,y} variables are not set properly
in egl mode.  Can you try the patch below?

thanks,
  Gerd

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D [ cut here ] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>From ebecaab0102aca37a3101131c20f45576835b6b3 Mon Sep 17 00:00:00 2001
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 6 Nov 2018 13:18:39 +0100
Subject: [PATCH] try fix gtk egl cursor

---
 ui/gtk-egl.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index a77c25b490..5420c2362b 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -68,8 +68,15 @@ void gd_egl_draw(VirtualConsole *vc)
         return;
     }
=20
+    window =3D gtk_widget_get_window(vc->gfx.drawing_area);
+    ww =3D gdk_window_get_width(window);
+    wh =3D gdk_window_get_height(window);
+
     if (vc->gfx.scanout_mode) {
         gd_egl_scanout_flush(&vc->gfx.dcl, 0, 0, vc->gfx.w, vc->gfx.h);
+
+        vc->gfx.scale_x =3D (double)ww / vc->gfx.w;
+        vc->gfx.scale_y =3D (double)wh / vc->gfx.h;
     } else {
         if (!vc->gfx.ds) {
             return;
@@ -77,13 +84,13 @@ void gd_egl_draw(VirtualConsole *vc)
         eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
                        vc->gfx.esurface, vc->gfx.ectx);
=20
-        window =3D gtk_widget_get_window(vc->gfx.drawing_area);
-        ww =3D gdk_window_get_width(window);
-        wh =3D gdk_window_get_height(window);
         surface_gl_setup_viewport(vc->gfx.gls, vc->gfx.ds, ww, wh);
         surface_gl_render_texture(vc->gfx.gls, vc->gfx.ds);
=20
         eglSwapBuffers(qemu_egl_display, vc->gfx.esurface);
+
+        vc->gfx.scale_x =3D (double)ww / surface_width(vc->gfx.ds);
+        vc->gfx.scale_y =3D (double)wh / surface_height(vc->gfx.ds);
     }
 }
=20
@@ -232,8 +239,8 @@ void gd_egl_cursor_position(DisplayChangeListener *dc=
l,
 {
     VirtualConsole *vc =3D container_of(dcl, VirtualConsole, gfx.dcl);
=20
-    vc->gfx.cursor_x =3D pos_x;
-    vc->gfx.cursor_y =3D pos_y;
+    vc->gfx.cursor_x =3D pos_x * vc->gfx.scale_x;
+    vc->gfx.cursor_y =3D pos_y * vc->gfx.scale_y;
 }
=20
 void gd_egl_release_dmabuf(DisplayChangeListener *dcl,
--=20
2.9.3
