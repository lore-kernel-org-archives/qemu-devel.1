Received: from eggs.gnu.org ([2001:4830:134:3::10]:41471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYY-0007Bo-AK
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYX-0004T5-Cg
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:30 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxYX-0004Qx-6X
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:29 -0500
Received: by mail-wm0-x242.google.com with SMTP id 81so1969289wmb.1
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:31:29 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:30:31 +0100
Message-Id: <1515756676-3860-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 07/52] chardev: let g_idle_add() be with chardev
 gcontext
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

The idle task will be attached to main gcontext even if the chardev
backend is running in another gcontext.  Fix the only caller by
extending the g_idle_add() logic into the more powerful
g_source_attach().  It's basically g_idle_add_full() implementation, but
with the chardev's gcontext passed in.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180104141835.17987-3-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-pty.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index 761ae6d..8248e36 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -43,7 +43,7 @@ typedef struct {
     /* Protected by the Chardev chr_write_lock.  */
     int connected;
     guint timer_tag;
-    guint open_tag;
+    GSource *open_source;
 } PtyChardev;
 
 #define PTY_CHARDEV(obj) OBJECT_CHECK(PtyChardev, (obj), TYPE_CHARDEV_PTY)
@@ -58,7 +58,7 @@ static gboolean pty_chr_timer(gpointer opaque)
 
     qemu_mutex_lock(&chr->chr_write_lock);
     s->timer_tag = 0;
-    s->open_tag = 0;
+    s->open_source = NULL;
     if (!s->connected) {
         /* Next poll ... */
         pty_chr_update_read_handler_locked(chr);
@@ -183,7 +183,7 @@ static gboolean qemu_chr_be_generic_open_func(gpointer opaque)
     Chardev *chr = CHARDEV(opaque);
     PtyChardev *s = PTY_CHARDEV(opaque);
 
-    s->open_tag = 0;
+    s->open_source = NULL;
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
     return FALSE;
 }
@@ -194,9 +194,10 @@ static void pty_chr_state(Chardev *chr, int connected)
     PtyChardev *s = PTY_CHARDEV(chr);
 
     if (!connected) {
-        if (s->open_tag) {
-            g_source_remove(s->open_tag);
-            s->open_tag = 0;
+        if (s->open_source) {
+            g_source_destroy(s->open_source);
+            g_source_unref(s->open_source);
+            s->open_source = NULL;
         }
         remove_fd_in_watch(chr);
         s->connected = 0;
@@ -210,9 +211,13 @@ static void pty_chr_state(Chardev *chr, int connected)
             s->timer_tag = 0;
         }
         if (!s->connected) {
-            g_assert(s->open_tag == 0);
+            g_assert(s->open_source == NULL);
+            s->open_source = g_idle_source_new();
             s->connected = 1;
-            s->open_tag = g_idle_add(qemu_chr_be_generic_open_func, chr);
+            g_source_set_callback(s->open_source,
+                                  qemu_chr_be_generic_open_func,
+                                  chr, NULL);
+            g_source_attach(s->open_source, chr->gcontext);
         }
         if (!chr->gsource) {
             chr->gsource = io_add_watch_poll(chr, s->ioc,
-- 
1.8.3.1
