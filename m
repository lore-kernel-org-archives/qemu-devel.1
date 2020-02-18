Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EB2C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 15:43:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D112A2176D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 15:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dgIuGhwj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D112A2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j451Z-0002Uf-1w
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 10:43:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j44zW-0006gF-VB
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 10:40:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j44zU-0001ew-MZ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 10:40:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34124
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j44zU-0001ej-H9
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 10:40:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582040452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2nJJibWr+MWF10oEnk54fPJyk9Rolq9tmMWulfdPvw=;
 b=dgIuGhwjj87rhfO8C6CcL0CoDMeNUgd543an7PF/gDxpzSopRx0aKVA1Q7X5sFTp1PsLz/
 6I6576UQCa/02axsZIW/PSCBS1VfOjceQ/JL0cmq+ZfjTZbfmVUPnJwKlhGApz58i/VsFe
 KhND42qrW3LwC76DldImD50KgU3dXvo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-Qp2Ics0aP-mi_3ucMGTzzQ-1; Tue, 18 Feb 2020 10:40:49 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A15A5800D48;
 Tue, 18 Feb 2020 15:40:48 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-181.ams2.redhat.com
 [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F2AB5C13B;
 Tue, 18 Feb 2020 15:40:47 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 3/4] qmp: Move dispatcher to a coroutine
Date: Tue, 18 Feb 2020 16:40:35 +0100
Message-Id: <20200218154036.28562-4-kwolf@redhat.com>
In-Reply-To: <20200218154036.28562-1-kwolf@redhat.com>
References: <20200218154036.28562-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Qp2Ics0aP-mi_3ucMGTzzQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: kwolf@redhat.com, marcandre.lureau@gmail.com, armbru@redhat.com,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This moves the QMP dispatcher to a coroutine and runs all QMP command
handlers that declare 'coroutine': true in coroutine context so they
can avoid blocking the main loop while doing I/O or waiting for other
events.

For commands that are not declared safe to run in a coroutine, the
dispatcher drops out of coroutine context by calling the QMP command
handler from a bottom half.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/qapi/qmp/dispatch.h |   1 +
 monitor/monitor-internal.h  |   6 +-
 monitor/monitor.c           |  55 +++++++++++++---
 monitor/qmp.c               | 122 +++++++++++++++++++++++++++---------
 qapi/qmp-dispatch.c         |  44 ++++++++++++-
 qapi/qmp-registry.c         |   3 +
 util/aio-posix.c            |   7 ++-
 7 files changed, 196 insertions(+), 42 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index d6ce9efc8e..6812e49b5f 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -30,6 +30,7 @@ typedef enum QmpCommandOptions
 typedef struct QmpCommand
 {
     const char *name;
+    /* Runs in coroutine context if QCO_COROUTINE is set */
     QmpCommandFunc *fn;
     QmpCommandOptions options;
     QTAILQ_ENTRY(QmpCommand) node;
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 3e6baba88f..f8123b151a 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -155,7 +155,9 @@ static inline bool monitor_is_qmp(const Monitor *mon)
=20
 typedef QTAILQ_HEAD(MonitorList, Monitor) MonitorList;
 extern IOThread *mon_iothread;
-extern QEMUBH *qmp_dispatcher_bh;
+extern Coroutine *qmp_dispatcher_co;
+extern bool qmp_dispatcher_co_shutdown;
+extern bool qmp_dispatcher_co_busy;
 extern QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
 extern QemuMutex monitor_lock;
 extern MonitorList mon_list;
@@ -173,7 +175,7 @@ void monitor_fdsets_cleanup(void);
=20
 void qmp_send_response(MonitorQMP *mon, const QDict *rsp);
 void monitor_data_destroy_qmp(MonitorQMP *mon);
-void monitor_qmp_bh_dispatcher(void *data);
+void coroutine_fn monitor_qmp_dispatcher_co(void *data);
=20
 int get_monitor_def(int64_t *pval, const char *name);
 void help_cmd(Monitor *mon, const char *name);
diff --git a/monitor/monitor.c b/monitor/monitor.c
index c1a6c4460f..72d57b5cd2 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -53,8 +53,32 @@ typedef struct {
 /* Shared monitor I/O thread */
 IOThread *mon_iothread;
=20
-/* Bottom half to dispatch the requests received from I/O thread */
-QEMUBH *qmp_dispatcher_bh;
+/* Coroutine to dispatch the requests received from I/O thread */
+Coroutine *qmp_dispatcher_co;
+
+/* Set to true when the dispatcher coroutine should terminate */
+bool qmp_dispatcher_co_shutdown;
+
+/*
+ * qmp_dispatcher_co_busy is used for synchronisation between the
+ * monitor thread and the main thread to ensure that the dispatcher
+ * coroutine never gets scheduled a second time when it's already
+ * scheduled (scheduling the same coroutine twice is forbidden).
+ *
+ * It is true if the coroutine is active and processing requests.
+ * Additional requests may then be pushed onto a mon->qmp_requests,
+ * and @qmp_dispatcher_co_shutdown may be set without further ado.
+ * @qmp_dispatcher_co_busy must not be woken up in this case.
+ *
+ * If false, you also have to set @qmp_dispatcher_co_busy to true and
+ * wake up @qmp_dispatcher_co after pushing the new requests.
+ *
+ * The coroutine will automatically change this variable back to false
+ * before it yields.  Nobody else may set the variable to false.
+ *
+ * Access must be atomic for thread safety.
+ */
+bool qmp_dispatcher_co_busy;
=20
 /* Protects mon_list, monitor_qapi_event_state, monitor_destroyed.  */
 QemuMutex monitor_lock;
@@ -579,9 +603,24 @@ void monitor_cleanup(void)
     }
     qemu_mutex_unlock(&monitor_lock);
=20
-    /* QEMUBHs needs to be deleted before destroying the I/O thread */
-    qemu_bh_delete(qmp_dispatcher_bh);
-    qmp_dispatcher_bh =3D NULL;
+    /*
+     * The dispatcher needs to stop before destroying the I/O thread.
+     *
+     * We need to poll both qemu_aio_context and iohandler_ctx to make
+     * sure that the dispatcher coroutine keeps making progress and
+     * eventually terminates.  qemu_aio_context is automatically
+     * polled by calling AIO_WAIT_WHILE on it, but we must poll
+     * iohandler_ctx manually.
+     */
+    qmp_dispatcher_co_shutdown =3D true;
+    if (!atomic_xchg(&qmp_dispatcher_co_busy, true)) {
+        aio_co_wake(qmp_dispatcher_co);
+    }
+
+    AIO_WAIT_WHILE(qemu_get_aio_context(),
+                   (aio_poll(iohandler_get_aio_context(), false),
+                    atomic_mb_read(&qmp_dispatcher_co_busy)));
+
     if (mon_iothread) {
         iothread_destroy(mon_iothread);
         mon_iothread =3D NULL;
@@ -604,9 +643,9 @@ void monitor_init_globals_core(void)
      * have commands assuming that context.  It would be nice to get
      * rid of those assumptions.
      */
-    qmp_dispatcher_bh =3D aio_bh_new(iohandler_get_aio_context(),
-                                   monitor_qmp_bh_dispatcher,
-                                   NULL);
+    qmp_dispatcher_co =3D qemu_coroutine_create(monitor_qmp_dispatcher_co,=
 NULL);
+    atomic_mb_set(&qmp_dispatcher_co_busy, true);
+    aio_co_schedule(iohandler_get_aio_context(), qmp_dispatcher_co);
 }
=20
 int monitor_init_opts(QemuOpts *opts, Error **errp)
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 8379c8f96e..d572d92e09 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -133,6 +133,10 @@ static void monitor_qmp_respond(MonitorQMP *mon, QDict=
 *rsp)
     }
 }
=20
+/*
+ * Runs outside of coroutine context for OOB commands, but in
+ * coroutine context for everything else.
+ */
 static void monitor_qmp_dispatch(MonitorQMP *mon, QObject *req)
 {
     Monitor *old_mon;
@@ -211,43 +215,99 @@ static QMPRequest *monitor_qmp_requests_pop_any_with_=
lock(void)
     return req_obj;
 }
=20
-void monitor_qmp_bh_dispatcher(void *data)
+void coroutine_fn monitor_qmp_dispatcher_co(void *data)
 {
-    QMPRequest *req_obj =3D monitor_qmp_requests_pop_any_with_lock();
+    QMPRequest *req_obj =3D NULL;
     QDict *rsp;
     bool need_resume;
     MonitorQMP *mon;
=20
-    if (!req_obj) {
-        return;
-    }
+    while (true) {
+        assert(atomic_mb_read(&qmp_dispatcher_co_busy) =3D=3D true);
=20
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
+        /*
+         * Mark the dispatcher as not busy already here so that we
+         * don't miss any new requests coming in the middle of our
+         * processing.
+         */
+        atomic_mb_set(&qmp_dispatcher_co_busy, false);
+
+        while (!(req_obj =3D monitor_qmp_requests_pop_any_with_lock())) {
+            /*
+             * No more requests to process.  Wait to be reentered from
+             * handle_qmp_command() when it pushes more requests, or
+             * from monitor_cleanup() when it requests shutdown.
+             */
+            if (!qmp_dispatcher_co_shutdown) {
+                qemu_coroutine_yield();
+
+                /*
+                 * busy must be set to true again by whoever
+                 * rescheduled us to avoid double scheduling
+                 */
+                assert(atomic_xchg(&qmp_dispatcher_co_busy, false) =3D=3D =
true);
+            }
+
+            /*
+             * qmp_dispatcher_co_shutdown may have changed if we
+             * yielded and were reentered from monitor_cleanup()
+             */
+            if (qmp_dispatcher_co_shutdown) {
+                return;
+            }
+        }
=20
-    if (need_resume) {
-        /* Pairs with the monitor_suspend() in handle_qmp_command() */
-        monitor_resume(&mon->common);
-    }
-    qmp_request_free(req_obj);
+        if (atomic_xchg(&qmp_dispatcher_co_busy, true) =3D=3D true) {
+            /*
+             * Someone rescheduled us (probably because a new requests
+             * came in), but we didn't actually yield. Do that now,
+             * only to be immediately reentered and removed from the
+             * list of scheduled coroutines.
+             */
+            qemu_coroutine_yield();
+        }
=20
-    /* Reschedule instead of looping so the main loop stays responsive */
-    qemu_bh_schedule(qmp_dispatcher_bh);
+        /*
+         * Move the coroutine from iohandler_ctx to qemu_aio_context for
+         * executing the command handler so that it can make progress if i=
t
+         * involves an AIO_WAIT_WHILE().
+         */
+        aio_co_schedule(qemu_get_aio_context(), qmp_dispatcher_co);
+        qemu_coroutine_yield();
+
+        mon =3D req_obj->mon;
+        /*  qmp_oob_enabled() might change after "qmp_capabilities" */
+        need_resume =3D !qmp_oob_enabled(mon) ||
+            mon->qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX - 1;
+        qemu_mutex_unlock(&mon->qmp_queue_lock);
+        if (req_obj->req) {
+            QDict *qdict =3D qobject_to(QDict, req_obj->req);
+            QObject *id =3D qdict ? qdict_get(qdict, "id") : NULL;
+            trace_monitor_qmp_cmd_in_band(qobject_get_try_str(id) ?: "");
+            monitor_qmp_dispatch(mon, req_obj->req);
+        } else {
+            assert(req_obj->err);
+            rsp =3D qmp_error_response(req_obj->err);
+            req_obj->err =3D NULL;
+            monitor_qmp_respond(mon, rsp);
+            qobject_unref(rsp);
+        }
+
+        if (need_resume) {
+            /* Pairs with the monitor_suspend() in handle_qmp_command() */
+            monitor_resume(&mon->common);
+        }
+        qmp_request_free(req_obj);
+
+        /*
+         * Yield and reschedule so the main loop stays responsive.
+         *
+         * Move back to iohandler_ctx so that nested event loops for
+         * qemu_aio_context don't start new monitor commands.
+         */
+        aio_co_schedule(iohandler_get_aio_context(), qmp_dispatcher_co);
+        qemu_coroutine_yield();
+    }
 }
=20
 static void handle_qmp_command(void *opaque, QObject *req, Error *err)
@@ -308,7 +368,9 @@ static void handle_qmp_command(void *opaque, QObject *r=
eq, Error *err)
     qemu_mutex_unlock(&mon->qmp_queue_lock);
=20
     /* Kick the dispatcher routine */
-    qemu_bh_schedule(qmp_dispatcher_bh);
+    if (!atomic_xchg(&qmp_dispatcher_co_busy, true)) {
+        aio_co_wake(qmp_dispatcher_co);
+    }
 }
=20
 static void monitor_qmp_read(void *opaque, const uint8_t *buf, int size)
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index bc264b3c9b..eef09d15bc 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -12,12 +12,16 @@
  */
=20
 #include "qemu/osdep.h"
+
+#include "block/aio.h"
 #include "qapi/error.h"
 #include "qapi/qmp/dispatch.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
 #include "sysemu/runstate.h"
 #include "qapi/qmp/qbool.h"
+#include "qemu/coroutine.h"
+#include "qemu/main-loop.h"
=20
 static QDict *qmp_dispatch_check_obj(const QObject *request, bool allow_oo=
b,
                                      Error **errp)
@@ -75,6 +79,25 @@ static QDict *qmp_dispatch_check_obj(const QObject *requ=
est, bool allow_oob,
     return dict;
 }
=20
+typedef struct QmpDispatchBH {
+    QmpCommand *cmd;
+    QDict *args;
+    QObject **ret;
+    Error **errp;
+    Coroutine *co;
+} QmpDispatchBH;
+
+static void do_qmp_dispatch_bh(void *opaque)
+{
+    QmpDispatchBH *data =3D opaque;
+    data->cmd->fn(data->args, data->ret, data->errp);
+    aio_co_wake(data->co);
+}
+
+/*
+ * Runs outside of coroutine context for OOB commands, but in coroutine co=
ntext
+ * for everything else.
+ */
 static QObject *do_qmp_dispatch(QmpCommandList *cmds, QObject *request,
                                 bool allow_oob, Error **errp)
 {
@@ -129,7 +152,22 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds, =
QObject *request,
         qobject_ref(args);
     }
=20
-    cmd->fn(args, &ret, &local_err);
+    assert(!(oob && qemu_in_coroutine()));
+    if ((cmd->options & QCO_COROUTINE) || !qemu_in_coroutine()) {
+        cmd->fn(args, &ret, &local_err);
+    } else {
+        /* Must drop out of coroutine context for this one */
+        QmpDispatchBH data =3D {
+            .cmd    =3D cmd,
+            .args   =3D args,
+            .ret    =3D &ret,
+            .errp   =3D &local_err,
+            .co     =3D qemu_coroutine_self(),
+        };
+        aio_bh_schedule_oneshot(qemu_get_aio_context(), do_qmp_dispatch_bh=
,
+                                &data);
+        qemu_coroutine_yield();
+    }
     if (local_err) {
         error_propagate(errp, local_err);
     } else if (cmd->options & QCO_NO_SUCCESS_RESP) {
@@ -164,6 +202,10 @@ bool qmp_is_oob(const QDict *dict)
         && !qdict_haskey(dict, "execute");
 }
=20
+/*
+ * Runs outside of coroutine context for OOB commands, but in coroutine co=
ntext
+ * for everything else.
+ */
 QDict *qmp_dispatch(QmpCommandList *cmds, QObject *request,
                     bool allow_oob)
 {
diff --git a/qapi/qmp-registry.c b/qapi/qmp-registry.c
index ca00f74795..1b5b9f1ccc 100644
--- a/qapi/qmp-registry.c
+++ b/qapi/qmp-registry.c
@@ -20,6 +20,9 @@ void qmp_register_command(QmpCommandList *cmds, const cha=
r *name,
 {
     QmpCommand *cmd =3D g_malloc0(sizeof(*cmd));
=20
+    /* QCO_COROUTINE and QCO_ALLOW_OOB are incompatible for now */
+    assert(!((options & QCO_COROUTINE) && (options & QCO_ALLOW_OOB)));
+
     cmd->name =3D name;
     cmd->fn =3D fn;
     cmd->enabled =3D true;
diff --git a/util/aio-posix.c b/util/aio-posix.c
index a4977f538e..223de08b91 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -15,6 +15,7 @@
=20
 #include "qemu/osdep.h"
 #include "block/block.h"
+#include "qemu/main-loop.h"
 #include "qemu/rcu_queue.h"
 #include "qemu/sockets.h"
 #include "qemu/cutils.h"
@@ -616,7 +617,11 @@ bool aio_poll(AioContext *ctx, bool blocking)
     int64_t timeout;
     int64_t start =3D 0;
=20
-    assert(in_aio_context_home_thread(ctx));
+    /* aio_poll() may only be called in the AioContext's thread. iohandler=
_ctx
+     * is special in that it runs in the main thread, but that thread's co=
ntext
+     * is qemu_aio_context. */
+    assert(in_aio_context_home_thread(ctx =3D=3D iohandler_get_aio_context=
() ?
+                                      qemu_get_aio_context() : ctx));
=20
     /* aio_notify can avoid the expensive event_notifier_set if
      * everything (file descriptors, bottom halves, timers) will
--=20
2.20.1


