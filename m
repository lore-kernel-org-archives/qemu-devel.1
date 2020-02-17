Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB29C761A4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 12:35:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 486C220718
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 12:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Up2chR9J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486C220718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3fcz-0000Yw-Fp
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 07:35:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j3fcB-0008Od-VR
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 07:35:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j3fc9-0000Nc-42
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 07:35:07 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22620
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j3fc8-0000NJ-Te
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 07:35:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581942904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qKcGIpSaq7f8NLbDK/uPJQtBW8BEpOhXxoln3hGk6bc=;
 b=Up2chR9JtUr0FXKXRhC5gbSnhES5TkLlT+SG2cd+f3NzDeOZJzzbEeJiPvmnzaExVc1TbS
 m12+KmQcsSpBKOJ41vjIBOkJpA2sLdPej/2umuNOIzp0A2VYL1Ht+5DpPXLfGd3/JPuc5B
 32ODQ998AlyF9f2lSfF3mhsQ1deenSc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-X9qZK6euMQ2Cj4IdOQ8xwA-1; Mon, 17 Feb 2020 07:35:01 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36566100550E;
 Mon, 17 Feb 2020 12:35:00 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-208.ams2.redhat.com [10.36.117.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D25A360BF1;
 Mon, 17 Feb 2020 12:34:55 +0000 (UTC)
Date: Mon, 17 Feb 2020 13:34:54 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v4 3/4] qmp: Move dispatcher to a coroutine
Message-ID: <20200217123454.GF6309@linux.fritz.box>
References: <20200121181122.15941-1-kwolf@redhat.com>
 <20200121181122.15941-4-kwolf@redhat.com>
 <87lfp1sc8d.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87lfp1sc8d.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: X9qZK6euMQ2Cj4IdOQ8xwA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

Am 17.02.2020 um 12:08 hat Markus Armbruster geschrieben:
> This is the hairy one.  Please bear with me while I try to grok it.
>=20
> Kevin Wolf <kwolf@redhat.com> writes:
>=20
> > This moves the QMP dispatcher to a coroutine and runs all QMP command
> > handlers that declare 'coroutine': true in coroutine context so they
> > can avoid blocking the main loop while doing I/O or waiting for other
> > events.
> >
> > For commands that are not declared safe to run in a coroutine, the
> > dispatcher drops out of coroutine context by calling the QMP command
> > handler from a bottom half.
> >
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  include/qapi/qmp/dispatch.h |   1 +
> >  monitor/monitor-internal.h  |   6 +-
> >  monitor/monitor.c           |  33 ++++++++---
> >  monitor/qmp.c               | 110 ++++++++++++++++++++++++++----------
> >  qapi/qmp-dispatch.c         |  44 ++++++++++++++-
> >  qapi/qmp-registry.c         |   3 +
> >  util/aio-posix.c            |   7 ++-
> >  7 files changed, 162 insertions(+), 42 deletions(-)
> >
> > diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
> > index d6ce9efc8e..6812e49b5f 100644
> > --- a/include/qapi/qmp/dispatch.h
> > +++ b/include/qapi/qmp/dispatch.h
> > @@ -30,6 +30,7 @@ typedef enum QmpCommandOptions
> >  typedef struct QmpCommand
> >  {
> >      const char *name;
> > +    /* Runs in coroutine context if QCO_COROUTINE is set */
> >      QmpCommandFunc *fn;
> >      QmpCommandOptions options;
> >      QTAILQ_ENTRY(QmpCommand) node;
> > diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> > index d78f5ca190..f180d03368 100644
> > --- a/monitor/monitor-internal.h
> > +++ b/monitor/monitor-internal.h
> > @@ -154,7 +154,9 @@ static inline bool monitor_is_qmp(const Monitor *mo=
n)
> > =20
> >  typedef QTAILQ_HEAD(MonitorList, Monitor) MonitorList;
> >  extern IOThread *mon_iothread;
> > -extern QEMUBH *qmp_dispatcher_bh;
> > +extern Coroutine *qmp_dispatcher_co;
> > +extern bool qmp_dispatcher_co_shutdown;
> > +extern bool qmp_dispatcher_co_busy;
> >  extern QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
> >  extern QemuMutex monitor_lock;
> >  extern MonitorList mon_list;
> > @@ -172,7 +174,7 @@ void monitor_fdsets_cleanup(void);
> > =20
> >  void qmp_send_response(MonitorQMP *mon, const QDict *rsp);
> >  void monitor_data_destroy_qmp(MonitorQMP *mon);
> > -void monitor_qmp_bh_dispatcher(void *data);
> > +void coroutine_fn monitor_qmp_dispatcher_co(void *data);
> > =20
> >  int get_monitor_def(int64_t *pval, const char *name);
> >  void help_cmd(Monitor *mon, const char *name);
> > diff --git a/monitor/monitor.c b/monitor/monitor.c
> > index 12898b6448..e753fa435d 100644
> > --- a/monitor/monitor.c
> > +++ b/monitor/monitor.c
> > @@ -53,8 +53,18 @@ typedef struct {
> >  /* Shared monitor I/O thread */
> >  IOThread *mon_iothread;
> > =20
> > -/* Bottom half to dispatch the requests received from I/O thread */
> > -QEMUBH *qmp_dispatcher_bh;
> > +/* Coroutine to dispatch the requests received from I/O thread */
> > +Coroutine *qmp_dispatcher_co;
> > +
> > +/* Set to true when the dispatcher coroutine should terminate */
> > +bool qmp_dispatcher_co_shutdown;
> > +
> > +/*
> > + * true if the coroutine is active and processing requests. The corout=
ine may
> > + * only be woken up externally (e.g. from the monitor thread) after ch=
anging
> > + * qmp_dispatcher_co_busy from false to true (e.g. using atomic_xchg).
> > + */
>=20
> I'm not sure what you mean by "externally".

By anyone outside the coroutine itself. Maybe just dropping the word
"externally" avoids the confusion because it's an implementation detail
that the coroutine can schedule itself while it is marked busy.

> Also mention how it changes from true to false?

Somethin like: "The coroutine will automatically change it back to false
after processing all pending requests"?

> Note to self: monitor_qmp_dispatcher_co() checks busy is true on resume.
>=20
> Nitpick: wrap around column 70, two spaces between sentences for
> consistency with other comments in this file, please.

Any specific reason why comments (but not code) in this file use a
different text width than everything else in QEMU? My editor is set to
use 80 characters to conform to CODING_STYLE.rst.

> > +bool qmp_dispatcher_co_busy;
> > =20
> >  /* Protects mon_list, monitor_qapi_event_state, monitor_destroyed.  */
> >  QemuMutex monitor_lock;
> > @@ -579,9 +589,16 @@ void monitor_cleanup(void)
>=20
> monitor_cleanup() runs in the main thread.
>=20
> Coroutine qmp_dispatcher_co also runs in the main thread, right?

Yes.

> >      }
> >      qemu_mutex_unlock(&monitor_lock);
> > =20
> > -    /* QEMUBHs needs to be deleted before destroying the I/O thread */
> > -    qemu_bh_delete(qmp_dispatcher_bh);
> > -    qmp_dispatcher_bh =3D NULL;
> > +    /* The dispatcher needs to stop before destroying the I/O thread *=
/
> > +    qmp_dispatcher_co_shutdown =3D true;
>=20
> The coroutine switch ensures qmp_dispatcher_co sees this write, so no
> need for a barrier.  Correct?

Both run in the same thread anyway, so barriers wouldn't make a
difference.

> > +    if (!atomic_xchg(&qmp_dispatcher_co_busy, true)) {
>=20
> Why do we need atomic?  I figure it's because qmp_dispatcher_co_busy is
> accessed from multiple threads (main thread and mon_iothread), unlike
> qmp_dispatcher_co_shutdown.

Yes, it's for synchronisation with the monitor thread. A coroutine may
not be scheduled twice at the same time. This is essentially all that
we're protecting against with qmp_dispatcher_co_busy. (See the
documentation for qmp_dispatcher_co_busy above.)

> What kind of atomic?  I'm asking because you use sequentially consistent
> atomic_xchg() together with the weaker atomic_mb_set() and
> atomic_mb_read().

atomic_mb_set/read() contain a barrier, which avoids reordering around
them. What makes them weaker than sequentially consistent atomic
operations is, quoting docs/devel/atomics.txt:

    However, and this is the important difference between
    atomic_mb_read/atomic_mb_set and sequential consistency, it is importan=
t
    for both threads to access the same volatile variable.  It is not the
    case that everything visible to thread A when it writes volatile field =
f
    becomes visible to thread B after it reads volatile field g. The store
    and load have to "match" (i.e., be performed on the same volatile
    field) to achieve the right semantics.

This condition is fulfilled, both threads communicate only through
qmp_dispatcher_co_busy.

> > +        aio_co_wake(qmp_dispatcher_co);
> > +    }
> > +
> > +    AIO_WAIT_WHILE(qemu_get_aio_context(),
> > +                   (aio_poll(iohandler_get_aio_context(), false),
> > +                    atomic_mb_read(&qmp_dispatcher_co_busy)));
>=20
> This waits for qmp_dispatcher_co_busy to become false again.  While
> waiting, pending AIO work is given a chance to progress, as long as it
> doesn't block.
>=20
> The only places that change qmp_dispatcher_co_busy to false (in
> monitor_qmp_dispatcher_co()) return without yielding when
> qmp_dispatcher_co_shutdown, terminating the coroutine.  Correct?

Correct.

> Ignorant question: what AIO work may be pending, and why do we want it
> to make progress?

This pending work specifically contains running the monitor dispatcher
coroutine. Without the aio_poll(), the coroutine code wouldn't get a
chance to run, so we would never complete.

Note that AIO_WAIT_WHILE() automatically polls the (main) AioContext of
the thread, but the main thread is irregular in that it has two
AioContexts. The monitor dispatcher happens to live in the iohandler
context, which is not polled by default, so we need to do that manually.

> I have to admit the I/O context magic is still voodoo to me.  Leaning
> opportunity, I guess :)
>=20
> Since v3, you switched from aio_bh_poll() to aio_poll().  Good:
> aio_poll() is intended for general use, while aio_bh_poll() is not.  But
> what happened to your "I would have called aio_poll(), but it's
> forbidden for iohandler_ctx"?  Oh, you've hidden an improvement to
> aio_poll() at the very end of this patch!
>=20
> You also wrote
>=20
>     Much of this complication comes from the fact that the monitor runs i=
n
>     iohandler_ctx, which is not the main AioContext of the main loop thre=
ad
>     (or any thread). This makes waiting for something in this AioContext
>     rather complicated because nothing wil poll that AioContext if I don'=
t
>     do it in the loop condition.
>=20
> Should we explain this complication in a comment somewhere?  Hmm, there
> is one further down:
>=20
>   +        /*
>   +         * Move the coroutine from iohandler_ctx to qemu_aio_context f=
or
>   +         * executing the command handler so that it can make progress =
if it
>   +         * involves an AIO_WAIT_WHILE().
>   +         */
>=20
> Assumes working knowledge of iohandler_ctx, which I don't quite have,
> yet.  I found this comment
>=20
>    /*
>     * Functions to operate on the I/O handler AioContext.
>     * This context runs on top of main loop. We can't reuse qemu_aio_cont=
ext
>     * because iohandlers mustn't be polled by aio_poll(qemu_aio_context).
>     */
>    static AioContext *iohandler_ctx;
>=20
> and docs/devel/multiple-iothreads.txt.  I guess I better study it.

I'm not sure myself how much of this is actually still true, but not
being an expert on iohandler_ctx myself, I decided to leave things in
the same AioContext where they were before this series.

> > +
> >      if (mon_iothread) {
> >          iothread_destroy(mon_iothread);
> >          mon_iothread =3D NULL;
> > @@ -604,9 +621,9 @@ void monitor_init_globals_core(void)
> >       * have commands assuming that context.  It would be nice to get
> >       * rid of those assumptions.
> >       */
> > -    qmp_dispatcher_bh =3D aio_bh_new(iohandler_get_aio_context(),
> > -                                   monitor_qmp_bh_dispatcher,
> > -                                   NULL);
> > +    qmp_dispatcher_co =3D qemu_coroutine_create(monitor_qmp_dispatcher=
_co, NULL);
> > +    atomic_mb_set(&qmp_dispatcher_co_busy, true);
> > +    aio_co_schedule(iohandler_get_aio_context(), qmp_dispatcher_co);
>=20
> In review of v3, you explained why you didn't use qemu_coroutine_enter()
> here, even though it's simpler:
>=20
>     Because the old code didn't run the BH right away. Should it? We're
>     pretty early in the initialisation of QEMU, but it should work as lon=
g
>     as we're allowed to call monitor_qmp_requests_pop_any_with_lock()
>     already.
>=20
> The old code creates, but does not schedule the bottom half here.  It
> gets scheduled only in handle_qmp_command().
>=20
> The new code appears to schedule the coroutine here.  I'm confused :)

What will happen here is essentially that we schedule a BH that enters
the coroutine. This runs the first part of monitor_qmp_dispatcher_co()
until it yields because there are no requests pending yet.

monitor_qmp_requests_pop_any_with_lock() is the only thing that is run
before handle_qmp_command() wakes up the coroutine (or monitor_cleanup
if we never get any request).

> Regarding calling monitor_qmp_requests_pop_any_with_lock(): it needs
> @monitor_lock and @mon_list to be valid.  We just initialized
> @monitor_lock, and @mon_list is empty.
> monitor_qmp_requests_pop_any_with_lock() should be safe and return null.
> monitor_qmp_dispatcher_co() should also be safe and yield without doing
> work.
>=20
> Can we exploit that to make things a bit simpler?  Separate patch would
> be fine with me.

If this is true, we could replace this line:

    aio_co_schedule(iohandler_get_aio_context(), qmp_dispatcher_co);

with the following one:

    qemu_aio_coroutine_enter(iohandler_get_aio_context(), qmp_dispatcher_co=
);

I'm not sure that this is any simpler.

> >  }
> > =20
> >  QemuOptsList qemu_mon_opts =3D {
> > diff --git a/monitor/qmp.c b/monitor/qmp.c
> > index 54c06ba824..9444de9fcf 100644
> > --- a/monitor/qmp.c
> > +++ b/monitor/qmp.c
> > @@ -133,6 +133,10 @@ static void monitor_qmp_respond(MonitorQMP *mon, Q=
Dict *rsp)
> >      }
> >  }
> > =20
> > +/*
> > + * Runs outside of coroutine context for OOB commands, but in coroutin=
e context
> > + * for everything else.
> > + */
>=20
> Nitpick: wrap around column 70, please.
>=20
> Note to self: the precondition is asserted in do_qmp_dispatch() below.
> Asserting here is impractical, because we don't know whether this is an
> OOB command.
>=20
> >  static void monitor_qmp_dispatch(MonitorQMP *mon, QObject *req)
> >  {
> >      Monitor *old_mon;
> > @@ -211,43 +215,87 @@ static QMPRequest *monitor_qmp_requests_pop_any_w=
ith_lock(void)
> >      return req_obj;
> >  }
> > =20
> > -void monitor_qmp_bh_dispatcher(void *data)
> > +void coroutine_fn monitor_qmp_dispatcher_co(void *data)
> >  {
> > -    QMPRequest *req_obj =3D monitor_qmp_requests_pop_any_with_lock();
> > +    QMPRequest *req_obj =3D NULL;
> >      QDict *rsp;
> >      bool need_resume;
> >      MonitorQMP *mon;
> > =20
> > -    if (!req_obj) {
> > -        return;
> > -    }
> > +    while (true) {
> > +        assert(atomic_mb_read(&qmp_dispatcher_co_busy) =3D=3D true);
>=20
> Read and assert, then ...
>=20
> > +
> > +        /* Mark the dispatcher as not busy already here so that we don=
't miss
> > +         * any new requests coming in the middle of our processing. */
> > +        atomic_mb_set(&qmp_dispatcher_co_busy, false);
>=20
> ... set.  Would exchange, then assert be cleaner?

Then you would ask me why the exchange has to be atomic. :-)

More practically, I would need a temporary variable so that I don't get
code with side effects in assert() (which may be compiled out with
NDEBUG). The temporary variable would never be read outside the assert
and would be unused with NDEBUG.

So possible, yes, cleaner I'm not sure.

> The assertion checks qmp_dispatcher_co_busy is set on coroutine enter.
> It pairs with the atomic_mb_set() in monitor_init_globals_core().
>=20
> Wing the comment, please, and wrap around column 70.  More of the same
> below.
>=20
> Hmm, qmp_dispatcher_co_busy is false while the coroutine busily runs.  I
> figure its actual purpose is something like "if false, you need to wake
> it up to ensure it processes additional requests".  Correct?

Yes. I understood "busy" in the sense of "executing a monitor command",
but of course the purpose of the variable is to know whether you need to
schedule the coroutine or whether you must not schedule it.

> > +
> > +        while (!(req_obj =3D monitor_qmp_requests_pop_any_with_lock())=
) {
> > +            /* Wait to be reentered from handle_qmp_command, or termin=
ate if
> > +             * qmp_dispatcher_co_shutdown is true*/
>=20
> Yes, these are the two places that wake this coroutine.
>=20
> Hmm, there's a third aio_co_wake() in do_qmp_dispatch_bh().  But that
> one resumes the yield in do_qmp_dispatch().  Correct?

Yes, do_qmp_dispatch_bh is scheduled immediately before yielding, so
that yield is where the coroutine will be resumed.

> Space before */, please.
>=20
> Would this
>=20
>                /*
>                 * No more requests to process.  Wait until
>                 * handle_qmp_command() pushes more, or monitor_cleanup()
>                 * requests shutdown.
>                 */
>=20
> be clearer?

I think I prefer explicitly mentioning that these callers not only push
requests or request shutdown, but that they actively cause this
coroutine to be reentered.

Matter of taste. You're the maintainer, so your taste wins.

> > +            if (!qmp_dispatcher_co_shutdown) {
> > +                qemu_coroutine_yield();
>=20
> Nothing to do, go to sleep.
>=20
> > +
> > +                /* busy must be set to true again by whoever reschedul=
ed us to
> > +                 * avoid double scheduling */
> > +                assert(atomic_xchg(&qmp_dispatcher_co_busy, false) =3D=
=3D true);
>=20
> The assertion checks the coroutine's resume set busy as it should.  It
> pairs with the atomic_xchg() in handle_qmp_command() and
> monitor_cleanup().

Correct.

> > +            }
> > +
> > +            /* qmp_dispatcher_co_shutdown may have changed if we yield=
ed and
> > +             * were reentered from monitor_cleanup() */
> > +            if (qmp_dispatcher_co_shutdown) {
> > +                return;
> > +            }
> > +        }
> > =20
>=20
> We got a request in @req.
>=20
> > -    mon =3D req_obj->mon;
> > -    /*  qmp_oob_enabled() might change after "qmp_capabilities" */
> > -    need_resume =3D !qmp_oob_enabled(mon) ||
> > -        mon->qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX - 1;
> > -    qemu_mutex_unlock(&mon->qmp_queue_lock);
> > -    if (req_obj->req) {
> > -        QDict *qdict =3D qobject_to(QDict, req_obj->req);
> > -        QObject *id =3D qdict ? qdict_get(qdict, "id") : NULL;
> > -        trace_monitor_qmp_cmd_in_band(qobject_get_try_str(id) ?: "");
> > -        monitor_qmp_dispatch(mon, req_obj->req);
> > -    } else {
> > -        assert(req_obj->err);
> > -        rsp =3D qmp_error_response(req_obj->err);
> > -        req_obj->err =3D NULL;
> > -        monitor_qmp_respond(mon, rsp);
> > -        qobject_unref(rsp);
> > -    }
> > +        if (atomic_xchg(&qmp_dispatcher_co_busy, true) =3D=3D true) {
> > +            /* Someone rescheduled us (probably because a new requests=
 came
> > +             * in), but we didn't actually yield. Do that now, only to=
 be
> > +             * immediately reentered and removed from the list of sche=
duled
> > +             * coroutines. */
> > +            qemu_coroutine_yield();
> > +        }
> > =20
> > -    if (need_resume) {
> > -        /* Pairs with the monitor_suspend() in handle_qmp_command() */
> > -        monitor_resume(&mon->common);
> > -    }
> > -    qmp_request_free(req_obj);
> > +        /*
> > +         * Move the coroutine from iohandler_ctx to qemu_aio_context f=
or
> > +         * executing the command handler so that it can make progress =
if it
> > +         * involves an AIO_WAIT_WHILE().
> > +         */
> > +        aio_co_schedule(qemu_get_aio_context(), qmp_dispatcher_co);
> > +        qemu_coroutine_yield();
> > +
> > +        mon =3D req_obj->mon;
> > +        /*  qmp_oob_enabled() might change after "qmp_capabilities" */
> > +        need_resume =3D !qmp_oob_enabled(mon) ||
> > +            mon->qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX - 1=
;
> > +        qemu_mutex_unlock(&mon->qmp_queue_lock);
> > +        if (req_obj->req) {
> > +            QDict *qdict =3D qobject_to(QDict, req_obj->req);
> > +            QObject *id =3D qdict ? qdict_get(qdict, "id") : NULL;
> > +            trace_monitor_qmp_cmd_in_band(qobject_get_try_str(id) ?: "=
");
> > +            monitor_qmp_dispatch(mon, req_obj->req);
> > +        } else {
> > +            assert(req_obj->err);
> > +            rsp =3D qmp_error_response(req_obj->err);
> > +            req_obj->err =3D NULL;
> > +            monitor_qmp_respond(mon, rsp);
> > +            qobject_unref(rsp);
> > +        }
> > +
> > +        if (need_resume) {
> > +            /* Pairs with the monitor_suspend() in handle_qmp_command(=
) */
> > +            monitor_resume(&mon->common);
> > +        }
> > +        qmp_request_free(req_obj);
> > =20
> > -    /* Reschedule instead of looping so the main loop stays responsive=
 */
> > -    qemu_bh_schedule(qmp_dispatcher_bh);
> > +        /*
> > +         * Yield and reschedule so the main loop stays responsive.
> > +         *
> > +         * Move back to iohandler_ctx so that nested event loops for
> > +         * qemu_aio_context don't start new monitor commands.
> > +         */
> > +        aio_co_schedule(iohandler_get_aio_context(), qmp_dispatcher_co=
);
> > +        qemu_coroutine_yield();
> > +    }
> >  }
> > =20
>=20
> Easier to review with diff -w:
>=20
>   +        if (atomic_xchg(&qmp_dispatcher_co_busy, true) =3D=3D true) {
>   +            /* Someone rescheduled us (probably because a new requests=
 came
>   +             * in), but we didn't actually yield. Do that now, only to=
 be
>   +             * immediately reentered and removed from the list of sche=
duled
>   +             * coroutines. */
>   +            qemu_coroutine_yield();
>   +        }
>=20
> This part I understand.
>=20
>   +
>   +        /*
>   +         * Move the coroutine from iohandler_ctx to qemu_aio_context f=
or
>   +         * executing the command handler so that it can make progress =
if it
>   +         * involves an AIO_WAIT_WHILE().
>   +         */
>   +        aio_co_schedule(qemu_get_aio_context(), qmp_dispatcher_co);
>   +        qemu_coroutine_yield();
>=20
> More I/O context voodoo.  I'll get there.
>=20
>            mon =3D req_obj->mon;
>            /*  qmp_oob_enabled() might change after "qmp_capabilities" */
>   @@ -246,8 +287,15 @@ void monitor_qmp_bh_dispatcher(void *data)
>            }
>            qmp_request_free(req_obj);
>=20
>   -    /* Reschedule instead of looping so the main loop stays responsive=
 */
>   -    qemu_bh_schedule(qmp_dispatcher_bh);
>   +        /*
>   +         * Yield and reschedule so the main loop stays responsive.
>   +         *
>   +         * Move back to iohandler_ctx so that nested event loops for
>   +         * qemu_aio_context don't start new monitor commands.
>=20
> Can you explain this sentence for dummies?

Nested event loops (i.e. AIO_WAIT_WHILE) poll qemu_aio_context, so if we
are scheduled there, the next iteration of the monitor dispatcher loop
could start from a nested event loop. If we are scheduled in
iohandler_ctx, then only the actual main loop will reenter the coroutine
and nested event loops ignore it.

I'm not sure if or why this is actually important, but this matches
scheduling the dispatcher BH in iohandler_ctx in the code before this
patch.

If we didn't do this, we could end up starting monitor requests in more
places than before, and who knows what that would mean.

>   +         */
>   +        aio_co_schedule(iohandler_get_aio_context(), qmp_dispatcher_co=
);
>   +        qemu_coroutine_yield();
>   +    }
>    }
>=20
> >  static void handle_qmp_command(void *opaque, QObject *req, Error *err)

Kevin


