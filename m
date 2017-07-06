Received: from eggs.gnu.org ([2001:4830:134:3::10]:45479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dTACB-0004e7-Vu
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:04:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dTAC8-0000QK-Rk
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:04:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dTAC8-0000PR-Ky
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:04:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8F20A4E03F
	for <qemu-devel@nongnu.org>; Thu,  6 Jul 2017 17:03:59 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  6 Jul 2017 19:03:53 +0200
Message-Id: <20170706170353.32601-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] chardev: block during sync read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

A sync read should block until all requested data is
available (instead of retrying in qemu_chr_fe_read_all). Change the
channel to blocking during sync_read.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-socket.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index ccc499cfa1..7e6648b03a 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -454,7 +454,9 @@ static int tcp_chr_sync_read(Chardev *chr, const uint=
8_t *buf, int len)
         return 0;
     }
=20
+    qio_channel_set_blocking(s->ioc, true, NULL);
     size =3D tcp_chr_recv(chr, (void *) buf, len);
+    qio_channel_set_blocking(s->ioc, false, NULL);
     if (size =3D=3D 0) {
         /* connection closed */
         tcp_chr_disconnect(chr);
--=20
2.13.1.395.gf7b71de06
