Received: from eggs.gnu.org ([2001:4830:134:3::10]:47393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fR8VE-0004ia-Ap
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 23:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fR8VC-00074u-4t
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 23:55:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34752 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fR8VC-00074m-02
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 23:55:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 861CD80125D6
	for <qemu-devel@nongnu.org>; Fri,  8 Jun 2018 03:55:49 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri,  8 Jun 2018 11:55:09 +0800
Message-Id: <20180608035511.7439-6-peterx@redhat.com>
In-Reply-To: <20180608035511.7439-1-peterx@redhat.com>
References: <20180608035511.7439-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v10 5/7] monitor: remove event_clock_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Instead, use a dynamic function to detect which clock we'll use.  The
problem is that the old code will let monitor initialization depend on
configure_accelerator() (that's where qtest_enabled() start to take
effect).  After this change, we don't have such a dependency any more.
We just need to make sure configure_accelerator() is called when we
start to use it.  Now it's only used in monitor_qapi_event_queue() and
monitor_qapi_event_handler(), so we're good.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/monitor.c b/monitor.c
index fa9c35631f..2bda0dfa12 100644
--- a/monitor.c
+++ b/monitor.c
@@ -281,8 +281,6 @@ QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
 
 Monitor *cur_mon;
 
-static QEMUClockType event_clock_type = QEMU_CLOCK_REALTIME;
-
 static void monitor_command_cb(void *opaque, const char *cmdline,
                                void *readline_opaque);
 
@@ -309,6 +307,19 @@ static inline bool monitor_is_hmp_non_interactive(const Monitor *mon)
     return !monitor_is_qmp(mon) && !monitor_uses_readline(mon);
 }
 
+/*
+ * This should never be called before configure_accelerator() since
+ * only until then could we know whether qtest was enabled or not.
+ */
+static inline QEMUClockType monitor_get_clock(void)
+{
+    /*
+     * This allows us to perform tests on the monitor queues to verify
+     * that the rate limits are enforced.
+     */
+    return qtest_enabled() ? QEMU_CLOCK_VIRTUAL : QEMU_CLOCK_REALTIME;
+}
+
 /**
  * Is the current monitor, if any, a QMP monitor?
  */
@@ -632,7 +643,7 @@ monitor_qapi_event_queue(QAPIEvent event, QDict *qdict, Error **errp)
              * monitor_qapi_event_handler() in evconf->rate ns.  Any
              * events arriving before then will be delayed until then.
              */
-            int64_t now = qemu_clock_get_ns(event_clock_type);
+            int64_t now = qemu_clock_get_ns(monitor_get_clock());
 
             monitor_qapi_event_emit(event, qdict);
 
@@ -640,7 +651,7 @@ monitor_qapi_event_queue(QAPIEvent event, QDict *qdict, Error **errp)
             evstate->event = event;
             evstate->data = qobject_ref(data);
             evstate->qdict = NULL;
-            evstate->timer = timer_new_ns(event_clock_type,
+            evstate->timer = timer_new_ns(monitor_get_clock(),
                                           monitor_qapi_event_handler,
                                           evstate);
             g_hash_table_add(monitor_qapi_event_state, evstate);
@@ -665,7 +676,7 @@ static void monitor_qapi_event_handler(void *opaque)
     qemu_mutex_lock(&monitor_lock);
 
     if (evstate->qdict) {
-        int64_t now = qemu_clock_get_ns(event_clock_type);
+        int64_t now = qemu_clock_get_ns(monitor_get_clock());
 
         monitor_qapi_event_emit(evstate->event, evstate->qdict);
         qobject_unref(evstate->qdict);
@@ -721,10 +732,6 @@ static gboolean qapi_event_throttle_equal(const void *a, const void *b)
 
 static void monitor_qapi_event_init(void)
 {
-    if (qtest_enabled()) {
-        event_clock_type = QEMU_CLOCK_VIRTUAL;
-    }
-
     monitor_qapi_event_state = g_hash_table_new(qapi_event_throttle_hash,
                                                 qapi_event_throttle_equal);
     qmp_event_set_func_emit(monitor_qapi_event_queue);
-- 
2.17.1
