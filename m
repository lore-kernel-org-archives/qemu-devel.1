Received: from eggs.gnu.org ([209.51.188.92]:33674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1grRFA-000623-RE
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:44:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1grRF9-0004cs-Q5
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:44:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1grRF9-0004Sh-C2
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:44:15 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C4D5EC01DDED
	for <qemu-devel@nongnu.org>; Wed,  6 Feb 2019 17:44:02 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  6 Feb 2019 18:43:27 +0100
Message-Id: <20190206174328.9736-6-marcandre.lureau@redhat.com>
In-Reply-To: <20190206174328.9736-1-marcandre.lureau@redhat.com>
References: <20190206174328.9736-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 5/6] char-pty: remove the check for
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This doesn't help much compared to the 1 second poll PTY
timer. I can't think of a use case where this would help.

However, we can simplify the code around chr_write(): the write lock
is no longer needed for other char-pty callbacks (see following
patch).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
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
2.20.1.519.g8feddda32c
