Received: from eggs.gnu.org ([2001:4830:134:3::10]:36143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxmA8-0006Ub-0c
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:40:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxmA2-0007As-W8
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:40:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dxmA2-0007AM-LI
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:40:22 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 29 Sep 2017 11:38:35 +0800
Message-Id: <20170929033844.26935-14-peterx@redhat.com>
In-Reply-To: <20170929033844.26935-1-peterx@redhat.com>
References: <20170929033844.26935-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v2 13/22] monitor: separate QMP parser and
 dispatcher
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

The isloation is done using one QEMUBH. Only one dispatcher QEMUBH is
used for all the monitors.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 156 +++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 133 insertions(+), 23 deletions(-)

diff --git a/monitor.c b/monitor.c
index 7b76dff5ad..1e9a6cb6a5 100644
--- a/monitor.c
+++ b/monitor.c
@@ -208,10 +208,14 @@ struct Monitor {
     mon_cmd_t *cmd_table;
     QLIST_HEAD(,mon_fd_t) fds;
     QTAILQ_ENTRY(Monitor) entry;
+    /* Input queue that hangs all the parsed QMP requests */
+    GQueue *qmp_requests;
 };
 
 struct MonitorGlobal {
     IOThread *mon_io_thread;
+    /* Bottom half to dispatch the requests received from IO thread */
+    QEMUBH *qmp_dispatcher_bh;
 };
 
 static struct MonitorGlobal mon_global;
@@ -586,6 +590,7 @@ static void monitor_data_init(Monitor *mon, bool skip_flush,
     mon->cmd_table = mon_cmds;
     mon->skip_flush = skip_flush;
     mon->use_io_thr = use_io_thr;
+    mon->qmp_requests = g_queue_new();
 }
 
 static void monitor_data_destroy(Monitor *mon)
@@ -597,6 +602,7 @@ static void monitor_data_destroy(Monitor *mon)
     g_free(mon->rs);
     QDECREF(mon->outbuf);
     qemu_mutex_destroy(&mon->out_lock);
+    g_queue_free(mon->qmp_requests);
 }
 
 char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
@@ -3861,29 +3867,31 @@ static void monitor_qmp_respond(Monitor *mon, QObject *rsp,
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
@@ -3894,7 +3902,7 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens,
     old_mon = cur_mon;
     cur_mon = mon;
 
-    rsp = qmp_dispatch(cur_mon->qmp.commands, req);
+    rsp = qmp_dispatch(mon->qmp.commands, req);
 
     cur_mon = old_mon;
 
@@ -3910,12 +3918,101 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens,
         }
     }
 
-err_out:
-    monitor_qmp_respond(mon, rsp, err, id);
-
+    /* Respond if necessary */
+    monitor_qmp_respond(mon, rsp, NULL, id);
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
+        req_obj = g_queue_pop_head(mon->qmp_requests);
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
+    g_queue_push_tail(mon->qmp_requests, req_obj);
+
+    /* Kick the dispatcher routine */
+    qemu_bh_schedule(mon_global.qmp_dispatcher_bh);
+}
+
 static void monitor_qmp_read(void *opaque, const uint8_t *buf, int size)
 {
     Monitor *mon = opaque;
@@ -4085,6 +4182,15 @@ static void monitor_io_thread_init(void)
      * fetch the context we'll have that initialized.
      */
     monitor_io_context_get();
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
@@ -4188,6 +4294,10 @@ void monitor_init(Chardev *chr, int flags)
 
 static void monitor_io_thread_destroy(void)
 {
+    /* QEMUBHs needs to be deleted before destroying the IOThread. */
+    qemu_bh_delete(mon_global.qmp_dispatcher_bh);
+    mon_global.qmp_dispatcher_bh = NULL;
+
     iothread_destroy(mon_global.mon_io_thread);
     mon_global.mon_io_thread = NULL;
 }
-- 
2.13.5
