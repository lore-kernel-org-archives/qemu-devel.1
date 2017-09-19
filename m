Received: from eggs.gnu.org ([2001:4830:134:3::10]:47863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duLnP-0006rk-7x
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:54:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duLnO-00031s-9T
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:54:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1duLnO-00031M-0a
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:54:50 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 19 Sep 2017 18:52:26 +0200
Message-Id: <20170919165226.23022-28-marcandre.lureau@redhat.com>
In-Reply-To: <20170919165226.23022-1-marcandre.lureau@redhat.com>
References: <20170919165226.23022-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 27/27] vhost-user-scsi: remove server_sock
 from VusDev
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

It is unneeded in the VusDev device structure, and also simplify a bit
the code.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 contrib/vhost-user-scsi/vhost-user-scsi.c | 77 ++++++++++---------------=
------
 1 file changed, 24 insertions(+), 53 deletions(-)

diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-us=
er-scsi/vhost-user-scsi.c
index 615e2a76bb..54c1191db0 100644
--- a/contrib/vhost-user-scsi/vhost-user-scsi.c
+++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
@@ -28,7 +28,6 @@ typedef struct VusIscsiLun {
 typedef struct VusDev {
     VugDev parent;
=20
-    int server_sock;
     VusIscsiLun lun;
     GMainLoop *loop;
 } VusDev;
@@ -357,57 +356,12 @@ fail:
=20
 /** vhost-user-scsi **/
=20
-static void vdev_scsi_free(VusDev *vdev_scsi)
-{
-    if (vdev_scsi->server_sock >=3D 0) {
-        close(vdev_scsi->server_sock);
-    }
-    g_main_loop_unref(vdev_scsi->loop);
-    g_free(vdev_scsi);
-}
-
-static VusDev *vdev_scsi_new(int server_sock)
-{
-    VusDev *vdev_scsi;
-
-    vdev_scsi =3D g_new0(VusDev, 1);
-    vdev_scsi->server_sock =3D server_sock;
-    vdev_scsi->loop =3D g_main_loop_new(NULL, FALSE);
-
-    return vdev_scsi;
-}
-
-static int vdev_scsi_run(VusDev *vdev_scsi)
-{
-    int cli_sock;
-
-    assert(vdev_scsi);
-    assert(vdev_scsi->server_sock >=3D 0);
-
-    cli_sock =3D accept(vdev_scsi->server_sock, NULL, NULL);
-    if (cli_sock < 0) {
-        perror("accept");
-        return -1;
-    }
-
-    vug_init(&vdev_scsi->parent,
-             cli_sock,
-             vus_panic_cb,
-             &vus_iface);
-
-    g_main_loop_run(vdev_scsi->loop);
-
-    vug_deinit(&vdev_scsi->parent);
-
-    return 0;
-}
-
 int main(int argc, char **argv)
 {
     VusDev *vdev_scsi =3D NULL;
     char *unix_fn =3D NULL;
     char *iscsi_uri =3D NULL;
-    int sock, opt, err =3D EXIT_SUCCESS;
+    int lsock =3D -1, csock =3D -1, opt, err =3D EXIT_SUCCESS;
=20
     while ((opt =3D getopt(argc, argv, "u:i:")) !=3D -1) {
         switch (opt) {
@@ -427,25 +381,42 @@ int main(int argc, char **argv)
         goto help;
     }
=20
-    sock =3D unix_sock_new(unix_fn);
-    if (sock < 0) {
+    lsock =3D unix_sock_new(unix_fn);
+    if (lsock < 0) {
         goto err;
     }
-    vdev_scsi =3D vdev_scsi_new(sock);
=20
-    if (vus_iscsi_add_lun(&vdev_scsi->lun, iscsi_uri) !=3D 0) {
+    csock =3D accept(lsock, NULL, NULL);
+    if (csock < 0) {
+        perror("accept");
         goto err;
     }
=20
-    if (vdev_scsi_run(vdev_scsi) !=3D 0) {
+    vdev_scsi =3D g_new0(VusDev, 1);
+    vdev_scsi->loop =3D g_main_loop_new(NULL, FALSE);
+
+    if (vus_iscsi_add_lun(&vdev_scsi->lun, iscsi_uri) !=3D 0) {
         goto err;
     }
=20
+    vug_init(&vdev_scsi->parent, csock, vus_panic_cb, &vus_iface);
+
+    g_main_loop_run(vdev_scsi->loop);
+
+    vug_deinit(&vdev_scsi->parent);
+
 out:
     if (vdev_scsi) {
-        vdev_scsi_free(vdev_scsi);
+        g_main_loop_unref(vdev_scsi->loop);
+        g_free(vdev_scsi);
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
