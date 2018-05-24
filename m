Received: from eggs.gnu.org ([2001:4830:134:3::10]:39422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fLlWX-000318-DI
	for qemu-devel@nongnu.org; Thu, 24 May 2018 04:23:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fLlWT-0003CZ-Bp
	for qemu-devel@nongnu.org; Thu, 24 May 2018 04:23:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39710 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fLlWT-0003CP-6w
	for qemu-devel@nongnu.org; Thu, 24 May 2018 04:22:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CDAC2402679B
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 08:22:56 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180412061108.10875-1-peterx@redhat.com>
	<87sh6iixvp.fsf@dusky.pond.sub.org> <20180523090450.GC2540@xz-mi>
	<87vabeecrg.fsf@dusky.pond.sub.org> <20180524042906.GE756@xz-mi>
Date: Thu, 24 May 2018 10:22:48 +0200
In-Reply-To: <20180524042906.GE756@xz-mi> (Peter Xu's message of "Thu, 24 May
	2018 12:29:06 +0800")
Message-ID: <87bmd58ntz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3] monitor: let cur_mon be per-thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, "Dr .
	David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> On Wed, May 23, 2018 at 03:13:07PM +0200, Markus Armbruster wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Wed, May 23, 2018 at 10:23:22AM +0200, Markus Armbruster wrote:
>> >> Peter Xu <peterx@redhat.com> writes:
>> >> 
>> >> > In the future the monitor iothread may be accessing the cur_mon as
>> >> > well (via monitor_qmp_dispatch_one()).  Before we introduce a real
>> >> > Out-Of-Band command,
>> >> 
>> >> Uh, inhowfar are the commands marked allow-oob: true now not real?
>> >> These are migrate-recover, migrate-pause, x-oob-test.
>> >
>> > x-oob-test is unreal; the rest are real.
>> 
>> Sounds like the commit message needs tweaking then.
>
> Ah yes.  When I drafted this patch we don't really have the other two
> commands yet.  They are there only after the postcopy recovery series.
>
> Do you want me to repost one?

Repost is fine, but I'm also happy to edit commit messages when I apply
to qapi-next.

>> >> Aside: having x-oob-test in QEMU proper is awful.  Is there really no
>> >> way around it?
>> >
>> > I tried hard to think of a way but failed.  I need to let the
>> > dispatcher stuck for a while, nothing can guarantee that but a lock.
>> 
>> Paraphrasing, to make sure I understand:
>> 
>> 0. We want to test an OOB command can "overtake" commands that hog the
>>    monitor.
>
> Here to be more explicit - to test an OOB command can overtake
> "non-OOB" commands that hog the monitor.
>
> Note that one OOB command still cannot overtake another OOB command
> now.  Since we are sharing the same thread for all the monitors, even
> we can't let monitor A's OOB command overtake another OOB command of
> monitor B.  After all, all OOB commands are run in the parser, and now
> QMP only has one thread to do the parsing.

Understood.

OOB commands must complete quicky.  Their code is effectively realtime
code.

>> 
>> 1. We need a command to *reliably* take long enough for us to issue an
>>    OOB command.  Since OOB commands must not hog the monitor, this
>>    should be a non-OOB command.
>> 
>> 2. We need an OOB command to do the overtaking.
>> 
>> 3. We'd very much like to make the overaken command complete quickly
>>    after the OOB command overtook it, to keep the test quick.
>> 
>> Correct?
>
> For the rest, I think yes.

Good :)

>> Your solution uses x-oob-test both for 1. and 2.  Problematic, because
>> x-oob-test is OOB, yet does something an OOB command must not do: block
>> on a lock.  Fixable.
>
> Yes if to be strict it is.  :)
>
> Before all the rest, I want to make sure we have the same
> understanding on OOB: when we say "one command is an OOB command" it
> does not mean it'll always be executed in OOB fasion.  Let's take
> x-oob-test for example: although it is an OOB command, it means that
> it can be run out of band, however it can also be run in band too,
> which depends on whether we have "control": { "run-oob": true } in the
> "execute" command.  Actually in our OOB test the locking operation is
> done in band, only the unlocking is done out of band.  Quote from
> function test_qmp_oob():
>
>     qtest_async_qmp(qts,
>                     "{ 'execute': 'x-oob-test',"
>                     "  'arguments': { 'lock': true }, "
>                     "  'id': 'lock-cmd'}");
>     qtest_async_qmp(qts,
>                     "{ 'execute': 'x-oob-test', "
>                     "  'arguments': { 'lock': false }, "
>                     "  'control': { 'run-oob': true }, "
>                     "  'id': 'unlock-cmd' }");

I missed that detail.  There is nothing to fix, actually.

> If we want to be strict on this, we can split x-oob-test into:
>
> - x-oob-test-lock: this can be a non-OOB command
> - x-oob-test-unlock: this must be an OOB command
>
> Then the second x-oob-test-unlock will satisfy our "strict
> requirement" on OOB command.

Not necessary, your hack is fine as is.

Having a real OOB command that must not be executed with run-oob: true
in some cases would not be fine.

> Here though I would still prefer to keep the x-oob-test command,
> because the strict rules are for people who are not familiar with OOB.
> For us, we are very sure that it will work for us (or say, we should
> never call the lock operation with OOB context).  It might be an
> overkill to introduce two test commands for this.

Agreed.

>> > was using migration before to make sure dispatcher won't quite very
>> > soon, but we have problems there since:
>> >
>> > - some architectures may not even have RAM, so snapshot of those
>> >   platforms can still be super fast;
>> >
>> > - even if we make sure RAM is big, the time will depend on the speed
>> >   of system, say, what if the test environment is running on RAM-disk
>> >   which is still super fast even to dump the whole RAM onto disk?  As
>> >   a conclusion - time based command won't work, because time is always
>> >   a relative value, which can be affected by OS scheduler and system
>> >   environments.
>> 
>> Hmm, using migration is actually a cute idea.  But making it take long
>> enough (1.) is unreliable, as you found.  Also, we can't make it
>> complete quickly (3.).
>
> Agreed.
>
>> 
>> > When there is better suggestion we can remove x-oob-test, but I can't
>> > see any so far.
>> 
>> The bit we actually need is having a command block on something we
>> control.  You picked a QemuSemaphore, internal to QEMU.  What about some
>> blocking system call?  Here's my idea:
>> 
>> 0. Create a named pipe with mkfifo(1)
>> 
>> 1. Issue some (non-OOB) QMP command that opens this pipe.  open()
>>    blocks.
>> 
>> 2. Issue the OOB-command, verify it completes
>> 
>> 3. If the non-OOB command writes to the pipe, suck the pipe dry, say
>>    with cat pipe | >/dev/null.  If it reads, give it something to read,
>>    say echo >pipe.
>> 
>> To make 3. complete quickly with a command that writes, you need one
>> that writes only a small amount of data.  Candidates: memsave, pmemsave,
>> screendump.
>
> I am not sure I have fully understood above, please correct me if I
> haven't.
>
> IMHO they are just similar ideas just like when we use semaphores.
> Semaphores are QEMU internal, but underneath that it'll also do
> syscalls (I believe we are using futex() syscalls for semaphores,
> though that should be in libc code not QEMU).  I believe fifos can be
> as easy to implement as semaphores, but I don't see much difference
> here - IMHO fifo just use its own way to do similar thing.  On the
> kernel side, both of them will basically do:
>
> (1) schedule() self process out to wait for the event
> (2) wake_up() by another process
>
> From that point of view, they are same to me.

The difference is we don't need a special command just for the test.

> In other words, since we don't allow OOB-capable command handlers to
> take risky locks, meanwhile we should also expand that idea further
> into any operation that might block for some time.  Reading a fifo
> here is the same as taking a risky lock - we need to make sure the
> fifo read won't block for long or we should never do that in OOB
> command handlers.

Absolutely.  Any code that can run in an OOB command is realtime code,
and that means it must not block for an indeterminate time.  Synchronous
read() is right out.

>> >> >                      let's convert the cur_mon variable to be a
>> >> > per-thread variable to make sure there won't be a race between threads.
>> >> >
>> >> > Note that thread variables are not initialized to a valid value when new
>> >> > thread is created.  However for our case we don't need to set it up,
>> >> > since the cur_mon variable is only used in such a pattern:
>> >> >
>> >> >   old_mon = cur_mon;
>> >> >   cur_mon = xxx;
>> >> >   (do something, read cur_mon if necessary in the stack)
>> >> >   cur_mon = old_mon;
>> >> >
>> >> > It plays a role as stack variable, so no need to be initialized at all.
>> >> > We only need to make sure the variable won't be changed unexpectedly by
>> >> > other threads.
>> >> 
>> >> Do we plan to keep switching cur_mon forever?  Or do we intend to work
>> >> towards a 1:1 association between Monitor struct and monitor thread?
>> >
>> > I still don't see a good way to remove the cur_mon switching... E.g.,
>> > in qmp_human_monitor_command() we'll switch no matter what.
>> 
>> That one's a hack.  We can make exceptions for hacks.  Where else do we
>> switch?
>
> Yeah, the major one should be monitor_qmp_dispatch_one().  If we can
> have one thread per monitor, it seems to be good we can at least omit
> the switching for this one.

Yes, please.
