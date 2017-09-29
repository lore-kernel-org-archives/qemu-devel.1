Received: from eggs.gnu.org ([2001:4830:134:3::10]:36305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxmAZ-0006rN-5U
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxmAY-0007Ww-4E
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:40:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dxmAX-0007WB-Fu
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:40:54 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 29 Sep 2017 11:38:40 +0800
Message-Id: <20170929033844.26935-19-peterx@redhat.com>
In-Reply-To: <20170929033844.26935-1-peterx@redhat.com>
References: <20170929033844.26935-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v2 18/22] qmp: support out-of-band (oob) execution
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
List-ID: <qemu-devel.nongnu.org>

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
 monitor.c                   |  8 ++++++++
 qapi/qmp-dispatch.c         | 34 ++++++++++++++++++++++++++++++++++
 trace-events                |  2 ++
 4 files changed, 45 insertions(+)

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
index 847468ecb0..2be79eadcc 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3968,6 +3968,7 @@ static void monitor_qmp_bh_dispatcher(void *data)
         if (!req_obj) {
             break;
         }
+        trace_monitor_qmp_cmd_in_band(qobject_get_try_str(req_obj->id));
         monitor_qmp_dispatch_one(req_obj);
     }
 }
@@ -4005,6 +4006,13 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens,
     req_obj->id = id;
     req_obj->req = req;
 
+    if (qmp_is_oob(req)) {
+        /* Out-Of-Band (OOB) requests are executed directly in parser. */
+        trace_monitor_qmp_cmd_out_of_band(qobject_get_try_str(req_obj->id));
+        monitor_qmp_dispatch_one(req_obj);
+        return;
+    }
+
     /* Drop the request if queue is full. */
     if (mon->qmp_requests->length >= QMP_ASYNC_QUEUE_LEN_MAX) {
         const char *id_str = qobject_get_try_str(id);
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index b41fa174fe..3c7c67acc1 100644
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
@@ -122,6 +128,34 @@ QObject *qmp_build_error_object(Error *err)
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
