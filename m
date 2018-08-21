Received: from eggs.gnu.org ([2001:4830:134:3::10]:33971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4y-0002Sa-5J
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4r-0007I3-NN
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:25 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:39711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4r-0007GR-6i
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:21 -0400
Received: by mail-wm0-x233.google.com with SMTP id q8-v6so3503072wmq.4
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:04:21 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:02:44 +0200
Message-Id: <1534870966-9287-73-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 72/74] Revert "chardev: tcp: postpone async
 connection setup"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

This reverts commit 25679e5d58e258e9950685ffbd0cae4cd40d9cc2.

This commit broke "reconnect socket" chardev that are created after
"machine_done": they no longer try to connect. It broke also
vhost-user-test that uses chardev while there is no "machine_done"
event.

The goal of this patch was to move the "connect" source to the
frontend context. chr->gcontext is set with
qemu_chr_fe_set_handlers(). But there is no guarantee that it will be
called, so we can't delay connection until then: the chardev should
still attempt to connect during open(). qemu_chr_fe_set_handlers() is
eventually called later and will update the context.

Unless there is a good reason to not use initially the default
context, I think we should revert to the previous state to fix the
regressions.

Signed-off-by: Marc-AndrÃ© Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180817135224.22971-3-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-socket.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index e28d2cc..14f6567 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1005,8 +1005,9 @@ static void qmp_chardev_open_socket(Chardev *chr,
         s->reconnect_time = reconnect;
     }
 
-    /* If reconnect_time is set, will do that in chr_machine_done. */
-    if (!s->reconnect_time) {
+    if (s->reconnect_time) {
+        tcp_chr_connect_async(chr);
+    } else {
         if (s->is_listen) {
             char *name;
             s->listener = qio_net_listener_new();
@@ -1155,17 +1156,6 @@ char_socket_get_connected(Object *obj, Error **errp)
     return s->connected;
 }
 
-static int tcp_chr_machine_done_hook(Chardev *chr)
-{
-    SocketChardev *s = SOCKET_CHARDEV(chr);
-
-    if (s->reconnect_time) {
-        tcp_chr_connect_async(chr);
-    }
-
-    return 0;
-}
-
 static void char_socket_class_init(ObjectClass *oc, void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
@@ -1181,7 +1171,6 @@ static void char_socket_class_init(ObjectClass *oc, void *data)
     cc->chr_add_client = tcp_chr_add_client;
     cc->chr_add_watch = tcp_chr_add_watch;
     cc->chr_update_read_handler = tcp_chr_update_read_handler;
-    cc->chr_machine_done = tcp_chr_machine_done_hook;
 
     object_class_property_add(oc, "addr", "SocketAddress",
                               char_socket_get_addr, NULL,
-- 
1.8.3.1
