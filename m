Received: from eggs.gnu.org ([2001:4830:134:3::10]:35980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxm9f-0005wk-89
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:40:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxm9a-0006mP-7c
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:39:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dxm9Z-0006lS-Vf
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:39:54 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 29 Sep 2017 11:38:32 +0800
Message-Id: <20170929033844.26935-11-peterx@redhat.com>
In-Reply-To: <20170929033844.26935-1-peterx@redhat.com>
References: <20170929033844.26935-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v2 10/22] monitor: allow to use IO thread for
 parsing
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
List-ID: <qemu-devel.nongnu.org>

For each Monitor, add one field "use_io_thr" to show whether it will be
using the dedicated monitor IO thread to handle input/output.  When set,
monitor IO parsing work will be offloaded to dedicated monitor IO
thread, rather than the original main loop thread.

This only works for QMP.  HMP will always be run on main loop thread.

Currently we're still keeping use_io_thr to off always.  Will turn it on
later at some point.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/monitor.c b/monitor.c
index b44e1f6c86..1d782afafb 100644
--- a/monitor.c
+++ b/monitor.c
@@ -191,6 +191,7 @@ struct Monitor {
     int flags;
     int suspend_cnt;
     bool skip_flush;
+    bool use_io_thr;
 
     QemuMutex out_lock;
     QString *outbuf;
@@ -575,7 +576,8 @@ static void monitor_qapi_event_init(void)
 
 static void handle_hmp_command(Monitor *mon, const char *cmdline);
 
-static void monitor_data_init(Monitor *mon, bool skip_flush)
+static void monitor_data_init(Monitor *mon, bool skip_flush,
+                              bool use_io_thr)
 {
     memset(mon, 0, sizeof(Monitor));
     qemu_mutex_init(&mon->out_lock);
@@ -583,6 +585,7 @@ static void monitor_data_init(Monitor *mon, bool skip_flush)
     /* Use *mon_cmds by default. */
     mon->cmd_table = mon_cmds;
     mon->skip_flush = skip_flush;
+    mon->use_io_thr = use_io_thr;
 }
 
 static void monitor_data_destroy(Monitor *mon)
@@ -602,7 +605,7 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
     char *output = NULL;
     Monitor *old_mon, hmp;
 
-    monitor_data_init(&hmp, true);
+    monitor_data_init(&hmp, true, false);
 
     old_mon = cur_mon;
     cur_mon = &hmp;
@@ -4122,8 +4125,9 @@ void error_vprintf_unless_qmp(const char *fmt, va_list ap)
 void monitor_init(Chardev *chr, int flags)
 {
     Monitor *mon = g_malloc(sizeof(*mon));
+    GMainContext *context;
 
-    monitor_data_init(mon, false);
+    monitor_data_init(mon, false, false);
 
     qemu_chr_fe_init(&mon->chr, chr, &error_abort);
     mon->flags = flags;
@@ -4135,19 +4139,37 @@ void monitor_init(Chardev *chr, int flags)
         monitor_read_command(mon, 0);
     }
 
+    if (mon->use_io_thr) {
+        /*
+         * When use_io_thr is set, we use the global shared dedicated
+         * IO thread for this monitor to handle input/output.
+         */
+        context = monitor_io_context_get();
+        /* We should have inited globals before reaching here. */
+        assert(context);
+    } else {
+        /* The default main loop, which is the main thread */
+        context = NULL;
+    }
+
+    /*
+     * Hang the monitor before running it (which is triggered by
+     * qemu_chr_fe_set_handlers).  Otherwise one monitor may run while
+     * find itself not on the mon_list.
+     */
+    qemu_mutex_lock(&monitor_lock);
+    QTAILQ_INSERT_HEAD(&mon_list, mon, entry);
+    qemu_mutex_unlock(&monitor_lock);
+
     if (monitor_is_qmp(mon)) {
         qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_qmp_read,
-                                 monitor_qmp_event, NULL, mon, NULL, true);
+                                 monitor_qmp_event, NULL, mon, context, true);
         qemu_chr_fe_set_echo(&mon->chr, true);
         json_message_parser_init(&mon->qmp.parser, handle_qmp_command, mon);
     } else {
         qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_read,
                                  monitor_event, NULL, mon, NULL, true);
     }
-
-    qemu_mutex_lock(&monitor_lock);
-    QLIST_INSERT_HEAD(&mon_list, mon, entry);
-    qemu_mutex_unlock(&monitor_lock);
 }
 
 static void monitor_io_thread_destroy(void)
-- 
2.13.5
