Received: from eggs.gnu.org ([2001:4830:134:3::10]:37778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dq1Et-00076x-Tv
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:09:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dq1Eo-0001Aw-4h
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:09:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dq1En-0001AS-R2
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:09:14 -0400
Date: Thu, 7 Sep 2017 19:09:00 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170907180900.GV2098@work-vm>
References: <20170906104850.GB2215@work-vm> <20170906105414.GL15510@redhat.com>
	<20170906105704.GC2215@work-vm> <20170906110629.GM15510@redhat.com>
	<20170906113157.GD2215@work-vm> <20170906115428.GP15510@redhat.com>
	<20170907081341.GA23040@pxdev.xzpeter.org>
	<87inguaclr.fsf@dusky.pond.sub.org>
	<20170907132259.GM30609@redhat.com>
	<87h8weo186.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h8weo186.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [RFC v2 0/8] monitor: allow per-monitor thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

* Markus Armbruster (armbru@redhat.com) wrote:
> "Daniel P. Berrange" <berrange@redhat.com> writes:
> 
> > On Thu, Sep 07, 2017 at 02:59:28PM +0200, Markus Armbruster wrote:
> >> So, what exactly is going to drain the command queue?  If there's more
> >> than one consumer, how exactly are commands from the queue dispatched to
> >> the consumers?
> >
> > In terms of my proposal, for any single command there should only ever
> > be a single consumer. The default consumer would be the main event loop
> > thread, such that we have no semantic change to QMP operation from today.
> >
> > Some commands that are capable of being made "async", would have a
> > different consumer. For example, if the client requested the 'migrate-cancel'
> > be made async, this would change things such that the migration thread is
> > now responsible for consuming the "migrate-cancel" command, instead of the
> > default main loop.
> >
> >> What are the "no hang" guarantees (if any) and conditions for each of
> >> these consumers?
> >
> > The non-main thread consumers would have to have some reasonable
> > guarantee that they won't block on a lock held by the main loop,
> > otherwise the whole feature is largely useless.
> 
> Same if they block indefinitely on anything else, actually.  In other
> words, we need to talk about liveness.
> 
> Threads by themselves don't buy us liveness.  Being careful with
> operations that may block does.  That care may lead to farming out
> certain operations to other threads, where they may block without harm.
> 
> You only talk about "the non-main thread consumers".  What about the
> main thread?  Is it okay for the main thread to block?  If yes, why?

It would be great if the main thread never blocked; but IMHO that's
a huge task that we'll never get done [challenge].

> >> We can have any number of QMP monitors today.  Would each of them feed
> >> its own queue?  Would they all feed a shared queue?
> >
> > Currently with multiple QMP monitors, everything runs in the main
> > loop, so commands arriving across  multiple monitors are 100%
> > serialized and processed strictly in the order in which QEMU reads
> > them off the wire.  To maintain these semantics, we would need to
> > have a single shared queue for the default main loop consumer, so
> > that ordering does not change.
> >
> >> How exactly is opt-in asynchronous to work?  Per QMP monitor?  Per
> >> command?
> >
> > Per monitor+command. ie just because libvirt knows how to cope with
> > async execution on the monitor it has open, does not mean that a
> > different app on the 2nd monitor command can cope. So in my proposal
> > the switch to async must be scoped to the particular command only
> > for the monitor connection that requesteed it.
> >
> >> What does it mean when an asynchronous command follows a synchronous
> >> command in the same QMP monitor?  I would expect the synchronous command
> >> to complete before the asynchronous command, because that's what
> >> synchronous means, isn't it?  To keep your QMP monitor available, you
> >> then must not send synchronous commands that can hang.
> >
> > No, that is not what I described. All synchronous commands are
> > serialized wrt each other, just as today. An asychronous command
> > can run as soon as it is received, regardless of whether any
> > earlier sent sync commands are still executing or pending. This
> > is trivial to achieve when you separate monitor I/O from command
> > execution in separate threads, provided of course the async
> > command consumers are not in the main loop.
> 
> So, a synchronous command is synchronous with respect to other commands,
> except for certain non-blocking commands.  The distinctive feature of
> the latter isn't so much an asynchronous reply, but out-of-band
> dispatch.
> 
> Out-of-band dispatch of commands that cannot block in fact orthogonal to
> asynchronous replies.  I can't see why out-of-band dispatch of
> synchronous non-blocking commands wouldn't work, too.
> 
> >> How can we determine whether a certain synchronous command can hang?
> >> Note that with opt-in async, *all* commands are also synchronous
> >> commands.
> >> 
> >> In short, explain to me how exactly you plan to ensure that certain QMP
> >> commands (such as post-copy recovery) can always "get through", in the
> >> presence of multiple monitors, hanging main loop, hanging synchronous
> >> commands, hanging whatever-else-can-now-hang-in-this-post-copy-world.
> >
> > Taking migrate-cancel as the example. The migration code already has
> > a background thread doing work independantly onthe main loop. Upon
> > marking the migrate-cancel command as async, the migration control
> > thread would become the consumer of migrate-cancel.
> 
> From 30,000 feet, the QMP monitor sends a "cancel" message to the
> migration thread, and later receives a "canceled" message from the
> migration thread.
> 
> From 300 feet, we use the migrate-cancel QMP command as the cancel
> message, and its success response as the "canceled" message.
> 
> In other words, we're pressing the external QM-Protocol into service as
> internal message passing protocol.

Be careful; it's not a cancel in the postcopy recovery case, it's a
restart.  The command is very much like the migration-incoming command.
The management layer has to provide data with the request, so it's not
an internal command.

> >                                                     This allows the
> > migration operation to be cancelled immediately, regardless of whether
> > there are earlier monitor commands blocked in the main loop.
> 
> The necessary part is moving all operations that can block out of
> whatever loop runs the monitor, be it the main loop, some other event
> loop, or a dedicated monitor thread's monitor loop.
> 
> Moving out non-blocking operations isn't necessary.  migrate-cancel
> could communicate with the migration thread by any suitable mechanism or
> protocol.  It doesn't have to be QMP.  Why would we want it to be QMP?

Because why invent another wheel?
This is a command that the management layer has to issue to qemu for
it to recover, including passing data, in a way similar to other
commands - so it looks like a QMP command, so why not use QMP.

Also, I think making other commands lock-free is advantageous - 
some of the 'info' commands just dont really need locks, making them
not use locks removes latency effects caused by the management layer
prodding qemu.

> > Of course this assumes the migration control thread can't block
> > for locks held by the main thread.
> 
> Thanks for your answers, they help.
> 
> >> Now let's talk about QMP requirements.
> >> 
> >> Any addition to QMP must consider what exists already.
> >> 
> >> You may add more of the same.
> >> 
> >> You may generalize existing stuff.
> >> 
> >> You may change existing stuff if you have sufficient reason, subject to
> >> backward compatibility constraints.
> >> 
> >> But attempts to add new ways to do the same old stuff without properly
> >> integrating the existing ways are not going to fly.
> >> 
> >> In particular, any new way to start some job, monitor and control it
> >> while it lives, get notified about its state changes and so forth must
> >> integrate the existing ways.  These include block jobs (probably the
> >> most sophisticated of the lot), migration, dump-guest-memory, and
> >> possibly more.  They all work the same way: synchronous command to kick
> >> off the job, more synchronous commands to monitor and control, events to
> >> notify.  They do differ in detail.
> >> 
> >> Asynchronous commands are a new way to do this.  When you only need to
> >> be notified on "done", and don't need to monitor / control, they fit the
> >> bill quite neatly.
> >> 
> >> However, we can't just ignore the cases where we need more than that!
> >> For those, we want a single generic solution instead of the several ad
> >> hoc solutions we have now.
> >> 
> >> If we add asynchronous commands *now*, and for simple cases only, we add
> >> yet another special case for a future generic solution to integrate.
> >> I'm not going to let that happen.
> >
> > With the async commands suggestion, while it would initially not
> > provide a way to query incremental status, that could easily be
> > fitted in.
> 
> This is [*] below.
> 
> >             Because command replies from async commands may be
> > out-of-order wrt the original requests, clients would need to
> > provide a unique ID for each command run. This originally was
> > part of QMP spec but then dropped, but libvirt still actually
> > generates a uniqe ID for every QMP command.
> >
> > Given this, one option is to actually use the QMP command ID as
> > a job ID, and let you query ongoing status via some new QMP
> > command that accepts the ID of the job to be queried. A complexity
> > with this is how to make the jobs visible across multiple QMP
> > monitors. The job ID might actually have to be a combination of
> > the serial ID from the QMP command, and the ID of the monitor
> > chardev combined.
> 
> Yes.  The job ID must be unique across all QMP monitors to make
> broadcast notifications work.
> 
> >> I figure the closest to a generic solution we have is block jobs.
> >> Perhaps a generic solution could be had by abstracting away the "block"
> >> from "block jobs", leaving just "jobs".
> 
> [*] starts here:
> 
> >> Another approach is generalizing the asynchronous command proposal to
> >> fully cover the not-so-simple cases.
> 
> We know asynchronous commands "fully cover" when we can use them to
> replace all the existing job-like commands.
> 
> Until then, they enlarge rather than solve our jobs problem.
> 
> I get the need for an available monitor.  But I need to balance it with
> other needs.  Can we find a solution for our monitor availability
> problem that doesn't enlarge our jobs problem?

Hopefully!

Dave

> >> If you'd rather want to make progress on monitor availability without
> >> cracking the "jobs" problem, you're in luck!  Use your license to "add
> >> more of the same": synchronous command to start a job, query to monitor,
> >> event to notify.  
> >> 
> >> If you insist on tying your monitor availability solution to
> >> asynchronous commands, then I'm in luck!  I just found volunteers to
> >> solve the "jobs" problem for me.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
