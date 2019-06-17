Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7456BC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 19:19:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3769A20863
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 19:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3769A20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51418 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcxAS-0006SM-H4
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 15:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40477)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hcwh4-0001ie-7u
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:49:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hcwh0-0007sT-En
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:49:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41486)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hcwh0-0007l9-3m
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:49:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A58C4B5956
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 18:49:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-177.ams2.redhat.com
 [10.36.117.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D0BB912A66;
 Mon, 17 Jun 2019 18:49:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 77BC31133019; Mon, 17 Jun 2019 20:49:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 20:48:58 +0200
Message-Id: <20190617184903.19436-12-armbru@redhat.com>
In-Reply-To: <20190617184903.19436-1-armbru@redhat.com>
References: <20190617184903.19436-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Mon, 17 Jun 2019 18:49:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 11/16] monitor: Split out monitor/qmp.c
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kevin Wolf <kwolf@redhat.com>

Move QMP infrastructure from monitor/misc.c to monitor/qmp.c. This is
code that can be shared for all targets, so compile it only once.

The amount of function and particularly extern variables in
monitor_int.h is probably a bit larger than it needs to be, but this way
no non-trivial code modifications are needed. The interfaces between QMP
and the monitor core can be cleaned up later.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190613153405.24769-11-kwolf@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[monitor_is_qmp() tidied up to make checkpatch.pl happy,
superfluous #include dropped]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 Makefile.objs              |   1 +
 monitor/Makefile.objs      |   1 +
 monitor/misc.c             | 401 +-----------------------------------
 monitor/monitor-internal.h |  30 +++
 monitor/qmp.c              | 406 +++++++++++++++++++++++++++++++++++++
 monitor/trace-events       |   4 +-
 6 files changed, 450 insertions(+), 393 deletions(-)
 create mode 100644 monitor/qmp.c

diff --git a/Makefile.objs b/Makefile.objs
index 9495fcbc7e..658cfc9d9f 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -46,6 +46,7 @@ ifeq ($(CONFIG_SOFTMMU),y)
 common-obj-y =3D blockdev.o blockdev-nbd.o block/
 common-obj-y +=3D bootdevice.o iothread.o
 common-obj-y +=3D job-qmp.o
+common-obj-y +=3D monitor/
 common-obj-y +=3D net/
 common-obj-y +=3D qdev-monitor.o device-hotplug.o
 common-obj-$(CONFIG_WIN32) +=3D os-win32.o
diff --git a/monitor/Makefile.objs b/monitor/Makefile.objs
index a7170af6e1..1037c09ff8 100644
--- a/monitor/Makefile.objs
+++ b/monitor/Makefile.objs
@@ -1,2 +1,3 @@
 obj-y +=3D misc.o
+common-obj-y +=3D qmp.o
 common-obj-y +=3D qmp-cmds.o hmp-cmds.o
diff --git a/monitor/misc.c b/monitor/misc.c
index 3cdbb681fb..824d28d717 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -36,7 +36,6 @@
 #include "exec/gdbstub.h"
 #include "net/net.h"
 #include "net/slirp.h"
-#include "chardev/char-io.h"
 #include "chardev/char-mux.h"
 #include "ui/qemu-spice.h"
 #include "sysemu/numa.h"
@@ -58,8 +57,6 @@
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
-#include "qapi/qmp/qjson.h"
-#include "qapi/qmp/qlist.h"
 #include "qom/object_interfaces.h"
 #include "trace.h"
 #include "trace/control.h"
@@ -81,7 +78,6 @@
 #include "qapi/qapi-introspect.h"
 #include "sysemu/qtest.h"
 #include "sysemu/cpus.h"
-#include "sysemu/iothread.h"
 #include "qemu/cutils.h"
 #include "tcg/tcg.h"
=20
@@ -138,51 +134,29 @@ IOThread *mon_iothread;
 /* Bottom half to dispatch the requests received from I/O thread */
 QEMUBH *qmp_dispatcher_bh;
=20
-struct QMPRequest {
-    /* Owner of the request */
-    MonitorQMP *mon;
-    /*
-     * Request object to be handled or Error to be reported
-     * (exactly one of them is non-null)
-     */
-    QObject *req;
-    Error *err;
-};
-typedef struct QMPRequest QMPRequest;
-
 /* QMP checker flags */
 #define QMP_ACCEPT_UNKNOWNS 1
=20
 /* Protects mon_list, monitor_qapi_event_state, monitor_destroyed.  */
-static QemuMutex monitor_lock;
+QemuMutex monitor_lock;
 static GHashTable *monitor_qapi_event_state;
-static QTAILQ_HEAD(, Monitor) mon_list;
+MonitorList mon_list;
 static bool monitor_destroyed;
=20
 /* Protects mon_fdsets */
 static QemuMutex mon_fdsets_lock;
 static QLIST_HEAD(, MonFdset) mon_fdsets;
=20
-static int mon_refcount;
+int mon_refcount;
=20
 static HMPCommand hmp_cmds[];
 static HMPCommand hmp_info_cmds[];
=20
-QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
-
 __thread Monitor *cur_mon;
=20
 static void monitor_command_cb(void *opaque, const char *cmdline,
                                void *readline_opaque);
=20
-/**
- * Is @mon a QMP monitor?
- */
-static inline bool monitor_is_qmp(const Monitor *mon)
-{
-    return (mon->flags & MONITOR_USE_CONTROL);
-}
-
 /**
  * Is @mon is using readline?
  * Note: not all HMP monitors use readline, e.g., gdbserver has a
@@ -241,28 +215,6 @@ int monitor_read_password(MonitorHMP *mon, ReadLineF=
unc *readline_func,
     }
 }
=20
-static void qmp_request_free(QMPRequest *req)
-{
-    qobject_unref(req->req);
-    error_free(req->err);
-    g_free(req);
-}
-
-/* Caller must hold mon->qmp.qmp_queue_lock */
-static void monitor_qmp_cleanup_req_queue_locked(MonitorQMP *mon)
-{
-    while (!g_queue_is_empty(mon->qmp_requests)) {
-        qmp_request_free(g_queue_pop_head(mon->qmp_requests));
-    }
-}
-
-static void monitor_qmp_cleanup_queues(MonitorQMP *mon)
-{
-    qemu_mutex_lock(&mon->qmp_queue_lock);
-    monitor_qmp_cleanup_req_queue_locked(mon);
-    qemu_mutex_unlock(&mon->qmp_queue_lock);
-}
-
=20
 static void monitor_flush_locked(Monitor *mon);
=20
@@ -322,7 +274,7 @@ void monitor_flush(Monitor *mon)
 }
=20
 /* flush at every end of line */
-static int monitor_puts(Monitor *mon, const char *str)
+int monitor_puts(Monitor *mon, const char *str)
 {
     int i;
     char c;
@@ -372,21 +324,6 @@ int monitor_printf(Monitor *mon, const char *fmt, ..=
.)
     return ret;
 }
=20
-static void qmp_send_response(MonitorQMP *mon, const QDict *rsp)
-{
-    const QObject *data =3D QOBJECT(rsp);
-    QString *json;
-
-    json =3D mon->common.flags & MONITOR_USE_PRETTY ?
-           qobject_to_json_pretty(data) : qobject_to_json(data);
-    assert(json !=3D NULL);
-
-    qstring_append_chr(json, '\n');
-    monitor_puts(&mon->common, qstring_get_str(json));
-
-    qobject_unref(json);
-}
-
 static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] =3D=
 {
     /* Limit guest-triggerable events to 1 per second */
     [QAPI_EVENT_RTC_CHANGE]        =3D { 1000 * SCALE_MS },
@@ -601,8 +538,8 @@ static void handle_hmp_command(MonitorHMP *mon, const=
 char *cmdline);
=20
 static void monitor_iothread_init(void);
=20
-static void monitor_data_init(Monitor *mon, int flags, bool skip_flush,
-                              bool use_io_thread)
+void monitor_data_init(Monitor *mon, int flags, bool skip_flush,
+                       bool use_io_thread)
 {
     if (use_io_thread && !mon_iothread) {
         monitor_iothread_init();
@@ -614,14 +551,6 @@ static void monitor_data_init(Monitor *mon, int flag=
s, bool skip_flush,
     mon->flags =3D flags;
 }
=20
-static void monitor_data_destroy_qmp(MonitorQMP *mon)
-{
-    json_message_parser_destroy(&mon->parser);
-    qemu_mutex_destroy(&mon->qmp_queue_lock);
-    monitor_qmp_cleanup_req_queue_locked(mon);
-    g_queue_free(mon->qmp_requests);
-}
-
 static void monitor_data_destroy(Monitor *mon)
 {
     g_free(mon->mon_cpu_path);
@@ -1058,18 +987,6 @@ static void monitor_init_qmp_commands(void)
                          qmp_marshal_qmp_capabilities, QCO_ALLOW_PRECONF=
IG);
 }
=20
-static bool qmp_oob_enabled(MonitorQMP *mon)
-{
-    return mon->capab[QMP_CAPABILITY_OOB];
-}
-
-static void monitor_qmp_caps_reset(MonitorQMP *mon)
-{
-    memset(mon->capab_offered, 0, sizeof(mon->capab_offered));
-    memset(mon->capab, 0, sizeof(mon->capab));
-    mon->capab_offered[QMP_CAPABILITY_OOB] =3D mon->common.use_io_thread=
;
-}
-
 /*
  * Accept QMP capabilities in @list for @mon.
  * On success, set mon->qmp.capab[], and return true.
@@ -2245,7 +2162,7 @@ static void monitor_fdset_cleanup(MonFdset *mon_fds=
et)
     }
 }
=20
-static void monitor_fdsets_cleanup(void)
+void monitor_fdsets_cleanup(void)
 {
     MonFdset *mon_fdset;
     MonFdset *mon_fdset_next;
@@ -4023,209 +3940,13 @@ cleanup:
     free_cmdline_args(args, nb_args);
 }
=20
-static int monitor_can_read(void *opaque)
+int monitor_can_read(void *opaque)
 {
     Monitor *mon =3D opaque;
=20
     return !atomic_mb_read(&mon->suspend_cnt);
 }
=20
-/*
- * Emit QMP response @rsp with ID @id to @mon.
- * Null @rsp can only happen for commands with QCO_NO_SUCCESS_RESP.
- * Nothing is emitted then.
- */
-static void monitor_qmp_respond(MonitorQMP *mon, QDict *rsp)
-{
-    if (rsp) {
-        qmp_send_response(mon, rsp);
-    }
-}
-
-static void monitor_qmp_dispatch(MonitorQMP *mon, QObject *req)
-{
-    Monitor *old_mon;
-    QDict *rsp;
-    QDict *error;
-
-    old_mon =3D cur_mon;
-    cur_mon =3D &mon->common;
-
-    rsp =3D qmp_dispatch(mon->commands, req, qmp_oob_enabled(mon));
-
-    cur_mon =3D old_mon;
-
-    if (mon->commands =3D=3D &qmp_cap_negotiation_commands) {
-        error =3D qdict_get_qdict(rsp, "error");
-        if (error
-            && !g_strcmp0(qdict_get_try_str(error, "class"),
-                    QapiErrorClass_str(ERROR_CLASS_COMMAND_NOT_FOUND))) =
{
-            /* Provide a more useful error message */
-            qdict_del(error, "desc");
-            qdict_put_str(error, "desc", "Expecting capabilities negotia=
tion"
-                          " with 'qmp_capabilities'");
-        }
-    }
-
-    monitor_qmp_respond(mon, rsp);
-    qobject_unref(rsp);
-}
-
-/*
- * Pop a QMP request from a monitor request queue.
- * Return the request, or NULL all request queues are empty.
- * We are using round-robin fashion to pop the request, to avoid
- * processing commands only on a very busy monitor.  To achieve that,
- * when we process one request on a specific monitor, we put that
- * monitor to the end of mon_list queue.
- *
- * Note: if the function returned with non-NULL, then the caller will
- * be with qmp_mon->qmp_queue_lock held, and the caller is responsible
- * to release it.
- */
-static QMPRequest *monitor_qmp_requests_pop_any_with_lock(void)
-{
-    QMPRequest *req_obj =3D NULL;
-    Monitor *mon;
-    MonitorQMP *qmp_mon;
-
-    qemu_mutex_lock(&monitor_lock);
-
-    QTAILQ_FOREACH(mon, &mon_list, entry) {
-        if (!monitor_is_qmp(mon)) {
-            continue;
-        }
-
-        qmp_mon =3D container_of(mon, MonitorQMP, common);
-        qemu_mutex_lock(&qmp_mon->qmp_queue_lock);
-        req_obj =3D g_queue_pop_head(qmp_mon->qmp_requests);
-        if (req_obj) {
-            /* With the lock of corresponding queue held */
-            break;
-        }
-        qemu_mutex_unlock(&qmp_mon->qmp_queue_lock);
-    }
-
-    if (req_obj) {
-        /*
-         * We found one request on the monitor. Degrade this monitor's
-         * priority to lowest by re-inserting it to end of queue.
-         */
-        QTAILQ_REMOVE(&mon_list, mon, entry);
-        QTAILQ_INSERT_TAIL(&mon_list, mon, entry);
-    }
-
-    qemu_mutex_unlock(&monitor_lock);
-
-    return req_obj;
-}
-
-static void monitor_qmp_bh_dispatcher(void *data)
-{
-    QMPRequest *req_obj =3D monitor_qmp_requests_pop_any_with_lock();
-    QDict *rsp;
-    bool need_resume;
-    MonitorQMP *mon;
-
-    if (!req_obj) {
-        return;
-    }
-
-    mon =3D req_obj->mon;
-    /*  qmp_oob_enabled() might change after "qmp_capabilities" */
-    need_resume =3D !qmp_oob_enabled(mon) ||
-        mon->qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX - 1;
-    qemu_mutex_unlock(&mon->qmp_queue_lock);
-    if (req_obj->req) {
-        QDict *qdict =3D qobject_to(QDict, req_obj->req);
-        QObject *id =3D qdict ? qdict_get(qdict, "id") : NULL;
-        trace_monitor_qmp_cmd_in_band(qobject_get_try_str(id) ?: "");
-        monitor_qmp_dispatch(mon, req_obj->req);
-    } else {
-        assert(req_obj->err);
-        rsp =3D qmp_error_response(req_obj->err);
-        req_obj->err =3D NULL;
-        monitor_qmp_respond(mon, rsp);
-        qobject_unref(rsp);
-    }
-
-    if (need_resume) {
-        /* Pairs with the monitor_suspend() in handle_qmp_command() */
-        monitor_resume(&mon->common);
-    }
-    qmp_request_free(req_obj);
-
-    /* Reschedule instead of looping so the main loop stays responsive *=
/
-    qemu_bh_schedule(qmp_dispatcher_bh);
-}
-
-static void handle_qmp_command(void *opaque, QObject *req, Error *err)
-{
-    MonitorQMP *mon =3D opaque;
-    QObject *id =3D NULL;
-    QDict *qdict;
-    QMPRequest *req_obj;
-
-    assert(!req !=3D !err);
-
-    qdict =3D qobject_to(QDict, req);
-    if (qdict) {
-        id =3D qdict_get(qdict, "id");
-    } /* else will fail qmp_dispatch() */
-
-    if (req && trace_event_get_state_backends(TRACE_HANDLE_QMP_COMMAND))=
 {
-        QString *req_json =3D qobject_to_json(req);
-        trace_handle_qmp_command(mon, qstring_get_str(req_json));
-        qobject_unref(req_json);
-    }
-
-    if (qdict && qmp_is_oob(qdict)) {
-        /* OOB commands are executed immediately */
-        trace_monitor_qmp_cmd_out_of_band(qobject_get_try_str(id) ?: "")=
;
-        monitor_qmp_dispatch(mon, req);
-        qobject_unref(req);
-        return;
-    }
-
-    req_obj =3D g_new0(QMPRequest, 1);
-    req_obj->mon =3D mon;
-    req_obj->req =3D req;
-    req_obj->err =3D err;
-
-    /* Protect qmp_requests and fetching its length. */
-    qemu_mutex_lock(&mon->qmp_queue_lock);
-
-    /*
-     * Suspend the monitor when we can't queue more requests after
-     * this one.  Dequeuing in monitor_qmp_bh_dispatcher() will resume
-     * it.  Note that when OOB is disabled, we queue at most one
-     * command, for backward compatibility.
-     */
-    if (!qmp_oob_enabled(mon) ||
-        mon->qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX - 1) {
-        monitor_suspend(&mon->common);
-    }
-
-    /*
-     * Put the request to the end of queue so that requests will be
-     * handled in time order.  Ownership for req_obj, req,
-     * etc. will be delivered to the handler side.
-     */
-    assert(mon->qmp_requests->length < QMP_REQ_QUEUE_LEN_MAX);
-    g_queue_push_tail(mon->qmp_requests, req_obj);
-    qemu_mutex_unlock(&mon->qmp_queue_lock);
-
-    /* Kick the dispatcher routine */
-    qemu_bh_schedule(qmp_dispatcher_bh);
-}
-
-static void monitor_qmp_read(void *opaque, const uint8_t *buf, int size)
-{
-    MonitorQMP *mon =3D opaque;
-
-    json_message_parser_feed(&mon->parser, (const char *) buf, size);
-}
-
 static void monitor_read(void *opaque, const uint8_t *buf, int size)
 {
     MonitorHMP *mon;
@@ -4312,56 +4033,6 @@ void monitor_resume(Monitor *mon)
     trace_monitor_suspend(mon, -1);
 }
=20
-static QDict *qmp_greeting(MonitorQMP *mon)
-{
-    QList *cap_list =3D qlist_new();
-    QObject *ver =3D NULL;
-    QMPCapability cap;
-
-    qmp_marshal_query_version(NULL, &ver, NULL);
-
-    for (cap =3D 0; cap < QMP_CAPABILITY__MAX; cap++) {
-        if (mon->capab_offered[cap]) {
-            qlist_append_str(cap_list, QMPCapability_str(cap));
-        }
-    }
-
-    return qdict_from_jsonf_nofail(
-        "{'QMP': {'version': %p, 'capabilities': %p}}",
-        ver, cap_list);
-}
-
-static void monitor_qmp_event(void *opaque, int event)
-{
-    QDict *data;
-    MonitorQMP *mon =3D opaque;
-
-    switch (event) {
-    case CHR_EVENT_OPENED:
-        mon->commands =3D &qmp_cap_negotiation_commands;
-        monitor_qmp_caps_reset(mon);
-        data =3D qmp_greeting(mon);
-        qmp_send_response(mon, data);
-        qobject_unref(data);
-        mon_refcount++;
-        break;
-    case CHR_EVENT_CLOSED:
-        /*
-         * Note: this is only useful when the output of the chardev
-         * backend is still open.  For example, when the backend is
-         * stdio, it's possible that stdout is still open when stdin
-         * is closed.
-         */
-        monitor_qmp_cleanup_queues(mon);
-        json_message_parser_destroy(&mon->parser);
-        json_message_parser_init(&mon->parser, handle_qmp_command,
-                                 mon, NULL);
-        mon_refcount--;
-        monitor_fdsets_cleanup();
-        break;
-    }
-}
-
 static void monitor_event(void *opaque, int event)
 {
     Monitor *mon =3D opaque;
@@ -4495,7 +4166,7 @@ int error_vprintf_unless_qmp(const char *fmt, va_li=
st ap)
     return -1;
 }
=20
-static void monitor_list_append(Monitor *mon)
+void monitor_list_append(Monitor *mon)
 {
     qemu_mutex_lock(&monitor_lock);
     /*
@@ -4515,60 +4186,6 @@ static void monitor_list_append(Monitor *mon)
     }
 }
=20
-static void monitor_qmp_setup_handlers_bh(void *opaque)
-{
-    MonitorQMP *mon =3D opaque;
-    GMainContext *context;
-
-    assert(mon->common.use_io_thread);
-    context =3D iothread_get_g_main_context(mon_iothread);
-    assert(context);
-    qemu_chr_fe_set_handlers(&mon->common.chr, monitor_can_read,
-                             monitor_qmp_read, monitor_qmp_event,
-                             NULL, &mon->common, context, true);
-    monitor_list_append(&mon->common);
-}
-
-static void monitor_init_qmp(Chardev *chr, int flags)
-{
-    MonitorQMP *mon =3D g_new0(MonitorQMP, 1);
-
-    /* Only HMP supports readline */
-    assert(!(flags & MONITOR_USE_READLINE));
-
-    /* Note: we run QMP monitor in I/O thread when @chr supports that */
-    monitor_data_init(&mon->common, flags, false,
-                      qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTE=
XT));
-
-    qemu_mutex_init(&mon->qmp_queue_lock);
-    mon->qmp_requests =3D g_queue_new();
-
-    qemu_chr_fe_init(&mon->common.chr, chr, &error_abort);
-    qemu_chr_fe_set_echo(&mon->common.chr, true);
-
-    json_message_parser_init(&mon->parser, handle_qmp_command, mon, NULL=
);
-    if (mon->common.use_io_thread) {
-        /*
-         * Make sure the old iowatch is gone.  It's possible when
-         * e.g. the chardev is in client mode, with wait=3Don.
-         */
-        remove_fd_in_watch(chr);
-        /*
-         * We can't call qemu_chr_fe_set_handlers() directly here
-         * since chardev might be running in the monitor I/O
-         * thread.  Schedule a bottom half.
-         */
-        aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
-                                monitor_qmp_setup_handlers_bh, mon);
-        /* The bottom half will add @mon to @mon_list */
-    } else {
-        qemu_chr_fe_set_handlers(&mon->common.chr, monitor_can_read,
-                                 monitor_qmp_read, monitor_qmp_event,
-                                 NULL, &mon->common, NULL, true);
-        monitor_list_append(&mon->common);
-    }
-}
-
 static void monitor_init_hmp(Chardev *chr, int flags)
 {
     MonitorHMP *mon =3D g_new0(MonitorHMP, 1);
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index ebaf0201c8..d859bd3894 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -31,6 +31,7 @@
 #include "qapi/qmp/dispatch.h"
 #include "qapi/qmp/json-parser.h"
 #include "qemu/readline.h"
+#include "sysemu/iothread.h"
=20
 /*
  * Supported types:
@@ -142,4 +143,33 @@ typedef struct {
     GQueue *qmp_requests;
 } MonitorQMP;
=20
+/**
+ * Is @mon a QMP monitor?
+ */
+static inline bool monitor_is_qmp(const Monitor *mon)
+{
+    return mon->flags & MONITOR_USE_CONTROL;
+}
+
+typedef QTAILQ_HEAD(MonitorList, Monitor) MonitorList;
+extern IOThread *mon_iothread;
+extern QEMUBH *qmp_dispatcher_bh;
+extern QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
+extern QemuMutex monitor_lock;
+extern MonitorList mon_list;
+extern int mon_refcount;
+
+void monitor_init_qmp(Chardev *chr, int flags);
+
+int monitor_puts(Monitor *mon, const char *str);
+void monitor_data_init(Monitor *mon, int flags, bool skip_flush,
+                       bool use_io_thread);
+int monitor_can_read(void *opaque);
+void monitor_list_append(Monitor *mon);
+void monitor_fdsets_cleanup(void);
+
+void qmp_send_response(MonitorQMP *mon, const QDict *rsp);
+void monitor_data_destroy_qmp(MonitorQMP *mon);
+void monitor_qmp_bh_dispatcher(void *data);
+
 #endif
diff --git a/monitor/qmp.c b/monitor/qmp.c
new file mode 100644
index 0000000000..7c3d081a72
--- /dev/null
+++ b/monitor/qmp.c
@@ -0,0 +1,406 @@
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
+
+#include "chardev/char-io.h"
+#include "monitor-internal.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-misc.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qjson.h"
+#include "qapi/qmp/qlist.h"
+#include "qapi/qmp/qstring.h"
+#include "trace.h"
+
+struct QMPRequest {
+    /* Owner of the request */
+    MonitorQMP *mon;
+    /*
+     * Request object to be handled or Error to be reported
+     * (exactly one of them is non-null)
+     */
+    QObject *req;
+    Error *err;
+};
+typedef struct QMPRequest QMPRequest;
+
+QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
+
+static bool qmp_oob_enabled(MonitorQMP *mon)
+{
+    return mon->capab[QMP_CAPABILITY_OOB];
+}
+
+static void monitor_qmp_caps_reset(MonitorQMP *mon)
+{
+    memset(mon->capab_offered, 0, sizeof(mon->capab_offered));
+    memset(mon->capab, 0, sizeof(mon->capab));
+    mon->capab_offered[QMP_CAPABILITY_OOB] =3D mon->common.use_io_thread=
;
+}
+
+static void qmp_request_free(QMPRequest *req)
+{
+    qobject_unref(req->req);
+    error_free(req->err);
+    g_free(req);
+}
+
+/* Caller must hold mon->qmp.qmp_queue_lock */
+static void monitor_qmp_cleanup_req_queue_locked(MonitorQMP *mon)
+{
+    while (!g_queue_is_empty(mon->qmp_requests)) {
+        qmp_request_free(g_queue_pop_head(mon->qmp_requests));
+    }
+}
+
+static void monitor_qmp_cleanup_queues(MonitorQMP *mon)
+{
+    qemu_mutex_lock(&mon->qmp_queue_lock);
+    monitor_qmp_cleanup_req_queue_locked(mon);
+    qemu_mutex_unlock(&mon->qmp_queue_lock);
+}
+
+void qmp_send_response(MonitorQMP *mon, const QDict *rsp)
+{
+    const QObject *data =3D QOBJECT(rsp);
+    QString *json;
+
+    json =3D mon->common.flags & MONITOR_USE_PRETTY ?
+           qobject_to_json_pretty(data) : qobject_to_json(data);
+    assert(json !=3D NULL);
+
+    qstring_append_chr(json, '\n');
+    monitor_puts(&mon->common, qstring_get_str(json));
+
+    qobject_unref(json);
+}
+
+/*
+ * Emit QMP response @rsp with ID @id to @mon.
+ * Null @rsp can only happen for commands with QCO_NO_SUCCESS_RESP.
+ * Nothing is emitted then.
+ */
+static void monitor_qmp_respond(MonitorQMP *mon, QDict *rsp)
+{
+    if (rsp) {
+        qmp_send_response(mon, rsp);
+    }
+}
+
+static void monitor_qmp_dispatch(MonitorQMP *mon, QObject *req)
+{
+    Monitor *old_mon;
+    QDict *rsp;
+    QDict *error;
+
+    old_mon =3D cur_mon;
+    cur_mon =3D &mon->common;
+
+    rsp =3D qmp_dispatch(mon->commands, req, qmp_oob_enabled(mon));
+
+    cur_mon =3D old_mon;
+
+    if (mon->commands =3D=3D &qmp_cap_negotiation_commands) {
+        error =3D qdict_get_qdict(rsp, "error");
+        if (error
+            && !g_strcmp0(qdict_get_try_str(error, "class"),
+                    QapiErrorClass_str(ERROR_CLASS_COMMAND_NOT_FOUND))) =
{
+            /* Provide a more useful error message */
+            qdict_del(error, "desc");
+            qdict_put_str(error, "desc", "Expecting capabilities negotia=
tion"
+                          " with 'qmp_capabilities'");
+        }
+    }
+
+    monitor_qmp_respond(mon, rsp);
+    qobject_unref(rsp);
+}
+
+/*
+ * Pop a QMP request from a monitor request queue.
+ * Return the request, or NULL all request queues are empty.
+ * We are using round-robin fashion to pop the request, to avoid
+ * processing commands only on a very busy monitor.  To achieve that,
+ * when we process one request on a specific monitor, we put that
+ * monitor to the end of mon_list queue.
+ *
+ * Note: if the function returned with non-NULL, then the caller will
+ * be with qmp_mon->qmp_queue_lock held, and the caller is responsible
+ * to release it.
+ */
+static QMPRequest *monitor_qmp_requests_pop_any_with_lock(void)
+{
+    QMPRequest *req_obj =3D NULL;
+    Monitor *mon;
+    MonitorQMP *qmp_mon;
+
+    qemu_mutex_lock(&monitor_lock);
+
+    QTAILQ_FOREACH(mon, &mon_list, entry) {
+        if (!monitor_is_qmp(mon)) {
+            continue;
+        }
+
+        qmp_mon =3D container_of(mon, MonitorQMP, common);
+        qemu_mutex_lock(&qmp_mon->qmp_queue_lock);
+        req_obj =3D g_queue_pop_head(qmp_mon->qmp_requests);
+        if (req_obj) {
+            /* With the lock of corresponding queue held */
+            break;
+        }
+        qemu_mutex_unlock(&qmp_mon->qmp_queue_lock);
+    }
+
+    if (req_obj) {
+        /*
+         * We found one request on the monitor. Degrade this monitor's
+         * priority to lowest by re-inserting it to end of queue.
+         */
+        QTAILQ_REMOVE(&mon_list, mon, entry);
+        QTAILQ_INSERT_TAIL(&mon_list, mon, entry);
+    }
+
+    qemu_mutex_unlock(&monitor_lock);
+
+    return req_obj;
+}
+
+void monitor_qmp_bh_dispatcher(void *data)
+{
+    QMPRequest *req_obj =3D monitor_qmp_requests_pop_any_with_lock();
+    QDict *rsp;
+    bool need_resume;
+    MonitorQMP *mon;
+
+    if (!req_obj) {
+        return;
+    }
+
+    mon =3D req_obj->mon;
+    /*  qmp_oob_enabled() might change after "qmp_capabilities" */
+    need_resume =3D !qmp_oob_enabled(mon) ||
+        mon->qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX - 1;
+    qemu_mutex_unlock(&mon->qmp_queue_lock);
+    if (req_obj->req) {
+        QDict *qdict =3D qobject_to(QDict, req_obj->req);
+        QObject *id =3D qdict ? qdict_get(qdict, "id") : NULL;
+        trace_monitor_qmp_cmd_in_band(qobject_get_try_str(id) ?: "");
+        monitor_qmp_dispatch(mon, req_obj->req);
+    } else {
+        assert(req_obj->err);
+        rsp =3D qmp_error_response(req_obj->err);
+        req_obj->err =3D NULL;
+        monitor_qmp_respond(mon, rsp);
+        qobject_unref(rsp);
+    }
+
+    if (need_resume) {
+        /* Pairs with the monitor_suspend() in handle_qmp_command() */
+        monitor_resume(&mon->common);
+    }
+    qmp_request_free(req_obj);
+
+    /* Reschedule instead of looping so the main loop stays responsive *=
/
+    qemu_bh_schedule(qmp_dispatcher_bh);
+}
+
+static void handle_qmp_command(void *opaque, QObject *req, Error *err)
+{
+    MonitorQMP *mon =3D opaque;
+    QObject *id =3D NULL;
+    QDict *qdict;
+    QMPRequest *req_obj;
+
+    assert(!req !=3D !err);
+
+    qdict =3D qobject_to(QDict, req);
+    if (qdict) {
+        id =3D qdict_get(qdict, "id");
+    } /* else will fail qmp_dispatch() */
+
+    if (req && trace_event_get_state_backends(TRACE_HANDLE_QMP_COMMAND))=
 {
+        QString *req_json =3D qobject_to_json(req);
+        trace_handle_qmp_command(mon, qstring_get_str(req_json));
+        qobject_unref(req_json);
+    }
+
+    if (qdict && qmp_is_oob(qdict)) {
+        /* OOB commands are executed immediately */
+        trace_monitor_qmp_cmd_out_of_band(qobject_get_try_str(id) ?: "")=
;
+        monitor_qmp_dispatch(mon, req);
+        qobject_unref(req);
+        return;
+    }
+
+    req_obj =3D g_new0(QMPRequest, 1);
+    req_obj->mon =3D mon;
+    req_obj->req =3D req;
+    req_obj->err =3D err;
+
+    /* Protect qmp_requests and fetching its length. */
+    qemu_mutex_lock(&mon->qmp_queue_lock);
+
+    /*
+     * Suspend the monitor when we can't queue more requests after
+     * this one.  Dequeuing in monitor_qmp_bh_dispatcher() will resume
+     * it.  Note that when OOB is disabled, we queue at most one
+     * command, for backward compatibility.
+     */
+    if (!qmp_oob_enabled(mon) ||
+        mon->qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX - 1) {
+        monitor_suspend(&mon->common);
+    }
+
+    /*
+     * Put the request to the end of queue so that requests will be
+     * handled in time order.  Ownership for req_obj, req,
+     * etc. will be delivered to the handler side.
+     */
+    assert(mon->qmp_requests->length < QMP_REQ_QUEUE_LEN_MAX);
+    g_queue_push_tail(mon->qmp_requests, req_obj);
+    qemu_mutex_unlock(&mon->qmp_queue_lock);
+
+    /* Kick the dispatcher routine */
+    qemu_bh_schedule(qmp_dispatcher_bh);
+}
+
+static void monitor_qmp_read(void *opaque, const uint8_t *buf, int size)
+{
+    MonitorQMP *mon =3D opaque;
+
+    json_message_parser_feed(&mon->parser, (const char *) buf, size);
+}
+
+static QDict *qmp_greeting(MonitorQMP *mon)
+{
+    QList *cap_list =3D qlist_new();
+    QObject *ver =3D NULL;
+    QMPCapability cap;
+
+    qmp_marshal_query_version(NULL, &ver, NULL);
+
+    for (cap =3D 0; cap < QMP_CAPABILITY__MAX; cap++) {
+        if (mon->capab_offered[cap]) {
+            qlist_append_str(cap_list, QMPCapability_str(cap));
+        }
+    }
+
+    return qdict_from_jsonf_nofail(
+        "{'QMP': {'version': %p, 'capabilities': %p}}",
+        ver, cap_list);
+}
+
+static void monitor_qmp_event(void *opaque, int event)
+{
+    QDict *data;
+    MonitorQMP *mon =3D opaque;
+
+    switch (event) {
+    case CHR_EVENT_OPENED:
+        mon->commands =3D &qmp_cap_negotiation_commands;
+        monitor_qmp_caps_reset(mon);
+        data =3D qmp_greeting(mon);
+        qmp_send_response(mon, data);
+        qobject_unref(data);
+        mon_refcount++;
+        break;
+    case CHR_EVENT_CLOSED:
+        /*
+         * Note: this is only useful when the output of the chardev
+         * backend is still open.  For example, when the backend is
+         * stdio, it's possible that stdout is still open when stdin
+         * is closed.
+         */
+        monitor_qmp_cleanup_queues(mon);
+        json_message_parser_destroy(&mon->parser);
+        json_message_parser_init(&mon->parser, handle_qmp_command,
+                                 mon, NULL);
+        mon_refcount--;
+        monitor_fdsets_cleanup();
+        break;
+    }
+}
+
+void monitor_data_destroy_qmp(MonitorQMP *mon)
+{
+    json_message_parser_destroy(&mon->parser);
+    qemu_mutex_destroy(&mon->qmp_queue_lock);
+    monitor_qmp_cleanup_req_queue_locked(mon);
+    g_queue_free(mon->qmp_requests);
+}
+
+static void monitor_qmp_setup_handlers_bh(void *opaque)
+{
+    MonitorQMP *mon =3D opaque;
+    GMainContext *context;
+
+    assert(mon->common.use_io_thread);
+    context =3D iothread_get_g_main_context(mon_iothread);
+    assert(context);
+    qemu_chr_fe_set_handlers(&mon->common.chr, monitor_can_read,
+                             monitor_qmp_read, monitor_qmp_event,
+                             NULL, &mon->common, context, true);
+    monitor_list_append(&mon->common);
+}
+
+void monitor_init_qmp(Chardev *chr, int flags)
+{
+    MonitorQMP *mon =3D g_new0(MonitorQMP, 1);
+
+    /* Only HMP supports readline */
+    assert(!(flags & MONITOR_USE_READLINE));
+
+    /* Note: we run QMP monitor in I/O thread when @chr supports that */
+    monitor_data_init(&mon->common, flags, false,
+                      qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTE=
XT));
+
+    qemu_mutex_init(&mon->qmp_queue_lock);
+    mon->qmp_requests =3D g_queue_new();
+
+    qemu_chr_fe_init(&mon->common.chr, chr, &error_abort);
+    qemu_chr_fe_set_echo(&mon->common.chr, true);
+
+    json_message_parser_init(&mon->parser, handle_qmp_command, mon, NULL=
);
+    if (mon->common.use_io_thread) {
+        /*
+         * Make sure the old iowatch is gone.  It's possible when
+         * e.g. the chardev is in client mode, with wait=3Don.
+         */
+        remove_fd_in_watch(chr);
+        /*
+         * We can't call qemu_chr_fe_set_handlers() directly here
+         * since chardev might be running in the monitor I/O
+         * thread.  Schedule a bottom half.
+         */
+        aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
+                                monitor_qmp_setup_handlers_bh, mon);
+        /* The bottom half will add @mon to @mon_list */
+    } else {
+        qemu_chr_fe_set_handlers(&mon->common.chr, monitor_can_read,
+                                 monitor_qmp_read, monitor_qmp_event,
+                                 NULL, &mon->common, NULL, true);
+        monitor_list_append(&mon->common);
+    }
+}
diff --git a/monitor/trace-events b/monitor/trace-events
index abfdf20b14..a06dde3fd3 100644
--- a/monitor/trace-events
+++ b/monitor/trace-events
@@ -5,7 +5,9 @@ monitor_protocol_event_handler(uint32_t event, void *qdic=
t) "event=3D%d data=3D%p"
 monitor_protocol_event_emit(uint32_t event, void *data) "event=3D%d data=
=3D%p"
 monitor_protocol_event_queue(uint32_t event, void *qdict, uint64_t rate)=
 "event=3D%d data=3D%p rate=3D%" PRId64
 handle_hmp_command(void *mon, const char *cmdline) "mon %p cmdline: %s"
-handle_qmp_command(void *mon, const char *req) "mon %p req: %s"
 monitor_suspend(void *ptr, int cnt) "mon %p: %d"
+
+# qmp.c
 monitor_qmp_cmd_in_band(const char *id) "%s"
 monitor_qmp_cmd_out_of_band(const char *id) "%s"
+handle_qmp_command(void *mon, const char *req) "mon %p req: %s"
--=20
2.21.0


