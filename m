Received: from eggs.gnu.org ([2001:4830:134:3::10]:50553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dTX1L-0003W3-Ox
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:26:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dTX1H-0002an-O5
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:26:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dTX1H-0002aU-FW
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:26:19 -0400
Date: Fri, 7 Jul 2017 18:26:06 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170707172605.GE2101@work-vm>
References: <20170628190047.26159-1-dgilbert@redhat.com>
	<20170703205127-mutt-send-email-mst@kernel.org>
	<20170707120155.GE2451@work-vm>
	<20170707182830-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170707182830-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [RFC 00/29] postcopy+vhost-user/shared ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, a.perevalov@samsung.com, marcandre.lureau@redhat.com, maxime.coquelin@redhat.com, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com

* Michael S. Tsirkin (mst@redhat.com) wrote:
> On Fri, Jul 07, 2017 at 01:01:56PM +0100, Dr. David Alan Gilbert wrote:
> > > >    Take care of deadlocking; any thread in the client that
> > > >    accesses a userfault protected page can stall.
> > > 
> > > And it can happen under a lock quite easily.
> > > What exactly is proposed here?
> > > Maybe we want to reuse the new channel that the IOMMU uses.
> > 
> > There's no fundamental reason to get deadlocks as long as you
> > get it right; the qemu thread that processes the user-fault's
> > is a separate independent thread, so once it's going the client
> > can do whatever it likes and it will get woken up without
> > intervention.
> 
> You take a lock for the channel, then access guest memory.
> Then the thread that gets messages from qemu can't get
> on the channel to mark range as populated.

It doesn't need to get the message from qemu to know it's populated
though; qemu performs a WAKE ioctl on the userfaultfd to cause
it to wake, so there's no action needed by the client.
(If it does need to take a lock then ye we have a problem).

> > Some care is needed around the postcopy-end; reception of the
> > message that tells you to drop the userfault enables (which
> > frees anything that hasn't been woken) must be allowed to happen
> > for the postcopy complete;  we take care that QEMUs fault
> > thread lives on until that message is acknowledged.
> >
> > I'm more worried about how this will work in a full packet switch
> > when one vhost-user client for an incoming migration stalls
> > the whole switch unless care is taken about the design.
> > How do we figure out whether this is going to fly on a full stack?
> 
> It's performance though. Client could run in a separate
> thread for a while until migration finishes.
> We need to make sure there's explicit documentation
> that tells clients at what point they might block.

Right.

> > That's my main reason for getting this WIP set out here to
> > get comments.
> 
> What will happen if QEMU dies? Is there a way to unblock the client?

If the client can detect this and close it's userfaultfd then yes;
of course that detection has to be done in a thread that can't be being
blocked by anything related to the userfaultfd that it might be blocked
on.

> > > >    There's a nasty hack of a lock around the set_mem_table message.
> > > 
> > > Yes.
> > > 
> > > >    I've not looked at the recent IOMMU code.
> > > > 
> > > >    Some cleanup and a lot of corner cases need thinking about.
> > > > 
> > > >    There are probably plenty of unknown issues as well.
> > > 
> > > At the protocol level, I'd like to rename the feature to
> > > USER_PAGEFAULT. Client does not really know anything about
> > > copies, it's all internal to qemu.
> > > Spec can document that it's used by qemu for postcopy.
> > 
> > OK, tbh I suspect that using it for anything else would be tricky
> > without adding more protocol features for that other use case.
> > 
> > Dave
> 
> Why exactly? How does client have to know it's migration?

It's more the sequence I worry about; we're reliant on
making sure that the userfaultfd is registered with the RAM before
it's ever accessed, and we unregister at the end.
This all keys in with migration requesting registration at the right
point before loading the devices.

Dave

> -- 
> MST
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
