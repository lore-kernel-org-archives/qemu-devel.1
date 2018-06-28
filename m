Received: from eggs.gnu.org ([2001:4830:134:3::10]:33696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYViw-0006bm-2t
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:08:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYViv-0007wm-4h
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:08:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34006 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fYViu-0007wQ-VW
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:08:29 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 28 Jun 2018 13:08:21 +0100
Message-Id: <20180628120821.10967-3-berrange@redhat.com>
In-Reply-To: <20180628120821.10967-1-berrange@redhat.com>
References: <20180628120821.10967-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 2/2] Delete AF_UNIX socket after close
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Pavel Balaev <mail@void.so>

From: Pavel Balaev <mail@void.so>

Since version 2.12.0 AF_UNIX socket created for QMP exchange is not
deleted on instance shutdown.

This is due to the fact that function qio_channel_socket_finalize() is
called after qio_channel_socket_close().

Signed-off-by: Pavel Balaev <mail@void.so>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 io/channel-socket.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/io/channel-socket.c b/io/channel-socket.c
index 57cfb4d3a6..b50e63a053 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -685,8 +685,10 @@ qio_channel_socket_close(QIOChannel *ioc,
                          Error **errp)
 {
     QIOChannelSocket *sioc =3D QIO_CHANNEL_SOCKET(ioc);
+    int rc =3D 0;
=20
     if (sioc->fd !=3D -1) {
+        SocketAddress *addr =3D socket_local_address(sioc->fd, errp);
 #ifdef WIN32
         WSAEventSelect(sioc->fd, NULL, 0);
 #endif
@@ -697,8 +699,22 @@ qio_channel_socket_close(QIOChannel *ioc,
             return -1;
         }
         sioc->fd =3D -1;
+
+        if (addr && addr->type =3D=3D SOCKET_ADDRESS_TYPE_UNIX
+            && addr->u.q_unix.path) {
+            if (unlink(addr->u.q_unix.path) < 0 && errno !=3D ENOENT) {
+                error_setg_errno(errp, errno,
+                                 "Failed to unlink socket %s",
+                                 addr->u.q_unix.path);
+                rc =3D -1;
+            }
+        }
+
+        if (addr) {
+            qapi_free_SocketAddress(addr);
+        }
     }
-    return 0;
+    return rc;
 }
=20
 static int
--=20
2.17.1
