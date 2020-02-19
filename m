Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3852BC34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:22:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4F682176D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F9MA7jxi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F682176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4QFR-0003Qz-53
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 09:22:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48055)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j4QEj-0002jz-W6
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:22:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j4QEh-0004fN-H4
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:22:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43632
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j4QEh-0004bj-6P
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:21:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582122118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4iuVpabDE87txwOahSMphdswhZEMQKZ+87axqZmBDaY=;
 b=F9MA7jxi9B6x1Rgc3lpyRBPXq6p6wm0ED4OHyRVDZsAUKZL3y4cSeyhn/WAW9xuD6IshtD
 XvRimf19nK86uX1+Pn3pV17RbrJKsbxjL90EAyOvpMQLFLgle+1H9OMN0Kz9WaC2khujeV
 L+iEkYbfYPTsYfveQGYMM0k3Sf9TE+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-WWWwo55pPgeNIKZ1smXQYw-1; Wed, 19 Feb 2020 09:21:56 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 291BB85EE97;
 Wed, 19 Feb 2020 14:21:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A75315C3FA;
 Wed, 19 Feb 2020 14:21:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2C0BE11385C9; Wed, 19 Feb 2020 15:21:50 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v4 3/4] qmp: Move dispatcher to a coroutine
References: <20200121181122.15941-1-kwolf@redhat.com>
 <20200121181122.15941-4-kwolf@redhat.com>
 <87lfp1sc8d.fsf@dusky.pond.sub.org>
 <20200217123454.GF6309@linux.fritz.box>
 <87r1ysc7d4.fsf@dusky.pond.sub.org>
 <20200218152931.GG6157@linux.fritz.box>
 <87tv3nt0cu.fsf@dusky.pond.sub.org>
 <20200219102226.GA6464@linux.fritz.box>
Date: Wed, 19 Feb 2020 15:21:50 +0100
In-Reply-To: <20200219102226.GA6464@linux.fritz.box> (Kevin Wolf's message of
 "Wed, 19 Feb 2020 11:22:26 +0100")
Message-ID: <8736b6r729.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: WWWwo55pPgeNIKZ1smXQYw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: qemu-block@nongnu.org, marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 19.02.2020 um 10:03 hat Markus Armbruster geschrieben:
>> >> >>   @@ -246,8 +287,15 @@ void monitor_qmp_bh_dispatcher(void *data)
>> >> >>            }
>> >> >>            qmp_request_free(req_obj);
>> >> >>=20
>> >> >>   -    /* Reschedule instead of looping so the main loop stays res=
ponsive */
>> >> >>   -    qemu_bh_schedule(qmp_dispatcher_bh);
>> >> >>   +        /*
>> >> >>   +         * Yield and reschedule so the main loop stays responsi=
ve.
>> >> >>   +         *
>> >> >>   +         * Move back to iohandler_ctx so that nested event loop=
s for
>> >> >>   +         * qemu_aio_context don't start new monitor commands.
>> >> >>=20
>> >> >> Can you explain this sentence for dummies?
>> >> >
>> >> > Nested event loops (i.e. AIO_WAIT_WHILE) poll qemu_aio_context, so =
if we
>> >> > are scheduled there, the next iteration of the monitor dispatcher l=
oop
>> >> > could start from a nested event loop. If we are scheduled in
>> >> > iohandler_ctx, then only the actual main loop will reenter the coro=
utine
>> >> > and nested event loops ignore it.
>> >> >
>> >> > I'm not sure if or why this is actually important, but this matches
>> >> > scheduling the dispatcher BH in iohandler_ctx in the code before th=
is
>> >> > patch.
>> >> >
>> >> > If we didn't do this, we could end up starting monitor requests in =
more
>> >> > places than before, and who knows what that would mean.
>> >>=20
>> >> Let me say it in my own words, to make sure I got it.  I'm going to
>> >> ignore special cases like "not using I/O thread" and exec-oob.
>> >>=20
>> >> QMP monitor I/O happens in mon_iothread, in iohandler_ctx (I think).
>> >> This pushes requests onto the monitor's qmp_requests queue.
>> >
>> > mon_iothread (like all iothreads) has a separate AioContext, which
>> > doesn't have a name, but can be accessed with
>> > iothread_get_aio_context(mon_iothread).
>>=20
>> Got it.
>>=20
>> @iohandler_ctx and @qemu_aio_context both belong to the main loop.
>>=20
>> @qemu_aio_context is for general "run in the main loop" use.  It is
>> polled both in the actual main loop and event loops nested in it.  I
>> figure "both" to keep things responsive.
>>=20
>> @iohandler_ctx is for "I/O handlers" (whatever those are).  It is polled
>> only in the actual main loop.  I figure this means "I/O handlers" may
>> get delayed while a nested event loop runs.  But better starve a bit
>> than run in unexpected places.
>>=20
>> >> Before this patch, the dispatcher runs in a bottom half in the main
>> >> thread, in qemu_aio_context.
>> >
>> > The dispatcher BH is what is scheduled in iohandler_ctx. This means th=
at
>> > the BH is run from the main loop, but not from nested event loops.
>>=20
>> Got it.
>>=20
>> >> The patch moves it to a coroutine running in the main thread.  It run=
s
>> >> in iohandler_ctx, but switches to qemu_aio_context for executing comm=
and
>> >> handlers.
>> >>=20
>> >> We want to keep command handlers running in qemu_aio_context, as befo=
re
>> >> this patch.
>> >
>> > "Running in AioContext X" is kind of a sloppy term, and I'm afraid it
>> > might be more confusing than helpful here. What this means is that the
>> > code is run while holding the lock of the AioContext, and it registers
>> > its BHs, callbacks etc. in that AioContext so it will be called from t=
he
>> > event loop of the respective thread.
>> >
>> > Before this patch, command handlers can't really use callbacks without=
 a
>> > nested event loop because they are synchronous.
>>=20
>> I figure an example for such a nested event loop is BDRV_POLL_WHILE() in
>> bdrv_truncate(), which runs in the command handler for block_resize.
>> True?
>
> Yes. I think most nested event loops are in the block layer, and they
> use the BDRV_POLL_WHILE() or AIO_WAIT_WHILE() macros today.
>
>> >                                                 The BQL is held, which
>> > is equivalent to holding the qemu_aio_context lock.
>>=20
>> Why is it equivalent?  Are they always taken together?
>
> I guess ideally they would be. In practice, we neglect the
> qemu_aio_context lock and rely on the BQL for everything in the main
> thread. So maybe I should say the BQL replaces the AioContext lock for
> the main context rather than being equivalent.

Sounds a bit sloppy.  It works...

>> >                                                     But other than tha=
t,
>> > all of the definition of "running in an AioContext" doesn't really app=
ly.
>> >
>> > Now with coroutines, you assign them an AioContext, which is the conte=
xt
>> > in which BHs reentering the coroutine will be scheduled, e.g. from
>> > explicit aio_co_schedule(), after qemu_co_sleep_ns() or after waiting
>> > for a lock like a CoMutex.
>> >
>> > qemu_aio_context is what most (if not all) of the existing QMP handler=
s
>> > use when they run a nested event loop,
>>=20
>> bdrv_truncate() appears to use bdrv_get_aio_context(), which is the
>> BlockDriverState's AioContext if set, else @qemu_aio_context.
>
> Right, the BDRV_POLL_WHILE() macro allows waiting for something in a
> different AioContext from the main context. This works because of the
> aio_wait_kick() in bdrv_truncate_co_entry(), which schedules a BH in the
> main context, and this is what BDRV_POLL_WHILE() is waiting for.

Hairy...

> So the command handler runs in the main context (and thread), whereas
> the bdrv_co_truncate() runs in the AioContext (and thread) of the BDS.
>
>> >                                        so running the coroutine in thi=
s
>> > context while calling the handlers will make the transition the easies=
t.
>>=20
>> In the case of block_resize: running it in a coroutine makes
>> bdrv_truncate() use that coroutine instead of creating one together with
>> a nested event loop.  "That coroutine" uses @qemu_aio_context.  So does
>> the nested event loop, *except* when the BlockDriverState has an
>> AioContext.
>>=20
>> I have no idea when a BlockDriverState has an AioContext.  Can you help?
>
> When it's used with a dataplane device, i.e. is tied a separate
> iothread.

I see.

> The fact that the coroutine fastpath (not only in bdrv_truncate(), but
> also everywhere else) assumes that we're already in the right AioContext
> might be a bug.
>
> If this is the only problem in v5, please consider applying only patches
> 1-3 (with the infrastructure) so that Marc-Andr=C3=A9's screendump patch =
gets
> its dependency resolved, and I'll send a separate series for converting
> block_resize that fixes this problem (probably by explicitly
> rescheduling the coroutine into the BDS context and back in the
> coroutine path).

Can do.

>> >> We want to run the rest in iohandler_ctx to ensure dispatching happen=
s
>> >> only in the main loop, as before this patch.
>> >>=20
>> >> Correct?
>> >
>> > This part is correct.
>>=20
>> Alright, let me try again, so you can point out the next level of my
>> ignorance :)
>>=20
>> QMP monitor I/O happens in I/O thread @mon_iothread, in the I/O thread's
>> AioContext.  The I/O thread's event loop polls monitor I/O.  The read
>> handler pushes requests onto the monitor's qmp_requests queue.
>>=20
>> The dispatcher pops requests off these queues, and runs command
>> handlers for them.
>>=20
>> Before this patch, the dispatcher runs in a bottom half in the main
>> thread with the BQL[*] held, in @iohandler_ctx context.  The latter
>> ensures dispatch happens only from the main loop, not nested event
>> loops.
>>=20
>> The command handlers don't care for the AioContext; they're synchronous.
>> If they need AIO internally, they have to set up a nested event loop.
>> When they do, they pick the AioContext explicitly, so they still don't
>> rely on the current context.
>
> They do rely on being run in the main thread, but the exact context
> doesn't matter. (In theory, running them in the thread of the block
> node's AioContext would be fine, too, but the monitor can't know what
> that is.)

Yes.  Command handlers have always run in the main thread, and handler
code may rely on that.

> See the AIO_WAIT_WHILE() documentation for details.
>
>> The patch moves the dispatcher to a coroutine running in the main
>> thread.  It runs in iohandler_ctx, but switches to qemu_aio_context for
>> executing command handlers.
>>=20
>> The dispatcher keeps running in @iohandler_ctx.  Good.
>>=20
>> The command handlers now run in @qemu_aio_context.  Doesn't matter
>> because "command handlers don't care for the AioContext".  Except when a
>> command handler has a fast path like bdrv_truncate() has.  For those,
>> @iohandler_ctx is generally not what we want.  @qemu_aio_context is.
>> "Generally", since every one needs to be inspected for AioContext
>> shenanigans.
>
> Except for the bug that the specific code in bdrv_trunate() wants
> to run the coroutine in the BDS AioContext, which may be different from
> qemu_aio_context...
>
> But I think the theory is right, for those commands that don't
> potentially schedule a coroutine in a different AioContext.

Let's review how switching to @qemu_aio_context for executing command
handlers affects command handlers:

* Handler is completely synchronous: the switch has no effect.

* Handler has a nested event loop

  - with a fast path for "running in coroutine context", and

    + the fast path tacitly assumes @qemu_aio_context: the switch makes
      it work without change

    + the fast path tacitly assumes anything else: the switch is
      useless, the fast path doesn't work without further changes

  - without such a fast path (not sure this case exists): the switch is
    useless, the nested event loop works anyway

* Handler has only the fast path, i.e. it assumes it runs coroutine
  context (this case cannot exist now, but this series enables it), and

  - the handler wants @qemu_aio_context: the switch saves it the trouble
    to switch itself

  - the handler wants anything else: the switch is useless

Whether the switch is actually useful often enough to be worthwhile I
can't say.  But because @qemu_aio_context is the "normal" context for
"normal" code running in the main loop, switching feels kind of right to
me.

I think we need to talk about AioContext in qapi-code-gen.txt.  PATCH 1
now adds

  Member 'coroutine' tells the QMP dispatcher whether the command handler
  is safe to be run in a coroutine.  It defaults to false.  If it is true,
  the command handler is called from coroutine context and may yield while
  waiting for an external event (such as I/O completion) in order to avoid
  blocking the guest and other background operations.
 =20
What about "is called from a coroutine running in the main loop with
@qemu_aio_context, and may yield"?

Likewise for the commit message of PATCH 3:

  This moves the QMP dispatcher to a coroutine and runs all QMP command
  handlers that declare 'coroutine': true in coroutine context so they
  can avoid blocking the main loop while doing I/O or waiting for other
  events.

"calls all ... in a coroutine running in the main loop with
@qemu_aio_context, so they can".

Speaking of PATCH 1:

  It is an error to specify both 'coroutine': true and 'allow-oob': true
  for a command.  (We don't currently have a use case for both together and
  without a use case, it's not entirely clear what the semantics should be.=
)

Let's lose the parenthesis around the last sentence.

If you agree with my proposed tweaks, and nothing else comes up, I can
try to do them in my tree.


