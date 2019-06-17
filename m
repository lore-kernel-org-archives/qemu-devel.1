Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E2BC31E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:58:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2355C206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2355C206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51170 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcwpM-0002Su-Cp
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 14:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40578)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hcwhA-0001wR-Jf
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:49:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hcwh5-0007wU-BL
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:49:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42430)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hcwh4-0007lc-Uc
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:49:27 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 76DB87FDCA
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 18:49:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-177.ams2.redhat.com
 [10.36.117.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A2C7C19746;
 Mon, 17 Jun 2019 18:49:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 80291113301F; Mon, 17 Jun 2019 20:49:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 20:49:00 +0200
Message-Id: <20190617184903.19436-14-armbru@redhat.com>
In-Reply-To: <20190617184903.19436-1-armbru@redhat.com>
References: <20190617184903.19436-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 17 Jun 2019 18:49:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 13/16] monitor: Split out monitor/monitor.c
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kevin Wolf <kwolf@redhat.com>

Move the monitor core infrastructure from monitor/misc.c to
monitor/monitor.c. This is code that can be shared for all targets, so
compile it only once.

What remains in monitor/misc.c after this patch is mostly monitor
command implementations (which could move to hmp-cmds.c or qmp-cmds.c
later) and code that requires a system emulator or is even
target-dependent (including HMP command completion code).

The amount of function and particularly extern variables in
monitor_int.h is probably a bit larger than it needs to be, but this way
no non-trivial code modifications are needed. The interfaces between all
monitor parts can be cleaned up later.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20190613153405.24769-13-kwolf@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Superfluous #include dropped]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS                |   2 +
 include/monitor/monitor.h  |   1 +
 monitor/Makefile.objs      |   2 +-
 monitor/misc.c             | 598 +----------------------------------
 monitor/monitor-internal.h |   1 +
 monitor/monitor.c          | 633 +++++++++++++++++++++++++++++++++++++
 monitor/trace-events       |   2 +-
 7 files changed, 640 insertions(+), 599 deletions(-)
 create mode 100644 monitor/monitor.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 15f21c35e0..d32c5c2313 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1920,6 +1920,7 @@ M: Dr. David Alan Gilbert <dgilbert@redhat.com>
 S: Maintained
 F: monitor/monitor-internal.h
 F: monitor/misc.c
+F: monitor/monitor.c
 F: monitor/hmp*
 F: hmp.h
 F: hmp-commands*.hx
@@ -2044,6 +2045,7 @@ S: Supported
 F: monitor/monitor-internal.h
 F: monitor/qmp*
 F: monitor/misc.c
+F: monitor/monitor.c
 F: docs/devel/*qmp-*
 F: docs/interop/*qmp-*
 F: scripts/qmp/
diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index f9d30e1d78..44ac43df34 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -19,6 +19,7 @@ typedef struct MonitorHMP MonitorHMP;
 bool monitor_cur_is_qmp(void);
=20
 void monitor_init_globals(void);
+void monitor_init_globals_core(void);
 void monitor_init(Chardev *chr, int flags);
 void monitor_cleanup(void);
=20
diff --git a/monitor/Makefile.objs b/monitor/Makefile.objs
index bea8838acc..e91a8581cd 100644
--- a/monitor/Makefile.objs
+++ b/monitor/Makefile.objs
@@ -1,3 +1,3 @@
 obj-y +=3D misc.o
-common-obj-y +=3D qmp.o hmp.o
+common-obj-y +=3D monitor.o qmp.o hmp.o
 common-obj-y +=3D qmp-cmds.o hmp-cmds.o
diff --git a/monitor/misc.c b/monitor/misc.c
index 5756d25590..002aba1030 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -54,7 +54,6 @@
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qstring.h"
 #include "qom/object_interfaces.h"
-#include "trace.h"
 #include "trace/control.h"
 #include "monitor/hmp-target.h"
 #ifdef CONFIG_TRACE_SIMPLE
@@ -71,7 +70,6 @@
 #include "qapi/error.h"
 #include "qapi/qmp-event.h"
 #include "qapi/qapi-introspect.h"
-#include "sysemu/qtest.h"
 #include "sysemu/cpus.h"
 #include "qemu/cutils.h"
 #include "tcg/tcg.h"
@@ -107,427 +105,15 @@ struct MonFdset {
     QLIST_ENTRY(MonFdset) next;
 };
=20
-/*
- * To prevent flooding clients, events can be throttled. The
- * throttling is calculated globally, rather than per-Monitor
- * instance.
- */
-typedef struct MonitorQAPIEventState {
-    QAPIEvent event;    /* Throttling state for this event type and... *=
/
-    QDict *data;        /* ... data, see qapi_event_throttle_equal() */
-    QEMUTimer *timer;   /* Timer for handling delayed events */
-    QDict *qdict;       /* Delayed event (if any) */
-} MonitorQAPIEventState;
-
-typedef struct {
-    int64_t rate;       /* Minimum time (in ns) between two events */
-} MonitorQAPIEventConf;
-
-/* Shared monitor I/O thread */
-IOThread *mon_iothread;
-
-/* Bottom half to dispatch the requests received from I/O thread */
-QEMUBH *qmp_dispatcher_bh;
-
 /* QMP checker flags */
 #define QMP_ACCEPT_UNKNOWNS 1
=20
-/* Protects mon_list, monitor_qapi_event_state, monitor_destroyed.  */
-QemuMutex monitor_lock;
-static GHashTable *monitor_qapi_event_state;
-MonitorList mon_list;
-static bool monitor_destroyed;
-
 /* Protects mon_fdsets */
 static QemuMutex mon_fdsets_lock;
 static QLIST_HEAD(, MonFdset) mon_fdsets;
=20
-int mon_refcount;
-
 static HMPCommand hmp_info_cmds[];
=20
-__thread Monitor *cur_mon;
-
-/**
- * Is @mon is using readline?
- * Note: not all HMP monitors use readline, e.g., gdbserver has a
- * non-interactive HMP monitor, so readline is not used there.
- */
-static inline bool monitor_uses_readline(const Monitor *mon)
-{
-    return mon->flags & MONITOR_USE_READLINE;
-}
-
-static inline bool monitor_is_hmp_non_interactive(const Monitor *mon)
-{
-    return !monitor_is_qmp(mon) && !monitor_uses_readline(mon);
-}
-
-/*
- * Return the clock to use for recording an event's time.
- * It's QEMU_CLOCK_REALTIME, except for qtests it's
- * QEMU_CLOCK_VIRTUAL, to support testing rate limits.
- * Beware: result is invalid before configure_accelerator().
- */
-static inline QEMUClockType monitor_get_event_clock(void)
-{
-    return qtest_enabled() ? QEMU_CLOCK_VIRTUAL : QEMU_CLOCK_REALTIME;
-}
-
-/**
- * Is the current monitor, if any, a QMP monitor?
- */
-bool monitor_cur_is_qmp(void)
-{
-    return cur_mon && monitor_is_qmp(cur_mon);
-}
-
-static void monitor_flush_locked(Monitor *mon);
-
-static gboolean monitor_unblocked(GIOChannel *chan, GIOCondition cond,
-                                  void *opaque)
-{
-    Monitor *mon =3D opaque;
-
-    qemu_mutex_lock(&mon->mon_lock);
-    mon->out_watch =3D 0;
-    monitor_flush_locked(mon);
-    qemu_mutex_unlock(&mon->mon_lock);
-    return FALSE;
-}
-
-/* Caller must hold mon->mon_lock */
-static void monitor_flush_locked(Monitor *mon)
-{
-    int rc;
-    size_t len;
-    const char *buf;
-
-    if (mon->skip_flush) {
-        return;
-    }
-
-    buf =3D qstring_get_str(mon->outbuf);
-    len =3D qstring_get_length(mon->outbuf);
-
-    if (len && !mon->mux_out) {
-        rc =3D qemu_chr_fe_write(&mon->chr, (const uint8_t *) buf, len);
-        if ((rc < 0 && errno !=3D EAGAIN) || (rc =3D=3D len)) {
-            /* all flushed or error */
-            qobject_unref(mon->outbuf);
-            mon->outbuf =3D qstring_new();
-            return;
-        }
-        if (rc > 0) {
-            /* partial write */
-            QString *tmp =3D qstring_from_str(buf + rc);
-            qobject_unref(mon->outbuf);
-            mon->outbuf =3D tmp;
-        }
-        if (mon->out_watch =3D=3D 0) {
-            mon->out_watch =3D
-                qemu_chr_fe_add_watch(&mon->chr, G_IO_OUT | G_IO_HUP,
-                                      monitor_unblocked, mon);
-        }
-    }
-}
-
-void monitor_flush(Monitor *mon)
-{
-    qemu_mutex_lock(&mon->mon_lock);
-    monitor_flush_locked(mon);
-    qemu_mutex_unlock(&mon->mon_lock);
-}
-
-/* flush at every end of line */
-int monitor_puts(Monitor *mon, const char *str)
-{
-    int i;
-    char c;
-
-    qemu_mutex_lock(&mon->mon_lock);
-    for (i =3D 0; str[i]; i++) {
-        c =3D str[i];
-        if (c =3D=3D '\n') {
-            qstring_append_chr(mon->outbuf, '\r');
-        }
-        qstring_append_chr(mon->outbuf, c);
-        if (c =3D=3D '\n') {
-            monitor_flush_locked(mon);
-        }
-    }
-    qemu_mutex_unlock(&mon->mon_lock);
-
-    return i;
-}
-
-int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
-{
-    char *buf;
-    int n;
-
-    if (!mon)
-        return -1;
-
-    if (monitor_is_qmp(mon)) {
-        return -1;
-    }
-
-    buf =3D g_strdup_vprintf(fmt, ap);
-    n =3D monitor_puts(mon, buf);
-    g_free(buf);
-    return n;
-}
-
-int monitor_printf(Monitor *mon, const char *fmt, ...)
-{
-    int ret;
-
-    va_list ap;
-    va_start(ap, fmt);
-    ret =3D monitor_vprintf(mon, fmt, ap);
-    va_end(ap);
-    return ret;
-}
-
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
-/*
- * Broadcast an event to all monitors.
- * @qdict is the event object.  Its member "event" must match @event.
- * Caller must hold monitor_lock.
- */
-static void monitor_qapi_event_emit(QAPIEvent event, QDict *qdict)
-{
-    Monitor *mon;
-    MonitorQMP *qmp_mon;
-
-    trace_monitor_protocol_event_emit(event, qdict);
-    QTAILQ_FOREACH(mon, &mon_list, entry) {
-        if (!monitor_is_qmp(mon)) {
-            continue;
-        }
-
-        qmp_mon =3D container_of(mon, MonitorQMP, common);
-        if (qmp_mon->commands !=3D &qmp_cap_negotiation_commands) {
-            qmp_send_response(qmp_mon, qdict);
-        }
-    }
-}
-
-static void monitor_qapi_event_handler(void *opaque);
-
-/*
- * Queue a new event for emission to Monitor instances,
- * applying any rate limiting if required.
- */
-static void
-monitor_qapi_event_queue_no_reenter(QAPIEvent event, QDict *qdict)
-{
-    MonitorQAPIEventConf *evconf;
-    MonitorQAPIEventState *evstate;
-
-    assert(event < QAPI_EVENT__MAX);
-    evconf =3D &monitor_qapi_event_conf[event];
-    trace_monitor_protocol_event_queue(event, qdict, evconf->rate);
-
-    qemu_mutex_lock(&monitor_lock);
-
-    if (!evconf->rate) {
-        /* Unthrottled event */
-        monitor_qapi_event_emit(event, qdict);
-    } else {
-        QDict *data =3D qobject_to(QDict, qdict_get(qdict, "data"));
-        MonitorQAPIEventState key =3D { .event =3D event, .data =3D data=
 };
-
-        evstate =3D g_hash_table_lookup(monitor_qapi_event_state, &key);
-        assert(!evstate || timer_pending(evstate->timer));
-
-        if (evstate) {
-            /*
-             * Timer is pending for (at least) evconf->rate ns after
-             * last send.  Store event for sending when timer fires,
-             * replacing a prior stored event if any.
-             */
-            qobject_unref(evstate->qdict);
-            evstate->qdict =3D qobject_ref(qdict);
-        } else {
-            /*
-             * Last send was (at least) evconf->rate ns ago.
-             * Send immediately, and arm the timer to call
-             * monitor_qapi_event_handler() in evconf->rate ns.  Any
-             * events arriving before then will be delayed until then.
-             */
-            int64_t now =3D qemu_clock_get_ns(monitor_get_event_clock())=
;
-
-            monitor_qapi_event_emit(event, qdict);
-
-            evstate =3D g_new(MonitorQAPIEventState, 1);
-            evstate->event =3D event;
-            evstate->data =3D qobject_ref(data);
-            evstate->qdict =3D NULL;
-            evstate->timer =3D timer_new_ns(monitor_get_event_clock(),
-                                          monitor_qapi_event_handler,
-                                          evstate);
-            g_hash_table_add(monitor_qapi_event_state, evstate);
-            timer_mod_ns(evstate->timer, now + evconf->rate);
-        }
-    }
-
-    qemu_mutex_unlock(&monitor_lock);
-}
-
-void qapi_event_emit(QAPIEvent event, QDict *qdict)
-{
-    /*
-     * monitor_qapi_event_queue_no_reenter() is not reentrant: it
-     * would deadlock on monitor_lock.  Work around by queueing
-     * events in thread-local storage.
-     * TODO: remove this, make it re-enter safe.
-     */
-    typedef struct MonitorQapiEvent {
-        QAPIEvent event;
-        QDict *qdict;
-        QSIMPLEQ_ENTRY(MonitorQapiEvent) entry;
-    } MonitorQapiEvent;
-    static __thread QSIMPLEQ_HEAD(, MonitorQapiEvent) event_queue;
-    static __thread bool reentered;
-    MonitorQapiEvent *ev;
-
-    if (!reentered) {
-        QSIMPLEQ_INIT(&event_queue);
-    }
-
-    ev =3D g_new(MonitorQapiEvent, 1);
-    ev->qdict =3D qobject_ref(qdict);
-    ev->event =3D event;
-    QSIMPLEQ_INSERT_TAIL(&event_queue, ev, entry);
-    if (reentered) {
-        return;
-    }
-
-    reentered =3D true;
-
-    while ((ev =3D QSIMPLEQ_FIRST(&event_queue)) !=3D NULL) {
-        QSIMPLEQ_REMOVE_HEAD(&event_queue, entry);
-        monitor_qapi_event_queue_no_reenter(ev->event, ev->qdict);
-        qobject_unref(ev->qdict);
-        g_free(ev);
-    }
-
-    reentered =3D false;
-}
-
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
-        int64_t now =3D qemu_clock_get_ns(monitor_get_event_clock());
-
-        monitor_qapi_event_emit(evstate->event, evstate->qdict);
-        qobject_unref(evstate->qdict);
-        evstate->qdict =3D NULL;
-        timer_mod_ns(evstate->timer, now + evconf->rate);
-    } else {
-        g_hash_table_remove(monitor_qapi_event_state, evstate);
-        qobject_unref(evstate->data);
-        timer_free(evstate->timer);
-        g_free(evstate);
-    }
-
-    qemu_mutex_unlock(&monitor_lock);
-}
-
-static unsigned int qapi_event_throttle_hash(const void *key)
-{
-    const MonitorQAPIEventState *evstate =3D key;
-    unsigned int hash =3D evstate->event * 255;
-
-    if (evstate->event =3D=3D QAPI_EVENT_VSERPORT_CHANGE) {
-        hash +=3D g_str_hash(qdict_get_str(evstate->data, "id"));
-    }
-
-    if (evstate->event =3D=3D QAPI_EVENT_QUORUM_REPORT_BAD) {
-        hash +=3D g_str_hash(qdict_get_str(evstate->data, "node-name"));
-    }
-
-    return hash;
-}
-
-static gboolean qapi_event_throttle_equal(const void *a, const void *b)
-{
-    const MonitorQAPIEventState *eva =3D a;
-    const MonitorQAPIEventState *evb =3D b;
-
-    if (eva->event !=3D evb->event) {
-        return FALSE;
-    }
-
-    if (eva->event =3D=3D QAPI_EVENT_VSERPORT_CHANGE) {
-        return !strcmp(qdict_get_str(eva->data, "id"),
-                       qdict_get_str(evb->data, "id"));
-    }
-
-    if (eva->event =3D=3D QAPI_EVENT_QUORUM_REPORT_BAD) {
-        return !strcmp(qdict_get_str(eva->data, "node-name"),
-                       qdict_get_str(evb->data, "node-name"));
-    }
-
-    return TRUE;
-}
-
-static void monitor_qapi_event_init(void)
-{
-    monitor_qapi_event_state =3D g_hash_table_new(qapi_event_throttle_ha=
sh,
-                                                qapi_event_throttle_equa=
l);
-}
-
-static void monitor_iothread_init(void);
-
-void monitor_data_init(Monitor *mon, int flags, bool skip_flush,
-                       bool use_io_thread)
-{
-    if (use_io_thread && !mon_iothread) {
-        monitor_iothread_init();
-    }
-    qemu_mutex_init(&mon->mon_lock);
-    mon->outbuf =3D qstring_new();
-    mon->skip_flush =3D skip_flush;
-    mon->use_io_thread =3D use_io_thread;
-    mon->flags =3D flags;
-}
-
-static void monitor_data_destroy(Monitor *mon)
-{
-    g_free(mon->mon_cpu_path);
-    qemu_chr_fe_deinit(&mon->chr, false);
-    if (monitor_is_qmp(mon)) {
-        monitor_data_destroy_qmp(container_of(mon, MonitorQMP, common));
-    } else {
-        readline_free(container_of(mon, MonitorHMP, common)->rs);
-    }
-    qobject_unref(mon->outbuf);
-    qemu_mutex_destroy(&mon->mon_lock);
-}
-
 char *qmp_human_monitor_command(const char *command_line, bool has_cpu_i=
ndex,
                                 int64_t cpu_index, Error **errp)
 {
@@ -2728,67 +2314,6 @@ void loadvm_completion(ReadLineState *rs, int nb_a=
rgs, const char *str)
     }
 }
=20
-int monitor_can_read(void *opaque)
-{
-    Monitor *mon =3D opaque;
-
-    return !atomic_mb_read(&mon->suspend_cnt);
-}
-
-int monitor_suspend(Monitor *mon)
-{
-    if (monitor_is_hmp_non_interactive(mon)) {
-        return -ENOTTY;
-    }
-
-    atomic_inc(&mon->suspend_cnt);
-
-    if (mon->use_io_thread) {
-        /*
-         * Kick I/O thread to make sure this takes effect.  It'll be
-         * evaluated again in prepare() of the watch object.
-         */
-        aio_notify(iothread_get_aio_context(mon_iothread));
-    }
-
-    trace_monitor_suspend(mon, 1);
-    return 0;
-}
-
-static void monitor_accept_input(void *opaque)
-{
-    Monitor *mon =3D opaque;
-
-    qemu_chr_fe_accept_input(&mon->chr);
-}
-
-void monitor_resume(Monitor *mon)
-{
-    if (monitor_is_hmp_non_interactive(mon)) {
-        return;
-    }
-
-    if (atomic_dec_fetch(&mon->suspend_cnt) =3D=3D 0) {
-        AioContext *ctx;
-
-        if (mon->use_io_thread) {
-            ctx =3D iothread_get_aio_context(mon_iothread);
-        } else {
-            ctx =3D qemu_get_aio_context();
-        }
-
-        if (!monitor_is_qmp(mon)) {
-            MonitorHMP *hmp_mon =3D container_of(mon, MonitorHMP, common=
);
-            assert(hmp_mon->rs);
-            readline_show_prompt(hmp_mon->rs);
-        }
-
-        aio_bh_schedule_oneshot(ctx, monitor_accept_input, mon);
-    }
-
-    trace_monitor_suspend(mon, -1);
-}
-
 static int
 compare_mon_cmd(const void *a, const void *b)
 {
@@ -2806,135 +2331,14 @@ static void sortcmdlist(void)
           compare_mon_cmd);
 }
=20
-static void monitor_iothread_init(void)
-{
-    mon_iothread =3D iothread_create("mon_iothread", &error_abort);
-}
-
 void monitor_init_globals(void)
 {
+    monitor_init_globals_core();
     monitor_init_qmp_commands();
-    monitor_qapi_event_init();
     sortcmdlist();
-    qemu_mutex_init(&monitor_lock);
     qemu_mutex_init(&mon_fdsets_lock);
-
-    /*
-     * The dispatcher BH must run in the main loop thread, since we
-     * have commands assuming that context.  It would be nice to get
-     * rid of those assumptions.
-     */
-    qmp_dispatcher_bh =3D aio_bh_new(iohandler_get_aio_context(),
-                                   monitor_qmp_bh_dispatcher,
-                                   NULL);
 }
=20
-/*
- * Print to current monitor if we have one, else to stderr.
- */
-int error_vprintf(const char *fmt, va_list ap)
-{
-    if (cur_mon && !monitor_cur_is_qmp()) {
-        return monitor_vprintf(cur_mon, fmt, ap);
-    }
-    return vfprintf(stderr, fmt, ap);
-}
-
-int error_vprintf_unless_qmp(const char *fmt, va_list ap)
-{
-    if (!cur_mon) {
-        return vfprintf(stderr, fmt, ap);
-    }
-    if (!monitor_cur_is_qmp()) {
-        return monitor_vprintf(cur_mon, fmt, ap);
-    }
-    return -1;
-}
-
-void monitor_list_append(Monitor *mon)
-{
-    qemu_mutex_lock(&monitor_lock);
-    /*
-     * This prevents inserting new monitors during monitor_cleanup().
-     * A cleaner solution would involve the main thread telling other
-     * threads to terminate, waiting for their termination.
-     */
-    if (!monitor_destroyed) {
-        QTAILQ_INSERT_HEAD(&mon_list, mon, entry);
-        mon =3D NULL;
-    }
-    qemu_mutex_unlock(&monitor_lock);
-
-    if (mon) {
-        monitor_data_destroy(mon);
-        g_free(mon);
-    }
-}
-
-void monitor_init(Chardev *chr, int flags)
-{
-    if (flags & MONITOR_USE_CONTROL) {
-        monitor_init_qmp(chr, flags);
-    } else {
-        monitor_init_hmp(chr, flags);
-    }
-}
-
-void monitor_cleanup(void)
-{
-    /*
-     * We need to explicitly stop the I/O thread (but not destroy it),
-     * clean up the monitor resources, then destroy the I/O thread since
-     * we need to unregister from chardev below in
-     * monitor_data_destroy(), and chardev is not thread-safe yet
-     */
-    if (mon_iothread) {
-        iothread_stop(mon_iothread);
-    }
-
-    /* Flush output buffers and destroy monitors */
-    qemu_mutex_lock(&monitor_lock);
-    monitor_destroyed =3D true;
-    while (!QTAILQ_EMPTY(&mon_list)) {
-        Monitor *mon =3D QTAILQ_FIRST(&mon_list);
-        QTAILQ_REMOVE(&mon_list, mon, entry);
-        /* Permit QAPI event emission from character frontend release */
-        qemu_mutex_unlock(&monitor_lock);
-        monitor_flush(mon);
-        monitor_data_destroy(mon);
-        qemu_mutex_lock(&monitor_lock);
-        g_free(mon);
-    }
-    qemu_mutex_unlock(&monitor_lock);
-
-    /* QEMUBHs needs to be deleted before destroying the I/O thread */
-    qemu_bh_delete(qmp_dispatcher_bh);
-    qmp_dispatcher_bh =3D NULL;
-    if (mon_iothread) {
-        iothread_destroy(mon_iothread);
-        mon_iothread =3D NULL;
-    }
-}
-
-QemuOptsList qemu_mon_opts =3D {
-    .name =3D "mon",
-    .implied_opt_name =3D "chardev",
-    .head =3D QTAILQ_HEAD_INITIALIZER(qemu_mon_opts.head),
-    .desc =3D {
-        {
-            .name =3D "mode",
-            .type =3D QEMU_OPT_STRING,
-        },{
-            .name =3D "chardev",
-            .type =3D QEMU_OPT_STRING,
-        },{
-            .name =3D "pretty",
-            .type =3D QEMU_OPT_BOOL,
-        },
-        { /* end of list */ }
-    },
-};
-
 HotpluggableCPUList *qmp_query_hotpluggable_cpus(Error **errp)
 {
     MachineState *ms =3D MACHINE(qdev_get_machine());
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 10fda7d97c..b4996c14ac 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -167,6 +167,7 @@ void monitor_init_hmp(Chardev *chr, int flags);
 int monitor_puts(Monitor *mon, const char *str);
 void monitor_data_init(Monitor *mon, int flags, bool skip_flush,
                        bool use_io_thread);
+void monitor_data_destroy(Monitor *mon);
 int monitor_can_read(void *opaque);
 void monitor_list_append(Monitor *mon);
 void monitor_fdsets_cleanup(void);
diff --git a/monitor/monitor.c b/monitor/monitor.c
new file mode 100644
index 0000000000..db3d5ece99
--- /dev/null
+++ b/monitor/monitor.c
@@ -0,0 +1,633 @@
+/*
+ * QEMU monitor
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "monitor-internal.h"
+#include "qapi/error.h"
+#include "qapi/qapi-emit-events.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qstring.h"
+#include "qemu/error-report.h"
+#include "qemu/option.h"
+#include "sysemu/qtest.h"
+#include "trace.h"
+
+/*
+ * To prevent flooding clients, events can be throttled. The
+ * throttling is calculated globally, rather than per-Monitor
+ * instance.
+ */
+typedef struct MonitorQAPIEventState {
+    QAPIEvent event;    /* Throttling state for this event type and... *=
/
+    QDict *data;        /* ... data, see qapi_event_throttle_equal() */
+    QEMUTimer *timer;   /* Timer for handling delayed events */
+    QDict *qdict;       /* Delayed event (if any) */
+} MonitorQAPIEventState;
+
+typedef struct {
+    int64_t rate;       /* Minimum time (in ns) between two events */
+} MonitorQAPIEventConf;
+
+/* Shared monitor I/O thread */
+IOThread *mon_iothread;
+
+/* Bottom half to dispatch the requests received from I/O thread */
+QEMUBH *qmp_dispatcher_bh;
+
+/* Protects mon_list, monitor_qapi_event_state, monitor_destroyed.  */
+QemuMutex monitor_lock;
+static GHashTable *monitor_qapi_event_state;
+
+MonitorList mon_list;
+int mon_refcount;
+static bool monitor_destroyed;
+
+__thread Monitor *cur_mon;
+
+/**
+ * Is the current monitor, if any, a QMP monitor?
+ */
+bool monitor_cur_is_qmp(void)
+{
+    return cur_mon && monitor_is_qmp(cur_mon);
+}
+
+/**
+ * Is @mon is using readline?
+ * Note: not all HMP monitors use readline, e.g., gdbserver has a
+ * non-interactive HMP monitor, so readline is not used there.
+ */
+static inline bool monitor_uses_readline(const Monitor *mon)
+{
+    return mon->flags & MONITOR_USE_READLINE;
+}
+
+static inline bool monitor_is_hmp_non_interactive(const Monitor *mon)
+{
+    return !monitor_is_qmp(mon) && !monitor_uses_readline(mon);
+}
+
+static void monitor_flush_locked(Monitor *mon);
+
+static gboolean monitor_unblocked(GIOChannel *chan, GIOCondition cond,
+                                  void *opaque)
+{
+    Monitor *mon =3D opaque;
+
+    qemu_mutex_lock(&mon->mon_lock);
+    mon->out_watch =3D 0;
+    monitor_flush_locked(mon);
+    qemu_mutex_unlock(&mon->mon_lock);
+    return FALSE;
+}
+
+/* Caller must hold mon->mon_lock */
+static void monitor_flush_locked(Monitor *mon)
+{
+    int rc;
+    size_t len;
+    const char *buf;
+
+    if (mon->skip_flush) {
+        return;
+    }
+
+    buf =3D qstring_get_str(mon->outbuf);
+    len =3D qstring_get_length(mon->outbuf);
+
+    if (len && !mon->mux_out) {
+        rc =3D qemu_chr_fe_write(&mon->chr, (const uint8_t *) buf, len);
+        if ((rc < 0 && errno !=3D EAGAIN) || (rc =3D=3D len)) {
+            /* all flushed or error */
+            qobject_unref(mon->outbuf);
+            mon->outbuf =3D qstring_new();
+            return;
+        }
+        if (rc > 0) {
+            /* partial write */
+            QString *tmp =3D qstring_from_str(buf + rc);
+            qobject_unref(mon->outbuf);
+            mon->outbuf =3D tmp;
+        }
+        if (mon->out_watch =3D=3D 0) {
+            mon->out_watch =3D
+                qemu_chr_fe_add_watch(&mon->chr, G_IO_OUT | G_IO_HUP,
+                                      monitor_unblocked, mon);
+        }
+    }
+}
+
+void monitor_flush(Monitor *mon)
+{
+    qemu_mutex_lock(&mon->mon_lock);
+    monitor_flush_locked(mon);
+    qemu_mutex_unlock(&mon->mon_lock);
+}
+
+/* flush at every end of line */
+int monitor_puts(Monitor *mon, const char *str)
+{
+    int i;
+    char c;
+
+    qemu_mutex_lock(&mon->mon_lock);
+    for (i =3D 0; str[i]; i++) {
+        c =3D str[i];
+        if (c =3D=3D '\n') {
+            qstring_append_chr(mon->outbuf, '\r');
+        }
+        qstring_append_chr(mon->outbuf, c);
+        if (c =3D=3D '\n') {
+            monitor_flush_locked(mon);
+        }
+    }
+    qemu_mutex_unlock(&mon->mon_lock);
+
+    return i;
+}
+
+int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
+{
+    char *buf;
+    int n;
+
+    if (!mon) {
+        return -1;
+    }
+
+    if (monitor_is_qmp(mon)) {
+        return -1;
+    }
+
+    buf =3D g_strdup_vprintf(fmt, ap);
+    n =3D monitor_puts(mon, buf);
+    g_free(buf);
+    return n;
+}
+
+int monitor_printf(Monitor *mon, const char *fmt, ...)
+{
+    int ret;
+
+    va_list ap;
+    va_start(ap, fmt);
+    ret =3D monitor_vprintf(mon, fmt, ap);
+    va_end(ap);
+    return ret;
+}
+
+/*
+ * Print to current monitor if we have one, else to stderr.
+ */
+int error_vprintf(const char *fmt, va_list ap)
+{
+    if (cur_mon && !monitor_cur_is_qmp()) {
+        return monitor_vprintf(cur_mon, fmt, ap);
+    }
+    return vfprintf(stderr, fmt, ap);
+}
+
+int error_vprintf_unless_qmp(const char *fmt, va_list ap)
+{
+    if (!cur_mon) {
+        return vfprintf(stderr, fmt, ap);
+    }
+    if (!monitor_cur_is_qmp()) {
+        return monitor_vprintf(cur_mon, fmt, ap);
+    }
+    return -1;
+}
+
+
+static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] =3D=
 {
+    /* Limit guest-triggerable events to 1 per second */
+    [QAPI_EVENT_RTC_CHANGE]        =3D { 1000 * SCALE_MS },
+    [QAPI_EVENT_WATCHDOG]          =3D { 1000 * SCALE_MS },
+    [QAPI_EVENT_BALLOON_CHANGE]    =3D { 1000 * SCALE_MS },
+    [QAPI_EVENT_QUORUM_REPORT_BAD] =3D { 1000 * SCALE_MS },
+    [QAPI_EVENT_QUORUM_FAILURE]    =3D { 1000 * SCALE_MS },
+    [QAPI_EVENT_VSERPORT_CHANGE]   =3D { 1000 * SCALE_MS },
+};
+
+/*
+ * Return the clock to use for recording an event's time.
+ * It's QEMU_CLOCK_REALTIME, except for qtests it's
+ * QEMU_CLOCK_VIRTUAL, to support testing rate limits.
+ * Beware: result is invalid before configure_accelerator().
+ */
+static inline QEMUClockType monitor_get_event_clock(void)
+{
+    return qtest_enabled() ? QEMU_CLOCK_VIRTUAL : QEMU_CLOCK_REALTIME;
+}
+
+/*
+ * Broadcast an event to all monitors.
+ * @qdict is the event object.  Its member "event" must match @event.
+ * Caller must hold monitor_lock.
+ */
+static void monitor_qapi_event_emit(QAPIEvent event, QDict *qdict)
+{
+    Monitor *mon;
+    MonitorQMP *qmp_mon;
+
+    trace_monitor_protocol_event_emit(event, qdict);
+    QTAILQ_FOREACH(mon, &mon_list, entry) {
+        if (!monitor_is_qmp(mon)) {
+            continue;
+        }
+
+        qmp_mon =3D container_of(mon, MonitorQMP, common);
+        if (qmp_mon->commands !=3D &qmp_cap_negotiation_commands) {
+            qmp_send_response(qmp_mon, qdict);
+        }
+    }
+}
+
+static void monitor_qapi_event_handler(void *opaque);
+
+/*
+ * Queue a new event for emission to Monitor instances,
+ * applying any rate limiting if required.
+ */
+static void
+monitor_qapi_event_queue_no_reenter(QAPIEvent event, QDict *qdict)
+{
+    MonitorQAPIEventConf *evconf;
+    MonitorQAPIEventState *evstate;
+
+    assert(event < QAPI_EVENT__MAX);
+    evconf =3D &monitor_qapi_event_conf[event];
+    trace_monitor_protocol_event_queue(event, qdict, evconf->rate);
+
+    qemu_mutex_lock(&monitor_lock);
+
+    if (!evconf->rate) {
+        /* Unthrottled event */
+        monitor_qapi_event_emit(event, qdict);
+    } else {
+        QDict *data =3D qobject_to(QDict, qdict_get(qdict, "data"));
+        MonitorQAPIEventState key =3D { .event =3D event, .data =3D data=
 };
+
+        evstate =3D g_hash_table_lookup(monitor_qapi_event_state, &key);
+        assert(!evstate || timer_pending(evstate->timer));
+
+        if (evstate) {
+            /*
+             * Timer is pending for (at least) evconf->rate ns after
+             * last send.  Store event for sending when timer fires,
+             * replacing a prior stored event if any.
+             */
+            qobject_unref(evstate->qdict);
+            evstate->qdict =3D qobject_ref(qdict);
+        } else {
+            /*
+             * Last send was (at least) evconf->rate ns ago.
+             * Send immediately, and arm the timer to call
+             * monitor_qapi_event_handler() in evconf->rate ns.  Any
+             * events arriving before then will be delayed until then.
+             */
+            int64_t now =3D qemu_clock_get_ns(monitor_get_event_clock())=
;
+
+            monitor_qapi_event_emit(event, qdict);
+
+            evstate =3D g_new(MonitorQAPIEventState, 1);
+            evstate->event =3D event;
+            evstate->data =3D qobject_ref(data);
+            evstate->qdict =3D NULL;
+            evstate->timer =3D timer_new_ns(monitor_get_event_clock(),
+                                          monitor_qapi_event_handler,
+                                          evstate);
+            g_hash_table_add(monitor_qapi_event_state, evstate);
+            timer_mod_ns(evstate->timer, now + evconf->rate);
+        }
+    }
+
+    qemu_mutex_unlock(&monitor_lock);
+}
+
+void qapi_event_emit(QAPIEvent event, QDict *qdict)
+{
+    /*
+     * monitor_qapi_event_queue_no_reenter() is not reentrant: it
+     * would deadlock on monitor_lock.  Work around by queueing
+     * events in thread-local storage.
+     * TODO: remove this, make it re-enter safe.
+     */
+    typedef struct MonitorQapiEvent {
+        QAPIEvent event;
+        QDict *qdict;
+        QSIMPLEQ_ENTRY(MonitorQapiEvent) entry;
+    } MonitorQapiEvent;
+    static __thread QSIMPLEQ_HEAD(, MonitorQapiEvent) event_queue;
+    static __thread bool reentered;
+    MonitorQapiEvent *ev;
+
+    if (!reentered) {
+        QSIMPLEQ_INIT(&event_queue);
+    }
+
+    ev =3D g_new(MonitorQapiEvent, 1);
+    ev->qdict =3D qobject_ref(qdict);
+    ev->event =3D event;
+    QSIMPLEQ_INSERT_TAIL(&event_queue, ev, entry);
+    if (reentered) {
+        return;
+    }
+
+    reentered =3D true;
+
+    while ((ev =3D QSIMPLEQ_FIRST(&event_queue)) !=3D NULL) {
+        QSIMPLEQ_REMOVE_HEAD(&event_queue, entry);
+        monitor_qapi_event_queue_no_reenter(ev->event, ev->qdict);
+        qobject_unref(ev->qdict);
+        g_free(ev);
+    }
+
+    reentered =3D false;
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
+    MonitorQAPIEventConf *evconf =3D &monitor_qapi_event_conf[evstate->e=
vent];
+
+    trace_monitor_protocol_event_handler(evstate->event, evstate->qdict)=
;
+    qemu_mutex_lock(&monitor_lock);
+
+    if (evstate->qdict) {
+        int64_t now =3D qemu_clock_get_ns(monitor_get_event_clock());
+
+        monitor_qapi_event_emit(evstate->event, evstate->qdict);
+        qobject_unref(evstate->qdict);
+        evstate->qdict =3D NULL;
+        timer_mod_ns(evstate->timer, now + evconf->rate);
+    } else {
+        g_hash_table_remove(monitor_qapi_event_state, evstate);
+        qobject_unref(evstate->data);
+        timer_free(evstate->timer);
+        g_free(evstate);
+    }
+
+    qemu_mutex_unlock(&monitor_lock);
+}
+
+static unsigned int qapi_event_throttle_hash(const void *key)
+{
+    const MonitorQAPIEventState *evstate =3D key;
+    unsigned int hash =3D evstate->event * 255;
+
+    if (evstate->event =3D=3D QAPI_EVENT_VSERPORT_CHANGE) {
+        hash +=3D g_str_hash(qdict_get_str(evstate->data, "id"));
+    }
+
+    if (evstate->event =3D=3D QAPI_EVENT_QUORUM_REPORT_BAD) {
+        hash +=3D g_str_hash(qdict_get_str(evstate->data, "node-name"));
+    }
+
+    return hash;
+}
+
+static gboolean qapi_event_throttle_equal(const void *a, const void *b)
+{
+    const MonitorQAPIEventState *eva =3D a;
+    const MonitorQAPIEventState *evb =3D b;
+
+    if (eva->event !=3D evb->event) {
+        return FALSE;
+    }
+
+    if (eva->event =3D=3D QAPI_EVENT_VSERPORT_CHANGE) {
+        return !strcmp(qdict_get_str(eva->data, "id"),
+                       qdict_get_str(evb->data, "id"));
+    }
+
+    if (eva->event =3D=3D QAPI_EVENT_QUORUM_REPORT_BAD) {
+        return !strcmp(qdict_get_str(eva->data, "node-name"),
+                       qdict_get_str(evb->data, "node-name"));
+    }
+
+    return TRUE;
+}
+
+int monitor_suspend(Monitor *mon)
+{
+    if (monitor_is_hmp_non_interactive(mon)) {
+        return -ENOTTY;
+    }
+
+    atomic_inc(&mon->suspend_cnt);
+
+    if (mon->use_io_thread) {
+        /*
+         * Kick I/O thread to make sure this takes effect.  It'll be
+         * evaluated again in prepare() of the watch object.
+         */
+        aio_notify(iothread_get_aio_context(mon_iothread));
+    }
+
+    trace_monitor_suspend(mon, 1);
+    return 0;
+}
+
+static void monitor_accept_input(void *opaque)
+{
+    Monitor *mon =3D opaque;
+
+    qemu_chr_fe_accept_input(&mon->chr);
+}
+
+void monitor_resume(Monitor *mon)
+{
+    if (monitor_is_hmp_non_interactive(mon)) {
+        return;
+    }
+
+    if (atomic_dec_fetch(&mon->suspend_cnt) =3D=3D 0) {
+        AioContext *ctx;
+
+        if (mon->use_io_thread) {
+            ctx =3D iothread_get_aio_context(mon_iothread);
+        } else {
+            ctx =3D qemu_get_aio_context();
+        }
+
+        if (!monitor_is_qmp(mon)) {
+            MonitorHMP *hmp_mon =3D container_of(mon, MonitorHMP, common=
);
+            assert(hmp_mon->rs);
+            readline_show_prompt(hmp_mon->rs);
+        }
+
+        aio_bh_schedule_oneshot(ctx, monitor_accept_input, mon);
+    }
+
+    trace_monitor_suspend(mon, -1);
+}
+
+int monitor_can_read(void *opaque)
+{
+    Monitor *mon =3D opaque;
+
+    return !atomic_mb_read(&mon->suspend_cnt);
+}
+
+void monitor_list_append(Monitor *mon)
+{
+    qemu_mutex_lock(&monitor_lock);
+    /*
+     * This prevents inserting new monitors during monitor_cleanup().
+     * A cleaner solution would involve the main thread telling other
+     * threads to terminate, waiting for their termination.
+     */
+    if (!monitor_destroyed) {
+        QTAILQ_INSERT_HEAD(&mon_list, mon, entry);
+        mon =3D NULL;
+    }
+    qemu_mutex_unlock(&monitor_lock);
+
+    if (mon) {
+        monitor_data_destroy(mon);
+        g_free(mon);
+    }
+}
+
+static void monitor_iothread_init(void)
+{
+    mon_iothread =3D iothread_create("mon_iothread", &error_abort);
+}
+
+void monitor_data_init(Monitor *mon, int flags, bool skip_flush,
+                       bool use_io_thread)
+{
+    if (use_io_thread && !mon_iothread) {
+        monitor_iothread_init();
+    }
+    qemu_mutex_init(&mon->mon_lock);
+    mon->outbuf =3D qstring_new();
+    mon->skip_flush =3D skip_flush;
+    mon->use_io_thread =3D use_io_thread;
+    mon->flags =3D flags;
+}
+
+void monitor_data_destroy(Monitor *mon)
+{
+    g_free(mon->mon_cpu_path);
+    qemu_chr_fe_deinit(&mon->chr, false);
+    if (monitor_is_qmp(mon)) {
+        monitor_data_destroy_qmp(container_of(mon, MonitorQMP, common));
+    } else {
+        readline_free(container_of(mon, MonitorHMP, common)->rs);
+    }
+    qobject_unref(mon->outbuf);
+    qemu_mutex_destroy(&mon->mon_lock);
+}
+
+void monitor_init(Chardev *chr, int flags)
+{
+    if (flags & MONITOR_USE_CONTROL) {
+        monitor_init_qmp(chr, flags);
+    } else {
+        monitor_init_hmp(chr, flags);
+    }
+}
+
+void monitor_cleanup(void)
+{
+    /*
+     * We need to explicitly stop the I/O thread (but not destroy it),
+     * clean up the monitor resources, then destroy the I/O thread since
+     * we need to unregister from chardev below in
+     * monitor_data_destroy(), and chardev is not thread-safe yet
+     */
+    if (mon_iothread) {
+        iothread_stop(mon_iothread);
+    }
+
+    /* Flush output buffers and destroy monitors */
+    qemu_mutex_lock(&monitor_lock);
+    monitor_destroyed =3D true;
+    while (!QTAILQ_EMPTY(&mon_list)) {
+        Monitor *mon =3D QTAILQ_FIRST(&mon_list);
+        QTAILQ_REMOVE(&mon_list, mon, entry);
+        /* Permit QAPI event emission from character frontend release */
+        qemu_mutex_unlock(&monitor_lock);
+        monitor_flush(mon);
+        monitor_data_destroy(mon);
+        qemu_mutex_lock(&monitor_lock);
+        g_free(mon);
+    }
+    qemu_mutex_unlock(&monitor_lock);
+
+    /* QEMUBHs needs to be deleted before destroying the I/O thread */
+    qemu_bh_delete(qmp_dispatcher_bh);
+    qmp_dispatcher_bh =3D NULL;
+    if (mon_iothread) {
+        iothread_destroy(mon_iothread);
+        mon_iothread =3D NULL;
+    }
+}
+
+static void monitor_qapi_event_init(void)
+{
+    monitor_qapi_event_state =3D g_hash_table_new(qapi_event_throttle_ha=
sh,
+                                                qapi_event_throttle_equa=
l);
+}
+
+void monitor_init_globals_core(void)
+{
+    monitor_qapi_event_init();
+    qemu_mutex_init(&monitor_lock);
+
+    /*
+     * The dispatcher BH must run in the main loop thread, since we
+     * have commands assuming that context.  It would be nice to get
+     * rid of those assumptions.
+     */
+    qmp_dispatcher_bh =3D aio_bh_new(iohandler_get_aio_context(),
+                                   monitor_qmp_bh_dispatcher,
+                                   NULL);
+}
+
+QemuOptsList qemu_mon_opts =3D {
+    .name =3D "mon",
+    .implied_opt_name =3D "chardev",
+    .head =3D QTAILQ_HEAD_INITIALIZER(qemu_mon_opts.head),
+    .desc =3D {
+        {
+            .name =3D "mode",
+            .type =3D QEMU_OPT_STRING,
+        },{
+            .name =3D "chardev",
+            .type =3D QEMU_OPT_STRING,
+        },{
+            .name =3D "pretty",
+            .type =3D QEMU_OPT_BOOL,
+        },
+        { /* end of list */ }
+    },
+};
diff --git a/monitor/trace-events b/monitor/trace-events
index 2285d26121..0365ac4d99 100644
--- a/monitor/trace-events
+++ b/monitor/trace-events
@@ -3,7 +3,7 @@
 # hmp.c
 handle_hmp_command(void *mon, const char *cmdline) "mon %p cmdline: %s"
=20
-# misc.c
+# monitor.c
 monitor_protocol_event_handler(uint32_t event, void *qdict) "event=3D%d =
data=3D%p"
 monitor_protocol_event_emit(uint32_t event, void *data) "event=3D%d data=
=3D%p"
 monitor_protocol_event_queue(uint32_t event, void *qdict, uint64_t rate)=
 "event=3D%d data=3D%p rate=3D%" PRId64
--=20
2.21.0


