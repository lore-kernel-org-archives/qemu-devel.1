Received: from eggs.gnu.org ([2001:4830:134:3::10]:53063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faH4Z-0001Rl-42
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faH4W-0007Ew-B0
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51400 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faH4W-0007EP-5L
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:04 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 10:53:52 +0200
Message-Id: <20180703085358.13941-27-armbru@redhat.com>
In-Reply-To: <20180703085358.13941-1-armbru@redhat.com>
References: <20180703085358.13941-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 26/32] qmp: Simplify monitor_qmp_respond()
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

monitor_qmp_respond() takes both a response object and an error
object.  If an error object is non-null, the response object must be
null, and the response is built from the error object.

Of the two callers, one always passes a null response object, and one
a null error object.  Move building the response object from the error
object to the latter, and drop the error object parameter.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 monitor.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/monitor.c b/monitor.c
index ba3124514c..876a3a23a7 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4099,18 +4099,12 @@ static int monitor_can_read(void *opaque)
 }
 
 /*
- * 1. This function takes ownership of rsp, err, and id.
- * 2. rsp, err, and id may be NULL.
- * 3. If err != NULL then rsp must be NULL.
+ * Emit QMP response @rsp with ID @id to @mon.
+ * Null @rsp can only happen for commands with QCO_NO_SUCCESS_RESP.
+ * Nothing is emitted then.
  */
-static void monitor_qmp_respond(Monitor *mon, QDict *rsp,
-                                Error *err, QObject *id)
+static void monitor_qmp_respond(Monitor *mon, QDict *rsp, QObject *id)
 {
-    if (err) {
-        assert(!rsp);
-        rsp = qmp_error_response(err);
-    }
-
     if (rsp) {
         if (id) {
             qdict_put_obj(rsp, "id", qobject_ref(id));
@@ -4118,9 +4112,6 @@ static void monitor_qmp_respond(Monitor *mon, QDict *rsp,
 
         qmp_queue_response(mon, rsp);
     }
-
-    qobject_unref(id);
-    qobject_unref(rsp);
 }
 
 static void monitor_qmp_dispatch(Monitor *mon, QObject *req, QObject *id)
@@ -4148,8 +4139,8 @@ static void monitor_qmp_dispatch(Monitor *mon, QObject *req, QObject *id)
         }
     }
 
-    /* Respond if necessary */
-    monitor_qmp_respond(mon, rsp, NULL, qobject_ref(id));
+    monitor_qmp_respond(mon, rsp, id);
+    qobject_unref(rsp);
 }
 
 /*
@@ -4192,6 +4183,7 @@ static QMPRequest *monitor_qmp_requests_pop_any(void)
 static void monitor_qmp_bh_dispatcher(void *data)
 {
     QMPRequest *req_obj = monitor_qmp_requests_pop_any();
+    QDict *rsp;
 
     if (!req_obj) {
         return;
@@ -4202,7 +4194,9 @@ static void monitor_qmp_bh_dispatcher(void *data)
         monitor_qmp_dispatch(req_obj->mon, req_obj->req, req_obj->id);
     } else {
         assert(req_obj->err);
-        monitor_qmp_respond(req_obj->mon, NULL, req_obj->err, NULL);
+        rsp = qmp_error_response(req_obj->err);
+        monitor_qmp_respond(req_obj->mon, rsp, NULL);
+        qobject_unref(rsp);
     }
 
     if (req_obj->need_resume) {
-- 
2.17.1
