Received: from eggs.gnu.org ([2001:4830:134:3::10]:52552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpxg7-0003yp-S0
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:21:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpxfz-0006xm-1Q
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:21:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dpxfy-0006wJ-No
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:21:02 -0400
Date: Thu, 7 Sep 2017 15:20:47 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170907142046.GQ2098@work-vm>
References: <20170906094846.GA2215@work-vm> <20170906104603.GK15510@redhat.com>
	<20170906104850.GB2215@work-vm> <20170906105414.GL15510@redhat.com>
	<20170906105704.GC2215@work-vm> <20170906110629.GM15510@redhat.com>
	<20170906113157.GD2215@work-vm> <20170906115428.GP15510@redhat.com>
	<20170907081341.GA23040@pxdev.xzpeter.org>
	<87inguaclr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87inguaclr.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [RFC v2 0/8] monitor: allow per-monitor thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

* Markus Armbruster (armbru@redhat.com) wrote:
> Peter Xu <peterx@redhat.com> writes:
>=20
> > On Wed, Sep 06, 2017 at 12:54:28PM +0100, Daniel P. Berrange wrote:
> >> On Wed, Sep 06, 2017 at 12:31:58PM +0100, Dr. David Alan Gilbert wrote:
> >> > * Daniel P. Berrange (berrange@redhat.com) wrote:
> >> > > This does imply that you need a separate monitor I/O processing, f=
rom the
> >> > > command execution thread, but I see no need for all commands to su=
ddenly
> >> > > become async. Just allowing interleaved replies is sufficient from=
 the
> >> > > POV of the protocol definition. This interleaving is easy to handl=
e from
> >> > > the client POV - just requires a unique 'serial' in the request by=
 the
> >> > > client, that is copied into the reply by QEMU.
> >> >=20
> >> > OK, so for that we can just take Marc-Andr=E9's syntax and call it '=
id':
> >> >   https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg03634.html
> >> >=20
> >> > then it's upto the caller to ensure those id's are unique.
> >>=20
> >> Libvirt has in fact generated a unique 'id' for every monitor command
> >> since day 1 of supporting QMP.
> >>=20
> >> > I do worry about two things:
> >> >   a) With this the caller doesn't really know which commands could be
> >> >   in parallel - for example if we've got a recovery command that's
> >> >   executed by this non-locking thread that's OK, we expect that
> >> >   to be doable in parallel.  If in the future though we do
> >> >   what you initially suggested and have a bunch of commands get
> >> >   routed to the migration thread (say) then those would suddenly
> >> >   operate in parallel with other commands that we're previously
> >> >   synchronous.
> >>=20
> >> We could still have an opt-in for async commands. eg default to execut=
ing
> >> all commands in the main thread, unless the client issues an explicit
> >> "make it async" command, to switch to allowing the migration thread to
> >> process it async.
> >>=20
> >>  { "execute": "qmp_allow_async",
> >>    "data": { "commands": [
> >>        "migrate_cancel",
> >>    ] } }
> >>=20
> >>=20
> >>  { "return": { "commands": [
> >>        "migrate_cancel",
> >>    ] } }
> >>=20
> >> The server response contains the subset of commands from the request
> >> for which async is supported.
> >>=20
> >> That gives good negotiation ability going forward as we incrementally
> >> support async on more commands.
> >
> > I think this goes back to the discussion on which design we'd like to
> > choose.  IMHO the whole async idea plus the per-command-id is indeed
> > cleaner and nicer, and I believe that can benefit not only libvirt,
>=20
> The following may be a bit harsh in places.  I apologize in advance.  A
> better writer than me wouldn't have to resort to that.  I've tried a few
> times to make my point that "async QMP" is neither necessary nor
> sufficient for monitor availability, but apparently without luck, since
> there's still talk like it was.  I hope this attempt will work.
>=20
> > but also other QMP users.  The problem is, I have no idea how long
> > it'll take to let us have such a feature - I believe that will include
> > QEMU and Libvirt to both support that.  And it'll be a pity if the
> > postcopy recovery cannot work only because we cannot guarantee a
> > stable monitor.
> >
> > I'm curious whether there are other requirements (besides postcopy
> > recovery) that would want an always-alive monitor to run some
> > lock-free commands?  If there is, I'd be more inclined to first
> > provide a work-around solution like "-qmp-lockfree", and we can
> > provide a better solution afterwards until when the whole async QMP
> > work ready.
>=20
> Yes, there are other requirements for "async QMP", and no, "async QMP"
> isn't a solution, but at best a part of a solution.
>=20
> Before I talk about QMP requirements, I need to ask a whole raft of
> questions, because so far this thread feels like dreaming up grand
> designs with only superficial understanding of the subject matter.

I think Dan's suggestions are pretty good; while I prefered Peter's
implementation, I think Dan's will work fine and if that's good for
libvirt I'm OK with that.  I think we have a reasonable understanding
of the problem.

> Quite possibly because *my* understanding is superficial.  If yours
> isn't, great!  Go answer my questions :)
>=20
> The root problem are main loop hangs.  QMP monitor hangs are merely a
> special case.
>=20
> The main loop should not hang.  We've always violated that design
> assumption in places, e.g. in monitor commands that write to disk, and
> thus can hang indefinitely with NFS.  Post-copy adds more violations, as
> Stefan pointed out.
>=20
> I can't say whether solving the special case "QMP monitor hangs" without
> also solving "main loop hangs" is useful.  A perfectly available QMP
> monitor buys you nothing if it feeds a command queue that isn't being
> emptied because its consumers all hang.

Correct.

> So, what exactly is going to drain the command queue?  If there's more
> than one consumer, how exactly are commands from the queue dispatched to
> the consumers?

The idea is to have 2 extra threads:
   a) An IO thread
   b) A thread that deals with non-blocking commands
   the existing main thread.

   The IO thread dispatches most commands to the main thread
but doesn't wait for the response.  When responses arrive it forwards
the response back.
   A class of commands is forwarded to the non-blocking command thread.

   More threads may be added in the future with some set of the commands
being moved off the main thread to these other threads.  Eventually
maybe no commands would be handled on the main thread.

> What are the "no hang" guarantees (if any) and conditions for each of
> these consumers?

Commands sent to the main thread are as they are now.
The non-blocking-command thread *shall not block*, it will not access
guest memory, it wont take any lock that is taken by any other thread
that can block on the main thread or main memory.  Commands that run
on it can:
   a) Access state that can be read atomically - e.g.=20
      'info status'
   b) Store parameters and then wake another thread
   c) Issue a non-blocking system call.


  In the case of postcopy recovery I see a command issued which starts
the new migration stream;  the command parses the path and makes sure
it's valid, and then stores it and kicks a recovery thread.
  In the case of a COLO failover I'd see something that does a
shutdown(2) on the migration stream.

> We can have any number of QMP monitors today.  Would each of them feed
> its own queue?  Would they all feed a shared queue?

I see two queues; one which is the set of commands being forwarded
to the main thread, the other is the set of commands being forwarded
to the non-blocking thread.

> How exactly is opt-in asynchronous to work?  Per QMP monitor?  Per
> command?

The command that Dan suggested is the opt-in; I think it's per monitor;
now we're starting to get a bit more fuzzy.

> What does it mean when an asynchronous command follows a synchronous
> command in the same QMP monitor?  I would expect the synchronous command
> to complete before the asynchronous command, because that's what
> synchronous means, isn't it?  To keep your QMP monitor available, you
> then must not send synchronous commands that can hang.

Once you opt-in, all commands operate in a semi-asynchronous fashion;
that is they don't block the IO thread, but at the same time there's
never any more than one command outstanding on any one thread.
You can issue any command you like; one command at a time waiting
for the response with the knowledge that you can then always
issue one of the non-blocking-commands after it.

> How can we determine whether a certain synchronous command can hang?
> Note that with opt-in async, *all* commands are also synchronous
> commands.

You regard all commands as blockable unless told otherwise.  The result
=66rom Dan's command is a list of truly async commands.

> In short, explain to me how exactly you plan to ensure that certain QMP
> commands (such as post-copy recovery) can always "get through", in the
> presence of multiple monitors, hanging main loop, hanging synchronous
> commands, hanging whatever-else-can-now-hang-in-this-post-copy-world.

Have I missed anything?

>=20
> Now let's talk about QMP requirements.
>=20
> Any addition to QMP must consider what exists already.

Yes.

> You may add more of the same.

Yes

> You may generalize existing stuff.

Yes

> You may change existing stuff if you have sufficient reason, subject to
> backward compatibility constraints.

Yes

> But attempts to add new ways to do the same old stuff without properly
> integrating the existing ways are not going to fly.

Agreed; that's why I'm following Dan's recommendations.

> In particular, any new way to start some job, monitor and control it
> while it lives, get notified about its state changes and so forth must
> integrate the existing ways.  These include block jobs (probably the
> most sophisticated of the lot), migration, dump-guest-memory, and
> possibly more.  They all work the same way: synchronous command to kick
> off the job, more synchronous commands to monitor and control, events to
> notify.  They do differ in detail.

And that's why we have the rule that all existing commands go onto the
main thread and only one of those is outstanding at a time.  That way
the actual behaviour of the existing commands doesn't change at all -
however you do require the 'id' field in the command to put into the
response so that you can distinguish the response of a command from each
thread.  Even if you enable async, if you don't use any of the
non-blocking commands the stream is just the same - send a command, get
a response, send a command, get a response....

> Asynchronous commands are a new way to do this.  When you only need to
> be notified on "done", and don't need to monitor / control, they fit the
> bill quite neatly.
>=20
> However, we can't just ignore the cases where we need more than that!
> For those, we want a single generic solution instead of the several ad
> hoc solutions we have now.
>=20
> If we add asynchronous commands *now*, and for simple cases only, we add
> yet another special case for a future generic solution to integrate.
> I'm not going to let that happen.
>=20
> I figure the closest to a generic solution we have is block jobs.
> Perhaps a generic solution could be had by abstracting away the "block"
> from "block jobs", leaving just "jobs".

I don't know block jobs well enough to answer that.
I would suggest you could add a thread for asynchronous commands
and you could shuffle commands onto that thread as and when you feel
like it.

> Another approach is generalizing the asynchronous command proposal to
> fully cover the not-so-simple cases.
>=20
> If you'd rather want to make progress on monitor availability without
> cracking the "jobs" problem, you're in luck!  Use your license to "add
> more of the same": synchronous command to start a job, query to monitor,
> event to notify. =20
>=20
> If you insist on tying your monitor availability solution to
> asynchronous commands, then I'm in luck!  I just found volunteers to
> solve the "jobs" problem for me.

I'm looking for minimal change here while keeping the door open for
the future, if there's anything you think we should do to make that
easy then tell us - but I'd rather this didn't turn into a 'fix all
known monitor problems' because frankly we may as well give up now.
So i don't see this as solving the 'jobs' problem, but if we can
do something to make it easier to solve in the future then lets do it.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
