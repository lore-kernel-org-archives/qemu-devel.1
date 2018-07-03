Received: from eggs.gnu.org ([2001:4830:134:3::10]:53005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faH4X-0001Rf-I3
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faH4V-0007E1-I0
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38134 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faH4V-0007DO-CY
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:03 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 10:53:43 +0200
Message-Id: <20180703085358.13941-18-armbru@redhat.com>
In-Reply-To: <20180703085358.13941-1-armbru@redhat.com>
References: <20180703085358.13941-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 17/32] qmp: Don't let malformed in-band
 commands jump the queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, eblake@redhat.com, stefanha@redhat.com, dgilbert@redhat.com, mdroth@linux.vnet.ibm.com

handle_qmp_command() reports certain errors right away.  This is wrong
when OOB is enabled, because the errors can "jump the queue" then, as
the previous commit demonstrates.

To fix, we need to delay errors until dispatch.  Do that for semantic
errors, mostly by reverting ill-advised parts of commit cf869d53172
"qmp: support out-of-band (oob) execution".  Bonus: doesn't run
qmp_dispatch_check_obj() twice, once in handle_qmp_command(), and
again in do_qmp_dispatch().  That's also due to commit cf869d53172.

The next commit will fix queue jumping for syntax errors.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/qapi/qmp/dispatch.h |  2 -
 monitor.c                   | 79 +++++++++----------------------------
 qapi/qmp-dispatch.c         | 12 +++++-
 tests/qmp-test.c            |  4 +-
 4 files changed, 30 insertions(+), 67 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 303a15ba84..514bfc45b0 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -48,8 +48,6 @@ bool qmp_command_is_enabled(const QmpCommand *cmd);
 const char *qmp_command_name(const QmpCommand *cmd);
 bool qmp_has_success_response(const QmpCommand *cmd);
 QObject *qmp_build_error_object(Error *err);
-QDict *qmp_dispatch_check_obj(const QObject *request, bool allow_oob,
-                              Error **errp);
 QObject *qmp_dispatch(QmpCommandList *cmds, QObject *request,
                       bool allow_oob);
 bool qmp_is_oob(QDict *dict);
diff --git a/monitor.c b/monitor.c
index 28fa9b8d44..7a80e58bf2 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1289,48 +1289,6 @@ static void qmp_caps_apply(Monitor *mon, QMPCapabilityList *list)
     }
 }
 
-/*
- * Return true if check successful, or false otherwise.  When false is
- * returned, detailed error will be in errp if provided.
- */
-static bool qmp_cmd_oob_check(Monitor *mon, QDict *req, Error **errp)
-{
-    const char *command;
-    QmpCommand *cmd;
-
-    command = qdict_get_try_str(req, "execute");
-    if (!command) {
-        command = qdict_get_try_str(req, "exec-oob");
-    }
-    if (!command) {
-        error_setg(errp, "Command field 'execute' missing");
-        return false;
-    }
-
-    cmd = qmp_find_command(mon->qmp.commands, command);
-    if (!cmd) {
-        if (mon->qmp.commands == &qmp_cap_negotiation_commands) {
-            error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
-                      "Expecting capabilities negotiation "
-                      "with 'qmp_capabilities'");
-        } else {
-            error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
-                      "The command %s has not been found", command);
-        }
-        return false;
-    }
-
-    if (qmp_is_oob(req)) {
-        if (!(cmd->options & QCO_ALLOW_OOB)) {
-            error_setg(errp, "The command %s does not support OOB",
-                       command);
-            return false;
-        }
-    }
-
-    return true;
-}
-
 void qmp_qmp_capabilities(bool has_enable, QMPCapabilityList *enable,
                           Error **errp)
 {
@@ -4170,6 +4128,7 @@ static void monitor_qmp_dispatch(Monitor *mon, QObject *req, QObject *id)
 {
     Monitor *old_mon;
     QObject *rsp;
+    QDict *error;
 
     old_mon = cur_mon;
     cur_mon = mon;
@@ -4178,6 +4137,19 @@ static void monitor_qmp_dispatch(Monitor *mon, QObject *req, QObject *id)
 
     cur_mon = old_mon;
 
+    if (mon->qmp.commands == &qmp_cap_negotiation_commands) {
+        error = qdict_get_qdict(qobject_to(QDict, rsp), "error");
+        if (error
+            && !g_strcmp0(qdict_get_try_str(error, "class"),
+                    QapiErrorClass_str(ERROR_CLASS_COMMAND_NOT_FOUND))) {
+            /* Provide a more useful error message */
+            qdict_del(error, "desc");
+            qdict_put_str(error, "desc", "Expecting capabilities negotiation"
+                          " with 'qmp_capabilities'");
+        }
+    }
+
+    /* Respond if necessary */
     monitor_qmp_respond(mon, rsp, NULL, qobject_ref(id));
 }
 
@@ -4255,7 +4227,9 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
         error_setg(&err, QERR_JSON_PARSING);
     }
     if (err) {
-        goto err;
+        assert(!req);
+        monitor_qmp_respond(mon, NULL, err, NULL);
+        return;
     }
 
     qdict = qobject_to(QDict, req);
@@ -4270,18 +4244,7 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
         qobject_unref(req_json);
     }
 
-    /* Check against the request in general layout */
-    qdict = qmp_dispatch_check_obj(req, qmp_oob_enabled(mon), &err);
-    if (!qdict) {
-        goto err;
-    }
-
-    /* Check against OOB specific */
-    if (!qmp_cmd_oob_check(mon, qdict, &err)) {
-        goto err;
-    }
-
-    if (qmp_is_oob(qdict)) {
+    if (qdict && qmp_is_oob(qdict)) {
         /* Out-of-band (OOB) requests are executed directly in parser. */
         trace_monitor_qmp_cmd_out_of_band(qobject_get_try_str(id)
                                           ?: "");
@@ -4335,12 +4298,6 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
 
     /* Kick the dispatcher routine */
     qemu_bh_schedule(mon_global.qmp_dispatcher_bh);
-    return;
-
-err:
-    /* FIXME overtakes queued in-band commands, wrong when !qmp_is_oob() */
-    monitor_qmp_respond(mon, NULL, err, NULL);
-    qobject_unref(req);
 }
 
 static void monitor_qmp_read(void *opaque, const uint8_t *buf, int size)
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 12be120fe7..6d78f3e9f6 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -20,8 +20,8 @@
 #include "qapi/qmp/qbool.h"
 #include "sysemu/sysemu.h"
 
-QDict *qmp_dispatch_check_obj(const QObject *request, bool allow_oob,
-                              Error **errp)
+static QDict *qmp_dispatch_check_obj(const QObject *request, bool allow_oob,
+                                     Error **errp)
 {
     const char *exec_key = NULL;
     const QDictEntry *ent;
@@ -78,6 +78,7 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds, QObject *request,
                                 bool allow_oob, Error **errp)
 {
     Error *local_err = NULL;
+    bool oob;
     const char *command;
     QDict *args, *dict;
     QmpCommand *cmd;
@@ -89,9 +90,11 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds, QObject *request,
     }
 
     command = qdict_get_try_str(dict, "execute");
+    oob = false;
     if (!command) {
         assert(allow_oob);
         command = qdict_get_str(dict, "exec-oob");
+        oob = true;
     }
     cmd = qmp_find_command(cmds, command);
     if (cmd == NULL) {
@@ -104,6 +107,11 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds, QObject *request,
                    command);
         return NULL;
     }
+    if (oob && !(cmd->options & QCO_ALLOW_OOB)) {
+        error_setg(errp, "The command %s does not support OOB",
+                   command);
+        return false;
+    }
 
     if (runstate_check(RUN_STATE_PRECONFIG) &&
         !(cmd->options & QCO_ALLOW_PRECONFIG)) {
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 6581d1d755..57c1296573 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -243,12 +243,12 @@ static void test_qmp_oob(void)
     recv_cmd_id(qts, "ib-blocks-1");
     recv_cmd_id(qts, "ib-quick-1");
 
-    /* FIXME certain in-band errors overtake slow in-band command */
+    /* Even malformed in-band command fails in-band */
     send_cmd_that_blocks(qts, "blocks-2");
     qtest_async_qmp(qts, "{ 'id': 'err-2' }");
-    recv_cmd_id(qts, NULL);
     unblock_blocked_cmd();
     recv_cmd_id(qts, "blocks-2");
+    recv_cmd_id(qts, "err-2");
     cleanup_blocking_cmd();
 
     qtest_quit(qts);
-- 
2.17.1
