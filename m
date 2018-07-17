Received: from eggs.gnu.org ([2001:4830:134:3::10]:38385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ffPTD-0002zC-6U
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:52:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ffPTC-0000xT-Aw
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:52:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35520 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ffPTC-0000x5-66
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:52:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B16D47C6CA
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:52:45 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Jul 2018 14:52:38 +0200
Message-Id: <20180717125239.22517-3-marcandre.lureau@redhat.com>
In-Reply-To: <20180717125239.22517-1-marcandre.lureau@redhat.com>
References: <20180717125239.22517-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/3] char-socket: make 'fd' incompatible with
 'reconnect'
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

A chardev socket created with the 'fd=3D' argument is not going to
handle reconnection properly by recycling the same fd (or not in a
supported way). Let's forbid this case.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-socket.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 8950f36317..6daa8d003a 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -992,6 +992,10 @@ static void qmp_chardev_open_socket(Chardev *chr,
=20
     s->addr =3D addr =3D socket_address_flatten(sock->addr);
=20
+    if (sock->has_reconnect && addr->type =3D=3D SOCKET_ADDRESS_TYPE_FD)=
 {
+        error_setg(errp, "'reconnect' option is incompatible with 'fd'")=
;
+        goto error;
+    }
     qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_RECONNECTABLE);
     /* TODO SOCKET_ADDRESS_FD where fd has AF_UNIX */
     if (addr->type =3D=3D SOCKET_ADDRESS_TYPE_UNIX) {
--=20
2.18.0.129.ge3331758f1
