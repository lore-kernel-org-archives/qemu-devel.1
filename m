Received: from eggs.gnu.org ([2001:4830:134:3::10]:49985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evJXB-0007Ca-VP
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:14:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evJX6-0004do-NG
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:14:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32874 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1evJX6-0004cd-JA
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:14:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3980A4000B6E
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 09:14:16 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 12 Mar 2018 10:14:03 +0100
Message-Id: <20180312091405.19610-13-kraxel@redhat.com>
In-Reply-To: <20180312091405.19610-1-kraxel@redhat.com>
References: <20180312091405.19610-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/14] spice: add scanout_dmabuf support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Add support for scanout dmabufs.  Just
pass them through to spice-server.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20180308090618.30147-3-kraxel@redhat.com
---
 ui/spice-display.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/ui/spice-display.c b/ui/spice-display.c
index 79ea4df02c..4c33c92ae5 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -936,6 +936,20 @@ static void qemu_spice_gl_scanout_texture(DisplayCha=
ngeListener *dcl,
     ssd->have_scanout =3D true;
 }
=20
+static void qemu_spice_gl_scanout_dmabuf(DisplayChangeListener *dcl,
+                                         QemuDmaBuf *dmabuf)
+{
+    SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDisplay, dc=
l);
+
+    /* note: spice server will close the fd, so hand over a dup */
+    spice_qxl_gl_scanout(&ssd->qxl, dup(dmabuf->fd),
+                         dmabuf->width, dmabuf->height,
+                         dmabuf->stride, dmabuf->fourcc, false);
+    qemu_spice_gl_monitor_config(ssd, 0, 0, dmabuf->width, dmabuf->heigh=
t);
+    ssd->have_surface =3D false;
+    ssd->have_scanout =3D true;
+}
+
 static void qemu_spice_gl_update(DisplayChangeListener *dcl,
                                  uint32_t x, uint32_t y, uint32_t w, uin=
t32_t h)
 {
@@ -969,6 +983,7 @@ static const DisplayChangeListenerOps display_listene=
r_gl_ops =3D {
=20
     .dpy_gl_scanout_disable  =3D qemu_spice_gl_scanout_disable,
     .dpy_gl_scanout_texture  =3D qemu_spice_gl_scanout_texture,
+    .dpy_gl_scanout_dmabuf   =3D qemu_spice_gl_scanout_dmabuf,
     .dpy_gl_update           =3D qemu_spice_gl_update,
 };
=20
--=20
2.9.3
