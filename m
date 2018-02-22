Received: from eggs.gnu.org ([2001:4830:134:3::10]:47480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eoplR-0003pQ-AG
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:14:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eoplM-0005JP-Bw
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:14:17 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43740 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eoplM-0005HI-7O
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:14:12 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 22 Feb 2018 12:13:51 +0000
Message-Id: <20180222121351.26191-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v1] chardev: fix handling of EAGAIN for TCP
 chardev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Aleksey Kuleshov <rndfax@yandex.ru>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

When this commit was applied

  commit 9894dc0cdcc397ee5b26370bc53da6d360a363c2
  Author: Daniel P. Berrange <berrange@redhat.com>
  Date:   Tue Jan 19 11:14:29 2016 +0000

    char: convert from GIOChannel to QIOChannel

The tcp_chr_recv() function was changed to return QIO_CHANNEL_ERR_BLOCK
which corresonds to -2. As such the handling for EAGAIN was able to be
removed from tcp_chr_read(). Unfortunately in a later commit:

  commit b6572b4f97a7b126c7b24e165893ed9fe3d72e1f
  Author: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
  Date:   Fri Mar 11 18:55:24 2016 +0100

    char: translate from QIOChannel error to errno

The tcp_chr_recv() function was changed back to return -1, with errno
set to EAGAIN, without also re-addding support for this to tcp_chr_read()

Reported-by: Aleksey Kuleshov <rndfax@yandex.ru>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 chardev/char-socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index bdd6cff5f6..b15682c362 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -449,7 +449,7 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOCon=
dition cond, void *opaque)
         len =3D s->max_size;
     }
     size =3D tcp_chr_recv(chr, (void *)buf, len);
-    if (size =3D=3D 0 || size =3D=3D -1) {
+    if (size =3D=3D 0 || (size =3D=3D -1 && errno !=3D EAGAIN)) {
         /* connection closed */
         tcp_chr_disconnect(chr);
     } else if (size > 0) {
--=20
2.14.3
