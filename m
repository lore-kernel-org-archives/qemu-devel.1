Received: from eggs.gnu.org ([2001:4830:134:3::10]:38991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4BKe-00008B-DT
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 15:13:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4BKd-0004cQ-08
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 15:13:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1d4BKc-0004c7-NW
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 15:13:30 -0400
Date: Fri, 28 Apr 2017 21:13:21 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170428191321.GF4714@noname.redhat.com>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
	<87o9yv890z.fsf@dusky.pond.sub.org>
	<87lgqpei5d.fsf@dusky.pond.sub.org>
	<20170425102258.GA4615@noname.redhat.com>
	<CAJ+F1CKYUbMo-3TrkNfc+H3tzLUaN00c6sGTxdnPn5qapfA_bA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKYUbMo-3TrkNfc+H3tzLUaN00c6sGTxdnPn5qapfA_bA@mail.gmail.com>
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
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, kraxel@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

Am 28.04.2017 um 17:55 hat Marc-Andr=E9 Lureau geschrieben:
> On Tue, Apr 25, 2017 at 2:23 PM Kevin Wolf <kwolf@redhat.com> wrote:
>=20
> > Am 24.04.2017 um 21:10 hat Markus Armbruster geschrieben:
> > > With 2.9 out of the way, how can we make progress on this one?
> > >
> > > I can see two ways to get asynchronous QMP commands accepted:
> > >
> > > 1. We break QMP compatibility in QEMU 3.0 and convert all long-runn=
ing
> > >    tasks from "synchronous command + event" to "asynchronous comman=
d".
> > >
> > >    This is design option 1 quoted below.  *If* we decide to leave
> > >    compatibility behind for 3.0, *and* we decide we like the
> > >    asynchronous sufficiently better to put in the work, we can do i=
t.
> > >
> > >    I guess there's nothing to do here until we decide on breaking
> > >    compatibility in 3.0.
> > >
> > > 2. We don't break QMP compatibility, but we add asynchronous comman=
ds
> > >    anyway, because we decide that's how we want to do "jobs".
> > >
> > >    This is design option 3 quoted below.  As I said, I dislike its =
lack
> > >    of orthogonality.  But if asynchronous commands help us get jobs
> > >    done, I can bury my dislike.
> >
> > I don't think async commands are attractive at all for doing jobs. I
>=20
> It's still a bit obscure to me what we mean by "jobs".

I guess the best definition that we have is: Image streaming, mirroring,
live backup, live commit and future "similar things".

> feel they bring up more questions that they answer, for example, what
> > happens if libvirt crashes and then reconnects? Which monitor connect=
ion
> > does get the reply for an async command sent on the now disconnected
> > one?
> >
>=20
> The monitor to receive a reply is the one that sent the command (just
> like return today)
>=20
> As explained in the cover letter, an async command may cancel the
> ongoing operation on disconnect.

But that's not what you generally want. You don't want to abort your
backup just because libvirt lost its monitor connection, but qemu should
continue to copy the data, and when libvirt reconnects it should be able
to get back control of this background operation and bring it to
successful completion.

> If there is a global state change, a separate event should be
> broadcasted (no change proposed here)

In a way, the existence of a block job is global state today. Not sure
if this is what you mean, though.

> > We already have a model for doing long-running jobs, and as far as I'=
m
> > aware, it's working and we're not fighting limitations of the design.=
 So
> > what are we even trying to solve here? In the context of jobs, async
> > commands feel like a solution in need of a problem to me.
>=20
> See the cover letter for the 2 main reasons for this proposal. If your
> domain API is fine, you don't have to opt-in and you may continue to us=
e
> the current sync model. However, I believe there is benefit in using th=
is
> work to have a more consitent async API.

I think we need a clear understanding of what the potential use cases
are that could make good use a new infrastructure. We don't generally
add infrastructure if we don't have a concrete idea what its users could
be. I only ruled out that the current users of block jobs are a good fit
for it, but there may be other use cases for which it works great.

If commands can opt-in or opt-out of the new model, consistency isn't a
particularly good argument, though.

> > Things may look a bit different in typically quick, but potentially
> > long-running commands. That is, anything that we currently execute
> > synchronously while holding the BQL, but that involves I/O and could
> > therefore take a while (impacting the performance of the VM) or even
> > block indefinitely.
> >
> > The first problem (we're holding the lock too long) can be addressed
> > by making things async just inside qemu and we don't need to expose
> > the change on the QMP level. The second one (blocking indefinitely)
> > requires
> >
>=20
> That's what I propose as 1)
>=20
>=20
> > being async on the QMP level if we want the monitor to be responsive
> > even if we're using an image on an NFS server that went down.
> >
>=20
> That's the 2)
>=20
> > On the other hand, using the traditional job infrastructure is way
> > over the top if all you want to do is 'query-block', so we need
> > something different for making it async. And if a client
> > disconnects, the 'query-block' result can just be thrown away, it's
> > much simpler than actual jobs.
>=20
> I agree a fully-featured job infrastructure is way over the top, and I
> believe I propose a minimal change to make optionnally some QMP
> commands async.

So are commands like 'query-block' (which are typically _not_ considered
long-running) what you're aiming for with your proposal? This is a case
where I think we could consider the use of async QMP commands, but I
didn't have the impression that this kind of commands was your primary
target.

> > So where I can see advantages for a new async command type is not for
> > converting real long-running commands like block jobs, but only for t=
he
> > typically, but not necessarily quick operations. At the same time it =
is
> > where you're rightfully afraid that the less common case might not
> > receive much testing in management tools.
> >
>=20
> I believe management tools / libvirt will want to use the async variant=
 if
> available. (the sync version is a one-command at a time constrained ver=
sion
> of 'async')

The point here is rather that even async commands degenerate into sync
commands if the management tool doesn't send multiple commands in
parallel.

If sending only a single command at a time is the common case (which
appears quite plausible to me), then race conditions that exist when
multiple commands are used in a rarer case might go unnoticed because
nobody gave the scenario real testing.

> > In the end, I'm unsure whether async commands are a good idea, I can
> > see good arguments for both stances. But I'm almost certain that
> > they are the wrong tool for jobs.
> >
> >
> Well, we already have 'async' commands, they are just hidden. They do
> not use QAPI/QMP facility and lack consistency.
>=20
> This series addresses the problem 1), internal to qemu.
>=20
> And also proposes to replace the idiomatic:
>=20
>     -> { "execute": "do-foo",  "id": 42
> }
>=20
>     <- { "return": {}, "id": 42 }            (this is a dummy useless
> return)
>     (foo is in fact async, you may do other commands here)

I know you like to insist on its uselessness, but no, it's not useless.
It tells the management tool that the background job has successfully
been started and block job management commands can be used with it now.

>=20
>     <- { "event": "FOO_DONE" }     (this is a broadcasted event that ot=
her
> monitor may not know how to deal with, lack of consistency with naming =
for
> various async op, "id" field may be lost, no facilities in generated co=
de
> etc etc)

Are these theoretical concerns or do you see them confirmed with
actually existing commands?

The broadcast is actually a feature, as mentioned above, because it
allows libvirt to reconnect after losing the connection and continue to
control the background operation.

> with a streamlined:
>=20
>     -> { "execute": "do-foo", "id": 42 }
>     (you may do other commands here)
>=20
>=20
>     <- { "return": {}, "id": 42 }       (returned only to the caller)
>     (if there is a global state change, there should also be a FOO_DONE
> event)
>=20
> As pointed out in the cover letter, existing client *have to* deal with
> dispatching unrelated messages when sending commands, because events ma=
y
> come before a return message. So they have facilities to handle async
> replies.
>=20
> But in any case, this streamlined version is behind a "async" QMP
> capability.
>=20
> I have been careful to not expose this change to qemu internal or qemu
> client if they don't want or need it.

The question is whether enough users (command implementations and
clients) need the change to justify maintaining another type of commands
long term. Just not breaking existing users doesn't justify a new
feature, it's only the most basic requirement for it to even be
considered.

Kevin
