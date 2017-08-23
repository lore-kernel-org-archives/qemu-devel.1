Received: from eggs.gnu.org ([2001:4830:134:3::10]:43359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkYOK-0005EK-Dq
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:20:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkYOJ-0006iZ-GL
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:20:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dkYOJ-0006hW-B1
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:20:27 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Aug 2017 18:19:42 +0200
Message-Id: <20170823162004.27337-6-marcandre.lureau@redhat.com>
In-Reply-To: <20170823162004.27337-1-marcandre.lureau@redhat.com>
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 05/27] vhost-user-scsi: connect unix socket
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
Cc: changpeng.liu@intel.com, felipe@nutanix.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This simplify a little bit memory management in the following patches.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/vhost-user-scsi/vhost-user-scsi.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-us=
er-scsi/vhost-user-scsi.c
index 1fb57da2da..cddaaf8995 100644
--- a/contrib/vhost-user-scsi/vhost-user-scsi.c
+++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
@@ -715,11 +715,11 @@ static void vdev_scsi_deinit(vhost_scsi_dev_t *vdev=
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
+    assert(server_sock >=3D 0);
=20
     vdev_scsi =3D calloc(1, sizeof(vhost_scsi_dev_t));
     if (!vdev_scsi) {
@@ -727,11 +727,7 @@ static vhost_scsi_dev_t *vdev_scsi_new(char *unix_fn=
)
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
@@ -815,7 +811,7 @@ int main(int argc, char **argv)
     vhost_scsi_dev_t *vdev_scsi =3D NULL;
     char *unix_fn =3D NULL;
     char *iscsi_uri =3D NULL;
-    int opt, err =3D EXIT_SUCCESS;
+    int sock, opt, err =3D EXIT_SUCCESS;
=20
     while ((opt =3D getopt(argc, argv, "u:i:")) !=3D -1) {
         switch (opt) {
@@ -835,7 +831,11 @@ int main(int argc, char **argv)
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
