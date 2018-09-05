Received: from eggs.gnu.org ([2001:4830:134:3::10]:37308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fxREB-0006c3-M2
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 02:23:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fxRE6-000765-3d
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 02:23:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44358 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fxRE5-000741-4W
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 02:23:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3519B804BAAC
	for <qemu-devel@nongnu.org>; Wed,  5 Sep 2018 06:23:40 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  5 Sep 2018 14:23:09 +0800
Message-Id: <20180905062313.4059-3-peterx@redhat.com>
In-Reply-To: <20180905062313.4059-1-peterx@redhat.com>
References: <20180905062313.4059-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v8 2/6] monitor: resume the monitor earlier if
 needed
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

Currently when QMP request queue full we won't resume the monitor until
we have completely handled the current command.  It's not necessary
since even before it's handled the queue is already non-full.  Moving
the resume logic earlier before the command execution, hence drop the
need_resume local variable.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/monitor.c b/monitor.c
index a89bb86599..c2c9853f75 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4130,7 +4130,6 @@ static void monitor_qmp_bh_dispatcher(void *data)
 {
     QMPRequest *req_obj = monitor_qmp_requests_pop_any_with_lock();
     QDict *rsp;
-    bool need_resume;
     Monitor *mon;
 
     if (!req_obj) {
@@ -4139,8 +4138,11 @@ static void monitor_qmp_bh_dispatcher(void *data)
 
     mon = req_obj->mon;
     /*  qmp_oob_enabled() might change after "qmp_capabilities" */
-    need_resume = !qmp_oob_enabled(mon) ||
-        mon->qmp.qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX - 1;
+    if (!qmp_oob_enabled(mon) ||
+        mon->qmp.qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX - 1) {
+        /* Pairs with the monitor_suspend() in handle_qmp_command() */
+        monitor_resume(mon);
+    }
     qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
     if (req_obj->req) {
         trace_monitor_qmp_cmd_in_band(qobject_get_try_str(req_obj->id) ?: "");
@@ -4153,10 +4155,6 @@ static void monitor_qmp_bh_dispatcher(void *data)
         qobject_unref(rsp);
     }
 
-    if (need_resume) {
-        /* Pairs with the monitor_suspend() in handle_qmp_command() */
-        monitor_resume(mon);
-    }
     qmp_request_free(req_obj);
 
     /* Reschedule instead of looping so the main loop stays responsive */
-- 
2.17.1
