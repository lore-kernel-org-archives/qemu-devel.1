Received: from eggs.gnu.org ([2001:4830:134:3::10]:34179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1duukV-00060t-0n
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 02:14:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1duukT-0008D2-UE
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 02:14:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1duukT-0008BN-MC
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 02:14:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D5BA0356D6
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 06:14:08 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu, 21 Sep 2017 14:13:34 +0800
Message-Id: <1505974414-6033-5-git-send-email-peterx@redhat.com>
In-Reply-To: <1505974414-6033-1-git-send-email-peterx@redhat.com>
References: <1505974414-6033-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] chardev: remove context in
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, peterx@redhat.com, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

We had a per-chardev cache for context, then we don't need this
parameter to be passed in every time when chr_update_read_handler()
called.  As long as we are calling chr_update_read_handler() using
qemu_chr_be_update_read_handlers() we'll be fine.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 chardev/char-fd.c      | 3 +--
 chardev/char-pty.c     | 3 +--
 chardev/char-socket.c  | 3 +--
 chardev/char-udp.c     | 3 +--
 include/chardev/char.h | 2 +-
 5 files changed, 5 insertions(+), 9 deletions(-)

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
2.7.4
