Received: from eggs.gnu.org ([2001:4830:134:3::10]:46342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1djhO7-0001NF-F0
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 03:44:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1djhO2-00058p-Ho
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 03:44:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1djhO2-00057T-86
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 03:44:38 -0400
From: Peter Xu <peterx@redhat.com>
Date: Mon, 21 Aug 2017 15:44:20 +0800
Message-Id: <1503301464-27886-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1503301464-27886-1-git-send-email-peterx@redhat.com>
References: <1503301464-27886-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 2/6] monitor: allow monitor to create thread to
 poll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Firstly, introduce Monitor.use_thread, and set it for monitors that are
using non-mux typed backend chardev.  We only do this for monitors, so
mux-typed chardevs are not suitable (when it connects to, e.g., serials
and the monitor together).

When use_thread is set, we create standalone thread to poll the monitor
events, isolated from the main loop thread.  Here we still need to take
the BQL before dispatching the tasks since some of the monitor commands
are not allowed to execute without the protection of BQL.  Then this
gives us the chance to avoid taking the BQL for some monitor commands in
the future.

* Why this change?

We need these per-monitor threads to make sure we can have at least one
monitor that will never stuck (that can receive further monitor
commands).

* So when will monitors stuck?  And, how do they stuck?

After we have postcopy and remote page faults, it's simple to achieve a
stuck in the monitor (which is also a stuck in main loop thread):

(1) Monitor deadlock on BQL

As we may know, when postcopy is running on destination VM, the vcpu
threads can stuck merely any time as long as it tries to access an
uncopied guest page.  Meanwhile, when the stuck happens, it is possible
that the vcpu thread is holding the BQL.  If the page fault is not
handled quickly, you'll find that monitors stop working, which is trying
to take the BQL.

If the page fault cannot be handled correctly (one case is a paused
postcopy, when network is temporarily down), monitors will hang
forever.  Without current patch, that means the main loop hanged.  We'll
never find a way to talk to VM again.

(2) Monitor tries to run codes page-faulted vcpus

The HMP command "info cpus" is one of the good example - it tries to
kick all the vcpus and sync status from them.  However, if there is any
vcpu that stuck at an unhandled page fault, it can never achieve the
sync, then the HMP hangs.  Again, it hangs the main loop thread as well.

After either (1) or (2), we can see the deadlock problem:

- On one hand, if monitor hangs, we cannot do the postcopy recovery,
  because postcopy recovery needs user to specify new listening port on
  destination monitor.

- On the other hand, if we cannot recover the paused postcopy, then page
  faults cannot be serviced, and the monitors will possibly hang
  forever then.

* How this patch helps?

- Firstly, we'll have our own thread for each dedicated monitor (or say,
  the backend chardev is only used for monitor), so even main loop
  thread hangs (it is always possible), this monitor thread may still
  survive.

- Not all monitor commands need the BQL.  We can selectively take the
  BQL (depends on which command we are running) to avoid waiting on a
  page-faulted vcpu thread that has taken the BQL (this will be done in
  following up patches).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c           | 67 +++++++++++++++++++++++++++++++++++++++++++++++++----
 qapi/qmp-dispatch.c | 15 ++++++++++++
 2 files changed, 77 insertions(+), 5 deletions(-)

diff --git a/monitor.c b/monitor.c
index 7c90df7..18504ef 100644
--- a/monitor.c
+++ b/monitor.c
@@ -36,6 +36,7 @@
 #include "net/net.h"
 #include "net/slirp.h"
 #include "chardev/char-fe.h"
+#include "chardev/char-mux.h"
 #include "ui/qemu-spice.h"
 #include "sysemu/numa.h"
 #include "monitor/monitor.h"
@@ -190,6 +191,8 @@ struct Monitor {
     int flags;
     int suspend_cnt;
     bool skip_flush;
+    /* Whether the monitor wants to be polled in standalone thread */
+    bool use_thread;
 
     QemuMutex out_lock;
     QString *outbuf;
@@ -206,6 +209,11 @@ struct Monitor {
     mon_cmd_t *cmd_table;
     QLIST_HEAD(,mon_fd_t) fds;
     QLIST_ENTRY(Monitor) entry;
+
+    /* Only used when "use_thread" is used */
+    QemuThread mon_thread;
+    GMainContext *mon_context;
+    GMainLoop *mon_loop;
 };
 
 /* QMP checker flags */
@@ -568,7 +576,7 @@ static void monitor_qapi_event_init(void)
 
 static void handle_hmp_command(Monitor *mon, const char *cmdline);
 
-static void monitor_data_init(Monitor *mon, bool skip_flush)
+static void monitor_data_init(Monitor *mon, bool skip_flush, bool use_thread)
 {
     memset(mon, 0, sizeof(Monitor));
     qemu_mutex_init(&mon->out_lock);
@@ -576,6 +584,16 @@ static void monitor_data_init(Monitor *mon, bool skip_flush)
     /* Use *mon_cmds by default. */
     mon->cmd_table = mon_cmds;
     mon->skip_flush = skip_flush;
+    mon->use_thread = use_thread;
+    if (use_thread) {
+        /*
+         * For monitors that use isolated threads, they'll need their
+         * own GMainContext and GMainLoop.  Otherwise, these pointers
+         * will be NULL, which means the default context will be used.
+         */
+        mon->mon_context = g_main_context_new();
+        mon->mon_loop = g_main_loop_new(mon->mon_context, TRUE);
+    }
 }
 
 static void monitor_data_destroy(Monitor *mon)
@@ -587,6 +605,13 @@ static void monitor_data_destroy(Monitor *mon)
     g_free(mon->rs);
     QDECREF(mon->outbuf);
     qemu_mutex_destroy(&mon->out_lock);
+    if (mon->use_thread) {
+        /* Notify the per-monitor thread to quit. */
+        g_main_loop_quit(mon->mon_loop);
+        qemu_thread_join(&mon->mon_thread);
+        g_main_loop_unref(mon->mon_loop);
+        g_main_context_unref(mon->mon_context);
+    }
 }
 
 char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
@@ -595,7 +620,7 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
     char *output = NULL;
     Monitor *old_mon, hmp;
 
-    monitor_data_init(&hmp, true);
+    monitor_data_init(&hmp, true, false);
 
     old_mon = cur_mon;
     cur_mon = &hmp;
@@ -3101,6 +3126,11 @@ static void handle_hmp_command(Monitor *mon, const char *cmdline)
 {
     QDict *qdict;
     const mon_cmd_t *cmd;
+    /*
+     * If we haven't take the BQL (when called by per-monitor
+     * threads), we need to take care of the BQL on our own.
+     */
+    bool take_bql = !qemu_mutex_iothread_locked();
 
     trace_handle_hmp_command(mon, cmdline);
 
@@ -3116,7 +3146,16 @@ static void handle_hmp_command(Monitor *mon, const char *cmdline)
         return;
     }
 
+    if (take_bql) {
+        qemu_mutex_lock_iothread();
+    }
+
     cmd->cmd(mon, qdict);
+
+    if (take_bql) {
+        qemu_mutex_unlock_iothread();
+    }
+
     QDECREF(qdict);
 }
 
@@ -4086,6 +4125,15 @@ static void __attribute__((constructor)) monitor_lock_init(void)
     qemu_mutex_init(&monitor_lock);
 }
 
+static void *monitor_thread(void *data)
+{
+    Monitor *mon = data;
+
+    g_main_loop_run(mon->mon_loop);
+
+    return NULL;
+}
+
 void monitor_init(Chardev *chr, int flags)
 {
     static int is_first_init = 1;
@@ -4098,7 +4146,9 @@ void monitor_init(Chardev *chr, int flags)
     }
 
     mon = g_malloc(sizeof(*mon));
-    monitor_data_init(mon, false);
+
+    /* For non-mux typed monitors, we create dedicated threads. */
+    monitor_data_init(mon, false, !CHARDEV_IS_MUX(chr));
 
     qemu_chr_fe_init(&mon->chr, chr, &error_abort);
     mon->flags = flags;
@@ -4112,12 +4162,19 @@ void monitor_init(Chardev *chr, int flags)
 
     if (monitor_is_qmp(mon)) {
         qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_qmp_read,
-                                 monitor_qmp_event, NULL, mon, NULL, true);
+                                 monitor_qmp_event, NULL, mon,
+                                 mon->mon_context, true);
         qemu_chr_fe_set_echo(&mon->chr, true);
         json_message_parser_init(&mon->qmp.parser, handle_qmp_command);
     } else {
         qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_read,
-                                 monitor_event, NULL, mon, NULL, true);
+                                 monitor_event, NULL, mon,
+                                 mon->mon_context, true);
+    }
+
+    if (mon->use_thread) {
+        qemu_thread_create(&mon->mon_thread, chr->label, monitor_thread,
+                           mon, QEMU_THREAD_JOINABLE);
     }
 
     qemu_mutex_lock(&monitor_lock);
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 5ad36f8..3b6b224 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -19,6 +19,7 @@
 #include "qapi/qmp/qjson.h"
 #include "qapi-types.h"
 #include "qapi/qmp/qerror.h"
+#include "qemu/main-loop.h"
 
 static QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
 {
@@ -75,6 +76,11 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds, QObject *request,
     QDict *args, *dict;
     QmpCommand *cmd;
     QObject *ret = NULL;
+    /*
+     * If we haven't take the BQL (when called by per-monitor
+     * threads), we need to take care of the BQL on our own.
+     */
+    bool take_bql = !qemu_mutex_iothread_locked();
 
     dict = qmp_dispatch_check_obj(request, errp);
     if (!dict) {
@@ -101,7 +107,16 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds, QObject *request,
         QINCREF(args);
     }
 
+    if (take_bql) {
+        qemu_mutex_lock_iothread();
+    }
+
     cmd->fn(args, &ret, &local_err);
+
+    if (take_bql) {
+        qemu_mutex_unlock_iothread();
+    }
+
     if (local_err) {
         error_propagate(errp, local_err);
     } else if (cmd->options & QCO_NO_SUCCESS_RESP) {
-- 
2.7.4
