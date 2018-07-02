Received: from eggs.gnu.org ([2001:4830:134:3::10]:42539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa1at-0004RS-Dr
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa1ar-0006eV-1U
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54936 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fa1aq-0006cq-M4
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 287B1407048A
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 16:22:24 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Jul 2018 18:22:04 +0200
Message-Id: <20180702162218.13678-19-armbru@redhat.com>
In-Reply-To: <20180702162218.13678-1-armbru@redhat.com>
References: <20180702162218.13678-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 18/32] qmp: Don't let JSON errors jump the queue
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

handle_qmp_command() reports JSON syntax errors right away.  This is
wrong when OOB is enabled, because the errors can "jump the queue"
then.

The previous commit fixed the same bug for semantic errors, by
delaying the checking until dispatch.  We can't delay the checking, so
delay the reporting.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/monitor.c b/monitor.c
index 7a80e58bf2..fd83a57dda 100644
--- a/monitor.c
+++ b/monitor.c
@@ -253,8 +253,12 @@ struct QMPRequest {
     Monitor *mon;
     /* "id" field of the request */
     QObject *id;
-    /* Request object to be handled */
+    /*
+     * Request object to be handled or Error to be reported
+     * (exactly one of them is non-null)
+     */
     QObject *req;
+    Error *err;
     /*
      * Whether we need to resume the monitor afterward.  This flag is
      * used to emulate the old QMP server behavior that the current
@@ -359,6 +363,7 @@ static void qmp_request_free(QMPRequest *req)
 {
     qobject_unref(req->id);
     qobject_unref(req->req);
+    error_free(req->err);
     g_free(req);
 }
 
@@ -4198,8 +4203,14 @@ static void monitor_qmp_bh_dispatcher(void *data)
         return;
     }
 
-    trace_monitor_qmp_cmd_in_band(qobject_get_try_str(req_obj->id) ?: "");
-    monitor_qmp_dispatch(req_obj->mon, req_obj->req, req_obj->id);
+    if (req_obj->req) {
+        trace_monitor_qmp_cmd_in_band(qobject_get_try_str(req_obj->id) ?: "");
+        monitor_qmp_dispatch(req_obj->mon, req_obj->req, req_obj->id);
+    } else {
+        assert(req_obj->err);
+        monitor_qmp_respond(req_obj->mon, NULL, req_obj->err, NULL);
+    }
+
     if (req_obj->need_resume) {
         /* Pairs with the monitor_suspend() in handle_qmp_command() */
         monitor_resume(req_obj->mon);
@@ -4226,11 +4237,6 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
         /* json_parser_parse_err() sucks: can fail without setting @err */
         error_setg(&err, QERR_JSON_PARSING);
     }
-    if (err) {
-        assert(!req);
-        monitor_qmp_respond(mon, NULL, err, NULL);
-        return;
-    }
 
     qdict = qobject_to(QDict, req);
     if (qdict) {
@@ -4256,6 +4262,7 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
     req_obj->mon = mon;
     req_obj->id = id;
     req_obj->req = req;
+    req_obj->err = err;
     req_obj->need_resume = false;
 
     /* Protect qmp_requests and fetching its length. */
-- 
2.17.1
