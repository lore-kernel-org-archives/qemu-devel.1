Received: from eggs.gnu.org ([2001:4830:134:3::10]:43831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fUwqm-0001rX-8x
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:17:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fUwqi-0004yv-Mu
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:17:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44976 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fUwqi-0004yk-HW
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:17:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 323CF401EF03
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 16:17:48 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 18 Jun 2018 18:17:09 +0200
Message-Id: <20180618161729.334-7-marcandre.lureau@redhat.com>
In-Reply-To: <20180618161729.334-1-marcandre.lureau@redhat.com>
References: <20180618161729.334-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 06/26] vhost-user: wrap some read/write with
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
Cc: berrange@redhat.com, kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/virtio/vhost-user.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 44795880d6..5b4188bc27 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -975,7 +975,10 @@ static void slave_read(void *opaque)
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
@@ -1004,7 +1007,10 @@ static void slave_read(void *opaque)
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
@@ -1052,7 +1058,10 @@ static void slave_read(void *opaque)
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
2.18.0.rc1
