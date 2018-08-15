Received: from eggs.gnu.org ([2001:4830:134:3::10]:60612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fpw0z-0002yf-7z
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 09:39:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fpw0y-0003fd-7k
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 09:39:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53130 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fpw0x-0003f9-Rx
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 09:39:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 751677D84D
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 13:39:07 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 15 Aug 2018 21:37:47 +0800
Message-Id: <20180815133747.25032-14-peterx@redhat.com>
In-Reply-To: <20180815133747.25032-1-peterx@redhat.com>
References: <20180815133747.25032-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v6 13/13] monitor: reduce different code path
 for oob
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

Markus suggests that we should reduce special code paths for out-of-band
if possible, so that QMP logic can be simplified.  Apply this rule to
two places where use_io_thread is used but not completely necessary.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/monitor.c b/monitor.c
index b24a934437..7494885890 100644
--- a/monitor.c
+++ b/monitor.c
@@ -552,23 +552,15 @@ static void qmp_send_response(Monitor *mon, QDict *rsp)
 
 static void qmp_queue_response(Monitor *mon, QDict *rsp)
 {
-    if (mon->use_io_thread) {
-        /*
-         * Push a reference to the response queue.  The I/O thread
-         * drains that queue and emits.
-         */
-        qemu_mutex_lock(&mon->qmp.qmp_lock);
-        g_queue_push_tail(mon->qmp.qmp_responses, qobject_ref(rsp));
-        trace_monitor_qmp_response_queue(mon, mon->qmp.qmp_responses->length);
-        qemu_mutex_unlock(&mon->qmp.qmp_lock);
-        qemu_bh_schedule(qmp_respond_bh);
-    } else {
-        /*
-         * Not using monitor I/O thread, i.e. we are in the main thread.
-         * Emit right away.
-         */
-        qmp_send_response(mon, rsp);
-    }
+    /*
+     * Push a reference to the response queue.  The I/O thread drains
+     * that queue and emits.
+     */
+    qemu_mutex_lock(&mon->qmp.qmp_lock);
+    g_queue_push_tail(mon->qmp.qmp_responses, qobject_ref(rsp));
+    trace_monitor_qmp_response_queue(mon, mon->qmp.qmp_responses->length);
+    qemu_mutex_unlock(&mon->qmp.qmp_lock);
+    qemu_bh_schedule(qmp_respond_bh);
 }
 
 struct QMPResponse {
@@ -4433,12 +4425,9 @@ void monitor_resume(Monitor *mon)
     if (atomic_dec_fetch(&mon->suspend_cnt) == 0) {
         if (monitor_is_qmp(mon)) {
             /*
-             * For QMP monitors that are running in the I/O thread,
-             * let's kick the thread in case it's sleeping.
+             * Let's kick the thread in case it's sleeping.
              */
-            if (mon->use_io_thread) {
-                aio_notify(iothread_get_aio_context(mon_iothread));
-            }
+            aio_notify(iothread_get_aio_context(mon_iothread));
         } else {
             assert(mon->rs);
             readline_show_prompt(mon->rs);
-- 
2.17.1
