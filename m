Received: from eggs.gnu.org ([209.51.188.92]:58844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1h1J13-0001ss-Ar
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 17:58:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1h1J12-0007jD-HD
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 17:58:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1h1J12-0007hq-9g
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 17:58:28 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9302681DFC
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 22:58:27 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  5 Mar 2019 23:57:24 +0100
Message-Id: <20190305225731.15074-6-marcandre.lureau@redhat.com>
In-Reply-To: <20190305225731.15074-1-marcandre.lureau@redhat.com>
References: <20190305225731.15074-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 05/12] vhost-user: wrap some read/write with
 retry handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, mst@redhat.com

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/virtio/vhost-user.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 0164060b2b..3b09c40578 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -968,7 +968,10 @@ static void slave_read(void *opaque)
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
@@ -997,7 +1000,10 @@ static void slave_read(void *opaque)
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
@@ -1045,7 +1051,10 @@ static void slave_read(void *opaque)
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
2.21.0.4.g36eb1cb9cf
