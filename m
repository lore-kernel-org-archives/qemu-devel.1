Received: from eggs.gnu.org ([209.51.188.92]:39586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtxGc-0004aC-1p
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:20:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtxGa-0005pp-GF
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:20:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gtxGa-0005pQ-AI
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:20:08 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 13 Feb 2019 17:19:12 +0100
Message-Id: <20190213161913.22107-25-marcandre.lureau@redhat.com>
In-Reply-To: <20190213161913.22107-1-marcandre.lureau@redhat.com>
References: <20190213161913.22107-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 24/25] char-pty: remove the check for
 connection on write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This doesn't help much compared to the 1 second poll PTY
timer. I can't think of a use case where this would help.

However, we can simplify the code around chr_write(): the write lock
is no longer needed for other char-pty callbacks (see following
patch).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20190206174328.9736-6-marcandre.lureau@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-pty.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index f681d637c1..f8772c9e15 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -130,11 +130,7 @@ static int char_pty_chr_write(Chardev *chr, const ui=
nt8_t *buf, int len)
     PtyChardev *s =3D PTY_CHARDEV(chr);
=20
     if (!s->connected) {
-        /* guest sends data, check for (re-)connect */
-        pty_chr_update_read_handler_locked(chr);
-        if (!s->connected) {
-            return len;
-        }
+        return len;
     }
     return io_channel_send(s->ioc, buf, len);
 }
--=20
2.21.0.rc0.1.g036caf7885
