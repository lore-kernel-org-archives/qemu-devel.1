Received: from eggs.gnu.org ([2001:4830:134:3::10]:53366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f8MZ1-0006o6-8h
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 05:06:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f8MYw-0005Ga-0I
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 05:06:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40156 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1f8MYv-0005Bd-QD
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 05:06:05 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180412061108.10875-1-peterx@redhat.com>
	<20180416083748.GD28904@stefanha-x1.localdomain>
	<20180416091732.GB21143@xz-mi>
	<20180417070843.GI10770@stefanha-x1.localdomain>
Date: Tue, 17 Apr 2018 11:05:47 +0200
In-Reply-To: <20180417070843.GI10770@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Tue, 17 Apr 2018 15:08:43 +0800")
Message-ID: <874lkai4no.fsf@dusky.pond.sub.org>
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr
	. David Alan Gilbert" <dgilbert@redhat.com>

Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Mon, Apr 16, 2018 at 05:17:32PM +0800, Peter Xu wrote:
>> On Mon, Apr 16, 2018 at 04:37:48PM +0800, Stefan Hajnoczi wrote:
>> > On Thu, Apr 12, 2018 at 02:11:08PM +0800, Peter Xu wrote:
>> > > In the future the monitor iothread may be accessing the cur_mon as
>> > > well (via monitor_qmp_dispatch_one()).  Before we introduce a real
>> > > Out-Of-Band command, let's convert the cur_mon variable to be a
>> > > per-thread variable to make sure there won't be a race between threads.
>> > >
>> > > Note that thread variables are not initialized to a valid value when new
>> > > thread is created.  However for our case we don't need to set it up,
>> > > since the cur_mon variable is only used in such a pattern:
>> > > 
>> > >   old_mon = cur_mon;
>> > >   cur_mon = xxx;
>> > >   (do something, read cur_mon if necessary in the stack)
>> > >   cur_mon = old_mon;
>> > > 
>> > > It plays a role as stack variable, so no need to be initialized at all.
>> > > We only need to make sure the variable won't be changed unexpectedly by
>> > > other threads.
>> > > 
>> > > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > > ---
>> > > v3:
>> > > - fix code style warning from patchew
>> > > v2:
>> > > - drop qemu-thread changes
>> > > ---
>> > >  include/monitor/monitor.h | 2 +-
>> > >  monitor.c                 | 2 +-
>> > >  stubs/monitor.c           | 2 +-
>> > >  tests/test-util-sockets.c | 2 +-
>> > >  4 files changed, 4 insertions(+), 4 deletions(-)
>> > 
>> > The Monitor object is not fully thread-safe, so although the correct
>> > cur_mon is now accessible, code may still be unsafe.  For example,
>> > monitor_get_fd(cur_mon, ...) is not thread-safe and must not be used by
>> > OOB commands.
>> 
>> IMHO things like monitor_get_fd() should only be called in QMP
>> context, so there should always be a monitor_qmp_dispatch_one() in the
>> stack already (no matter whether it is in main thread or the monitor
>> iothread), which means that cur_mon should have been setup.  So IMHO
>> it's a programming error if monitor_get_fd() is called without correct
>> cur_mon setup after this patch.
>
> The pointer value of cur_mon is not the issue, you have made that work
> correctly.  The problem is that some monitor.h APIs do not access the
> Monitor object in a thread-safe fashion.
>
> Two QMP commands executing simultaneously in the main loop thread and
> the monitor IOThread can hit race conditions.  The example I gave was
> the monitor_get_fd() API, which iterates and modifies the mon->fds
> QLIST without a lock.
>
> Please audit monitor.h and either make things thread-safe or document
> the thread-safety rules (e.g. "This function cannot be called from
> out-of-band QMP context").  This wasn't necessary before but now that
> you are adding multi-threading it is.

Code working with the current thread's monitor via thread-local cur_mon
is easier to analyze in some ways than code working with a Monitor *
parameter: the latter can interfere with some other thread's monitor,
and you may have to argue what values the parameter can take.

You might want to replace parameters by cur_mon in certain cases.

Funnily, the plan used to be the opposite.  Commit 376253ece48: "On the
mid or long term, those use case will be obsoleted so that [cur_mon] can
be removed again."
