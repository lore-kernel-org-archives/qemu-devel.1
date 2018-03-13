Received: from eggs.gnu.org ([2001:4830:134:3::10]:57867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evshm-0005Ss-FF
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evshl-0002vY-J8
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:38 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:54931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evshl-0002uV-CP
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:37 -0400
Received: by mail-wm0-x241.google.com with SMTP id h76so869688wme.4
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:47:37 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:22 +0100
Message-Id: <20180313224719.4954-13-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/69] chardev: update net listener gcontext
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

TCP chardevs can be using QIO network listeners working in the
background when in listening mode.  However the network listeners are
always running in main context.  This can race with chardevs that are
running in non-main contexts.

To solve this, we need to re-setup the net listeners in
tcp_chr_update_read_handler() with the newly cached gcontext.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180306053320.15401-4-peterx@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-socket.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 541fcf487d..2475e1d52f 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -423,8 +423,8 @@ static void tcp_chr_disconnect(Chardev *chr)
     tcp_chr_free_connection(chr);
 
     if (s->listener) {
-        qio_net_listener_set_client_func(s->listener, tcp_chr_accept,
-                                         chr, NULL);
+        qio_net_listener_set_client_func_full(s->listener, tcp_chr_accept,
+                                              chr, NULL, chr->gcontext);
     }
     update_disconnected_filename(s);
     if (emit_close) {
@@ -560,6 +560,16 @@ static void tcp_chr_update_read_handler(Chardev *chr)
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
@@ -744,7 +754,8 @@ static int tcp_chr_new_client(Chardev *chr, QIOChannelSocket *sioc)
         qio_channel_set_delay(s->ioc, false);
     }
     if (s->listener) {
-        qio_net_listener_set_client_func(s->listener, NULL, NULL, NULL);
+        qio_net_listener_set_client_func_full(s->listener, NULL, NULL,
+                                              NULL, chr->gcontext);
     }
 
     if (s->tls_creds) {
@@ -825,7 +836,8 @@ static void char_socket_finalize(Object *obj)
     tcp_chr_reconn_timer_cancel(s);
     qapi_free_SocketAddress(s->addr);
     if (s->listener) {
-        qio_net_listener_set_client_func(s->listener, NULL, NULL, NULL);
+        qio_net_listener_set_client_func_full(s->listener, NULL, NULL,
+                                              NULL, chr->gcontext);
         object_unref(OBJECT(s->listener));
     }
     if (s->tls_creds) {
@@ -981,8 +993,10 @@ static void qmp_chardev_open_socket(Chardev *chr,
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
