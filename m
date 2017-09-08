Received: from eggs.gnu.org ([2001:4830:134:3::10]:58210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqFZv-0006xj-W2
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:28:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqFZm-0001pg-C5
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:27:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dqFZm-0001ox-3W
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:27:50 -0400
Date: Fri, 8 Sep 2017 10:27:38 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170908092738.GB3609@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170906104850.GB2215@work-vm> <20170906105414.GL15510@redhat.com>
	<20170906105704.GC2215@work-vm> <20170906110629.GM15510@redhat.com>
	<20170906113157.GD2215@work-vm> <20170906115428.GP15510@redhat.com>
	<20170907081341.GA23040@pxdev.xzpeter.org>
	<87inguaclr.fsf@dusky.pond.sub.org>
	<20170907132259.GM30609@redhat.com>
	<87h8weo186.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Sep 07, 2017 at 07:41:29PM +0200, Markus Armbruster wrote:
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

It isn't ok, but I feel that challenge is intractable in the short to
medium term. Agree that having separate threads doesn't automatically
give liveness, but I think it makes the problem tractble to solve for
at least a subset of scenarios.

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

The terminology synchronous vs asynchronous is not a great fit for
what I was describing. The distinction is really closer to being
serialized vs parallelizable commands.

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

I don't think we really want to invent yet another way of controlling
QEMU, that isn't QMP do we, particularly not if it is special cased
to just one operationg ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
