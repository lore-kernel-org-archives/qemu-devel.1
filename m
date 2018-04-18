Received: from eggs.gnu.org ([2001:4830:134:3::10]:56335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f8izQ-0000Qb-DP
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 05:03:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f8izK-0005sE-3z
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 05:02:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53314 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f8izJ-0005rG-WA
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 05:02:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 93B948DC2E
	for <qemu-devel@nongnu.org>; Wed, 18 Apr 2018 09:02:47 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 18 Apr 2018 17:02:37 +0800
Message-Id: <20180418090239.13090-2-peterx@redhat.com>
In-Reply-To: <20180418090239.13090-1-peterx@redhat.com>
References: <20180418090239.13090-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/3] monitor: rename out_lock to mon_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

The out_lock was only protecting out buffers.  In the future the monitor
code will start to run in multiple threads.  We turn it into a bigger
lock to protect not only the out buffer but also all the rest.  We split
this lock until necessary.  So far I don't see a reason to complicate
lock usage for monitors.

Since at it, arrange the Monitor struct a bit.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/monitor.c b/monitor.c
index 39f8ee17ba..c93aa4e22b 100644
--- a/monitor.c
+++ b/monitor.c
@@ -202,20 +202,17 @@ typedef struct {
 
 struct Monitor {
     CharBackend chr;
+    /* We can't access guest memory when holding the lock */
+    QemuMutex mon_lock;
     int reset_seen;
     int flags;
     int suspend_cnt;            /* Needs to be accessed atomically */
     bool skip_flush;
     bool use_io_thr;
-
-    /* We can't access guest memory when holding the lock */
-    QemuMutex out_lock;
     QString *outbuf;
     guint out_watch;
-
-    /* Read under either BQL or out_lock, written with BQL+out_lock.  */
+    /* Read under either BQL or mon_lock, written with BQL+mon_lock.  */
     int mux_out;
-
     ReadLineState *rs;
     MonitorQMP qmp;
     gchar *mon_cpu_path;
@@ -366,14 +363,14 @@ static gboolean monitor_unblocked(GIOChannel *chan, GIOCondition cond,
 {
     Monitor *mon = opaque;
 
-    qemu_mutex_lock(&mon->out_lock);
+    qemu_mutex_lock(&mon->mon_lock);
     mon->out_watch = 0;
     monitor_flush_locked(mon);
-    qemu_mutex_unlock(&mon->out_lock);
+    qemu_mutex_unlock(&mon->mon_lock);
     return FALSE;
 }
 
-/* Called with mon->out_lock held.  */
+/* Called with mon->mon_lock held.  */
 static void monitor_flush_locked(Monitor *mon)
 {
     int rc;
@@ -411,9 +408,9 @@ static void monitor_flush_locked(Monitor *mon)
 
 void monitor_flush(Monitor *mon)
 {
-    qemu_mutex_lock(&mon->out_lock);
+    qemu_mutex_lock(&mon->mon_lock);
     monitor_flush_locked(mon);
-    qemu_mutex_unlock(&mon->out_lock);
+    qemu_mutex_unlock(&mon->mon_lock);
 }
 
 /* flush at every end of line */
@@ -421,7 +418,7 @@ static void monitor_puts(Monitor *mon, const char *str)
 {
     char c;
 
-    qemu_mutex_lock(&mon->out_lock);
+    qemu_mutex_lock(&mon->mon_lock);
     for(;;) {
         c = *str++;
         if (c == '\0')
@@ -434,7 +431,7 @@ static void monitor_puts(Monitor *mon, const char *str)
             monitor_flush_locked(mon);
         }
     }
-    qemu_mutex_unlock(&mon->out_lock);
+    qemu_mutex_unlock(&mon->mon_lock);
 }
 
 void monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
@@ -728,7 +725,7 @@ static void monitor_data_init(Monitor *mon, bool skip_flush,
                               bool use_io_thr)
 {
     memset(mon, 0, sizeof(Monitor));
-    qemu_mutex_init(&mon->out_lock);
+    qemu_mutex_init(&mon->mon_lock);
     qemu_mutex_init(&mon->qmp.qmp_queue_lock);
     mon->outbuf = qstring_new();
     /* Use *mon_cmds by default. */
@@ -748,7 +745,7 @@ static void monitor_data_destroy(Monitor *mon)
     }
     readline_free(mon->rs);
     QDECREF(mon->outbuf);
-    qemu_mutex_destroy(&mon->out_lock);
+    qemu_mutex_destroy(&mon->mon_lock);
     qemu_mutex_destroy(&mon->qmp.qmp_queue_lock);
     monitor_qmp_cleanup_req_queue_locked(mon);
     monitor_qmp_cleanup_resp_queue_locked(mon);
@@ -780,13 +777,13 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
     handle_hmp_command(&hmp, command_line);
     cur_mon = old_mon;
 
-    qemu_mutex_lock(&hmp.out_lock);
+    qemu_mutex_lock(&hmp.mon_lock);
     if (qstring_get_length(hmp.outbuf) > 0) {
         output = g_strdup(qstring_get_str(hmp.outbuf));
     } else {
         output = g_strdup("");
     }
-    qemu_mutex_unlock(&hmp.out_lock);
+    qemu_mutex_unlock(&hmp.mon_lock);
 
 out:
     monitor_data_destroy(&hmp);
@@ -4383,9 +4380,9 @@ static void monitor_event(void *opaque, int event)
 
     switch (event) {
     case CHR_EVENT_MUX_IN:
-        qemu_mutex_lock(&mon->out_lock);
+        qemu_mutex_lock(&mon->mon_lock);
         mon->mux_out = 0;
-        qemu_mutex_unlock(&mon->out_lock);
+        qemu_mutex_unlock(&mon->mon_lock);
         if (mon->reset_seen) {
             readline_restart(mon->rs);
             monitor_resume(mon);
@@ -4405,9 +4402,9 @@ static void monitor_event(void *opaque, int event)
         } else {
             atomic_inc(&mon->suspend_cnt);
         }
-        qemu_mutex_lock(&mon->out_lock);
+        qemu_mutex_lock(&mon->mon_lock);
         mon->mux_out = 1;
-        qemu_mutex_unlock(&mon->out_lock);
+        qemu_mutex_unlock(&mon->mon_lock);
         break;
 
     case CHR_EVENT_OPENED:
-- 
2.14.3
