Received: from eggs.gnu.org ([2001:4830:134:3::10]:54509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpwm8-0006uD-Oh
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:23:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpwm0-0004oh-HI
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:23:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dpwm0-0004oG-7y
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:23:12 -0400
Date: Thu, 7 Sep 2017 14:22:59 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170907132259.GM30609@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170906094846.GA2215@work-vm> <20170906104603.GK15510@redhat.com>
	<20170906104850.GB2215@work-vm> <20170906105414.GL15510@redhat.com>
	<20170906105704.GC2215@work-vm> <20170906110629.GM15510@redhat.com>
	<20170906113157.GD2215@work-vm> <20170906115428.GP15510@redhat.com>
	<20170907081341.GA23040@pxdev.xzpeter.org>
	<87inguaclr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87inguaclr.fsf@dusky.pond.sub.org>
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
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

On Thu, Sep 07, 2017 at 02:59:28PM +0200, Markus Armbruster wrote:
> So, what exactly is going to drain the command queue?  If there's more
> than one consumer, how exactly are commands from the queue dispatched to
> the consumers?

In terms of my proposal, for any single command there should only ever
be a single consumer. The default consumer would be the main event loop
thread, such that we have no semantic change to QMP operation from today.

Some commands that are capable of being made "async", would have a
different consumer. For example, if the client requested the 'migrate-cancel'
be made async, this would change things such that the migration thread is
now responsible for consuming the "migrate-cancel" command, instead of the
default main loop.

> What are the "no hang" guarantees (if any) and conditions for each of
> these consumers?

The non-main thread consumers would have to have some reasonable
guarantee that they won't block on a lock held by the main loop,
otherwise the whole feature is largely useless.

> We can have any number of QMP monitors today.  Would each of them feed
> its own queue?  Would they all feed a shared queue?

Currently with multiple QMP monitors, everything runs in the main
loop, so commands arriving across  multiple monitors are 100%
serialized and processed strictly in the order in which QEMU reads
them off the wire.  To maintain these semantics, we would need to
have a single shared queue for the default main loop consumer, so
that ordering does not change.

> How exactly is opt-in asynchronous to work?  Per QMP monitor?  Per
> command?

Per monitor+command. ie just because libvirt knows how to cope with
async execution on the monitor it has open, does not mean that a
different app on the 2nd monitor command can cope. So in my proposal
the switch to async must be scoped to the particular command only
for the monitor connection that requesteed it.

> What does it mean when an asynchronous command follows a synchronous
> command in the same QMP monitor?  I would expect the synchronous command
> to complete before the asynchronous command, because that's what
> synchronous means, isn't it?  To keep your QMP monitor available, you
> then must not send synchronous commands that can hang.

No, that is not what I described. All synchronous commands are
serialized wrt each other, just as today. An asychronous command
can run as soon as it is received, regardless of whether any
earlier sent sync commands are still executing or pending. This
is trivial to achieve when you separate monitor I/O from command
execution in separate threads, provided of course the async
command consumers are not in the main loop.

> How can we determine whether a certain synchronous command can hang?
> Note that with opt-in async, *all* commands are also synchronous
> commands.
> 
> In short, explain to me how exactly you plan to ensure that certain QMP
> commands (such as post-copy recovery) can always "get through", in the
> presence of multiple monitors, hanging main loop, hanging synchronous
> commands, hanging whatever-else-can-now-hang-in-this-post-copy-world.

Taking migrate-cancel as the example. The migration code already has
a background thread doing work independantly onthe main loop. Upon
marking the migrate-cancel command as async, the migration control
thread would become the consumer of migrate-cancel. This allows the
migration operation to be cancelled immediately, regardless of whether
there are earlier monitor commands blocked in the main loop.

Of course this assumes the migration control thread can't block
for locks held by the main thread. 

> Now let's talk about QMP requirements.
> 
> Any addition to QMP must consider what exists already.
> 
> You may add more of the same.
> 
> You may generalize existing stuff.
> 
> You may change existing stuff if you have sufficient reason, subject to
> backward compatibility constraints.
> 
> But attempts to add new ways to do the same old stuff without properly
> integrating the existing ways are not going to fly.
> 
> In particular, any new way to start some job, monitor and control it
> while it lives, get notified about its state changes and so forth must
> integrate the existing ways.  These include block jobs (probably the
> most sophisticated of the lot), migration, dump-guest-memory, and
> possibly more.  They all work the same way: synchronous command to kick
> off the job, more synchronous commands to monitor and control, events to
> notify.  They do differ in detail.
> 
> Asynchronous commands are a new way to do this.  When you only need to
> be notified on "done", and don't need to monitor / control, they fit the
> bill quite neatly.
> 
> However, we can't just ignore the cases where we need more than that!
> For those, we want a single generic solution instead of the several ad
> hoc solutions we have now.
> 
> If we add asynchronous commands *now*, and for simple cases only, we add
> yet another special case for a future generic solution to integrate.
> I'm not going to let that happen.

With the async commands suggestion, while it would initially not
provide a way to query incremental status, that could easily be
fitted in.  Because command replies from async commands may be
out-of-order wrt the original requests, clients would need to
provide a unique ID for each command run. This originally was
part of QMP spec but then dropped, but libvirt still actually
generates a uniqe ID for every QMP command.

Given this, one option is to actually use the QMP command ID as
a job ID, and let you query ongoing status via some new QMP
command that accepts the ID of the job to be queried. A complexity
with this is how to make the jobs visible across multiple QMP
monitors. The job ID might actually have to be a combination of
the serial ID from the QMP command, and the ID of the monitor
chardev combined.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
