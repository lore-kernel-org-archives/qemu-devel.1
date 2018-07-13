Received: from eggs.gnu.org ([2001:4830:134:3::10]:41177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fdxpW-00042w-CM
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:09:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fdxpT-0002u1-FO
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:09:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40308 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fdxpT-0002rN-9t
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:09:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0937E79D36
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 13:09:47 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Jul 2018 15:09:00 +0200
Message-Id: <20180713130916.4153-14-marcandre.lureau@redhat.com>
In-Reply-To: <20180713130916.4153-1-marcandre.lureau@redhat.com>
References: <20180713130916.4153-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 13/29] libvhost-user: export vug_source_new()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: airlied@redhat.com, kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Simplify the creation of FD sources for other users.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/libvhost-user/libvhost-user-glib.h |  3 +++
 contrib/libvhost-user/libvhost-user-glib.c | 15 +++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

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
index 545f089587..0e2c467f28 100644
--- a/contrib/libvhost-user/libvhost-user-glib.c
+++ b/contrib/libvhost-user/libvhost-user-glib.c
@@ -69,8 +69,8 @@ static GSourceFuncs vug_src_funcs =3D {
 };
=20
 static GSource *
-vug_source_new(VuDev *dev, int fd, GIOCondition cond,
-               vu_watch_cb vu_cb, gpointer data)
+_vug_source_new(VuDev *dev, int fd, GIOCondition cond,
+                vu_watch_cb vu_cb, gpointer data)
 {
     GSource *gsrc;
     VugSrc *src;
@@ -95,6 +95,13 @@ vug_source_new(VuDev *dev, int fd, GIOCondition cond,
     return gsrc;
 }
=20
+GSource *
+vug_source_new(VugDev *dev, int fd, GIOCondition cond,
+               vu_watch_cb vu_cb, gpointer data)
+{
+    return _vug_source_new(&dev->parent, fd, cond, vu_cb, data);
+}
+
 static void
 set_watch(VuDev *vu_dev, int fd, int vu_evt, vu_watch_cb cb, void *pvt)
 {
@@ -106,7 +113,7 @@ set_watch(VuDev *vu_dev, int fd, int vu_evt, vu_watch=
_cb cb, void *pvt)
     g_assert(cb);
=20
     dev =3D container_of(vu_dev, VugDev, parent);
-    src =3D vug_source_new(vu_dev, fd, vu_evt, cb, pvt);
+    src =3D _vug_source_new(vu_dev, fd, vu_evt, cb, pvt);
     g_hash_table_replace(dev->fdmap, GINT_TO_POINTER(fd), src);
 }
=20
@@ -141,7 +148,7 @@ vug_init(VugDev *dev, int socket,
     dev->fdmap =3D g_hash_table_new_full(NULL, NULL, NULL,
                                        (GDestroyNotify) g_source_destroy=
);
=20
-    dev->src =3D vug_source_new(&dev->parent, socket, G_IO_IN, vug_watch=
, NULL);
+    dev->src =3D _vug_source_new(&dev->parent, socket, G_IO_IN, vug_watc=
h, NULL);
 }
=20
 void
--=20
2.18.0.129.ge3331758f1
