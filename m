Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F71C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 12:07:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 745C0206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 12:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LOYpTdB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 745C0206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igpAJ-0004tE-CZ
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 07:07:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1igp9g-0004S0-Pe
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 07:07:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1igp9c-0004Ph-Qn
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 07:07:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60813
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1igp9c-0004P0-5d
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 07:07:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576498031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IETWJ56Z9divsVJOVnTcfbolwQxqJyyNM0F+guuiPNU=;
 b=LOYpTdB3b/QOmsRy3LidsaathOFJ4F+40mHjdxBYob/0ZLYxyFeWh5Yn941XtSRH8qGfPS
 ZPTko4s85j2YYBiTKE6k2udLzRGT8xjCUFtrnXy0u2MUGZxjZTTihY0bWW7hO73UaYBcWL
 TUDwTwautG2HfjNM8R1E7JKSwTbFpHk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-FZDCTJe0MWCGBYh9w4v6Jg-1; Mon, 16 Dec 2019 07:07:07 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AE431800D7B;
 Mon, 16 Dec 2019 12:07:06 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-54.ams2.redhat.com [10.36.117.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BE56691AD;
 Mon, 16 Dec 2019 12:07:03 +0000 (UTC)
Date: Mon, 16 Dec 2019 13:07:01 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH v6 00/25] monitor: add asynchronous command type
Message-ID: <20191216120701.GC6610@linux.fritz.box>
References: <20191108150123.12213-1-marcandre.lureau@redhat.com>
 <20191213160330.GD3428@localhost.localdomain>
 <CAJ+F1CLSfYPFPych4twnvOMt3qR4UnGauWq_k=VN8W5kKUze9g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLSfYPFPych4twnvOMt3qR4UnGauWq_k=VN8W5kKUze9g@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: FZDCTJe0MWCGBYh9w4v6Jg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 13.12.2019 um 17:28 hat Marc-Andr=E9 Lureau geschrieben:
> On Fri, Dec 13, 2019 at 8:04 PM Kevin Wolf <kwolf@redhat.com> wrote:
> >
> > Am 08.11.2019 um 16:00 hat Marc-Andr=E9 Lureau geschrieben:
> > > The following series implements an internal async command solution
> > > instead. By introducing a session context and a command return
> > > handler, QMP handlers can:
> > > - defer the return, allowing the mainloop to reenter
> > > - return only to the caller (instead of the broadcast event reply)
> > > - optionnally allow cancellation when the client is gone
> > > - track on-going qapi command(s) per session
> >
> > This requires major changes to existing QMP command handlers. Did you
> > consider at least optionally providing a way where instead of using the
> > new async_fn, QMP already creates a coroutine in which the handler is
> > executed?
>=20
> Yes, but I don't see how this could be done without the basic callback
> infrastructure I propose here. Also forcing existing code to be
> translated to coroutine-aware is probably even more complicated.

I'll attach what I hacked up last week after discussing a problem with
Markus and Max. As you probably expected, screendump isn't really my
main motivation to look into this. The specific command we discussed was
block_resize, which can potentially block the monitor for a while, but
I'm sure that many more block commands have the same problem.

What my patch does is moving everything into a coroutine. This is wrong
because not everything can be run in a coroutine, so it needs to be made
optional (like you did with your async flag).

The problem isn't with completely coroutine-unaware code, though: That
one would just work, even if not taking advantage from the coroutine. A
potential problem exists with code that behaves differently when run in
a coroutine or outside of coroutine context (generally by checking
qemu_in_coroutine())), or calls of coroutine-unaware code into such
functions.

Running some command handlers outside of coroutine context wouldn't be
hard to add to my patch (basically just a BH), but I haven't looked into
the QAPI side of making it an option.

> > At least for some of the block layer commands, we could simply enable
> > this without changing any of the code and would automatically get rid o=
f
> > blocking the guest while the command is doing I/O. If we need to
> > implement .async_fn, in contrast, it would be quite a bit of boiler
> > plate code for each single handler to create a coroutine for the real
> > handler and to wrap all parameters in a struct.
>=20
> We could have the generator do that for you eventually, and spawn the
> coroutine.

Yes, if we need both, that's an option. I'd like to explore first if the
callback-based approach is actually needed, though.

> > > The screendump command is converted to an async:true version to solve
> > > rhbz#1230527. The command shows basic cancellation (this could be
> > > extended if needed). It could be further improved to do asynchronous
> > > IO writes as well.
> >
> > After converting it to QIOChannel like you already do, I/O would
> > automatically become asynchronous when run in a coroutine.
> >
> > If you don't want this yet, but only fix the BZ, I guess you could dela=
y
> > that patch until later and just have a single yield and reenter of the
> > command handler coroutine like this:
> >
> >     co =3D qemu_coroutine_self();
> >     aio_co_schedule(qemu_coroutine_get_aio_context(co), co);
> >     qemu_coroutine_yield();

(This specific code is wrong, I misread your patches. You don't want to
immediately reenter the coroutine, but only in graphic_hw_update_done().)

> If various places of code start doing that, we are in trouble, the
> stack may grow, cancellation becomes hairy.

I don't understand. How does the coroutine-based approach differ from
what your series does? Basically, instead of splitting qmp_screendump()
in two parts, you keep the existing single function, just with a
qemu_coroutine_yield() in the middle, and instead of calling
qmp_screendump_finish() you wake up the coroutine.

Yes, instead of malloc'ing a struct qmp_screendump, you would keep
things on the stack, but that doesn't make the stack grow as these
things are already on the stack in qmp_screendump().

> Furthermore, in the case of screendump, IO is not necessarily within
> the coroutine context. In this case, we need to wait for the QXL
> device to "flush" the screen. Communicating this event back to the
> coroutine isn't simpler than what I propose here.

Waiting for something in a coroutine means calling
qemu_coroutine_yield() and then letting the event handler call
aio_co_wake() to resume the coroutine. It's really simple. I'm pretty
sure that if qmp_screendump() is called in a coroutine, your I/O would
automatically end up in the coroutine context unless you do something
specifically to avoid it.

Kevin


From 8d4b8ba34d33d3bbf3f0a21703928eb68895e169 Mon Sep 17 00:00:00 2001
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 12 Dec 2019 16:32:27 +0100
Subject: [PATCH] qmp: Move dispatcher to a coroutine

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/qapi/qmp/dispatch.h |  2 +
 monitor/monitor-internal.h  |  5 ++-
 monitor/monitor.c           | 24 +++++++----
 monitor/qmp.c               | 80 +++++++++++++++++++++++--------------
 qapi/qmp-dispatch.c         |  4 ++
 5 files changed, 75 insertions(+), 40 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 9aa426a398..4088255463 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -29,6 +29,8 @@ typedef enum QmpCommandOptions
 typedef struct QmpCommand
 {
     const char *name;
+    /* Runs outside of coroutine context for OOB commands, but in coroutin=
e context
+     * for everything else. */
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
index 12898b6448..8f90d0b46c 100644
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
+                   aio_bh_poll(iohandler_get_aio_context()) ||
+                   atomic_mb_read(&qmp_dispatcher_co_busy));
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
index b67a8e7d1f..f5dc77cd0a 100644
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
@@ -211,43 +213,59 @@ static QMPRequest *monitor_qmp_requests_pop_any_with_=
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
+            } else {
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
@@ -308,7 +326,9 @@ static void handle_qmp_command(void *opaque, QObject *r=
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
index bc264b3c9b..1dbc152307 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -75,6 +75,8 @@ static QDict *qmp_dispatch_check_obj(const QObject *reque=
st, bool allow_oob,
     return dict;
 }
=20
+/* Runs outside of coroutine context for OOB commands, but in coroutine co=
ntext
+ * for everything else. */
 static QObject *do_qmp_dispatch(QmpCommandList *cmds, QObject *request,
                                 bool allow_oob, Error **errp)
 {
@@ -164,6 +166,8 @@ bool qmp_is_oob(const QDict *dict)
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


