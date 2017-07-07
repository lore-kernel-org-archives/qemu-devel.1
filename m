Received: from eggs.gnu.org ([2001:4830:134:3::10]:42741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dTVIg-0006Cl-C7
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dTVId-0004oJ-5N
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:36:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dTVIc-0004mX-Sq
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:36:07 -0400
Date: Fri, 7 Jul 2017 18:35:56 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170707182830-mutt-send-email-mst@kernel.org>
References: <20170628190047.26159-1-dgilbert@redhat.com>
	<20170703205127-mutt-send-email-mst@kernel.org>
	<20170707120155.GE2451@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170707120155.GE2451@work-vm>
Subject: Re: [Qemu-devel] [RFC 00/29] postcopy+vhost-user/shared ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, a.perevalov@samsung.com, marcandre.lureau@redhat.com, maxime.coquelin@redhat.com, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com

On Fri, Jul 07, 2017 at 01:01:56PM +0100, Dr. David Alan Gilbert wrote:
> > >    Take care of deadlocking; any thread in the client that
> > >    accesses a userfault protected page can stall.
> > 
> > And it can happen under a lock quite easily.
> > What exactly is proposed here?
> > Maybe we want to reuse the new channel that the IOMMU uses.
> 
> There's no fundamental reason to get deadlocks as long as you
> get it right; the qemu thread that processes the user-fault's
> is a separate independent thread, so once it's going the client
> can do whatever it likes and it will get woken up without
> intervention.

You take a lock for the channel, then access guest memory.
Then the thread that gets messages from qemu can't get
on the channel to mark range as populated.

> Some care is needed around the postcopy-end; reception of the
> message that tells you to drop the userfault enables (which
> frees anything that hasn't been woken) must be allowed to happen
> for the postcopy complete;  we take care that QEMUs fault
> thread lives on until that message is acknowledged.
>
> I'm more worried about how this will work in a full packet switch
> when one vhost-user client for an incoming migration stalls
> the whole switch unless care is taken about the design.
> How do we figure out whether this is going to fly on a full stack?

It's performance though. Client could run in a separate
thread for a while until migration finishes.
We need to make sure there's explicit documentation
that tells clients at what point they might block.

> That's my main reason for getting this WIP set out here to
> get comments.

What will happen if QEMU dies? Is there a way to unblock the client?

> > >    There's a nasty hack of a lock around the set_mem_table message.
> > 
> > Yes.
> > 
> > >    I've not looked at the recent IOMMU code.
> > > 
> > >    Some cleanup and a lot of corner cases need thinking about.
> > > 
> > >    There are probably plenty of unknown issues as well.
> > 
> > At the protocol level, I'd like to rename the feature to
> > USER_PAGEFAULT. Client does not really know anything about
> > copies, it's all internal to qemu.
> > Spec can document that it's used by qemu for postcopy.
> 
> OK, tbh I suspect that using it for anything else would be tricky
> without adding more protocol features for that other use case.
> 
> Dave

Why exactly? How does client have to know it's migration?

-- 
MST
