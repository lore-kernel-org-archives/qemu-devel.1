Received: from eggs.gnu.org ([2001:4830:134:3::10]:56731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fuPvH-0003nK-V3
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 18:23:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fuPvH-0005xa-Bv
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 18:23:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49316 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fuPvH-0005xW-6T
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 18:23:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DBBF5401DECC
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 22:23:46 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 28 Aug 2018 00:23:21 +0200
Message-Id: <20180827222322.26009-9-marcandre.lureau@redhat.com>
In-Reply-To: <20180827222322.26009-1-marcandre.lureau@redhat.com>
References: <20180827222322.26009-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 8/9] char-pty: remove check for connection on
 write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This doesn't give much compared to the 1 second timer: there is no
reliable / unracy way to have slave connect & master write. However,
we can simplify the code around chr_write() since the write lock is no
longer needed for various other char-pty callbacks (see following
patch).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-pty.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index 68fd4e20c3..ebd7035c6d 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -134,11 +134,7 @@ static int char_pty_chr_write(Chardev *chr, const ui=
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
2.18.0.547.g1d89318c48
