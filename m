Received: from eggs.gnu.org ([2001:4830:134:3::10]:41508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYa-0007Dx-CL
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYY-0004WR-Q0
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:32 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:44846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxYY-0004Uh-Fg
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:30 -0500
Received: by mail-wm0-x230.google.com with SMTP id t8so11395251wmc.3
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:31:30 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:30:32 +0100
Message-Id: <1515756676-3860-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 08/52] chardev: introduce
 qemu_chr_timeout_add_ms()
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

It's a replacement of g_timeout_add[_seconds]() for chardevs.  Chardevs
now can have dedicated gcontext, we should always bind chardev tasks
onto those gcontext rather than the default main context.  Since there
are quite a few of g_timeout_add[_seconds]() callers, a new function
qemu_chr_timeout_add_ms() is introduced.

One thing to mention is that, terminal3270 is still always running on
main gcontext.  However let's convert that as well since it's still part
of chardev codes and in case one day we'll miss that when we move it out
of main gcontext too.

Also, convert all the timers from GSource tags into GSource pointers.
Gsource tag IDs and g_source_remove()s can only work with default
gcontext, while now these GSources can logically be attached to other
contexts.  So let's use explicit g_source_destroy() plus another
g_source_unref() to remove a timer.

Note: when in the timer handler, we don't need the g_source_destroy()
any more since that'll be done automatically if the timer handler
returns false (and that's what all the current handlers do).

Yet another note: in pty_chr_rearm_timer() we take special care for
ms=1000.  This patch merged the two cases into one.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180104141835.17987-4-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-pty.c     | 43 +++++++++++++++++++------------------------
 chardev/char-socket.c  | 28 ++++++++++++++++++----------
 chardev/char.c         | 18 ++++++++++++++++++
 hw/char/terminal3270.c | 28 ++++++++++++++++------------
 include/chardev/char.h |  3 +++
 5 files changed, 74 insertions(+), 46 deletions(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index 8248e36..89315e6 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -42,7 +42,7 @@ typedef struct {
 
     /* Protected by the Chardev chr_write_lock.  */
     int connected;
-    guint timer_tag;
+    GSource *timer_src;
     GSource *open_source;
 } PtyChardev;
 
@@ -57,7 +57,8 @@ static gboolean pty_chr_timer(gpointer opaque)
     PtyChardev *s = PTY_CHARDEV(opaque);
 
     qemu_mutex_lock(&chr->chr_write_lock);
-    s->timer_tag = 0;
+    s->timer_src = NULL;
+    g_source_unref(s->open_source);
     s->open_source = NULL;
     if (!s->connected) {
         /* Next poll ... */
@@ -67,25 +68,25 @@ static gboolean pty_chr_timer(gpointer opaque)
     return FALSE;
 }
 
+static void pty_chr_timer_cancel(PtyChardev *s)
+{
+    if (s->timer_src) {
+        g_source_destroy(s->timer_src);
+        g_source_unref(s->timer_src);
+        s->timer_src = NULL;
+    }
+}
+
 /* Called with chr_write_lock held.  */
 static void pty_chr_rearm_timer(Chardev *chr, int ms)
 {
     PtyChardev *s = PTY_CHARDEV(chr);
     char *name;
 
-    if (s->timer_tag) {
-        g_source_remove(s->timer_tag);
-        s->timer_tag = 0;
-    }
-
-    if (ms == 1000) {
-        name = g_strdup_printf("pty-timer-secs-%s", chr->label);
-        s->timer_tag = g_timeout_add_seconds(1, pty_chr_timer, chr);
-    } else {
-        name = g_strdup_printf("pty-timer-ms-%s", chr->label);
-        s->timer_tag = g_timeout_add(ms, pty_chr_timer, chr);
-    }
-    g_source_set_name_by_id(s->timer_tag, name);
+    pty_chr_timer_cancel(s);
+    name = g_strdup_printf("pty-timer-%s", chr->label);
+    s->timer_src = qemu_chr_timeout_add_ms(chr, ms, pty_chr_timer, chr);
+    g_source_set_name(s->timer_src, name);
     g_free(name);
 }
 
@@ -206,10 +207,7 @@ static void pty_chr_state(Chardev *chr, int connected)
          * the virtual device linked to our pty. */
         pty_chr_rearm_timer(chr, 1000);
     } else {
-        if (s->timer_tag) {
-            g_source_remove(s->timer_tag);
-            s->timer_tag = 0;
-        }
+        pty_chr_timer_cancel(s);
         if (!s->connected) {
             g_assert(s->open_source == NULL);
             s->open_source = g_idle_source_new();
@@ -236,10 +234,7 @@ static void char_pty_finalize(Object *obj)
     qemu_mutex_lock(&chr->chr_write_lock);
     pty_chr_state(chr, 0);
     object_unref(OBJECT(s->ioc));
-    if (s->timer_tag) {
-        g_source_remove(s->timer_tag);
-        s->timer_tag = 0;
-    }
+    pty_chr_timer_cancel(s);
     qemu_mutex_unlock(&chr->chr_write_lock);
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
@@ -272,7 +267,7 @@ static void char_pty_open(Chardev *chr,
     name = g_strdup_printf("chardev-pty-%s", chr->label);
     qio_channel_set_name(QIO_CHANNEL(s->ioc), name);
     g_free(name);
-    s->timer_tag = 0;
+    s->timer_src = NULL;
     *be_opened = false;
 }
 
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 630a7f2..77cdf48 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -57,7 +57,7 @@ typedef struct {
     bool is_telnet;
     bool is_tn3270;
 
-    guint reconnect_timer;
+    GSource *reconnect_timer;
     int64_t reconnect_time;
     bool connect_err_reported;
 } SocketChardev;
@@ -67,16 +67,27 @@ typedef struct {
 
 static gboolean socket_reconnect_timeout(gpointer opaque);
 
+static void tcp_chr_reconn_timer_cancel(SocketChardev *s)
+{
+    if (s->reconnect_timer) {
+        g_source_destroy(s->reconnect_timer);
+        g_source_unref(s->reconnect_timer);
+        s->reconnect_timer = NULL;
+    }
+}
+
 static void qemu_chr_socket_restart_timer(Chardev *chr)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
     char *name;
 
     assert(s->connected == 0);
-    s->reconnect_timer = g_timeout_add_seconds(s->reconnect_time,
-                                               socket_reconnect_timeout, chr);
     name = g_strdup_printf("chardev-socket-reconnect-%s", chr->label);
-    g_source_set_name_by_id(s->reconnect_timer, name);
+    s->reconnect_timer = qemu_chr_timeout_add_ms(chr,
+                                                 s->reconnect_time * 1000,
+                                                 socket_reconnect_timeout,
+                                                 chr);
+    g_source_set_name(s->reconnect_timer, name);
     g_free(name);
 }
 
@@ -781,11 +792,7 @@ static void char_socket_finalize(Object *obj)
     SocketChardev *s = SOCKET_CHARDEV(obj);
 
     tcp_chr_free_connection(chr);
-
-    if (s->reconnect_timer) {
-        g_source_remove(s->reconnect_timer);
-        s->reconnect_timer = 0;
-    }
+    tcp_chr_reconn_timer_cancel(s);
     qapi_free_SocketAddress(s->addr);
     if (s->listener) {
         qio_net_listener_set_client_func(s->listener, NULL, NULL, NULL);
@@ -824,7 +831,8 @@ static gboolean socket_reconnect_timeout(gpointer opaque)
     SocketChardev *s = SOCKET_CHARDEV(opaque);
     QIOChannelSocket *sioc;
 
-    s->reconnect_timer = 0;
+    g_source_unref(s->reconnect_timer);
+    s->reconnect_timer = NULL;
 
     if (chr->be_open) {
         return false;
diff --git a/chardev/char.c b/chardev/char.c
index 8c3765e..3e14de1 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -1084,6 +1084,24 @@ void qmp_chardev_send_break(const char *id, Error **errp)
     qemu_chr_be_event(chr, CHR_EVENT_BREAK);
 }
 
+/*
+ * Add a timeout callback for the chardev (in milliseconds), return
+ * the GSource object created. Please use this to add timeout hook for
+ * chardev instead of g_timeout_add() and g_timeout_add_seconds(), to
+ * make sure the gcontext that the task bound to is correct.
+ */
+GSource *qemu_chr_timeout_add_ms(Chardev *chr, guint ms,
+                                 GSourceFunc func, void *private)
+{
+    GSource *source = g_timeout_source_new(ms);
+
+    assert(func);
+    g_source_set_callback(source, func, private, NULL);
+    g_source_attach(source, chr->gcontext);
+
+    return source;
+}
+
 void qemu_chr_cleanup(void)
 {
     object_unparent(get_chardevs_root());
diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
index a109ce5..e9c45e5 100644
--- a/hw/char/terminal3270.c
+++ b/hw/char/terminal3270.c
@@ -31,7 +31,7 @@ typedef struct Terminal3270 {
     uint8_t outv[OUTPUT_BUFFER_SIZE];
     int in_len;
     bool handshake_done;
-    guint timer_tag;
+    GSource *timer_src;
 } Terminal3270;
 
 #define TYPE_TERMINAL_3270 "x-terminal3270"
@@ -45,6 +45,15 @@ static int terminal_can_read(void *opaque)
     return INPUT_BUFFER_SIZE - t->in_len;
 }
 
+static void terminal_timer_cancel(Terminal3270 *t)
+{
+    if (t->timer_src) {
+        g_source_destroy(t->timer_src);
+        g_source_unref(t->timer_src);
+        t->timer_src = NULL;
+    }
+}
+
 /*
  * Protocol handshake done,
  * signal guest by an unsolicited DE irq.
@@ -90,12 +99,9 @@ static void terminal_read(void *opaque, const uint8_t *buf, int size)
 
     assert(size <= (INPUT_BUFFER_SIZE - t->in_len));
 
-    if (t->timer_tag) {
-        g_source_remove(t->timer_tag);
-        t->timer_tag = 0;
-    }
-    t->timer_tag = g_timeout_add_seconds(600, send_timing_mark_cb, t);
-
+    terminal_timer_cancel(t);
+    t->timer_src = qemu_chr_timeout_add_ms(t->chr.chr, 600 * 1000,
+                                           send_timing_mark_cb, t);
     memcpy(&t->inv[t->in_len], buf, size);
     t->in_len += size;
     if (t->in_len < 2) {
@@ -145,10 +151,7 @@ static void chr_event(void *opaque, int event)
     /* Ensure the initial status correct, always reset them. */
     t->in_len = 0;
     t->handshake_done = false;
-    if (t->timer_tag) {
-        g_source_remove(t->timer_tag);
-        t->timer_tag = 0;
-    }
+    terminal_timer_cancel(t);
 
     switch (event) {
     case CHR_EVENT_OPENED:
@@ -157,7 +160,8 @@ static void chr_event(void *opaque, int event)
          * char-socket.c. Once qemu receives the terminal-type of the
          * client, mark handshake done and trigger everything rolling again.
          */
-        t->timer_tag = g_timeout_add_seconds(600, send_timing_mark_cb, t);
+        t->timer_src = qemu_chr_timeout_add_ms(t->chr.chr, 600 * 1000,
+                                               send_timing_mark_cb, t);
         break;
     case CHR_EVENT_CLOSED:
         sch->curr_status.scsw.dstat = SCSW_DSTAT_DEVICE_END;
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 778d610..d8941fc 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -256,6 +256,9 @@ Chardev *qemu_chardev_new(const char *id, const char *typename,
 
 extern int term_escape_char;
 
+GSource *qemu_chr_timeout_add_ms(Chardev *chr, guint ms,
+                                 GSourceFunc func, void *private);
+
 /* console.c */
 void qemu_chr_parse_vc(QemuOpts *opts, ChardevBackend *backend, Error **errp);
 
-- 
1.8.3.1
