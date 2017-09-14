Received: from eggs.gnu.org ([2001:4830:134:3::10]:52614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dsOwQ-0007Ef-Fp
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:52:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dsOwO-0007qN-MI
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:52:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dsOwO-0007o1-BN
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:52:04 -0400
From: Peter Xu <peterx@redhat.com>
Date: Thu, 14 Sep 2017 15:50:32 +0800
Message-Id: <1505375436-28439-12-git-send-email-peterx@redhat.com>
In-Reply-To: <1505375436-28439-1-git-send-email-peterx@redhat.com>
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 11/15] monitor: separate QMP parser and dispatcher
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

Originally QMP is going throw these steps:

  JSON Parser --> QMP Dispatcher --> Respond
      /|\    (2)                (3)     |
   (1) |                               \|/ (4)
       +---------  main thread  --------+

This patch does this:

  JSON Parser     QMP Dispatcher --> Respond
      /|\ |           /|\       (4)     |
       |  | (2)        | (3)            |  (5)
   (1) |  +----->      |               \|/
       +---------  main thread  <-------+

So the parsing job and the dispatching job is isolated now.  It gives us
a chance in following up patches to totally move the parser outside.

The isloation is done using one QEMUBH. Only one dispatcher BH for all
the monitors.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 122 ++++++++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 99 insertions(+), 23 deletions(-)

diff --git a/monitor.c b/monitor.c
index aa0c384..f649d6a 100644
--- a/monitor.c
+++ b/monitor.c
@@ -213,6 +213,10 @@ struct MonitorGlobal {
     QemuThread mon_io_thread;
     GMainContext *mon_context;
     GMainLoop *mon_loop;
+    /* Bottom half to dispatch the requests received from IO thread */
+    QEMUBH *qmp_dispatcher_bh;
+    /* Input queue that hangs all the parsed QMP requests */
+    GQueue *qmp_requests;
 };
 
 static struct MonitorGlobal mon_global;
@@ -3858,29 +3862,31 @@ static void monitor_qmp_respond(Monitor *mon, QObject *rsp,
     qobject_decref(rsp);
 }
 
-static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens,
-                               void *opaque)
+struct QMPRequest {
+    /* Owner of the request */
+    Monitor *mon;
+    /* "id" field of the request */
+    QObject *id;
+    /* Request object to be handled */
+    QObject *req;
+};
+typedef struct QMPRequest QMPRequest;
+
+/*
+ * Dispatch one single QMP request. The function will free the req_obj
+ * and objects inside it before return.
+ */
+static void monitor_qmp_dispatch_one(QMPRequest *req_obj)
 {
-    QObject *req, *rsp = NULL, *id = NULL;
+    Monitor *mon, *old_mon;
+    QObject *req, *rsp = NULL, *id;
     QDict *qdict = NULL;
-    Monitor *mon = opaque, *old_mon;
-    Error *err = NULL;
 
-    req = json_parser_parse_err(tokens, NULL, &err);
-    if (!req && !err) {
-        /* json_parser_parse_err() sucks: can fail without setting @err */
-        error_setg(&err, QERR_JSON_PARSING);
-    }
-    if (err) {
-        goto err_out;
-    }
+    req = req_obj->req;
+    mon = req_obj->mon;
+    id = req_obj->id;
 
-    qdict = qobject_to_qdict(req);
-    if (qdict) {
-        id = qdict_get(qdict, "id");
-        qobject_incref(id);
-        qdict_del(qdict, "id");
-    } /* else will fail qmp_dispatch() */
+    g_free(req_obj);
 
     if (trace_event_get_state_backends(TRACE_HANDLE_QMP_COMMAND)) {
         QString *req_json = qobject_to_json(req);
@@ -3891,7 +3897,7 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens,
     old_mon = cur_mon;
     cur_mon = mon;
 
-    rsp = qmp_dispatch(cur_mon->qmp.commands, req);
+    rsp = qmp_dispatch(mon->qmp.commands, req);
 
     cur_mon = old_mon;
 
@@ -3907,12 +3913,66 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens,
         }
     }
 
-err_out:
-    monitor_qmp_respond(mon, rsp, err, id);
-
+    /* Respond if necessary */
+    monitor_qmp_respond(mon, rsp, NULL, id);
     qobject_decref(req);
 }
 
+static void monitor_qmp_bh_dispatcher(void *data)
+{
+    QMPRequest *req_obj;
+
+    while (true) {
+        req_obj = g_queue_pop_head(mon_global.qmp_requests);
+        if (!req_obj) {
+            break;
+        }
+        monitor_qmp_dispatch_one(req_obj);
+    }
+}
+
+static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens,
+                               void *opaque)
+{
+    QObject *req, *id = NULL;
+    QDict *qdict = NULL;
+    Monitor *mon = opaque;
+    Error *err = NULL;
+    QMPRequest *req_obj;
+
+    req = json_parser_parse_err(tokens, NULL, &err);
+    if (!req && !err) {
+        /* json_parser_parse_err() sucks: can fail without setting @err */
+        error_setg(&err, QERR_JSON_PARSING);
+    }
+    if (err) {
+        monitor_qmp_respond(mon, NULL, err, NULL);
+        qobject_decref(req);
+    }
+
+    qdict = qobject_to_qdict(req);
+    if (qdict) {
+        id = qdict_get(qdict, "id");
+        qobject_incref(id);
+        qdict_del(qdict, "id");
+    } /* else will fail qmp_dispatch() */
+
+    req_obj = g_new0(QMPRequest, 1);
+    req_obj->mon = mon;
+    req_obj->id = id;
+    req_obj->req = req;
+
+    /*
+     * Put the request to the end of queue so that requests will be
+     * handled in time order.  Ownership for req_obj, req, id,
+     * etc. will be delivered to the handler side.
+     */
+    g_queue_push_tail(mon_global.qmp_requests, req_obj);
+
+    /* Kick the dispatcher routine */
+    qemu_bh_schedule(mon_global.qmp_dispatcher_bh);
+}
+
 static void monitor_qmp_read(void *opaque, const uint8_t *buf, int size)
 {
     Monitor *mon = opaque;
@@ -4085,6 +4145,16 @@ static void monitor_io_thread_init(void)
     mon_global.mon_loop = g_main_loop_new(mon_global.mon_context, TRUE);
     qemu_thread_create(&mon_global.mon_io_thread, "mon-io-thr",
                        monitor_io_thread, NULL, QEMU_THREAD_JOINABLE);
+
+    /*
+     * This MUST be on main loop thread since we have commands that
+     * have assumption to be run on main loop thread (Yeah, we'd
+     * better remove this assumption in the future).
+     */
+    mon_global.qmp_dispatcher_bh = aio_bh_new(qemu_get_aio_context(),
+                                              monitor_qmp_bh_dispatcher,
+                                              NULL);
+    mon_global.qmp_requests = g_queue_new();
 }
 
 void monitor_init_globals(void)
@@ -4213,6 +4283,12 @@ void monitor_cleanup(void)
     qemu_mutex_unlock(&monitor_lock);
 
     monitor_io_thread_destroy();
+
+    qemu_bh_delete(mon_global.qmp_dispatcher_bh);
+    mon_global.qmp_dispatcher_bh = NULL;
+
+    g_queue_free(mon_global.qmp_requests);
+    mon_global.qmp_requests = NULL;
 }
 
 QemuOptsList qemu_mon_opts = {
-- 
2.7.4
