Received: from eggs.gnu.org ([2001:4830:134:3::10]:45825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckReF-0000Ri-4V
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:36:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckRe7-0002yE-Op
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:36:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ckRe7-0002xE-Aq
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:36:03 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 73D8BC04B92E
	for <qemu-devel@nongnu.org>; Sun,  5 Mar 2017 08:36:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v258a1kA011147
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Sun, 5 Mar 2017 03:36:02 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Sun,  5 Mar 2017 09:35:36 +0100
Message-Id: <1488702958-24336-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1488702958-24336-1-git-send-email-armbru@redhat.com>
References: <1488702958-24336-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 05/27] qapi: Support multiple command
 registries per program
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The command registry encapsulates a single command list.  Give the
functions using it a parameter instead.  Define suitable command lists
in monitor, guest agent and test-qmp-commands.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1488544368-30622-6-git-send-email-armbru@redhat.com>
[Debugging turds buried]
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/qapi/qmp/dispatch.h | 22 ++++++++++++++--------
 monitor.c                   | 31 +++++++++++++++++--------------
 qapi/qmp-dispatch.c         |  9 +++++----
 qapi/qmp-registry.c         | 37 ++++++++++++++++++-------------------
 qga/commands.c              |  2 +-
 qga/guest-agent-core.h      |  2 ++
 qga/main.c                  | 19 ++++++++++---------
 scripts/qapi-commands.py    | 16 ++++++++++------
 tests/test-qmp-commands.c   | 12 +++++++-----
 9 files changed, 84 insertions(+), 66 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 57651ea..20578dc 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -34,18 +34,24 @@ typedef struct QmpCommand
     bool enabled;
 } QmpCommand;
 
-void qmp_register_command(const char *name, QmpCommandFunc *fn,
-                          QmpCommandOptions options);
-void qmp_unregister_command(const char *name);
-QmpCommand *qmp_find_command(const char *name);
-QObject *qmp_dispatch(QObject *request);
-void qmp_disable_command(const char *name);
-void qmp_enable_command(const char *name);
+typedef QTAILQ_HEAD(QmpCommandList, QmpCommand) QmpCommandList;
+
+void qmp_register_command(QmpCommandList *cmds, const char *name,
+                          QmpCommandFunc *fn, QmpCommandOptions options);
+void qmp_unregister_command(QmpCommandList *cmds, const char *name);
+QmpCommand *qmp_find_command(QmpCommandList *cmds, const char *name);
+QObject *qmp_dispatch(QmpCommandList *cmds, QObject *request);
+void qmp_disable_command(QmpCommandList *cmds, const char *name);
+void qmp_enable_command(QmpCommandList *cmds, const char *name);
+
 bool qmp_command_is_enabled(const QmpCommand *cmd);
 const char *qmp_command_name(const QmpCommand *cmd);
 bool qmp_has_success_response(const QmpCommand *cmd);
 QObject *qmp_build_error_object(Error *err);
+
 typedef void (*qmp_cmd_callback_fn)(QmpCommand *cmd, void *opaque);
-void qmp_for_each_command(qmp_cmd_callback_fn fn, void *opaque);
+
+void qmp_for_each_command(QmpCommandList *cmds, qmp_cmd_callback_fn fn,
+                          void *opaque);
 
 #endif
diff --git a/monitor.c b/monitor.c
index 53f5f5a..c7f7602 100644
--- a/monitor.c
+++ b/monitor.c
@@ -221,6 +221,8 @@ static int mon_refcount;
 static mon_cmd_t mon_cmds[];
 static mon_cmd_t info_cmds[];
 
+QmpCommandList qmp_commands;
+
 Monitor *cur_mon;
 
 static QEMUClockType event_clock_type = QEMU_CLOCK_REALTIME;
@@ -919,7 +921,7 @@ CommandInfoList *qmp_query_commands(Error **errp)
 {
     CommandInfoList *list = NULL;
 
-    qmp_for_each_command(query_commands_cb, &list);
+    qmp_for_each_command(&qmp_commands, query_commands_cb, &list);
 
     return list;
 }
@@ -973,39 +975,40 @@ static void qmp_query_qmp_schema(QDict *qdict, QObject **ret_data,
 static void qmp_unregister_commands_hack(void)
 {
 #ifndef CONFIG_SPICE
-    qmp_unregister_command("query-spice");
+    qmp_unregister_command(&qmp_commands, "query-spice");
 #endif
 #ifndef TARGET_I386
-    qmp_unregister_command("rtc-reset-reinjection");
+    qmp_unregister_command(&qmp_commands, "rtc-reset-reinjection");
 #endif
 #ifndef TARGET_S390X
-    qmp_unregister_command("dump-skeys");
+    qmp_unregister_command(&qmp_commands, "dump-skeys");
 #endif
 #ifndef TARGET_ARM
-    qmp_unregister_command("query-gic-capabilities");
+    qmp_unregister_command(&qmp_commands, "query-gic-capabilities");
 #endif
 #if !defined(TARGET_S390X) && !defined(TARGET_I386)
-    qmp_unregister_command("query-cpu-model-expansion");
+    qmp_unregister_command(&qmp_commands, "query-cpu-model-expansion");
 #endif
 #if !defined(TARGET_S390X)
-    qmp_unregister_command("query-cpu-model-baseline");
-    qmp_unregister_command("query-cpu-model-comparison");
+    qmp_unregister_command(&qmp_commands, "query-cpu-model-baseline");
+    qmp_unregister_command(&qmp_commands, "query-cpu-model-comparison");
 #endif
 #if !defined(TARGET_PPC) && !defined(TARGET_ARM) && !defined(TARGET_I386) \
     && !defined(TARGET_S390X)
-    qmp_unregister_command("query-cpu-definitions");
+    qmp_unregister_command(&qmp_commands, "query-cpu-definitions");
 #endif
 }
 
 void monitor_init_qmp_commands(void)
 {
-    qmp_init_marshal();
+    qmp_init_marshal(&qmp_commands);
 
-    qmp_register_command("query-qmp-schema", qmp_query_qmp_schema,
+    qmp_register_command(&qmp_commands, "query-qmp-schema",
+                         qmp_query_qmp_schema,
                          QCO_NO_OPTIONS);
-    qmp_register_command("device_add", qmp_device_add,
+    qmp_register_command(&qmp_commands, "device_add", qmp_device_add,
                          QCO_NO_OPTIONS);
-    qmp_register_command("netdev_add", qmp_netdev_add,
+    qmp_register_command(&qmp_commands, "netdev_add", qmp_netdev_add,
                          QCO_NO_OPTIONS);
 
     qmp_unregister_commands_hack();
@@ -3787,7 +3790,7 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
         goto err_out;
     }
 
-    rsp = qmp_dispatch(req);
+    rsp = qmp_dispatch(&qmp_commands, req);
 
 err_out:
     if (err) {
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 621922f..72827a3 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -67,7 +67,8 @@ static QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
     return dict;
 }
 
-static QObject *do_qmp_dispatch(QObject *request, Error **errp)
+static QObject *do_qmp_dispatch(QmpCommandList *cmds, QObject *request,
+                                Error **errp)
 {
     Error *local_err = NULL;
     const char *command;
@@ -81,7 +82,7 @@ static QObject *do_qmp_dispatch(QObject *request, Error **errp)
     }
 
     command = qdict_get_str(dict, "execute");
-    cmd = qmp_find_command(command);
+    cmd = qmp_find_command(cmds, command);
     if (cmd == NULL) {
         error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
                   "The command %s has not been found", command);
@@ -121,13 +122,13 @@ QObject *qmp_build_error_object(Error *err)
                               error_get_pretty(err));
 }
 
-QObject *qmp_dispatch(QObject *request)
+QObject *qmp_dispatch(QmpCommandList *cmds, QObject *request)
 {
     Error *err = NULL;
     QObject *ret;
     QDict *rsp;
 
-    ret = do_qmp_dispatch(request, &err);
+    ret = do_qmp_dispatch(cmds, request, &err);
 
     rsp = qdict_new();
     if (err) {
diff --git a/qapi/qmp-registry.c b/qapi/qmp-registry.c
index e805368..5af484c 100644
--- a/qapi/qmp-registry.c
+++ b/qapi/qmp-registry.c
@@ -15,11 +15,8 @@
 #include "qemu/osdep.h"
 #include "qapi/qmp/dispatch.h"
 
-static QTAILQ_HEAD(QmpCommandList, QmpCommand) qmp_commands =
-    QTAILQ_HEAD_INITIALIZER(qmp_commands);
-
-void qmp_register_command(const char *name, QmpCommandFunc *fn,
-                          QmpCommandOptions options)
+void qmp_register_command(QmpCommandList *cmds, const char *name,
+                          QmpCommandFunc *fn, QmpCommandOptions options)
 {
     QmpCommand *cmd = g_malloc0(sizeof(*cmd));
 
@@ -27,22 +24,22 @@ void qmp_register_command(const char *name, QmpCommandFunc *fn,
     cmd->fn = fn;
     cmd->enabled = true;
     cmd->options = options;
-    QTAILQ_INSERT_TAIL(&qmp_commands, cmd, node);
+    QTAILQ_INSERT_TAIL(cmds, cmd, node);
 }
 
-void qmp_unregister_command(const char *name)
+void qmp_unregister_command(QmpCommandList *cmds, const char *name)
 {
-    QmpCommand *cmd = qmp_find_command(name);
+    QmpCommand *cmd = qmp_find_command(cmds, name);
 
-    QTAILQ_REMOVE(&qmp_commands, cmd, node);
+    QTAILQ_REMOVE(cmds, cmd, node);
     g_free(cmd);
 }
 
-QmpCommand *qmp_find_command(const char *name)
+QmpCommand *qmp_find_command(QmpCommandList *cmds, const char *name)
 {
     QmpCommand *cmd;
 
-    QTAILQ_FOREACH(cmd, &qmp_commands, node) {
+    QTAILQ_FOREACH(cmd, cmds, node) {
         if (strcmp(cmd->name, name) == 0) {
             return cmd;
         }
@@ -50,11 +47,12 @@ QmpCommand *qmp_find_command(const char *name)
     return NULL;
 }
 
-static void qmp_toggle_command(const char *name, bool enabled)
+static void qmp_toggle_command(QmpCommandList *cmds, const char *name,
+                               bool enabled)
 {
     QmpCommand *cmd;
 
-    QTAILQ_FOREACH(cmd, &qmp_commands, node) {
+    QTAILQ_FOREACH(cmd, cmds, node) {
         if (strcmp(cmd->name, name) == 0) {
             cmd->enabled = enabled;
             return;
@@ -62,14 +60,14 @@ static void qmp_toggle_command(const char *name, bool enabled)
     }
 }
 
-void qmp_disable_command(const char *name)
+void qmp_disable_command(QmpCommandList *cmds, const char *name)
 {
-    qmp_toggle_command(name, false);
+    qmp_toggle_command(cmds, name, false);
 }
 
-void qmp_enable_command(const char *name)
+void qmp_enable_command(QmpCommandList *cmds, const char *name)
 {
-    qmp_toggle_command(name, true);
+    qmp_toggle_command(cmds, name, true);
 }
 
 bool qmp_command_is_enabled(const QmpCommand *cmd)
@@ -87,11 +85,12 @@ bool qmp_has_success_response(const QmpCommand *cmd)
     return !(cmd->options & QCO_NO_SUCCESS_RESP);
 }
 
-void qmp_for_each_command(qmp_cmd_callback_fn fn, void *opaque)
+void qmp_for_each_command(QmpCommandList *cmds, qmp_cmd_callback_fn fn,
+                          void *opaque)
 {
     QmpCommand *cmd;
 
-    QTAILQ_FOREACH(cmd, &qmp_commands, node) {
+    QTAILQ_FOREACH(cmd, cmds, node) {
         fn(cmd, opaque);
     }
 }
diff --git a/qga/commands.c b/qga/commands.c
index edd3e83..4d92946 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -75,7 +75,7 @@ struct GuestAgentInfo *qmp_guest_info(Error **errp)
     GuestAgentInfo *info = g_new0(GuestAgentInfo, 1);
 
     info->version = g_strdup(QEMU_VERSION);
-    qmp_for_each_command(qmp_command_info, info);
+    qmp_for_each_command(&ga_commands, qmp_command_info, info);
     return info;
 }
 
diff --git a/qga/guest-agent-core.h b/qga/guest-agent-core.h
index 63e9d39..3e8a4ac 100644
--- a/qga/guest-agent-core.h
+++ b/qga/guest-agent-core.h
@@ -18,7 +18,9 @@
 
 typedef struct GAState GAState;
 typedef struct GACommandState GACommandState;
+
 extern GAState *ga_state;
+extern QmpCommandList ga_commands;
 
 GList *ga_command_blacklist_init(GList *blacklist);
 void ga_command_state_init(GAState *s, GACommandState *cs);
diff --git a/qga/main.c b/qga/main.c
index 6f8c614..9435bc7 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -92,6 +92,7 @@ struct GAState {
 };
 
 struct GAState *ga_state;
+QmpCommandList ga_commands;
 
 /* commands that are safe to issue while filesystems are frozen */
 static const char *ga_freeze_whitelist[] = {
@@ -370,7 +371,7 @@ static void ga_disable_non_whitelisted(QmpCommand *cmd, void *opaque)
     }
     if (!whitelisted) {
         g_debug("disabling command: %s", name);
-        qmp_disable_command(name);
+        qmp_disable_command(&ga_commands, name);
     }
 }
 
@@ -383,7 +384,7 @@ static void ga_enable_non_blacklisted(QmpCommand *cmd, void *opaque)
     if (g_list_find_custom(blacklist, name, ga_strcmp) == NULL &&
         !qmp_command_is_enabled(cmd)) {
         g_debug("enabling command: %s", name);
-        qmp_enable_command(name);
+        qmp_enable_command(&ga_commands, name);
     }
 }
 
@@ -420,7 +421,7 @@ void ga_set_frozen(GAState *s)
         return;
     }
     /* disable all non-whitelisted (for frozen state) commands */
-    qmp_for_each_command(ga_disable_non_whitelisted, NULL);
+    qmp_for_each_command(&ga_commands, ga_disable_non_whitelisted, NULL);
     g_warning("disabling logging due to filesystem freeze");
     ga_disable_logging(s);
     s->frozen = true;
@@ -456,7 +457,7 @@ void ga_unset_frozen(GAState *s)
     }
 
     /* enable all disabled, non-blacklisted commands */
-    qmp_for_each_command(ga_enable_non_blacklisted, s->blacklist);
+    qmp_for_each_command(&ga_commands, ga_enable_non_blacklisted, s->blacklist);
     s->frozen = false;
     if (!ga_delete_file(s->state_filepath_isfrozen)) {
         g_warning("unable to delete %s, fsfreeze may not function properly",
@@ -555,7 +556,7 @@ static void process_command(GAState *s, QDict *req)
 
     g_assert(req);
     g_debug("processing command");
-    rsp = qmp_dispatch(QOBJECT(req));
+    rsp = qmp_dispatch(&ga_commands, QOBJECT(req));
     if (rsp) {
         ret = send_response(s, rsp);
         if (ret < 0) {
@@ -1119,7 +1120,7 @@ static void config_parse(GAConfig *config, int argc, char **argv)
             break;
         case 'b': {
             if (is_help_option(optarg)) {
-                qmp_for_each_command(ga_print_cmd, NULL);
+                qmp_for_each_command(&ga_commands, ga_print_cmd, NULL);
                 exit(EXIT_SUCCESS);
             }
             config->blacklist = g_list_concat(config->blacklist,
@@ -1247,7 +1248,7 @@ static int run_agent(GAState *s, GAConfig *config)
             s->deferred_options.log_filepath = config->log_filepath;
         }
         ga_disable_logging(s);
-        qmp_for_each_command(ga_disable_non_whitelisted, NULL);
+        qmp_for_each_command(&ga_commands, ga_disable_non_whitelisted, NULL);
     } else {
         if (config->daemonize) {
             become_daemon(config->pid_filepath);
@@ -1277,7 +1278,7 @@ static int run_agent(GAState *s, GAConfig *config)
         s->blacklist = config->blacklist;
         do {
             g_debug("disabling command: %s", (char *)l->data);
-            qmp_disable_command(l->data);
+            qmp_disable_command(&ga_commands, l->data);
             l = g_list_next(l);
         } while (l);
     }
@@ -1321,7 +1322,7 @@ int main(int argc, char **argv)
 
     config->log_level = G_LOG_LEVEL_ERROR | G_LOG_LEVEL_CRITICAL;
 
-    qmp_init_marshal();
+    qga_qmp_init_marshal(&ga_commands);
 
     init_dfl_pathnames();
     config_load(config);
diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
index a75946f..2b062ad 100644
--- a/scripts/qapi-commands.py
+++ b/scripts/qapi-commands.py
@@ -198,7 +198,8 @@ def gen_register_command(name, success_response):
         options = 'QCO_NO_SUCCESS_RESP'
 
     ret = mcgen('''
-    qmp_register_command("%(name)s", qmp_marshal_%(c_name)s, %(opts)s);
+    qmp_register_command(cmds, "%(name)s", 
+                         qmp_marshal_%(c_name)s, %(opts)s);
 ''',
                 name=name, c_name=c_name(name),
                 opts=options)
@@ -208,9 +209,12 @@ def gen_register_command(name, success_response):
 def gen_registry(registry):
     ret = mcgen('''
 
-void qmp_init_marshal(void)
+void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds)
 {
-''')
+    QTAILQ_INIT(cmds);
+
+''',
+                c_prefix=c_name(prefix, protect=False))
     ret += registry
     ret += mcgen('''
 }
@@ -289,7 +293,6 @@ fdef.write(mcgen('''
 #include "qemu-common.h"
 #include "qemu/module.h"
 #include "qapi/qmp/types.h"
-#include "qapi/qmp/dispatch.h"
 #include "qapi/visitor.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qobject-input-visitor.h"
@@ -304,11 +307,12 @@ fdef.write(mcgen('''
 fdecl.write(mcgen('''
 #include "%(prefix)sqapi-types.h"
 #include "qapi/qmp/qdict.h"
+#include "qapi/qmp/dispatch.h"
 #include "qapi/error.h"
 
-void qmp_init_marshal(void);
+void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
 ''',
-                  prefix=prefix))
+                  prefix=prefix, c_prefix=c_name(prefix, protect=False)))
 
 schema = QAPISchema(input_file)
 gen = QAPISchemaGenCommandVisitor()
diff --git a/tests/test-qmp-commands.c b/tests/test-qmp-commands.c
index c4e20d1..1cf413b 100644
--- a/tests/test-qmp-commands.c
+++ b/tests/test-qmp-commands.c
@@ -8,6 +8,8 @@
 #include "tests/test-qapi-types.h"
 #include "tests/test-qapi-visit.h"
 
+static QmpCommandList qmp_commands;
+
 void qmp_user_def_cmd(Error **errp)
 {
 }
@@ -94,7 +96,7 @@ static void test_dispatch_cmd(void)
 
     qdict_put_obj(req, "execute", QOBJECT(qstring_from_str("user_def_cmd")));
 
-    resp = qmp_dispatch(QOBJECT(req));
+    resp = qmp_dispatch(&qmp_commands, QOBJECT(req));
     assert(resp != NULL);
     assert(!qdict_haskey(qobject_to_qdict(resp), "error"));
 
@@ -111,7 +113,7 @@ static void test_dispatch_cmd_failure(void)
 
     qdict_put_obj(req, "execute", QOBJECT(qstring_from_str("user_def_cmd2")));
 
-    resp = qmp_dispatch(QOBJECT(req));
+    resp = qmp_dispatch(&qmp_commands, QOBJECT(req));
     assert(resp != NULL);
     assert(qdict_haskey(qobject_to_qdict(resp), "error"));
 
@@ -125,7 +127,7 @@ static void test_dispatch_cmd_failure(void)
 
     qdict_put_obj(req, "execute", QOBJECT(qstring_from_str("user_def_cmd")));
 
-    resp = qmp_dispatch(QOBJECT(req));
+    resp = qmp_dispatch(&qmp_commands, QOBJECT(req));
     assert(resp != NULL);
     assert(qdict_haskey(qobject_to_qdict(resp), "error"));
 
@@ -139,7 +141,7 @@ static QObject *test_qmp_dispatch(QDict *req)
     QDict *resp;
     QObject *ret;
 
-    resp_obj = qmp_dispatch(QOBJECT(req));
+    resp_obj = qmp_dispatch(&qmp_commands, QOBJECT(req));
     assert(resp_obj);
     resp = qobject_to_qdict(resp_obj);
     assert(resp && !qdict_haskey(resp, "error"));
@@ -273,7 +275,7 @@ int main(int argc, char **argv)
     g_test_add_func("/0.15/dealloc_types", test_dealloc_types);
     g_test_add_func("/0.15/dealloc_partial", test_dealloc_partial);
 
-    qmp_init_marshal();
+    test_qmp_init_marshal(&qmp_commands);
     g_test_run();
 
     return 0;
-- 
2.7.4
