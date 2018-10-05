Received: from eggs.gnu.org ([2001:4830:134:3::10]:60109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SSH-0005zk-7S
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:55:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SSD-0004f2-Ji
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:55:53 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:52773)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g8SSD-0004ef-Cv
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:55:49 -0400
Received: by mail-wm1-x32b.google.com with SMTP id 189-v6so2331470wmw.2
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 08:55:49 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  5 Oct 2018 16:49:06 +0100
Message-Id: <20181005154910.3099-18-alex.bennee@linaro.org>
In-Reply-To: <20181005154910.3099-1-alex.bennee@linaro.org>
References: <20181005154910.3099-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 17/21] hmp: expose status of plugins to the
 monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu, cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hmp-commands-info.hx   | 17 +++++++++++++++++
 include/qemu/plugins.h |  1 +
 monitor.c              | 14 ++++++++++++++
 trace/plugins.c        | 15 +++++++++++++++
 4 files changed, 47 insertions(+)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index cbee8b944d..e245a852ae 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -683,6 +683,23 @@ STEXI
 Show available trace-events & their state.
 ETEXI
 
+#if defined(CONFIG_TRACE_PLUGIN)
+    {
+        .name       = "trace-plugins",
+        .args_type  = "name:s?",
+        .params     = "[name]",
+        .help       = "show available plugins and any extra info "
+                      "(name: plugin name pattern)",
+        .cmd = hmp_info_trace_plugins,
+    },
+
+STEXI
+@item info trace-plugins
+@findex info trace-plugins
+Show available trace-plugins & their state.
+ETEXI
+#endif
+
     {
         .name       = "tpm",
         .args_type  = "",
diff --git a/include/qemu/plugins.h b/include/qemu/plugins.h
index c86bb7ae67..44f2ec8c98 100644
--- a/include/qemu/plugins.h
+++ b/include/qemu/plugins.h
@@ -6,6 +6,7 @@
 void qemu_plugin_parse_cmd_args(const char *optarg);
 void qemu_plugin_load(const char *filename, const char *args);
 void qemu_plugins_init(void);
+GString *qemu_plugin_status(const char *name);
 
 #else
 
diff --git a/monitor.c b/monitor.c
index d8229cd2b0..0d0de9ece7 100644
--- a/monitor.c
+++ b/monitor.c
@@ -67,6 +67,9 @@
 #ifdef CONFIG_TRACE_SIMPLE
 #include "trace/simple.h"
 #endif
+#ifdef CONFIG_TRACE_PLUGIN
+#include "qemu/plugins.h"
+#endif
 #include "exec/memory.h"
 #include "exec/exec-all.h"
 #include "qemu/log.h"
@@ -1429,6 +1432,17 @@ static void hmp_info_trace_events(Monitor *mon, const QDict *qdict)
     qapi_free_TraceEventInfoList(events);
 }
 
+#ifdef CONFIG_TRACE_PLUGIN
+static void hmp_info_trace_plugins(Monitor *mon, const QDict *qdict)
+{
+    const char *name = qdict_get_try_str(qdict, "name");
+    GString *status = qemu_plugin_status(name);
+
+    monitor_printf(mon, "%s", status->str);
+    g_string_free(status, true);
+}
+#endif
+
 void qmp_client_migrate_info(const char *protocol, const char *hostname,
                              bool has_port, int64_t port,
                              bool has_tls_port, int64_t tls_port,
diff --git a/trace/plugins.c b/trace/plugins.c
index 25aec2ff70..05630b02e6 100644
--- a/trace/plugins.c
+++ b/trace/plugins.c
@@ -58,6 +58,21 @@ void qemu_plugin_parse_cmd_args(const char *optarg)
                      qemu_opt_get(opts, "args"));
 }
 
+GString *qemu_plugin_status(const char *name)
+{
+    QemuPluginInfo *info;
+    GString *status = g_string_new("");
+
+    QLIST_FOREACH(info, &qemu_plugins, next) {
+        if (info->status) {
+            char *pstatus = info->status();
+            g_string_append_printf(status, "%s: %s\n", info->filename, pstatus);
+            g_free(pstatus);
+        }
+    }
+    return status;
+}
+
 static int bind_to_tracepoints(GModule *g_module, GPtrArray *events)
 {
     int count = 0;
-- 
2.17.1
