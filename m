Received: from eggs.gnu.org ([209.51.188.92]:55537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glaJ1-0008EO-O3
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:12:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glaJ0-0000jr-U6
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:12:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33195)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1glaJ0-0000jT-Iy
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:12:02 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D06A75D608
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 14:12:01 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 21 Jan 2019 15:11:50 +0100
Message-Id: <20190121141152.948-5-kraxel@redhat.com>
In-Reply-To: <20190121141152.948-1-kraxel@redhat.com>
References: <20190121141152.948-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/5] vnc: detect and optimize pageflips
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

When size and format of the display surface stays the same we can just
tag the guest display as dirty and be done with it.

There is no need need to resize the vnc server display or to touch the
vnc client dirty bits.  On the next refresh cycle
vnc_refresh_server_surface() will check for actual display content
changes and update the client dirty bits as needed.

The desktop resize and framebuffer format notifications to the vnc
client will be skipped too.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-id: 20190116101049.8929-1-kraxel@redhat.com
---
 ui/vnc.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 9e4b2beb71..6002d09407 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -742,6 +742,17 @@ static void vnc_update_server_surface(VncDisplay *vd=
)
                        width, height);
 }
=20
+static bool vnc_check_pageflip(DisplaySurface *s1,
+                               DisplaySurface *s2)
+{
+    return (s1 !=3D NULL &&
+            s2 !=3D NULL &&
+            surface_width(s1) =3D=3D surface_width(s2) &&
+            surface_height(s1) =3D=3D surface_height(s2) &&
+            surface_format(s1) =3D=3D surface_format(s2));
+
+}
+
 static void vnc_dpy_switch(DisplayChangeListener *dcl,
                            DisplaySurface *surface)
 {
@@ -749,6 +760,7 @@ static void vnc_dpy_switch(DisplayChangeListener *dcl=
,
         "Display output is not active.";
     static DisplaySurface *placeholder;
     VncDisplay *vd =3D container_of(dcl, VncDisplay, dcl);
+    bool pageflip =3D vnc_check_pageflip(vd->ds, surface);
     VncState *vs;
=20
     if (surface =3D=3D NULL) {
@@ -761,14 +773,21 @@ static void vnc_dpy_switch(DisplayChangeListener *d=
cl,
     vnc_abort_display_jobs(vd);
     vd->ds =3D surface;
=20
-    /* server surface */
-    vnc_update_server_surface(vd);
-
     /* guest surface */
     qemu_pixman_image_unref(vd->guest.fb);
     vd->guest.fb =3D pixman_image_ref(surface->image);
     vd->guest.format =3D surface->format;
=20
+    if (pageflip) {
+        vnc_set_area_dirty(vd->guest.dirty, vd, 0, 0,
+                           surface_width(surface),
+                           surface_height(surface));
+        return;
+    }
+
+    /* server surface */
+    vnc_update_server_surface(vd);
+
     QTAILQ_FOREACH(vs, &vd->clients, next) {
         vnc_colordepth(vs);
         vnc_desktop_resize(vs);
--=20
2.9.3
