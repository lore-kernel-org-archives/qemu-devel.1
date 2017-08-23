Received: from eggs.gnu.org ([2001:4830:134:3::10]:43539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkYOf-0005aa-6J
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:20:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkYOd-00077Y-QM
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:20:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dkYOd-00076e-H4
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:20:47 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Aug 2017 18:19:50 +0200
Message-Id: <20170823162004.27337-14-marcandre.lureau@redhat.com>
In-Reply-To: <20170823162004.27337-1-marcandre.lureau@redhat.com>
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 13/27] vhost-user-scsi: use glib watch directly
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

The following patches is going to remove the custom VUS source.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/vhost-user-scsi/vhost-user-scsi.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-us=
er-scsi/vhost-user-scsi.c
index 596c1effa1..b40009e234 100644
--- a/contrib/vhost-user-scsi/vhost-user-scsi.c
+++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
@@ -136,7 +136,7 @@ static GSourceFuncs vus_gsrc_funcs =3D {
 };
=20
 static void vus_gsrc_new(vhost_scsi_dev_t *vdev_scsi, int fd, GIOConditi=
on cond,
-                         vu_watch_cb vu_cb, GSourceFunc gsrc_cb, gpointe=
r data)
+                         vu_watch_cb vu_cb, gpointer data)
 {
     GSource *vus_gsrc;
     vus_gsrc_t *vus_src;
@@ -144,8 +144,7 @@ static void vus_gsrc_new(vhost_scsi_dev_t *vdev_scsi,=
 int fd, GIOCondition cond,
=20
     assert(vdev_scsi);
     assert(fd >=3D 0);
-    assert(vu_cb || gsrc_cb);
-    assert(!(vu_cb && gsrc_cb));
+    assert(vu_cb);
=20
     vus_gsrc =3D g_source_new(&vus_gsrc_funcs, sizeof(vus_gsrc_t));
     vus_src =3D (vus_gsrc_t *)vus_gsrc;
@@ -156,7 +155,6 @@ static void vus_gsrc_new(vhost_scsi_dev_t *vdev_scsi,=
 int fd, GIOCondition cond,
     vus_src->vu_cb =3D vu_cb;
=20
     g_source_add_poll(vus_gsrc, &vus_src->gfd);
-    g_source_set_callback(vus_gsrc, gsrc_cb, data, NULL);
     id =3D g_source_attach(vus_gsrc, NULL);
     assert(id);
     g_source_unref(vus_gsrc);
@@ -450,7 +448,7 @@ static void vus_add_watch_cb(VuDev *vu_dev, int fd, i=
nt vu_evt, vu_watch_cb cb,
         (void)g_tree_remove(vdev_scsi->fdmap, (gpointer)(uintptr_t)fd);
     }
=20
-    vus_gsrc_new(vdev_scsi, fd, vu_evt, cb, NULL, pvt);
+    vus_gsrc_new(vdev_scsi, fd, vu_evt, cb, pvt);
 }
=20
 static void vus_del_watch_cb(VuDev *vu_dev, int fd)
@@ -578,7 +576,8 @@ static const VuDevIface vus_iface =3D {
     .queue_set_started =3D vus_queue_set_started,
 };
=20
-static gboolean vus_vhost_cb(gpointer data)
+static gboolean vus_vhost_cb(GIOChannel *source, GIOCondition condition,
+                             gpointer data)
 {
     VuDev *vu_dev =3D (VuDev *)data;
=20
@@ -679,6 +678,7 @@ static int vdev_scsi_add_iscsi_lun(vhost_scsi_dev_t *=
vdev_scsi,
=20
 static int vdev_scsi_run(vhost_scsi_dev_t *vdev_scsi)
 {
+    GIOChannel *chan;
     int cli_sock;
     int ret =3D 0;
=20
@@ -699,10 +699,10 @@ static int vdev_scsi_run(vhost_scsi_dev_t *vdev_scs=
i)
             vus_del_watch_cb,
             &vus_iface);
=20
-    vus_gsrc_new(vdev_scsi, cli_sock, G_IO_IN, NULL, vus_vhost_cb,
-                 &vdev_scsi->vu_dev);
-
+    chan =3D g_io_channel_unix_new(cli_sock);
+    g_io_add_watch(chan, G_IO_IN, vus_vhost_cb, &vdev_scsi->vu_dev);
     g_main_loop_run(vdev_scsi->loop);
+    g_io_channel_unref(chan);
=20
     vu_deinit(&vdev_scsi->vu_dev);
=20
--=20
2.14.1.146.gd35faa819
