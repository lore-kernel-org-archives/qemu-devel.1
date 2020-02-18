Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F753C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 15:30:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1935021D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 15:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jia6n6Tz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1935021D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j44pc-0000om-Ad
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 10:30:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j44oi-0008PK-Ob
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 10:29:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j44oh-00049n-1l
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 10:29:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57494
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j44og-00049S-UC
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 10:29:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582039782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sMt4VzCOJl2cLHEULFXiT+AIX6aqRwjiJJkMAkFIkLU=;
 b=Jia6n6TzlWpYfEkafP0VesCG4SvpQ8PxlPvPGoNuCZCRFJtD5KF4TYcs6vS+FXwm1mLlr5
 M9fK8TOtlaWl9BH2p94ucFrtV+aOzSjB6e/b3SLMp2WjY4bCIBwhWewYnZkCdIdHyWXiog
 2+gkLylWokGcNkGqmLH+77dSlwPBkks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-pJxbo8lZMeyUDsT7z1hgRA-1; Tue, 18 Feb 2020 10:29:38 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26D708010E5;
 Tue, 18 Feb 2020 15:29:37 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-181.ams2.redhat.com [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2205E5C241;
 Tue, 18 Feb 2020 15:29:32 +0000 (UTC)
Date: Tue, 18 Feb 2020 16:29:31 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v4 3/4] qmp: Move dispatcher to a coroutine
Message-ID: <20200218152931.GG6157@linux.fritz.box>
References: <20200121181122.15941-1-kwolf@redhat.com>
 <20200121181122.15941-4-kwolf@redhat.com>
 <87lfp1sc8d.fsf@dusky.pond.sub.org>
 <20200217123454.GF6309@linux.fritz.box>
 <87r1ysc7d4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87r1ysc7d4.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: pJxbo8lZMeyUDsT7z1hgRA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: qemu-block@nongnu.org, marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 18.02.2020 um 15:12 hat Markus Armbruster geschrieben:
> >> Regarding calling monitor_qmp_requests_pop_any_with_lock(): it needs
> >> @monitor_lock and @mon_list to be valid.  We just initialized
> >> @monitor_lock, and @mon_list is empty.
> >> monitor_qmp_requests_pop_any_with_lock() should be safe and return nul=
l.
> >> monitor_qmp_dispatcher_co() should also be safe and yield without doin=
g
> >> work.
> >>=20
> >> Can we exploit that to make things a bit simpler?  Separate patch woul=
d
> >> be fine with me.
> >
> > If this is true, we could replace this line:
> >
> >     aio_co_schedule(iohandler_get_aio_context(), qmp_dispatcher_co);
> >
> > with the following one:
> >
> >     qemu_aio_coroutine_enter(iohandler_get_aio_context(), qmp_dispatche=
r_co);
> >
> > I'm not sure that this is any simpler.
>=20
> Naive question: what's the difference between "scheduling", "entering",
> and "waking up" a coroutine?
>=20
> qemu_coroutine_enter() and qemu_aio_coroutine_enter() are in
> coroutine.h.

These are the low-level functions that just enter the coroutine (i.e. do
a stack switch and jump to coroutine code) immediately when they are
called. They must be called in the right thread with the right
AioContext locks held. (What "right" means depends on the code run in
the coroutine.)

> aio_co_schedule(), aio_co_wake() and aio_co_enter() are in aio.h.

aio_co_schedule() never enters the coroutine directly. It only adds it
to the list of scheduled coroutines and schedules a BH in the target
AioContext. This BH in turn will actually enter the coroutine.

aio_co_enter() enters the coroutine immediately if it's being called
outside of coroutine context and in the right thread for the given
AioContext. If it's in the right thread, but in coroutine context then
it will queue the given coroutine so that it runs whenever the current
coroutine yields. If it's in the wrong thread, it uses aio_co_schedule()
to get it run in the right thread.

aio_co_wake() takes just the coroutine as a parameter and calls
aio_co_enter() with the context in which the coroutine was last run.

All of these functions make sure that the AioContext lock is taken when
the coroutine is entered and that they run in the right thread.

> qemu_coroutine_enter() calls qemu_aio_coroutine_enter().
>=20
> aio_co_wake() calls aio_co_enter() calls qemu_aio_coroutine_enter().
>=20
> aio_co_enter() seems to be independent.

It's not. It calls either aio_co_schedule() or
qemu_aio_coroutine_enter(), or inserts the coroutine ina queue that is
processed in qemu_aio_coroutine_enter().

> aio.h seems to be layered on top of coroutine.h.  Should I prefer using
> aio.h to coroutine.h?

In the common case, using the aio.h functions is preferable because they
just do "the right thing" without requiring as much thinking as the
low-level functions.

> >> >  }
> >> > =20
> >> >  QemuOptsList qemu_mon_opts =3D {
> >> > diff --git a/monitor/qmp.c b/monitor/qmp.c
> >> > index 54c06ba824..9444de9fcf 100644
> >> > --- a/monitor/qmp.c
> >> > +++ b/monitor/qmp.c
> >> > @@ -133,6 +133,10 @@ static void monitor_qmp_respond(MonitorQMP *mon=
, QDict *rsp)
> >> >      }
> >> >  }
> >> > =20
> >> > +/*
> >> > + * Runs outside of coroutine context for OOB commands, but in corou=
tine context
> >> > + * for everything else.
> >> > + */
> >>=20
> >> Nitpick: wrap around column 70, please.
> >>=20
> >> Note to self: the precondition is asserted in do_qmp_dispatch() below.
> >> Asserting here is impractical, because we don't know whether this is a=
n
> >> OOB command.
> >>=20
> >> >  static void monitor_qmp_dispatch(MonitorQMP *mon, QObject *req)
> >> >  {
> >> >      Monitor *old_mon;
> >> > @@ -211,43 +215,87 @@ static QMPRequest *monitor_qmp_requests_pop_an=
y_with_lock(void)
> >> >      return req_obj;
> >> >  }
> >> > =20
> >> > -void monitor_qmp_bh_dispatcher(void *data)
> >> > +void coroutine_fn monitor_qmp_dispatcher_co(void *data)
> >> >  {
> >> > -    QMPRequest *req_obj =3D monitor_qmp_requests_pop_any_with_lock(=
);
> >> > +    QMPRequest *req_obj =3D NULL;
> >> >      QDict *rsp;
> >> >      bool need_resume;
> >> >      MonitorQMP *mon;
> >> > =20
> >> > -    if (!req_obj) {
> >> > -        return;
> >> > -    }
> >> > +    while (true) {
> >> > +        assert(atomic_mb_read(&qmp_dispatcher_co_busy) =3D=3D true)=
;
> >>=20
> >> Read and assert, then ...
> >>=20
> >> > +
> >> > +        /* Mark the dispatcher as not busy already here so that we =
don't miss
> >> > +         * any new requests coming in the middle of our processing.=
 */
> >> > +        atomic_mb_set(&qmp_dispatcher_co_busy, false);
> >>=20
> >> ... set.  Would exchange, then assert be cleaner?
> >
> > Then you would ask me why the exchange has to be atomic. :-)
>=20
> Possibly :)
>=20
> > More practically, I would need a temporary variable so that I don't get
> > code with side effects in assert() (which may be compiled out with
> > NDEBUG). The temporary variable would never be read outside the assert
> > and would be unused with NDEBUG.
> >
> > So possible, yes, cleaner I'm not sure.
>=20
> I asked because the patch made me wonder whether qmp_dispatcher_co could
> change between the read and the set.

Ah. No, this function is the only one that does a transition from true
to false. Everyone else only transitions from false to true (or leaves
the value unchanged as true).

> >>   @@ -246,8 +287,15 @@ void monitor_qmp_bh_dispatcher(void *data)
> >>            }
> >>            qmp_request_free(req_obj);
> >>=20
> >>   -    /* Reschedule instead of looping so the main loop stays respons=
ive */
> >>   -    qemu_bh_schedule(qmp_dispatcher_bh);
> >>   +        /*
> >>   +         * Yield and reschedule so the main loop stays responsive.
> >>   +         *
> >>   +         * Move back to iohandler_ctx so that nested event loops fo=
r
> >>   +         * qemu_aio_context don't start new monitor commands.
> >>=20
> >> Can you explain this sentence for dummies?
> >
> > Nested event loops (i.e. AIO_WAIT_WHILE) poll qemu_aio_context, so if w=
e
> > are scheduled there, the next iteration of the monitor dispatcher loop
> > could start from a nested event loop. If we are scheduled in
> > iohandler_ctx, then only the actual main loop will reenter the coroutin=
e
> > and nested event loops ignore it.
> >
> > I'm not sure if or why this is actually important, but this matches
> > scheduling the dispatcher BH in iohandler_ctx in the code before this
> > patch.
> >
> > If we didn't do this, we could end up starting monitor requests in more
> > places than before, and who knows what that would mean.
>=20
> Let me say it in my own words, to make sure I got it.  I'm going to
> ignore special cases like "not using I/O thread" and exec-oob.
>=20
> QMP monitor I/O happens in mon_iothread, in iohandler_ctx (I think).
> This pushes requests onto the monitor's qmp_requests queue.

mon_iothread (like all iothreads) has a separate AioContext, which
doesn't have a name, but can be accessed with
iothread_get_aio_context(mon_iothread).

> Before this patch, the dispatcher runs in a bottom half in the main
> thread, in qemu_aio_context.

The dispatcher BH is what is scheduled in iohandler_ctx. This means that
the BH is run from the main loop, but not from nested event loops.

> The patch moves it to a coroutine running in the main thread.  It runs
> in iohandler_ctx, but switches to qemu_aio_context for executing command
> handlers.
>=20
> We want to keep command handlers running in qemu_aio_context, as before
> this patch.

"Running in AioContext X" is kind of a sloppy term, and I'm afraid it
might be more confusing than helpful here. What this means is that the
code is run while holding the lock of the AioContext, and it registers
its BHs, callbacks etc. in that AioContext so it will be called from the
event loop of the respective thread.

Before this patch, command handlers can't really use callbacks without a
nested event loop because they are synchronous. The BQL is held, which
is equivalent to holding the qemu_aio_context lock. But other than that,
all of the definition of "running in an AioContext" doesn't really apply.

Now with coroutines, you assign them an AioContext, which is the context
in which BHs reentering the coroutine will be scheduled, e.g. from
explicit aio_co_schedule(), after qemu_co_sleep_ns() or after waiting
for a lock like a CoMutex.

qemu_aio_context is what most (if not all) of the existing QMP handlers
use when they run a nested event loop, so running the coroutine in this
context while calling the handlers will make the transition the easiest.

> We want to run the rest in iohandler_ctx to ensure dispatching happens
> only in the main loop, as before this patch.
>=20
> Correct?

This part is correct.

Kevin


