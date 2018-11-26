Received: from eggs.gnu.org ([2001:4830:134:3::10]:49930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRGG1-0008K1-Vs
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 07:44:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRGFz-0008R8-2R
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 07:44:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gRGFy-0008QM-TX
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 07:44:55 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 300754E8B7
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 12:44:54 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Nov 2018 16:42:47 +0400
Message-Id: <20181126124250.29985-9-marcandre.lureau@redhat.com>
In-Reply-To: <20181126124250.29985-1-marcandre.lureau@redhat.com>
References: <20181126124250.29985-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 08/11] libvhost-user-glib: export
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
Cc: kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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
2.20.0.rc1
