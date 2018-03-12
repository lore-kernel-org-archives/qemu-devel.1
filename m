Received: from eggs.gnu.org ([2001:4830:134:3::10]:49994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evJXC-0007Ck-9k
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:14:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evJX6-0004c7-4e
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:14:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47206 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1evJX5-0004ah-VU
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:14:16 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 12 Mar 2018 10:14:01 +0100
Message-Id: <20180312091405.19610-11-kraxel@redhat.com>
In-Reply-To: <20180312091405.19610-1-kraxel@redhat.com>
References: <20180312091405.19610-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/14] vnc: deal with surface NULL pointers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Secondary displays in multihead setups are allowed to have a NULL
DisplaySurface.  Typically user interfaces handle this by hiding the
window which shows the display in question.

This isn't an option for vnc though because it simply hasn't a concept
of windows or outputs.  So handle the situation by showing a placeholder
DisplaySurface instead.  Also check in console_select whenever a surface
is preset in the first place before requesting an update.

This fixes a segfault which can be triggered by switching to an unused
display (via vtrl-alt-<nr>) in a multihead setup, for example using
-device virtio-vga,max_outputs=3D2.

Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-id: 20180308161803.6152-1-kraxel@redhat.com
---
 include/ui/console.h |  2 ++
 ui/console.c         | 10 ++++++----
 ui/vnc.c             | 10 ++++++++++
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index aae9e44cb3..5fca9afcbc 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -260,6 +260,8 @@ DisplaySurface *qemu_create_displaysurface_guestmem(i=
nt width, int height,
                                                     pixman_format_code_t=
 format,
                                                     int linesize,
                                                     uint64_t addr);
+DisplaySurface *qemu_create_message_surface(int w, int h,
+                                            const char *msg);
 PixelFormat qemu_default_pixelformat(int bpp);
=20
 DisplaySurface *qemu_create_displaysurface(int width, int height);
diff --git a/ui/console.c b/ui/console.c
index 6ab4ff3baf..348610dd43 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1039,8 +1039,10 @@ void console_select(unsigned int index)
                     dcl->ops->dpy_gfx_switch(dcl, s->surface);
                 }
             }
-            dpy_gfx_update(s, 0, 0, surface_width(s->surface),
-                           surface_height(s->surface));
+            if (s->surface) {
+                dpy_gfx_update(s, 0, 0, surface_width(s->surface),
+                               surface_height(s->surface));
+            }
         }
         if (ds->have_text) {
             dpy_text_resize(s, s->width, s->height);
@@ -1370,8 +1372,8 @@ DisplaySurface *qemu_create_displaysurface_guestmem=
(int width, int height,
     return surface;
 }
=20
-static DisplaySurface *qemu_create_message_surface(int w, int h,
-                                                   const char *msg)
+DisplaySurface *qemu_create_message_surface(int w, int h,
+                                            const char *msg)
 {
     DisplaySurface *surface =3D qemu_create_displaysurface(w, h);
     pixman_color_t bg =3D color_table_rgb[0][QEMU_COLOR_BLACK];
diff --git a/ui/vnc.c b/ui/vnc.c
index 13c28cabb0..e164eb798c 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -746,9 +746,19 @@ static void vnc_update_server_surface(VncDisplay *vd=
)
 static void vnc_dpy_switch(DisplayChangeListener *dcl,
                            DisplaySurface *surface)
 {
+    static const char placeholder_msg[] =3D
+        "Display output is not active.";
+    static DisplaySurface *placeholder;
     VncDisplay *vd =3D container_of(dcl, VncDisplay, dcl);
     VncState *vs;
=20
+    if (surface =3D=3D NULL) {
+        if (placeholder =3D=3D NULL) {
+            placeholder =3D qemu_create_message_surface(640, 480, placeh=
older_msg);
+        }
+        surface =3D placeholder;
+    }
+
     vnc_abort_display_jobs(vd);
     vd->ds =3D surface;
=20
--=20
2.9.3
