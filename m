Received: from eggs.gnu.org ([209.51.188.92]:50473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gtGHE-0000J5-0H
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 13:25:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gtGHC-00088N-NI
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 13:25:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gtGHA-00084s-HN
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 13:25:52 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Mon, 11 Feb 2019 18:24:38 +0000
Message-Id: <20190211182442.8542-13-berrange@redhat.com>
In-Reply-To: <20190211182442.8542-1-berrange@redhat.com>
References: <20190211182442.8542-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 12/16] chardev: honour the reconnect setting
 in tcp_chr_wait_connected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yongji Xie <elohimes@gmail.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>

If establishing a client connection fails, the tcp_chr_wait_connected
method should sleep for the reconnect timeout and then retry the
attempt. This ensures the callers don't immediately abort with an
error when the initial connection fails.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 chardev/char-socket.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index d6de5d2305..7db20ff0a0 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -957,8 +957,15 @@ static int tcp_chr_wait_connected(Chardev *chr, Erro=
r **errp)
         if (s->is_listen) {
             tcp_chr_accept_server_sync(chr);
         } else {
-            if (tcp_chr_connect_client_sync(chr, errp) < 0) {
-                return -1;
+            Error *err =3D NULL;
+            if (tcp_chr_connect_client_sync(chr, &err) < 0) {
+                if (s->reconnect_time) {
+                    error_free(err);
+                    g_usleep(s->reconnect_time * 1000ULL * 1000ULL);
+                } else {
+                    error_propagate(errp, err);
+                    return -1;
+                }
             }
         }
     }
--=20
2.20.1
