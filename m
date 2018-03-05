Received: from eggs.gnu.org ([2001:4830:134:3::10]:46542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1esjxa-0007UJ-Ow
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 01:50:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1esjxZ-0001VZ-8V
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 01:50:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35598 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1esjxZ-0001Ub-2l
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 01:50:57 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F5CA8D6C7
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 06:50:56 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon,  5 Mar 2018 14:50:34 +0800
Message-Id: <20180305065040.10353-4-peterx@redhat.com>
In-Reply-To: <20180305065040.10353-1-peterx@redhat.com>
References: <20180305065040.10353-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 3/9] chardev: update net listener gcontext
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

TCP chardevs can be using QIO network listeners working in the
background when in listening mode.  However the network listeners are
always running in main context.  This can race with chardevs that are
running in non-main contexts.

To solve this, we need to re-setup the net listeners in
tcp_chr_update_read_handler() with the newly cached gcontext.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 chardev/char-socket.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 205ee377a4..5aa01e15ff 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -422,8 +422,8 @@ static void tcp_chr_disconnect(Chardev *chr)
     tcp_chr_free_connection(chr);
 
     if (s->listener) {
-        qio_net_listener_set_client_func(s->listener, tcp_chr_accept,
-                                         chr, NULL);
+        qio_net_listener_set_client_func_full(s->listener, tcp_chr_accept,
+                                              chr, NULL, chr->gcontext);
     }
     update_disconnected_filename(s);
     if (emit_close) {
@@ -559,6 +559,16 @@ static void tcp_chr_update_read_handler(Chardev *chr)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
 
+    if (s->listener) {
+        /*
+         * It's possible that chardev context is changed in
+         * qemu_chr_be_update_read_handlers().  Reset it for QIO net
+         * listener if there is.
+         */
+        qio_net_listener_set_client_func_full(s->listener, tcp_chr_accept,
+                                              chr, NULL, chr->gcontext);
+    }
+
     if (!s->connected) {
         return;
     }
@@ -743,7 +753,8 @@ static int tcp_chr_new_client(Chardev *chr, QIOChannelSocket *sioc)
         qio_channel_set_delay(s->ioc, false);
     }
     if (s->listener) {
-        qio_net_listener_set_client_func(s->listener, NULL, NULL, NULL);
+        qio_net_listener_set_client_func_full(s->listener, NULL, NULL,
+                                              NULL, chr->gcontext);
     }
 
     if (s->tls_creds) {
@@ -824,7 +835,8 @@ static void char_socket_finalize(Object *obj)
     tcp_chr_reconn_timer_cancel(s);
     qapi_free_SocketAddress(s->addr);
     if (s->listener) {
-        qio_net_listener_set_client_func(s->listener, NULL, NULL, NULL);
+        qio_net_listener_set_client_func_full(s->listener, NULL, NULL,
+                                              NULL, chr->gcontext);
         object_unref(OBJECT(s->listener));
     }
     if (s->tls_creds) {
@@ -980,8 +992,10 @@ static void qmp_chardev_open_socket(Chardev *chr,
                 return;
             }
             if (!s->ioc) {
-                qio_net_listener_set_client_func(s->listener, tcp_chr_accept,
-                                                 chr, NULL);
+                qio_net_listener_set_client_func_full(s->listener,
+                                                      tcp_chr_accept,
+                                                      chr, NULL,
+                                                      chr->gcontext);
             }
         } else if (qemu_chr_wait_connected(chr, errp) < 0) {
             goto error;
-- 
2.14.3
