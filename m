Received: from eggs.gnu.org ([2001:4830:134:3::10]:50785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fadoH-0004YW-O7
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:10:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fadoF-00010S-CM
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:10:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41210 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fadoF-0000za-7V
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:10:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DF7877262D
	for <qemu-devel@nongnu.org>; Wed,  4 Jul 2018 09:10:46 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  4 Jul 2018 17:10:36 +0800
Message-Id: <20180704091038.29449-2-peterx@redhat.com>
In-Reply-To: <20180704091038.29449-1-peterx@redhat.com>
References: <20180704091038.29449-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 1/3] monitor: allow monitor_qapi_event_emit
 specify mon
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com

This is an internal change to allow monitor_qapi_event_emit() to pass in
specific monitor to send the event.  No functional change.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c    | 37 ++++++++++++++++++++++++++-----------
 trace-events |  2 +-
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/monitor.c b/monitor.c
index 9eb9f06599..94ae7f1c79 100644
--- a/monitor.c
+++ b/monitor.c
@@ -637,20 +637,35 @@ static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
     [QAPI_EVENT_VSERPORT_CHANGE]   = { 1000 * SCALE_MS },
 };
 
+static bool monitor_allows_events(Monitor *mon)
+{
+    return monitor_is_qmp(mon) &&
+        mon->qmp.commands != &qmp_cap_negotiation_commands;
+}
+
+static void monitor_queue_event(Monitor *mon, QDict *qdict)
+{
+    if (monitor_allows_events(mon)) {
+        qmp_queue_response(mon, qdict);
+    }
+}
+
 /*
- * Broadcast an event to all monitors.
+ * Broadcast an event to the monitor specified by @mon, or all
+ * monitors if @mon is NULL.
  * @qdict is the event object.  Its member "event" must match @event.
  * Caller must hold monitor_lock.
  */
-static void monitor_qapi_event_emit(QAPIEvent event, QDict *qdict)
+static void monitor_qapi_event_emit(Monitor *mon, QAPIEvent event,
+                                    QDict *qdict)
 {
-    Monitor *mon;
+    trace_monitor_protocol_event_emit(mon, event, qdict);
 
-    trace_monitor_protocol_event_emit(event, qdict);
-    QTAILQ_FOREACH(mon, &mon_list, entry) {
-        if (monitor_is_qmp(mon)
-            && mon->qmp.commands != &qmp_cap_negotiation_commands) {
-            qmp_queue_response(mon, qdict);
+    if (mon) {
+        monitor_queue_event(mon, qdict);
+    } else {
+        QTAILQ_FOREACH(mon, &mon_list, entry) {
+            monitor_queue_event(mon, qdict);
         }
     }
 }
@@ -675,7 +690,7 @@ monitor_qapi_event_queue(QAPIEvent event, QDict *qdict)
 
     if (!evconf->rate) {
         /* Unthrottled event */
-        monitor_qapi_event_emit(event, qdict);
+        monitor_qapi_event_emit(NULL, event, qdict);
     } else {
         QDict *data = qobject_to(QDict, qdict_get(qdict, "data"));
         MonitorQAPIEventState key = { .event = event, .data = data };
@@ -700,7 +715,7 @@ monitor_qapi_event_queue(QAPIEvent event, QDict *qdict)
              */
             int64_t now = qemu_clock_get_ns(monitor_get_event_clock());
 
-            monitor_qapi_event_emit(event, qdict);
+            monitor_qapi_event_emit(NULL, event, qdict);
 
             evstate = g_new(MonitorQAPIEventState, 1);
             evstate->event = event;
@@ -733,7 +748,7 @@ static void monitor_qapi_event_handler(void *opaque)
     if (evstate->qdict) {
         int64_t now = qemu_clock_get_ns(monitor_get_event_clock());
 
-        monitor_qapi_event_emit(evstate->event, evstate->qdict);
+        monitor_qapi_event_emit(NULL, evstate->event, evstate->qdict);
         qobject_unref(evstate->qdict);
         evstate->qdict = NULL;
         timer_mod_ns(evstate->timer, now + evconf->rate);
diff --git a/trace-events b/trace-events
index c445f54773..d8074bb721 100644
--- a/trace-events
+++ b/trace-events
@@ -43,7 +43,7 @@ qemu_system_powerdown_request(void) ""
 
 # monitor.c
 monitor_protocol_event_handler(uint32_t event, void *qdict) "event=%d data=%p"
-monitor_protocol_event_emit(uint32_t event, void *data) "event=%d data=%p"
+monitor_protocol_event_emit(void *mon, uint32_t event, void *data) "mon=%p event=%d data=%p"
 monitor_protocol_event_queue(uint32_t event, void *qdict, uint64_t rate) "event=%d data=%p rate=%" PRId64
 handle_hmp_command(void *mon, const char *cmdline) "mon %p cmdline: %s"
 handle_qmp_command(void *mon, const char *req) "mon %p req: %s"
-- 
2.17.1
