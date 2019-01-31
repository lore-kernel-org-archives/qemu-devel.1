Received: from eggs.gnu.org ([209.51.188.92]:59324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gpIvF-0002cM-7L
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 15:26:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gpIvD-0008HI-MK
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 15:26:53 -0500
Received: from smtp52.i.mail.ru ([94.100.177.112]:51096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1gpIvC-0008GO-QO
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 15:26:51 -0500
From: Julia Suvorova <jusual@mail.ru>
Date: Thu, 31 Jan 2019 23:26:37 +0300
Message-Id: <20190131202637.4062-1-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH] monitor: Add whitelist support for QMP commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

The whitelist option allows to run a reduced monitor with a subset of
QMP commands. This allows the monitor to run in secure mode, which is
convenient for sending commands via the WebSocket monitor using the
web UI. This is planned to be done on micro:bit board.

The list of allowed commands should be written to a file, one per line.
The command line will look like this:
    -mon chardev_name,mode=control,whitelist=path_to_file

Signed-off-by: Julia Suvorova <jusual@mail.ru>
---
 chardev/char.c            |  2 +-
 gdbstub.c                 |  2 +-
 include/monitor/monitor.h |  2 +-
 monitor.c                 | 82 +++++++++++++++++++++++++++++++++++++--
 qemu-options.hx           |  8 +++-
 stubs/monitor.c           |  2 +-
 vl.c                      |  5 ++-
 7 files changed, 92 insertions(+), 11 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index ccba36bafb..9af8690806 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -726,7 +726,7 @@ Chardev *qemu_chr_new_noreplay(const char *label, const char *filename,
 
     if (qemu_opt_get_bool(opts, "mux", 0)) {
         assert(permit_mux_mon);
-        monitor_init(chr, MONITOR_USE_READLINE);
+        monitor_init(chr, MONITOR_USE_READLINE, NULL);
     }
 
 out:
diff --git a/gdbstub.c b/gdbstub.c
index 3129b5c284..a91a47e79b 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2542,7 +2542,7 @@ int gdbserver_start(const char *device)
         /* Initialize a monitor terminal for gdb */
         mon_chr = qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
                                    NULL, &error_abort);
-        monitor_init(mon_chr, 0);
+        monitor_init(mon_chr, 0, NULL);
     } else {
         qemu_chr_fe_deinit(&s->chr, true);
         mon_chr = s->mon_chr;
diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index c1b40a9cac..a0d7ad2ba2 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -19,7 +19,7 @@ extern __thread Monitor *cur_mon;
 bool monitor_cur_is_qmp(void);
 
 void monitor_init_globals(void);
-void monitor_init(Chardev *chr, int flags);
+void monitor_init(Chardev *chr, int flags, const char *whitelist_file);
 void monitor_cleanup(void);
 
 int monitor_suspend(Monitor *mon);
diff --git a/monitor.c b/monitor.c
index c09fa63940..a26ddf72bb 100644
--- a/monitor.c
+++ b/monitor.c
@@ -238,6 +238,7 @@ struct Monitor {
     guint out_watch;
     /* Read under either BQL or mon_lock, written with BQL+mon_lock.  */
     int mux_out;
+    GHashTable *whitelist;
 };
 
 /* Shared monitor I/O thread */
@@ -358,6 +359,22 @@ static void qmp_request_free(QMPRequest *req)
     g_free(req);
 }
 
+static void monitor_qmp_cleanup_commands(Monitor *mon)
+{
+    QmpCommand *cmd, *next_cmd;
+
+    if (!monitor_is_qmp(mon) ||
+        mon->qmp.commands == &qmp_cap_negotiation_commands) {
+        return;
+    }
+
+    QTAILQ_FOREACH_SAFE(cmd, mon->qmp.commands, node, next_cmd) {
+        QTAILQ_REMOVE(mon->qmp.commands, cmd, node);
+        g_free(cmd);
+    }
+    g_free(mon->qmp.commands);
+}
+
 /* Caller must hold mon->qmp.qmp_queue_lock */
 static void monitor_qmp_cleanup_req_queue_locked(Monitor *mon)
 {
@@ -739,6 +756,10 @@ static void monitor_data_destroy(Monitor *mon)
     qemu_mutex_destroy(&mon->qmp.qmp_queue_lock);
     monitor_qmp_cleanup_req_queue_locked(mon);
     g_queue_free(mon->qmp.qmp_requests);
+    if (mon->whitelist) {
+        g_hash_table_destroy(mon->whitelist);
+    }
+    monitor_qmp_cleanup_commands(mon);
 }
 
 char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
@@ -1242,10 +1263,28 @@ static bool qmp_caps_accept(Monitor *mon, QMPCapabilityList *list,
     return true;
 }
 
+static void monitor_copy_qmp_commands(Monitor *mon, QmpCommandList *cmds)
+{
+    QmpCommand *cmd;
+
+    mon->qmp.commands = g_malloc0(sizeof(*cmds));
+    QTAILQ_INIT(mon->qmp.commands);
+    QTAILQ_FOREACH(cmd, cmds, node) {
+        QmpCommand *new_cmd = g_memdup(cmd, sizeof(*cmd));
+
+        if (mon->whitelist) {
+            new_cmd->enabled = g_hash_table_contains(mon->whitelist,
+                                                     new_cmd->name);
+        }
+        QTAILQ_INSERT_TAIL(mon->qmp.commands, new_cmd, node);
+    }
+}
+
 void qmp_qmp_capabilities(bool has_enable, QMPCapabilityList *enable,
                           Error **errp)
 {
-    if (cur_mon->qmp.commands == &qmp_commands) {
+    if (cur_mon->qmp.commands &&
+        cur_mon->qmp.commands != &qmp_cap_negotiation_commands) {
         error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
                   "Capabilities negotiation is already complete, command "
                   "ignored");
@@ -1256,7 +1295,7 @@ void qmp_qmp_capabilities(bool has_enable, QMPCapabilityList *enable,
         return;
     }
 
-    cur_mon->qmp.commands = &qmp_commands;
+    monitor_copy_qmp_commands(cur_mon, &qmp_commands);
 }
 
 /* Set the current CPU defined by the user. Callers must hold BQL. */
@@ -2621,7 +2660,6 @@ static mon_cmd_t mon_cmds[] = {
 static const char *pch;
 static sigjmp_buf expr_env;
 
-
 static void GCC_FMT_ATTR(2, 3) QEMU_NORETURN
 expr_error(Monitor *mon, const char *fmt, ...)
 {
@@ -4562,7 +4600,32 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
     monitor_list_append(mon);
 }
 
-void monitor_init(Chardev *chr, int flags)
+static void process_whitelist_file(Monitor *mon, const char *whitelist_file)
+{
+    char cmd_name[256];
+    FILE *fd = fopen(whitelist_file, "r");
+
+    if (fd == NULL) {
+        error_report("Could not open whitelist file: %s", strerror(errno));
+        exit(1);
+    }
+
+    mon->whitelist = g_hash_table_new_full(g_str_hash,
+                                           g_str_equal,
+                                           g_free,
+                                           NULL);
+
+    g_hash_table_add(mon->whitelist, g_strdup("qmp_capabilities"));
+    g_hash_table_add(mon->whitelist, g_strdup("query-commands"));
+
+    while (fscanf(fd, "%255s", cmd_name) == 1) {
+        g_hash_table_add(mon->whitelist, g_strdup(cmd_name));
+    }
+
+    fclose(fd);
+}
+
+void monitor_init(Chardev *chr, int flags, const char *whitelist_file)
 {
     Monitor *mon = g_malloc(sizeof(*mon));
     bool use_readline = flags & MONITOR_USE_READLINE;
@@ -4583,6 +4646,14 @@ void monitor_init(Chardev *chr, int flags)
         monitor_read_command(mon, 0);
     }
 
+    if (whitelist_file) {
+        if (monitor_is_qmp(mon)) {
+            process_whitelist_file(mon, whitelist_file);
+        } else {
+            warn_report("HMP doesn't support whitelist option: file ignored");
+        }
+    }
+
     if (monitor_is_qmp(mon)) {
         qemu_chr_fe_set_echo(&mon->chr, true);
         json_message_parser_init(&mon->qmp.parser, handle_qmp_command,
@@ -4666,6 +4737,9 @@ QemuOptsList qemu_mon_opts = {
         },{
             .name = "pretty",
             .type = QEMU_OPT_BOOL,
+        },{
+            .name = "whitelist",
+            .type = QEMU_OPT_STRING,
         },
         { /* end of list */ }
     },
diff --git a/qemu-options.hx b/qemu-options.hx
index 521511ec13..e5d1b7dfb5 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3195,12 +3195,16 @@ Like -qmp but uses pretty JSON formatting.
 ETEXI
 
 DEF("mon", HAS_ARG, QEMU_OPTION_mon, \
-    "-mon [chardev=]name[,mode=readline|control][,pretty[=on|off]]\n", QEMU_ARCH_ALL)
+    "-mon [chardev=]name[,mode=readline|control][,pretty[=on|off]]" \
+    "[,whitelist=file]\n", QEMU_ARCH_ALL)
 STEXI
-@item -mon [chardev=]name[,mode=readline|control][,pretty[=on|off]]
+@item -mon [chardev=]name[,mode=readline|control][,pretty[=on|off]][,whitelist=@var{file}]
 @findex -mon
 Setup monitor on chardev @var{name}. @code{pretty} turns on JSON pretty printing
 easing human reading and debugging.
+The @code{whitelist} option disables all commands except those specified in
+@var{file}. The file must contain one command name per line. This option is only
+avaliable in 'control' mode.
 ETEXI
 
 DEF("debugcon", HAS_ARG, QEMU_OPTION_debugcon, \
diff --git a/stubs/monitor.c b/stubs/monitor.c
index 32bd7012c3..36725b8090 100644
--- a/stubs/monitor.c
+++ b/stubs/monitor.c
@@ -12,7 +12,7 @@ int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
     return -1;
 }
 
-void monitor_init(Chardev *chr, int flags)
+void monitor_init(Chardev *chr, int flags, const char *whitelist_file)
 {
 }
 
diff --git a/vl.c b/vl.c
index bc9fbec654..81278a0155 100644
--- a/vl.c
+++ b/vl.c
@@ -2337,6 +2337,7 @@ static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
     Chardev *chr;
     const char *chardev;
     const char *mode;
+    const char *whitelist_file;
     int flags;
 
     mode = qemu_opt_get(opts, "mode");
@@ -2366,7 +2367,9 @@ static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
         return -1;
     }
 
-    monitor_init(chr, flags);
+    whitelist_file = qemu_opt_get(opts, "whitelist");
+
+    monitor_init(chr, flags, whitelist_file);
     return 0;
 }
 
-- 
2.17.1
