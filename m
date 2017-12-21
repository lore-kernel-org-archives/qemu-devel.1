Received: from eggs.gnu.org ([2001:4830:134:3::10]:46586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eRyUt-00084Y-CE
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 05:54:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eRyUq-0004kR-Aq
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 05:54:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eRyUq-0004ic-3W
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 05:54:40 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1D62C806AE
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 10:54:38 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 21 Dec 2017 10:54:33 +0000
Message-Id: <20171221105433.32307-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] char: don't silently skip tn3270 protocol init
 when TLS is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Even if common tn3270 implementations do not support TLS, it is trivial to
have them proxied over a proxy like stunnel which adds TLS at the sockets
layer. We should thus not silently skip tn3270 protocol initialization
when TLS is enabled.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 chardev/char-socket.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 53eda8ef00..6013972f72 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -623,8 +623,7 @@ static void tcp_chr_tls_handshake(QIOTask *task,
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
