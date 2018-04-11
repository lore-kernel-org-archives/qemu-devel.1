Received: from eggs.gnu.org ([2001:4830:134:3::10]:41458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f66Tw-0002aH-IF
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 23:31:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f66Tt-0007a0-Es
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 23:31:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35524 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f66Tt-0007Zd-92
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 23:31:33 -0400
Date: Wed, 11 Apr 2018 11:31:18 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180411033117.GB13887@xz-mi>
References: <20180410124913.10832-1-peterx@redhat.com>
	<20180410124913.10832-3-peterx@redhat.com>
	<8fe4adb8-3f4a-9f2f-59a9-ea6a5468332c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8fe4adb8-3f4a-9f2f-59a9-ea6a5468332c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-thread: let cur_mon be per-thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Apr 10, 2018 at 08:54:31AM -0500, Eric Blake wrote:
> On 04/10/2018 07:49 AM, Peter Xu wrote:
> > cur_mon was only used in main loop so we don't really need that to be
> > per-thread variable.  Now it's possible that we have more than one
> > thread to operate on it.  Let's start to let it be per-thread variable.
> > 
> > In case we'll create threads within a valid cur_mon setup, we'd better
> > let the child threads to inherit the cur_mon from parent thread too.  Do
> > that for both posix and win32 threads.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/monitor/monitor.h   | 2 +-
> >  include/qemu/thread-win32.h | 1 +
> >  monitor.c                   | 2 +-
> >  stubs/monitor.c             | 2 +-
> >  tests/test-util-sockets.c   | 2 +-
> >  util/qemu-thread-posix.c    | 6 ++++++
> >  util/qemu-thread-win32.c    | 6 ++++++
> >  7 files changed, 17 insertions(+), 4 deletions(-)
> > 
> 
> > @@ -494,6 +496,9 @@ static void *qemu_thread_start(void *args)
> >      void *(*start_routine)(void *) = qemu_thread_args->start_routine;
> >      void *arg = qemu_thread_args->arg;
> >  
> > +    /* Inherit the cur_mon pointer from father thread */
> 
> More typical as s/father/parent/

Fixed.

> 
> > +++ b/util/qemu-thread-win32.c
> 
> > @@ -339,6 +341,9 @@ static unsigned __stdcall win32_start_routine(void *arg)
> >      void *(*start_routine)(void *) = data->start_routine;
> >      void *thread_arg = data->arg;
> >  
> > +    /* Inherit the cur_mon pointer from father thread */
> > +    cur_mon = data->current_monitor;
> 
> Otherwise makes sense to me.
> 
> I agree with your analysis that the set of existing OOB commands (just
> 'x-oob-test') has no direct use of cur_mon.  I'm a little fuzzier on
> whether the OOB changes can cause cur_mon to be modified by two threads
> in parallel (monitor_qmp_dispatch_one() is futzing around with 'cur_mon'
> around the call to qmp_dispatch(), and at least
> qmp_human_monitor_command() is also futzing around with it; is there a
> case where handling qmp_human_monitor_command() in the dispatch thread
> in parallel with more input on the main thread could break?)  Thus I'm
> not sure whether this is needed for 2.12 to avoid a regression.

Could I ask what's the "more input on the main thread"?

AFAIU, if we don't take x-oob-test into account, then still only the
main thread will touch (not only modify, even read) the cur_mon
variable.  And as long as that's true, we are keeping the old behavior
as when we are without Out-Of-Band, then IMHO we'll be fine.

qmp_human_monitor_command() is only one QMP command handler, now it
can only be run within main thread.  So even we can have the stack
like monitor_qmp_dispatch_one (which modifies cur_mon) calls
qmp_human_monitor_command (which modifies cur_mon again), still we'll
be fine too as long as they are in the same thread, just like before.

That's why I think it's not a 2.12 regression.  We just need to be
prepared for what might come. Thanks,

-- 
Peter Xu
