Received: from eggs.gnu.org ([2001:4830:134:3::10]:37599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAik-0005FO-6R
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAih-0004ib-2V
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:26 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34319)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dvAig-0004hb-RW
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:22 -0400
Received: by mail-wm0-x244.google.com with SMTP id i131so6443022wma.1
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 16:17:22 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Sep 2017 01:16:40 +0200
Message-Id: <1506035800-30509-33-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
References: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 32/32] chardev: remove context in
 chr_update_read_handler
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

We had a per-chardev cache for context, then we don't need this
parameter to be passed in every time when chr_update_read_handler()
called.  As long as we are calling chr_update_read_handler() using
qemu_chr_be_update_read_handlers() we'll be fine.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1505975754-21555-5-git-send-email-peterx@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-fd.c      | 3 +--
 chardev/char-pty.c     | 3 +--
 chardev/char-socket.c  | 3 +--
 chardev/char-udp.c     | 3 +--
 chardev/char.c         | 2 +-
 include/chardev/char.h | 2 +-
 6 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/chardev/char-fd.c b/chardev/char-fd.c
index 09fbb07..2c9b2ce 100644
--- a/chardev/char-fd.c
+++ b/chardev/char-fd.c
@@ -84,8 +84,7 @@ static GSource *fd_chr_add_watch(Chardev *chr, GIOCondition cond)
     return qio_channel_create_watch(s->ioc_out, cond);
 }
 
-static void fd_chr_update_read_handler(Chardev *chr,
-                                       GMainContext *context)
+static void fd_chr_update_read_handler(Chardev *chr)
 {
     FDChardev *s = FD_CHARDEV(chr);
 
diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index d239c04..761ae6d 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -112,8 +112,7 @@ static void pty_chr_update_read_handler_locked(Chardev *chr)
     }
 }
 
-static void pty_chr_update_read_handler(Chardev *chr,
-                                        GMainContext *context)
+static void pty_chr_update_read_handler(Chardev *chr)
 {
     qemu_mutex_lock(&chr->chr_write_lock);
     pty_chr_update_read_handler_locked(chr);
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index ee71cbe..e65148f 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -521,8 +521,7 @@ static void tcp_chr_connect(void *opaque)
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
 }
 
-static void tcp_chr_update_read_handler(Chardev *chr,
-                                        GMainContext *context)
+static void tcp_chr_update_read_handler(Chardev *chr)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
 
diff --git a/chardev/char-udp.c b/chardev/char-udp.c
index 106dee1..d46ff7a 100644
--- a/chardev/char-udp.c
+++ b/chardev/char-udp.c
@@ -100,8 +100,7 @@ static gboolean udp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
     return TRUE;
 }
 
-static void udp_chr_update_read_handler(Chardev *chr,
-                                        GMainContext *context)
+static void udp_chr_update_read_handler(Chardev *chr)
 {
     UdpChardev *s = UDP_CHARDEV(chr);
 
diff --git a/chardev/char.c b/chardev/char.c
index 89eabea..2ae4f46 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -187,7 +187,7 @@ void qemu_chr_be_update_read_handlers(Chardev *s,
 
     s->gcontext = context;
     if (cc->chr_update_read_handler) {
-        cc->chr_update_read_handler(s, context);
+        cc->chr_update_read_handler(s);
     }
 }
 
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 84fb773..43aabcc 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -238,7 +238,7 @@ typedef struct ChardevClass {
     int (*chr_write)(Chardev *s, const uint8_t *buf, int len);
     int (*chr_sync_read)(Chardev *s, const uint8_t *buf, int len);
     GSource *(*chr_add_watch)(Chardev *s, GIOCondition cond);
-    void (*chr_update_read_handler)(Chardev *s, GMainContext *context);
+    void (*chr_update_read_handler)(Chardev *s);
     int (*chr_ioctl)(Chardev *s, int cmd, void *arg);
     int (*get_msgfds)(Chardev *s, int* fds, int num);
     int (*set_msgfds)(Chardev *s, int *fds, int num);
-- 
1.8.3.1
