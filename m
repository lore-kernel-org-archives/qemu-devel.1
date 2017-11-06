Received: from eggs.gnu.org ([2001:4830:134:3::10]:49723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eBe3V-0006Xt-Dn
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:51:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eBe3U-0005Nb-6Z
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:50:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eBe3T-0005N8-UO
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:50:56 -0500
From: Peter Xu <peterx@redhat.com>
Date: Mon,  6 Nov 2017 17:46:37 +0800
Message-Id: <20171106094643.14881-22-peterx@redhat.com>
In-Reply-To: <20171106094643.14881-1-peterx@redhat.com>
References: <20171106094643.14881-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v3 21/27] qmp: support out-of-band (oob) execution
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

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
 monitor.c                   | 16 ++++++++++++++++
 qapi/qmp-dispatch.c         | 39 +++++++++++++++++++++++++++++++++++++++
 trace-events                |  2 ++
 4 files changed, 58 insertions(+)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index b76798800c..ee2b8ce576 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -49,6 +49,7 @@ bool qmp_command_is_enabled(const QmpCommand *cmd);
 const char *qmp_command_name(const QmpCommand *cmd);
 bool qmp_has_success_response(const QmpCommand *cmd);
 QObject *qmp_build_error_object(Error *err);
+bool qmp_is_oob(const QObject *request);
 
 typedef void (*qmp_cmd_callback_fn)(QmpCommand *cmd, void *opaque);
 
diff --git a/monitor.c b/monitor.c
index f1f850f5c6..45d293469a 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4025,6 +4025,7 @@ static void monitor_qmp_bh_dispatcher(void *data)
         if (!req_obj) {
             break;
         }
+        trace_monitor_qmp_cmd_in_band(qobject_get_try_str(req_obj->id));
         monitor_qmp_dispatch_one(req_obj);
     }
 }
@@ -4051,6 +4052,14 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens,
         return;
     }
 
+    if (!qmp_oob_enabled(mon) && qmp_is_oob(req)) {
+        error_setg(&err, "Out-Of-Band is only allowed "
+                   "when OOB is enabled.");
+        monitor_qmp_respond(mon, NULL, err, NULL);
+        qobject_decref(req);
+        return;
+    }
+
     qdict = qobject_to_qdict(req);
     if (qdict) {
         id = qdict_get(qdict, "id");
@@ -4064,6 +4073,13 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens,
     req_obj->req = req;
 
     if (qmp_oob_enabled(mon)) {
+        if (qmp_is_oob(req)) {
+            /* Out-Of-Band (OOB) requests are executed directly in parser. */
+            trace_monitor_qmp_cmd_out_of_band(qobject_get_try_str(req_obj->id));
+            monitor_qmp_dispatch_one(req_obj);
+            return;
+        }
+
         /* Drop the request if queue is full. */
         if (mon->qmp.qmp_requests->length >= QMP_REQ_QUEUE_LEN_MAX) {
             const char *id_str = qobject_get_try_str(id);
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index b41fa174fe..ed7e5d5a75 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -52,6 +52,12 @@ static QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
                            "QMP input member 'arguments' must be an object");
                 return NULL;
             }
+        } else if (!strcmp(arg_name, "control")) {
+            if (qobject_type(arg_obj) != QTYPE_QDICT) {
+                error_setg(errp,
+                           "QMP input member 'control' must be a dict");
+                return NULL;
+            }
         } else {
             error_setg(errp, "QMP input member '%s' is unexpected",
                        arg_name);
@@ -94,6 +100,11 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds, QObject *request,
         return NULL;
     }
 
+    if (qmp_is_oob(request) && !(cmd->options & QCO_ALLOW_OOB)) {
+        error_setg(errp, "The command %s does not support OOB", command);
+        return NULL;
+    }
+
     if (!qdict_haskey(dict, "arguments")) {
         args = qdict_new();
     } else {
@@ -122,6 +133,34 @@ QObject *qmp_build_error_object(Error *err)
                               error_get_pretty(err));
 }
 
+/*
+ * Detect whether a request should be run out-of-band, by quickly
+ * peeking at whether we have: { "control": { "run-oob": True } }. By
+ * default commands are run in-band.
+ */
+bool qmp_is_oob(const QObject *request)
+{
+    QDict *dict;
+    QBool *bool_obj;
+
+    dict = qobject_to_qdict(request);
+    if (!dict) {
+        return false;
+    }
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
index 1d2eb5d3e4..3148e590c9 100644
--- a/trace-events
+++ b/trace-events
@@ -47,6 +47,8 @@ monitor_protocol_event_emit(uint32_t event, void *data) "event=%d data=%p"
 monitor_protocol_event_queue(uint32_t event, void *qdict, uint64_t rate) "event=%d data=%p rate=%" PRId64
 handle_hmp_command(void *mon, const char *cmdline) "mon %p cmdline: %s"
 handle_qmp_command(void *mon, const char *req) "mon %p req: %s"
+monitor_qmp_cmd_in_band(const char *id) "%s"
+monitor_qmp_cmd_out_of_band(const char *id) "%s"
 
 # dma-helpers.c
 dma_blk_io(void *dbs, void *bs, int64_t offset, bool to_dev) "dbs=%p bs=%p offset=%" PRId64 " to_dev=%d"
-- 
2.13.5
