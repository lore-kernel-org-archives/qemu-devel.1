Received: from eggs.gnu.org ([2001:4830:134:3::10]:55395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fx5LD-0005F4-7U
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 03:01:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fx5Kq-0001xQ-MS
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 03:01:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44672 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fx5Kq-0001w9-4Y
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 03:01:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6D9EE40216E5
	for <qemu-devel@nongnu.org>; Tue,  4 Sep 2018 07:01:11 +0000 (UTC)
Date: Tue, 4 Sep 2018 15:01:04 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180904070104.GA11314@xz-x1>
References: <20180903043149.4076-1-peterx@redhat.com>
	<20180903043149.4076-4-peterx@redhat.com>
	<87pnxv9gkn.fsf@dusky.pond.sub.org> <20180903090647.GA16551@xz-x1>
	<87sh2q67qw.fsf@dusky.pond.sub.org> <20180904033304.GD14774@xz-x1>
	<87bm9dzsz1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bm9dzsz1.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v7 3/7] monitor: suspend monitor instead of
 send CMD_DROP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Sep 04, 2018 at 08:17:54AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Sep 03, 2018 at 03:16:55PM +0200, Markus Armbruster wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > On Mon, Sep 03, 2018 at 09:38:00AM +0200, Markus Armbruster wrote:
> >> >> Peter Xu <peterx@redhat.com> writes:
> >> >> 
> >> >> > When we received too many qmp commands, previously we'll send
> >> >> > COMMAND_DROPPED events to monitors, then we'll drop the requests.  Now
> >> >> > instead of dropping the command we stop reading from input when we
> >> >> > notice the queue is getting full.  Note that here since we removed the
> >> >> > need_resume flag we need to be _very_ careful on the suspend/resume
> >> >> > paring on the conditions since unmatched condition checks will hang
> >> >> > death the monitor.  Meanwhile, now we will need to read the queue length
> >> >> > to decide whether we'll need to resume the monitor so we need to take
> >> >> > the queue lock again even after popping from it.
> >> >> >
> >> >> > Signed-off-by: Peter Xu <peterx@redhat.com>
> >> >> 
> >> >> The subject's "send CMD_DROP" fails to highlight the important part:
> >> >> we're no longer dropping commands.  Moreover, the commit message could
> >> >> do a better job explaining the tradeoffs.  Here's my try:
> >> >> 
> >> >>     monitor: Suspend monitor instead dropping commands
> >> >> 
> >> >>     When a QMP client sends in-band commands more quickly that we can
> >> >>     process them, we can either queue them without limit (QUEUE), drop
> >> >>     commands when the queue is full (DROP), or suspend receiving commands
> >> >>     when the queue is full (SUSPEND).  None of them is ideal:
> >> >> 
> >> >>     * QUEUE lets a misbehaving client make QEMU eat memory without bounds.
> >> >>       Not such a hot idea.
> >> >> 
> >> >>     * With DROP, the client has to cope with dropped in-band commands.  To
> >> >>       inform the client, we send a COMMAND_DROPPED event then.  The event is
> >> >>       flawed by design in two ways: it's ambiguous (see commit d621cfe0a17),
> >> >>       and it brings back the "eat memory without bounds" problem.
> >> >> 
> >> >>     * With SUSPEND, the client has to manage the flow of in-band commands to
> >> >>       keep the monitor available for out-of-band commands.
> >> >> 
> >> >>     We currently DROP.  Switch to SUSPEND.
> >> >> 
> >> >>     Managing the flow of in-band commands to keep the monitor available for
> >> >>     out-of-band commands isn't really hard: just count the number of
> >> >>     "outstanding" in-band commands (commands sent minus replies received),
> >> >>     and if it exceeds the limit, hold back additional ones until it drops
> >> >>     below the limit again.
> >> >
> >> > (Will the simplest QMP client just block at the write() system call
> >> >  without notice?
> >> 
> >> Yes.
> >> 
> >> When you stop reading from a socket or pipe, the peer eventually can't
> >> write more.  "Eventually", because the TCP connection or pipe buffers
> >> some.
> >> 
> >> A naive client using a blocking write() will block then.
> >> 
> >> A slightly more sophisticated client using a non-blocking write() has
> >> its write() fail with EAGAIN or EWOULDBLOCK.
> >> 
> >> In both cases, OOB commands may be stuck in the TCP connection's /
> >> pipe's buffer.
> >> 
> >> 
> >> >                   Anyway, the SUSPEND is ideal enough to me... :)
> >> >
> >> >> 
> >> >>     Note that we need to be careful pairing the suspend with a resume, or
> >> >>     else the monitor will hang, possibly forever.
> >> >
> >> > Will take your version, thanks.
> >> >
> >> >> 
> >> >> 
> >> >> > ---
> >> >> >  monitor.c | 33 +++++++++++++++------------------
> >> >> >  1 file changed, 15 insertions(+), 18 deletions(-)
> >> >> >
> >> >> > diff --git a/monitor.c b/monitor.c
> >> >> > index 3b90c9eb5f..9e6cad2af6 100644
> >> >> > --- a/monitor.c
> >> >> > +++ b/monitor.c
> >> >> > @@ -89,6 +89,8 @@
> >> >> >  #include "hw/s390x/storage-attributes.h"
> >> >> >  #endif
> >> >> >  
> >> >> > +#define  QMP_REQ_QUEUE_LEN_MAX  (8)
> >> >> > +
> >> >> 
> >> >> Let's drop the parenthesis.
> >> >
> >> > Ok.
> >> >
> >> >> 
> >> >> >  /*
> >> >> >   * Supported types:
> >> >> >   *
> >> >> > @@ -4124,29 +4126,33 @@ static QMPRequest *monitor_qmp_requests_pop_any(void)
> >> >> >  static void monitor_qmp_bh_dispatcher(void *data)
> >> >> >  {
> >> >> >      QMPRequest *req_obj = monitor_qmp_requests_pop_any();
> >> >> > +    Monitor *mon;
> >> >> >      QDict *rsp;
> >> >> >      bool need_resume;
> >> >> >  
> >> >> >      if (!req_obj) {
> >> >> >          return;
> >> >> >      }
> >> >> > -
> >> >> 
> >> >> Let's keep the blank line.
> >> >
> >> > Ok.
> >> >
> >> >> 
> >> >> > +    mon = req_obj->mon;
> >> >> >      /*  qmp_oob_enabled() might change after "qmp_capabilities" */
> >> >> > -    need_resume = !qmp_oob_enabled(req_obj->mon);
> >> >> > +    qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
> >> >> > +    need_resume = !qmp_oob_enabled(req_obj->mon) ||
> >> >> > +        mon->qmp.qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX - 1;
> >> >> 
> >> >> Note for later: this is the condition guarding monitor_resume().
> >> >> 
> >> >> Is this race-free?  We have two criticial sections, one in
> >> >> monitor_qmp_requests_pop_any(), and one here.  What if two threads
> >> >> interleave like this
> >> >> 
> >> >>     thread 1                            thread 2
> >> >>     ------------------------------------------------------------------
> >> >>     monitor_qmp_requests_pop_any()
> >> >>         lock
> >> >>         dequeue
> >> >>         unlock
> >> >>                                         monitor_qmp_requests_pop_any()
> >> >>                                             lock
> >> >>                                             dequeue
> >> >>                                             unlock
> >> >>                                         lock
> >> >>                                         check queue length
> >> >>                                         unlock
> >> >>                                         if queue length demands it
> >> >>                                              monitor_resume() 
> >> >>     lock
> >> >>     check queue length
> >> >>     unlock
> >> >>     if queue length demands it
> >> >>         monitor_resume()
> >> >> 
> >> >> Looks racy to me: if we start with the queue full (and the monitor
> >> >> suspended), both threads' check queue length see length
> >> >> QMP_REQ_QUEUE_LEN_MAX - 2, and neither thread resumes the monitor.
> >> >> Oops.
> >> >> 
> >> >> Simplest fix is probably moving the resume into
> >> >> monitor_qmp_requests_pop_any()'s critical section.
> >> >
> >> > But we only have one QMP dispatcher, right?  So IMHO we can't have two
> >> > threads doing monitor_qmp_requests_pop_any() at the same time.
> >> 
> >> You're right, we currently run monitor_qmp_bh_dispatcher() only in the
> >> main thread, and a thread can't race with itself.  But the main thread
> >> can still race with handle_qmp_command() running in mon_iothread.
> >> 
> >>     main thread                         mon_iothread
> >>     ------------------------------------------------------------------
> >>     monitor_qmp_requests_pop_any()
> >>         lock
> >>         dequeue
> >>         unlock
> >>                                         lock
> >>                                         if queue length demands it
> >>                                             monitor_suspend()
> >>                                         push onto queue
> >>                                         unlock
> >>     lock
> >>     check queue length
> >>     unlock
> >>     if queue length demands it
> >>         monitor_resume()           <---------------------- [1]
> >> 
> >> If we start with the queue full (and the monitor suspended), the main
> >> thread first determines it'll need to resume.  mon_iothread then fills
> >> the queue again, and suspends the suspended monitor some more.  If I
> >
> > (Side note: here it's tricky that when we "determines to resume" we
> >  didn't really resume, so we are still suspended, hence the
> >  mon_iothread cannot fill the queue again until the resume at [1]
> 
> You're right.
> 
> >  above.  Hence IMHO we're safe here.  But I agree that it's still racy
> >  in other cases.)
> 
> Maybe.
> 
> Getting threads to cooperate safely is hard.  Key to success is making
> things as simple and obvious as we can.  Suitable invariants help.
> 
> They help even more when they're documented and checked with assertions.
> Perhaps you can think of ways to do that.
> 
> >> read the code correctly, this increments mon->suspend_cnt from 1 to 2.
> >> Finally, the main thread checks the queue length:
> >> 
> >>        need_resume = !qmp_oob_enabled(req_obj->mon) ||
> >>            mon->qmp.qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX - 1;
> >> 
> >> The yields false, because ->length is now QMP_REQ_QUEUE_LEN_MAX.  The
> >> main thread does *not* resume the monitor.
> >> 
> >> State after this: queue full, mon->suspend_cnt == 2.  Bad, but we'll
> >> recover on the dequeue after next: the next dequeue decrements
> >> mon->suspend_cnt to 1 without resuming the monitor, the one after that
> >> will decrement it to 0 and resume the monitor.
> >> 
> >> However, if handle_qmp_command() runs in this spot often enough to push
> >> mon->suspend_cnt above QMP_REQ_QUEUE_LEN_MAX, the monitor will remain
> >> suspended forever.
> >> 
> >> I'm teaching you multiprogramming 101 here.  The thing that should make
> >> the moderately experienced nose twitch is the anti-pattern
> >> 
> >>     begin critical section
> >>     do something
> >>     end critical section
> >>     begin critical section
> >>     if we just did X, state must be Y, so we must now do Z
> >>     end critical section
> >> 
> >> The part "if we just did X, state must be Y" is *wrong*.  You have no
> >> idea what the state is, since code running between the two critical
> >> sections may have changed it.
> >> 
> >> Here,
> >> 
> >>     X = dequeued from a full queue"
> >>     Y = "mon->suspend_cnt == 1"
> >>     Z = monitor_resume() to resume the monitor
> >> 
> >> I showed that Y does not hold.
> >> 
> >> On a slightly more abstract level, this anti-pattern applies:
> >> 
> >>     begin critical section
> >>     start messing with invariant
> >>     end critical section
> >>     // invariant does not hold here, oopsie
> >>     begin critical section
> >>     finish messing with invariant
> >>     end critical section
> >> 
> >> The invariant here is "monitor suspended exactly when the queue is
> >> full".  Your first critical section can make the queue non-full.  The
> >> second one resumes.  The invariant doesn't hold in between, and all bets
> >> are off.
> >> 
> >> To maintain the invariant, you *have* to enqueue and suspend in a single
> >> critical section (which you do), *and* dequeue and resume in a single
> >> critical section (which you don't).
> >
> > Thank you for teaching the lesson for me.
> >
> >> 
> >> > But I fully agree that it'll be nicer to keep them together (e.g. in
> >> > case we allow to dispatch two commands some day), but then if you see
> >> > it'll be something like the old req_obj->need_resume flag, but we set
> >> > it in monitor_qmp_requests_pop_any() instead.  If so, I really prefer
> >> > we just keep that need_resume flag for per-monitor by dropping
> >> > 176160ce78 and keep my patch to move that flag into monitor struct
> >> > (which I dropped after the rebase of this version).
> >> 
> >> Please have another look.
> >
> > Again, if we want to put pop+check into the same critical section,
> > then we possibly need to return something from the
> > monitor_qmp_requests_pop_any() to show the queue length information,
> > then I would prefer to keep the per-monitor need_resume flag.
> >
> > What do you think?
> 
> Options:
> 
> * Save rather than recompute @need_resume
> 
>   This gets rid of the second critical section.

This one I always liked.  Actually it will avoid potential risk when
the conditions become more complicated (now it only contains two
checks).  Meanwhile...

> 
> * Have monitor_qmp_requests_pop_any() return @need_resume
> 
>   This merges the second critical section into the first.

(I don't like this one much...)

> 
> * Have a single critical section in monitor_qmp_bh_dispatcher()
> 
>   This replaces both critical sections by a single larger one.
>   Callers of monitor_qmp_bh_dispatcher() must hold monitor_lock.

... I like this one too since it's clean enough at least for now and
it won't bother you to drop one queued patch in monitor-next.

I'll use this one if no one disagrees.

> 
> * Other ideas?
> 
> The question to ask regardless of option: what invariant do the critical
> sections maintain?
> 
> I proposed one: monitor suspended exactly when the queue is full.
> 
> handle_qmp_command()'s critical section maintains it: it suspends when
> its enqueue fills up the queue.
> 
> monitor_qmp_bh_dispatcher()'s critical sections do not.  Even if we
> reduce them from two to one, the resulting single critical section can't
> as long as we resume only after the dequeued command completed, because
> that would require holding monitor_lock while the command executes.  So,
> to maintain this invariant, we need to rethink
> monitor_qmp_bh_dispatcher().  Why can't we resume right after dequeuing?

Makes sense.  I can do that in my next post if you like.

> 
> You're of course welcome to propose a different invariant.
> 
> [...]

Thanks,

-- 
Peter Xu
