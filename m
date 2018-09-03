Received: from eggs.gnu.org ([2001:4830:134:3::10]:46328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fwoj5-0003CZ-4R
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 09:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fwoj0-0004NB-U4
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 09:17:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59712 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fwoj0-0004LR-Ki
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 09:17:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 56ADD4023ECB
	for <qemu-devel@nongnu.org>; Mon,  3 Sep 2018 13:17:01 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180903043149.4076-1-peterx@redhat.com>
	<20180903043149.4076-4-peterx@redhat.com>
	<87pnxv9gkn.fsf@dusky.pond.sub.org> <20180903090647.GA16551@xz-x1>
Date: Mon, 03 Sep 2018 15:16:55 +0200
In-Reply-To: <20180903090647.GA16551@xz-x1> (Peter Xu's message of "Mon, 3 Sep
	2018 17:06:47 +0800")
Message-ID: <87sh2q67qw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Peter Xu <peterx@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> On Mon, Sep 03, 2018 at 09:38:00AM +0200, Markus Armbruster wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > When we received too many qmp commands, previously we'll send
>> > COMMAND_DROPPED events to monitors, then we'll drop the requests.  Now
>> > instead of dropping the command we stop reading from input when we
>> > notice the queue is getting full.  Note that here since we removed the
>> > need_resume flag we need to be _very_ careful on the suspend/resume
>> > paring on the conditions since unmatched condition checks will hang
>> > death the monitor.  Meanwhile, now we will need to read the queue length
>> > to decide whether we'll need to resume the monitor so we need to take
>> > the queue lock again even after popping from it.
>> >
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> 
>> The subject's "send CMD_DROP" fails to highlight the important part:
>> we're no longer dropping commands.  Moreover, the commit message could
>> do a better job explaining the tradeoffs.  Here's my try:
>> 
>>     monitor: Suspend monitor instead dropping commands
>> 
>>     When a QMP client sends in-band commands more quickly that we can
>>     process them, we can either queue them without limit (QUEUE), drop
>>     commands when the queue is full (DROP), or suspend receiving commands
>>     when the queue is full (SUSPEND).  None of them is ideal:
>> 
>>     * QUEUE lets a misbehaving client make QEMU eat memory without bounds.
>>       Not such a hot idea.
>> 
>>     * With DROP, the client has to cope with dropped in-band commands.  To
>>       inform the client, we send a COMMAND_DROPPED event then.  The event is
>>       flawed by design in two ways: it's ambiguous (see commit d621cfe0a17),
>>       and it brings back the "eat memory without bounds" problem.
>> 
>>     * With SUSPEND, the client has to manage the flow of in-band commands to
>>       keep the monitor available for out-of-band commands.
>> 
>>     We currently DROP.  Switch to SUSPEND.
>> 
>>     Managing the flow of in-band commands to keep the monitor available for
>>     out-of-band commands isn't really hard: just count the number of
>>     "outstanding" in-band commands (commands sent minus replies received),
>>     and if it exceeds the limit, hold back additional ones until it drops
>>     below the limit again.
>
> (Will the simplest QMP client just block at the write() system call
>  without notice?

Yes.

When you stop reading from a socket or pipe, the peer eventually can't
write more.  "Eventually", because the TCP connection or pipe buffers
some.

A naive client using a blocking write() will block then.

A slightly more sophisticated client using a non-blocking write() has
its write() fail with EAGAIN or EWOULDBLOCK.

In both cases, OOB commands may be stuck in the TCP connection's /
pipe's buffer.


>                   Anyway, the SUSPEND is ideal enough to me... :)
>
>> 
>>     Note that we need to be careful pairing the suspend with a resume, or
>>     else the monitor will hang, possibly forever.
>
> Will take your version, thanks.
>
>> 
>> 
>> > ---
>> >  monitor.c | 33 +++++++++++++++------------------
>> >  1 file changed, 15 insertions(+), 18 deletions(-)
>> >
>> > diff --git a/monitor.c b/monitor.c
>> > index 3b90c9eb5f..9e6cad2af6 100644
>> > --- a/monitor.c
>> > +++ b/monitor.c
>> > @@ -89,6 +89,8 @@
>> >  #include "hw/s390x/storage-attributes.h"
>> >  #endif
>> >  
>> > +#define  QMP_REQ_QUEUE_LEN_MAX  (8)
>> > +
>> 
>> Let's drop the parenthesis.
>
> Ok.
>
>> 
>> >  /*
>> >   * Supported types:
>> >   *
>> > @@ -4124,29 +4126,33 @@ static QMPRequest *monitor_qmp_requests_pop_any(void)
>> >  static void monitor_qmp_bh_dispatcher(void *data)
>> >  {
>> >      QMPRequest *req_obj = monitor_qmp_requests_pop_any();
>> > +    Monitor *mon;
>> >      QDict *rsp;
>> >      bool need_resume;
>> >  
>> >      if (!req_obj) {
>> >          return;
>> >      }
>> > -
>> 
>> Let's keep the blank line.
>
> Ok.
>
>> 
>> > +    mon = req_obj->mon;
>> >      /*  qmp_oob_enabled() might change after "qmp_capabilities" */
>> > -    need_resume = !qmp_oob_enabled(req_obj->mon);
>> > +    qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
>> > +    need_resume = !qmp_oob_enabled(req_obj->mon) ||
>> > +        mon->qmp.qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX - 1;
>> 
>> Note for later: this is the condition guarding monitor_resume().
>> 
>> Is this race-free?  We have two criticial sections, one in
>> monitor_qmp_requests_pop_any(), and one here.  What if two threads
>> interleave like this
>> 
>>     thread 1                            thread 2
>>     ------------------------------------------------------------------
>>     monitor_qmp_requests_pop_any()
>>         lock
>>         dequeue
>>         unlock
>>                                         monitor_qmp_requests_pop_any()
>>                                             lock
>>                                             dequeue
>>                                             unlock
>>                                         lock
>>                                         check queue length
>>                                         unlock
>>                                         if queue length demands it
>>                                              monitor_resume() 
>>     lock
>>     check queue length
>>     unlock
>>     if queue length demands it
>>         monitor_resume()
>> 
>> Looks racy to me: if we start with the queue full (and the monitor
>> suspended), both threads' check queue length see length
>> QMP_REQ_QUEUE_LEN_MAX - 2, and neither thread resumes the monitor.
>> Oops.
>> 
>> Simplest fix is probably moving the resume into
>> monitor_qmp_requests_pop_any()'s critical section.
>
> But we only have one QMP dispatcher, right?  So IMHO we can't have two
> threads doing monitor_qmp_requests_pop_any() at the same time.

You're right, we currently run monitor_qmp_bh_dispatcher() only in the
main thread, and a thread can't race with itself.  But the main thread
can still race with handle_qmp_command() running in mon_iothread.

    main thread                         mon_iothread
    ------------------------------------------------------------------
    monitor_qmp_requests_pop_any()
        lock
        dequeue
        unlock
                                        lock
                                        if queue length demands it
                                            monitor_suspend()
                                        push onto queue
                                        unlock
    lock
    check queue length
    unlock
    if queue length demands it
        monitor_resume()

If we start with the queue full (and the monitor suspended), the main
thread first determines it'll need to resume.  mon_iothread then fills
the queue again, and suspends the suspended monitor some more.  If I
read the code correctly, this increments mon->suspend_cnt from 1 to 2.
Finally, the main thread checks the queue length:

       need_resume = !qmp_oob_enabled(req_obj->mon) ||
           mon->qmp.qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX - 1;

The yields false, because ->length is now QMP_REQ_QUEUE_LEN_MAX.  The
main thread does *not* resume the monitor.

State after this: queue full, mon->suspend_cnt == 2.  Bad, but we'll
recover on the dequeue after next: the next dequeue decrements
mon->suspend_cnt to 1 without resuming the monitor, the one after that
will decrement it to 0 and resume the monitor.

However, if handle_qmp_command() runs in this spot often enough to push
mon->suspend_cnt above QMP_REQ_QUEUE_LEN_MAX, the monitor will remain
suspended forever.

I'm teaching you multiprogramming 101 here.  The thing that should make
the moderately experienced nose twitch is the anti-pattern

    begin critical section
    do something
    end critical section
    begin critical section
    if we just did X, state must be Y, so we must now do Z
    end critical section

The part "if we just did X, state must be Y" is *wrong*.  You have no
idea what the state is, since code running between the two critical
sections may have changed it.

Here,

    X = dequeued from a full queue"
    Y = "mon->suspend_cnt == 1"
    Z = monitor_resume() to resume the monitor

I showed that Y does not hold.

On a slightly more abstract level, this anti-pattern applies:

    begin critical section
    start messing with invariant
    end critical section
    // invariant does not hold here, oopsie
    begin critical section
    finish messing with invariant
    end critical section

The invariant here is "monitor suspended exactly when the queue is
full".  Your first critical section can make the queue non-full.  The
second one resumes.  The invariant doesn't hold in between, and all bets
are off.

To maintain the invariant, you *have* to enqueue and suspend in a single
critical section (which you do), *and* dequeue and resume in a single
critical section (which you don't).

> But I fully agree that it'll be nicer to keep them together (e.g. in
> case we allow to dispatch two commands some day), but then if you see
> it'll be something like the old req_obj->need_resume flag, but we set
> it in monitor_qmp_requests_pop_any() instead.  If so, I really prefer
> we just keep that need_resume flag for per-monitor by dropping
> 176160ce78 and keep my patch to move that flag into monitor struct
> (which I dropped after the rebase of this version).

Please have another look.

>> > +    qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
>> >      if (req_obj->req) {
>> >          trace_monitor_qmp_cmd_in_band(qobject_get_try_str(req_obj->id) ?: "");
>> > -        monitor_qmp_dispatch(req_obj->mon, req_obj->req, req_obj->id);
>> > +        monitor_qmp_dispatch(mon, req_obj->req, req_obj->id);
>> >      } else {
>> >          assert(req_obj->err);
>> >          rsp = qmp_error_response(req_obj->err);
>> >          req_obj->err = NULL;
>> > -        monitor_qmp_respond(req_obj->mon, rsp, NULL);
>> > +        monitor_qmp_respond(mon, rsp, NULL);
>> >          qobject_unref(rsp);
>> >      }
>> >  
>> >      if (need_resume) {
>> >          /* Pairs with the monitor_suspend() in handle_qmp_command() */
>> > -        monitor_resume(req_obj->mon);
>> > +        monitor_resume(mon);
>> >      }
>> >      qmp_request_free(req_obj);
>> 
>> The replacement of req_obj->mon by mon makes this change less clear than
>> it could be.  Let's figure out the possible race, and then we'll see
>> whether we'll still want this replacement.
>
> Sure.
>
>> 
>> >  
>> > @@ -4154,8 +4160,6 @@ static void monitor_qmp_bh_dispatcher(void *data)
>> >      qemu_bh_schedule(qmp_dispatcher_bh);
>> >  }
>> >  
>> > -#define  QMP_REQ_QUEUE_LEN_MAX  (8)
>> > -
>> >  static void handle_qmp_command(void *opaque, QObject *req, Error *err)
>> >  {
>> >      Monitor *mon = opaque;
>> > @@ -4205,19 +4209,12 @@ static void handle_qmp_command(void *opaque, QObject *req, Error *err)
>>        /*
>>         * If OOB is not enabled on the current monitor, we'll emulate the
>>         * old behavior that we won't process the current monitor any more
>>         * until it has responded.  This helps make sure that as long as
>>         * OOB is not enabled, the server will never drop any command.
>>         */
>> 
>> This comment is now stale, we don't drop commands anymore.
>
> AFAIU it's describing [1] below but nothing related to COMMAND_DROP?

The comment suggests the server can drop commands when OOB is enabled.
This is no longer correct after this patch.

>> 
>> >      if (!qmp_oob_enabled(mon)) {
>> >          monitor_suspend(mon);
>
> [1]
>
>> >      } else {
>> > -        /* Drop the request if queue is full. */
>> > -        if (mon->qmp.qmp_requests->length >= QMP_REQ_QUEUE_LEN_MAX) {
>> > -            qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
>> > +        if (mon->qmp.qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX - 1) {
>> >              /*
>> > -             * FIXME @id's scope is just @mon, and broadcasting it is
>> > -             * wrong.  If another monitor's client has a command with
>> > -             * the same ID in flight, the event will incorrectly claim
>> > -             * that command was dropped.
>> > +             * If this is _exactly_ the last request that we can
>> > +             * queue, we suspend the monitor right now.
>> >               */
>> > -            qapi_event_send_command_dropped(id,
>> > -                                            COMMAND_DROP_REASON_QUEUE_FULL);
>> > -            qmp_request_free(req_obj);
>> > -            return;
>> > +            monitor_suspend(mon);
>> >          }
>> >      }
>> 
>> The conditional and its comments look unbalanced.  Moreover, the
>> condition is visually dissimilar to the one guarding the matching
>> monitor_resume().  What about:
>> 
>>        /*
>>         * Suspend the monitor when we can't queue more requests after
>>         * this one.  Dequeuing in monitor_qmp_bh_dispatcher() will resume
>>         * it.
>>         * Note that when OOB is disabled, we queue at most one command,
>>         * for backward compatibility.
>>         */
>>        if (!qmp_oob_enabled(mon) ||
>>            mon->qmp.qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX - 1) {
>>            monitor_suspend(mon);
>>        }
>> 
>> You'll have to update the comment if you move the resume to
>> monitor_qmp_requests_pop_any().
>> 
>> Next:
>> 
>>        /*
>>         * Put the request to the end of queue so that requests will be
>>         * handled in time order.  Ownership for req_obj, req, id,
>>         * etc. will be delivered to the handler side.
>>         */
>> 
>> Suggest asserting mon->qmp.qmp_requests->length < QMP_REQ_QUEUE_LEN_MAX
>> here.
>
> Sure I can do this.
>
>> 
>>        g_queue_push_tail(mon->qmp.qmp_requests, req_obj);
>>        qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
>
> Thanks,
