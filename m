Received: from eggs.gnu.org ([2001:4830:134:3::10]:52925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dsOwk-0007fq-TC
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:52:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dsOwh-0008SV-Oy
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:52:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dsOwh-0008RE-HE
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:52:23 -0400
From: Peter Xu <peterx@redhat.com>
Date: Thu, 14 Sep 2017 15:50:35 +0800
Message-Id: <1505375436-28439-15-git-send-email-peterx@redhat.com>
In-Reply-To: <1505375436-28439-1-git-send-email-peterx@redhat.com>
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 14/15] qmp: support out-of-band (oob) execution
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Having "allow-oob" to true for a command does not mean that this command
will always be run in out-of-band mode.  The out-of-band quick path will
only be executed if we specify the extra "run-oob" flag when sending the
QMP request:

  { "execute": "command-that-allows-oob",
    "arguments": { ... },
    "control": { "run-oob": true } }

The "control" key is introduced to store this extra flag.  "control"
field is used to store arguments that are shared by all the commands,
rather than command specific arguments.  Let "run-oob" be the first.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 10 ++++++++++
 include/qapi/qmp/dispatch.h  |  1 +
 monitor.c                    | 11 +++++++++++
 qapi/qmp-dispatch.c          | 34 ++++++++++++++++++++++++++++++++++
 trace-events                 |  2 ++
 5 files changed, 58 insertions(+)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 61fa167..47d16bb 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -665,6 +665,16 @@ allowed to run out-of-band can also be introspected using
 query-qmp-schema command.  Please see the section "Client JSON
 Protocol introspection" for more information.
 
+To execute a command in out-of-band way, we need to specify the
+"control" field in the request, with "run-oob" set to true. Example:
+
+ => { "execute": "command-support-oob",
+      "arguments": { ... },
+      "control": { "run-oob": true } }
+ <= { "return": { } }
+
+Without it, even the commands that supports out-of-band execution will
+still be run in-band.
 
 === Events ===
 
diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index b767988..ee2b8ce 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -49,6 +49,7 @@ bool qmp_command_is_enabled(const QmpCommand *cmd);
 const char *qmp_command_name(const QmpCommand *cmd);
 bool qmp_has_success_response(const QmpCommand *cmd);
 QObject *qmp_build_error_object(Error *err);
+bool qmp_is_oob(const QObject *request);
 
 typedef void (*qmp_cmd_callback_fn)(QmpCommand *cmd, void *opaque);
 
diff --git a/monitor.c b/monitor.c
index 599ea36..cb96204 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3928,6 +3928,7 @@ static void monitor_qmp_bh_dispatcher(void *data)
         if (!req_obj) {
             break;
         }
+        trace_monitor_qmp_cmd_in_band(qobject_get_str(req_obj->id));
         monitor_qmp_dispatch_one(req_obj);
     }
 }
@@ -3963,6 +3964,16 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens,
     req_obj->id = id;
     req_obj->req = req;
 
+    if (qmp_is_oob(req)) {
+        /*
+         * Trigger fast-path to handle the out-of-band request, by
+         * executing the command directly in parser.
+         */
+        trace_monitor_qmp_cmd_out_of_band(qobject_get_str(req_obj->id));
+        monitor_qmp_dispatch_one(req_obj);
+        return;
+    }
+
     /*
      * Put the request to the end of queue so that requests will be
      * handled in time order.  Ownership for req_obj, req, id,
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index b41fa17..9a05dfa 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -52,6 +52,12 @@ static QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
                            "QMP input member 'arguments' must be an object");
                 return NULL;
             }
+        } else if (!strcmp(arg_name, "control")) {
+            if (qobject_type(arg_obj) != QTYPE_QDICT) {
+                error_setg(errp,
+                           "QMP input member 'control' must be an object");
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
index 1f50f56..f7900a6 100644
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
2.7.4
