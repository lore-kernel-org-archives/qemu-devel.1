Received: from eggs.gnu.org ([2001:4830:134:3::10]:53549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fLTZw-0002ml-8o
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:13:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fLTZt-0007VK-Ft
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:13:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43432 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fLTZt-0007Uv-Bu
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:13:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51B018182D27
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 13:13:16 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180412061108.10875-1-peterx@redhat.com>
	<87sh6iixvp.fsf@dusky.pond.sub.org> <20180523090450.GC2540@xz-mi>
Date: Wed, 23 May 2018 15:13:07 +0200
In-Reply-To: <20180523090450.GC2540@xz-mi> (Peter Xu's message of "Wed, 23 May
	2018 17:04:50 +0800")
Message-ID: <87vabeecrg.fsf@dusky.pond.sub.org>
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
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> On Wed, May 23, 2018 at 10:23:22AM +0200, Markus Armbruster wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > In the future the monitor iothread may be accessing the cur_mon as
>> > well (via monitor_qmp_dispatch_one()).  Before we introduce a real
>> > Out-Of-Band command,
>> 
>> Uh, inhowfar are the commands marked allow-oob: true now not real?
>> These are migrate-recover, migrate-pause, x-oob-test.
>
> x-oob-test is unreal; the rest are real.

Sounds like the commit message needs tweaking then.

>> Aside: having x-oob-test in QEMU proper is awful.  Is there really no
>> way around it?
>
> I tried hard to think of a way but failed.  I need to let the
> dispatcher stuck for a while, nothing can guarantee that but a lock.

Paraphrasing, to make sure I understand:

0. We want to test an OOB command can "overtake" commands that hog the
   monitor.

1. We need a command to *reliably* take long enough for us to issue an
   OOB command.  Since OOB commands must not hog the monitor, this
   should be a non-OOB command.

2. We need an OOB command to do the overtaking.

3. We'd very much like to make the overaken command complete quickly
   after the OOB command overtook it, to keep the test quick.

Correct?

Your solution uses x-oob-test both for 1. and 2.  Problematic, because
x-oob-test is OOB, yet does something an OOB command must not do: block
on a lock.  Fixable.

>                                                                      I
> was using migration before to make sure dispatcher won't quite very
> soon, but we have problems there since:
>
> - some architectures may not even have RAM, so snapshot of those
>   platforms can still be super fast;
>
> - even if we make sure RAM is big, the time will depend on the speed
>   of system, say, what if the test environment is running on RAM-disk
>   which is still super fast even to dump the whole RAM onto disk?  As
>   a conclusion - time based command won't work, because time is always
>   a relative value, which can be affected by OS scheduler and system
>   environments.

Hmm, using migration is actually a cute idea.  But making it take long
enough (1.) is unreliable, as you found.  Also, we can't make it
complete quickly (3.).

> When there is better suggestion we can remove x-oob-test, but I can't
> see any so far.

The bit we actually need is having a command block on something we
control.  You picked a QemuSemaphore, internal to QEMU.  What about some
blocking system call?  Here's my idea:

0. Create a named pipe with mkfifo(1)

1. Issue some (non-OOB) QMP command that opens this pipe.  open()
   blocks.

2. Issue the OOB-command, verify it completes

3. If the non-OOB command writes to the pipe, suck the pipe dry, say
   with cat pipe | >/dev/null.  If it reads, give it something to read,
   say echo >pipe.

To make 3. complete quickly with a command that writes, you need one
that writes only a small amount of data.  Candidates: memsave, pmemsave,
screendump.

>> >                      let's convert the cur_mon variable to be a
>> > per-thread variable to make sure there won't be a race between threads.
>> >
>> > Note that thread variables are not initialized to a valid value when new
>> > thread is created.  However for our case we don't need to set it up,
>> > since the cur_mon variable is only used in such a pattern:
>> >
>> >   old_mon = cur_mon;
>> >   cur_mon = xxx;
>> >   (do something, read cur_mon if necessary in the stack)
>> >   cur_mon = old_mon;
>> >
>> > It plays a role as stack variable, so no need to be initialized at all.
>> > We only need to make sure the variable won't be changed unexpectedly by
>> > other threads.
>> 
>> Do we plan to keep switching cur_mon forever?  Or do we intend to work
>> towards a 1:1 association between Monitor struct and monitor thread?
>
> I still don't see a good way to remove the cur_mon switching... E.g.,
> in qmp_human_monitor_command() we'll switch no matter what.

That one's a hack.  We can make exceptions for hacks.  Where else do we
switch?

>> Even if we want the latter, I'm okay with this patch as an intermediate
>> step.
>
> That'll be appreciated.  Thanks,
>
>> 
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
