Received: from eggs.gnu.org ([2001:4830:134:3::10]:47251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1coRbv-0004aZ-LL
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:22:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1coRbu-0000VW-ST
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:22:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1coRbu-0000V9-Mz
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:22:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BAAFCC05680F
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 09:22:18 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 16 Mar 2017 13:21:12 +0400
Message-Id: <20170316092121.25672-13-marcandre.lureau@redhat.com>
In-Reply-To: <20170316092121.25672-1-marcandre.lureau@redhat.com>
References: <20170316092121.25672-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 12/21] char-socket: update local address
 after listen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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
index e3b5288af7..4325a05387 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -908,6 +908,11 @@ static void qmp_chardev_open_socket(Chardev *chr,
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
