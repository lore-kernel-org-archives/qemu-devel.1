Received: from eggs.gnu.org ([209.51.188.92]:41758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmMJo-0002Ol-0m
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:28:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmMJn-0002XM-9m
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:28:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gmMJl-0002UX-FW
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:28:03 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 23 Jan 2019 17:27:28 +0000
Message-Id: <20190123172740.32452-5-berrange@redhat.com>
In-Reply-To: <20190123172740.32452-1-berrange@redhat.com>
References: <20190123172740.32452-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 04/16] chardev: forbid 'reconnect' option
 with server sockets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Yongji Xie <elohimes@gmail.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The 'reconnect' option is used to give the sleep time, in seconds,
before a client socket attempts to re-establish a connection to the
server. It does not make sense to set this for server sockets, as they
will always accept a new client connection immediately after the
previous one went away.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 chardev/char-socket.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index e85250b624..743b7b11cd 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1035,7 +1035,14 @@ static bool qmp_chardev_validate_socket(ChardevSoc=
ket *sock,
     }
=20
     /* Validate any options which have a dependancy on client vs server =
*/
-    if (!(sock->has_server && sock->server)) {
+    if (!sock->has_server || sock->server) {
+        if (sock->has_reconnect) {
+            error_setg(errp,
+                       "'reconnect' option is incompatible with "
+                       "socket in server listen mode");
+            return false;
+        }
+    } else {
         if (sock->has_websocket && sock->websocket) {
             error_setg(errp, "%s", "Websocket client is not implemented"=
);
             return false;
--=20
2.20.1
