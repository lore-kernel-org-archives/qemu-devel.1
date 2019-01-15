Received: from eggs.gnu.org ([209.51.188.92]:46790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjQ6v-0005p6-MU
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:54:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjQ6t-0004tk-PA
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:54:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gjQ6t-0004sz-2h
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:54:35 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 15 Jan 2019 14:52:56 +0000
Message-Id: <20190115145256.9593-13-berrange@redhat.com>
In-Reply-To: <20190115145256.9593-1-berrange@redhat.com>
References: <20190115145256.9593-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 12/12] chardev: fix race with client
 connections in tcp_chr_wait_connected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, Yongji Xie <elohimes@gmail.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

When the 'reconnect' option is given for a client connection, the
qmp_chardev_open_socket_client method will run an asynchronous
connection attempt. The QIOChannel socket executes this is a single use
background thread, so the connection will succeed immediately (assuming
the server is listening). The chardev, however, won't get the result
from this background thread until the main loop starts running and
processes idle callbacks.

Thus when tcp_chr_wait_connected is run s->ioc will be NULL, and the
state will still be TCP_CHARDEV_STATE_DISCONNECTED, but there will
already be an established connection that will be associated with the
chardev by the pending idle callback.  tcp_chr_wait_connected doesn't
see this and so attempts to establish another connection synchronously.

If the server allows multiple connections this is unhelpful but not a
fatal problem as the duplicate connection will get ignored by the
tcp_chr_new_client method when it sees the state is already connected.

If the server only supports a single connection, however, the
tcp_chr_wait_connected method will hang forever because the server will
not accept its synchronous connection attempt until the first connection
is closed.

To deal with this we must ensure that qmp_chardev_open_socket_client
does not actually start the asynchronous connection attempt. Instead it
should schedule a timer with 0ms expiry time, which will only be
processed once the main loop starts running. The tcp_chr_wait_connected
method can now safely do a synchronous connection attempt without
creating a race condition. When the timer expires it will see that a
connection has already been established and take no further action.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 chardev/char-socket.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 7e98a95bbd..07942d7a1b 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -965,7 +965,25 @@ static int tcp_chr_wait_connected(Chardev *chr, Erro=
r **errp)
         }
     }
=20
-    while (!s->ioc) {
+    /*
+     * We expect state to be as follows:
+     *
+     *  - server
+     *    - wait   -> CONNECTED
+     *    - nowait -> DISCONNECTED
+     *  - client
+     *    - reconnect =3D=3D 0 -> CONNECTED
+     *    - reconnect !=3D 0 -> DISCONNECTED
+     *
+     */
+    if (s->state =3D=3D TCP_CHARDEV_STATE_CONNECTING) {
+        error_setg(errp,
+                   "Unexpected 'connecting' state when waiting for "
+                   "connection during early startup");
+        return -1;
+    }
+
+    while (s->state !=3D TCP_CHARDEV_STATE_CONNECTED) {
         if (s->is_listen) {
             tcp_chr_accept_server_sync(chr);
         } else {
@@ -1106,7 +1124,15 @@ static int qmp_chardev_open_socket_client(Chardev =
*chr,
=20
     if (reconnect > 0) {
         s->reconnect_time =3D reconnect;
-        tcp_chr_connect_client_async(chr);
+        /*
+         * We must not start the socket connect attempt until the main
+         * loop is running, otherwise qemu_chr_wait_connect will not be
+         * able to take over connection establishment during startup
+         */
+        s->reconnect_timer =3D qemu_chr_timeout_add_ms(chr,
+                                                     0,
+                                                     socket_reconnect_ti=
meout,
+                                                     chr);
         return 0;
     } else {
         return tcp_chr_connect_client_sync(chr, errp);
--=20
2.20.1
