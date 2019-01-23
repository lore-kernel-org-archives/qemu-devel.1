Received: from eggs.gnu.org ([209.51.188.92]:42061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmMKY-00031M-V7
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:28:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmMKW-0002uA-BL
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:28:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gmMKW-0002tH-1R
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:28:48 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 23 Jan 2019 17:27:37 +0000
Message-Id: <20190123172740.32452-14-berrange@redhat.com>
In-Reply-To: <20190123172740.32452-1-berrange@redhat.com>
References: <20190123172740.32452-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 13/16] chardev: disallow
 TLS/telnet/websocket with tcp_chr_wait_connected
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

In the previous commit

    commit 1dc8a6695c731abb7461c637b2512c3670d82be4
    Author: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
    Date:   Tue Aug 16 12:33:32 2016 +0400

      char: fix waiting for TLS and telnet connection

the tcp_chr_wait_connected() method was changed to check for a non-NULL
's->ioc' as a sign that there is already a connection present, as
opposed to checking the "connected" flag to supposedly fix handling of
TLS/telnet connections.

The original code would repeatedly call tcp_chr_wait_connected creating
many connections as 'connected' would never become true. The changed
code would still repeatedly call tcp_chr_wait_connected busy waiting
because s->ioc is set but the chardev will never see CHR_EVENT_OPENED.
IOW, the code is still broken with TLS/telnet, but in a different way.

Checking for a non-NULL 's->ioc' does not mean that a CHR_EVENT_OPENED
will be ready for a TLS/telnet connection. These protocols (and the
websocket protocol) all require the main loop to be running in order
to complete the protocol handshake before emitting CHR_EVENT_OPENED.
The tcp_chr_wait_connected() method is only used during early startup
before a main loop is running, so TLS/telnet/websock connections can
never complete initialization.

Making this work would require changing tcp_chr_wait_connected to run
a main loop. This is quite complex since we must not allow GSource's
that other parts of QEMU have registered to run yet. The current callers
of tcp_chr_wait_connected do not require use of the TLS/telnet/websocket
protocols, so the simplest option is to just forbid this combination
completely for now.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 chardev/char-socket.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 7db20ff0a0..86c1f502d6 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -951,8 +951,20 @@ static void tcp_chr_accept_server_sync(Chardev *chr)
 static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
 {
     SocketChardev *s =3D SOCKET_CHARDEV(chr);
-    /* It can't wait on s->connected, since it is set asynchronously
-     * in TLS and telnet cases, only wait for an accepted socket */
+    const char *opts[] =3D { "telnet", "tn3270", "websock", "tls-creds" =
};
+    bool optset[] =3D { s->is_telnet, s->is_tn3270, s->is_websock, s->tl=
s_creds };
+    size_t i;
+
+    QEMU_BUILD_BUG_ON(G_N_ELEMENTS(opts) !=3D G_N_ELEMENTS(optset));
+    for (i =3D 0; i < G_N_ELEMENTS(opts); i++) {
+        if (optset[i]) {
+            error_setg(errp,
+                       "'%s' option is incompatible with waiting for "
+                       "connection completion", opts[i]);
+            return -1;
+        }
+    }
+
     while (!s->ioc) {
         if (s->is_listen) {
             tcp_chr_accept_server_sync(chr);
--=20
2.20.1
