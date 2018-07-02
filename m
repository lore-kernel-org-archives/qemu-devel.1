Received: from eggs.gnu.org ([2001:4830:134:3::10]:42535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa1at-0004RR-CK
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa1ar-0006em-3g
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47590 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fa1aq-0006dG-O2
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F2057DAC2
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 16:22:24 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Jul 2018 18:22:01 +0200
Message-Id: <20180702162218.13678-16-armbru@redhat.com>
In-Reply-To: <20180702162218.13678-1-armbru@redhat.com>
References: <20180702162218.13678-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 15/32] qmp: Simplify code around
 monitor_qmp_dispatch_one()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, eblake@redhat.com, stefanha@redhat.com, dgilbert@redhat.com

Change monitor_qmp_dispatch_one() to take its parameters unwrapped,
move monitor_resume() to the one caller that needs it, rename the
function to monitor_qmp_dispatch().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c | 58 +++++++++++++++++++++++--------------------------------
 1 file changed, 24 insertions(+), 34 deletions(-)

diff --git a/monitor.c b/monitor.c
index 94f5660c3c..51ba1485ad 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4166,20 +4166,10 @@ static void monitor_qmp_respond(Monitor *mon, QObject *rsp,
     qobject_unref(rsp);
 }
 
-/*
- * Dispatch one single QMP request. The function will free the req_obj
- * and objects inside it before return.
- */
-static void monitor_qmp_dispatch_one(QMPRequest *req_obj)
+static void monitor_qmp_dispatch(Monitor *mon, QObject *req, QObject *id)
 {
-    Monitor *mon, *old_mon;
-    QObject *req, *rsp = NULL, *id;
-    bool need_resume;
-
-    req = req_obj->req;
-    mon = req_obj->mon;
-    id = req_obj->id;
-    need_resume = req_obj->need_resume;
+    Monitor *old_mon;
+    QObject *rsp;
 
     old_mon = cur_mon;
     cur_mon = mon;
@@ -4188,15 +4178,7 @@ static void monitor_qmp_dispatch_one(QMPRequest *req_obj)
 
     cur_mon = old_mon;
 
-    /* Respond if necessary */
     monitor_qmp_respond(mon, rsp, NULL, qobject_ref(id));
-
-    /* This pairs with the monitor_suspend() in handle_qmp_command(). */
-    if (need_resume) {
-        monitor_resume(mon);
-    }
-
-    qmp_request_free(req_obj);
 }
 
 /*
@@ -4240,12 +4222,20 @@ static void monitor_qmp_bh_dispatcher(void *data)
 {
     QMPRequest *req_obj = monitor_qmp_requests_pop_any();
 
-    if (req_obj) {
-        trace_monitor_qmp_cmd_in_band(qobject_get_try_str(req_obj->id) ?: "");
-        monitor_qmp_dispatch_one(req_obj);
-        /* Reschedule instead of looping so the main loop stays responsive */
-        qemu_bh_schedule(mon_global.qmp_dispatcher_bh);
+    if (!req_obj) {
+        return;
     }
+
+    trace_monitor_qmp_cmd_in_band(qobject_get_try_str(req_obj->id) ?: "");
+    monitor_qmp_dispatch(req_obj->mon, req_obj->req, req_obj->id);
+    if (req_obj->need_resume) {
+        /* Pairs with the monitor_suspend() in handle_qmp_command() */
+        monitor_resume(req_obj->mon);
+    }
+    qmp_request_free(req_obj);
+
+    /* Reschedule instead of looping so the main loop stays responsive */
+    qemu_bh_schedule(mon_global.qmp_dispatcher_bh);
 }
 
 #define  QMP_REQ_QUEUE_LEN_MAX  (8)
@@ -4291,20 +4281,20 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
         goto err;
     }
 
+    if (qmp_is_oob(qdict)) {
+        /* Out-of-band (OOB) requests are executed directly in parser. */
+        trace_monitor_qmp_cmd_out_of_band(qobject_get_try_str(id)
+                                          ?: "");
+        monitor_qmp_dispatch(mon, req, id);
+        return;
+    }
+
     req_obj = g_new0(QMPRequest, 1);
     req_obj->mon = mon;
     req_obj->id = id;
     req_obj->req = req;
     req_obj->need_resume = false;
 
-    if (qmp_is_oob(qdict)) {
-        /* Out-of-band (OOB) requests are executed directly in parser. */
-        trace_monitor_qmp_cmd_out_of_band(qobject_get_try_str(req_obj->id)
-                                          ?: "");
-        monitor_qmp_dispatch_one(req_obj);
-        return;
-    }
-
     /* Protect qmp_requests and fetching its length. */
     qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
 
-- 
2.17.1
