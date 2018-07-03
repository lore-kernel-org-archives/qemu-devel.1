Received: from eggs.gnu.org ([2001:4830:134:3::10]:34513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faNN2-0002Pm-80
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faNMy-0005NA-J6
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:37:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50140 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faNMy-0005LQ-9w
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:37:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C9A43818B126
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 15:37:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-126.ams2.redhat.com
	[10.36.116.126])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8ADB11C65F
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 15:37:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 17:37:20 +0200
Message-Id: <20180703153728.2175-25-armbru@redhat.com>
In-Reply-To: <20180703153728.2175-1-armbru@redhat.com>
References: <20180703153728.2175-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 24/32] qmp: Replace monitor_json_emitter{,
 raw}() by qmp_{queue, send}_response()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

monitor_json_emitter() and monitor_json_emitter_raw() are
unnecessarily general: they can send arbitrary JSON values, even
though we only ever use them for QMP, which may send only JSON
objects.

Specialize the argument from QObject * to QDict *, and rename to
qmp_queue_response(), qmp_send_response().

All callers but one lose an upcast.  The lone exception gains a
downcast; the next commit will get rid of it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180703085358.13941-25-armbru@redhat.com>
---
 monitor.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/monitor.c b/monitor.c
index 8237b1c916..50dc57c82e 100644
--- a/monitor.c
+++ b/monitor.c
@@ -503,9 +503,9 @@ int monitor_fprintf(FILE *stream, const char *fmt, ...)
     return 0;
 }
 
-static void monitor_json_emitter_raw(Monitor *mon,
-                                     QObject *data)
+static void qmp_send_response(Monitor *mon, QDict *rsp)
 {
+    QObject *data = QOBJECT(rsp);
     QString *json;
 
     json = mon->flags & MONITOR_USE_PRETTY ? qobject_to_json_pretty(data) :
@@ -518,7 +518,7 @@ static void monitor_json_emitter_raw(Monitor *mon,
     qobject_unref(json);
 }
 
-static void monitor_json_emitter(Monitor *mon, QObject *data)
+static void qmp_queue_response(Monitor *mon, QDict *rsp)
 {
     if (mon->use_io_thread) {
         /*
@@ -528,8 +528,7 @@ static void monitor_json_emitter(Monitor *mon, QObject *data)
          * responder thread).
          */
         qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
-        g_queue_push_tail(mon->qmp.qmp_responses,
-                          qobject_ref(qobject_to(QDict, data)));
+        g_queue_push_tail(mon->qmp.qmp_responses, qobject_ref(rsp));
         qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
         qemu_bh_schedule(qmp_respond_bh);
     } else {
@@ -537,7 +536,7 @@ static void monitor_json_emitter(Monitor *mon, QObject *data)
          * If not using monitor I/O thread, then we are in main thread.
          * Do the emission right away.
          */
-        monitor_json_emitter_raw(mon, data);
+        qmp_send_response(mon, rsp);
     }
 }
 
@@ -563,7 +562,7 @@ static void monitor_qmp_response_flush(Monitor *mon)
     QDict *data;
 
     while ((data = monitor_qmp_response_pop_one(mon))) {
-        monitor_json_emitter_raw(mon, QOBJECT(data));
+        qmp_send_response(mon, data);
         qobject_unref(data);
     }
 }
@@ -595,7 +594,7 @@ static void monitor_qmp_bh_responder(void *opaque)
     QMPResponse response;
 
     while (monitor_qmp_response_pop_any(&response)) {
-        monitor_json_emitter_raw(response.mon, QOBJECT(response.data));
+        qmp_send_response(response.mon, response.data);
         qobject_unref(response.data);
     }
 }
@@ -622,7 +621,7 @@ static void monitor_qapi_event_emit(QAPIEvent event, QDict *qdict)
     QTAILQ_FOREACH(mon, &mon_list, entry) {
         if (monitor_is_qmp(mon)
             && mon->qmp.commands != &qmp_cap_negotiation_commands) {
-            monitor_json_emitter(mon, QOBJECT(qdict));
+            qmp_queue_response(mon, qdict);
         }
     }
 }
@@ -4118,7 +4117,7 @@ static void monitor_qmp_respond(Monitor *mon, QDict *rsp,
             qdict_put_obj(rsp, "id", qobject_ref(id));
         }
 
-        monitor_json_emitter(mon, QOBJECT(rsp));
+        qmp_queue_response(mon, rsp);
     }
 
     qobject_unref(id);
@@ -4418,7 +4417,7 @@ static void monitor_qmp_event(void *opaque, int event)
         mon->qmp.commands = &qmp_cap_negotiation_commands;
         monitor_qmp_caps_reset(mon);
         data = get_qmp_greeting(mon);
-        monitor_json_emitter(mon, data);
+        qmp_queue_response(mon, qobject_to(QDict, data));
         qobject_unref(data);
         mon_refcount++;
         break;
-- 
2.17.1
