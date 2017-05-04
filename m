Received: from eggs.gnu.org ([2001:4830:134:3::10]:46234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d6FAy-0003r1-9M
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:44:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d6FAt-0004dc-6o
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:44:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47405)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d6FAt-0004dR-0q
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:43:59 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  4 May 2017 15:42:23 +0400
Message-Id: <20170504114232.20318-13-marcandre.lureau@redhat.com>
In-Reply-To: <20170504114232.20318-1-marcandre.lureau@redhat.com>
References: <20170504114232.20318-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/21] char-socket: update local address after
 listen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is mainly useful to know the actual bound port when using port 0.

For example, when starting qemu with socket on port 0, before:
QEMU waiting for connection on: disconnected:tcp:localhost:0,server
After:
QEMU waiting for connection on: disconnected:tcp:localhost:32454,server

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-socket.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 511a82960d..f24961ad16 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -911,6 +911,11 @@ static void qmp_chardev_open_socket(Chardev *chr,
             if (qio_channel_socket_listen_sync(sioc, s->addr, errp) < 0)=
 {
                 goto error;
             }
+
+            qapi_free_SocketAddress(s->addr);
+            s->addr =3D socket_local_address(sioc->fd, errp);
+            update_disconnected_filename(s);
+
             s->listen_ioc =3D sioc;
             if (is_waitconnect &&
                 qemu_chr_wait_connected(chr, errp) < 0) {
--=20
2.12.0.191.gc5d8de91d
