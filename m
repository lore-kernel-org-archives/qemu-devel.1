Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B024C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 18:38:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8BB420678
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 18:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NOkNMwc8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8BB420678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipchQ-0000XA-NV
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 13:38:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50665)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ipcfC-0006Gh-P5
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 13:36:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ipcfA-00047j-S4
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 13:36:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46936
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ipcfA-00045R-NF
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 13:36:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578594968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KrGGGGshu3lrbvQADvv8kcIscup1g6d+xbagBet6GYE=;
 b=NOkNMwc8OBhv8vQALIxEoLJRMYxvOr2g4cke6np0YUTnY1dPbkFt317sM7GJgV9ujPKZMc
 dTGtbJ/mPzTlQAVZuypJnnz/LkR1ZRXnKP8GlFOujeIstsgpFsQms9PcpcrHN1rW4MAiR8
 t6ULxT+Ez5kb9b/vTfjg7GFFuwpcH30=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-7wNh3ophNc-ryghVCtcxtQ-1; Thu, 09 Jan 2020 13:36:05 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AFB618A6EC0;
 Thu,  9 Jan 2020 18:36:04 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-193.ams2.redhat.com
 [10.36.117.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA9EE86CC2;
 Thu,  9 Jan 2020 18:36:02 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] qmp: Move dispatcher to a coroutine
Date: Thu,  9 Jan 2020 19:35:45 +0100
Message-Id: <20200109183545.27452-5-kwolf@redhat.com>
In-Reply-To: <20200109183545.27452-1-kwolf@redhat.com>
References: <20200109183545.27452-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 7wNh3ophNc-ryghVCtcxtQ-1
X-Mimecast-Spam-Score: 0
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
 include/qapi/qmp/dispatch.h |  2 +
 monitor/monitor-internal.h  |  5 ++-
 monitor/monitor.c           | 24 +++++++----
 monitor/qmp.c               | 83 +++++++++++++++++++++++--------------
 qapi/qmp-dispatch.c         | 38 ++++++++++++++++-
 5 files changed, 111 insertions(+), 41 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index d6ce9efc8e..d6d5443391 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -30,6 +30,8 @@ typedef enum QmpCommandOptions
 typedef struct QmpCommand
 {
     const char *name;
+    /* Runs in coroutine context if QCO_COROUTINE is set, except for OOB
+     * commands */
     QmpCommandFunc *fn;
     QmpCommandOptions options;
     QTAILQ_ENTRY(QmpCommand) node;
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index d78f5ca190..7389b6a56c 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -154,7 +154,8 @@ static inline bool monitor_is_qmp(const Monitor *mon)
=20
 typedef QTAILQ_HEAD(MonitorList, Monitor) MonitorList;
 extern IOThread *mon_iothread;
-extern QEMUBH *qmp_dispatcher_bh;
+extern Coroutine *qmp_dispatcher_co;
+extern bool qmp_dispatcher_co_busy;
 extern QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
 extern QemuMutex monitor_lock;
 extern MonitorList mon_list;
@@ -172,7 +173,7 @@ void monitor_fdsets_cleanup(void);
=20
 void qmp_send_response(MonitorQMP *mon, const QDict *rsp);
 void monitor_data_destroy_qmp(MonitorQMP *mon);
-void monitor_qmp_bh_dispatcher(void *data);
+void coroutine_fn monitor_qmp_dispatcher_co(void *data);
=20
 int get_monitor_def(int64_t *pval, const char *name);
 void help_cmd(Monitor *mon, const char *name);
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 12898b6448..c72763fa4e 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -53,8 +53,9 @@ typedef struct {
 /* Shared monitor I/O thread */
 IOThread *mon_iothread;
=20
-/* Bottom half to dispatch the requests received from I/O thread */
-QEMUBH *qmp_dispatcher_bh;
+/* Coroutine to dispatch the requests received from I/O thread */
+Coroutine *qmp_dispatcher_co;
+bool qmp_dispatcher_co_busy;
=20
 /* Protects mon_list, monitor_qapi_event_state, monitor_destroyed.  */
 QemuMutex monitor_lock;
@@ -579,9 +580,16 @@ void monitor_cleanup(void)
     }
     qemu_mutex_unlock(&monitor_lock);
=20
-    /* QEMUBHs needs to be deleted before destroying the I/O thread */
-    qemu_bh_delete(qmp_dispatcher_bh);
-    qmp_dispatcher_bh =3D NULL;
+    /* The dispatcher needs to stop before destroying the I/O thread */
+    if (!atomic_mb_read(&qmp_dispatcher_co_busy)) {
+        aio_co_schedule(iohandler_get_aio_context(), qmp_dispatcher_co);
+        qmp_dispatcher_co =3D NULL;
+    }
+
+    AIO_WAIT_WHILE(qemu_get_aio_context(),
+                   (aio_bh_poll(iohandler_get_aio_context()),
+                    atomic_mb_read(&qmp_dispatcher_co_busy)));
+
     if (mon_iothread) {
         iothread_destroy(mon_iothread);
         mon_iothread =3D NULL;
@@ -604,9 +612,9 @@ void monitor_init_globals_core(void)
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
 QemuOptsList qemu_mon_opts =3D {
diff --git a/monitor/qmp.c b/monitor/qmp.c
index b67a8e7d1f..9fd66c7b97 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -133,6 +133,8 @@ static void monitor_qmp_respond(MonitorQMP *mon, QDict =
*rsp)
     }
 }
=20
+/* Runs outside of coroutine context for OOB commands, but in coroutine co=
ntext
+ * for everything else. */
 static void monitor_qmp_dispatch(MonitorQMP *mon, QObject *req)
 {
     Monitor *old_mon;
@@ -211,43 +213,62 @@ static QMPRequest *monitor_qmp_requests_pop_any_with_=
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
+
+        while (!(req_obj =3D monitor_qmp_requests_pop_any_with_lock())) {
+            /* Wait to be reentered from handle_qmp_command, or terminate =
if
+             * qmp_dispatcher_co has been reset to NULL */
+            atomic_mb_set(&qmp_dispatcher_co_busy, false);
+            if (qmp_dispatcher_co) {
+                qemu_coroutine_yield();
+            }
+            /* qmp_dispatcher_co may have changed if we yielded and were
+             * reentered from monitor_cleanup() */
+            if (!qmp_dispatcher_co) {
+                return;
+            }
+            atomic_mb_set(&qmp_dispatcher_co_busy, true);
+        }
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
=20
-    if (need_resume) {
-        /* Pairs with the monitor_suspend() in handle_qmp_command() */
-        monitor_resume(&mon->common);
-    }
-    qmp_request_free(req_obj);
+        if (need_resume) {
+            /* Pairs with the monitor_suspend() in handle_qmp_command() */
+            monitor_resume(&mon->common);
+        }
+        qmp_request_free(req_obj);
=20
-    /* Reschedule instead of looping so the main loop stays responsive */
-    qemu_bh_schedule(qmp_dispatcher_bh);
+        /* Reschedule instead of looping so the main loop stays responsive=
 */
+        aio_co_schedule(iohandler_get_aio_context(), qmp_dispatcher_co);
+        qemu_coroutine_yield();
+    }
 }
=20
 static void handle_qmp_command(void *opaque, QObject *req, Error *err)
@@ -308,7 +329,9 @@ static void handle_qmp_command(void *opaque, QObject *r=
eq, Error *err)
     qemu_mutex_unlock(&mon->qmp_queue_lock);
=20
     /* Kick the dispatcher routine */
-    qemu_bh_schedule(qmp_dispatcher_bh);
+    if (!atomic_mb_read(&qmp_dispatcher_co_busy)) {
+        aio_co_wake(qmp_dispatcher_co);
+    }
 }
=20
 static void monitor_qmp_read(void *opaque, const uint8_t *buf, int size)
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index bc264b3c9b..6ccf19f2a2 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -12,6 +12,8 @@
  */
=20
 #include "qemu/osdep.h"
+
+#include "monitor/monitor-internal.h"
 #include "qapi/error.h"
 #include "qapi/qmp/dispatch.h"
 #include "qapi/qmp/qdict.h"
@@ -75,6 +77,23 @@ static QDict *qmp_dispatch_check_obj(const QObject *requ=
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
+/* Runs outside of coroutine context for OOB commands, but in coroutine co=
ntext
+ * for everything else. */
 static QObject *do_qmp_dispatch(QmpCommandList *cmds, QObject *request,
                                 bool allow_oob, Error **errp)
 {
@@ -129,7 +148,22 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds, =
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
@@ -164,6 +198,8 @@ bool qmp_is_oob(const QDict *dict)
         && !qdict_haskey(dict, "execute");
 }
=20
+/* Runs outside of coroutine context for OOB commands, but in coroutine co=
ntext
+ * for everything else. */
 QDict *qmp_dispatch(QmpCommandList *cmds, QObject *request,
                     bool allow_oob)
 {
--=20
2.20.1


