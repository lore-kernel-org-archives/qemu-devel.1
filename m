Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B870CC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:15:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 261ED20757
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mi50zUKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 261ED20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG1p9-0007Dx-4V
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 11:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kG1ls-0001lf-I0
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 11:12:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48927
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kG1ll-0003p8-PV
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 11:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599664341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q1vpMQqLgqTZe8O+N86RN1Ridb8ccaWzg8zgL9u8DKk=;
 b=Mi50zUKDCm/wkKonVl6Geuwo3jNSlzoRVJBl2mK0HfqnZLePOb8Z2GTvq11ZM765FaP6LU
 UPbg2eDLET8uCuoCWV27wSoJeSPR7ybl0LqlQjOEzPe5KGhlNWzukJcaTHdghtwsEPrbJ9
 7TIbjzKeirFnXIR59Hk8YfeP0lCoogc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-Qb2S7zMUO8ONgeMfKD2zvQ-1; Wed, 09 Sep 2020 11:12:19 -0400
X-MC-Unique: Qb2S7zMUO8ONgeMfKD2zvQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7C2E1005E5C;
 Wed,  9 Sep 2020 15:12:17 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-221.ams2.redhat.com
 [10.36.113.221])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C3FF60C07;
 Wed,  9 Sep 2020 15:12:13 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 09/13] qmp: Move dispatcher to a coroutine
Date: Wed,  9 Sep 2020 17:11:45 +0200
Message-Id: <20200909151149.490589-10-kwolf@redhat.com>
In-Reply-To: <20200909151149.490589-1-kwolf@redhat.com>
References: <20200909151149.490589-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:05:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 marcandre.lureau@gmail.com, stefanha@redhat.com, dgilbert@redhat.com
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
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/dispatch.h |   1 +
 monitor/monitor-internal.h  |   6 +-
 monitor/monitor.c           |  55 +++++++++++++---
 monitor/qmp.c               | 122 +++++++++++++++++++++++++++---------
 qapi/qmp-dispatch.c         |  61 ++++++++++++++++--
 qapi/qmp-registry.c         |   3 +
 util/aio-posix.c            |   8 ++-
 7 files changed, 210 insertions(+), 46 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 9fd2b720a7..af8d96c570 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -31,6 +31,7 @@ typedef enum QmpCommandOptions
 typedef struct QmpCommand
 {
     const char *name;
+    /* Runs in coroutine context if QCO_COROUTINE is set */
     QmpCommandFunc *fn;
     QmpCommandOptions options;
     QTAILQ_ENTRY(QmpCommand) node;
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index b39e03b744..b55d6df07f 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -155,7 +155,9 @@ static inline bool monitor_is_qmp(const Monitor *mon)
 
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
 
 void qmp_send_response(MonitorQMP *mon, const QDict *rsp);
 void monitor_data_destroy_qmp(MonitorQMP *mon);
-void monitor_qmp_bh_dispatcher(void *data);
+void coroutine_fn monitor_qmp_dispatcher_co(void *data);
 
 int get_monitor_def(int64_t *pval, const char *name);
 void help_cmd(Monitor *mon, const char *name);
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 629aa073ee..ac2722bf91 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -55,8 +55,32 @@ typedef struct {
 /* Shared monitor I/O thread */
 IOThread *mon_iothread;
 
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
+ * Additional requests may then be pushed onto mon->qmp_requests,
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
 
 /*
  * Protects mon_list, monitor_qapi_event_state, coroutine_mon,
@@ -623,9 +647,24 @@ void monitor_cleanup(void)
     }
     qemu_mutex_unlock(&monitor_lock);
 
-    /* QEMUBHs needs to be deleted before destroying the I/O thread */
-    qemu_bh_delete(qmp_dispatcher_bh);
-    qmp_dispatcher_bh = NULL;
+    /*
+     * The dispatcher needs to stop before destroying the I/O thread.
+     *
+     * We need to poll both qemu_aio_context and iohandler_ctx to make
+     * sure that the dispatcher coroutine keeps making progress and
+     * eventually terminates.  qemu_aio_context is automatically
+     * polled by calling AIO_WAIT_WHILE on it, but we must poll
+     * iohandler_ctx manually.
+     */
+    qmp_dispatcher_co_shutdown = true;
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
         mon_iothread = NULL;
@@ -649,9 +688,9 @@ void monitor_init_globals_core(void)
      * have commands assuming that context.  It would be nice to get
      * rid of those assumptions.
      */
-    qmp_dispatcher_bh = aio_bh_new(iohandler_get_aio_context(),
-                                   monitor_qmp_bh_dispatcher,
-                                   NULL);
+    qmp_dispatcher_co = qemu_coroutine_create(monitor_qmp_dispatcher_co, NULL);
+    atomic_mb_set(&qmp_dispatcher_co_busy, true);
+    aio_co_schedule(iohandler_get_aio_context(), qmp_dispatcher_co);
 }
 
 int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp)
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 922fdb5541..69f6e93f38 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -133,6 +133,10 @@ static void monitor_qmp_respond(MonitorQMP *mon, QDict *rsp)
     }
 }
 
+/*
+ * Runs outside of coroutine context for OOB commands, but in
+ * coroutine context for everything else.
+ */
 static void monitor_qmp_dispatch(MonitorQMP *mon, QObject *req)
 {
     QDict *rsp;
@@ -205,43 +209,99 @@ static QMPRequest *monitor_qmp_requests_pop_any_with_lock(void)
     return req_obj;
 }
 
-void monitor_qmp_bh_dispatcher(void *data)
+void coroutine_fn monitor_qmp_dispatcher_co(void *data)
 {
-    QMPRequest *req_obj = monitor_qmp_requests_pop_any_with_lock();
+    QMPRequest *req_obj = NULL;
     QDict *rsp;
     bool need_resume;
     MonitorQMP *mon;
 
-    if (!req_obj) {
-        return;
-    }
+    while (true) {
+        assert(atomic_mb_read(&qmp_dispatcher_co_busy) == true);
 
-    mon = req_obj->mon;
-    /*  qmp_oob_enabled() might change after "qmp_capabilities" */
-    need_resume = !qmp_oob_enabled(mon) ||
-        mon->qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX - 1;
-    qemu_mutex_unlock(&mon->qmp_queue_lock);
-    if (req_obj->req) {
-        QDict *qdict = qobject_to(QDict, req_obj->req);
-        QObject *id = qdict ? qdict_get(qdict, "id") : NULL;
-        trace_monitor_qmp_cmd_in_band(qobject_get_try_str(id) ?: "");
-        monitor_qmp_dispatch(mon, req_obj->req);
-    } else {
-        assert(req_obj->err);
-        rsp = qmp_error_response(req_obj->err);
-        req_obj->err = NULL;
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
+        while (!(req_obj = monitor_qmp_requests_pop_any_with_lock())) {
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
+                assert(atomic_xchg(&qmp_dispatcher_co_busy, false) == true);
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
 
-    if (need_resume) {
-        /* Pairs with the monitor_suspend() in handle_qmp_command() */
-        monitor_resume(&mon->common);
-    }
-    qmp_request_free(req_obj);
+        if (atomic_xchg(&qmp_dispatcher_co_busy, true) == true) {
+            /*
+             * Someone rescheduled us (probably because a new requests
+             * came in), but we didn't actually yield. Do that now,
+             * only to be immediately reentered and removed from the
+             * list of scheduled coroutines.
+             */
+            qemu_coroutine_yield();
+        }
 
-    /* Reschedule instead of looping so the main loop stays responsive */
-    qemu_bh_schedule(qmp_dispatcher_bh);
+        /*
+         * Move the coroutine from iohandler_ctx to qemu_aio_context for
+         * executing the command handler so that it can make progress if it
+         * involves an AIO_WAIT_WHILE().
+         */
+        aio_co_schedule(qemu_get_aio_context(), qmp_dispatcher_co);
+        qemu_coroutine_yield();
+
+        mon = req_obj->mon;
+        /* qmp_oob_enabled() might change after "qmp_capabilities" */
+        need_resume = !qmp_oob_enabled(mon) ||
+            mon->qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX - 1;
+        qemu_mutex_unlock(&mon->qmp_queue_lock);
+        if (req_obj->req) {
+            QDict *qdict = qobject_to(QDict, req_obj->req);
+            QObject *id = qdict ? qdict_get(qdict, "id") : NULL;
+            trace_monitor_qmp_cmd_in_band(qobject_get_try_str(id) ?: "");
+            monitor_qmp_dispatch(mon, req_obj->req);
+        } else {
+            assert(req_obj->err);
+            rsp = qmp_error_response(req_obj->err);
+            req_obj->err = NULL;
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
 
 static void handle_qmp_command(void *opaque, QObject *req, Error *err)
@@ -302,7 +362,9 @@ static void handle_qmp_command(void *opaque, QObject *req, Error *err)
     qemu_mutex_unlock(&mon->qmp_queue_lock);
 
     /* Kick the dispatcher routine */
-    qemu_bh_schedule(qmp_dispatcher_bh);
+    if (!atomic_xchg(&qmp_dispatcher_co_busy, true)) {
+        aio_co_wake(qmp_dispatcher_co);
+    }
 }
 
 static void monitor_qmp_read(void *opaque, const uint8_t *buf, int size)
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 5677ba92ca..754f7b854c 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -12,12 +12,16 @@
  */
 
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
 
 static QDict *qmp_dispatch_check_obj(QDict *dict, bool allow_oob,
                                      Error **errp)
@@ -88,6 +92,30 @@ bool qmp_is_oob(const QDict *dict)
         && !qdict_haskey(dict, "execute");
 }
 
+typedef struct QmpDispatchBH {
+    const QmpCommand *cmd;
+    Monitor *cur_mon;
+    QDict *args;
+    QObject **ret;
+    Error **errp;
+    Coroutine *co;
+} QmpDispatchBH;
+
+static void do_qmp_dispatch_bh(void *opaque)
+{
+    QmpDispatchBH *data = opaque;
+
+    assert(monitor_cur() == NULL);
+    monitor_set_cur(qemu_coroutine_self(), data->cur_mon);
+    data->cmd->fn(data->args, data->ret, data->errp);
+    monitor_set_cur(qemu_coroutine_self(), NULL);
+    aio_co_wake(data->co);
+}
+
+/*
+ * Runs outside of coroutine context for OOB commands, but in coroutine
+ * context for everything else.
+ */
 QDict *qmp_dispatch(const QmpCommandList *cmds, QObject *request,
                     bool allow_oob, Monitor *cur_mon)
 {
@@ -153,12 +181,35 @@ QDict *qmp_dispatch(const QmpCommandList *cmds, QObject *request,
         qobject_ref(args);
     }
 
+    assert(!(oob && qemu_in_coroutine()));
     assert(monitor_cur() == NULL);
-    monitor_set_cur(qemu_coroutine_self(), cur_mon);
-
-    cmd->fn(args, &ret, &err);
-
-    monitor_set_cur(qemu_coroutine_self(), NULL);
+    if (!!(cmd->options & QCO_COROUTINE) == qemu_in_coroutine()) {
+        monitor_set_cur(qemu_coroutine_self(), cur_mon);
+        cmd->fn(args, &ret, &err);
+        monitor_set_cur(qemu_coroutine_self(), NULL);
+    } else {
+        /*
+         * Not being in coroutine context implies that we're handling
+         * an OOB command, which must not have QCO_COROUTINE.
+         *
+         * This implies that we are in coroutine context, but the
+         * command doesn't have QCO_COROUTINE. We must drop out of
+         * coroutine context for this one.
+         */
+        assert(!oob && qemu_in_coroutine() && !(cmd->options & QCO_COROUTINE));
+
+        QmpDispatchBH data = {
+            .cur_mon    = cur_mon,
+            .cmd        = cmd,
+            .args       = args,
+            .ret        = &ret,
+            .errp       = &err,
+            .co         = qemu_coroutine_self(),
+        };
+        aio_bh_schedule_oneshot(qemu_get_aio_context(), do_qmp_dispatch_bh,
+                                &data);
+        qemu_coroutine_yield();
+    }
     qobject_unref(args);
     if (err) {
         /* or assert(!ret) after reviewing all handlers: */
diff --git a/qapi/qmp-registry.c b/qapi/qmp-registry.c
index d0f9a1d3e3..58c65b5052 100644
--- a/qapi/qmp-registry.c
+++ b/qapi/qmp-registry.c
@@ -20,6 +20,9 @@ void qmp_register_command(QmpCommandList *cmds, const char *name,
 {
     QmpCommand *cmd = g_malloc0(sizeof(*cmd));
 
+    /* QCO_COROUTINE and QCO_ALLOW_OOB are incompatible for now */
+    assert(!((options & QCO_COROUTINE) && (options & QCO_ALLOW_OOB)));
+
     cmd->name = name;
     cmd->fn = fn;
     cmd->enabled = true;
diff --git a/util/aio-posix.c b/util/aio-posix.c
index f7f13ebfc2..30bb21d699 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -15,6 +15,7 @@
 
 #include "qemu/osdep.h"
 #include "block/block.h"
+#include "qemu/main-loop.h"
 #include "qemu/rcu.h"
 #include "qemu/rcu_queue.h"
 #include "qemu/sockets.h"
@@ -558,8 +559,13 @@ bool aio_poll(AioContext *ctx, bool blocking)
      * There cannot be two concurrent aio_poll calls for the same AioContext (or
      * an aio_poll concurrent with a GSource prepare/check/dispatch callback).
      * We rely on this below to avoid slow locked accesses to ctx->notify_me.
+     *
+     * aio_poll() may only be called in the AioContext's thread. iohandler_ctx
+     * is special in that it runs in the main thread, but that thread's context
+     * is qemu_aio_context.
      */
-    assert(in_aio_context_home_thread(ctx));
+    assert(in_aio_context_home_thread(ctx == iohandler_get_aio_context() ?
+                                      qemu_get_aio_context() : ctx));
 
     qemu_lockcnt_inc(&ctx->list_lock);
 
-- 
2.25.4


