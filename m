Received: from eggs.gnu.org ([209.51.188.92]:42404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1go7q6-0005vB-Ic
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:24:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1go7q2-0003Eq-NX
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:24:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1go7q1-000387-37
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:24:38 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BB11E19F43
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 14:24:27 +0000 (UTC)
From: Bandan Das <bsd@redhat.com>
Date: Mon, 28 Jan 2019 09:24:10 -0500
Message-Id: <20190128142410.11584-4-bsd@redhat.com>
In-Reply-To: <20190128142410.11584-1-bsd@redhat.com>
References: <20190128142410.11584-1-bsd@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 3/3] usb-mtp: replace the homebrew write
 with qemu_write_full
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

qemu_write_full takes care of partial blocking writes,
as in cases of larger file sizes

Signed-off-by: Bandan Das <bsd@redhat.com>
---
 hw/usb/dev-mtp.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index b607c7be05..f4d9470493 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1630,24 +1630,16 @@ static char *utf16_to_str(uint8_t len, uint16_t *=
arr)
 /* Wrapper around write, returns 0 on failure */
 static uint64_t write_retry(int fd, void *buf, uint64_t size, off_t offs=
et)
 {
-        uint64_t bytes_left =3D size, ret;
+        uint64_t ret =3D 0;
=20
         if (lseek(fd, offset, SEEK_SET) < 0) {
             goto done;
         }
=20
-        while (bytes_left > 0) {
-                ret =3D write(fd, buf, bytes_left);
-                if ((ret =3D=3D -1) && (errno !=3D EINTR || errno !=3D E=
AGAIN ||
-                                    errno !=3D EWOULDBLOCK)) {
-                        break;
-                }
-                bytes_left -=3D ret;
-                buf +=3D ret;
-        }
+        ret =3D qemu_write_full(fd, buf, size);
=20
 done:
-        return size - bytes_left;
+        return ret;
 }
=20
 static void usb_mtp_update_object(MTPObject *parent, char *name)
--=20
2.19.2
