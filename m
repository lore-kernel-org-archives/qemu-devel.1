Received: from eggs.gnu.org ([2001:4830:134:3::10]:49817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6cSR-0002j8-Rc
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:35:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6cSM-0005tB-M4
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:35:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d6cSM-0005sv-Ct
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:35:34 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
	<87mvaszbsu.fsf@dusky.pond.sub.org>
	<CAJ+F1C+MvHoMtaUUWDDmoFJWEXiaK1FxeZ8csqTOEB76WSPDRA@mail.gmail.com>
Date: Fri, 05 May 2017 14:35:25 +0200
In-Reply-To: <CAJ+F1C+MvHoMtaUUWDDmoFJWEXiaK1FxeZ8csqTOEB76WSPDRA@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 05 May 2017
	09:00:17 +0000")
Message-ID: <877f1viir6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/25] qmp: add async command type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, kraxel@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Thu, May 4, 2017 at 11:02 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>
>> I figure everyone interested has had his say.  Let me try to summarize
>> and draw my conclusions.
>>
>> Commands + events can replace asynchronous commands (they did).
>>
>> Asynchronous commands cannot replace events, because "interesting" side
>> effects of commands need to be broadcast.  Doesn't mean asynchronous
>> commands can't make sense for us.  Does mean that we need to address any
>> serious flaws in the existing commands + event mechanism even if we
>> adopt asynchronous commands.  The cover letter lists multiple flaws,
>> which I'll discuss inline.
>>
>> If an operation satisfies certain conditions, then implementing it as
>> asynchronous command provides certain benefits.  If the operation
>>
>> (C1) does not need to broadcast state changes, including start and end
>>      of operation, and
>>
>> (C2) even the initiating client needs no state change notifications
>>      except for end of operation, and
>>
>> (C3) even that isn't needed when the client loses the connection and
>>      reconnects, and
>>
>> (C4) the operation doesn't have to be examined or controlled while it
>>      runs,
>>
>> then making it an asynchronous command
>>
>> (B1) saves you the trouble of defining an event together with its link
>>      to the command, and
>>
>> (B2) saves you the trouble of sending the event, and
>>
>> (B3) saves a bit of QMP traffic, namely the event broadcast.
>>
>> Letting clients opt into the asynchronousness as this series does
>> provides an additional benefit:
>>
>> (B4) when you find one of your synchronous commands is at times taking
>>      too long, you can compatibly evolve it.
>>
>> We can remove (C3) and (C4) by providing suitable ways to examine and
>> control asynchronous commands while they run.
>>
>> We could remove (C1) and (C2) by sending events, but that would also
>> lose pretty much all benefits.
>>
>> The operation chosen to showcase asynchronous commands is taking
>> screenshots.  It obviously satisfies (C1).  I guess for (C2) and (C4) we
>> have to assume that it completes "quickly".  I'm willing to buy that.
>> (C3) seems pretty dubious to me, however.
>>
>> The tradeoff to judge is desirability of the benefits vs. cost to get
>> them.
>>
>> Desirability depends on how many commands satisfy these conditions, and
>> how much trouble exactly is saved.
>>
>> A list of commands that is more complete than just "screendump" would
>> help with the former.  query- commands that need to gather information
>> in ways that could block are among the candidates.
>>
>> On the latter, I figure (B1) dwarves (B2), (B3) is a relatively minor
>> optimization unless proven otherwise, and (B4) is real, but asynchronous
>> commands are not the only way to get it; we can equally well evolve
>> synchronous commands compatibly into synchronous + event.
>>
>> The cost is interface and implementation complexity.
>>
>> Interface complexity increases because we add the concept "asynchronous
>> command" and the concept "synchronous or asynchronous command, client's
>> choice".  This is my main concern.
>>
>
> Since we already have client dispatch of unrelated reply and hidden-async
> pattern, this is less of a concern in practice, most of the complexity has
> to be already handled.

Yes, we already handle the abstract concept of kicking off operations
and getting notified when they change state.  But we handle it in *one*
abstract way: command + event(s).  Adding a second way (asynchronous
commands) can only increase complexity.

> Note it is a bit simpler for a client to handle a generic async return
> rather than various events.

I posit that the complexitity difference between zero and one instances
of command + event far exceeds the one between one and multiple.

Same for asynchronous commands.

The increase in conceptual complexity might be offset by a decrease in
individual operations' complexity.  That's (B1).

Your best estimate of the overall complexity change is more favourable
than mine.  That's okay, you're as entitled to your opinion as I am.
But my duty is to come up with my own best estimate, and act on it.

>> Implementation complexity isn't prohibitive according to diffstat, but
>> it's not neglible, either: with the last six patches peeled off, we get
>> some 500 additional lines plus some 300 in tests/.  The last six patches
>> put the new infrastructure to work, which takes another 200.  Ways to
>> examine and control asynchronous commands while they run would add some
>> more, but we don't know how much exactly.
>>
>> Now let me take a step back: we need to crack the "jobs" problem anyway.
>> Merging this series now would in a way add another special case of the
>> general case "jobs" before adding the general case.  In other words,
>> create more stuff to unify.  I'm afraid that's a bad idea, not least
>> since it's an external interface.  I think we should do "jobs" first.
>> Once we got at least a prototype, we can
>>
>> * judge how onerous defining and implementing jobs really is, i.e. have
>>   a clearer idea of the potential benefits of asynchronous commands, and
>>
>> * explore asynchronous commands as a special case of "jobs" optimized
>>   for operations that satisfy the conditions above, i.e. get a clearer
>>   idea of the *actual* additional implementation complexity.
>>
>
> That's what I have been told for over 1.5y :) I would like to know the li=
st
> of requirements / features "jobs" would have. I am willing to help
> implementing it.

We have multiple use cases for generic jobs infrastructure in various
subsystems, but the ones driving the work are the block subsystem's,
simply because the existing block jobs need a major revamp anyway.  The
people most familiar with the requirements are John Snow, Kevin Wolf,
Stefan Hajnoczi, and to a lesser degree myself.  Recommend to meet John
in front of a big whiteboard, or else the next best way to talk things
over you two can find.

>> Bottom line:
>>
>> 1. I still don't want to merge this.
>>
>> 2. I want us to tackle jobs sooner rather than later.
>>
>> 3. Once we got at least a jobs prototype, I'm willing to reconsider
>>    asynchronous commands implemented as special case of jobs.
>>
>>
> Who is going to work on it?

I hope John can work on jobs.

>> One of the most important maintainer duties is saying "no".  It's also
>> one of the least fun duties.
>>
>>
> It doesn't sound like a "no" :)

Well, it's as close to "no" as you can get in a situation that's going
to change!  It's a straight "no" for the current situation, and a
"maybe" for a future situation that will be different in ways we don't
yet understand.

I'm *not* encouraging you to pursue asynchronous QMP commands.  In fact,
I never did, at least not knowingly.  It's your decision.  All I offer
is what I offer to all patch submitters: my best effort at a fair
hearing.
