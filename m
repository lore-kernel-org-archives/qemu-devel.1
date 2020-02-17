Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D4CC35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:09:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B49FE207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UsCITwRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B49FE207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3eGq-0005k1-Tm
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 06:09:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j3eG7-0004p6-0H
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:08:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j3eG4-0001EV-EO
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:08:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36497
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j3eG4-0001Cw-92
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:08:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581937691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bP9VOSDzLRXatzYNvqROQAnMmKeGHpfcsF0l1VTy2Vg=;
 b=UsCITwRgYbwlRO3jxh4zIYCYssos+YzzCLAp59LkeFlnZg6XynIvoqvr7DTRu0guImgex7
 EDQer4ym6SKo353daQy2Sfvc4QNO9PdQyi8GNHzPMyeqIUBU71ypOUbqKiWs382tciDSc4
 c8mk742M6hyAjdB1GPai+d0ObPRjZJo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-9rYpHzUtNC6svqYZVgyUCQ-1; Mon, 17 Feb 2020 06:08:08 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03C658017DF;
 Mon, 17 Feb 2020 11:08:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E437B5C112;
 Mon, 17 Feb 2020 11:08:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6890E11385C9; Mon, 17 Feb 2020 12:08:02 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v4 3/4] qmp: Move dispatcher to a coroutine
References: <20200121181122.15941-1-kwolf@redhat.com>
 <20200121181122.15941-4-kwolf@redhat.com>
Date: Mon, 17 Feb 2020 12:08:02 +0100
In-Reply-To: <20200121181122.15941-4-kwolf@redhat.com> (Kevin Wolf's message
 of "Tue, 21 Jan 2020 19:11:21 +0100")
Message-ID: <87lfp1sc8d.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 9rYpHzUtNC6svqYZVgyUCQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: stefanha@redhat.com, marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the hairy one.  Please bear with me while I try to grok it.

Kevin Wolf <kwolf@redhat.com> writes:

> This moves the QMP dispatcher to a coroutine and runs all QMP command
> handlers that declare 'coroutine': true in coroutine context so they
> can avoid blocking the main loop while doing I/O or waiting for other
> events.
>
> For commands that are not declared safe to run in a coroutine, the
> dispatcher drops out of coroutine context by calling the QMP command
> handler from a bottom half.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/qapi/qmp/dispatch.h |   1 +
>  monitor/monitor-internal.h  |   6 +-
>  monitor/monitor.c           |  33 ++++++++---
>  monitor/qmp.c               | 110 ++++++++++++++++++++++++++----------
>  qapi/qmp-dispatch.c         |  44 ++++++++++++++-
>  qapi/qmp-registry.c         |   3 +
>  util/aio-posix.c            |   7 ++-
>  7 files changed, 162 insertions(+), 42 deletions(-)
>
> diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
> index d6ce9efc8e..6812e49b5f 100644
> --- a/include/qapi/qmp/dispatch.h
> +++ b/include/qapi/qmp/dispatch.h
> @@ -30,6 +30,7 @@ typedef enum QmpCommandOptions
>  typedef struct QmpCommand
>  {
>      const char *name;
> +    /* Runs in coroutine context if QCO_COROUTINE is set */
>      QmpCommandFunc *fn;
>      QmpCommandOptions options;
>      QTAILQ_ENTRY(QmpCommand) node;
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index d78f5ca190..f180d03368 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -154,7 +154,9 @@ static inline bool monitor_is_qmp(const Monitor *mon)
> =20
>  typedef QTAILQ_HEAD(MonitorList, Monitor) MonitorList;
>  extern IOThread *mon_iothread;
> -extern QEMUBH *qmp_dispatcher_bh;
> +extern Coroutine *qmp_dispatcher_co;
> +extern bool qmp_dispatcher_co_shutdown;
> +extern bool qmp_dispatcher_co_busy;
>  extern QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
>  extern QemuMutex monitor_lock;
>  extern MonitorList mon_list;
> @@ -172,7 +174,7 @@ void monitor_fdsets_cleanup(void);
> =20
>  void qmp_send_response(MonitorQMP *mon, const QDict *rsp);
>  void monitor_data_destroy_qmp(MonitorQMP *mon);
> -void monitor_qmp_bh_dispatcher(void *data);
> +void coroutine_fn monitor_qmp_dispatcher_co(void *data);
> =20
>  int get_monitor_def(int64_t *pval, const char *name);
>  void help_cmd(Monitor *mon, const char *name);
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 12898b6448..e753fa435d 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -53,8 +53,18 @@ typedef struct {
>  /* Shared monitor I/O thread */
>  IOThread *mon_iothread;
> =20
> -/* Bottom half to dispatch the requests received from I/O thread */
> -QEMUBH *qmp_dispatcher_bh;
> +/* Coroutine to dispatch the requests received from I/O thread */
> +Coroutine *qmp_dispatcher_co;
> +
> +/* Set to true when the dispatcher coroutine should terminate */
> +bool qmp_dispatcher_co_shutdown;
> +
> +/*
> + * true if the coroutine is active and processing requests. The coroutin=
e may
> + * only be woken up externally (e.g. from the monitor thread) after chan=
ging
> + * qmp_dispatcher_co_busy from false to true (e.g. using atomic_xchg).
> + */

I'm not sure what you mean by "externally".

Also mention how it changes from true to false?

Note to self: monitor_qmp_dispatcher_co() checks busy is true on resume.

Nitpick: wrap around column 70, two spaces between sentences for
consistency with other comments in this file, please.

> +bool qmp_dispatcher_co_busy;
> =20
>  /* Protects mon_list, monitor_qapi_event_state, monitor_destroyed.  */
>  QemuMutex monitor_lock;
> @@ -579,9 +589,16 @@ void monitor_cleanup(void)

monitor_cleanup() runs in the main thread.

Coroutine qmp_dispatcher_co also runs in the main thread, right?

>      }
>      qemu_mutex_unlock(&monitor_lock);
> =20
> -    /* QEMUBHs needs to be deleted before destroying the I/O thread */
> -    qemu_bh_delete(qmp_dispatcher_bh);
> -    qmp_dispatcher_bh =3D NULL;
> +    /* The dispatcher needs to stop before destroying the I/O thread */
> +    qmp_dispatcher_co_shutdown =3D true;

The coroutine switch ensures qmp_dispatcher_co sees this write, so no
need for a barrier.  Correct?

> +    if (!atomic_xchg(&qmp_dispatcher_co_busy, true)) {

Why do we need atomic?  I figure it's because qmp_dispatcher_co_busy is
accessed from multiple threads (main thread and mon_iothread), unlike
qmp_dispatcher_co_shutdown.

What kind of atomic?  I'm asking because you use sequentially consistent
atomic_xchg() together with the weaker atomic_mb_set() and
atomic_mb_read().

> +        aio_co_wake(qmp_dispatcher_co);
> +    }
> +
> +    AIO_WAIT_WHILE(qemu_get_aio_context(),
> +                   (aio_poll(iohandler_get_aio_context(), false),
> +                    atomic_mb_read(&qmp_dispatcher_co_busy)));

This waits for qmp_dispatcher_co_busy to become false again.  While
waiting, pending AIO work is given a chance to progress, as long as it
doesn't block.

The only places that change qmp_dispatcher_co_busy to false (in
monitor_qmp_dispatcher_co()) return without yielding when
qmp_dispatcher_co_shutdown, terminating the coroutine.  Correct?

Ignorant question: what AIO work may be pending, and why do we want it
to make progress?

I have to admit the I/O context magic is still voodoo to me.  Leaning
opportunity, I guess :)

Since v3, you switched from aio_bh_poll() to aio_poll().  Good:
aio_poll() is intended for general use, while aio_bh_poll() is not.  But
what happened to your "I would have called aio_poll(), but it's
forbidden for iohandler_ctx"?  Oh, you've hidden an improvement to
aio_poll() at the very end of this patch!

You also wrote

    Much of this complication comes from the fact that the monitor runs in
    iohandler_ctx, which is not the main AioContext of the main loop thread
    (or any thread). This makes waiting for something in this AioContext
    rather complicated because nothing wil poll that AioContext if I don't
    do it in the loop condition.

Should we explain this complication in a comment somewhere?  Hmm, there
is one further down:

  +        /*
  +         * Move the coroutine from iohandler_ctx to qemu_aio_context for
  +         * executing the command handler so that it can make progress if=
 it
  +         * involves an AIO_WAIT_WHILE().
  +         */

Assumes working knowledge of iohandler_ctx, which I don't quite have,
yet.  I found this comment

   /*
    * Functions to operate on the I/O handler AioContext.
    * This context runs on top of main loop. We can't reuse qemu_aio_contex=
t
    * because iohandlers mustn't be polled by aio_poll(qemu_aio_context).
    */
   static AioContext *iohandler_ctx;

and docs/devel/multiple-iothreads.txt.  I guess I better study it.

> +
>      if (mon_iothread) {
>          iothread_destroy(mon_iothread);
>          mon_iothread =3D NULL;
> @@ -604,9 +621,9 @@ void monitor_init_globals_core(void)
>       * have commands assuming that context.  It would be nice to get
>       * rid of those assumptions.
>       */
> -    qmp_dispatcher_bh =3D aio_bh_new(iohandler_get_aio_context(),
> -                                   monitor_qmp_bh_dispatcher,
> -                                   NULL);
> +    qmp_dispatcher_co =3D qemu_coroutine_create(monitor_qmp_dispatcher_c=
o, NULL);
> +    atomic_mb_set(&qmp_dispatcher_co_busy, true);
> +    aio_co_schedule(iohandler_get_aio_context(), qmp_dispatcher_co);

In review of v3, you explained why you didn't use qemu_coroutine_enter()
here, even though it's simpler:

    Because the old code didn't run the BH right away. Should it? We're
    pretty early in the initialisation of QEMU, but it should work as long
    as we're allowed to call monitor_qmp_requests_pop_any_with_lock()
    already.

The old code creates, but does not schedule the bottom half here.  It
gets scheduled only in handle_qmp_command().

The new code appears to schedule the coroutine here.  I'm confused :)

Regarding calling monitor_qmp_requests_pop_any_with_lock(): it needs
@monitor_lock and @mon_list to be valid.  We just initialized
@monitor_lock, and @mon_list is empty.
monitor_qmp_requests_pop_any_with_lock() should be safe and return null.
monitor_qmp_dispatcher_co() should also be safe and yield without doing
work.

Can we exploit that to make things a bit simpler?  Separate patch would
be fine with me.

>  }
> =20
>  QemuOptsList qemu_mon_opts =3D {
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index 54c06ba824..9444de9fcf 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -133,6 +133,10 @@ static void monitor_qmp_respond(MonitorQMP *mon, QDi=
ct *rsp)
>      }
>  }
> =20
> +/*
> + * Runs outside of coroutine context for OOB commands, but in coroutine =
context
> + * for everything else.
> + */

Nitpick: wrap around column 70, please.

Note to self: the precondition is asserted in do_qmp_dispatch() below.
Asserting here is impractical, because we don't know whether this is an
OOB command.

>  static void monitor_qmp_dispatch(MonitorQMP *mon, QObject *req)
>  {
>      Monitor *old_mon;
> @@ -211,43 +215,87 @@ static QMPRequest *monitor_qmp_requests_pop_any_wit=
h_lock(void)
>      return req_obj;
>  }
> =20
> -void monitor_qmp_bh_dispatcher(void *data)
> +void coroutine_fn monitor_qmp_dispatcher_co(void *data)
>  {
> -    QMPRequest *req_obj =3D monitor_qmp_requests_pop_any_with_lock();
> +    QMPRequest *req_obj =3D NULL;
>      QDict *rsp;
>      bool need_resume;
>      MonitorQMP *mon;
> =20
> -    if (!req_obj) {
> -        return;
> -    }
> +    while (true) {
> +        assert(atomic_mb_read(&qmp_dispatcher_co_busy) =3D=3D true);

Read and assert, then ...

> +
> +        /* Mark the dispatcher as not busy already here so that we don't=
 miss
> +         * any new requests coming in the middle of our processing. */
> +        atomic_mb_set(&qmp_dispatcher_co_busy, false);

... set.  Would exchange, then assert be cleaner?

The assertion checks qmp_dispatcher_co_busy is set on coroutine enter.
It pairs with the atomic_mb_set() in monitor_init_globals_core().

Wing the comment, please, and wrap around column 70.  More of the same
below.

Hmm, qmp_dispatcher_co_busy is false while the coroutine busily runs.  I
figure its actual purpose is something like "if false, you need to wake
it up to ensure it processes additional requests".  Correct?

> +
> +        while (!(req_obj =3D monitor_qmp_requests_pop_any_with_lock())) =
{
> +            /* Wait to be reentered from handle_qmp_command, or terminat=
e if
> +             * qmp_dispatcher_co_shutdown is true*/

Yes, these are the two places that wake this coroutine.

Hmm, there's a third aio_co_wake() in do_qmp_dispatch_bh().  But that
one resumes the yield in do_qmp_dispatch().  Correct?

Space before */, please.

Would this

               /*
                * No more requests to process.  Wait until
                * handle_qmp_command() pushes more, or monitor_cleanup()
                * requests shutdown.
                */

be clearer?

> +            if (!qmp_dispatcher_co_shutdown) {
> +                qemu_coroutine_yield();

Nothing to do, go to sleep.

> +
> +                /* busy must be set to true again by whoever rescheduled=
 us to
> +                 * avoid double scheduling */
> +                assert(atomic_xchg(&qmp_dispatcher_co_busy, false) =3D=
=3D true);

The assertion checks the coroutine's resume set busy as it should.  It
pairs with the atomic_xchg() in handle_qmp_command() and
monitor_cleanup().

> +            }
> +
> +            /* qmp_dispatcher_co_shutdown may have changed if we yielded=
 and
> +             * were reentered from monitor_cleanup() */
> +            if (qmp_dispatcher_co_shutdown) {
> +                return;
> +            }
> +        }
> =20

We got a request in @req.

> -    mon =3D req_obj->mon;
> -    /*  qmp_oob_enabled() might change after "qmp_capabilities" */
> -    need_resume =3D !qmp_oob_enabled(mon) ||
> -        mon->qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX - 1;
> -    qemu_mutex_unlock(&mon->qmp_queue_lock);
> -    if (req_obj->req) {
> -        QDict *qdict =3D qobject_to(QDict, req_obj->req);
> -        QObject *id =3D qdict ? qdict_get(qdict, "id") : NULL;
> -        trace_monitor_qmp_cmd_in_band(qobject_get_try_str(id) ?: "");
> -        monitor_qmp_dispatch(mon, req_obj->req);
> -    } else {
> -        assert(req_obj->err);
> -        rsp =3D qmp_error_response(req_obj->err);
> -        req_obj->err =3D NULL;
> -        monitor_qmp_respond(mon, rsp);
> -        qobject_unref(rsp);
> -    }
> +        if (atomic_xchg(&qmp_dispatcher_co_busy, true) =3D=3D true) {
> +            /* Someone rescheduled us (probably because a new requests c=
ame
> +             * in), but we didn't actually yield. Do that now, only to b=
e
> +             * immediately reentered and removed from the list of schedu=
led
> +             * coroutines. */
> +            qemu_coroutine_yield();
> +        }
> =20
> -    if (need_resume) {
> -        /* Pairs with the monitor_suspend() in handle_qmp_command() */
> -        monitor_resume(&mon->common);
> -    }
> -    qmp_request_free(req_obj);
> +        /*
> +         * Move the coroutine from iohandler_ctx to qemu_aio_context for
> +         * executing the command handler so that it can make progress if=
 it
> +         * involves an AIO_WAIT_WHILE().
> +         */
> +        aio_co_schedule(qemu_get_aio_context(), qmp_dispatcher_co);
> +        qemu_coroutine_yield();
> +
> +        mon =3D req_obj->mon;
> +        /*  qmp_oob_enabled() might change after "qmp_capabilities" */
> +        need_resume =3D !qmp_oob_enabled(mon) ||
> +            mon->qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX - 1;
> +        qemu_mutex_unlock(&mon->qmp_queue_lock);
> +        if (req_obj->req) {
> +            QDict *qdict =3D qobject_to(QDict, req_obj->req);
> +            QObject *id =3D qdict ? qdict_get(qdict, "id") : NULL;
> +            trace_monitor_qmp_cmd_in_band(qobject_get_try_str(id) ?: "")=
;
> +            monitor_qmp_dispatch(mon, req_obj->req);
> +        } else {
> +            assert(req_obj->err);
> +            rsp =3D qmp_error_response(req_obj->err);
> +            req_obj->err =3D NULL;
> +            monitor_qmp_respond(mon, rsp);
> +            qobject_unref(rsp);
> +        }
> +
> +        if (need_resume) {
> +            /* Pairs with the monitor_suspend() in handle_qmp_command() =
*/
> +            monitor_resume(&mon->common);
> +        }
> +        qmp_request_free(req_obj);
> =20
> -    /* Reschedule instead of looping so the main loop stays responsive *=
/
> -    qemu_bh_schedule(qmp_dispatcher_bh);
> +        /*
> +         * Yield and reschedule so the main loop stays responsive.
> +         *
> +         * Move back to iohandler_ctx so that nested event loops for
> +         * qemu_aio_context don't start new monitor commands.
> +         */
> +        aio_co_schedule(iohandler_get_aio_context(), qmp_dispatcher_co);
> +        qemu_coroutine_yield();
> +    }
>  }
> =20

Easier to review with diff -w:

  +        if (atomic_xchg(&qmp_dispatcher_co_busy, true) =3D=3D true) {
  +            /* Someone rescheduled us (probably because a new requests c=
ame
  +             * in), but we didn't actually yield. Do that now, only to b=
e
  +             * immediately reentered and removed from the list of schedu=
led
  +             * coroutines. */
  +            qemu_coroutine_yield();
  +        }

This part I understand.

  +
  +        /*
  +         * Move the coroutine from iohandler_ctx to qemu_aio_context for
  +         * executing the command handler so that it can make progress if=
 it
  +         * involves an AIO_WAIT_WHILE().
  +         */
  +        aio_co_schedule(qemu_get_aio_context(), qmp_dispatcher_co);
  +        qemu_coroutine_yield();

More I/O context voodoo.  I'll get there.

           mon =3D req_obj->mon;
           /*  qmp_oob_enabled() might change after "qmp_capabilities" */
  @@ -246,8 +287,15 @@ void monitor_qmp_bh_dispatcher(void *data)
           }
           qmp_request_free(req_obj);

  -    /* Reschedule instead of looping so the main loop stays responsive *=
/
  -    qemu_bh_schedule(qmp_dispatcher_bh);
  +        /*
  +         * Yield and reschedule so the main loop stays responsive.
  +         *
  +         * Move back to iohandler_ctx so that nested event loops for
  +         * qemu_aio_context don't start new monitor commands.

Can you explain this sentence for dummies?

  +         */
  +        aio_co_schedule(iohandler_get_aio_context(), qmp_dispatcher_co);
  +        qemu_coroutine_yield();
  +    }
   }

>  static void handle_qmp_command(void *opaque, QObject *req, Error *err)
> @@ -308,7 +356,9 @@ static void handle_qmp_command(void *opaque, QObject =
*req, Error *err)
>      qemu_mutex_unlock(&mon->qmp_queue_lock);
> =20
>      /* Kick the dispatcher routine */
> -    qemu_bh_schedule(qmp_dispatcher_bh);
> +    if (!atomic_xchg(&qmp_dispatcher_co_busy, true)) {
> +        aio_co_wake(qmp_dispatcher_co);
> +    }
>  }
> =20
>  static void monitor_qmp_read(void *opaque, const uint8_t *buf, int size)
> diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
> index bc264b3c9b..eef09d15bc 100644
> --- a/qapi/qmp-dispatch.c
> +++ b/qapi/qmp-dispatch.c
> @@ -12,12 +12,16 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +
> +#include "block/aio.h"
>  #include "qapi/error.h"
>  #include "qapi/qmp/dispatch.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qjson.h"
>  #include "sysemu/runstate.h"
>  #include "qapi/qmp/qbool.h"
> +#include "qemu/coroutine.h"
> +#include "qemu/main-loop.h"
> =20
>  static QDict *qmp_dispatch_check_obj(const QObject *request, bool allow_=
oob,
>                                       Error **errp)
> @@ -75,6 +79,25 @@ static QDict *qmp_dispatch_check_obj(const QObject *re=
quest, bool allow_oob,
>      return dict;
>  }
> =20
> +typedef struct QmpDispatchBH {
> +    QmpCommand *cmd;
> +    QDict *args;
> +    QObject **ret;
> +    Error **errp;
> +    Coroutine *co;
> +} QmpDispatchBH;
> +
> +static void do_qmp_dispatch_bh(void *opaque)
> +{
> +    QmpDispatchBH *data =3D opaque;
> +    data->cmd->fn(data->args, data->ret, data->errp);
> +    aio_co_wake(data->co);
> +}
> +
> +/*
> + * Runs outside of coroutine context for OOB commands, but in coroutine =
context
> + * for everything else.
> + */
>  static QObject *do_qmp_dispatch(QmpCommandList *cmds, QObject *request,
>                                  bool allow_oob, Error **errp)
>  {
> @@ -129,7 +152,22 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds=
, QObject *request,
>          qobject_ref(args);
>      }
> =20
> -    cmd->fn(args, &ret, &local_err);
> +    assert(!(oob && qemu_in_coroutine()));
> +    if ((cmd->options & QCO_COROUTINE) || !qemu_in_coroutine()) {
> +        cmd->fn(args, &ret, &local_err);
> +    } else {
> +        /* Must drop out of coroutine context for this one */
> +        QmpDispatchBH data =3D {
> +            .cmd    =3D cmd,
> +            .args   =3D args,
> +            .ret    =3D &ret,
> +            .errp   =3D &local_err,
> +            .co     =3D qemu_coroutine_self(),
> +        };
> +        aio_bh_schedule_oneshot(qemu_get_aio_context(), do_qmp_dispatch_=
bh,
> +                                &data);
> +        qemu_coroutine_yield();
> +    }
>      if (local_err) {
>          error_propagate(errp, local_err);
>      } else if (cmd->options & QCO_NO_SUCCESS_RESP) {
> @@ -164,6 +202,10 @@ bool qmp_is_oob(const QDict *dict)
>          && !qdict_haskey(dict, "execute");
>  }
> =20
> +/*
> + * Runs outside of coroutine context for OOB commands, but in coroutine =
context
> + * for everything else.
> + */
>  QDict *qmp_dispatch(QmpCommandList *cmds, QObject *request,
>                      bool allow_oob)
>  {
> diff --git a/qapi/qmp-registry.c b/qapi/qmp-registry.c
> index ca00f74795..3d896aedd8 100644
> --- a/qapi/qmp-registry.c
> +++ b/qapi/qmp-registry.c
> @@ -20,6 +20,9 @@ void qmp_register_command(QmpCommandList *cmds, const c=
har *name,
>  {
>      QmpCommand *cmd =3D g_malloc0(sizeof(*cmd));
> =20
> +    /* QCO_COROUTINE and QCO_ALLOW_OOB are incompatible */

Only because we don't implement coroutine context for exec-oob, for want
of a use case.  See also my review of PATCH 01.  No need to spell this
out every time, but I think spelling it out at least once wouldn't hurt.

> +    assert(!((options & QCO_COROUTINE) && (options & QCO_ALLOW_OOB)));
> +
>      cmd->name =3D name;
>      cmd->fn =3D fn;
>      cmd->enabled =3D true;
> diff --git a/util/aio-posix.c b/util/aio-posix.c
> index a4977f538e..223de08b91 100644
> --- a/util/aio-posix.c
> +++ b/util/aio-posix.c
> @@ -15,6 +15,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include "block/block.h"
> +#include "qemu/main-loop.h"
>  #include "qemu/rcu_queue.h"
>  #include "qemu/sockets.h"
>  #include "qemu/cutils.h"
> @@ -616,7 +617,11 @@ bool aio_poll(AioContext *ctx, bool blocking)
>      int64_t timeout;
>      int64_t start =3D 0;
> =20
> -    assert(in_aio_context_home_thread(ctx));
> +    /* aio_poll() may only be called in the AioContext's thread. iohandl=
er_ctx
> +     * is special in that it runs in the main thread, but that thread's =
context
> +     * is qemu_aio_context. */
> +    assert(in_aio_context_home_thread(ctx =3D=3D iohandler_get_aio_conte=
xt() ?
> +                                      qemu_get_aio_context() : ctx));
> =20
>      /* aio_notify can avoid the expensive event_notifier_set if
>       * everything (file descriptors, bottom halves, timers) will

This is the aio_poll() improvement.


I very much appreciate the effort you put into making this easier to
understand and maintain.  Thank you!


