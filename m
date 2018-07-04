Received: from eggs.gnu.org ([2001:4830:134:3::10]:55761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fafh2-0004vJ-5H
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 07:11:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fafgy-0007G1-N3
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 07:11:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54702 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fafgy-0007FY-JZ
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 07:11:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 47725407565B
	for <qemu-devel@nongnu.org>; Wed,  4 Jul 2018 11:11:23 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed,  4 Jul 2018 12:11:18 +0100
Message-Id: <20180704111118.7241-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] chardev: unconditionally set FD_PASS feature
 for socket type=fd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The vhostuser network backend requires the chardev it is using to have
the FD passing feature. It checks this upfront when initializing the
network backend and reports an error if not set.

The socket chardev has to set the FD_PASS feature during early
initialization to satisfy the vhostuser backend, and at this point
the socket has not been initialized. It is thus unable to do a live
check on the socket to see if it supports FD passing (aka is a UNIX
socket). As a result it has to blindly set FD_PASS feature based
solely on info in the SocketAddress struct, such as address type.

Unfortunately libvirt wishes to use FD passing to provide the UNIX
domain socket listener, and as a result the FD_PASS feature is no
longer set, which breaks vhostuser's checks, despite the fact that
FD passing will in fact work later.

This unconditionally sets FD_PASS feature for any socket address
which has type=3D=3Dfd. Thus will be wrong if the passed in FD was not
a UNIX socket, but if an attempt is later made to use FD passing
we'll still get an error reported by the QIOChannelSocket class.
So the effective of setting the chardev FD_PASS feature early
is merely to delay error reporting.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 chardev/char-socket.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 17519ec589..b495d6a851 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -990,8 +990,18 @@ static void qmp_chardev_open_socket(Chardev *chr,
     s->addr =3D addr =3D socket_address_flatten(sock->addr);
=20
     qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_RECONNECTABLE);
-    /* TODO SOCKET_ADDRESS_FD where fd has AF_UNIX */
-    if (addr->type =3D=3D SOCKET_ADDRESS_TYPE_UNIX) {
+    /*
+     * We can't tell at this point if the "fd" we're passed is
+     * a UNIX socket or not, so can't reliably set the
+     * FD_PASS feature. vhost-user, however, checks for this
+     * feature early before we've even created the I/O channel,
+     * so we can't wait until later to set the feature. Thus
+     * we optimistically set the FD_PASS feature. If the passed
+     * in "fd" is not a UNIX socket, there will be an error
+     * reported later anyway.
+     */
+    if (addr->type =3D=3D SOCKET_ADDRESS_TYPE_UNIX ||
+        addr->type =3D=3D SOCKET_ADDRESS_TYPE_FD) {
         qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_FD_PASS);
     }
=20
--=20
2.17.1
