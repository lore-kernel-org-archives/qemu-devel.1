Received: from eggs.gnu.org ([2001:4830:134:3::10]:43504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkYOb-0005YZ-UC
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:20:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkYOZ-000736-JY
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:20:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dkYOZ-00071B-CE
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:20:43 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Aug 2017 18:19:48 +0200
Message-Id: <20170823162004.27337-12-marcandre.lureau@redhat.com>
In-Reply-To: <20170823162004.27337-1-marcandre.lureau@redhat.com>
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 11/27] vhost-user-scsi: simplify unix path
 cleanup
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

Always remove the unix path when leaving the program (instead of when
freeing scsi_dev). Note that unix_sock_new() also unlink() exisiting
path before creating the socket.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/vhost-user-scsi/vhost-user-scsi.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-us=
er-scsi/vhost-user-scsi.c
index bb10848cd2..624efc24ca 100644
--- a/contrib/vhost-user-scsi/vhost-user-scsi.c
+++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
@@ -636,24 +636,9 @@ fail:
=20
 static void vdev_scsi_free(vhost_scsi_dev_t *vdev_scsi)
 {
-    if (!vdev_scsi) {
-        return;
-    }
-
     if (vdev_scsi->server_sock >=3D 0) {
-        struct sockaddr_storage ss;
-        socklen_t sslen =3D sizeof(ss);
-
-        if (getsockname(vdev_scsi->server_sock, (struct sockaddr *)&ss,
-                        &sslen) =3D=3D 0) {
-            struct sockaddr_un *su =3D (struct sockaddr_un *)&ss;
-            (void)unlink(su->sun_path);
-        }
-
-        (void)close(vdev_scsi->server_sock);
-        vdev_scsi->server_sock =3D -1;
+        close(vdev_scsi->server_sock);
     }
-
     g_main_loop_unref(vdev_scsi->loop);
     g_tree_destroy(vdev_scsi->fdmap);
     g_free(vdev_scsi);
@@ -764,7 +749,10 @@ int main(int argc, char **argv)
     }
=20
 out:
-    vdev_scsi_free(vdev_scsi);
+    if (vdev_scsi) {
+        vdev_scsi_free(vdev_scsi);
+        unlink(unix_fn);
+    }
     g_free(unix_fn);
     g_free(iscsi_uri);
=20
--=20
2.14.1.146.gd35faa819
