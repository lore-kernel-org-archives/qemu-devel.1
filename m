Received: from eggs.gnu.org ([2001:4830:134:3::10]:47554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duLn2-0006ZR-M0
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:54:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duLn1-0002oq-Pg
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:54:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1duLn1-0002oP-Jy
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:54:27 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 19 Sep 2017 18:52:21 +0200
Message-Id: <20170919165226.23022-23-marcandre.lureau@redhat.com>
In-Reply-To: <20170919165226.23022-1-marcandre.lureau@redhat.com>
References: <20170919165226.23022-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 22/27] vhost-user-scsi: drop extra callback
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
Cc: pbonzini@redhat.com, changpeng.liu@intel.com, f4bug@amsat.org, felipe@nutanix.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Use the one from the source with casting, like any other glib source.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 contrib/vhost-user-scsi/vhost-user-scsi.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-us=
er-scsi/vhost-user-scsi.c
index cfac1ce1fe..0e6784187c 100644
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
+    ((vu_watch_cb)cb)(&vdev_scsi->vu_dev, vus_src->gfd.revents, data);
+
     return G_SOURCE_CONTINUE;
 }
=20
@@ -147,12 +141,12 @@ static void vus_gsrc_new(VusDev *vdev_scsi, int fd,=
 GIOCondition cond,
     assert(!(vu_cb && gsrc_cb));
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
     g_source_set_callback(vus_gsrc, gsrc_cb, data, NULL);
--=20
2.14.1.146.gd35faa819
