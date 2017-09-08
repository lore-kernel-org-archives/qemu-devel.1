Received: from eggs.gnu.org ([2001:4830:134:3::10]:36064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dqEr3-0001cP-RE
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 04:41:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dqEqx-0001l4-JZ
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 04:41:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dqEqx-0001jl-A9
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 04:41:31 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170906104850.GB2215@work-vm>
	<20170906105414.GL15510@redhat.com> <20170906105704.GC2215@work-vm>
	<20170906110629.GM15510@redhat.com> <20170906113157.GD2215@work-vm>
	<20170906115428.GP15510@redhat.com>
	<20170907081341.GA23040@pxdev.xzpeter.org>
	<87inguaclr.fsf@dusky.pond.sub.org>
	<20170907132259.GM30609@redhat.com>
	<87h8weo186.fsf@dusky.pond.sub.org> <20170907180900.GV2098@work-vm>
Date: Fri, 08 Sep 2017 10:41:22 +0200
In-Reply-To: <20170907180900.GV2098@work-vm> (David Alan Gilbert's message of
	"Thu, 7 Sep 2017 19:09:00 +0100")
Message-ID: <87k219fuq5.fsf@dusky.pond.sub.org>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> "Daniel P. Berrange" <berrange@redhat.com> writes:
>> 
>> > On Thu, Sep 07, 2017 at 02:59:28PM +0200, Markus Armbruster wrote:
>> >> So, what exactly is going to drain the command queue?  If there's more
>> >> than one consumer, how exactly are commands from the queue dispatched to
>> >> the consumers?
>> >
>> > In terms of my proposal, for any single command there should only ever
>> > be a single consumer. The default consumer would be the main event loop
>> > thread, such that we have no semantic change to QMP operation from today.
>> >
>> > Some commands that are capable of being made "async", would have a
>> > different consumer. For example, if the client requested the 'migrate-cancel'
>> > be made async, this would change things such that the migration thread is
>> > now responsible for consuming the "migrate-cancel" command, instead of the
>> > default main loop.
>> >
>> >> What are the "no hang" guarantees (if any) and conditions for each of
>> >> these consumers?
>> >
>> > The non-main thread consumers would have to have some reasonable
>> > guarantee that they won't block on a lock held by the main loop,
>> > otherwise the whole feature is largely useless.
>> 
>> Same if they block indefinitely on anything else, actually.  In other
>> words, we need to talk about liveness.
>> 
>> Threads by themselves don't buy us liveness.  Being careful with
>> operations that may block does.  That care may lead to farming out
>> certain operations to other threads, where they may block without harm.
>> 
>> You only talk about "the non-main thread consumers".  What about the
>> main thread?  Is it okay for the main thread to block?  If yes, why?
>
> It would be great if the main thread never blocked; but IMHO that's
> a huge task that we'll never get done [challenge].

This is perhaps starting to wander off the topic, but here goes anyway.

What unpleasant things can happen when the main loop hangs?

What are the known causes of main loop hangs?  Any ideas on fixing them?

Are the unknown main loop hangs relevant in practice?

If we can't eliminate main loop hangs, any ideas on reducing their
impact?

>> >> We can have any number of QMP monitors today.  Would each of them feed
>> >> its own queue?  Would they all feed a shared queue?
>> >
>> > Currently with multiple QMP monitors, everything runs in the main
>> > loop, so commands arriving across  multiple monitors are 100%
>> > serialized and processed strictly in the order in which QEMU reads
>> > them off the wire.  To maintain these semantics, we would need to
>> > have a single shared queue for the default main loop consumer, so
>> > that ordering does not change.
>> >
>> >> How exactly is opt-in asynchronous to work?  Per QMP monitor?  Per
>> >> command?
>> >
>> > Per monitor+command. ie just because libvirt knows how to cope with
>> > async execution on the monitor it has open, does not mean that a
>> > different app on the 2nd monitor command can cope. So in my proposal
>> > the switch to async must be scoped to the particular command only
>> > for the monitor connection that requesteed it.
>> >
>> >> What does it mean when an asynchronous command follows a synchronous
>> >> command in the same QMP monitor?  I would expect the synchronous command
>> >> to complete before the asynchronous command, because that's what
>> >> synchronous means, isn't it?  To keep your QMP monitor available, you
>> >> then must not send synchronous commands that can hang.
>> >
>> > No, that is not what I described. All synchronous commands are
>> > serialized wrt each other, just as today. An asychronous command
>> > can run as soon as it is received, regardless of whether any
>> > earlier sent sync commands are still executing or pending. This
>> > is trivial to achieve when you separate monitor I/O from command
>> > execution in separate threads, provided of course the async
>> > command consumers are not in the main loop.
>> 
>> So, a synchronous command is synchronous with respect to other commands,
>> except for certain non-blocking commands.  The distinctive feature of
>> the latter isn't so much an asynchronous reply, but out-of-band
>> dispatch.
>> 
>> Out-of-band dispatch of commands that cannot block in fact orthogonal to
>> asynchronous replies.  I can't see why out-of-band dispatch of
>> synchronous non-blocking commands wouldn't work, too.
>> 
>> >> How can we determine whether a certain synchronous command can hang?
>> >> Note that with opt-in async, *all* commands are also synchronous
>> >> commands.
>> >> 
>> >> In short, explain to me how exactly you plan to ensure that certain QMP
>> >> commands (such as post-copy recovery) can always "get through", in the
>> >> presence of multiple monitors, hanging main loop, hanging synchronous
>> >> commands, hanging whatever-else-can-now-hang-in-this-post-copy-world.
>> >
>> > Taking migrate-cancel as the example. The migration code already has
>> > a background thread doing work independantly onthe main loop. Upon
>> > marking the migrate-cancel command as async, the migration control
>> > thread would become the consumer of migrate-cancel.
>> 
>> From 30,000 feet, the QMP monitor sends a "cancel" message to the
>> migration thread, and later receives a "canceled" message from the
>> migration thread.
>> 
>> From 300 feet, we use the migrate-cancel QMP command as the cancel
>> message, and its success response as the "canceled" message.
>> 
>> In other words, we're pressing the external QM-Protocol into service as
>> internal message passing protocol.
>
> Be careful; it's not a cancel in the postcopy recovery case, it's a
> restart.  The command is very much like the migration-incoming command.
> The management layer has to provide data with the request, so it's not
> an internal command.

It's still a message.

>> >                                                     This allows the
>> > migration operation to be cancelled immediately, regardless of whether
>> > there are earlier monitor commands blocked in the main loop.
>> 
>> The necessary part is moving all operations that can block out of
>> whatever loop runs the monitor, be it the main loop, some other event
>> loop, or a dedicated monitor thread's monitor loop.
>> 
>> Moving out non-blocking operations isn't necessary.  migrate-cancel
>> could communicate with the migration thread by any suitable mechanism or
>> protocol.  It doesn't have to be QMP.  Why would we want it to be QMP?
>
> Because why invent another wheel?
> This is a command that the management layer has to issue to qemu for
> it to recover, including passing data, in a way similar to other
> commands - so it looks like a QMP command, so why not use QMP.

Point taken.

Minor terminology remark: I'd prefer to call this a reuse of QAPI rather
than QMP, because QMP makes me think of sockets and JSON, while QAPI
makes me think of generated data types and marshaling code.

> Also, I think making other commands lock-free is advantageous - 
> some of the 'info' commands just dont really need locks, making them
> not use locks removes latency effects caused by the management layer
> prodding qemu.

I get the desire to move commands that can block out of whatever loop
runs the monitor.  But moving out commands that always complete quickly
seems pointless: by the time you're done queuing them, you could be done
*executing* them.  More on that below.

>> > Of course this assumes the migration control thread can't block
>> > for locks held by the main thread.
>> 
>> Thanks for your answers, they help.
>> 
>> >> Now let's talk about QMP requirements.
>> >> 
>> >> Any addition to QMP must consider what exists already.
>> >> 
>> >> You may add more of the same.
>> >> 
>> >> You may generalize existing stuff.
>> >> 
>> >> You may change existing stuff if you have sufficient reason, subject to
>> >> backward compatibility constraints.
>> >> 
>> >> But attempts to add new ways to do the same old stuff without properly
>> >> integrating the existing ways are not going to fly.
>> >> 
>> >> In particular, any new way to start some job, monitor and control it
>> >> while it lives, get notified about its state changes and so forth must
>> >> integrate the existing ways.  These include block jobs (probably the
>> >> most sophisticated of the lot), migration, dump-guest-memory, and
>> >> possibly more.  They all work the same way: synchronous command to kick
>> >> off the job, more synchronous commands to monitor and control, events to
>> >> notify.  They do differ in detail.
>> >> 
>> >> Asynchronous commands are a new way to do this.  When you only need to
>> >> be notified on "done", and don't need to monitor / control, they fit the
>> >> bill quite neatly.
>> >> 
>> >> However, we can't just ignore the cases where we need more than that!
>> >> For those, we want a single generic solution instead of the several ad
>> >> hoc solutions we have now.
>> >> 
>> >> If we add asynchronous commands *now*, and for simple cases only, we add
>> >> yet another special case for a future generic solution to integrate.
>> >> I'm not going to let that happen.
>> >
>> > With the async commands suggestion, while it would initially not
>> > provide a way to query incremental status, that could easily be
>> > fitted in.
>> 
>> This is [*] below.
>> 
>> >             Because command replies from async commands may be
>> > out-of-order wrt the original requests, clients would need to
>> > provide a unique ID for each command run. This originally was
>> > part of QMP spec but then dropped, but libvirt still actually
>> > generates a uniqe ID for every QMP command.
>> >
>> > Given this, one option is to actually use the QMP command ID as
>> > a job ID, and let you query ongoing status via some new QMP
>> > command that accepts the ID of the job to be queried. A complexity
>> > with this is how to make the jobs visible across multiple QMP
>> > monitors. The job ID might actually have to be a combination of
>> > the serial ID from the QMP command, and the ID of the monitor
>> > chardev combined.
>> 
>> Yes.  The job ID must be unique across all QMP monitors to make
>> broadcast notifications work.
>> 
>> >> I figure the closest to a generic solution we have is block jobs.
>> >> Perhaps a generic solution could be had by abstracting away the "block"
>> >> from "block jobs", leaving just "jobs".
>> 
>> [*] starts here:
>> 
>> >> Another approach is generalizing the asynchronous command proposal to
>> >> fully cover the not-so-simple cases.
>> 
>> We know asynchronous commands "fully cover" when we can use them to
>> replace all the existing job-like commands.
>> 
>> Until then, they enlarge rather than solve our jobs problem.
>> 
>> I get the need for an available monitor.  But I need to balance it with
>> other needs.  Can we find a solution for our monitor availability
>> problem that doesn't enlarge our jobs problem?
>
> Hopefully!
>
> Dave
>
>> >> If you'd rather want to make progress on monitor availability without
>> >> cracking the "jobs" problem, you're in luck!  Use your license to "add
>> >> more of the same": synchronous command to start a job, query to monitor,
>> >> event to notify.  
>> >> 
>> >> If you insist on tying your monitor availability solution to
>> >> asynchronous commands, then I'm in luck!  I just found volunteers to
>> >> solve the "jobs" problem for me.

Let me try to distill the discussion so far into a design sketch.

1. A QMP monitor runs in a loop.  The loop may execute other stuff, but
   this must not unduly delay the monitor's work.  Thus, everything in
   this loop must complete "quickly".

   All QMP monitors currently run in the main loop, which really should
   satisfy "quickly", but doesn't.  Since fixing that to a tolerable
   degree is beyond our means (is it?), we move them out.

   Design alternative: either one loop and thread per monitor, or one
   loop and thread for all monitors, or something in between.

   I'm wary of "one thread per software artifact" designs.  "One
   (preemptable) thread per activity, all sharing state" is a lousy way
   to structure software.

2. A QMP monitor receives and dispatches commands, and sends command
   responses and events.

   What if sending a response or event would block?  See 6.

3. Arbitrary code can trigger QMP events.  Events are broadcast to all
   QMP monitors.  Each QMP monitor provides an event queue.  When an
   event is triggered, it gets put into all queues, subject to rate
   limiting.

   Rate limiting and queuing needs some shared data, which is protected
   by a mutex.  The critical sections guarded by this mutex must be
   "quick".

   Nothing new here, it's how events work today.

   We could easily add events that go to just one monitor, if there's a
   need.

4. Commands are normally dispatched to a worker thread, where they can
   take their own sweet time to complete.

   Currently, the monitor runs in the main loop and executes commands
   directly.  This is effectively dispatching commands to the main loop.
   Dispatch to main loop is wrong, because it can make the main loop
   hang.  If it was the only relevant cause for main loop hangs, we'd
   move the command work out and be done.  Since it isn't (see 1.) we
   *also* have to move the monitor out to prevent main loop hangs from
   hanging the monitor.

   Moving monitor and command work to separate threads changes the
   dispatch from function call to queuing.  Need a pair of queues, one
   for commands, one for responses.

   Design alternative: one worker per monitor, or one worker for all
   monitors, or main loop is the one worker for all monitors.  The
   latter leaves the main loop hangs unaddressed.  No worse than before,
   so it could be okay as a first step.

   The worker provides the pair of queues.  It executes commands in
   order.  If a command blocks, the command queue stalls.

   The command queue can therefore grow without bounds.  See 6.

5. Certain commands that always complete "quickly" can instead be
   executed directly, at the QMP client's request.  This direct
   execution is out-of-band; the response can "overtake" prior in-band
   commands' responses.

   The amount of work these out-of-band commands do themselves is up to
   them.  A qiuck query command would do all the work.  migrate-cancel
   could perhaps notify the migration thread and be done.  Postcopy
   recovery could perhaps send its argument struct to whatever thread
   handles recovery.

6. Flow control

   We currently leave flow control to the underlying character device.
   If the client sends more quickly than the monitor can execute, the
   client's send eventually blocks or fails with EAGAIN.  If the monitor
   sends more quickly than the client accepts, the monitor buffers
   without bounds (I think).

   Buffering monitor output without bounds is bad.  We could perhaps
   kill a monitor when it exceeds its limit.

   Buffering monitor input (in the command queue) without bounds is just
   as bad.  It also destroys the existing flow control mechanism: the
   client can no longer detect that it's sending too much.  Not an issue
   for fully synchronous clients, i.e. clients that wait for the
   previous command's response before they send the next command.  Such
   clients cannot use of out-of-band command execution.

   The obvious way to limit the command queue is to fail commands when
   the queue is "full".

   Note that we can't send an error response right away then, because
   the command is in-band (if it wasn't, we wouldn't queue it), so its
   response has to go after all all the respones to the (in-band)
   commands currently in the queue.

   To tell the client right away, we could send an event.

   Delaying the "queue full" response until the correct time to send it
   requires state: at least the command ID.  We can just as well enqueue
   and pray memory will suffice.

   Note that the only reason for the command queue is out-of-band
   commands.  Without them, reading the next command is pointless.  This
   leads me to a possible solution: separate out-of-band mode, default
   off, QMP client can switch it on.  When off, we read monitor input
   just like we do now (no queue, no problem).  When on, we read and
   queue.  If the queue is full, we send a "queue full" event with the
   IDs of the commands we dropped on the floor.  By switching on
   out-of-band-mode, the QMP client also opts into this event.

   Switching could be done with QMP capabilities negotiation.

7. How all this is related to "jobs"

   Out-of-band execution is a limited special case of asynchronous
   execution.  With general asynchronous execution, responses can be
   sent in any order.  With out-of-band execution, only the out-of-band
   responses can "jump" order, and only over in-band responses.

   "All commands are (to be treated as) asynchronous" is arguably more
   elegant than this out-of-band thing.  However, it runs into two
   roadblocks that don't apply to out-of-band.

   One, backward compatibility.  That's a roadblock only as much as we
   make it one.

   Two, consistency.  "All asynchronous, but we do most job-like things
   with commands + events anyway" is not acceptable to me.  I'd be
   willing to accept "all asynchronous" when it solves the jobs problem.

   You asked for a solution to the monitor availability problem that
   doesn't require you to solve the jobs problem first.  Well, here's my
   best try.  Go shoot some holes into it :)
