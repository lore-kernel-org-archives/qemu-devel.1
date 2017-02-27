Received: from eggs.gnu.org ([2001:4830:134:3::10]:53530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ciLZy-00024a-M7
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:43:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ciLZx-0001hw-UZ
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:43:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ciLZx-0001ho-Oh
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:43:05 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DD355C04B93B
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 13:43:05 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Feb 2017 17:41:53 +0400
Message-Id: <20170227134202.2991-13-marcandre.lureau@redhat.com>
In-Reply-To: <20170227134202.2991-1-marcandre.lureau@redhat.com>
References: <20170227134202.2991-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 12/21] char-socket: update local address
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
index 636a6ea5fa..dbf2c54639 100644
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
2.12.0.rc2.3.gc93709801
