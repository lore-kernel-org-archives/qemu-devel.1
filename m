Received: from eggs.gnu.org ([2001:4830:134:3::10]:43922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkYPF-00068M-76
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:21:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkYPD-0007gr-1K
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:21:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dkYPC-0007gc-RV
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:21:22 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Aug 2017 18:19:58 +0200
Message-Id: <20170823162004.27337-22-marcandre.lureau@redhat.com>
In-Reply-To: <20170823162004.27337-1-marcandre.lureau@redhat.com>
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 21/27] vhost-user-scsi: drop extra callback
 pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: changpeng.liu@intel.com, felipe@nutanix.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Use the one from the source with casting, like any other glib source.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/vhost-user-scsi/vhost-user-scsi.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-us=
er-scsi/vhost-user-scsi.c
index 795799ec14..102d910e8f 100644
--- a/contrib/vhost-user-scsi/vhost-user-scsi.c
+++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
@@ -81,7 +81,6 @@ typedef struct vus_gsrc {
     GSource parent;
     VusDev *vdev_scsi;
     GPollFD gfd;
-    vu_watch_cb vu_cb;
 } vus_gsrc_t;
=20
 static gint vus_fdmap_compare(gconstpointer a, gconstpointer b)
@@ -112,18 +111,13 @@ static gboolean vus_gsrc_dispatch(GSource *src, GSo=
urceFunc cb, gpointer data)
     vus_gsrc_t *vus_src =3D (vus_gsrc_t *)src;
=20
     assert(vus_src);
-    assert(!(vus_src->vu_cb && cb));
=20
     vdev_scsi =3D vus_src->vdev_scsi;
=20
     assert(vdev_scsi);
=20
-    if (cb) {
-        return cb(data);
-    }
-    if (vus_src->vu_cb) {
-        vus_src->vu_cb(&vdev_scsi->vu_dev, vus_src->gfd.revents, data);
-    }
+    ((vu_watch_cb)cb) (&vdev_scsi->vu_dev, vus_src->gfd.revents, data);
+
     return G_SOURCE_CONTINUE;
 }
=20
@@ -146,12 +140,12 @@ static void vus_gsrc_new(VusDev *vdev_scsi, int fd,=
 GIOCondition cond,
     assert(vu_cb);
=20
     vus_gsrc =3D g_source_new(&vus_gsrc_funcs, sizeof(vus_gsrc_t));
+    g_source_set_callback(vus_gsrc, (GSourceFunc) vu_cb, data, NULL);
     vus_src =3D (vus_gsrc_t *)vus_gsrc;
=20
     vus_src->vdev_scsi =3D vdev_scsi;
     vus_src->gfd.fd =3D fd;
     vus_src->gfd.events =3D cond;
-    vus_src->vu_cb =3D vu_cb;
=20
     g_source_add_poll(vus_gsrc, &vus_src->gfd);
     id =3D g_source_attach(vus_gsrc, NULL);
--=20
2.14.1.146.gd35faa819
