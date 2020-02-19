Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00DAC34022
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 09:04:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BB3A2464E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 09:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+uyY8U5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB3A2464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4LHn-0001Ln-Ma
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 04:04:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j4LGw-0000uH-Dd
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 04:04:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j4LGu-00041r-14
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 04:03:58 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26953
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j4LGt-00041h-TG
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 04:03:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582103035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h94enNz7TKmW4rzNoCBXZQM3gcKGlJjJTKt9ZzCTQH8=;
 b=F+uyY8U5+SXYBu7ET7EcT2gCvZp5NDLYkO5sj73EwpgG5P7WCMRsLPhKGyxWkcw6NODiFj
 RC0sgA5yqeYIoulDFRvpLGfkZw38hV3K7vstFjaL9DHNxJZppEDxYIjvDFYCOjKr1kw4zM
 aSg1/0JjCrsiQnOxzWbA2LUObvQ8pkc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-RmlCTU7uOUGa6GLcJ-9eDw-1; Wed, 19 Feb 2020 04:03:51 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68F80189F760;
 Wed, 19 Feb 2020 09:03:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 39B2C1001920;
 Wed, 19 Feb 2020 09:03:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AA34711385C9; Wed, 19 Feb 2020 10:03:45 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v4 3/4] qmp: Move dispatcher to a coroutine
References: <20200121181122.15941-1-kwolf@redhat.com>
 <20200121181122.15941-4-kwolf@redhat.com>
 <87lfp1sc8d.fsf@dusky.pond.sub.org>
 <20200217123454.GF6309@linux.fritz.box>
 <87r1ysc7d4.fsf@dusky.pond.sub.org>
 <20200218152931.GG6157@linux.fritz.box>
Date: Wed, 19 Feb 2020 10:03:45 +0100
In-Reply-To: <20200218152931.GG6157@linux.fritz.box> (Kevin Wolf's message of
 "Tue, 18 Feb 2020 16:29:31 +0100")
Message-ID: <87tv3nt0cu.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: RmlCTU7uOUGa6GLcJ-9eDw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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

Kevin Wolf <kwolf@redhat.com> writes:

> Am 18.02.2020 um 15:12 hat Markus Armbruster geschrieben:
>> >> Regarding calling monitor_qmp_requests_pop_any_with_lock(): it needs
>> >> @monitor_lock and @mon_list to be valid.  We just initialized
>> >> @monitor_lock, and @mon_list is empty.
>> >> monitor_qmp_requests_pop_any_with_lock() should be safe and return nu=
ll.
>> >> monitor_qmp_dispatcher_co() should also be safe and yield without doi=
ng
>> >> work.
>> >>=20
>> >> Can we exploit that to make things a bit simpler?  Separate patch wou=
ld
>> >> be fine with me.
>> >
>> > If this is true, we could replace this line:
>> >
>> >     aio_co_schedule(iohandler_get_aio_context(), qmp_dispatcher_co);
>> >
>> > with the following one:
>> >
>> >     qemu_aio_coroutine_enter(iohandler_get_aio_context(), qmp_dispatch=
er_co);
>> >
>> > I'm not sure that this is any simpler.
>>=20
>> Naive question: what's the difference between "scheduling", "entering",
>> and "waking up" a coroutine?
>>=20
>> qemu_coroutine_enter() and qemu_aio_coroutine_enter() are in
>> coroutine.h.
>
> These are the low-level functions that just enter the coroutine (i.e. do
> a stack switch and jump to coroutine code) immediately when they are
> called. They must be called in the right thread with the right
> AioContext locks held. (What "right" means depends on the code run in
> the coroutine.)

I see; low level building blocks.

>> aio_co_schedule(), aio_co_wake() and aio_co_enter() are in aio.h.
>
> aio_co_schedule() never enters the coroutine directly. It only adds it
> to the list of scheduled coroutines and schedules a BH in the target
> AioContext. This BH in turn will actually enter the coroutine.

Makes sense.

> aio_co_enter() enters the coroutine immediately if it's being called
> outside of coroutine context and in the right thread for the given
> AioContext. If it's in the right thread, but in coroutine context then
> it will queue the given coroutine so that it runs whenever the current
> coroutine yields. If it's in the wrong thread, it uses aio_co_schedule()
> to get it run in the right thread.

Uff, sounds complicated.  Lots of magic.

> aio_co_wake() takes just the coroutine as a parameter and calls
> aio_co_enter() with the context in which the coroutine was last run.

Complicated by extension.

> All of these functions make sure that the AioContext lock is taken when
> the coroutine is entered and that they run in the right thread.
>
>> qemu_coroutine_enter() calls qemu_aio_coroutine_enter().
>>=20
>> aio_co_wake() calls aio_co_enter() calls qemu_aio_coroutine_enter().
>>=20
>> aio_co_enter() seems to be independent.
>
> It's not. It calls either aio_co_schedule() or
> qemu_aio_coroutine_enter(), or inserts the coroutine ina queue that is
> processed in qemu_aio_coroutine_enter().

I was blind.

>> aio.h seems to be layered on top of coroutine.h.  Should I prefer using
>> aio.h to coroutine.h?
>
> In the common case, using the aio.h functions is preferable because they
> just do "the right thing" without requiring as much thinking as the
> low-level functions.

Got it.

>> >> >  }
>> >> > =20
>> >> >  QemuOptsList qemu_mon_opts =3D {
>> >> > diff --git a/monitor/qmp.c b/monitor/qmp.c
>> >> > index 54c06ba824..9444de9fcf 100644
>> >> > --- a/monitor/qmp.c
>> >> > +++ b/monitor/qmp.c
>> >> > @@ -133,6 +133,10 @@ static void monitor_qmp_respond(MonitorQMP *mo=
n, QDict *rsp)
>> >> >      }
>> >> >  }
>> >> > =20
>> >> > +/*
>> >> > + * Runs outside of coroutine context for OOB commands, but in coro=
utine context
>> >> > + * for everything else.
>> >> > + */
>> >>=20
>> >> Nitpick: wrap around column 70, please.
>> >>=20
>> >> Note to self: the precondition is asserted in do_qmp_dispatch() below=
.
>> >> Asserting here is impractical, because we don't know whether this is =
an
>> >> OOB command.
>> >>=20
>> >> >  static void monitor_qmp_dispatch(MonitorQMP *mon, QObject *req)
>> >> >  {
>> >> >      Monitor *old_mon;
>> >> > @@ -211,43 +215,87 @@ static QMPRequest *monitor_qmp_requests_pop_a=
ny_with_lock(void)
>> >> >      return req_obj;
>> >> >  }
>> >> > =20
>> >> > -void monitor_qmp_bh_dispatcher(void *data)
>> >> > +void coroutine_fn monitor_qmp_dispatcher_co(void *data)
>> >> >  {
>> >> > -    QMPRequest *req_obj =3D monitor_qmp_requests_pop_any_with_lock=
();
>> >> > +    QMPRequest *req_obj =3D NULL;
>> >> >      QDict *rsp;
>> >> >      bool need_resume;
>> >> >      MonitorQMP *mon;
>> >> > =20
>> >> > -    if (!req_obj) {
>> >> > -        return;
>> >> > -    }
>> >> > +    while (true) {
>> >> > +        assert(atomic_mb_read(&qmp_dispatcher_co_busy) =3D=3D true=
);
>> >>=20
>> >> Read and assert, then ...
>> >>=20
>> >> > +
>> >> > +        /* Mark the dispatcher as not busy already here so that we=
 don't miss
>> >> > +         * any new requests coming in the middle of our processing=
. */
>> >> > +        atomic_mb_set(&qmp_dispatcher_co_busy, false);
>> >>=20
>> >> ... set.  Would exchange, then assert be cleaner?
>> >
>> > Then you would ask me why the exchange has to be atomic. :-)
>>=20
>> Possibly :)
>>=20
>> > More practically, I would need a temporary variable so that I don't ge=
t
>> > code with side effects in assert() (which may be compiled out with
>> > NDEBUG). The temporary variable would never be read outside the assert
>> > and would be unused with NDEBUG.
>> >
>> > So possible, yes, cleaner I'm not sure.
>>=20
>> I asked because the patch made me wonder whether qmp_dispatcher_co could
>> change between the read and the set.
>
> Ah. No, this function is the only one that does a transition from true
> to false. Everyone else only transitions from false to true (or leaves
> the value unchanged as true).

True, but it's non-local argument.  Anyway, not a big deal.

>> >>   @@ -246,8 +287,15 @@ void monitor_qmp_bh_dispatcher(void *data)
>> >>            }
>> >>            qmp_request_free(req_obj);
>> >>=20
>> >>   -    /* Reschedule instead of looping so the main loop stays respon=
sive */
>> >>   -    qemu_bh_schedule(qmp_dispatcher_bh);
>> >>   +        /*
>> >>   +         * Yield and reschedule so the main loop stays responsive.
>> >>   +         *
>> >>   +         * Move back to iohandler_ctx so that nested event loops f=
or
>> >>   +         * qemu_aio_context don't start new monitor commands.
>> >>=20
>> >> Can you explain this sentence for dummies?
>> >
>> > Nested event loops (i.e. AIO_WAIT_WHILE) poll qemu_aio_context, so if =
we
>> > are scheduled there, the next iteration of the monitor dispatcher loop
>> > could start from a nested event loop. If we are scheduled in
>> > iohandler_ctx, then only the actual main loop will reenter the corouti=
ne
>> > and nested event loops ignore it.
>> >
>> > I'm not sure if or why this is actually important, but this matches
>> > scheduling the dispatcher BH in iohandler_ctx in the code before this
>> > patch.
>> >
>> > If we didn't do this, we could end up starting monitor requests in mor=
e
>> > places than before, and who knows what that would mean.
>>=20
>> Let me say it in my own words, to make sure I got it.  I'm going to
>> ignore special cases like "not using I/O thread" and exec-oob.
>>=20
>> QMP monitor I/O happens in mon_iothread, in iohandler_ctx (I think).
>> This pushes requests onto the monitor's qmp_requests queue.
>
> mon_iothread (like all iothreads) has a separate AioContext, which
> doesn't have a name, but can be accessed with
> iothread_get_aio_context(mon_iothread).

Got it.

@iohandler_ctx and @qemu_aio_context both belong to the main loop.

@qemu_aio_context is for general "run in the main loop" use.  It is
polled both in the actual main loop and event loops nested in it.  I
figure "both" to keep things responsive.

@iohandler_ctx is for "I/O handlers" (whatever those are).  It is polled
only in the actual main loop.  I figure this means "I/O handlers" may
get delayed while a nested event loop runs.  But better starve a bit
than run in unexpected places.

>> Before this patch, the dispatcher runs in a bottom half in the main
>> thread, in qemu_aio_context.
>
> The dispatcher BH is what is scheduled in iohandler_ctx. This means that
> the BH is run from the main loop, but not from nested event loops.

Got it.

>> The patch moves it to a coroutine running in the main thread.  It runs
>> in iohandler_ctx, but switches to qemu_aio_context for executing command
>> handlers.
>>=20
>> We want to keep command handlers running in qemu_aio_context, as before
>> this patch.
>
> "Running in AioContext X" is kind of a sloppy term, and I'm afraid it
> might be more confusing than helpful here. What this means is that the
> code is run while holding the lock of the AioContext, and it registers
> its BHs, callbacks etc. in that AioContext so it will be called from the
> event loop of the respective thread.
>
> Before this patch, command handlers can't really use callbacks without a
> nested event loop because they are synchronous.

I figure an example for such a nested event loop is BDRV_POLL_WHILE() in
bdrv_truncate(), which runs in the command handler for block_resize.
True?

>                                                 The BQL is held, which
> is equivalent to holding the qemu_aio_context lock.

Why is it equivalent?  Are they always taken together?

>                                                     But other than that,
> all of the definition of "running in an AioContext" doesn't really apply.
>
> Now with coroutines, you assign them an AioContext, which is the context
> in which BHs reentering the coroutine will be scheduled, e.g. from
> explicit aio_co_schedule(), after qemu_co_sleep_ns() or after waiting
> for a lock like a CoMutex.
>
> qemu_aio_context is what most (if not all) of the existing QMP handlers
> use when they run a nested event loop,

bdrv_truncate() appears to use bdrv_get_aio_context(), which is the
BlockDriverState's AioContext if set, else @qemu_aio_context.

>                                        so running the coroutine in this
> context while calling the handlers will make the transition the easiest.

In the case of block_resize: running it in a coroutine makes
bdrv_truncate() use that coroutine instead of creating one together with
a nested event loop.  "That coroutine" uses @qemu_aio_context.  So does
the nested event loop, *except* when the BlockDriverState has an
AioContext.

I have no idea when a BlockDriverState has an AioContext.  Can you help?

>> We want to run the rest in iohandler_ctx to ensure dispatching happens
>> only in the main loop, as before this patch.
>>=20
>> Correct?
>
> This part is correct.

Alright, let me try again, so you can point out the next level of my
ignorance :)

QMP monitor I/O happens in I/O thread @mon_iothread, in the I/O thread's
AioContext.  The I/O thread's event loop polls monitor I/O.  The read
handler pushes requests onto the monitor's qmp_requests queue.

The dispatcher pops requests off these queues, and runs command
handlers for them.

Before this patch, the dispatcher runs in a bottom half in the main
thread with the BQL[*] held, in @iohandler_ctx context.  The latter
ensures dispatch happens only from the main loop, not nested event
loops.

The command handlers don't care for the AioContext; they're synchronous.
If they need AIO internally, they have to set up a nested event loop.
When they do, they pick the AioContext explicitly, so they still don't
rely on the current context.

The patch moves the dispatcher to a coroutine running in the main
thread.  It runs in iohandler_ctx, but switches to qemu_aio_context for
executing command handlers.

The dispatcher keeps running in @iohandler_ctx.  Good.

The command handlers now run in @qemu_aio_context.  Doesn't matter
because "command handlers don't care for the AioContext".  Except when a
command handler has a fast path like bdrv_truncate() has.  For those,
@iohandler_ctx is generally not what we want.  @qemu_aio_context is.
"Generally", since every one needs to be inspected for AioContext
shenanigans.


[*] @qemu_global_mutex, a.k.a. "iothread mutex"; pity anyone who needs
to figure this out from the source code by himself


