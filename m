Received: from eggs.gnu.org ([2001:4830:134:3::10]:43157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fLlpM-0001R9-KV
	for qemu-devel@nongnu.org; Thu, 24 May 2018 04:42:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fLlpJ-0006Be-GD
	for qemu-devel@nongnu.org; Thu, 24 May 2018 04:42:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40844 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fLlpJ-0006BJ-9X
	for qemu-devel@nongnu.org; Thu, 24 May 2018 04:42:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C536E4067F19
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 08:42:24 +0000 (UTC)
Date: Thu, 24 May 2018 16:42:14 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180524084214.GD12122@xz-mi>
References: <20180412061108.10875-1-peterx@redhat.com>
	<87sh6iixvp.fsf@dusky.pond.sub.org> <20180523090450.GC2540@xz-mi>
	<87vabeecrg.fsf@dusky.pond.sub.org> <20180524042906.GE756@xz-mi>
	<87bmd58ntz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bmd58ntz.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v3] monitor: let cur_mon be per-thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, May 24, 2018 at 10:22:48AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Wed, May 23, 2018 at 03:13:07PM +0200, Markus Armbruster wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > On Wed, May 23, 2018 at 10:23:22AM +0200, Markus Armbruster wrote:
> >> >> Peter Xu <peterx@redhat.com> writes:
> >> >> 
> >> >> > In the future the monitor iothread may be accessing the cur_mon as
> >> >> > well (via monitor_qmp_dispatch_one()).  Before we introduce a real
> >> >> > Out-Of-Band command,
> >> >> 
> >> >> Uh, inhowfar are the commands marked allow-oob: true now not real?
> >> >> These are migrate-recover, migrate-pause, x-oob-test.
> >> >
> >> > x-oob-test is unreal; the rest are real.
> >> 
> >> Sounds like the commit message needs tweaking then.
> >
> > Ah yes.  When I drafted this patch we don't really have the other two
> > commands yet.  They are there only after the postcopy recovery series.
> >
> > Do you want me to repost one?
> 
> Repost is fine, but I'm also happy to edit commit messages when I apply
> to qapi-next.

If this is the only thing to touch up, I would appreciate if you can
do that to avoid message bounces.

[...]

> >> > When there is better suggestion we can remove x-oob-test, but I can't
> >> > see any so far.
> >> 
> >> The bit we actually need is having a command block on something we
> >> control.  You picked a QemuSemaphore, internal to QEMU.  What about some
> >> blocking system call?  Here's my idea:
> >> 
> >> 0. Create a named pipe with mkfifo(1)
> >> 
> >> 1. Issue some (non-OOB) QMP command that opens this pipe.  open()
> >>    blocks.
> >> 
> >> 2. Issue the OOB-command, verify it completes
> >> 
> >> 3. If the non-OOB command writes to the pipe, suck the pipe dry, say
> >>    with cat pipe | >/dev/null.  If it reads, give it something to read,
> >>    say echo >pipe.
> >> 
> >> To make 3. complete quickly with a command that writes, you need one
> >> that writes only a small amount of data.  Candidates: memsave, pmemsave,
> >> screendump.
> >
> > I am not sure I have fully understood above, please correct me if I
> > haven't.
> >
> > IMHO they are just similar ideas just like when we use semaphores.
> > Semaphores are QEMU internal, but underneath that it'll also do
> > syscalls (I believe we are using futex() syscalls for semaphores,
> > though that should be in libc code not QEMU).  I believe fifos can be
> > as easy to implement as semaphores, but I don't see much difference
> > here - IMHO fifo just use its own way to do similar thing.  On the
> > kernel side, both of them will basically do:
> >
> > (1) schedule() self process out to wait for the event
> > (2) wake_up() by another process
> >
> > From that point of view, they are same to me.
> 
> The difference is we don't need a special command just for the test.

Ah I see the point now - an existing command that will open a fifo.
Yes that works too, though we'll need to find a good candidate, add
some work to prepare the testbed and make sure there's no side effect.
Anyway, I am totally fine with it once we really want it that way.

> 
> > In other words, since we don't allow OOB-capable command handlers to
> > take risky locks, meanwhile we should also expand that idea further
> > into any operation that might block for some time.  Reading a fifo
> > here is the same as taking a risky lock - we need to make sure the
> > fifo read won't block for long or we should never do that in OOB
> > command handlers.
> 
> Absolutely.  Any code that can run in an OOB command is realtime code,
> and that means it must not block for an indeterminate time.  Synchronous
> read() is right out.
> 
> >> >> >                      let's convert the cur_mon variable to be a
> >> >> > per-thread variable to make sure there won't be a race between threads.
> >> >> >
> >> >> > Note that thread variables are not initialized to a valid value when new
> >> >> > thread is created.  However for our case we don't need to set it up,
> >> >> > since the cur_mon variable is only used in such a pattern:
> >> >> >
> >> >> >   old_mon = cur_mon;
> >> >> >   cur_mon = xxx;
> >> >> >   (do something, read cur_mon if necessary in the stack)
> >> >> >   cur_mon = old_mon;
> >> >> >
> >> >> > It plays a role as stack variable, so no need to be initialized at all.
> >> >> > We only need to make sure the variable won't be changed unexpectedly by
> >> >> > other threads.
> >> >> 
> >> >> Do we plan to keep switching cur_mon forever?  Or do we intend to work
> >> >> towards a 1:1 association between Monitor struct and monitor thread?
> >> >
> >> > I still don't see a good way to remove the cur_mon switching... E.g.,
> >> > in qmp_human_monitor_command() we'll switch no matter what.
> >> 
> >> That one's a hack.  We can make exceptions for hacks.  Where else do we
> >> switch?
> >
> > Yeah, the major one should be monitor_qmp_dispatch_one().  If we can
> > have one thread per monitor, it seems to be good we can at least omit
> > the switching for this one.
> 
> Yes, please.

Note that currently it's still not 1:1 - we only have one thread for
all the monitors, so now it seems that we still cannot omit it.  And
I'm not sure whether we should do that only to omit this cur_mon
fiddling, since it might be an overkill too.

Thanks,

-- 
Peter Xu
