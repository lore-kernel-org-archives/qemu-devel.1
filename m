Received: from eggs.gnu.org ([2001:4830:134:3::10]:60499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fpw0i-0002im-8k
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 09:38:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fpw0h-0003Xa-7J
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 09:38:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46686 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fpw0g-0003XE-Ua
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 09:38:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8EA4277154
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 13:38:50 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 15 Aug 2018 21:37:44 +0800
Message-Id: <20180815133747.25032-11-peterx@redhat.com>
In-Reply-To: <20180815133747.25032-1-peterx@redhat.com>
References: <20180815133747.25032-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v6 10/13] monitor: add traces for qmp queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

This can help us to track QMP monitor flow controls.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c    | 8 ++++++++
 trace-events | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/monitor.c b/monitor.c
index 10ed853de9..b24a934437 100644
--- a/monitor.c
+++ b/monitor.c
@@ -376,6 +376,7 @@ static void monitor_qmp_cleanup_req_queue_locked(Monitor *mon)
     while (!g_queue_is_empty(mon->qmp.qmp_requests)) {
         qmp_request_free(g_queue_pop_head(mon->qmp.qmp_requests));
     }
+    trace_monitor_qmp_request_queue(mon, 0);
 }
 
 /* Caller must hold the mon->qmp.qmp_lock */
@@ -384,6 +385,7 @@ static void monitor_qmp_cleanup_resp_queue_locked(Monitor *mon)
     while (!g_queue_is_empty(mon->qmp.qmp_responses)) {
         qobject_unref((QDict *)g_queue_pop_head(mon->qmp.qmp_responses));
     }
+    trace_monitor_qmp_response_queue(mon, 0);
 }
 
 static void monitor_qmp_cleanup_queues(Monitor *mon)
@@ -409,6 +411,7 @@ static void monitor_qmp_try_resume_locked(Monitor *mon)
     if (mon->qmp.need_resume) {
         monitor_resume(mon);
         mon->qmp.need_resume = false;
+        trace_monitor_qmp_resume(mon);
     }
 }
 
@@ -556,6 +559,7 @@ static void qmp_queue_response(Monitor *mon, QDict *rsp)
          */
         qemu_mutex_lock(&mon->qmp.qmp_lock);
         g_queue_push_tail(mon->qmp.qmp_responses, qobject_ref(rsp));
+        trace_monitor_qmp_response_queue(mon, mon->qmp.qmp_responses->length);
         qemu_mutex_unlock(&mon->qmp.qmp_lock);
         qemu_bh_schedule(qmp_respond_bh);
     } else {
@@ -579,6 +583,7 @@ static QDict *monitor_qmp_response_pop_one(Monitor *mon)
 
     qemu_mutex_lock(&mon->qmp.qmp_lock);
     data = g_queue_pop_head(mon->qmp.qmp_responses);
+    trace_monitor_qmp_response_queue(mon, mon->qmp.qmp_responses->length);
     /* In case if we were suspended due to response queue full */
     monitor_qmp_try_resume_locked(mon);
     qemu_mutex_unlock(&mon->qmp.qmp_lock);
@@ -4223,6 +4228,7 @@ static QMPRequest *monitor_qmp_requests_pop_any(void)
     QTAILQ_FOREACH(mon, &mon_list, entry) {
         qemu_mutex_lock(&mon->qmp.qmp_lock);
         req_obj = g_queue_pop_head(mon->qmp.qmp_requests);
+        trace_monitor_qmp_request_queue(mon, mon->qmp.qmp_requests->length);
         qemu_mutex_unlock(&mon->qmp.qmp_lock);
         if (req_obj) {
             break;
@@ -4280,6 +4286,7 @@ static void monitor_qmp_suspend_locked(Monitor *mon)
     assert(mon->qmp.need_resume == false);
     monitor_suspend(mon);
     mon->qmp.need_resume = true;
+    trace_monitor_qmp_suspend(mon);
 }
 
 static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
@@ -4353,6 +4360,7 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
      * etc. will be delivered to the handler side.
      */
     g_queue_push_tail(mon->qmp.qmp_requests, req_obj);
+    trace_monitor_qmp_request_queue(mon, mon->qmp.qmp_requests->length);
     qemu_mutex_unlock(&mon->qmp.qmp_lock);
 
     /* Kick the dispatcher routine */
diff --git a/trace-events b/trace-events
index c445f54773..bd9dade938 100644
--- a/trace-events
+++ b/trace-events
@@ -50,6 +50,10 @@ handle_qmp_command(void *mon, const char *req) "mon %p req: %s"
 monitor_suspend(void *ptr, int cnt) "mon %p: %d"
 monitor_qmp_cmd_in_band(const char *id) "%s"
 monitor_qmp_cmd_out_of_band(const char *id) "%s"
+monitor_qmp_suspend(void *mon) "mon=%p"
+monitor_qmp_resume(void *mon) "mon=%p"
+monitor_qmp_request_queue(void *mon, int len) "mon=%p len=%d"
+monitor_qmp_response_queue(void *mon, int len) "mon=%p len=%d"
 
 # dma-helpers.c
 dma_blk_io(void *dbs, void *bs, int64_t offset, bool to_dev) "dbs=%p bs=%p offset=%" PRId64 " to_dev=%d"
-- 
2.17.1
