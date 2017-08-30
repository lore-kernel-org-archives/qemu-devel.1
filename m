Received: from eggs.gnu.org ([2001:4830:134:3::10]:44316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dmx5C-00013r-WD
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 03:06:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dmx57-0004ts-Up
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 03:06:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dmx57-0004tJ-Lk
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 03:06:33 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
	<20170829110357.GG3783@redhat.com>
Date: Wed, 30 Aug 2017 09:06:20 +0200
In-Reply-To: <20170829110357.GG3783@redhat.com> (Daniel P. Berrange's message
	of "Tue, 29 Aug 2017 12:03:57 +0100")
Message-ID: <877exllekz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC v2 0/8] monitor: allow per-monitor thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, John Snow <jsnow@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>

"Daniel P. Berrange" <berrange@redhat.com> writes:

> On Wed, Aug 23, 2017 at 02:51:03PM +0800, Peter Xu wrote:
>> v2:
>> - fixed "make check" error that patchew reported
>> - moved the thread_join upper in monitor_data_destroy(), before
>>   resources are released
>> - added one new patch (current patch 3) that fixes a nasty risk
>>   condition with IOWatchPoll.  Please see commit message for more
>>   information.
>> - added a g_main_context_wakeup() to make sure the separate loop
>>   thread can be kicked always when we want to destroy the per-monitor
>>   threads.
>> - added one new patch (current patch 8) to introduce migration mgmt
>>   lock for migrate_incoming.
>> 
>> This is an extended work for migration postcopy recovery. This series
>> is tested with the following series to make sure it solves the monitor
>> hang problem that we have encountered for postcopy recovery:
>> 
>>   [RFC 00/29] Migration: postcopy failure recovery
>>   [RFC 0/6] migration: re-use migrate_incoming for postcopy recovery
>> 
>> The root problem is that, monitor commands are all handled in main
>> loop thread now, no matter how many monitors we specify. And, if main
>> loop thread hangs due to some reason, all monitors will be stuck.
>> This can be done in reversed order as well: if any of the monitor
>> hangs, it will hang the main loop, and the rest of the monitors (if
>> there is any).

Yes.

>> That affects postcopy recovery, since the recovery requires user input
>> on destination side.  If monitors hang, the destination VM dies and
>> lose hope for even a final recovery.
>> 
>> So, sometimes we need to make sure the monitor be alive, at least one
>> of them.
>> 
>> The whole idea of this series is that instead if handling monitor
>> commands all in main loop thread, we do it separately in per-monitor
>> threads.  Then, even if main loop thread hangs at any point by any
>> reason, per-monitor thread can still survive.

This takes care of "monitor hangs because other parts of the main loop
(including other monitors) hang".  It doesn't take care of "monitor
hangs because the current monitor command hangs".

>>                                                Further, we add hint in
>> QMP/HMP to show whether a command can be executed without QMP, if so,
>> we avoid taking BQL when running that command.  It greatly reduced
>> contention of BQL.  Now the only user of that new parameter (currently
>> I call it "without-bql") is "migrate-incoming" command, which is the
>> only command to rescue a paused postcopy migration.

This takes care of one way commands can hang.  There are other ways;
NFS server going AWOL is a classic.  I don't know whether any other way
applies to migrate-incoming.

>> However, even with the series, it does not mean that per-monitor
>> threads will never hang.  One example is that we can still run "info
>> vcpus" in per-monitor threads during a paused postcopy (in that state,
>> page faults are never handled, and "info cpus" will never return since
>> it tries to sync every vcpus).  So to make sure it does not hang, we
>> not only need the per-monitor thread, the user should be careful as
>> well on how to use it.
>> 
>> For postcopy recovery, we may need dedicated monitor channel for
>> recovery.  In other words, a destination VM that supports postcopy
>> recovery would possibly need:
>> 
>>   -qmp MAIN_CHANNEL -qmp RECOVERY_CHANNEL

Where RECOVERY_CHANNEL isn't necessarily just for postcopy, but for any
"emergency" QMP access.  If you use it only for commands that cannot
hang (i.e. terminate in bounded time), then you'll always be able to get
commands accepted there in bounded time.

> I think this is a really horrible thing to expose to management applications.
> They should not need to be aware of fact that QEMU is buggy and thus requires
> that certain commands be run on different monitors to work around the bug.

These are (serious) design limitations, not bugs in the narrow sense of
the word.

However, I quite agree that the need for clients to know whether a
monitor command can hang is impractical for the general case.  What
might be practical is a QMP monitor mode that accepts only known
hang-free commands.  Hang-free could be introspectable.

In case you consider that ugly: it's best to explore the design space
first, and recoil from "ugly" second.

> I'd much prefer to see the problem described handled transparently inside
> QEMU. One approach is have a dedicated thread in QEMU responsible for all
> monitor I/O. This thread should never actually execute monitor commands
> though, it would simply parse the command request and put data onto a queue
> of pending commands, thus it could never hang. The command queue could be
> processed by the main thread, or by another thread that is interested.
> eg the migration thread could process any queued commands related to
> migration directly.

The monitor itself can't hang then, but the thread(s) dequeuing parsed
commands can.

To maintain commands' synchronous semantics, their replies need to be
sent in order, which of course reintroduces the hangs.

Let's take a step back from the implementation, and talk about
*behavior* instead.

You prefer to have "the problem described handled transparently inside
QEMU".  I read that as "QEMU must ensure the QMP monitor is available at
all times".  "Available" means it accepts commands in bounded time.
Some commands will always finish in bounded time once accepted, others
may not, and whether they do may depend on the commands currently in
flight.

Commands that can always start and always terminate in bounded time are
no problem.

All the other commands have to become "job-starting": the QMP command
kicks off a "job", which runs concurrently with the QMP monitor for some
(possibly unbounded) time, then finishes.  Jobs can be examined (say to
monitor progress, if the job supports that) and controlled (say to
cancel, if the job supports that).

A few commands are already job-starting: migrate, the block job family,
dump-guest-memory with detach=true.  Whether they're already hang-free I
can't say; they could do risky work in their synchronous part.

Many commands that can hang are not job-starting.

Changing a command from "do the job" to "merely start the job" is a
compatibility break.

We could make the change opt-in to preserve compatibility.  But is
preserving a compatible QMP monitor that is prone to hang wortwhile?

If no, we may choose to use the resulting compatibility break to also
switch the packaging of jobs from the current "synchronous command +
broadcast message when done" to some variation of asynchronous command.
But that should be discussed in a separate thread, and only after we
know how we plan to ensure monitor availability.
