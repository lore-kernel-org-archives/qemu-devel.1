Received: from eggs.gnu.org ([2001:4830:134:3::10]:50187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDmRE-0002UR-FF
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:44:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDmRD-00083Y-BW
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:44:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40996 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fDmRD-00083D-7P
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:44:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C17DB84257
	for <qemu-devel@nongnu.org>; Wed,  2 May 2018 07:44:30 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  2 May 2018 15:44:18 +0800
Message-Id: <20180502074421.3762-2-peterx@redhat.com>
In-Reply-To: <20180502074421.3762-1-peterx@redhat.com>
References: <20180502074421.3762-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/4] monitor: rename out_lock to mon_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

The out_lock was only protecting a few Monitor fields.  In the future
the monitor code will start to run in multiple threads.  We turn it into
a bigger lock to protect not only the out buffer but also all the rest.
For now we share the lock.  We can split the lock when needed.

Since at it, arrange the Monitor struct a bit.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 53 +++++++++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/monitor.c b/monitor.c
index 39f8ee17ba..48882d28ae 100644
--- a/monitor.c
+++ b/monitor.c
@@ -207,15 +207,6 @@ struct Monitor {
     int suspend_cnt;            /* Needs to be accessed atomically */
     bool skip_flush;
     bool use_io_thr;
-
-    /* We can't access guest memory when holding the lock */
-    QemuMutex out_lock;
-    QString *outbuf;
-    guint out_watch;
-
-    /* Read under either BQL or out_lock, written with BQL+out_lock.  */
-    int mux_out;
-
     ReadLineState *rs;
     MonitorQMP qmp;
     gchar *mon_cpu_path;
@@ -224,6 +215,20 @@ struct Monitor {
     mon_cmd_t *cmd_table;
     QLIST_HEAD(,mon_fd_t) fds;
     QTAILQ_ENTRY(Monitor) entry;
+
+    /*
+     * The per-monitor lock. We can't access guest memory when holding
+     * the lock.
+     */
+    QemuMutex mon_lock;
+
+    /*
+     * Fields that are protected by the per-monitor lock.
+     */
+    QString *outbuf;
+    guint out_watch;
+    /* Read under either BQL or mon_lock, written with BQL+mon_lock.  */
+    int mux_out;
 };
 
 /* Let's add monitor global variables to this struct. */
@@ -366,14 +371,14 @@ static gboolean monitor_unblocked(GIOChannel *chan, GIOCondition cond,
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
@@ -411,9 +416,9 @@ static void monitor_flush_locked(Monitor *mon)
 
 void monitor_flush(Monitor *mon)
 {
-    qemu_mutex_lock(&mon->out_lock);
+    qemu_mutex_lock(&mon->mon_lock);
     monitor_flush_locked(mon);
-    qemu_mutex_unlock(&mon->out_lock);
+    qemu_mutex_unlock(&mon->mon_lock);
 }
 
 /* flush at every end of line */
@@ -421,7 +426,7 @@ static void monitor_puts(Monitor *mon, const char *str)
 {
     char c;
 
-    qemu_mutex_lock(&mon->out_lock);
+    qemu_mutex_lock(&mon->mon_lock);
     for(;;) {
         c = *str++;
         if (c == '\0')
@@ -434,7 +439,7 @@ static void monitor_puts(Monitor *mon, const char *str)
             monitor_flush_locked(mon);
         }
     }
-    qemu_mutex_unlock(&mon->out_lock);
+    qemu_mutex_unlock(&mon->mon_lock);
 }
 
 void monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
@@ -728,7 +733,7 @@ static void monitor_data_init(Monitor *mon, bool skip_flush,
                               bool use_io_thr)
 {
     memset(mon, 0, sizeof(Monitor));
-    qemu_mutex_init(&mon->out_lock);
+    qemu_mutex_init(&mon->mon_lock);
     qemu_mutex_init(&mon->qmp.qmp_queue_lock);
     mon->outbuf = qstring_new();
     /* Use *mon_cmds by default. */
@@ -748,7 +753,7 @@ static void monitor_data_destroy(Monitor *mon)
     }
     readline_free(mon->rs);
     QDECREF(mon->outbuf);
-    qemu_mutex_destroy(&mon->out_lock);
+    qemu_mutex_destroy(&mon->mon_lock);
     qemu_mutex_destroy(&mon->qmp.qmp_queue_lock);
     monitor_qmp_cleanup_req_queue_locked(mon);
     monitor_qmp_cleanup_resp_queue_locked(mon);
@@ -780,13 +785,13 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
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
@@ -4383,9 +4388,9 @@ static void monitor_event(void *opaque, int event)
 
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
@@ -4405,9 +4410,9 @@ static void monitor_event(void *opaque, int event)
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
