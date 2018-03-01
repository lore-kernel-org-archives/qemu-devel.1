Received: from eggs.gnu.org ([2001:4830:134:3::10]:52827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erJrF-0000eO-GU
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 03:46:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erJrA-0007k2-KQ
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 03:46:33 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36958 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1erJrA-0007jo-FV
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 03:46:28 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E76DE4026789
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 08:46:27 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu,  1 Mar 2018 16:44:38 +0800
Message-Id: <20180301084438.13594-16-peterx@redhat.com>
In-Reply-To: <20180301084438.13594-1-peterx@redhat.com>
References: <20180301084438.13594-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 15/15] chardev: tcp: postpone TLS work until
 machine done
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, peterx@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

TLS handshake may create background GSource tasks, while we won't know
the correct GMainContext until the whole chardev (including frontend)
inited.  Let's postpone the initial TLS handshake until machine done.

If we dynamically add tcp chardev, it won't be affected since we have a
new tcp_chr_machine_done flag to know whether we should postpone it or
not.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 chardev/char-socket.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 2b355fc7a8..13aeca0b27 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -72,6 +72,8 @@ typedef struct {
 static gboolean socket_reconnect_timeout(gpointer opaque);
 static void tcp_chr_telnet_init(Chardev *chr);
 
+static bool tcp_chr_machine_done;
+
 static void tcp_chr_reconn_timer_cancel(SocketChardev *s)
 {
     if (s->reconnect_timer) {
@@ -719,6 +721,11 @@ static void tcp_chr_tls_init(Chardev *chr)
     Error *err = NULL;
     gchar *name;
 
+    if (!tcp_chr_machine_done) {
+        /* This will be postponed to machine_done notifier */
+        return;
+    }
+
     if (s->is_listen) {
         tioc = qio_channel_tls_new_server(
             s->ioc, s->tls_creds,
@@ -1131,10 +1138,17 @@ static int tcp_chr_machine_done_hook(Chardev *chr)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
 
+    /* Set it multiple times won't hurt */
+    tcp_chr_machine_done = true;
+
     if (s->reconnect_time) {
         tcp_chr_connect_async(chr);
     }
 
+    if (s->tls_creds) {
+        tcp_chr_tls_init(chr);
+    }
+
     return 0;
 }
 
-- 
2.14.3
