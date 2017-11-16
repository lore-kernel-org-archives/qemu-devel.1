Received: from eggs.gnu.org ([2001:4830:134:3::10]:38919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eFJtg-0000Ox-P7
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:08:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eFJtf-00088v-97
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:08:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eFJtf-00086K-04
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:07:59 -0500
From: Peter Xu <peterx@redhat.com>
Date: Thu, 16 Nov 2017 21:05:59 +0800
Message-Id: <20171116130610.23582-17-peterx@redhat.com>
In-Reply-To: <20171116130610.23582-1-peterx@redhat.com>
References: <20171116130610.23582-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v4 16/27] monitor: separate QMP parser and
 dispatcher
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

Originally QMP goes throw these steps:

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

The isloation is done using one QEMUBH. Only one dispatcher QEMUBH is
used for all the monitors.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 179 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 157 insertions(+), 22 deletions(-)

diff --git a/monitor.c b/monitor.c
index 30f9cd80de..0e2ff114cc 100644
--- a/monitor.c
+++ b/monitor.c
@@ -168,6 +168,10 @@ typedef struct {
      */
     QmpCommandList *commands;
     bool qmp_caps[QMP_CAPABILITY__MAX];
+    /* Protects qmp request/response queue. */
+    QemuMutex qmp_queue_lock;
+    /* Input queue that holds all the parsed QMP requests */
+    GQueue *qmp_requests;
 } MonitorQMP;
 
 /*
@@ -213,6 +217,8 @@ struct Monitor {
 
 struct MonitorGlobal {
     IOThread *mon_iothread;
+    /* Bottom half to dispatch the requests received from IO thread */
+    QEMUBH *qmp_dispatcher_bh;
 };
 
 static struct MonitorGlobal mon_global;
@@ -582,11 +588,13 @@ static void monitor_data_init(Monitor *mon, bool skip_flush,
 {
     memset(mon, 0, sizeof(Monitor));
     qemu_mutex_init(&mon->out_lock);
+    qemu_mutex_init(&mon->qmp.qmp_queue_lock);
     mon->outbuf = qstring_new();
     /* Use *mon_cmds by default. */
     mon->cmd_table = mon_cmds;
     mon->skip_flush = skip_flush;
     mon->use_io_thr = use_io_thr;
+    mon->qmp.qmp_requests = g_queue_new();
 }
 
 static void monitor_data_destroy(Monitor *mon)
@@ -599,6 +607,8 @@ static void monitor_data_destroy(Monitor *mon)
     g_free(mon->rs);
     QDECREF(mon->outbuf);
     qemu_mutex_destroy(&mon->out_lock);
+    qemu_mutex_destroy(&mon->qmp.qmp_queue_lock);
+    g_queue_free(mon->qmp.qmp_requests);
 }
 
 char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
@@ -3907,29 +3917,31 @@ static void monitor_qmp_respond(Monitor *mon, QObject *rsp,
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
@@ -3940,7 +3952,7 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens,
     old_mon = cur_mon;
     cur_mon = mon;
 
-    rsp = qmp_dispatch(cur_mon->qmp.commands, req);
+    rsp = qmp_dispatch(mon->qmp.commands, req);
 
     cur_mon = old_mon;
 
@@ -3956,12 +3968,122 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens,
         }
     }
 
-err_out:
-    monitor_qmp_respond(mon, rsp, err, id);
+    /* Respond if necessary */
+    monitor_qmp_respond(mon, rsp, NULL, id);
+
+    /* This pairs with the monitor_suspend() in handle_qmp_command(). */
+    if (!qmp_oob_enabled(mon)) {
+        monitor_resume(mon);
+    }
 
     qobject_decref(req);
 }
 
+/*
+ * Pop one QMP request from monitor queues, return NULL if not found.
+ * We are using round-robin fasion to pop the request, to avoid
+ * processing command only on a very busy monitor.  To achieve that,
+ * when we processed one request on specific monitor, we put that
+ * monitor to the end of mon_list queue.
+ */
+static QMPRequest *monitor_qmp_requests_pop_one(void)
+{
+    QMPRequest *req_obj = NULL;
+    Monitor *mon;
+
+    qemu_mutex_lock(&monitor_lock);
+
+    QTAILQ_FOREACH(mon, &mon_list, entry) {
+        qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
+        req_obj = g_queue_pop_head(mon->qmp.qmp_requests);
+        qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
+        if (req_obj) {
+            break;
+        }
+    }
+
+    if (req_obj) {
+        /*
+         * We found one request on the monitor. Degrade this monitor's
+         * priority to lowest by re-inserting it to end of queue.
+         */
+        QTAILQ_REMOVE(&mon_list, mon, entry);
+        QTAILQ_INSERT_TAIL(&mon_list, mon, entry);
+    }
+
+    qemu_mutex_unlock(&monitor_lock);
+
+    return req_obj;
+}
+
+static void monitor_qmp_bh_dispatcher(void *data)
+{
+    QMPRequest *req_obj;
+
+    while (true) {
+        req_obj = monitor_qmp_requests_pop_one();
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
+        return;
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
+    qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
+    g_queue_push_tail(mon->qmp.qmp_requests, req_obj);
+    qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
+
+    /* Kick the dispatcher routine */
+    qemu_bh_schedule(mon_global.qmp_dispatcher_bh);
+
+    /*
+     * If OOB is not enabled on current monitor, we'll emulate the old
+     * behavior that we won't process current monitor any more until
+     * it is responded.  This helps make sure that as long as OOB is
+     * not enabled, the server will never drop any command.
+     */
+    if (!qmp_oob_enabled(mon)) {
+        monitor_suspend(mon);
+    }
+}
+
 static void monitor_qmp_read(void *opaque, const uint8_t *buf, int size)
 {
     Monitor *mon = opaque;
@@ -4144,6 +4266,15 @@ static void monitor_iothread_init(void)
 {
     mon_global.mon_iothread = iothread_create("monitor_iothread",
                                               &error_abort);
+
+    /*
+     * This MUST be on main loop thread since we have commands that
+     * have assumption to be run on main loop thread (Yeah, we'd
+     * better remove this assumption in the future).
+     */
+    mon_global.qmp_dispatcher_bh = aio_bh_new(qemu_get_aio_context(),
+                                              monitor_qmp_bh_dispatcher,
+                                              NULL);
 }
 
 void monitor_init_globals(void)
@@ -4264,6 +4395,10 @@ void monitor_cleanup(void)
     }
     qemu_mutex_unlock(&monitor_lock);
 
+    /* QEMUBHs needs to be deleted before destroying the IOThread. */
+    qemu_bh_delete(mon_global.qmp_dispatcher_bh);
+    mon_global.qmp_dispatcher_bh = NULL;
+
     iothread_destroy(mon_global.mon_iothread);
     mon_global.mon_iothread = NULL;
 }
-- 
2.13.6
