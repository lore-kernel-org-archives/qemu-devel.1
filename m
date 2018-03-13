Received: from eggs.gnu.org ([2001:4830:134:3::10]:57944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evshr-0005Y7-MV
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evshq-00033V-QX
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:43 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:42346)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evshq-00032U-JU
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:42 -0400
Received: by mail-wr0-x241.google.com with SMTP id s18so2505702wrg.9
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:47:42 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:26 +0100
Message-Id: <20180313224719.4954-17-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/69] chardev: tcp: postpone async connection
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
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

This patch allows the socket chardev async connection be setup with
non-default gcontext.  We do it by postponing the setup to machine done,
since until then we can know which context we should run the async
operation on.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180306053320.15401-8-peterx@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-socket.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 09aa345869..f6ad6ee4d8 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1005,9 +1005,8 @@ static void qmp_chardev_open_socket(Chardev *chr,
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
@@ -1139,6 +1138,17 @@ char_socket_get_connected(Object *obj, Error **errp)
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
@@ -1154,6 +1164,7 @@ static void char_socket_class_init(ObjectClass *oc, void *data)
     cc->chr_add_client = tcp_chr_add_client;
     cc->chr_add_watch = tcp_chr_add_watch;
     cc->chr_update_read_handler = tcp_chr_update_read_handler;
+    cc->chr_machine_done = tcp_chr_machine_done_hook;
 
     object_class_property_add(oc, "addr", "SocketAddress",
                               char_socket_get_addr, NULL,
-- 
2.14.3
