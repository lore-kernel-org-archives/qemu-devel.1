Received: from eggs.gnu.org ([2001:4830:134:3::10]:37721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fUuq2-0000yz-VH
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:09:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fUuq1-0000TP-Td
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:08:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36314 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fUuq1-0000Sx-Ln
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:08:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 18A60803F869
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 14:08:57 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 18 Jun 2018 16:08:52 +0200
Message-Id: <20180618140854.17824-6-armbru@redhat.com>
In-Reply-To: <20180618140854.17824-1-armbru@redhat.com>
References: <20180618140854.17824-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 5/7] monitor: remove event_clock_type
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

Instead, use a dynamic function to detect which clock we'll use.  The
problem is that the old code will let monitor initialization depend on
configure_accelerator() (that's where qtest_enabled() start to take
effect).  After this change, we don't have such a dependency any more.
We just need to make sure configure_accelerator() is called when we
start to use it.  Now it's only used in monitor_qapi_event_queue() and
monitor_qapi_event_handler(), so we're good.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180608035511.7439-6-peterx@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[monitor_get_event_clock() name and comment tweaked]
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/monitor.c b/monitor.c
index fa9c35631f..e805e40799 100644
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
+ * Return the clock to use for recording an event's time.
+ * Beware: result is invalid before configure_accelerator().
+ */
+static inline QEMUClockType monitor_get_event_clock(void)
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
+            int64_t now = qemu_clock_get_ns(monitor_get_event_clock());
 
             monitor_qapi_event_emit(event, qdict);
 
@@ -640,7 +651,7 @@ monitor_qapi_event_queue(QAPIEvent event, QDict *qdict, Error **errp)
             evstate->event = event;
             evstate->data = qobject_ref(data);
             evstate->qdict = NULL;
-            evstate->timer = timer_new_ns(event_clock_type,
+            evstate->timer = timer_new_ns(monitor_get_event_clock(),
                                           monitor_qapi_event_handler,
                                           evstate);
             g_hash_table_add(monitor_qapi_event_state, evstate);
@@ -665,7 +676,7 @@ static void monitor_qapi_event_handler(void *opaque)
     qemu_mutex_lock(&monitor_lock);
 
     if (evstate->qdict) {
-        int64_t now = qemu_clock_get_ns(event_clock_type);
+        int64_t now = qemu_clock_get_ns(monitor_get_event_clock());
 
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
