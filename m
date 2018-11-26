Received: from eggs.gnu.org ([2001:4830:134:3::10]:49610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRGFN-0007ir-1O
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 07:44:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRGFJ-0007b1-2A
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 07:44:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gRGFI-0007aO-S7
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 07:44:13 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Nov 2018 16:42:43 +0400
Message-Id: <20181126124250.29985-5-marcandre.lureau@redhat.com>
In-Reply-To: <20181126124250.29985-1-marcandre.lureau@redhat.com>
References: <20181126124250.29985-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 04/11] vhost-user: wrap some read/write
 with retry handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "Michael S. Tsirkin" <mst@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/virtio/vhost-user.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 90a9492bcf..0131bbb0fc 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -964,7 +964,10 @@ static void slave_read(void *opaque)
     iov.iov_base =3D &hdr;
     iov.iov_len =3D VHOST_USER_HDR_SIZE;
=20
-    size =3D recvmsg(u->slave_fd, &msgh, 0);
+    do {
+        size =3D recvmsg(u->slave_fd, &msgh, 0);
+    } while (size < 0 && (errno =3D=3D EINTR || errno =3D=3D EAGAIN));
+
     if (size !=3D VHOST_USER_HDR_SIZE) {
         error_report("Failed to read from slave.");
         goto err;
@@ -993,7 +996,10 @@ static void slave_read(void *opaque)
     }
=20
     /* Read payload */
-    size =3D read(u->slave_fd, &payload, hdr.size);
+    do {
+        size =3D read(u->slave_fd, &payload, hdr.size);
+    } while (size < 0 && (errno =3D=3D EINTR || errno =3D=3D EAGAIN));
+
     if (size !=3D hdr.size) {
         error_report("Failed to read payload from slave.");
         goto err;
@@ -1041,7 +1047,10 @@ static void slave_read(void *opaque)
         iovec[1].iov_base =3D &payload;
         iovec[1].iov_len =3D hdr.size;
=20
-        size =3D writev(u->slave_fd, iovec, ARRAY_SIZE(iovec));
+        do {
+            size =3D writev(u->slave_fd, iovec, ARRAY_SIZE(iovec));
+        } while (size < 0 && (errno =3D=3D EINTR || errno =3D=3D EAGAIN)=
);
+
         if (size !=3D VHOST_USER_HDR_SIZE + hdr.size) {
             error_report("Failed to send msg reply to slave.");
             goto err;
--=20
2.20.0.rc1
