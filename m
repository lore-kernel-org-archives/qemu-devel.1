Received: from eggs.gnu.org ([2001:4830:134:3::10]:53269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faH4e-0001ZL-MO
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faH4Z-0007Jl-Pi
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51432 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faH4Z-0007Id-G8
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:07 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 10:53:49 +0200
Message-Id: <20180703085358.13941-24-armbru@redhat.com>
In-Reply-To: <20180703085358.13941-1-armbru@redhat.com>
References: <20180703085358.13941-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 23/32] qmp: Use QDict * instead of QObject *
 for response objects
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

By using the more specific type, we get fewer downcasts.  The
downcasts are safe, but not obviously so, at least not locally.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/qapi/qmp/dispatch.h |  4 ++--
 monitor.c                   | 31 ++++++++++++++++---------------
 qapi/qmp-dispatch.c         |  6 +++---
 qga/main.c                  |  8 ++++----
 tests/test-qmp-cmds.c       | 17 +++++++----------
 5 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index a53e11c9b1..4e2e749faf 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -48,8 +48,8 @@ bool qmp_command_is_enabled(const QmpCommand *cmd);
 const char *qmp_command_name(const QmpCommand *cmd);
 bool qmp_has_success_response(const QmpCommand *cmd);
 QDict *qmp_error_response(Error *err);
-QObject *qmp_dispatch(QmpCommandList *cmds, QObject *request,
-                      bool allow_oob);
+QDict *qmp_dispatch(QmpCommandList *cmds, QObject *request,
+                    bool allow_oob);
 bool qmp_is_oob(QDict *dict);
 
 typedef void (*qmp_cmd_callback_fn)(QmpCommand *cmd, void *opaque);
diff --git a/monitor.c b/monitor.c
index db85cd0a57..0f7a96213f 100644
--- a/monitor.c
+++ b/monitor.c
@@ -378,7 +378,7 @@ static void monitor_qmp_cleanup_req_queue_locked(Monitor *mon)
 static void monitor_qmp_cleanup_resp_queue_locked(Monitor *mon)
 {
     while (!g_queue_is_empty(mon->qmp.qmp_responses)) {
-        qobject_unref((QObject *)g_queue_pop_head(mon->qmp.qmp_responses));
+        qobject_unref((QDict *)g_queue_pop_head(mon->qmp.qmp_responses));
     }
 }
 
@@ -527,7 +527,8 @@ static void monitor_json_emitter(Monitor *mon, QObject *data)
          * responder thread).
          */
         qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
-        g_queue_push_tail(mon->qmp.qmp_responses, qobject_ref(data));
+        g_queue_push_tail(mon->qmp.qmp_responses,
+                          qobject_ref(qobject_to(QDict, data)));
         qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
         qemu_bh_schedule(qmp_respond_bh);
     } else {
@@ -541,13 +542,13 @@ static void monitor_json_emitter(Monitor *mon, QObject *data)
 
 struct QMPResponse {
     Monitor *mon;
-    QObject *data;
+    QDict *data;
 };
 typedef struct QMPResponse QMPResponse;
 
-static QObject *monitor_qmp_response_pop_one(Monitor *mon)
+static QDict *monitor_qmp_response_pop_one(Monitor *mon)
 {
-    QObject *data;
+    QDict *data;
 
     qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
     data = g_queue_pop_head(mon->qmp.qmp_responses);
@@ -558,10 +559,10 @@ static QObject *monitor_qmp_response_pop_one(Monitor *mon)
 
 static void monitor_qmp_response_flush(Monitor *mon)
 {
-    QObject *data;
+    QDict *data;
 
     while ((data = monitor_qmp_response_pop_one(mon))) {
-        monitor_json_emitter_raw(mon, data);
+        monitor_json_emitter_raw(mon, QOBJECT(data));
         qobject_unref(data);
     }
 }
@@ -573,7 +574,7 @@ static void monitor_qmp_response_flush(Monitor *mon)
 static bool monitor_qmp_response_pop_any(QMPResponse *response)
 {
     Monitor *mon;
-    QObject *data = NULL;
+    QDict *data = NULL;
 
     qemu_mutex_lock(&monitor_lock);
     QTAILQ_FOREACH(mon, &mon_list, entry) {
@@ -593,7 +594,7 @@ static void monitor_qmp_bh_responder(void *opaque)
     QMPResponse response;
 
     while (monitor_qmp_response_pop_any(&response)) {
-        monitor_json_emitter_raw(response.mon, response.data);
+        monitor_json_emitter_raw(response.mon, QOBJECT(response.data));
         qobject_unref(response.data);
     }
 }
@@ -4103,20 +4104,20 @@ static int monitor_can_read(void *opaque)
  * 2. rsp, err, and id may be NULL.
  * 3. If err != NULL then rsp must be NULL.
  */
-static void monitor_qmp_respond(Monitor *mon, QObject *rsp,
+static void monitor_qmp_respond(Monitor *mon, QDict *rsp,
                                 Error *err, QObject *id)
 {
     if (err) {
         assert(!rsp);
-        rsp = QOBJECT(qmp_error_response(err));
+        rsp = qmp_error_response(err);
     }
 
     if (rsp) {
         if (id) {
-            qdict_put_obj(qobject_to(QDict, rsp), "id", qobject_ref(id));
+            qdict_put_obj(rsp, "id", qobject_ref(id));
         }
 
-        monitor_json_emitter(mon, rsp);
+        monitor_json_emitter(mon, QOBJECT(rsp));
     }
 
     qobject_unref(id);
@@ -4126,7 +4127,7 @@ static void monitor_qmp_respond(Monitor *mon, QObject *rsp,
 static void monitor_qmp_dispatch(Monitor *mon, QObject *req, QObject *id)
 {
     Monitor *old_mon;
-    QObject *rsp;
+    QDict *rsp;
     QDict *error;
 
     old_mon = cur_mon;
@@ -4137,7 +4138,7 @@ static void monitor_qmp_dispatch(Monitor *mon, QObject *req, QObject *id)
     cur_mon = old_mon;
 
     if (mon->qmp.commands == &qmp_cap_negotiation_commands) {
-        error = qdict_get_qdict(qobject_to(QDict, rsp), "error");
+        error = qdict_get_qdict(rsp, "error");
         if (error
             && !g_strcmp0(qdict_get_try_str(error, "class"),
                     QapiErrorClass_str(ERROR_CLASS_COMMAND_NOT_FOUND))) {
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index c85748a33f..761812e924 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -161,8 +161,8 @@ bool qmp_is_oob(QDict *dict)
         && !qdict_haskey(dict, "execute");
 }
 
-QObject *qmp_dispatch(QmpCommandList *cmds, QObject *request,
-                      bool allow_oob)
+QDict *qmp_dispatch(QmpCommandList *cmds, QObject *request,
+                    bool allow_oob)
 {
     Error *err = NULL;
     QObject *ret;
@@ -179,5 +179,5 @@ QObject *qmp_dispatch(QmpCommandList *cmds, QObject *request,
         rsp = NULL;
     }
 
-    return QOBJECT(rsp);
+    return rsp;
 }
diff --git a/qga/main.c b/qga/main.c
index 0e30e30248..537cc0e162 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -545,7 +545,7 @@ fail:
 #endif
 }
 
-static int send_response(GAState *s, QObject *payload)
+static int send_response(GAState *s, QDict *payload)
 {
     const char *buf;
     QString *payload_qstr, *response_qstr;
@@ -553,7 +553,7 @@ static int send_response(GAState *s, QObject *payload)
 
     g_assert(payload && s->channel);
 
-    payload_qstr = qobject_to_json(payload);
+    payload_qstr = qobject_to_json(QOBJECT(payload));
     if (!payload_qstr) {
         return -EINVAL;
     }
@@ -581,7 +581,7 @@ static int send_response(GAState *s, QObject *payload)
 
 static void process_command(GAState *s, QDict *req)
 {
-    QObject *rsp = NULL;
+    QDict *rsp;
     int ret;
 
     g_assert(req);
@@ -629,7 +629,7 @@ static void process_event(JSONMessageParser *parser, GQueue *tokens)
             error_setg(&err, QERR_UNSUPPORTED);
             qdict = qmp_error_response(err);
         }
-        ret = send_response(s, QOBJECT(qdict));
+        ret = send_response(s, qdict);
         if (ret < 0) {
             g_warning("error sending error response: %s", strerror(-ret));
         }
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 10c7ba40c1..afb338a61e 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -98,13 +98,13 @@ __org_qemu_x_Union1 *qmp___org_qemu_x_command(__org_qemu_x_EnumList *a,
 static void test_dispatch_cmd(void)
 {
     QDict *req = qdict_new();
-    QObject *resp;
+    QDict *resp;
 
     qdict_put_str(req, "execute", "user_def_cmd");
 
     resp = qmp_dispatch(&qmp_commands, QOBJECT(req), false);
     assert(resp != NULL);
-    assert(!qdict_haskey(qobject_to(QDict, resp), "error"));
+    assert(!qdict_haskey(resp, "error"));
 
     qobject_unref(resp);
     qobject_unref(req);
@@ -115,13 +115,13 @@ static void test_dispatch_cmd_failure(void)
 {
     QDict *req = qdict_new();
     QDict *args = qdict_new();
-    QObject *resp;
+    QDict *resp;
 
     qdict_put_str(req, "execute", "user_def_cmd2");
 
     resp = qmp_dispatch(&qmp_commands, QOBJECT(req), false);
     assert(resp != NULL);
-    assert(qdict_haskey(qobject_to(QDict, resp), "error"));
+    assert(qdict_haskey(resp, "error"));
 
     qobject_unref(resp);
     qobject_unref(req);
@@ -135,7 +135,7 @@ static void test_dispatch_cmd_failure(void)
 
     resp = qmp_dispatch(&qmp_commands, QOBJECT(req), false);
     assert(resp != NULL);
-    assert(qdict_haskey(qobject_to(QDict, resp), "error"));
+    assert(qdict_haskey(resp, "error"));
 
     qobject_unref(resp);
     qobject_unref(req);
@@ -143,18 +143,15 @@ static void test_dispatch_cmd_failure(void)
 
 static QObject *test_qmp_dispatch(QDict *req)
 {
-    QObject *resp_obj;
     QDict *resp;
     QObject *ret;
 
-    resp_obj = qmp_dispatch(&qmp_commands, QOBJECT(req), false);
-    assert(resp_obj);
-    resp = qobject_to(QDict, resp_obj);
+    resp = qmp_dispatch(&qmp_commands, QOBJECT(req), false);
     assert(resp && !qdict_haskey(resp, "error"));
     ret = qdict_get(resp, "return");
     assert(ret);
     qobject_ref(ret);
-    qobject_unref(resp_obj);
+    qobject_unref(resp);
     return ret;
 }
 
-- 
2.17.1
