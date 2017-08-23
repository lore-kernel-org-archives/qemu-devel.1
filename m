Received: from eggs.gnu.org ([2001:4830:134:3::10]:44121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkYPa-0006SN-8d
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkYPZ-0007r3-AF
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:21:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dkYPZ-0007ql-0m
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:21:45 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Aug 2017 18:20:04 +0200
Message-Id: <20170823162004.27337-28-marcandre.lureau@redhat.com>
In-Reply-To: <20170823162004.27337-1-marcandre.lureau@redhat.com>
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 27/27] vhost-user-scsi: remove server_sock from
 VusDev
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

It is unneeded in the VusDev device structure, and also simplify a bit
the code.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/vhost-user-scsi/vhost-user-scsi.c | 52 ++++++++++++++-----------=
------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-us=
er-scsi/vhost-user-scsi.c
index cfd62b46ce..3166331856 100644
--- a/contrib/vhost-user-scsi/vhost-user-scsi.c
+++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
@@ -28,7 +28,6 @@ typedef struct VusIscsiLun {
 typedef struct VusDev {
     VugDev parent;
=20
-    int server_sock;
     VusIscsiLun lun;
 } VusDev;
=20
@@ -371,48 +370,30 @@ fail:
=20
 static void vdev_scsi_free(VusDev *vdev_scsi)
 {
-    if (vdev_scsi->server_sock >=3D 0) {
-        close(vdev_scsi->server_sock);
-    }
     g_free(vdev_scsi);
 }
=20
-static VusDev *vdev_scsi_new(int server_sock)
+static VusDev *vdev_scsi_new(void)
 {
-    VusDev *vdev_scsi;
-
-    assert(server_sock >=3D 0);
-
-    vdev_scsi =3D g_new0(VusDev, 1);
-    vdev_scsi->server_sock =3D server_sock;
-
-    return vdev_scsi;
+    return g_new0(VusDev, 1);
 }
=20
-static int vdev_scsi_run(VusDev *vdev_scsi)
+static int vdev_scsi_run(VusDev *vdev_scsi, int sock)
 {
     GMainLoop *loop;
     GIOChannel *chan;
-    int cli_sock;
     int ret =3D 0;
=20
     assert(vdev_scsi);
-    assert(vdev_scsi->server_sock >=3D 0);
-
-    cli_sock =3D accept(vdev_scsi->server_sock, NULL, NULL);
-    if (cli_sock < 0) {
-        perror("accept");
-        return -1;
-    }
=20
     loop =3D g_main_loop_new(NULL, FALSE);
     vug_init(&vdev_scsi->parent,
-             cli_sock,
+             sock,
              loop,
              vus_panic_cb,
              &vus_iface);
=20
-    chan =3D g_io_channel_unix_new(cli_sock);
+    chan =3D g_io_channel_unix_new(sock);
     g_io_add_watch(chan, G_IO_IN, vus_vhost_cb, vdev_scsi);
     g_main_loop_run(loop);
     g_io_channel_unref(chan);
@@ -428,7 +409,7 @@ int main(int argc, char **argv)
     VusDev *vdev_scsi =3D NULL;
     char *unix_fn =3D NULL;
     char *iscsi_uri =3D NULL;
-    int sock, opt, err =3D EXIT_SUCCESS;
+    int lsock =3D -1, csock =3D -1, opt, err =3D EXIT_SUCCESS;
=20
     while ((opt =3D getopt(argc, argv, "u:i:")) !=3D -1) {
         switch (opt) {
@@ -448,17 +429,24 @@ int main(int argc, char **argv)
         goto help;
     }
=20
-    sock =3D unix_sock_new(unix_fn);
-    if (sock < 0) {
+    lsock =3D unix_sock_new(unix_fn);
+    if (lsock < 0) {
+        goto err;
+    }
+
+    csock =3D accept(lsock, NULL, NULL);
+    if (csock < 0) {
+        perror("accept");
         goto err;
     }
-    vdev_scsi =3D vdev_scsi_new(sock);
+
+    vdev_scsi =3D vdev_scsi_new();
=20
     if (vus_iscsi_add_lun(&vdev_scsi->lun, iscsi_uri) !=3D 0) {
         goto err;
     }
=20
-    if (vdev_scsi_run(vdev_scsi) !=3D 0) {
+    if (vdev_scsi_run(vdev_scsi, csock) !=3D 0) {
         goto err;
     }
=20
@@ -467,6 +455,12 @@ out:
         vdev_scsi_free(vdev_scsi);
         unlink(unix_fn);
     }
+    if (csock >=3D 0) {
+        close(csock);
+    }
+    if (lsock >=3D 0) {
+        close(lsock);
+    }
     g_free(unix_fn);
     g_free(iscsi_uri);
=20
--=20
2.14.1.146.gd35faa819
