Received: from eggs.gnu.org ([2001:4830:134:3::10]:40135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evoPz-0000zj-W6
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:13:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evoPy-0007Gn-Bm
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:12:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58654 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1evoPy-0007GU-6X
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:12:58 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 13 Mar 2018 18:12:40 +0000
Message-Id: <20180313181248.16215-2-berrange@redhat.com>
In-Reply-To: <20180313181248.16215-1-berrange@redhat.com>
References: <20180313181248.16215-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v2 1/9] char: don't silently skip tn3270
 protocol init when TLS is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

Even if common tn3270 implementations do not support TLS, it is trivial to
have them proxied over a proxy like stunnel which adds TLS at the sockets
layer. We should thus not silently skip tn3270 protocol initialization
when TLS is enabled.

Reviewed-by: Eric Blake <eblake@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 chardev/char-socket.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index a220803c01..1a371b91ac 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -663,8 +663,7 @@ static void tcp_chr_tls_handshake(QIOTask *task,
     if (qio_task_propagate_error(task, NULL)) {
         tcp_chr_disconnect(chr);
     } else {
-        /* tn3270 does not support TLS yet */
-        if (s->do_telnetopt && !s->is_tn3270) {
+        if (s->do_telnetopt) {
             tcp_chr_telnet_init(chr);
         } else {
             tcp_chr_connect(chr);
-- 
2.14.3
