Received: from eggs.gnu.org ([2001:4830:134:3::10]:38414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ffPTF-0002zS-95
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:52:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ffPTE-0000zN-AT
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:52:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41084 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ffPTE-0000ys-5h
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:52:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7E5B277885
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:52:47 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Jul 2018 14:52:39 +0200
Message-Id: <20180717125239.22517-4-marcandre.lureau@redhat.com>
In-Reply-To: <20180717125239.22517-1-marcandre.lureau@redhat.com>
References: <20180717125239.22517-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/3] char-socket: delay setting fd-pass feature
 until connected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, berrange@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Wait for QIO channel connection completion, and check the feature set
by QIO. This fixes setting fd-pass chardev feature on
SOCKET_ADDRESS_FD where fd has AF_UNIX.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-socket.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 6daa8d003a..7387e632d4 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -789,6 +789,9 @@ static int tcp_chr_new_client(Chardev *chr, QIOChanne=
lSocket *sioc)
=20
     qio_channel_set_blocking(s->ioc, false, NULL);
=20
+    if (qio_channel_has_feature(s->ioc, QIO_CHANNEL_FEATURE_FD_PASS)) {
+        qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_FD_PASS);
+    }
     if (s->do_nodelay) {
         qio_channel_set_delay(s->ioc, false);
     }
@@ -996,11 +999,8 @@ static void qmp_chardev_open_socket(Chardev *chr,
         error_setg(errp, "'reconnect' option is incompatible with 'fd'")=
;
         goto error;
     }
+
     qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_RECONNECTABLE);
-    /* TODO SOCKET_ADDRESS_FD where fd has AF_UNIX */
-    if (addr->type =3D=3D SOCKET_ADDRESS_TYPE_UNIX) {
-        qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_FD_PASS);
-    }
=20
     /* be isn't opened until we get a connection */
     *be_opened =3D false;
--=20
2.18.0.129.ge3331758f1
