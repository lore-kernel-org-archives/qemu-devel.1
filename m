Received: from eggs.gnu.org ([2001:4830:134:3::10]:36542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgfbeta@icloud.com>) id 1gKClC-0001AX-OQ
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 20:36:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgfbeta@icloud.com>) id 1gKCkz-0001Kl-MF
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 20:35:51 -0500
Received: from pv33p00im-asmtp002.me.com ([17.142.194.251]:37143)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgfbeta@icloud.com>) id 1gKCkz-0000Rr-2A
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 20:35:45 -0500
Received: from process-dkim-sign-daemon.pv33p00im-asmtp002.me.com by
	pv33p00im-asmtp002.me.com
	(Oracle Communications Messaging Server 8.0.2.2.20180531 64bit (built
	May 31 2018)) id <0PHS00J00TTL4600@pv33p00im-asmtp002.me.com> for
	qemu-devel@nongnu.org; Wed, 07 Nov 2018 01:35:32 +0000 (GMT)
From: Chen Zhang <tgfbeta@icloud.com>
Date: Wed, 07 Nov 2018 01:35:30 +0000 (GMT)
Message-id: <9a5fadaf-d74a-4201-80db-2bed26647587@me.com>
MIME-version: 1.0
Content-Type: text/plain;
    charset=utf-8;
    format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
 =?utf-8?q?=5BPATCH=5D_gtk=3A_Fix_mouse_offset_in_sc?=
 =?utf-8?q?aled_gtk-gl_display_for_VFIO/iGVT-g_DMA_Buf_mode?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

Yes, this patch just works.=0A=0AThank you.=0A=0ABest regards=0A=0AOn Nov =
06, 2018, at 08:22 PM, Gerd Hoffmann <kraxel@redhat.com> wrote:=0A=0AOn We=
d, Oct 31, 2018 at 06:24:56AM +0000, Chen Zhang wrote:=0AThe issue was rep=
orted as in=C2=A0https://bugs.launchpad.net/qemu/+bug/1793859=0A=0AWhen an=
 OpenGL accelerated GTK window is used for iGVT-g DMA Buf device,=0Awindow=
 scaling would cause guest cursor to move in undesirable velocity.=0A=0ATo=
 fix this usability issue, the gtk mouse motion events was modified to=0As=
cale the position of event to match the coordinates=C2=A0of the scaled GL=0A=
surface.=0A=0AHmm, we already have logic in place to deal with that. I sus=
pect the=0Aroot cause is simply that the scale_{x,y} variables are not set=
 properly=0Ain egl mode. Can you try the patch below?=0A=0Athanks,=0AGerd=0A=
=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D [ cut here ] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=0AFrom ebecaab0102aca37a3101131c20f45576835b6b=
3 Mon Sep 17 00:00:00 2001=0AFrom: Gerd Hoffmann <kraxel@redhat.com>=0ADat=
e: Tue, 6 Nov 2018 13:18:39 +0100=0ASubject: [PATCH] try fix gtk egl curso=
r=0A=0A---=0Aui/gtk-egl.c | 17 ++++++++++++-----=0A1 file changed, 12 inse=
rtions(+), 5 deletions(-)=0A=0Adiff --git a/ui/gtk-egl.c b/ui/gtk-egl.c=0A=
index a77c25b490..5420c2362b 100644=0A--- a/ui/gtk-egl.c=0A+++ b/ui/gtk-eg=
l.c=0A@@ -68,8 +68,15 @@ void gd_egl_draw(VirtualConsole *vc)=0Areturn;=0A=
}=0A=0A+ window =3D gtk_widget_get_window(vc->gfx.drawing_area);=0A+ ww =3D=
 gdk_window_get_width(window);=0A+ wh =3D gdk_window_get_height(window);=0A=
+=0Aif (vc->gfx.scanout_mode) {=0Agd_egl_scanout_flush(&vc->gfx.dcl, 0, 0,=
 vc->gfx.w, vc->gfx.h);=0A+=0A+ vc->gfx.scale_x =3D (double)ww / vc->gfx.w=
;=0A+ vc->gfx.scale_y =3D (double)wh / vc->gfx.h;=0A} else {=0Aif (!vc->gf=
x.ds) {=0Areturn;=0A@@ -77,13 +84,13 @@ void gd_egl_draw(VirtualConsole *v=
c)=0AeglMakeCurrent(qemu_egl_display, vc->gfx.esurface,=0Avc->gfx.esurface=
, vc->gfx.ectx);=0A=0A- window =3D gtk_widget_get_window(vc->gfx.drawing_a=
rea);=0A- ww =3D gdk_window_get_width(window);=0A- wh =3D gdk_window_get_h=
eight(window);=0Asurface_gl_setup_viewport(vc->gfx.gls, vc->gfx.ds, ww, wh=
);=0Asurface_gl_render_texture(vc->gfx.gls, vc->gfx.ds);=0A=0AeglSwapBuffe=
rs(qemu_egl_display, vc->gfx.esurface);=0A+=0A+ vc->gfx.scale_x =3D (doubl=
e)ww / surface_width(vc->gfx.ds);=0A+ vc->gfx.scale_y =3D (double)wh / sur=
face_height(vc->gfx.ds);=0A}=0A}=0A=0A@@ -232,8 +239,8 @@ void gd_egl_curs=
or_position(DisplayChangeListener *dcl,=0A{=0AVirtualConsole *vc =3D conta=
iner_of(dcl, VirtualConsole, gfx.dcl);=0A=0A- vc->gfx.cursor_x =3D pos_x;=0A=
- vc->gfx.cursor_y =3D pos_y;=0A+ vc->gfx.cursor_x =3D pos_x * vc->gfx.sca=
le_x;=0A+ vc->gfx.cursor_y =3D pos_y * vc->gfx.scale_y;=0A}=0A=0Avoid gd_e=
gl_release_dmabuf(DisplayChangeListener *dcl,=0A-- =0A2.9.3=0A
