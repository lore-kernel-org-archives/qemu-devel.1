Received: from eggs.gnu.org ([2001:4830:134:3::10]:35242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gI8IT-0007RM-0p
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 04:25:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gI8IS-0006D3-DC
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 04:25:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gI8IQ-0006Am-PP
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 04:25:42 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  1 Nov 2018 12:24:19 +0400
Message-Id: <20181101082423.26424-4-marcandre.lureau@redhat.com>
In-Reply-To: <20181101082423.26424-1-marcandre.lureau@redhat.com>
References: <20181101082423.26424-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 3/7] char-socket: make 'fd' incompatible with
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
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>

A chardev socket created with the 'fd=3D' argument is not going to
handle reconnection properly by recycling the same fd (or not in a
supported way). Let's forbid this case.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 chardev/char-socket.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 64e24cb2ab..e4137ccd3c 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -997,6 +997,10 @@ static void qmp_chardev_open_socket(Chardev *chr,
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
2.19.1.708.g4ede3d42df
