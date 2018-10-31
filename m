Received: from eggs.gnu.org ([2001:4830:134:3::10]:60660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgfbeta@icloud.com>) id 1gHjwt-0000Jd-Pf
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 02:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgfbeta@icloud.com>) id 1gHjwp-0001rB-VD
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 02:25:51 -0400
Received: from ms11p00im-qufv17100101.me.com ([17.58.37.19]:47626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgfbeta@icloud.com>) id 1gHjwn-0001mO-TA
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 02:25:47 -0400
Received: from process-dkim-sign-daemon.ms11p00im-qufv17100101.me.com by
	ms11p00im-qufv17100101.me.com
	(Oracle Communications Messaging Server 8.0.2.2.20180531 64bit (built
	May 31 2018)) id <0PHG003009HOT900@ms11p00im-qufv17100101.me.com> for
	qemu-devel@nongnu.org; Wed, 31 Oct 2018 06:25:29 +0000 (GMT)
From: Chen Zhang <tgfbeta@icloud.com>
Date: Wed, 31 Oct 2018 06:24:56 +0000 (GMT)
Message-id: <bf58421d-e1be-4e42-b155-cb4faa366b98@me.com>
MIME-version: 1.0
Content-Type: text/plain;
    charset=utf-8;
    format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] =?utf-8?q?=5BPATCH=5D_gtk=3A_Fix_mouse_offset_in_sca?=
 =?utf-8?q?led_gtk-gl_display_for_VFIO/iGVT-g_DMA_Buf_mode?=
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

The issue was reported as in=C2=A0https://bugs.launchpad.net/qemu/+bug/179=
3859=0A=0AWhen an OpenGL accelerated GTK window is used for iGVT-g DMA Buf=
 device,=0Awindow scaling would cause guest cursor to move in undesirable =
velocity.=0A=0ATo fix this usability issue, the gtk mouse motion events wa=
s modified to=0Ascale the position of event to match the coordinates=C2=A0=
of the scaled GL=0Asurface.=0A=0ASigned-off-by: Chen Zhang <tgfbeta@me.com=
>=0A---=0A=C2=A0ui/gtk-egl.c | 10 +++++++---=0A=C2=A0ui/gtk.c =C2=A0 =C2=A0=
 | 19 +++++++++++++------=0A=C2=A02 files changed, 20 insertions(+), 9 del=
etions(-)=0A=0Adiff --git a/ui/gtk-egl.c b/ui/gtk-egl.c=0Aindex a77c25b..8=
24beed 100644=0A--- a/ui/gtk-egl.c=0A+++ b/ui/gtk-egl.c=0A@@ -231,9 +231,1=
3 @@ void gd_egl_cursor_position(DisplayChangeListener *dcl,=0A=C2=A0=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 uint32_t pos_x, uint32_t pos_y)=0A=C2=A0{=0A=C2=A0=C2=A0=
 =C2=A0 VirtualConsole *vc =3D container_of(dcl, VirtualConsole, gfx.dcl);=
=0A-=0A-=C2=A0 =C2=A0 vc->gfx.cursor_x =3D pos_x;=0A-=C2=A0 =C2=A0 vc->gfx=
.cursor_y =3D pos_y;=0A+=C2=A0 =C2=A0 uint32_t sw =3D surface_width(vc->gf=
x.ds);=0A+=C2=A0 =C2=A0 uint32_t sh =3D surface_height(vc->gfx.ds);=0A+=C2=
=A0 =C2=A0 GdkWindow *window =3D gtk_widget_get_window(vc->gfx.drawing_are=
a);=0A+=C2=A0 =C2=A0 uint32_t ww =3D gdk_window_get_width(window);=0A+=C2=A0=
 =C2=A0 uint32_t wh =3D gdk_window_get_height(window);=0A+=C2=A0 =C2=A0 vc=
->gfx.cursor_x =3D pos_x * ww / sw;=0A+=C2=A0 =C2=A0 vc->gfx.cursor_y =3D =
pos_y * wh / sh;=0A=C2=A0}=0A=C2=A0=0A=C2=A0void gd_egl_release_dmabuf(Dis=
playChangeListener *dcl,=0Adiff --git a/ui/gtk.c b/ui/gtk.c=0Aindex 579990=
b..41c82e5 100644=0A--- a/ui/gtk.c=0A+++ b/ui/gtk.c=0A@@ -875,20 +875,27 @=
@ static gboolean gd_motion_event(GtkWidget *widget, GdkEventMotion *motio=
n,=0A=C2=A0=C2=A0 =C2=A0 x =3D (motion->x - mx) / vc->gfx.scale_x;=0A=C2=A0=
=C2=A0 =C2=A0 y =3D (motion->y - my) / vc->gfx.scale_y;=0A=C2=A0=0A+=C2=A0=
 =C2=A0 bool scaled =3D display_opengl && !gtk_use_gl_area && s->free_scal=
e;=0A=C2=A0=C2=A0 =C2=A0 if (qemu_input_is_absolute()) {=0A+=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 int max_w =3D scaled ? ww : surface_width(vc->gfx.ds);=0A+=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 int max_h =3D scaled ? wh : surface_height(vc->gf=
x.ds);=0A=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (x < 0 || y < 0 ||=0A-=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 x >=3D surface_width(vc->gfx.ds) ||=0A=
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 y >=3D surface_height(vc->gfx.d=
s)) {=0A+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 x >=3D max_w ||=0A+=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 y >=3D max_h) {=0A=C2=A0=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TRUE;=0A=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 }=0A=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_input_queue_abs(vc->gfx.dcl.co=
n, INPUT_AXIS_X, x,=0A- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, surface_width(vc->gfx.ds)=
);=0A+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, max_w);=0A=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 qemu_input_queue_abs(vc->gfx.dcl.con, INPUT_AXIS_Y, y,=0A- =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 0, surface_height(vc->gfx.ds));=0A+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, max_=
h);=0A=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_input_event_sync();=0A=C2=A0=C2=
=A0 =C2=A0 } else if (s->last_set && s->ptr_owner =3D=3D vc) {=0A-=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 qemu_input_queue_rel(vc->gfx.dcl.con, INPUT_AXIS_X, x - =
s->last_x);=0A-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_input_queue_rel(vc->gfx.dc=
l.con, INPUT_AXIS_Y, y - s->last_y);=0A+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int di=
ff_x =3D scaled=0A+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ? (x - s->las=
t_x) * surface_width(vc->gfx.ds) / ww : (x - s->last_x);=0A+=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 int diff_y =3D scaled=0A+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ? (y - s->last_y) * surface_height(vc->gfx.ds) / wh : (y - s->last_=
y);=0A+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_input_queue_rel(vc->gfx.dcl.con, I=
NPUT_AXIS_X, diff_x);=0A+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_input_queue_rel(=
vc->gfx.dcl.con, INPUT_AXIS_Y, diff_y);=0A=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 qemu_input_event_sync();=0A=C2=A0=C2=A0 =C2=A0 }=0A=C2=A0=C2=A0 =C2=A0 s-=
>last_x =3D x;=0A--=C2=A0=0A2.7.4
