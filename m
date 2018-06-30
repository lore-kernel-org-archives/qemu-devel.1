Received: from eggs.gnu.org ([2001:4830:134:3::10]:55928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fZIiz-0008Tk-N8
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 12:27:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fZIiy-0007Zz-8h
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 12:27:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32876 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fZIiy-0007ZJ-2I
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 12:27:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A63F3401EF15
	for <qemu-devel@nongnu.org>; Sat, 30 Jun 2018 16:27:47 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Sat, 30 Jun 2018 18:27:41 +0200
Message-Id: <20180630162744.15920-3-armbru@redhat.com>
In-Reply-To: <20180630162744.15920-1-armbru@redhat.com>
References: <20180630162744.15920-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 2/5] monitor: rename *_pop_one to *_pop_any
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

The old names are confusing since both of the old functions are popping
an item from multiple queues rather than a single queue.  In that
sense, *_pop_any() suites better than *_pop_one().

Since at it, touch up the function monitor_qmp_response_pop_any() a bit
to let the callers pass in a QMPResponse struct instead of returning a
struct.  Change the return value to boolean to mark whether we have
popped a valid response instead.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180620073223.31964-3-peterx@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/monitor.c b/monitor.c
index 7b473aad1f..2881345758 100644
--- a/monitor.c
+++ b/monitor.c
@@ -542,10 +542,10 @@ struct QMPResponse {
 typedef struct QMPResponse QMPResponse;
 
 /*
- * Return one QMPResponse.  The response is only valid if
- * response.data is not NULL.
+ * Pop a QMPResponse from any monitor's response queue into @response.
+ * Return false if all the queues are empty; else true.
  */
-static QMPResponse monitor_qmp_response_pop_one(void)
+static bool monitor_qmp_response_pop_any(QMPResponse *response)
 {
     Monitor *mon;
     QObject *data = NULL;
@@ -556,22 +556,20 @@ static QMPResponse monitor_qmp_response_pop_one(void)
         data = g_queue_pop_head(mon->qmp.qmp_responses);
         qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
         if (data) {
+            response->mon = mon;
+            response->data = data;
             break;
         }
     }
     qemu_mutex_unlock(&monitor_lock);
-    return (QMPResponse) { .mon = mon, .data = data };
+    return data != NULL;
 }
 
 static void monitor_qmp_bh_responder(void *opaque)
 {
     QMPResponse response;
 
-    while (true) {
-        response = monitor_qmp_response_pop_one();
-        if (!response.data) {
-            break;
-        }
+    while (monitor_qmp_response_pop_any(&response)) {
         monitor_json_emitter_raw(response.mon, response.data);
         qobject_unref(response.data);
     }
@@ -4199,7 +4197,7 @@ static void monitor_qmp_dispatch_one(QMPRequest *req_obj)
  * when we process one request on a specific monitor, we put that
  * monitor to the end of mon_list queue.
  */
-static QMPRequest *monitor_qmp_requests_pop_one(void)
+static QMPRequest *monitor_qmp_requests_pop_any(void)
 {
     QMPRequest *req_obj = NULL;
     Monitor *mon;
@@ -4231,7 +4229,7 @@ static QMPRequest *monitor_qmp_requests_pop_one(void)
 
 static void monitor_qmp_bh_dispatcher(void *data)
 {
-    QMPRequest *req_obj = monitor_qmp_requests_pop_one();
+    QMPRequest *req_obj = monitor_qmp_requests_pop_any();
 
     if (req_obj) {
         trace_monitor_qmp_cmd_in_band(qobject_get_try_str(req_obj->id) ?: "");
-- 
2.17.1
