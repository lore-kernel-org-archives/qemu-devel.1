Received: from eggs.gnu.org ([2001:4830:134:3::10]:54681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWYjL-0003vY-Bc
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 21:24:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWYjI-0001Mp-6H
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 21:24:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eWYjH-0001MO-Tc
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 21:24:32 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CFCED883B9
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 02:24:30 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  3 Jan 2018 10:24:18 +0800
Message-Id: <20180103022418.23165-1-peterx@redhat.com>
In-Reply-To: <20180103021456.22526-4-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2.1 3/3] chardev: introduce
 qemu_chr_timeout_add() and use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, marcandre.lureau@redhat.com

It's a replacement of g_timeout_add[_seconds]() for chardevs.  Chardevs
now can have dedicated gcontext, we should always bind chardev tasks
onto those gcontext rather than the default main context.  Since there
are quite a few of g_timeout_add[_seconds]() callers, a new function
qemu_chr_timeout_add() is introduced.

One thing to mention is that, terminal3270 is still always running on
main gcontext.  However let's convert that as well since it's still part
of chardev codes and in case one day we'll miss that when we move it out
of main gcontext too.

Signed-off-by: Peter Xu <peterx@redhat.com>
---

v2 -> v2.1: Sorry I forgot to do the move in char.h.  Did it in this
minor version.

 chardev/char-pty.c     |  9 ++-------
 chardev/char-socket.c  |  4 ++--
 chardev/char.c         | 20 ++++++++++++++++++++
 hw/char/terminal3270.c |  7 ++++---
 include/chardev/char.h |  3 +++
 5 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index dd17b1b823..cbd8ac5eb7 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -78,13 +78,8 @@ static void pty_chr_rearm_timer(Chardev *chr, int ms)
         s->timer_tag = 0;
     }
 
-    if (ms == 1000) {
-        name = g_strdup_printf("pty-timer-secs-%s", chr->label);
-        s->timer_tag = g_timeout_add_seconds(1, pty_chr_timer, chr);
-    } else {
-        name = g_strdup_printf("pty-timer-ms-%s", chr->label);
-        s->timer_tag = g_timeout_add(ms, pty_chr_timer, chr);
-    }
+    name = g_strdup_printf("pty-timer-ms-%s", chr->label);
+    s->timer_tag = qemu_chr_timeout_add(chr, ms, pty_chr_timer, chr);
     g_source_set_name_by_id(s->timer_tag, name);
     g_free(name);
 }
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 630a7f2995..5cca32f963 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -73,8 +73,8 @@ static void qemu_chr_socket_restart_timer(Chardev *chr)
     char *name;
 
     assert(s->connected == 0);
-    s->reconnect_timer = g_timeout_add_seconds(s->reconnect_time,
-                                               socket_reconnect_timeout, chr);
+    s->reconnect_timer = qemu_chr_timeout_add(chr, s->reconnect_time * 1000,
+                                              socket_reconnect_timeout, chr);
     name = g_strdup_printf("chardev-socket-reconnect-%s", chr->label);
     g_source_set_name_by_id(s->reconnect_timer, name);
     g_free(name);
diff --git a/chardev/char.c b/chardev/char.c
index 8c3765ee99..a1de662fec 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -1084,6 +1084,26 @@ void qmp_chardev_send_break(const char *id, Error **errp)
     qemu_chr_be_event(chr, CHR_EVENT_BREAK);
 }
 
+/*
+ * Add a timeout callback for the chardev (in milliseconds). Please
+ * use this to add timeout hook for chardev instead of g_timeout_add()
+ * and g_timeout_add_seconds(), to make sure the gcontext that the
+ * task bound to is correct.
+ */
+guint qemu_chr_timeout_add(Chardev *chr, guint ms, GSourceFunc func,
+                           void *private)
+{
+    GSource *source = g_timeout_source_new(ms);
+    guint id;
+
+    assert(func);
+    g_source_set_callback(source, func, private, NULL);
+    id = g_source_attach(source, chr->gcontext);
+    g_source_unref(source);
+
+    return id;
+}
+
 void qemu_chr_cleanup(void)
 {
     object_unparent(get_chardevs_root());
diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
index a109ce5987..250137b78b 100644
--- a/hw/char/terminal3270.c
+++ b/hw/char/terminal3270.c
@@ -94,8 +94,8 @@ static void terminal_read(void *opaque, const uint8_t *buf, int size)
         g_source_remove(t->timer_tag);
         t->timer_tag = 0;
     }
-    t->timer_tag = g_timeout_add_seconds(600, send_timing_mark_cb, t);
-
+    t->timer_tag = qemu_chr_timeout_add(t->chr.chr, 600 * 1000,
+                                        send_timing_mark_cb, t);
     memcpy(&t->inv[t->in_len], buf, size);
     t->in_len += size;
     if (t->in_len < 2) {
@@ -157,7 +157,8 @@ static void chr_event(void *opaque, int event)
          * char-socket.c. Once qemu receives the terminal-type of the
          * client, mark handshake done and trigger everything rolling again.
          */
-        t->timer_tag = g_timeout_add_seconds(600, send_timing_mark_cb, t);
+        t->timer_tag = qemu_chr_timeout_add(t->chr.chr, 600 * 1000,
+                                            send_timing_mark_cb, t);
         break;
     case CHR_EVENT_CLOSED:
         sch->curr_status.scsw.dstat = SCSW_DSTAT_DEVICE_END;
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 778d610295..7f71f0def0 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -256,6 +256,9 @@ Chardev *qemu_chardev_new(const char *id, const char *typename,
 
 extern int term_escape_char;
 
+guint qemu_chr_timeout_add(Chardev *chr, guint ms, GSourceFunc func,
+                           void *private);
+
 /* console.c */
 void qemu_chr_parse_vc(QemuOpts *opts, ChardevBackend *backend, Error **errp);
 
-- 
2.14.3
