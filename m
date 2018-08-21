Received: from eggs.gnu.org ([2001:4830:134:3::10]:33973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4y-0002Se-5H
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4s-0007J0-I9
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:25 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:53040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4r-0007Ha-Vk
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:22 -0400
Received: by mail-wm0-x22b.google.com with SMTP id y139-v6so855764wmc.2
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:04:21 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:02:45 +0200
Message-Id: <1534870966-9287-74-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 73/74] char-socket: update all ioc handlers when
 changing context
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

So far, tcp_chr_update_read_handler() only updated the read
handler. Let's also update the hup handler.

Factorize the code while at it. (note that s->ioc != NULL when
s->connected)

Signed-off-by: Marc-AndrÃ© Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180817135224.22971-4-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-socket.c | 59 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 14f6567..7cd0ae2 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -353,6 +353,15 @@ static GSource *tcp_chr_add_watch(Chardev *chr, GIOCondition cond)
     return qio_channel_create_watch(s->ioc, cond);
 }
 
+static void remove_hup_source(SocketChardev *s)
+{
+    if (s->hup_source != NULL) {
+        g_source_destroy(s->hup_source);
+        g_source_unref(s->hup_source);
+        s->hup_source = NULL;
+    }
+}
+
 static void tcp_chr_free_connection(Chardev *chr)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
@@ -367,11 +376,7 @@ static void tcp_chr_free_connection(Chardev *chr)
         s->read_msgfds_num = 0;
     }
 
-    if (s->hup_source != NULL) {
-        g_source_destroy(s->hup_source);
-        g_source_unref(s->hup_source);
-        s->hup_source = NULL;
-    }
+    remove_hup_source(s);
 
     tcp_set_msgfds(chr, NULL, 0);
     remove_fd_in_watch(chr);
@@ -540,6 +545,27 @@ static char *sockaddr_to_str(struct sockaddr_storage *ss, socklen_t ss_len,
     }
 }
 
+static void update_ioc_handlers(SocketChardev *s)
+{
+    Chardev *chr = CHARDEV(s);
+
+    if (!s->connected) {
+        return;
+    }
+
+    remove_fd_in_watch(chr);
+    chr->gsource = io_add_watch_poll(chr, s->ioc,
+                                     tcp_chr_read_poll,
+                                     tcp_chr_read, chr,
+                                     chr->gcontext);
+
+    remove_hup_source(s);
+    s->hup_source = qio_channel_create_watch(s->ioc, G_IO_HUP);
+    g_source_set_callback(s->hup_source, (GSourceFunc)tcp_chr_hup,
+                          chr, NULL);
+    g_source_attach(s->hup_source, chr->gcontext);
+}
+
 static void tcp_chr_connect(void *opaque)
 {
     Chardev *chr = CHARDEV(opaque);
@@ -552,16 +578,7 @@ static void tcp_chr_connect(void *opaque)
         s->is_listen, s->is_telnet);
 
     s->connected = 1;
-    chr->gsource = io_add_watch_poll(chr, s->ioc,
-                                       tcp_chr_read_poll,
-                                       tcp_chr_read,
-                                       chr, chr->gcontext);
-
-    s->hup_source = qio_channel_create_watch(s->ioc, G_IO_HUP);
-    g_source_set_callback(s->hup_source, (GSourceFunc)tcp_chr_hup,
-                          chr, NULL);
-    g_source_attach(s->hup_source, chr->gcontext);
-
+    update_ioc_handlers(s);
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
 }
 
@@ -592,17 +609,7 @@ static void tcp_chr_update_read_handler(Chardev *chr)
         tcp_chr_telnet_init(CHARDEV(s));
     }
 
-    if (!s->connected) {
-        return;
-    }
-
-    remove_fd_in_watch(chr);
-    if (s->ioc) {
-        chr->gsource = io_add_watch_poll(chr, s->ioc,
-                                           tcp_chr_read_poll,
-                                           tcp_chr_read, chr,
-                                           chr->gcontext);
-    }
+    update_ioc_handlers(s);
 }
 
 static gboolean tcp_chr_telnet_init_io(QIOChannel *ioc,
-- 
1.8.3.1
