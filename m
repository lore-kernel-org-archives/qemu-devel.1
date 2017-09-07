Received: from eggs.gnu.org ([2001:4830:134:3::10]:47303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpwPI-0007Lk-1i
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:59:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpwPC-0003gZ-NV
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:59:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dpwPC-0003fr-E4
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:59:38 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
	<20170829110357.GG3783@redhat.com> <20170906094846.GA2215@work-vm>
	<20170906104603.GK15510@redhat.com> <20170906104850.GB2215@work-vm>
	<20170906105414.GL15510@redhat.com> <20170906105704.GC2215@work-vm>
	<20170906110629.GM15510@redhat.com> <20170906113157.GD2215@work-vm>
	<20170906115428.GP15510@redhat.com>
	<20170907081341.GA23040@pxdev.xzpeter.org>
Date: Thu, 07 Sep 2017 14:59:28 +0200
In-Reply-To: <20170907081341.GA23040@pxdev.xzpeter.org> (Peter Xu's message of
	"Thu, 7 Sep 2017 16:13:41 +0800")
Message-ID: <87inguaclr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 0/8] monitor: allow per-monitor thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> On Wed, Sep 06, 2017 at 12:54:28PM +0100, Daniel P. Berrange wrote:
>> On Wed, Sep 06, 2017 at 12:31:58PM +0100, Dr. David Alan Gilbert wrote:
>> > * Daniel P. Berrange (berrange@redhat.com) wrote:
>> > > This does imply that you need a separate monitor I/O processing, fro=
m the
>> > > command execution thread, but I see no need for all commands to sudd=
enly
>> > > become async. Just allowing interleaved replies is sufficient from t=
he
>> > > POV of the protocol definition. This interleaving is easy to handle =
from
>> > > the client POV - just requires a unique 'serial' in the request by t=
he
>> > > client, that is copied into the reply by QEMU.
>> >=20
>> > OK, so for that we can just take Marc-Andr=C3=A9's syntax and call it =
'id':
>> >   https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg03634.html
>> >=20
>> > then it's upto the caller to ensure those id's are unique.
>>=20
>> Libvirt has in fact generated a unique 'id' for every monitor command
>> since day 1 of supporting QMP.
>>=20
>> > I do worry about two things:
>> >   a) With this the caller doesn't really know which commands could be
>> >   in parallel - for example if we've got a recovery command that's
>> >   executed by this non-locking thread that's OK, we expect that
>> >   to be doable in parallel.  If in the future though we do
>> >   what you initially suggested and have a bunch of commands get
>> >   routed to the migration thread (say) then those would suddenly
>> >   operate in parallel with other commands that we're previously
>> >   synchronous.
>>=20
>> We could still have an opt-in for async commands. eg default to executing
>> all commands in the main thread, unless the client issues an explicit
>> "make it async" command, to switch to allowing the migration thread to
>> process it async.
>>=20
>>  { "execute": "qmp_allow_async",
>>    "data": { "commands": [
>>        "migrate_cancel",
>>    ] } }
>>=20
>>=20
>>  { "return": { "commands": [
>>        "migrate_cancel",
>>    ] } }
>>=20
>> The server response contains the subset of commands from the request
>> for which async is supported.
>>=20
>> That gives good negotiation ability going forward as we incrementally
>> support async on more commands.
>
> I think this goes back to the discussion on which design we'd like to
> choose.  IMHO the whole async idea plus the per-command-id is indeed
> cleaner and nicer, and I believe that can benefit not only libvirt,

The following may be a bit harsh in places.  I apologize in advance.  A
better writer than me wouldn't have to resort to that.  I've tried a few
times to make my point that "async QMP" is neither necessary nor
sufficient for monitor availability, but apparently without luck, since
there's still talk like it was.  I hope this attempt will work.

> but also other QMP users.  The problem is, I have no idea how long
> it'll take to let us have such a feature - I believe that will include
> QEMU and Libvirt to both support that.  And it'll be a pity if the
> postcopy recovery cannot work only because we cannot guarantee a
> stable monitor.
>
> I'm curious whether there are other requirements (besides postcopy
> recovery) that would want an always-alive monitor to run some
> lock-free commands?  If there is, I'd be more inclined to first
> provide a work-around solution like "-qmp-lockfree", and we can
> provide a better solution afterwards until when the whole async QMP
> work ready.

Yes, there are other requirements for "async QMP", and no, "async QMP"
isn't a solution, but at best a part of a solution.

Before I talk about QMP requirements, I need to ask a whole raft of
questions, because so far this thread feels like dreaming up grand
designs with only superficial understanding of the subject matter.
Quite possibly because *my* understanding is superficial.  If yours
isn't, great!  Go answer my questions :)

The root problem are main loop hangs.  QMP monitor hangs are merely a
special case.

The main loop should not hang.  We've always violated that design
assumption in places, e.g. in monitor commands that write to disk, and
thus can hang indefinitely with NFS.  Post-copy adds more violations, as
Stefan pointed out.

I can't say whether solving the special case "QMP monitor hangs" without
also solving "main loop hangs" is useful.  A perfectly available QMP
monitor buys you nothing if it feeds a command queue that isn't being
emptied because its consumers all hang.

So, what exactly is going to drain the command queue?  If there's more
than one consumer, how exactly are commands from the queue dispatched to
the consumers?

What are the "no hang" guarantees (if any) and conditions for each of
these consumers?

We can have any number of QMP monitors today.  Would each of them feed
its own queue?  Would they all feed a shared queue?

How exactly is opt-in asynchronous to work?  Per QMP monitor?  Per
command?

What does it mean when an asynchronous command follows a synchronous
command in the same QMP monitor?  I would expect the synchronous command
to complete before the asynchronous command, because that's what
synchronous means, isn't it?  To keep your QMP monitor available, you
then must not send synchronous commands that can hang.

How can we determine whether a certain synchronous command can hang?
Note that with opt-in async, *all* commands are also synchronous
commands.

In short, explain to me how exactly you plan to ensure that certain QMP
commands (such as post-copy recovery) can always "get through", in the
presence of multiple monitors, hanging main loop, hanging synchronous
commands, hanging whatever-else-can-now-hang-in-this-post-copy-world.


Now let's talk about QMP requirements.

Any addition to QMP must consider what exists already.

You may add more of the same.

You may generalize existing stuff.

You may change existing stuff if you have sufficient reason, subject to
backward compatibility constraints.

But attempts to add new ways to do the same old stuff without properly
integrating the existing ways are not going to fly.

In particular, any new way to start some job, monitor and control it
while it lives, get notified about its state changes and so forth must
integrate the existing ways.  These include block jobs (probably the
most sophisticated of the lot), migration, dump-guest-memory, and
possibly more.  They all work the same way: synchronous command to kick
off the job, more synchronous commands to monitor and control, events to
notify.  They do differ in detail.

Asynchronous commands are a new way to do this.  When you only need to
be notified on "done", and don't need to monitor / control, they fit the
bill quite neatly.

However, we can't just ignore the cases where we need more than that!
For those, we want a single generic solution instead of the several ad
hoc solutions we have now.

If we add asynchronous commands *now*, and for simple cases only, we add
yet another special case for a future generic solution to integrate.
I'm not going to let that happen.

I figure the closest to a generic solution we have is block jobs.
Perhaps a generic solution could be had by abstracting away the "block"
from "block jobs", leaving just "jobs".

Another approach is generalizing the asynchronous command proposal to
fully cover the not-so-simple cases.

If you'd rather want to make progress on monitor availability without
cracking the "jobs" problem, you're in luck!  Use your license to "add
more of the same": synchronous command to start a job, query to monitor,
event to notify.=20=20

If you insist on tying your monitor availability solution to
asynchronous commands, then I'm in luck!  I just found volunteers to
solve the "jobs" problem for me.
