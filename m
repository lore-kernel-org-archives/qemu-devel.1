Received: from eggs.gnu.org ([209.51.188.92]:36227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gs4HF-0001to-Il
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:25:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gs4HE-0000Ez-Qv
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:25:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gs4HE-0000Eb-Lf
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:25:00 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0960AC050069
	for <qemu-devel@nongnu.org>; Fri,  8 Feb 2019 11:25:00 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  8 Feb 2019 12:23:49 +0100
Message-Id: <20190208112357.31615-6-marcandre.lureau@redhat.com>
In-Reply-To: <20190208112357.31615-1-marcandre.lureau@redhat.com>
References: <20190208112357.31615-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 05/13] vhost-user: wrap some read/write with
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
Cc: kraxel@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/virtio/vhost-user.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index a0e8a81857..b2e1175c1e 100644
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
2.20.1.519.g8feddda32c
