Received: from eggs.gnu.org ([2001:4830:134:3::10]:45480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJd-0000u7-RB
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJc-00064N-A3
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33614 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evSJc-00063l-3s
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:56 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 12 Mar 2018 13:36:20 -0500
Message-Id: <20180312183628.394722-30-eblake@redhat.com>
In-Reply-To: <20180312183628.394722-1-eblake@redhat.com>
References: <20180312183628.394722-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 29/36] qmp: support out-of-band (oob) execution
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

From: Peter Xu <peterx@redhat.com>

Having "allow-oob":true for a command does not mean that this command
will always be run in out-of-band mode.  The out-of-band quick path will
only be executed if we specify the extra "run-oob" flag when sending the
QMP request:

    { "execute":   "command-that-allows-oob",
      "arguments": { ... },
      "control":   { "run-oob": true } }

The "control" key is introduced to store this extra flag.  "control"
field is used to store arguments that are shared by all the commands,
rather than command specific arguments.  Let "run-oob" be the first.

Note that in the patch I exported qmp_dispatch_check_obj() to be used to
check the request earlier, and at the same time allowed "id" field to be
there since actually we always allow that.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180309090006.10018-19-peterx@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: rebase to qobject_to(), spelling fix]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/qapi/qmp/dispatch.h |  2 ++
 monitor.c                   | 84 ++++++++++++++++++++++++++++++++++++++++-----
 qapi/qmp-dispatch.c         | 33 +++++++++++++++++-
 trace-events                |  2 ++
 4 files changed, 111 insertions(+), 10 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 26eb13ff417..ffb4652f716 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -48,6 +48,8 @@ bool qmp_command_is_enabled(const QmpCommand *cmd);
 const char *qmp_command_name(const QmpCommand *cmd);
 bool qmp_has_success_response(const QmpCommand *cmd);
 QObject *qmp_build_error_object(Error *err);
+QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp);
+bool qmp_is_oob(QDict *dict);

 typedef void (*qmp_cmd_callback_fn)(QmpCommand *cmd, void *opaque);

diff --git a/monitor.c b/monitor.c
index d28457d60d7..3b7a4a5c3a7 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1110,6 +1110,44 @@ static void qmp_caps_apply(Monitor *mon, QMPCapabilityList *list)
     }
 }

+/*
+ * Return true if check successful, or false otherwise.  When false is
+ * returned, detailed error will be in errp if provided.
+ */
+static bool qmp_cmd_oob_check(Monitor *mon, QDict *req, Error **errp)
+{
+    const char *command;
+    QmpCommand *cmd;
+
+    command = qdict_get_try_str(req, "execute");
+    if (!command) {
+        error_setg(errp, "Command field 'execute' missing");
+        return false;
+    }
+
+    cmd = qmp_find_command(mon->qmp.commands, command);
+    if (!cmd) {
+        error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
+                  "The command %s has not been found", command);
+        return false;
+    }
+
+    if (qmp_is_oob(req)) {
+        if (!qmp_oob_enabled(mon)) {
+            error_setg(errp, "Please enable Out-Of-Band first "
+                       "for the session during capabilities negotiation");
+            return false;
+        }
+        if (!(cmd->options & QCO_ALLOW_OOB)) {
+            error_setg(errp, "The command %s does not support OOB",
+                       command);
+            return false;
+        }
+    }
+
+    return true;
+}
+
 void qmp_qmp_capabilities(bool has_enable, QMPCapabilityList *enable,
                           Error **errp)
 {
@@ -4001,6 +4039,7 @@ static void monitor_qmp_bh_dispatcher(void *data)
     QMPRequest *req_obj = monitor_qmp_requests_pop_one();

     if (req_obj) {
+        trace_monitor_qmp_cmd_in_band(qobject_get_try_str(req_obj->id) ?: "");
         monitor_qmp_dispatch_one(req_obj);
         /* Reschedule instead of looping so the main loop stays responsive */
         qemu_bh_schedule(mon_global.qmp_dispatcher_bh);
@@ -4024,17 +4063,31 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
         error_setg(&err, QERR_JSON_PARSING);
     }
     if (err) {
-        monitor_qmp_respond(mon, NULL, err, NULL);
-        qobject_decref(req);
-        return;
+        goto err;
     }

-    qdict = qobject_to(QDict, req);
-    if (qdict) {
-        id = qdict_get(qdict, "id");
-        qobject_incref(id);
-        qdict_del(qdict, "id");
-    } /* else will fail qmp_dispatch() */
+    /* Check against the request in general layout */
+    qdict = qmp_dispatch_check_obj(req, &err);
+    if (!qdict) {
+        goto err;
+    }
+
+    /* Check against OOB specific */
+    if (!qmp_cmd_oob_check(mon, qdict, &err)) {
+        goto err;
+    }
+
+    id = qdict_get(qdict, "id");
+
+    /* When OOB is enabled, the "id" field is mandatory. */
+    if (qmp_oob_enabled(mon) && !id) {
+        error_setg(&err, "Out-Of-Band capability requires that "
+                   "every command contains an 'id' field");
+        goto err;
+    }
+
+    qobject_incref(id);
+    qdict_del(qdict, "id");

     req_obj = g_new0(QMPRequest, 1);
     req_obj->mon = mon;
@@ -4042,6 +4095,14 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
     req_obj->req = req;
     req_obj->need_resume = false;

+    if (qmp_is_oob(qdict)) {
+        /* Out-Of-Band (OOB) requests are executed directly in parser. */
+        trace_monitor_qmp_cmd_out_of_band(qobject_get_try_str(req_obj->id)
+                                          ?: "");
+        monitor_qmp_dispatch_one(req_obj);
+        return;
+    }
+
     /* Protect qmp_requests and fetching its length. */
     qemu_mutex_lock(&mon->qmp.qmp_queue_lock);

@@ -4078,6 +4139,11 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)

     /* Kick the dispatcher routine */
     qemu_bh_schedule(mon_global.qmp_dispatcher_bh);
+    return;
+
+err:
+    monitor_qmp_respond(mon, NULL, err, NULL);
+    qobject_decref(req);
 }

 static void monitor_qmp_read(void *opaque, const uint8_t *buf, int size)
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index af537f3d7d2..dd059072651 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -17,8 +17,9 @@
 #include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
+#include "qapi/qmp/qbool.h"

-static QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
+QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
 {
     const QDictEntry *ent;
     const char *arg_name;
@@ -50,6 +51,14 @@ static QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
                            "QMP input member 'arguments' must be an object");
                 return NULL;
             }
+        } else if (!strcmp(arg_name, "id")) {
+            continue;
+        } else if (!strcmp(arg_name, "control")) {
+            if (qobject_type(arg_obj) != QTYPE_QDICT) {
+                error_setg(errp,
+                           "QMP input member 'control' must be a dict");
+                return NULL;
+            }
         } else {
             error_setg(errp, "QMP input member '%s' is unexpected",
                        arg_name);
@@ -120,6 +129,28 @@ QObject *qmp_build_error_object(Error *err)
                               error_get_pretty(err));
 }

+/*
+ * Detect whether a request should be run out-of-band, by quickly
+ * peeking at whether we have: { "control": { "run-oob": true } }. By
+ * default commands are run in-band.
+ */
+bool qmp_is_oob(QDict *dict)
+{
+    QBool *bool_obj;
+
+    dict = qdict_get_qdict(dict, "control");
+    if (!dict) {
+        return false;
+    }
+
+    bool_obj = qobject_to(QBool, qdict_get(dict, "run-oob"));
+    if (!bool_obj) {
+        return false;
+    }
+
+    return qbool_get_bool(bool_obj);
+}
+
 QObject *qmp_dispatch(QmpCommandList *cmds, QObject *request)
 {
     Error *err = NULL;
diff --git a/trace-events b/trace-events
index fe10c3b487c..bd036da278d 100644
--- a/trace-events
+++ b/trace-events
@@ -48,6 +48,8 @@ monitor_protocol_event_queue(uint32_t event, void *qdict, uint64_t rate) "event=
 handle_hmp_command(void *mon, const char *cmdline) "mon %p cmdline: %s"
 handle_qmp_command(void *mon, const char *req) "mon %p req: %s"
 monitor_suspend(void *ptr, int cnt) "mon %p: %d"
+monitor_qmp_cmd_in_band(const char *id) "%s"
+monitor_qmp_cmd_out_of_band(const char *id) "%s"

 # dma-helpers.c
 dma_blk_io(void *dbs, void *bs, int64_t offset, bool to_dev) "dbs=%p bs=%p offset=%" PRId64 " to_dev=%d"
-- 
2.14.3
