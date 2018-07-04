Received: from eggs.gnu.org ([2001:4830:134:3::10]:50805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fadoJ-0004Zm-Au
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:10:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fadoI-00015e-4p
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:10:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41218 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fadoH-00014d-W2
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:10:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A2DD8701E3
	for <qemu-devel@nongnu.org>; Wed,  4 Jul 2018 09:10:49 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  4 Jul 2018 17:10:37 +0800
Message-Id: <20180704091038.29449-3-peterx@redhat.com>
In-Reply-To: <20180704091038.29449-1-peterx@redhat.com>
References: <20180704091038.29449-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 2/3] monitor: let QMPEventFuncEmit take a monitor
 arg
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

Let the QMPEventFuncEmit to take an extra Monitor* argument to allow
send events to specific monitor in follow-up patches.

Now we make the throttling of the events be per-monitor too.  There will
be a relatively complex scenario where we have an event for both
per-monitor and to-all-monitors, please refer to the comments in the
code for some details.

No functional change yet.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qapi/qmp-event.h |  6 +++++-
 monitor.c                | 27 +++++++++++++++++++++++----
 tests/test-qmp-event.c   |  2 +-
 scripts/qapi/events.py   |  2 +-
 4 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/include/qapi/qmp-event.h b/include/qapi/qmp-event.h
index 23e588ccf8..89ddfefe5a 100644
--- a/include/qapi/qmp-event.h
+++ b/include/qapi/qmp-event.h
@@ -14,7 +14,11 @@
 #ifndef QMP_EVENT_H
 #define QMP_EVENT_H
 
-typedef void (*QMPEventFuncEmit)(unsigned event, QDict *dict);
+/*
+ * Send an @event to the monitor specified in @mon.  If @mon is NULL,
+ * then send the event to all the available monitors.
+ */
+typedef void (*QMPEventFuncEmit)(Monitor *mon, unsigned event, QDict *dict);
 
 void qmp_event_set_func_emit(QMPEventFuncEmit emit);
 
diff --git a/monitor.c b/monitor.c
index 94ae7f1c79..48b5f0e21b 100644
--- a/monitor.c
+++ b/monitor.c
@@ -200,6 +200,7 @@ typedef struct {
  * instance.
  */
 typedef struct MonitorQAPIEventState {
+    Monitor *mon;       /* The monitor to emit the event; NULL to all */
     QAPIEvent event;    /* Throttling state for this event type and... */
     QDict *data;        /* ... data, see qapi_event_throttle_equal() */
     QEMUTimer *timer;   /* Timer for handling delayed events */
@@ -673,11 +674,11 @@ static void monitor_qapi_event_emit(Monitor *mon, QAPIEvent event,
 static void monitor_qapi_event_handler(void *opaque);
 
 /*
- * Queue a new event for emission to Monitor instances,
+ * Queue a new event for emission to one Monitor instance or all,
  * applying any rate limiting if required.
  */
 static void
-monitor_qapi_event_queue(QAPIEvent event, QDict *qdict)
+monitor_qapi_event_queue(Monitor *mon, QAPIEvent event, QDict *qdict)
 {
     MonitorQAPIEventConf *evconf;
     MonitorQAPIEventState *evstate;
@@ -693,7 +694,8 @@ monitor_qapi_event_queue(QAPIEvent event, QDict *qdict)
         monitor_qapi_event_emit(NULL, event, qdict);
     } else {
         QDict *data = qobject_to(QDict, qdict_get(qdict, "data"));
-        MonitorQAPIEventState key = { .event = event, .data = data };
+        MonitorQAPIEventState key = { .mon = mon, .event = event,
+                                      .data = data };
 
         evstate = g_hash_table_lookup(monitor_qapi_event_state, &key);
         assert(!evstate || timer_pending(evstate->timer));
@@ -715,9 +717,10 @@ monitor_qapi_event_queue(QAPIEvent event, QDict *qdict)
              */
             int64_t now = qemu_clock_get_ns(monitor_get_event_clock());
 
-            monitor_qapi_event_emit(NULL, event, qdict);
+            monitor_qapi_event_emit(mon, event, qdict);
 
             evstate = g_new(MonitorQAPIEventState, 1);
+            evstate->mon = mon;
             evstate->event = event;
             evstate->data = qobject_ref(data);
             evstate->qdict = NULL;
@@ -787,6 +790,22 @@ static gboolean qapi_event_throttle_equal(const void *a, const void *b)
         return FALSE;
     }
 
+    /*
+     * We do event throttling per-monitor.  It's still possible that
+     * we have one event that are both throttled by one per-monitor
+     * MonitorQAPIEventState, and another global MonitorQAPIEventState
+     * for the same event, but it's not a big problem since one event
+     * should either be for per-monitor or for globally, so generally
+     * we should not have this happened.  Even if it happens, the
+     * worst case is that we'll double the throttle for that specific
+     * monitor to receive the events, so it might receive the events
+     * in 2*rate speed, that'll still keep it away from event
+     * flooding.  It'll only be the rate that will be inaccurate.
+     */
+    if (eva->mon != evb->mon) {
+        return FALSE;
+    }
+
     if (eva->event == QAPI_EVENT_VSERPORT_CHANGE) {
         return !strcmp(qdict_get_str(eva->data, "id"),
                        qdict_get_str(evb->data, "id"));
diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
index 9cddd72adb..8d59d4898e 100644
--- a/tests/test-qmp-event.c
+++ b/tests/test-qmp-event.c
@@ -95,7 +95,7 @@ static bool qdict_cmp_simple(QDict *a, QDict *b)
 
 /* This function is hooked as final emit function, which can verify the
    correctness. */
-static void event_test_emit(test_QAPIEvent event, QDict *d)
+static void event_test_emit(Monitor *mon, test_QAPIEvent event, QDict *d)
 {
     QDict *t;
     int64_t s, ms;
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index 3953dc9837..fec0168af7 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -121,7 +121,7 @@ def gen_event_send(name, arg_type, boxed, event_enum_name):
 ''')
 
     ret += mcgen('''
-    emit(%(c_enum)s, qmp);
+    emit(NULL, %(c_enum)s, qmp);
 
 ''',
                  c_enum=c_enum_const(event_enum_name, name))
-- 
2.17.1
