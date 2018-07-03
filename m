Received: from eggs.gnu.org ([2001:4830:134:3::10]:50363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSxv-00085S-Io
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSxs-0006Be-R4
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:36:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45982 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faSxs-0006AT-JN
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:36:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 040C94007389
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 21:36:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-126.ams2.redhat.com
	[10.36.116.126])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D573720290AC
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 21:35:59 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 23:35:50 +0200
Message-Id: <20180703213556.20619-27-armbru@redhat.com>
In-Reply-To: <20180703213556.20619-1-armbru@redhat.com>
References: <20180703213556.20619-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 26/32] qmp: Simplify monitor_qmp_respond()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

monitor_qmp_respond() takes both a response object and an error
object.  If an error object is non-null, the response object must be
null, and the response is built from the error object.

Of the two callers, one always passes a null response object, and one
a null error object.  Move building the response object from the error
object to the latter, and drop the error object parameter.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180703085358.13941-27-armbru@redhat.com>
---
 monitor.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/monitor.c b/monitor.c
index e5e9f496c2..1da7b8bebf 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4100,18 +4100,12 @@ static int monitor_can_read(void *opaque)
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
@@ -4119,9 +4113,6 @@ static void monitor_qmp_respond(Monitor *mon, QDict *rsp,
 
         qmp_queue_response(mon, rsp);
     }
-
-    qobject_unref(id);
-    qobject_unref(rsp);
 }
 
 static void monitor_qmp_dispatch(Monitor *mon, QObject *req, QObject *id)
@@ -4149,8 +4140,8 @@ static void monitor_qmp_dispatch(Monitor *mon, QObject *req, QObject *id)
         }
     }
 
-    /* Respond if necessary */
-    monitor_qmp_respond(mon, rsp, NULL, qobject_ref(id));
+    monitor_qmp_respond(mon, rsp, id);
+    qobject_unref(rsp);
 }
 
 /*
@@ -4193,6 +4184,7 @@ static QMPRequest *monitor_qmp_requests_pop_any(void)
 static void monitor_qmp_bh_dispatcher(void *data)
 {
     QMPRequest *req_obj = monitor_qmp_requests_pop_any();
+    QDict *rsp;
 
     if (!req_obj) {
         return;
@@ -4203,7 +4195,9 @@ static void monitor_qmp_bh_dispatcher(void *data)
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
