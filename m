Received: from eggs.gnu.org ([2001:4830:134:3::10]:58214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fV9I5-0005Ii-JG
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:34:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fV9I4-0003dU-Of
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:34:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33402 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fV9I4-0003dA-KU
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:34:52 -0400
From: Peter Xu <peterx@redhat.com>
Date: Tue, 19 Jun 2018 13:34:21 +0800
Message-Id: <20180619053426.13065-3-peterx@redhat.com>
In-Reply-To: <20180619053426.13065-1-peterx@redhat.com>
References: <20180619053426.13065-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 2/7] monitor: rename *_pop_one to *_pop_any
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, peterx@redhat.com, Eric Auger <eric.auger@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

The old names are confusing since both of the old functions are poping
an item from multiple queues rather than a single queue.  In that
sense, *_pop_any() suites better than *_pop_one().

Since at it, touch up the function monitor_qmp_response_pop_any() a bit
to let the callers pass in a QMPResponse struct instead of returning a
struct.  Change the return value to boolean to mark whether we have
poped a valid response instead.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/monitor.c b/monitor.c
index 6d0cec552e..d4a463f707 100644
--- a/monitor.c
+++ b/monitor.c
@@ -513,10 +513,10 @@ struct QMPResponse {
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
@@ -527,22 +527,20 @@ static QMPResponse monitor_qmp_response_pop_one(void)
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
@@ -4107,7 +4105,7 @@ static void monitor_qmp_dispatch_one(QMPRequest *req_obj)
  * when we process one request on a specific monitor, we put that
  * monitor to the end of mon_list queue.
  */
-static QMPRequest *monitor_qmp_requests_pop_one(void)
+static QMPRequest *monitor_qmp_requests_pop_any(void)
 {
     QMPRequest *req_obj = NULL;
     Monitor *mon;
@@ -4139,7 +4137,7 @@ static QMPRequest *monitor_qmp_requests_pop_one(void)
 
 static void monitor_qmp_bh_dispatcher(void *data)
 {
-    QMPRequest *req_obj = monitor_qmp_requests_pop_one();
+    QMPRequest *req_obj = monitor_qmp_requests_pop_any();
 
     if (req_obj) {
         trace_monitor_qmp_cmd_in_band(qobject_get_try_str(req_obj->id) ?: "");
-- 
2.17.1
