Received: from eggs.gnu.org ([2001:4830:134:3::10]:59707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d6Z6H-0002ib-Ub
	for qemu-devel@nongnu.org; Fri, 05 May 2017 05:00:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d6Z6E-0004hy-Ss
	for qemu-devel@nongnu.org; Fri, 05 May 2017 05:00:34 -0400
Received: from mail-lf0-x22c.google.com ([2a00:1450:4010:c07::22c]:34866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1d6Z6E-0004hT-GB
	for qemu-devel@nongnu.org; Fri, 05 May 2017 05:00:30 -0400
Received: by mail-lf0-x22c.google.com with SMTP id j1so21042976lfh.2
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 02:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
	<87mvaszbsu.fsf@dusky.pond.sub.org>
In-Reply-To: <87mvaszbsu.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 05 May 2017 09:00:17 +0000
Message-ID: <CAJ+F1C+MvHoMtaUUWDDmoFJWEXiaK1FxeZ8csqTOEB76WSPDRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, kraxel@redhat.com

Hi

On Thu, May 4, 2017 at 11:02 PM Markus Armbruster <armbru@redhat.com> wrote=
:

> I figure everyone interested has had his say.  Let me try to summarize
> and draw my conclusions.
>
> Commands + events can replace asynchronous commands (they did).
>
> Asynchronous commands cannot replace events, because "interesting" side
> effects of commands need to be broadcast.  Doesn't mean asynchronous
> commands can't make sense for us.  Does mean that we need to address any
> serious flaws in the existing commands + event mechanism even if we
> adopt asynchronous commands.  The cover letter lists multiple flaws,
> which I'll discuss inline.
>
> If an operation satisfies certain conditions, then implementing it as
> asynchronous command provides certain benefits.  If the operation
>
> (C1) does not need to broadcast state changes, including start and end
>      of operation, and
>
> (C2) even the initiating client needs no state change notifications
>      except for end of operation, and
>
> (C3) even that isn't needed when the client loses the connection and
>      reconnects, and
>
> (C4) the operation doesn't have to be examined or controlled while it
>      runs,
>
> then making it an asynchronous command
>
> (B1) saves you the trouble of defining an event together with its link
>      to the command, and
>
> (B2) saves you the trouble of sending the event, and
>
> (B3) saves a bit of QMP traffic, namely the event broadcast.
>
> Letting clients opt into the asynchronousness as this series does
> provides an additional benefit:
>
> (B4) when you find one of your synchronous commands is at times taking
>      too long, you can compatibly evolve it.
>
> We can remove (C3) and (C4) by providing suitable ways to examine and
> control asynchronous commands while they run.
>
> We could remove (C1) and (C2) by sending events, but that would also
> lose pretty much all benefits.
>
> The operation chosen to showcase asynchronous commands is taking
> screenshots.  It obviously satisfies (C1).  I guess for (C2) and (C4) we
> have to assume that it completes "quickly".  I'm willing to buy that.
> (C3) seems pretty dubious to me, however.
>
> The tradeoff to judge is desirability of the benefits vs. cost to get
> them.
>
> Desirability depends on how many commands satisfy these conditions, and
> how much trouble exactly is saved.
>
> A list of commands that is more complete than just "screendump" would
> help with the former.  query- commands that need to gather information
> in ways that could block are among the candidates.
>
> On the latter, I figure (B1) dwarves (B2), (B3) is a relatively minor
> optimization unless proven otherwise, and (B4) is real, but asynchronous
> commands are not the only way to get it; we can equally well evolve
> synchronous commands compatibly into synchronous + event.
>
> The cost is interface and implementation complexity.
>
> Interface complexity increases because we add the concept "asynchronous
> command" and the concept "synchronous or asynchronous command, client's
> choice".  This is my main concern.
>

Since we already have client dispatch of unrelated reply and hidden-async
pattern, this is less of a concern in practice, most of the complexity has
to be already handled.

Note it is a bit simpler for a client to handle a generic async return
rather than various events.


> Implementation complexity isn't prohibitive according to diffstat, but
> it's not neglible, either: with the last six patches peeled off, we get
> some 500 additional lines plus some 300 in tests/.  The last six patches
> put the new infrastructure to work, which takes another 200.  Ways to
> examine and control asynchronous commands while they run would add some
> more, but we don't know how much exactly.
>
> Now let me take a step back: we need to crack the "jobs" problem anyway.
> Merging this series now would in a way add another special case of the
> general case "jobs" before adding the general case.  In other words,
> create more stuff to unify.  I'm afraid that's a bad idea, not least
> since it's an external interface.  I think we should do "jobs" first.
> Once we got at least a prototype, we can
>
> * judge how onerous defining and implementing jobs really is, i.e. have
>   a clearer idea of the potential benefits of asynchronous commands, and
>
> * explore asynchronous commands as a special case of "jobs" optimized
>   for operations that satisfy the conditions above, i.e. get a clearer
>   idea of the *actual* additional implementation complexity.
>

That's what I have been told for over 1.5y :) I would like to know the list
of requirements / features "jobs" would have. I am willing to help
implementing it.

>
> Bottom line:
>
> 1. I still don't want to merge this.
>
> 2. I want us to tackle jobs sooner rather than later.
>
> 3. Once we got at least a jobs prototype, I'm willing to reconsider
>    asynchronous commands implemented as special case of jobs.
>
>
Who is going to work on it?


> One of the most important maintainer duties is saying "no".  It's also
> one of the least fun duties.
>
>
It doesn't sound like a "no" :)


>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Hi,
> >
> > One of initial design goals of QMP was to have "asynchronous command
> > completion" (http://wiki.qemu.org/Features/QAPI). Unfortunately, that
> > goal was not fully achieved, and some broken bits left were removed
> > progressively until commit 65207c59d that removed async command
> > support.
> >
> > Note that qmp events are asynchronous messages, and must be handled
> > appropriately by the client: dispatch both reply and events after a
> > command is sent for example.
> >
> > The benefits of async commands that can be trade-off depending on the
> > requirements are:
> >
> > 1) allow the command handler to re-enter the main loop if the command
> > cannot be handled synchronously, or if it is long-lasting. This is
> > currently not possible and make some bugs such as rhbz#1230527 tricky
> > (see below) to solve.  Furthermore, many QMP commands do IO and could
> > be considered 'slow' and blocking today.
> >
> > 2) allow concurrent commands and events. This mainly implies hanlding
> > concurrency in qemu and out-of-order replies for the client. As noted
> > earlier, a good qmp client already has to handle dispatching of
> > received messages (reply and events).
> >
> > The traditional approach to solving the above in qemu is the following
> > scheme:
> > -> { "execute": "do-foo" }
> > <- { "return": {} }
> > <- { "event": "FOO_DONE" }
> >
> > It has several flaws:
>
> Since asynchronous commands can't replace events outright, all of these
> flaws stay even if we adopt asynchronous commands.  Any serious flaws
> need fixing in other ways.
>
> > - FOO_DONE event has no semantic link with do-foo in the qapi
> >   schema. It is not simple to generalize that pattern when writing
> >   qmp clients. It makes documentation and usage harder.
>
> I consider this serious enough to be worth fixing.  We can either adopt
> suitable naming and documentation conventions, or have commands declare
> the events they can trigger.  I think the latter makes sense only if we
> can flag violations somehow.
>
> > - the FOO_DONE event has no clear association with the command that
> >   triggered it: commands/events have to come up with additional
> >   specific association schemes (ids, path etc)
>
> Existing events that need to be linked certainly have one.  But there is
> no single documented convention for such links.  Well worth fixing; I'd
> love to have a single convention for linking events to commands.
>
> We could then assert that an event's linked command declares the event.
>
> > - FOO_DONE is broadcasted to all clients, but they may have no way to
> >   interprete it or interest in it, or worse it may conflict with their
> >   own commands.
>
> An event that can be "mislinked" by clients is a design flaw that needs
> fixing.  A convention for linking (fix for the previous item) needs to
> avoid this flaw.
>
> > - the arguably useless empty reply return
>
> Useless only if the client doesn't need to know that the (possibly
> long-running) job has been started successfully.
>
> > For some cases, it makes sense to use that scheme, or a more complete
> > one: to have an "handler" associated with an on-going operation, that
> > can be queried, modified, cancelled etc (block jobs etc). Also, some
> > operations have a global side-effect, in which case that cmd+event
> > scheme is right, as all clients are listening for global events.
>
> I'm leaning more and more towards the idea that *any* long-running
> operation implemented as command + event should be made an instance of
> the future "job" abstraction, to give us a *uniform* way to examine and
> control them all.
>
> > However, for the simple case where a client want to perform a "local
> > context" operation (dump, query etc), QAPI can easily do better
> > without resorting to this pattern: it can send the reply when the
> > operation is done. That would make QAPI schema, usage and
> > documentation more obvious.
> >
> > The following series implements an async solution, by introducing a
> > context associated with a command, it can:
> > - defer the return
> > - return only to the caller (no broadcasted event)
> > - return with the 'id' associated with the call (as originally intended=
)
> > - optionnally allow cancellation when the client is gone
> > - track on-going qapi command(s) per client
> >
> > 1) existing qemu commands can be gradually replaced by async:true
> > variants when needed, and by carefully reviewing the concurrency
> > aspects. The async:true commands marshaller helpers are splitted in
> > half, the calling and return functions. The command is called with a
> > QmpReturn context, that can return immediately or later, using the
> > generated return helper.
> >
> > 2) allow concurrent commands when 'async' is negotiated. If the client
> > doesn't support 'async', then the monitor is suspended during command
> > execution (events are still sent). Effectively, async commands behave
> > like normal commands from client POV in this case, giving full
> > backward compatibility.
> >
> > The screendump command is converted to an async:true version to solve
> > rhbz#1230527. The command shows basic cancellation (this could be
> > extended if needed). HMP remains sync, but it would be worth to make
> > it possible to call async:true qapi commands.
> >
> > The last patch cleans up qmp_dispatch usage to have consistant checks
> > between qga & qemu, and simplify QmpClient/parser_feed usage.
>
> --
Marc-Andr=C3=A9 Lureau
