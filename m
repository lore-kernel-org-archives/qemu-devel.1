Received: from eggs.gnu.org ([2001:4830:134:3::10]:47118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d5VGK-0003v8-1l
	for qemu-devel@nongnu.org; Tue, 02 May 2017 06:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d5VGG-00054D-VX
	for qemu-devel@nongnu.org; Tue, 02 May 2017 06:42:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1d5VGG-00052I-Lg
	for qemu-devel@nongnu.org; Tue, 02 May 2017 06:42:28 -0400
Date: Tue, 2 May 2017 12:42:04 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170502104204.GA5805@noname.redhat.com>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
	<87o9yv890z.fsf@dusky.pond.sub.org>
	<87lgqpei5d.fsf@dusky.pond.sub.org>
	<20170425102258.GA4615@noname.redhat.com>
	<CAJ+F1CKYUbMo-3TrkNfc+H3tzLUaN00c6sGTxdnPn5qapfA_bA@mail.gmail.com>
	<20170428191321.GF4714@noname.redhat.com>
	<CAJ+F1CLM9UzgMxNJm3T+Uaog7Ki+6Pu6bO6Z7d4Vyce3FNEj8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CLM9UzgMxNJm3T+Uaog7Ki+6Pu6bO6Z7d4Vyce3FNEj8Q@mail.gmail.com>
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

Am 02.05.2017 um 11:05 hat Marc-Andr=E9 Lureau geschrieben:
> On Fri, Apr 28, 2017 at 11:13 PM Kevin Wolf <kwolf@redhat.com> wrote:
>=20
> > Am 28.04.2017 um 17:55 hat Marc-Andr=E9 Lureau geschrieben:
> > > On Tue, Apr 25, 2017 at 2:23 PM Kevin Wolf <kwolf@redhat.com> wrote=
:
> > >
> > > > Am 24.04.2017 um 21:10 hat Markus Armbruster geschrieben:
> > > > > With 2.9 out of the way, how can we make progress on this one?
> > > > >
> > > > > I can see two ways to get asynchronous QMP commands accepted:
> > > > >
> > > > > 1. We break QMP compatibility in QEMU 3.0 and convert all
> > long-running
> > > > >    tasks from "synchronous command + event" to "asynchronous
> > command".
> > > > >
> > > > >    This is design option 1 quoted below.  *If* we decide to lea=
ve
> > > > >    compatibility behind for 3.0, *and* we decide we like the
> > > > >    asynchronous sufficiently better to put in the work, we can =
do it.
> > > > >
> > > > >    I guess there's nothing to do here until we decide on breaki=
ng
> > > > >    compatibility in 3.0.
> > > > >
> > > > > 2. We don't break QMP compatibility, but we add asynchronous co=
mmands
> > > > >    anyway, because we decide that's how we want to do "jobs".
> > > > >
> > > > >    This is design option 3 quoted below.  As I said, I dislike =
its
> > lack
> > > > >    of orthogonality.  But if asynchronous commands help us get =
jobs
> > > > >    done, I can bury my dislike.
> > > >
> > > > I don't think async commands are attractive at all for doing jobs=
. I
> > >
> > > It's still a bit obscure to me what we mean by "jobs".
> >
> > I guess the best definition that we have is: Image streaming, mirrori=
ng,
> > live backup, live commit and future "similar things".
>=20
> What does it mean in terms of QAPI/QMP protocol ? If I need to write a =
new
> "job" (for something else than block op), is there some doc or guidelin=
e?

Well, we don't have a generic job API yet, so there can't be one. The
problem with using the current block job API for other things is that
block jobs are tied to one owner BlockDriverState (which made sense for
the very first block job, but already since the second one it doesn't
really match reality any more, because more than one image file is
involved in the other block job types).

John is working on generalising things so that we get a job API that can
be used for more than just block jobs.

> > > feel they bring up more questions that they answer, for example, wh=
at
> > > > happens if libvirt crashes and then reconnects? Which monitor
> > connection
> > > > does get the reply for an async command sent on the now disconnec=
ted
> > > > one?
> > > >
> > >
> > > The monitor to receive a reply is the one that sent the command (ju=
st
> > > like return today)
> > >
> > > As explained in the cover letter, an async command may cancel the
> > > ongoing operation on disconnect.
> >
> > But that's not what you generally want. You don't want to abort your
> > backup just because libvirt lost its monitor connection, but qemu sho=
uld
> > continue to copy the data, and when libvirt reconnects it should be a=
ble
> > to get back control of this background operation and bring it to
> > successful completion.
>=20
> I said "may", and I make a difference between "local" (to the client) a=
nd
> "global" (to qemu) operation.

The "may" doesn't help you because it's your only option as long as you
don't have a mechanism to attach an already running command to a new
monitor.

But the local vs. global thing that you detailed below makes sense and
now I think we were really talking past each other. Block jobs are very
much global, and so we actually agree that this proposal has nothing to
do with the operations that are currently block jobs. I guess what I'm
really arguing against then is what Markus made of your proposal in his
reply (which is when I got CCed).

> > > > On the other hand, using the traditional job infrastructure is wa=
y
> > > > over the top if all you want to do is 'query-block', so we need
> > > > something different for making it async. And if a client
> > > > disconnects, the 'query-block' result can just be thrown away, it=
's
> > > > much simpler than actual jobs.
> > >
> > > I agree a fully-featured job infrastructure is way over the top, an=
d I
> > > believe I propose a minimal change to make optionnally some QMP
> > > commands async.
> >
> > So are commands like 'query-block' (which are typically _not_ conside=
red
> > long-running) what you're aiming for with your proposal? This is a ca=
se
> > where I think we could consider the use of async QMP commands, but I
> > didn't have the impression that this kind of commands was your primar=
y
> > target.
> >
>=20
> Typically, I would like to improve the case described in the cover
> letter where we have:
>=20
> -> { "execute": "do-foo" }
> <- { "return": {} }
> <- { "event": "FOO_DONE" }
>=20
> Let's call this an "hidden-async" (I will refer to this pattern later).

This is not a good description of what you really seem to be after,
because the hidden-async pattern is what is used for real long-running,
global impact commands like the block jobs, too.

You only seem to want to replace it if 'do-foo' is a "local" operation,
and then that's much more agreeable than if we were to apply it to every
operation, including "global" ones.

> And do instead:
>=20
> -> { "execute": "do-foo" }
> <- { "return": {} }
>=20
> (I won't repeat the flaws of the current status quo here, see cover and
> thread)
>=20
> But any blocking (even shortly) operation could also benefit from this
> series by using the async variant to allow reentering the loop. This
> is the 1). I suppose 'query-block' is a good candidate, and typically
> could cancel itself it the client is gone.
>=20
> 2) is an extra, if the client supports concurrent commands.

I believe allowing 1) is a good idea anyway. Whether or not we need 2)
is a different discussion, but given the scope of the proposal that I
understand now, possibly not one in which I need to participate.

> > >     <- { "event": "FOO_DONE" }     (this is a broadcasted event tha=
t
> > other
> > > monitor may not know how to deal with, lack of consistency with nam=
ing
> > for
> > > various async op, "id" field may be lost, no facilities in generate=
d code
> > > etc etc)
> >
> > Are these theoretical concerns or do you see them confirmed with
> > actually existing commands?
> >
> I think existing commands using this event pattern are all global. The
> problems raise if we start using events for local commands (such as
> screendump, dump-guest-memory, query-* etc), then various peers may
> conflict the completion event from a different client command.

So what you're really trying is not to replace existing hidden-async
patterns (which are for global operations, so events are wanted), but
to avoid introducing the pattern for new, local operations.

I think this is one of the most important points where the
misunderstandings came from.

> Your concern regarding async testing exist at a different protocol
> level when commands use the cmd + event pattern (hidden-async),
> regardless of this proposal.

This was Markus' concern, I was just trying to explain how I understand
it. And I still think it's a valid concern, but you're right that cmd +
event isn't much different. It's mostly the comparison between sync and
either of the async models that is interesting here.

Kevin
