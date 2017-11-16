Received: from eggs.gnu.org ([2001:4830:134:3::10]:38373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eFJt4-0008G5-RG
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:07:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eFJt3-00078p-JT
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:07:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eFJt3-00078P-AM
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:07:21 -0500
From: Peter Xu <peterx@redhat.com>
Date: Thu, 16 Nov 2017 21:05:53 +0800
Message-Id: <20171116130610.23582-11-peterx@redhat.com>
In-Reply-To: <20171116130610.23582-1-peterx@redhat.com>
References: <20171116130610.23582-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v4 10/27] monitor: allow to use IO thread for
 parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

For each Monitor, add one field "use_io_thr" to show whether it will be
using the dedicated monitor IO thread to handle input/output.  When set,
monitor IO parsing work will be offloaded to dedicated monitor IO
thread, rather than the original main loop thread.

This only works for QMP.  HMP will always be run on main loop thread.

Currently we're still keeping use_io_thr to off always.  Will turn it on
later at some point.

One thing to mention is that we cannot set use_io_thr for every QMP
monitors.  The problem is that MUXed typed chardevs may not work well
with it now. When MUX is used, frontend of chardev can be the monitor
plus something else.  The only thing we know would be safe to be run
outside main thread so far is the monitor frontend. All the rest of the
frontends should still be run in main thread only.

Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/monitor.c b/monitor.c
index 4ce9828fab..685938b9f2 100644
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
@@ -603,7 +606,7 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
     char *output = NULL;
     Monitor *old_mon, hmp;
 
-    monitor_data_init(&hmp, true);
+    monitor_data_init(&hmp, true, false);
 
     old_mon = cur_mon;
     cur_mon = &hmp;
@@ -4104,8 +4107,9 @@ void error_vprintf_unless_qmp(const char *fmt, va_list ap)
 void monitor_init(Chardev *chr, int flags)
 {
     Monitor *mon = g_malloc(sizeof(*mon));
+    GMainContext *context;
 
-    monitor_data_init(mon, false);
+    monitor_data_init(mon, false, false);
 
     qemu_chr_fe_init(&mon->chr, chr, &error_abort);
     mon->flags = flags;
@@ -4117,19 +4121,37 @@ void monitor_init(Chardev *chr, int flags)
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
+     * Add the monitor before running it (which is triggered by
+     * qemu_chr_fe_set_handlers), otherwise one monitor may find
+     * itself not on the mon_list when running.
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
 
 void monitor_cleanup(void)
-- 
2.13.6
