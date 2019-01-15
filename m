Received: from eggs.gnu.org ([209.51.188.92]:46761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjQ6s-0005lx-Ck
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:54:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjQ6r-0004sk-Ow
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:54:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gjQ6p-0004r8-7c
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:54:32 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 15 Jan 2019 14:52:54 +0000
Message-Id: <20190115145256.9593-11-berrange@redhat.com>
In-Reply-To: <20190115145256.9593-1-berrange@redhat.com>
References: <20190115145256.9593-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/12] chardev: honour the reconnect setting in
 tcp_chr_wait_connected
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

If establishing a client connection fails, the tcp_chr_wait_connected
method should sleep for the reconnect timeout and then retry the
attempt. This ensures the callers don't immediately abort with an
error when the initial connection fails.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 chardev/char-socket.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 96a60eb105..91d775e9c5 100644
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
+                    g_usleep(s->reconnect_time);
+                } else {
+                    error_propagate(errp, err);
+                    return -1;
+                }
             }
         }
     }
--=20
2.20.1
