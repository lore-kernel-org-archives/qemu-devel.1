Received: from eggs.gnu.org ([2001:4830:134:3::10]:46373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fadPy-0001Qp-2e
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 04:45:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fadPu-00060j-Vh
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 04:45:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34132 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fadPu-0005zz-Ps
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 04:45:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 540964078BBB
	for <qemu-devel@nongnu.org>; Wed,  4 Jul 2018 08:45:38 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  4 Jul 2018 16:45:05 +0800
Message-Id: <20180704084507.14560-8-peterx@redhat.com>
In-Reply-To: <20180704084507.14560-1-peterx@redhat.com>
References: <20180704084507.14560-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 7/9] monitor: restrict response queue length too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Before this patch we were only monitoring the request queue, but it's
still possible that a client only sends requests but it never eats any
reply from us.  In that case our response queue might grow with
unlimited responses and put us at risk.

Now we play the similar trick as we have done to the request queue to
make sure we apply the same queue length rule to the response queue as
well.  Then we also need to peek at the queue length after we unqueue a
response now, to make sure we'll kick the monitor to alive if it was
suspended due to "response queue full".

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/monitor.c b/monitor.c
index ebf862914f..9b78cf1c63 100644
--- a/monitor.c
+++ b/monitor.c
@@ -393,18 +393,15 @@ static void monitor_qmp_cleanup_queues(Monitor *mon)
     qemu_mutex_unlock(&mon->qmp.qmp_lock);
 }
 
-/* Try to resume the monitor if it was suspended due to any reason */
-static void monitor_qmp_try_resume(Monitor *mon)
+/* Callers must be with Monitor.qmp.qmp_lock held. */
+static void monitor_qmp_try_resume_locked(Monitor *mon)
 {
-    assert(monitor_is_qmp(mon));
-    qemu_mutex_lock(&mon->qmp.qmp_lock);
-
-    if (mon->qmp.qmp_requests->length >= QMP_REQ_QUEUE_LEN_MAX) {
+    if (mon->qmp.qmp_requests->length >= QMP_REQ_QUEUE_LEN_MAX ||
+        mon->qmp.qmp_responses->length >= QMP_REQ_QUEUE_LEN_MAX) {
         /*
          * This should not happen, but in case if it happens, we
          * should still keep the monitor in suspend state
          */
-        qemu_mutex_unlock(&mon->qmp.qmp_lock);
         return;
     }
 
@@ -412,7 +409,14 @@ static void monitor_qmp_try_resume(Monitor *mon)
         monitor_resume(mon);
         mon->qmp.need_resume = false;
     }
+}
 
+/* Try to resume the monitor if it was suspended due to any reason */
+static void monitor_qmp_try_resume(Monitor *mon)
+{
+    assert(monitor_is_qmp(mon));
+    qemu_mutex_lock(&mon->qmp.qmp_lock);
+    monitor_qmp_try_resume_locked(mon);
     qemu_mutex_unlock(&mon->qmp.qmp_lock);
 }
 
@@ -574,6 +578,8 @@ static QDict *monitor_qmp_response_pop_one(Monitor *mon)
 
     qemu_mutex_lock(&mon->qmp.qmp_lock);
     data = g_queue_pop_head(mon->qmp.qmp_responses);
+    /* In case if we were suspended due to response queue full */
+    monitor_qmp_try_resume_locked(mon);
     qemu_mutex_unlock(&mon->qmp.qmp_lock);
 
     return data;
@@ -4289,12 +4295,13 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
         monitor_qmp_suspend_locked(mon);
     } else {
         /*
-         * If the queue is reaching the length limitation, we queue
-         * this command, meanwhile we suspend the monitor to block new
-         * commands.  We'll resume ourselves until the queue has more
-         * space.
+         * If any of the req/resp queue is reaching the length
+         * limitation, we queue this command, meanwhile we suspend the
+         * monitor to block new commands.  We'll resume ourselves
+         * until both of the queues have more spaces.
          */
-        if (mon->qmp.qmp_requests->length >= QMP_REQ_QUEUE_LEN_MAX - 1) {
+        if (mon->qmp.qmp_requests->length >= QMP_REQ_QUEUE_LEN_MAX - 1 ||
+            mon->qmp.qmp_responses->length >= QMP_REQ_QUEUE_LEN_MAX - 1) {
             monitor_qmp_suspend_locked(mon);
         }
     }
-- 
2.17.1
