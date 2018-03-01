Received: from eggs.gnu.org ([2001:4830:134:3::10]:52828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erJrF-0000eP-GV
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 03:46:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erJrC-0007m0-R4
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 03:46:33 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41614 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1erJrC-0007lb-Ko
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 03:46:30 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A339C404084B
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 08:46:13 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu,  1 Mar 2018 16:44:37 +0800
Message-Id: <20180301084438.13594-15-peterx@redhat.com>
In-Reply-To: <20180301084438.13594-1-peterx@redhat.com>
References: <20180301084438.13594-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 14/15] chardev: tcp: postpone async
 connection setup
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

This patch allows the socket chardev async connection be setup with
non-default gcontext.  We do it by postponing the setup to machine done,
since until then we can know which context we should run the async
operation on.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 chardev/char-socket.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index cd9db123f2..2b355fc7a8 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -997,9 +997,8 @@ static void qmp_chardev_open_socket(Chardev *chr,
         s->reconnect_time = reconnect;
     }
 
-    if (s->reconnect_time) {
-        tcp_chr_connect_async(chr);
-    } else {
+    /* If reconnect_time is set, will do that in chr_machine_done. */
+    if (!s->reconnect_time) {
         if (s->is_listen) {
             char *name;
             s->listener = qio_net_listener_new();
@@ -1128,6 +1127,17 @@ char_socket_get_connected(Object *obj, Error **errp)
     return s->connected;
 }
 
+static int tcp_chr_machine_done_hook(Chardev *chr)
+{
+    SocketChardev *s = SOCKET_CHARDEV(chr);
+
+    if (s->reconnect_time) {
+        tcp_chr_connect_async(chr);
+    }
+
+    return 0;
+}
+
 static void char_socket_class_init(ObjectClass *oc, void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
@@ -1143,6 +1153,7 @@ static void char_socket_class_init(ObjectClass *oc, void *data)
     cc->chr_add_client = tcp_chr_add_client;
     cc->chr_add_watch = tcp_chr_add_watch;
     cc->chr_update_read_handler = tcp_chr_update_read_handler;
+    cc->chr_machine_done = tcp_chr_machine_done_hook;
 
     object_class_property_add(oc, "addr", "SocketAddress",
                               char_socket_get_addr, NULL,
-- 
2.14.3
