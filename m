Received: from eggs.gnu.org ([2001:4830:134:3::10]:44519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimS8-0004KM-8Z
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimS5-0004u8-Fo
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:20 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:45168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimS5-0004ty-8N
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:17 -0500
Received: by mail-wr0-x241.google.com with SMTP id h9so17829663wre.12
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:17 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:23 +0100
Message-Id: <1517858941-5538-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/47] chardev: fix incorrect unref of source
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

glib reported error when pty chardev used:

$ ./qemu-system-x86_64 -chardev pty,id=foo -device isa-serial,chardev=foo
qemu-system-x86_64: -chardev pty,id=foo: char device redirected to /dev/pts/2 (label foo)
(qemu-system-x86_64:27885): GLib-CRITICAL **: g_source_unref: assertion 'source != NULL' failed
(qemu-system-x86_64:27885): GLib-CRITICAL **: g_source_unref: assertion 'source != NULL' failed

This patch fixes that.

Fixes: 2c716ba150 ("chardev: introduce qemu_chr_timeout_add_ms()")
CC: Paolo Bonzini <pbonzini@redhat.com>
Reported-by: Marc-AndrÃ© Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180118052049.31119-1-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-pty.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index 89315e6..68fd4e2 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -51,15 +51,32 @@ typedef struct {
 static void pty_chr_update_read_handler_locked(Chardev *chr);
 static void pty_chr_state(Chardev *chr, int connected);
 
+static void pty_chr_timer_cancel(PtyChardev *s)
+{
+    if (s->timer_src) {
+        g_source_destroy(s->timer_src);
+        g_source_unref(s->timer_src);
+        s->timer_src = NULL;
+    }
+}
+
+static void pty_chr_open_src_cancel(PtyChardev *s)
+{
+    if (s->open_source) {
+        g_source_destroy(s->open_source);
+        g_source_unref(s->open_source);
+        s->open_source = NULL;
+    }
+}
+
 static gboolean pty_chr_timer(gpointer opaque)
 {
     struct Chardev *chr = CHARDEV(opaque);
     PtyChardev *s = PTY_CHARDEV(opaque);
 
     qemu_mutex_lock(&chr->chr_write_lock);
-    s->timer_src = NULL;
-    g_source_unref(s->open_source);
-    s->open_source = NULL;
+    pty_chr_timer_cancel(s);
+    pty_chr_open_src_cancel(s);
     if (!s->connected) {
         /* Next poll ... */
         pty_chr_update_read_handler_locked(chr);
@@ -68,15 +85,6 @@ static gboolean pty_chr_timer(gpointer opaque)
     return FALSE;
 }
 
-static void pty_chr_timer_cancel(PtyChardev *s)
-{
-    if (s->timer_src) {
-        g_source_destroy(s->timer_src);
-        g_source_unref(s->timer_src);
-        s->timer_src = NULL;
-    }
-}
-
 /* Called with chr_write_lock held.  */
 static void pty_chr_rearm_timer(Chardev *chr, int ms)
 {
@@ -195,11 +203,7 @@ static void pty_chr_state(Chardev *chr, int connected)
     PtyChardev *s = PTY_CHARDEV(chr);
 
     if (!connected) {
-        if (s->open_source) {
-            g_source_destroy(s->open_source);
-            g_source_unref(s->open_source);
-            s->open_source = NULL;
-        }
+        pty_chr_open_src_cancel(s);
         remove_fd_in_watch(chr);
         s->connected = 0;
         /* (re-)connect poll interval for idle guests: once per second.
-- 
1.8.3.1
