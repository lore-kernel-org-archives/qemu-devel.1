Received: from eggs.gnu.org ([2001:4830:134:3::10]:42718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ffo47-0002Nv-70
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ffo43-000819-V1
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:08:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45396 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ffo43-00080D-On
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:08:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CD18D4062231
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 15:08:26 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180620073223.31964-1-peterx@redhat.com>
	<871sctea4y.fsf@dusky.pond.sub.org>
	<87tvpoadcc.fsf_-_@dusky.pond.sub.org>
	<87wouk8vul.fsf@dusky.pond.sub.org>
	<87h8lo74oa.fsf@dusky.pond.sub.org> <20180627133442.GB2455@xz-mi>
	<87woujgi8m.fsf@dusky.pond.sub.org> <20180629090115.GH2455@xz-mi>
Date: Wed, 18 Jul 2018 17:08:21 +0200
In-Reply-To: <20180629090115.GH2455@xz-mi> (Peter Xu's message of "Fri, 29 Jun
	2018 17:01:15 +0800")
Message-ID: <87d0vkh996.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] monitor: enable OOB by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>

Marc-Andr=C3=A9, one question for you inline.  Search for your name.

Peter Xu <peterx@redhat.com> writes:

> On Thu, Jun 28, 2018 at 03:20:41PM +0200, Markus Armbruster wrote:
>> Peter Xu <peterx@redhat.com> writes:
>>=20
>> > On Wed, Jun 27, 2018 at 03:13:57PM +0200, Markus Armbruster wrote:
>> >> Monitor behavior changes even when the client rejects capability "oob=
".
>> >>=20
>> >> Traditionally, the monitor reads, executes and responds to one command
>> >> after the other.  If the client sends in-band commands faster than the
>> >> server can execute them, the kernel will eventually refuse to buffer
>> >> more, and sending blocks or fails with EAGAIN.
>> >>=20
>> >> To make OOB possible, we need to read and queue commands as we receive
>> >> them.  If the client sends in-band commands faster than the server can
>> >> execute them, the server will eventually drop commands to limit the
>> >> queue length.  The sever sends event COMMAND_DROPPED then.
>> >>=20
>> >> However, we get the new behavior even when the client rejects capabil=
ity
>> >> "oob".  We get the traditional behavior only when the server doesn't
>> >> offer "oob".
>> >>=20
>> >> Is this what we want?
>> >
>> > Not really.  But I thought we kept that old behavior, haven't we?
>> >
>> > In handle_qmp_command() we have this:
>> >
>> >     /*
>> >      * If OOB is not enabled on the current monitor, we'll emulate the
>> >      * old behavior that we won't process the current monitor any more
>> >      * until it has responded.  This helps make sure that as long as
>> >      * OOB is not enabled, the server will never drop any command.
>> >      */
>> >     if (!qmp_oob_enabled(mon)) {
>> >         monitor_suspend(mon);
>> >         req_obj->need_resume =3D true;
>> >     } else {
>> >         /* Drop the request if queue is full. */
>> >         if (mon->qmp.qmp_requests->length >=3D QMP_REQ_QUEUE_LEN_MAX) {
>> >             qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
>> >             qapi_event_send_command_dropped(id,
>> >                                             COMMAND_DROP_REASON_QUEUE_=
FULL,
>> >                                             &error_abort);
>> >             qmp_request_free(req_obj);
>> >             return;
>> >         }
>> >     }
>> >
>> > Here assuming that we are not enabling OOB, then since we will suspend
>> > the monitor when we receive one command, then monitor_can_read() later
>> > will check with a result that "we should not read the chardev", then
>> > it'll leave all the data in the input buffer.  Then AFAIU the QMP
>> > client that didn't enable OOB will have similar behavior as before.
>> >
>> > Also, we will never receive a COMMAND_DROPPED event in that legacy
>> > mode as well since it's in the "else" block.   Am I right?
>>=20
>> Hmm.  Did I get confused?  Let me look again.
>>=20
>> Some places check qmp_oob_enabled(), which is true when the server
>> offered capability "oob" and the client accepted.  In terms of my reply
>> to Daniel, it distinguishes the two run time cases "OOB off" and "OOB
>> on".
>
> Exactly.
>
>>=20
>> Other places check ->use_io_thr, which is true when
>>=20
>>     (flags & MONITOR_USE_CONTROL) && !CHARDEV_IS_MUX(chr)
>>=20
>> in monitor_init().

->use_io_thr is now spelled ->use_io_thread.

>> One of these places is get_qmp_greeting().  It makes the server offer
>> "oob" when ->use_io_thr.  Makes sense.
>>=20
>> In terms of my reply to Daniel, ->use_io_thr distinguishes between "OOB
>> not offered" and ("OOB offered, but rejected by client" or "OOB offered
>> and accepted").
>
> Exactly.
>
> To be more clear, let's name the three cases (as you mentioned):
>
> (A) OOB not offered
> (B) OOB offered, but rejected by client
> (C) OOB offered, and accepted
>
> Then:
>
> (1) qmp_oob_enabled() will only be return true if (C).
> (2) ->use_io_thr will only be true if (B) or (C).

Notes on (A) to be kept in mind for the remainder of the discussion:

* I don't expect (A) to occur in production

  (A) means the monitor has a chardev-mux backend.  chardev-mux
  multiplexes multiple character backends, e.g. multiplex a monitor and
  a console on stdio.  C-a c switches focus.  While such multiplexing
  may be convenient for humans, it's an unnecessary complication for
  machines, which could just as well use two UNIX domain sockets and not
  have to worry about focus and escape sequences.

* I do expect (A) to go away eventually

  (A) exists only because "not all the chardev frontends can run without
  main thread, or can run in multiple threads" [PATCH 6].  Hopefully,
  that'll be fixed eventually, so (A) can go away.

  Marc-Andr=C3=A9, your "[PATCH 04/12] Revert "qmp: isolate responses into =
io
  thread" states the "chardev write path is thread safe".  What's
  missing to make chardev-mux capable of supporting OOB?

>> Uses could to violate 'may use "server offered OOB" only for
>> configuration purposes', so let's check them:
>>=20
>> * monitor_json_emitter()

This is now qmp_queue_response()

>>   If mon->use_io_thr, push to response queue.  Else emit directly.
>>=20
>>   I'm afraid run time behavior differs for "OOB not offered" (emit
>>   directly) and "OOB offered by rejected" (queue).
>
> Yeah it's different, but logically it's the same.  IMHO it's only a
> fast path for main thread.  In other word, I think it can still work
> correctly if we remove that else clause.  In that sense, it's not
> really a "true" behavior change.

Remember that (A) should not occur in production, and should go away
eventually.  Maintaining a fast path just for that feels unjustified.

>> * qmp_caps_check()
>>=20
>>   If !mon->use_io_thr, reject client's acceptance of "oob".  Implicitly
>>   recomputing the set of offered capabilities here is less than elegant,
>>   but it's not wrong.

This has been replaced by monitor_qmp_caps_reset().

If mon->use_io_thread, offer OOB.  Makes sense.

>> * monitor_resume()
>>=20
>>   If mon->use_io_thr(), kick the monitor I/O thread.
>>=20
>>   Again, different behavior for the two variations of "OOB off".
>
> This is another example like above - IMHO we can just kick it no
> matter what, but we just don't need to do that for main thread (since
> we are in main thread so we are sure it is not asleep).  It's just
> another trivial enhancement on top of the main logic.

Again, maintaining a special case just for (A) feels unjustified.

>> * get_qmp_greeting()
>>=20
>>   Covered above, looks good to me.

Also replaced by monitor_qmp_caps_reset().

>> * monitor_qmp_setup_handlers_bh()
>>=20
>>   If mon->use_io_thr(), pass the monitor I/O thread's AIOContext to
>>   qemu_chr_fe_set_handlers(), else pass NULL.
>>=20
>>   Again, different behavior for the two variations of "OOB off".
>
> This is different indeed, but IMHO it's not really "behavior
> difference", it's just the context (thread to run the code) that is
> different.  The major code path for case (A) and (B) (which are the
> two "off" cases) should be the same (when I say "major", I excluded
> those trivial enhancements that I mentioned).

As far as I can tell, monitor_qmp_setup_handlers_bh() can run only if
scheduled by monitor_init() when mon->use_io_thread.  If that's true,
then the !mon->use_io_thread case is unreachable.  Ah, I see you've also
noticed that, and you're proposing a patch below.

>> * monitor_init()
>>=20
>>   If mon->use_io_thr, set up bottom half
>>   monitor_qmp_setup_handlers_bh(), else call qemu_chr_fe_set_handlers()
>>   directly.
>
> This is indeed a bit tricky (to avoid a potential race that Stefan has
> pointed out), however after things are setup it'll be exactly the same
> code path for both OFF cases.
>
> And actually when I read the code I noticed that we can actually
> simplify the code with this:
>
> diff --git a/monitor.c b/monitor.c
> index 0730a27172..5d6bff8d51 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -4635,18 +4635,14 @@ static void monitor_qmp_setup_handlers_bh(void *o=
paque)
>      Monitor *mon =3D opaque;
>      GMainContext *context;
>
> -    if (mon->use_io_thr) {
> -        /*
> -         * When use_io_thr is set, we use the global shared dedicated
> -         * IO thread for this monitor to handle input/output.
> -         */
> -        context =3D monitor_get_io_context();
> -        /* We should have inited globals before reaching here. */
> -        assert(context);
> -    } else {
> -        /* The default main loop, which is the main thread */
> -        context =3D NULL;
> -    }
> +    assert(mon->use_io_thr);
> +    /*
> +     * When use_io_thr is set, we use the global shared dedicated
> +     * IO thread for this monitor to handle input/output.
> +     */
> +    context =3D monitor_get_io_context();
> +    /* We should have inited globals before reaching here. */
> +    assert(context);
>
>      qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_qmp_re=
ad,
>                               monitor_qmp_event, NULL, mon, context, true=
);
>
> Since monitor_qmp_setup_handlers_bh() will only be used for IOThread
> case.  I can post a patch for that.

Yes, please.

>>=20
>>   Again, different behavior for the two variations of "OOB off".

The difference is

* timing: right away for (A) vs. bottom half for (B) and (C)

* context argument for qemu_chr_fe_set_handlers(): NULL, i.e. main loop
  thread for (A), monitor_get_io_context(), i.e. the I/O thread for (B)
  and (C)

Okay, I think.

>> Either I am confused now, or the two variations of "OOB off" execute
>> different code at run time.  Which is it?
>
> As mentioned, they should be running the same code at run time.
> Though with some trivial differences, but if you see above most of
> them should only be small enhancements which can actually be removed.

Please do.

>> If it's different code, are the differences observable for the client?
>
> AFAIU since the code path should mostly be the same for the two OOF
> cases, IMHO there should have no difference observable from the
> client, otherwise it's buggy and I'd be willing to fix it.
>
>>=20
>> Observable or not, I suspect the differences should not exist.
>
> We can remove those "trivial enhancements" if we want to make sure the
> code paths are exactly the same, but I'm not sure whether that's
> really what we need (or we just need to make sure it's unobservable).

As long as we're running separate code for (A), "unobservable
difference" is a proposition we need to prove.

Reducing separate code should simplify the proof.

Eliminiating it will simplify it maximally :)

> Thanks!

Thank *you* for persevering :)
