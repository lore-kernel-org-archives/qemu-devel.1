Received: from eggs.gnu.org ([2001:4830:134:3::10]:58791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fNXeQ-0004Tz-Mh
	for qemu-devel@nongnu.org; Tue, 29 May 2018 01:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fNXeP-0001Qg-Si
	for qemu-devel@nongnu.org; Tue, 29 May 2018 01:58:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52728 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fNXeP-0001QW-N6
	for qemu-devel@nongnu.org; Tue, 29 May 2018 01:58:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 389E7401EF09
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 05:58:29 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue, 29 May 2018 13:57:53 +0800
Message-Id: <20180529055755.12404-6-peterx@redhat.com>
In-Reply-To: <20180529055755.12404-1-peterx@redhat.com>
References: <20180529055755.12404-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v9 5/7] monitor: remove event_clock_type
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
problem is that the old code will let monitor initialization depends on
qtest_enabled().  After this change, we don't have such a dependency any
more.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/monitor.c b/monitor.c
index 2504696d76..bd9ab5597f 100644
--- a/monitor.c
+++ b/monitor.c
@@ -282,8 +282,6 @@ QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
 
 Monitor *cur_mon;
 
-static QEMUClockType event_clock_type = QEMU_CLOCK_REALTIME;
-
 static void monitor_command_cb(void *opaque, const char *cmdline,
                                void *readline_opaque);
 
@@ -310,6 +308,15 @@ static inline bool monitor_is_hmp_non_interactive(const Monitor *mon)
     return !monitor_is_qmp(mon) && !monitor_uses_readline(mon);
 }
 
+static inline QEMUClockType monitor_get_clock(void)
+{
+    if (qtest_enabled()) {
+        return QEMU_CLOCK_VIRTUAL;
+    } else {
+        return QEMU_CLOCK_REALTIME;
+    }
+}
+
 /**
  * Is the current monitor, if any, a QMP monitor?
  */
@@ -633,7 +640,7 @@ monitor_qapi_event_queue(QAPIEvent event, QDict *qdict, Error **errp)
              * monitor_qapi_event_handler() in evconf->rate ns.  Any
              * events arriving before then will be delayed until then.
              */
-            int64_t now = qemu_clock_get_ns(event_clock_type);
+            int64_t now = qemu_clock_get_ns(monitor_get_clock());
 
             monitor_qapi_event_emit(event, qdict);
 
@@ -641,7 +648,7 @@ monitor_qapi_event_queue(QAPIEvent event, QDict *qdict, Error **errp)
             evstate->event = event;
             evstate->data = qobject_ref(data);
             evstate->qdict = NULL;
-            evstate->timer = timer_new_ns(event_clock_type,
+            evstate->timer = timer_new_ns(monitor_get_clock(),
                                           monitor_qapi_event_handler,
                                           evstate);
             g_hash_table_add(monitor_qapi_event_state, evstate);
@@ -666,7 +673,7 @@ static void monitor_qapi_event_handler(void *opaque)
     qemu_mutex_lock(&monitor_lock);
 
     if (evstate->qdict) {
-        int64_t now = qemu_clock_get_ns(event_clock_type);
+        int64_t now = qemu_clock_get_ns(monitor_get_clock());
 
         monitor_qapi_event_emit(evstate->event, evstate->qdict);
         qobject_unref(evstate->qdict);
@@ -722,10 +729,6 @@ static gboolean qapi_event_throttle_equal(const void *a, const void *b)
 
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
2.17.0
