Received: from eggs.gnu.org ([2001:4830:134:3::10]:45338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJZ-0000nr-3m
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJW-00060E-TY
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33606 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evSJW-000600-OM
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4D1B6814F0D2
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:36:50 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 12 Mar 2018 13:36:11 -0500
Message-Id: <20180312183628.394722-21-eblake@redhat.com>
In-Reply-To: <20180312183628.394722-1-eblake@redhat.com>
References: <20180312183628.394722-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 20/36] monitor: allow using IO thread for parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

From: Peter Xu <peterx@redhat.com>

For each Monitor, add one field "use_io_thr" to show whether it will be
using the dedicated monitor IO thread to handle input/output.  When set,
monitor IO parsing work will be offloaded to the dedicated monitor IO
thread, rather than the original main loop thread.

This only works for QMP.  HMP will always be run on the main loop
thread.

Currently we're still keeping use_io_thr off always.  Will turn it on
later at some point.

One thing to mention is that we cannot set use_io_thr for every QMP
monitor.  The problem is that MUXed typed chardevs may not work well
with it now. When MUX is used, frontend of chardev can be the monitor
plus something else.  The only thing we know would be safe to be run
outside main thread so far is the monitor frontend. All the rest of the
frontends should still be run in main thread only.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180309090006.10018-10-peterx@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 monitor.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 90 insertions(+), 8 deletions(-)

diff --git a/monitor.c b/monitor.c
index 63b93f83217..ce9f7fc8e8a 100644
--- a/monitor.c
+++ b/monitor.c
@@ -35,6 +35,7 @@
 #include "net/net.h"
 #include "net/slirp.h"
 #include "chardev/char-fe.h"
+#include "chardev/char-io.h"
 #include "ui/qemu-spice.h"
 #include "sysemu/numa.h"
 #include "monitor/monitor.h"
@@ -79,6 +80,7 @@
 #include "qapi/qapi-introspect.h"
 #include "sysemu/qtest.h"
 #include "sysemu/cpus.h"
+#include "sysemu/iothread.h"
 #include "qemu/cutils.h"

 #if defined(TARGET_S390X)
@@ -192,6 +194,7 @@ struct Monitor {
     int flags;
     int suspend_cnt;
     bool skip_flush;
+    bool use_io_thr;

     QemuMutex out_lock;
     QString *outbuf;
@@ -210,6 +213,11 @@ struct Monitor {
     QTAILQ_ENTRY(Monitor) entry;
 };

+/* Let's add monitor global variables to this struct. */
+static struct {
+    IOThread *mon_iothread;
+} mon_global;
+
 /* QMP checker flags */
 #define QMP_ACCEPT_UNKNOWNS 1

@@ -570,7 +578,8 @@ static void monitor_qapi_event_init(void)

 static void handle_hmp_command(Monitor *mon, const char *cmdline);

-static void monitor_data_init(Monitor *mon, bool skip_flush)
+static void monitor_data_init(Monitor *mon, bool skip_flush,
+                              bool use_io_thr)
 {
     memset(mon, 0, sizeof(Monitor));
     qemu_mutex_init(&mon->out_lock);
@@ -578,6 +587,7 @@ static void monitor_data_init(Monitor *mon, bool skip_flush)
     /* Use *mon_cmds by default. */
     mon->cmd_table = mon_cmds;
     mon->skip_flush = skip_flush;
+    mon->use_io_thr = use_io_thr;
 }

 static void monitor_data_destroy(Monitor *mon)
@@ -598,7 +608,7 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
     char *output = NULL;
     Monitor *old_mon, hmp;

-    monitor_data_init(&hmp, true);
+    monitor_data_init(&hmp, true, false);

     old_mon = cur_mon;
     cur_mon = &hmp;
@@ -3985,12 +3995,29 @@ static void sortcmdlist(void)
     qsort((void *)info_cmds, array_num, elem_size, compare_mon_cmd);
 }

+static GMainContext *monitor_get_io_context(void)
+{
+    return iothread_get_g_main_context(mon_global.mon_iothread);
+}
+
+static AioContext *monitor_get_aio_context(void)
+{
+    return iothread_get_aio_context(mon_global.mon_iothread);
+}
+
+static void monitor_iothread_init(void)
+{
+    mon_global.mon_iothread = iothread_create("mon_iothread",
+                                              &error_abort);
+}
+
 void monitor_init_globals(void)
 {
     monitor_init_qmp_commands();
     monitor_qapi_event_init();
     sortcmdlist();
     qemu_mutex_init(&monitor_lock);
+    monitor_iothread_init();
 }

 /* These functions just adapt the readline interface in a typesafe way.  We
@@ -4033,11 +4060,41 @@ void error_vprintf_unless_qmp(const char *fmt, va_list ap)
     }
 }

+static void monitor_list_append(Monitor *mon)
+{
+    qemu_mutex_lock(&monitor_lock);
+    QTAILQ_INSERT_HEAD(&mon_list, mon, entry);
+    qemu_mutex_unlock(&monitor_lock);
+}
+
+static void monitor_qmp_setup_handlers_bh(void *opaque)
+{
+    Monitor *mon = opaque;
+    GMainContext *context;
+
+    if (mon->use_io_thr) {
+        /*
+         * When use_io_thr is set, we use the global shared dedicated
+         * IO thread for this monitor to handle input/output.
+         */
+        context = monitor_get_io_context();
+        /* We should have inited globals before reaching here. */
+        assert(context);
+    } else {
+        /* The default main loop, which is the main thread */
+        context = NULL;
+    }
+
+    qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_qmp_read,
+                             monitor_qmp_event, NULL, mon, context, true);
+    monitor_list_append(mon);
+}
+
 void monitor_init(Chardev *chr, int flags)
 {
     Monitor *mon = g_malloc(sizeof(*mon));

-    monitor_data_init(mon, false);
+    monitor_data_init(mon, false, false);

     qemu_chr_fe_init(&mon->chr, chr, &error_abort);
     mon->flags = flags;
@@ -4050,24 +4107,46 @@ void monitor_init(Chardev *chr, int flags)
     }

     if (monitor_is_qmp(mon)) {
-        qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_qmp_read,
-                                 monitor_qmp_event, NULL, mon, NULL, true);
         qemu_chr_fe_set_echo(&mon->chr, true);
         json_message_parser_init(&mon->qmp.parser, handle_qmp_command);
+        if (mon->use_io_thr) {
+            /*
+             * We can't call qemu_chr_fe_set_handlers() directly here
+             * since during the procedure the chardev will be active
+             * and running in monitor iothread, while we'll still do
+             * something before returning from it, which is a possible
+             * race too.  To avoid that, we just create a BH to setup
+             * the handlers.
+             */
+            aio_bh_schedule_oneshot(monitor_get_aio_context(),
+                                    monitor_qmp_setup_handlers_bh, mon);
+            /* We'll add this to mon_list in the BH when setup done */
+            return;
+        } else {
+            qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read,
+                                     monitor_qmp_read, monitor_qmp_event,
+                                     NULL, mon, NULL, true);
+        }
     } else {
         qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_read,
                                  monitor_event, NULL, mon, NULL, true);
     }

-    qemu_mutex_lock(&monitor_lock);
-    QTAILQ_INSERT_HEAD(&mon_list, mon, entry);
-    qemu_mutex_unlock(&monitor_lock);
+    monitor_list_append(mon);
 }

 void monitor_cleanup(void)
 {
     Monitor *mon, *next;

+    /*
+     * We need to explicitly stop the iothread (but not destroy it),
+     * cleanup the monitor resources, then destroy the iothread since
+     * we need to unregister from chardev below in
+     * monitor_data_destroy(), and chardev is not thread-safe yet
+     */
+    iothread_stop(mon_global.mon_iothread);
+
     qemu_mutex_lock(&monitor_lock);
     QTAILQ_FOREACH_SAFE(mon, &mon_list, entry, next) {
         QTAILQ_REMOVE(&mon_list, mon, entry);
@@ -4075,6 +4154,9 @@ void monitor_cleanup(void)
         g_free(mon);
     }
     qemu_mutex_unlock(&monitor_lock);
+
+    iothread_destroy(mon_global.mon_iothread);
+    mon_global.mon_iothread = NULL;
 }

 QemuOptsList qemu_mon_opts = {
-- 
2.14.3
