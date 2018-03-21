Received: from eggs.gnu.org ([2001:4830:134:3::10]:49050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycJe-0006ii-J4
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:54:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycJc-00009a-PR
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:54:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53284 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eycJc-00009I-Jk
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:54:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 27B384001852
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 11:54:00 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 12:52:03 +0100
Message-Id: <20180321115211.17937-42-marcandre.lureau@redhat.com>
In-Reply-To: <20180321115211.17937-1-marcandre.lureau@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 41/49] qapi: add a top-unit 'target' schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Add a 'target' top-unit to be compiled seperately from the common qapi
modules, in order to allow poisoined target #ifdef.

The generated commands must be registered seperately.

The events have a different enum, and must thus use a different
limiter/emitter.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi/qapi-schema.json    |   1 +
 qapi/target.json         |  13 +++
 include/qapi/qmp-event.h |   4 +
 monitor.c                | 205 ++++++++++++++++++++++++++-------------
 qapi/qmp-event.c         |  11 +++
 Makefile                 |   1 +
 Makefile.target          |   2 +
 7 files changed, 170 insertions(+), 67 deletions(-)
 create mode 100644 qapi/target.json

diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 25bce78352..6e7f85ae6d 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -93,3 +93,4 @@
 { 'include': 'trace.json' }
 { 'include': 'introspect.json' }
 { 'include': 'misc.json' }
+{ 'include': 'target.json' }
diff --git a/qapi/target.json b/qapi/target.json
new file mode 100644
index 0000000000..be2360ca34
--- /dev/null
+++ b/qapi/target.json
@@ -0,0 +1,13 @@
+# -*- Mode: Python -*-
+#
+
+##
+# =3D Target-specific commands & events
+##
+
+{ 'pragma': { 'top-unit': 'target' } }
+
+##
+# @DUMMY:
+##
+{ 'event': 'DUMMY' }
diff --git a/include/qapi/qmp-event.h b/include/qapi/qmp-event.h
index 0c87ad833e..cdf3b9b970 100644
--- a/include/qapi/qmp-event.h
+++ b/include/qapi/qmp-event.h
@@ -21,5 +21,9 @@ void qmp_event_set_func_emit(QMPEventFuncEmit emit);
=20
 QMPEventFuncEmit qmp_event_get_func_emit(void);
=20
+void target_qmp_event_set_func_emit(QMPEventFuncEmit emit);
+
+QMPEventFuncEmit target_qmp_event_get_func_emit(void);
+
 QDict *qmp_event_build_dict(const char *event_name);
 #endif
diff --git a/monitor.c b/monitor.c
index 0d84c3edb4..0b96285e94 100644
--- a/monitor.c
+++ b/monitor.c
@@ -77,6 +77,8 @@
 #include "block/qapi.h"
 #include "qapi/qapi-commands.h"
 #include "qapi/qapi-events.h"
+#include "qapi/target-qapi-commands.h"
+#include "qapi/target-qapi-events.h"
 #include "qapi/error.h"
 #include "qapi/qmp-event.h"
 #include "qapi/qapi-introspect.h"
@@ -184,22 +186,25 @@ typedef struct {
     GQueue *qmp_responses;
 } MonitorQMP;
=20
+typedef struct {
+    GHashTable *state;
+    const size_t size;    /* size of array =3D=3D number of events */
+    const int64_t rate[]; /* Minimum time (in ns) between two events */
+} MonitorQAPIEventRateLimit;
+
 /*
  * To prevent flooding clients, events can be throttled. The
  * throttling is calculated globally, rather than per-Monitor
  * instance.
  */
 typedef struct MonitorQAPIEventState {
-    QAPIEvent event;    /* Throttling state for this event type and... *=
/
+    const MonitorQAPIEventRateLimit *limiter;
+    unsigned event;     /* Throttling state for this event type and... *=
/
     QDict *data;        /* ... data, see qapi_event_throttle_equal() */
     QEMUTimer *timer;   /* Timer for handling delayed events */
     QDict *qdict;       /* Delayed event (if any) */
 } MonitorQAPIEventState;
=20
-typedef struct {
-    int64_t rate;       /* Minimum time (in ns) between two events */
-} MonitorQAPIEventConf;
-
 struct Monitor {
     CharBackend chr;
     int reset_seen;
@@ -502,23 +507,11 @@ static void monitor_qmp_bh_responder(void *opaque)
     }
 }
=20
-static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] =3D=
 {
-    /* Limit guest-triggerable events to 1 per second */
-    [QAPI_EVENT_RTC_CHANGE]        =3D { 1000 * SCALE_MS },
-    [QAPI_EVENT_WATCHDOG]          =3D { 1000 * SCALE_MS },
-    [QAPI_EVENT_BALLOON_CHANGE]    =3D { 1000 * SCALE_MS },
-    [QAPI_EVENT_QUORUM_REPORT_BAD] =3D { 1000 * SCALE_MS },
-    [QAPI_EVENT_QUORUM_FAILURE]    =3D { 1000 * SCALE_MS },
-    [QAPI_EVENT_VSERPORT_CHANGE]   =3D { 1000 * SCALE_MS },
-};
-
-GHashTable *monitor_qapi_event_state;
-
 /*
  * Emits the event to every monitor instance, @event is only used for tr=
ace
  * Called with monitor_lock held.
  */
-static void monitor_qapi_event_emit(QAPIEvent event, QDict *qdict)
+static void monitor_qapi_event_emit(unsigned event, QDict *qdict)
 {
     Monitor *mon;
=20
@@ -538,30 +531,31 @@ static void monitor_qapi_event_handler(void *opaque=
);
  * applying any rate limiting if required.
  */
 static void
-monitor_qapi_event_queue(QAPIEvent event, QDict *qdict, Error **errp)
+monitor_qapi_event_queue_limit(const MonitorQAPIEventRateLimit *limiter,
+                              unsigned event, QDict *qdict, Error **errp=
)
 {
-    MonitorQAPIEventConf *evconf;
+    int64_t rate;
     MonitorQAPIEventState *evstate;
=20
-    assert(event < QAPI_EVENT__MAX);
-    evconf =3D &monitor_qapi_event_conf[event];
-    trace_monitor_protocol_event_queue(event, qdict, evconf->rate);
+    assert(event < limiter->size);
+    rate =3D limiter->rate[event];
+    trace_monitor_protocol_event_queue(event, qdict, rate);
=20
     qemu_mutex_lock(&monitor_lock);
=20
-    if (!evconf->rate) {
+    if (!rate) {
         /* Unthrottled event */
         monitor_qapi_event_emit(event, qdict);
     } else {
         QDict *data =3D qobject_to(QDict, qdict_get(qdict, "data"));
         MonitorQAPIEventState key =3D { .event =3D event, .data =3D data=
 };
=20
-        evstate =3D g_hash_table_lookup(monitor_qapi_event_state, &key);
+        evstate =3D g_hash_table_lookup(limiter->state, &key);
         assert(!evstate || timer_pending(evstate->timer));
=20
         if (evstate) {
             /*
-             * Timer is pending for (at least) evconf->rate ns after
+             * Timer is pending for (at least) rate ns after
              * last send.  Store event for sending when timer fires,
              * replacing a prior stored event if any.
              */
@@ -570,9 +564,9 @@ monitor_qapi_event_queue(QAPIEvent event, QDict *qdic=
t, Error **errp)
             QINCREF(evstate->qdict);
         } else {
             /*
-             * Last send was (at least) evconf->rate ns ago.
+             * Last send was (at least) rate ns ago.
              * Send immediately, and arm the timer to call
-             * monitor_qapi_event_handler() in evconf->rate ns.  Any
+             * monitor_qapi_event_handler() in rate ns.  Any
              * events arriving before then will be delayed until then.
              */
             int64_t now =3D qemu_clock_get_ns(event_clock_type);
@@ -580,6 +574,7 @@ monitor_qapi_event_queue(QAPIEvent event, QDict *qdic=
t, Error **errp)
             monitor_qapi_event_emit(event, qdict);
=20
             evstate =3D g_new(MonitorQAPIEventState, 1);
+            evstate->limiter =3D limiter;
             evstate->event =3D event;
             evstate->data =3D data;
             QINCREF(evstate->data);
@@ -587,44 +582,14 @@ monitor_qapi_event_queue(QAPIEvent event, QDict *qd=
ict, Error **errp)
             evstate->timer =3D timer_new_ns(event_clock_type,
                                           monitor_qapi_event_handler,
                                           evstate);
-            g_hash_table_add(monitor_qapi_event_state, evstate);
-            timer_mod_ns(evstate->timer, now + evconf->rate);
+            g_hash_table_add(limiter->state, evstate);
+            timer_mod_ns(evstate->timer, now + rate);
         }
     }
=20
     qemu_mutex_unlock(&monitor_lock);
 }
=20
-/*
- * This function runs evconf->rate ns after sending a throttled
- * event.
- * If another event has since been stored, send it.
- */
-static void monitor_qapi_event_handler(void *opaque)
-{
-    MonitorQAPIEventState *evstate =3D opaque;
-    MonitorQAPIEventConf *evconf =3D &monitor_qapi_event_conf[evstate->e=
vent];
-
-    trace_monitor_protocol_event_handler(evstate->event, evstate->qdict)=
;
-    qemu_mutex_lock(&monitor_lock);
-
-    if (evstate->qdict) {
-        int64_t now =3D qemu_clock_get_ns(event_clock_type);
-
-        monitor_qapi_event_emit(evstate->event, evstate->qdict);
-        QDECREF(evstate->qdict);
-        evstate->qdict =3D NULL;
-        timer_mod_ns(evstate->timer, now + evconf->rate);
-    } else {
-        g_hash_table_remove(monitor_qapi_event_state, evstate);
-        QDECREF(evstate->data);
-        timer_free(evstate->timer);
-        g_free(evstate);
-    }
-
-    qemu_mutex_unlock(&monitor_lock);
-}
-
 static unsigned int qapi_event_throttle_hash(const void *key)
 {
     const MonitorQAPIEventState *evstate =3D key;
@@ -663,15 +628,108 @@ static gboolean qapi_event_throttle_equal(const vo=
id *a, const void *b)
     return TRUE;
 }
=20
+static void
+monitor_qapi_event_queue(unsigned event, QDict *qdict, Error **errp)
+{
+    static MonitorQAPIEventRateLimit limiter =3D {
+        .size =3D QAPI_EVENT__MAX,
+        .rate =3D {
+            /* Limit guest-triggerable events to 1 per second */
+            [QAPI_EVENT_RTC_CHANGE]        =3D 1000 * SCALE_MS,
+            [QAPI_EVENT_WATCHDOG]          =3D 1000 * SCALE_MS,
+            [QAPI_EVENT_BALLOON_CHANGE]    =3D 1000 * SCALE_MS,
+            [QAPI_EVENT_QUORUM_REPORT_BAD] =3D 1000 * SCALE_MS,
+            [QAPI_EVENT_QUORUM_FAILURE]    =3D 1000 * SCALE_MS,
+            [QAPI_EVENT_VSERPORT_CHANGE]   =3D 1000 * SCALE_MS,
+            [QAPI_EVENT__MAX]              =3D 0,
+        },
+    };
+
+    if (!limiter.state) {
+        limiter.state =3D g_hash_table_new(qapi_event_throttle_hash,
+                                         qapi_event_throttle_equal);
+    }
+
+    monitor_qapi_event_queue_limit(&limiter, event, qdict, errp);
+}
+
+static unsigned int target_qapi_event_throttle_hash(const void *key)
+{
+    const MonitorQAPIEventState *evstate =3D key;
+    unsigned int hash =3D evstate->event * 255;
+
+    return hash;
+}
+
+static gboolean target_qapi_event_throttle_equal(const void *a, const vo=
id *b)
+{
+    const MonitorQAPIEventState *eva =3D a;
+    const MonitorQAPIEventState *evb =3D b;
+
+    if (eva->event !=3D evb->event) {
+        return FALSE;
+    }
+
+    return TRUE;
+}
+
+static void
+target_monitor_qapi_event_queue(unsigned event, QDict *qdict, Error **er=
rp)
+{
+    static MonitorQAPIEventRateLimit limiter =3D {
+        .size =3D TARGET_QAPI_EVENT__MAX,
+        .rate =3D {
+            /* Limit guest-triggerable events to 1 per second */
+            [TARGET_QAPI_EVENT__MAX]       =3D 0,
+        },
+    };
+
+    if (!limiter.state) {
+        limiter.state =3D g_hash_table_new(target_qapi_event_throttle_ha=
sh,
+                                         target_qapi_event_throttle_equa=
l);
+    }
+    monitor_qapi_event_queue_limit(&limiter, event, qdict, errp);
+}
+
+/*
+ * This function runs evconf->rate ns after sending a throttled
+ * event.
+ * If another event has since been stored, send it.
+ */
+static void monitor_qapi_event_handler(void *opaque)
+{
+    MonitorQAPIEventState *evstate =3D opaque;
+    const MonitorQAPIEventRateLimit *limiter =3D evstate->limiter;
+    int64_t rate =3D limiter->rate[evstate->event];
+
+    trace_monitor_protocol_event_handler(evstate->event, evstate->qdict)=
;
+    qemu_mutex_lock(&monitor_lock);
+
+    if (evstate->qdict) {
+        int64_t now =3D qemu_clock_get_ns(event_clock_type);
+
+        monitor_qapi_event_emit(evstate->event, evstate->qdict);
+        QDECREF(evstate->qdict);
+        evstate->qdict =3D NULL;
+        timer_mod_ns(evstate->timer, now + rate);
+    } else {
+        g_hash_table_remove(limiter->state, evstate);
+        QDECREF(evstate->data);
+        timer_free(evstate->timer);
+        g_free(evstate);
+    }
+
+    qemu_mutex_unlock(&monitor_lock);
+}
+
 static void monitor_qapi_event_init(void)
 {
     if (qtest_enabled()) {
         event_clock_type =3D QEMU_CLOCK_VIRTUAL;
     }
=20
-    monitor_qapi_event_state =3D g_hash_table_new(qapi_event_throttle_ha=
sh,
-                                                qapi_event_throttle_equa=
l);
     qmp_event_set_func_emit(monitor_qapi_event_queue);
+    target_qmp_event_set_func_emit(target_monitor_qapi_event_queue);
 }
=20
 static void handle_hmp_command(Monitor *mon, const char *cmdline);
@@ -1039,9 +1097,10 @@ CommandInfoList *qmp_query_commands(Error **errp)
     return list;
 }
=20
-EventInfoList *qmp_query_events(Error **errp)
+static void qmp_query_events_list(EventInfoList **list,
+                                  const QEnumLookup *qenum, int max)
 {
-    EventInfoList *info, *ev_list =3D NULL;
+    EventInfoList *info;
     QAPIEvent e;
=20
     for (e =3D 0 ; e < QAPI_EVENT__MAX ; e++) {
@@ -1051,11 +1110,22 @@ EventInfoList *qmp_query_events(Error **errp)
         info->value =3D g_malloc0(sizeof(*info->value));
         info->value->name =3D g_strdup(event_name);
=20
-        info->next =3D ev_list;
-        ev_list =3D info;
+        info->next =3D *list;
+        *list =3D info;
     }
=20
-    return ev_list;
+}
+
+EventInfoList *qmp_query_events(Error **errp)
+{
+    EventInfoList *list =3D NULL;
+
+    qmp_query_events_list(&list, &QAPIEvent_lookup,
+                          QAPI_EVENT__MAX);
+    qmp_query_events_list(&list, &target_QAPIEvent_lookup,
+                          TARGET_QAPI_EVENT__MAX);
+
+    return list;
 }
=20
 /*
@@ -1123,6 +1193,7 @@ static void monitor_init_qmp_commands(void)
=20
     QTAILQ_INIT(&qmp_commands);
     qmp_init_marshal(&qmp_commands);
+    target_qmp_init_marshal(&qmp_commands);
=20
     qmp_register_command(&qmp_commands, "query-qmp-schema",
                          qmp_query_qmp_schema,
diff --git a/qapi/qmp-event.c b/qapi/qmp-event.c
index 9d7e88e84a..72fd83841d 100644
--- a/qapi/qmp-event.c
+++ b/qapi/qmp-event.c
@@ -20,6 +20,7 @@
 #include "qapi/qmp/qjson.h"
=20
 static QMPEventFuncEmit qmp_emit;
+static QMPEventFuncEmit target_qmp_emit;
=20
 void qmp_event_set_func_emit(QMPEventFuncEmit emit)
 {
@@ -31,6 +32,16 @@ QMPEventFuncEmit qmp_event_get_func_emit(void)
     return qmp_emit;
 }
=20
+void target_qmp_event_set_func_emit(QMPEventFuncEmit emit)
+{
+    target_qmp_emit =3D emit;
+}
+
+QMPEventFuncEmit target_qmp_event_get_func_emit(void)
+{
+    return target_qmp_emit;
+}
+
 static void timestamp_put(QDict *qdict)
 {
     int err;
diff --git a/Makefile b/Makefile
index 727ef118f3..93a8ff5b78 100644
--- a/Makefile
+++ b/Makefile
@@ -588,6 +588,7 @@ qapi-modules =3D $(SRC_PATH)/qapi/qapi-schema.json $(=
SRC_PATH)/qapi/common.json \
                $(SRC_PATH)/qapi/rocker.json \
                $(SRC_PATH)/qapi/run-state.json \
                $(SRC_PATH)/qapi/sockets.json \
+               $(SRC_PATH)/qapi/target.json \
                $(SRC_PATH)/qapi/tpm.json \
                $(SRC_PATH)/qapi/trace.json \
                $(SRC_PATH)/qapi/transaction.json \
diff --git a/Makefile.target b/Makefile.target
index 0bb18dff9e..9db617cda9 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -150,6 +150,8 @@ endif
=20
 GENERATED_FILES +=3D hmp-commands.h hmp-commands-info.h
=20
+obj-y +=3D qapi/target-qapi-types.o qapi/target-qapi-visit.o
+obj-y +=3D qapi/target-qapi-events.o qapi/target-qapi-commands.o
 obj-y +=3D qapi/qapi-introspect.o
=20
 endif # CONFIG_SOFTMMU
--=20
2.16.2.521.g9aa15f885a
