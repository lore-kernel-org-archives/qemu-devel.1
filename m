Received: from eggs.gnu.org ([2001:4830:134:3::10]:38944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eRDat-0002tw-E0
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:49:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eRDas-0002Id-2c
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:49:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eRDar-0002I3-QU
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:49:46 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue, 19 Dec 2017 16:45:51 +0800
Message-Id: <20171219084557.9801-22-peterx@redhat.com>
In-Reply-To: <20171219084557.9801-1-peterx@redhat.com>
References: <20171219084557.9801-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v6 21/27] qmp: support out-of-band (oob) execution
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

Having "allow-oob" to true for a command does not mean that this command
will always be run in out-of-band mode.  The out-of-band quick path will
only be executed if we specify the extra "run-oob" flag when sending the
QMP request:

    { "execute":   "command-that-allows-oob",
      "arguments": { ... },
      "control":   { "run-oob": true } }

The "control" key is introduced to store this extra flag.  "control"
field is used to store arguments that are shared by all the commands,
rather than command specific arguments.  Let "run-oob" be the first.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qapi/qmp/dispatch.h |  1 +
 monitor.c                   | 83 ++++++++++++++++++++++++++++++++++++++++-----
 qapi/qmp-dispatch.c         | 28 +++++++++++++++
 trace-events                |  2 ++
 4 files changed, 105 insertions(+), 9 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index cf2657b5c9..d8d913b338 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -50,6 +50,7 @@ const char *qmp_command_name(const QmpCommand *cmd);
 bool qmp_has_success_response(const QmpCommand *cmd);
 QObject *qmp_build_error_object(Error *err);
 QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp);
+bool qmp_is_oob(QDict *dict);
 
 typedef void (*qmp_cmd_callback_fn)(QmpCommand *cmd, void *opaque);
 
diff --git a/monitor.c b/monitor.c
index b571866659..505db439d8 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1090,6 +1090,44 @@ static void qmp_caps_apply(Monitor *mon, QMPCapabilityList *list)
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
+                       "for the session during handshake");
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
@@ -4032,6 +4070,7 @@ static void monitor_qmp_bh_dispatcher(void *data)
     QMPRequest *req_obj = monitor_qmp_requests_pop_one();
 
     if (req_obj) {
+        trace_monitor_qmp_cmd_in_band(qobject_get_try_str(req_obj->id));
         monitor_qmp_dispatch_one(req_obj);
         /* Reschedule instead of looping so the main loop stays responsive */
         qemu_bh_schedule(mon_global.qmp_dispatcher_bh);
@@ -4055,17 +4094,31 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
         error_setg(&err, QERR_JSON_PARSING);
     }
     if (err) {
-        monitor_qmp_respond(mon, NULL, err, NULL);
-        qobject_decref(req);
-        return;
+        goto err;
+    }
+
+    /* Check against the request in general layout */
+    qdict = qmp_dispatch_check_obj(req, &err);
+    if (!qdict) {
+        goto err;
     }
 
-    qdict = qobject_to_qdict(req);
-    if (qdict) {
-        id = qdict_get(qdict, "id");
-        qobject_incref(id);
-        qdict_del(qdict, "id");
-    } /* else will fail qmp_dispatch() */
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
+                   "every command contains an 'id' field.");
+        goto err;
+    }
+
+    qobject_incref(id);
+    qdict_del(qdict, "id");
 
     req_obj = g_new0(QMPRequest, 1);
     req_obj->mon = mon;
@@ -4073,6 +4126,13 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
     req_obj->req = req;
     req_obj->need_resume = false;
 
+    if (qmp_is_oob(qdict)) {
+        /* Out-Of-Band (OOB) requests are executed directly in parser. */
+        trace_monitor_qmp_cmd_out_of_band(qobject_get_try_str(req_obj->id));
+        monitor_qmp_dispatch_one(req_obj);
+        return;
+    }
+
     /* Protect qmp_requests and fetching its length. */
     qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
 
@@ -4108,6 +4168,11 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
 
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
index b16f2f1d3f..675223e0ec 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -54,6 +54,12 @@ QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
             }
         } else if (!strcmp(arg_name, "id")) {
             continue;
+        } else if (!strcmp(arg_name, "control")) {
+            if (qobject_type(arg_obj) != QTYPE_QDICT) {
+                error_setg(errp,
+                           "QMP input member 'control' must be a dict");
+                return NULL;
+            }
         } else {
             error_setg(errp, "QMP input member '%s' is unexpected",
                        arg_name);
@@ -124,6 +130,28 @@ QObject *qmp_build_error_object(Error *err)
                               error_get_pretty(err));
 }
 
+/*
+ * Detect whether a request should be run out-of-band, by quickly
+ * peeking at whether we have: { "control": { "run-oob": True } }. By
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
+    bool_obj = qobject_to_qbool(qdict_get(dict, "run-oob"));
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
index 2646241a0f..1fb9ea7df2 100644
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
