Received: from eggs.gnu.org ([2001:4830:134:3::10]:56844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fuDHA-0005XH-4s
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 04:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fuDH6-0004lI-Er
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 04:53:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56028 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fuDH6-0004kq-8Y
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 04:53:28 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D3C3240200A0
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 08:53:27 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 27 Aug 2018 10:53:19 +0200
Message-Id: <20180827085320.9732-12-kraxel@redhat.com>
In-Reply-To: <20180827085320.9732-1-kraxel@redhat.com>
References: <20180827085320.9732-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/12] dmabuf: add y0_top, pass it to spice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Some scanouts during boot are top-down without it.

y0_top is set from VHOST_USER_GPU_DMABUF_SCANOUT code path in the last
patch of this series.

In current QEMU code base, only vfio/display uses dmabuf API. But the
VFIO query interface doesn't provide or need that detail so far.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180713130916.4153-5-marcandre.lureau@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/console.h | 1 +
 ui/spice-display.c   | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 981b519dde..fb969caf70 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -186,6 +186,7 @@ struct QemuDmaBuf {
     uint32_t  stride;
     uint32_t  fourcc;
     uint32_t  texture;
+    bool      y0_top;
 };
=20
 typedef struct DisplayChangeListenerOps {
diff --git a/ui/spice-display.c b/ui/spice-display.c
index 7b230987dc..2f8adb6b9f 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -1056,7 +1056,8 @@ static void qemu_spice_gl_update(DisplayChangeListe=
ner *dcl,
             /* note: spice server will close the fd, so hand over a dup =
*/
             spice_qxl_gl_scanout(&ssd->qxl, dup(dmabuf->fd),
                                  dmabuf->width, dmabuf->height,
-                                 dmabuf->stride, dmabuf->fourcc, false);
+                                 dmabuf->stride, dmabuf->fourcc,
+                                 dmabuf->y0_top);
         }
         qemu_spice_gl_monitor_config(ssd, 0, 0, dmabuf->width, dmabuf->h=
eight);
         ssd->guest_dmabuf_refresh =3D false;
--=20
2.9.3
