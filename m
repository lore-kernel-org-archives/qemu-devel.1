Received: from eggs.gnu.org ([209.51.188.92]:36467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gs4I5-0002fl-34
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:25:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gs4I3-0000pE-5e
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:25:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gs4I2-0000o1-Uz
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:25:51 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3213987623
	for <qemu-devel@nongnu.org>; Fri,  8 Feb 2019 11:25:49 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  8 Feb 2019 12:23:53 +0100
Message-Id: <20190208112357.31615-10-marcandre.lureau@redhat.com>
In-Reply-To: <20190208112357.31615-1-marcandre.lureau@redhat.com>
References: <20190208112357.31615-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 09/13] libvhost-user-glib: export
 vug_source_new()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Simplify the creation of FD sources for other users. This is just
convenience to avoid duplicating similar code elsewhere.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/libvhost-user/libvhost-user-glib.h |  3 +++
 contrib/libvhost-user/libvhost-user-glib.c | 11 ++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user-glib.h b/contrib/libvhos=
t-user/libvhost-user-glib.h
index 6b2110b94c..d3200f3afc 100644
--- a/contrib/libvhost-user/libvhost-user-glib.h
+++ b/contrib/libvhost-user/libvhost-user-glib.h
@@ -29,4 +29,7 @@ void vug_init(VugDev *dev, int socket,
               vu_panic_cb panic, const VuDevIface *iface);
 void vug_deinit(VugDev *dev);
=20
+GSource *vug_source_new(VugDev *dev, int fd, GIOCondition cond,
+                        vu_watch_cb vu_cb, gpointer data);
+
 #endif /* LIBVHOST_USER_GLIB_H */
diff --git a/contrib/libvhost-user/libvhost-user-glib.c b/contrib/libvhos=
t-user/libvhost-user-glib.c
index 545f089587..42660a1b36 100644
--- a/contrib/libvhost-user/libvhost-user-glib.c
+++ b/contrib/libvhost-user/libvhost-user-glib.c
@@ -68,15 +68,16 @@ static GSourceFuncs vug_src_funcs =3D {
     NULL
 };
=20
-static GSource *
-vug_source_new(VuDev *dev, int fd, GIOCondition cond,
+GSource *
+vug_source_new(VugDev *gdev, int fd, GIOCondition cond,
                vu_watch_cb vu_cb, gpointer data)
 {
+    VuDev *dev =3D &gdev->parent;
     GSource *gsrc;
     VugSrc *src;
     guint id;
=20
-    g_assert(dev);
+    g_assert(gdev);
     g_assert(fd >=3D 0);
     g_assert(vu_cb);
=20
@@ -106,7 +107,7 @@ set_watch(VuDev *vu_dev, int fd, int vu_evt, vu_watch=
_cb cb, void *pvt)
     g_assert(cb);
=20
     dev =3D container_of(vu_dev, VugDev, parent);
-    src =3D vug_source_new(vu_dev, fd, vu_evt, cb, pvt);
+    src =3D vug_source_new(dev, fd, vu_evt, cb, pvt);
     g_hash_table_replace(dev->fdmap, GINT_TO_POINTER(fd), src);
 }
=20
@@ -141,7 +142,7 @@ vug_init(VugDev *dev, int socket,
     dev->fdmap =3D g_hash_table_new_full(NULL, NULL, NULL,
                                        (GDestroyNotify) g_source_destroy=
);
=20
-    dev->src =3D vug_source_new(&dev->parent, socket, G_IO_IN, vug_watch=
, NULL);
+    dev->src =3D vug_source_new(dev, socket, G_IO_IN, vug_watch, NULL);
 }
=20
 void
--=20
2.20.1.519.g8feddda32c
