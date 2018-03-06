Received: from eggs.gnu.org ([2001:4830:134:3::10]:41528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1et5Ee-00017n-Pb
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 00:34:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1et5Ed-0006uC-Sf
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 00:34:00 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41358 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1et5Ed-0006tz-O4
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 00:33:59 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5803E4001416
	for <qemu-devel@nongnu.org>; Tue,  6 Mar 2018 05:33:59 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue,  6 Mar 2018 13:33:18 +0800
Message-Id: <20180306053320.15401-8-peterx@redhat.com>
In-Reply-To: <20180306053320.15401-1-peterx@redhat.com>
References: <20180306053320.15401-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 7/9] chardev: tcp: postpone async connection
 setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, peterx@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This patch allows the socket chardev async connection be setup with
non-default gcontext.  We do it by postponing the setup to machine done,
since until then we can know which context we should run the async
operation on.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 chardev/char-socket.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 1ce5adad9a..165612845a 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1004,9 +1004,8 @@ static void qmp_chardev_open_socket(Chardev *chr,
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
@@ -1138,6 +1137,17 @@ char_socket_get_connected(Object *obj, Error **errp)
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
@@ -1153,6 +1163,7 @@ static void char_socket_class_init(ObjectClass *oc, void *data)
     cc->chr_add_client = tcp_chr_add_client;
     cc->chr_add_watch = tcp_chr_add_watch;
     cc->chr_update_read_handler = tcp_chr_update_read_handler;
+    cc->chr_machine_done = tcp_chr_machine_done_hook;
 
     object_class_property_add(oc, "addr", "SocketAddress",
                               char_socket_get_addr, NULL,
-- 
2.14.3
