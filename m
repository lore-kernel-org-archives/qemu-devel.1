Received: from eggs.gnu.org ([2001:4830:134:3::10]:54143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cWPJM-0004tJ-LY
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 10:16:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cWPJI-0000KF-Ji
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 10:16:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cWPJI-0000Jm-Af
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 10:16:32 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 997C47FB6C
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 15:16:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
Date: Wed, 25 Jan 2017 16:16:28 +0100
In-Reply-To: <20170118160332.13390-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 18 Jan 2017 20:03:07 +0400")
Message-ID: <87o9yv890z.fsf@dusky.pond.sub.org>
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, Jeff Cody <jcody@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Cc'ing block job people.

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi,
>
> One of initial design goals of QMP was to have "asynchronous command
> completion" (http://wiki.qemu.org/Features/QAPI). Unfortunately, that
> goal was not fully achieved, and some broken bits left were removed
> progressively until commit 65207c59d that removed async command
> support.

Correct.

QMP's initial design stipulated that commands are asynchronous.  The
initial implementation made them all synchronous, with very few
exceptions (buggy ones, to boot).  Naturally, clients relied on the
actual rather than the theoretical behavior, i.e. on getting command
replies synchronously, in order.

> Note that qmp events are asynchronous messages, and must be handled
> appropriately by the client: dispatch both reply and events after a
> command is sent for example.

Yes.

> The benefits of async commands that can be trade-off depending on the
> requirements are:
>
> 1) allow the command handler to re-enter the main loop if the command
> cannot be handled synchronously, or if it is long-lasting. This is
> currently not possible and make some bugs such as rhbz#1230527 tricky
> (see below) to solve.  Furthermore, many QMP commands do IO and could
> be considered 'slow' and blocking today.
>
> 2) allow concurrent commands and events. This mainly implies hanlding
> concurrency in qemu and out-of-order replies for the client. As noted
> earlier, a good qmp client already has to handle dispatching of
> received messages (reply and events).

We need to distingish two kinds of concurrency.  One, execution of QMP
commands concurrently with other activities in QEMU, including other QMP
monitors.  Two, executing multiple QMP commands concurrently in the same
monitor, which obviously requires all but one of them to be
asynchronous.

> The traditional approach to solving the above in qemu is the following
> scheme:
> -> { "execute": "do-foo" }
> <- { "return": {} }
> <- { "event": "FOO_DONE" }

... where the event may carry additional data, such as the command's
true result.

> It has several flaws:
> - FOO_DONE event has no semantic link with do-foo in the qapi
>   schema. It is not simple to generalize that pattern when writing
>   qmp clients. It makes documentation and usage harder.
> - the FOO_DONE event has no clear association with the command that
>   triggered it: commands/events have to come up with additional
>   specific association schemes (ids, path etc)

Valid points.  Emulating asynchronous commands with a synchronous
command + event isn't quite as simple to specify as a native
asynchronous command could be.

> - FOO_DONE is broadcasted to all clients, but they may have no way to
>   interprete it or interest in it, or worse it may conflict with their
>   own commands.

The part about "no interest" is valid in cases where the event signals
completion of a job without side effects, because then only the job's
initiator cares (the event has to carry a result for this to make
sense).  But when the job has side effects, other clients may want to
know, and broadcast is probably the right thing to do.

We deliberately broadcast events even though some clients may not care
about some of them.  It's the stupidest solution that could possibly
work.  Has never been a problem; clients simply ignore events they don't
need.  If it becomes a problem, we can provide a mechanism to subscribe
to events.  Adds some interface complexity to save a bit of bandwidth.

The part about "conflict due to broadcast" is weak.  To create a
conflict, the interface has to be misdesigned so that events can't be
reliably connected back to their commands.  But then the conflict could
just as well happen between commands issued by a single client.  I think
the valid point here is that synchronous command + event offers an
additional opportunity for screwing up at the command design level.
Perhaps we should do something about it; more on that below.

> - the arguably useless empty reply return

Valid point, but really, really minor.

> For some cases, it makes sense to use that scheme, or a more complete
> one: to have an "handler" associated with an on-going operation, that
> can be queried, modified, cancelled etc (block jobs etc).

Block jobs provide ways to query status and properties, modify
properties, pause, resume, cancel, and initiate synchronous completion.

I suspect that we could use some of these "job control" features for
pretty much any long-running activity.

Migration is such an activity, but uses its own job control interfaces.

We hope to unify both under a more generic "job" abstraction.

>                                                           Also, some
> operations have a global side-effect, in which case that cmd+event
> scheme is right, as all clients are listening for global events.

Yes.

> However, for the simple case where a client want to perform a "local
> context" operation (dump, query etc), QAPI can easily do better
> without resorting to this pattern: it can send the reply when the
> operation is done. That would make QAPI schema, usage and
> documentation more obvious.

On the other hand, it creates a second, independent way to do
asynchronous.

Let me review the design space.

1. Commands are asynchronous

   We still need events to broadcast state changes of interest.

   Commands that complete "quickly" will probably behave synchronously
   anyway, because messing with threads or coroutines would be
   inefficient and needlessly complex then.

   Risk: clients that erroneously rely on synchronous behavior can work
   in simple testing, yet break in entertaining ways under load, or when
   a "quick" command becomes "slow" later on.  Not an argument against
   this design, I'm merely pointing out an opportunity to screw up.  It
   could make evolving de facto synchronous commands into asynchronous
   ones impractical, though.

   We still need job control.  A natural way to do it is to provide job
   control for *any* asynchronous command, i.e. there's no separate
   concept of "jobs", there are just commands that haven't completed,
   yet.  Job control commands simply fail when the asynchronous command
   they target doesn't support them.  I figure only select commands
   support cancellation, for instance.

   Of course, we could also do job control the way we do it now, with a
   separate "job" concept.  You can't evolve a mere command into a job
   then: if you start with a mere command, and it later turns out that
   it can run for a very long time, and you need to be able to cancel
   it, you have to start over: create a new command that creates a job.

   While this feels like a perfectly sensible design to me, we can't
   have it without a massive compatibility break.  Or can we?

2. Commands are synchronous

   This is what we have now.

   Commands that may not complete "quickly" need to be split into a
   command to kick off the job, and an event to signal completion and
   transmit the result.

   If we misjudge "quickly", we have to start over with a new command.
   With 1., we can change the old command from synchronous to
   asynchronous instead, but that risks breaking clients, which may
   force us to start over anyway.

   We currently lack a generic way to connect events back to their
   commands, and instead leave the problem to each command/event pair to
   solve.

   A special case of the command+event pattern is "block jobs".  We'd
   like to evolve them into general job abstraction.  Perhaps any
   (non-deprecated) command/event combo could be an instance of this job
   abstraction.  Such a job abstraction should certainly provide an
   unambiguous connection between event and command.

3. Both

   Existing commands stay synchronous for compatibility.  New commands
   that complete "quickly" are synchronous.  New commands that may not
   complete "quickly" become asynchronous if job control isn't needed,
   else they start jobs.  Having a single job abstraction for them would
   be nice.

   If we misjudge "quickly" or "no need for job control", we have to
   start over with a new command.

   I hope this is a fair description of what you're proposing, please
   correct misunderstandings.

   While I accept your assertion that the commands we can make
   asynchronous would be a bit simpler than their synchronous command +
   event equivalent, I'm afraid adding them to what we have now merely
   moves the complexity around: three kinds of commands (quick,
   command+event, async) instead of two.  Whether that's a net win is
   unclear.  I doubt it.

I'm pretty confident adding a suitable jobs abstraction can make 2. work
reasonably well.

I can't quite see how we can get from here to 1., but perhaps you can
show us.

I strongly dislike the lack of orthogonality in 3.

> The following series implements an async solution, by introducing a
> context associated with a command, it can:
> - defer the return
> - return only to the caller (no broadcasted event)
> - return with the 'id' associated with the call (as originally intended)

Context: 'id' is passed by the client with the command.

As you mentioned elsewhere in this thread, 'id' could conceivably
ambiguous with multiple QMP monitors.  One way to disambiguate is
including a monitor-id that uniquely identifies the monitor where 'id'
comes from.

> - optionnally allow cancellation when the client is gone
> - track on-going qapi command(s) per client

Inching towards job control...

> 1) existing qemu commands can be gradually replaced by async:true
> variants when needed, and by carefully reviewing the concurrency
> aspects.

It's a behavioral change that can conceivably break clients, so
"reviewing the concurrency aspects" includes reviewing all clients, I'm
afraid.  I'm not saying it's impossible, but I'm not exactly looking
forward to it.

>          The async:true commands marshaller helpers are splitted in
> half, the calling and return functions. The command is called with a
> QmpReturn context, that can return immediately or later, using the
> generated return helper.
>
> 2) allow concurrent commands when 'async' is negotiated. If the client
> doesn't support 'async', then the monitor is suspended during command
> execution (events are still sent). Effectively, async commands behave
> like normal commands from client POV in this case, giving full
> backward compatibility.

Aha.  Okay, that makes it more practical.  Converting to async can break
a client even when it claims to support async, but I guess it's less
likely.

> The screendump command is converted to an async:true version to solve
> rhbz#1230527. The command shows basic cancellation (this could be
> extended if needed). HMP remains sync, but it would be worth to make
> it possible to call async:true qapi commands.
>
> The last patch cleans up qmp_dispatch usage to have consistant checks
> between qga & qemu, and simplify QmpClient/parser_feed usage.

I'm afraid I lack the time to review your actual patches in a reasonable
time frame; I really need to hunker down and deliver the QemuOpts / QAPI
work I promised for 2.9, or else my block friends will be sad, Dan
Berrange will be sad, and my manager will be sad, too.  This is
unfortunate.  More so since your proposal has been pending for so long.
My sincere apologies.

Let's at least use the time to discuss the design, in particular how it
relates to the work on evolving block jobs into a generic jobs
abstraction.
