Received: from eggs.gnu.org ([2001:4830:134:3::10]:57107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SMF-0006fM-Fj
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SM9-0006Ft-Uw
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:39 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g8SM9-00066X-AT
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:33 -0400
Received: by mail-wm1-x343.google.com with SMTP id 143-v6so2304750wmf.1
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 08:49:26 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  5 Oct 2018 16:49:03 +0100
Message-Id: <20181005154910.3099-15-alex.bennee@linaro.org>
In-Reply-To: <20181005154910.3099-1-alex.bennee@linaro.org>
References: <20181005154910.3099-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 14/21] trace: add support for plugin
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu, cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This patch adds support for dynamically loaded plugins. Every plugin
is a dynamic library with a set of optional exported functions that
will be called from QEMU.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
[AJB: moved to using trace point API]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
ajb
  - moved to tracepoint interface (bind_to_tracepoints)
  - now in trace/ and include/plugins/
---
 include/plugins/plugins.h |  14 ++++
 include/qemu/plugins.h    |  18 +++++
 qemu-options.hx           |  10 +++
 trace/Makefile.objs       |   1 +
 trace/plugins.c           | 139 ++++++++++++++++++++++++++++++++++++++
 vl.c                      |   8 +++
 6 files changed, 190 insertions(+)
 create mode 100644 include/plugins/plugins.h
 create mode 100644 include/qemu/plugins.h
 create mode 100644 trace/plugins.c

diff --git a/include/plugins/plugins.h b/include/plugins/plugins.h
new file mode 100644
index 0000000000..54ac53cb32
--- /dev/null
+++ b/include/plugins/plugins.h
@@ -0,0 +1,14 @@
+#ifndef PLUGINS_INTERFACE_H
+#define PLUGINS_INTERFACE_H
+
+#include <stdbool.h>
+#include <stdio.h>
+
+/* Mandatory Plugin interfaces */
+
+bool plugin_init(const char *args);
+char *plugin_status(void);
+
+/* Other optional hooks are defined by available trace-points */
+
+#endif /* PLUGINS_INTERFACE_H */
diff --git a/include/qemu/plugins.h b/include/qemu/plugins.h
new file mode 100644
index 0000000000..c86bb7ae67
--- /dev/null
+++ b/include/qemu/plugins.h
@@ -0,0 +1,18 @@
+#ifndef PLUGINS_H
+#define PLUGINS_H
+
+#ifdef CONFIG_TRACE_PLUGIN
+
+void qemu_plugin_parse_cmd_args(const char *optarg);
+void qemu_plugin_load(const char *filename, const char *args);
+void qemu_plugins_init(void);
+
+#else
+
+static inline void qemu_plugin_parse_cmd_args(const char *optarg) { }
+static inline void qemu_plugin_load(const char *filename, const char *args) { }
+static inline void qemu_plugins_init(void) { }
+
+#endif
+
+#endif /* PLUGINS_H */
diff --git a/qemu-options.hx b/qemu-options.hx
index f139459e80..87206dd79f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3892,6 +3892,16 @@ STEXI
 Enable synchronization profiling.
 ETEXI
 
+#ifdef CONFIG_TRACE_PLUGIN
+DEF("plugin", HAS_ARG, QEMU_OPTION_plugin, \
+           "-plugin file=<file>[,args=<args>] load <dso> plugin with <args>\n", QEMU_ARCH_ALL)
+STEXI
+@item -plugin file=@var{file}[,args=@var{args}]
+@findex -plugin
+Load @var{file} plugin passing @var{args} arguments.
+ETEXI
+#endif
+
 STEXI
 @end table
 ETEXI
diff --git a/trace/Makefile.objs b/trace/Makefile.objs
index afd571c3ec..4977f654a5 100644
--- a/trace/Makefile.objs
+++ b/trace/Makefile.objs
@@ -54,6 +54,7 @@ $(obj)/generated-tcg-tracers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/
 
 util-obj-$(CONFIG_TRACE_SIMPLE) += simple.o
 util-obj-$(CONFIG_TRACE_FTRACE) += ftrace.o
+util-obj-$(CONFIG_TRACE_PLUGIN) += plugins.o
 util-obj-y += control.o
 target-obj-y += control-target.o
 util-obj-y += qmp.o
diff --git a/trace/plugins.c b/trace/plugins.c
new file mode 100644
index 0000000000..25aec2ff70
--- /dev/null
+++ b/trace/plugins.c
@@ -0,0 +1,139 @@
+/*
+ * Plugin Support
+ *
+ *
+ * Copyright (c) 2018 Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
+ * Copyright (c) 2018 Alex Bennée <alex.bennee@linaro.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include <gmodule.h>
+#include "qemu-common.h"
+#include "qemu/error-report.h"
+#include "qemu/plugins.h"
+#include "qemu/queue.h"
+#include "qemu/option.h"
+#include "trace/control.h"
+
+typedef bool (*PluginInitFunc)(const char *);
+typedef char * (*PluginStatusFunc)(void);
+
+typedef struct QemuPluginInfo {
+    const char *filename;
+    const char *args;
+    GModule *g_module;
+
+    PluginInitFunc init;
+    PluginStatusFunc status;
+
+    GPtrArray *events;
+
+    QLIST_ENTRY(QemuPluginInfo) next;
+} QemuPluginInfo;
+
+static QLIST_HEAD(, QemuPluginInfo) qemu_plugins
+                                = QLIST_HEAD_INITIALIZER(qemu_plugins);
+
+static QemuOptsList qemu_plugin_opts = {
+    .name = "plugin",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_plugin_opts.head),
+    .desc = {
+        {
+            .name = "file",
+            .type = QEMU_OPT_STRING,
+        },{
+            .name = "args",
+            .type = QEMU_OPT_STRING,
+        },
+        { /* end of list */ }
+    },
+};
+
+void qemu_plugin_parse_cmd_args(const char *optarg)
+{
+    QemuOpts *opts = qemu_opts_parse_noisily(&qemu_plugin_opts, optarg, false);
+    qemu_plugin_load(qemu_opt_get(opts, "file"),
+                     qemu_opt_get(opts, "args"));
+}
+
+static int bind_to_tracepoints(GModule *g_module, GPtrArray *events)
+{
+    int count = 0;
+    TraceEventIter iter;
+    TraceEvent *ev;
+
+    trace_event_iter_init(&iter, "*");
+    while ((ev = trace_event_iter_next(&iter)) != NULL) {
+        const char *name = trace_event_get_name(ev);
+        gpointer fn;
+
+        if (g_module_symbol(g_module, name, &fn)) {
+            ev->plugin = (uintptr_t) fn;
+            trace_event_set_state_dynamic(ev, true);
+            count++;
+        }
+    }
+
+    return count;
+}
+
+void qemu_plugin_load(const char *filename, const char *args)
+{
+    GModule *g_module;
+    QemuPluginInfo *info = NULL;
+    if (!filename) {
+        error_report("plugin name was not specified");
+        return;
+    }
+    g_module = g_module_open(filename,
+        G_MODULE_BIND_LAZY | G_MODULE_BIND_LOCAL);
+    if (!g_module) {
+        error_report("can't load plugin '%s'", filename);
+        return;
+    }
+    info = g_new0(QemuPluginInfo, 1);
+    info->filename = g_strdup(filename);
+    info->g_module = g_module;
+
+    if (!g_module_symbol(g_module, "plugin_init",
+                         (gpointer *) &info->init)) {
+        error_report("all plugins must provide a plugin_init hook");
+        return;
+    }
+
+    if (!g_module_symbol(g_module, "plugin_status",
+                         (gpointer *) &info->status)) {
+        error_report("all plugins must provide a plugin_status hook");
+        return;
+    }
+
+    /* OK we can now see how many events might have bindings */
+    info->events = g_ptr_array_new();
+
+    if (bind_to_tracepoints(g_module, info->events) < 0) {
+        error_report("failed to bind any events");
+        return;
+    }
+
+    /* Save the args, we will initialise later on once everything is
+       set up */
+    if (args) {
+        info->args = g_strdup(args);
+    }
+
+    QLIST_INSERT_HEAD(&qemu_plugins, info, next);
+
+    return;
+}
+
+void qemu_plugins_init(void)
+{
+    QemuPluginInfo *info;
+    QLIST_FOREACH(info, &qemu_plugins, next) {
+        if (info->init) {
+            info->init(info->args);
+        }
+    }
+}
diff --git a/vl.c b/vl.c
index 795e025445..b46ef5032f 100644
--- a/vl.c
+++ b/vl.c
@@ -130,6 +130,7 @@ int main(int argc, char **argv)
 #include "qapi/qapi-commands-run-state.h"
 #include "qapi/qmp/qerror.h"
 #include "sysemu/iothread.h"
+#include "qemu/plugins.h"
 
 #define MAX_VIRTIO_CONSOLES 1
 
@@ -3884,6 +3885,11 @@ int main(int argc, char **argv, char **envp)
             case QEMU_OPTION_enable_sync_profile:
                 qsp_enable();
                 break;
+#ifdef CONFIG_TRACE_PLUGIN
+            case QEMU_OPTION_plugin:
+                qemu_plugin_parse_cmd_args(optarg);
+                break;
+#endif
             case QEMU_OPTION_nouserconfig:
                 /* Nothing to be parsed here. Especially, do not error out below. */
                 break;
@@ -4449,6 +4455,8 @@ int main(int argc, char **argv, char **envp)
     }
     parse_numa_opts(current_machine);
 
+    qemu_plugins_init();
+
     /* do monitor/qmp handling at preconfig state if requested */
     main_loop();
 
-- 
2.17.1
