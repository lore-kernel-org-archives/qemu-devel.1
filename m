Received: from eggs.gnu.org ([2001:4830:134:3::10]:46135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duLlg-0005Nk-J4
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:53:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duLlf-0001c2-Mm
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:53:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1duLlf-0001bS-GM
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:53:03 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 19 Sep 2017 18:52:06 +0200
Message-Id: <20170919165226.23022-8-marcandre.lureau@redhat.com>
In-Reply-To: <20170919165226.23022-1-marcandre.lureau@redhat.com>
References: <20170919165226.23022-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 07/27] vhost-user-scsi: connect unix socket
 before allocating
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

This simplify a little bit memory management in the following patches.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 contrib/vhost-user-scsi/vhost-user-scsi.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-us=
er-scsi/vhost-user-scsi.c
index 1fb57da2da..e01bf31296 100644
--- a/contrib/vhost-user-scsi/vhost-user-scsi.c
+++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
@@ -715,23 +715,17 @@ static void vdev_scsi_deinit(vhost_scsi_dev_t *vdev=
_scsi)
     }
 }
=20
-static vhost_scsi_dev_t *vdev_scsi_new(char *unix_fn)
+static vhost_scsi_dev_t *vdev_scsi_new(int server_sock)
 {
     vhost_scsi_dev_t *vdev_scsi =3D NULL;
=20
-    assert(unix_fn);
-
     vdev_scsi =3D calloc(1, sizeof(vhost_scsi_dev_t));
     if (!vdev_scsi) {
         PERR("calloc: %s", strerror(errno));
         return NULL;
     }
=20
-    vdev_scsi->server_sock =3D unix_sock_new(unix_fn);
-    if (vdev_scsi->server_sock < 0) {
-        goto err;
-    }
-
+    vdev_scsi->server_sock =3D server_sock;
     vdev_scsi->loop =3D g_main_loop_new(NULL, FALSE);
     if (!vdev_scsi->loop) {
         PERR("Error creating glib event loop");
@@ -815,7 +809,7 @@ int main(int argc, char **argv)
     vhost_scsi_dev_t *vdev_scsi =3D NULL;
     char *unix_fn =3D NULL;
     char *iscsi_uri =3D NULL;
-    int opt, err =3D EXIT_SUCCESS;
+    int sock, opt, err =3D EXIT_SUCCESS;
=20
     while ((opt =3D getopt(argc, argv, "u:i:")) !=3D -1) {
         switch (opt) {
@@ -835,7 +829,11 @@ int main(int argc, char **argv)
         goto help;
     }
=20
-    vdev_scsi =3D vdev_scsi_new(unix_fn);
+    sock =3D unix_sock_new(unix_fn);
+    if (sock < 0) {
+        goto err;
+    }
+    vdev_scsi =3D vdev_scsi_new(sock);
     if (!vdev_scsi) {
         goto err;
     }
--=20
2.14.1.146.gd35faa819
