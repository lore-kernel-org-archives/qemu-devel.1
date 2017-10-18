Received: from eggs.gnu.org ([2001:4830:134:3::10]:35677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qxu-0003J0-72
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qxt-00020o-2A
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:06 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:55350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1e4qxs-00020J-Q3
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:04 -0400
Received: by mail-wr0-x242.google.com with SMTP id z99so3131120wrc.12
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 09:13:04 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Oct 2017 18:11:56 +0200
Message-Id: <1508343141-31835-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
References: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/29] char: don't skip client cleanup if
 'connected' flag is unset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: "Daniel P. Berrange" <berrange@redhat.com>

The tcp_chr_free_connection & tcp_chr_disconnect methods both
skip all of their cleanup work unless the 's->connected' flag
is set.  This flag is set when the incoming client connection
is ready to use. Crucially this is *after* the TLS handshake
has been completed. So if the TLS handshake fails and we try
to cleanup the failed client, all the cleanup is skipped as
's->connected' is still false.

The only important thing that should be skipped in this case
is sending of the CHR_EVENT_CLOSED, because we never got as
far as sending the corresponding CHR_EVENT_OPENED. Every other
bit of cleanup can be robust against being called even when
s->connected is false.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-Id: <20171005155057.7664-1-berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-socket.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index e65148f..53eda8e 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -332,10 +332,6 @@ static void tcp_chr_free_connection(Chardev *chr)
     SocketChardev *s = SOCKET_CHARDEV(chr);
     int i;
 
-    if (!s->connected) {
-        return;
-    }
-
     if (s->read_msgfds_num) {
         for (i = 0; i < s->read_msgfds_num; i++) {
             close(s->read_msgfds[i]);
@@ -394,22 +390,25 @@ static void update_disconnected_filename(SocketChardev *s)
                                          s->is_listen, s->is_telnet);
 }
 
+/* NB may be called even if tcp_chr_connect has not been
+ * reached, due to TLS or telnet initialization failure,
+ * so can *not* assume s->connected == true
+ */
 static void tcp_chr_disconnect(Chardev *chr)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
-
-    if (!s->connected) {
-        return;
-    }
+    bool emit_close = s->connected;
 
     tcp_chr_free_connection(chr);
 
-    if (s->listen_ioc) {
+    if (s->listen_ioc && s->listen_tag == 0) {
         s->listen_tag = qio_channel_add_watch(
             QIO_CHANNEL(s->listen_ioc), G_IO_IN, tcp_chr_accept, chr, NULL);
     }
     update_disconnected_filename(s);
-    qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
+    if (emit_close) {
+        qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
+    }
     if (s->reconnect_time) {
         qemu_chr_socket_restart_timer(chr);
     }
-- 
1.8.3.1
