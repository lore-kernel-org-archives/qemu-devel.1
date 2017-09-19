Received: from eggs.gnu.org ([2001:4830:134:3::10]:46837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duLmH-0005tJ-7F
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:53:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duLmG-0002CD-DU
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:53:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1duLmG-0002BW-8e
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:53:40 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 19 Sep 2017 18:52:12 +0200
Message-Id: <20170919165226.23022-14-marcandre.lureau@redhat.com>
In-Reply-To: <20170919165226.23022-1-marcandre.lureau@redhat.com>
References: <20170919165226.23022-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 13/27] vhost-user-scsi: simplify unix path
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
Cc: pbonzini@redhat.com, changpeng.liu@intel.com, f4bug@amsat.org, felipe@nutanix.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Always remove the unix path when leaving the program (instead of when
freeing scsi_dev). Note that unix_sock_new() also unlink() exisiting
path before creating the socket.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 contrib/vhost-user-scsi/vhost-user-scsi.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-us=
er-scsi/vhost-user-scsi.c
index 82624a0f17..a9a4066eeb 100644
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
@@ -762,7 +747,10 @@ int main(int argc, char **argv)
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
