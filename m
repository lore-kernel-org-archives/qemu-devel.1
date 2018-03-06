Received: from eggs.gnu.org ([2001:4830:134:3::10]:45603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1etAEu-0006YL-1D
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:54:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1etAEp-00083s-6r
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:54:36 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59498 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1etAEp-00083e-1H
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:54:31 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8CD4A4040859
	for <qemu-devel@nongnu.org>; Tue,  6 Mar 2018 10:54:30 +0000 (UTC)
Date: Tue, 6 Mar 2018 10:54:18 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180306105418.GD3096@work-vm>
References: <20180216131625.9639-1-dgilbert@redhat.com>
	<20180216131625.9639-21-dgilbert@redhat.com>
	<20180302075107.GM27381@xz-mi> <20180305195513.GW3131@work-vm>
	<20180306033736.GA3615@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306033736.GA3615@xz-mi>
Subject: Re: [Qemu-devel] [PATCH v3 20/29] postcopy:
 postcopy_notify_shared_wake
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, imammedo@redhat.com, mst@redhat.com, quintela@redhat.com, aarcange@redhat.com

* Peter Xu (peterx@redhat.com) wrote:
> On Mon, Mar 05, 2018 at 07:55:13PM +0000, Dr. David Alan Gilbert wrote:
> > * Peter Xu (peterx@redhat.com) wrote:
> > > On Fri, Feb 16, 2018 at 01:16:16PM +0000, Dr. David Alan Gilbert (git) wrote:
> > > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > > 
> > > > Add a hook to allow a client userfaultfd to be 'woken'
> > > > when a page arrives, and a walker that calls that
> > > > hook for relevant clients given a RAMBlock and offset.
> > > > 
> > > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > > ---
> > > >  migration/postcopy-ram.c | 16 ++++++++++++++++
> > > >  migration/postcopy-ram.h | 10 ++++++++++
> > > >  2 files changed, 26 insertions(+)
> > > > 
> > > > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > > > index 67deae7e1c..879711968c 100644
> > > > --- a/migration/postcopy-ram.c
> > > > +++ b/migration/postcopy-ram.c
> > > > @@ -824,6 +824,22 @@ static int qemu_ufd_copy_ioctl(int userfault_fd, void *host_addr,
> > > >      return ret;
> > > >  }
> > > >  
> > > > +int postcopy_notify_shared_wake(RAMBlock *rb, uint64_t offset)
> > > > +{
> > > > +    int i;
> > > > +    MigrationIncomingState *mis = migration_incoming_get_current();
> > > > +    GArray *pcrfds = mis->postcopy_remote_fds;
> > > > +
> > > > +    for (i = 0; i < pcrfds->len; i++) {
> > > > +        struct PostCopyFD *cur = &g_array_index(pcrfds, struct PostCopyFD, i);
> > > > +        int ret = cur->waker(cur, rb, offset);
> > > > +        if (ret) {
> > > > +            return ret;
> > > > +        }
> > > > +    }
> > > > +    return 0;
> > > > +}
> > > > +
> > > 
> > > We should know that which FD needs what pages, right?  If with that
> > > information, we can only notify the ones who have page faulted on
> > > exactly the same page?  Otherwise we do UFFDIO_WAKE once for each
> > > client when a page is ready, even if the clients have not page faulted
> > > at all?
> > 
> > The 'waker' function we call knows that, we don't; see the
> > 'vhost_user_postcopy_waker' in the next patch, and it hunts down whether
> > the address the waker is called for is one it's responsible for.
> 
> For vhost-user devices, they should be always responsible for mostly
> all RAM exported on the guest?  If so, they will always be notified to
> wake up if a page is copied?

Right; but this patch isn't vhost-user specific; this is more general.

> Here I was thinking not only about responsible ranges - It was about
> whether each PostcopyFD could note down the faulted addresses that
> were waiting to be service.  Then when we do the wake up, we could
> possibly skip notifying the PostcopyFD when the copied page is not
> covering any of the faulted addresses on that PostcopyFD?

Yes, that would be possible - in this case I made that the job of
the device that had registered (i.e. the waker method) rather than
the core postcopy code.

> > Also note that a shared page might be shared between multiple other
> > programs - not just one.  In our case that could be two vhost-user
> > devices wired to two separate processes.
> 
> Yeah, but the idea still stands IMHO - we can notify only those
> PostcopyFDs that have faulted on the page already and skip the rest.
> For sure there can be more than one candidate for the wakeup, since
> there can be multiple PostcopyFDs that captured page fault on the same
> page (or even, same address).
> 
> > 
> > > But for the first version, I think it's fine.  And I believe if we
> > > maintain the faulted addresses we need some way to sync between the
> > > wake thread and fault thread too.
> > 
> > Hmm can you explain that a bit more?
> 
> Basically above was what I thought - to record the faulted addresses
> with specific PostcopyFD when page fault happened, then we may know
> which page(s) will a PostcopyFD need.  But when with that, we'll
> possibly need a lock to protect the information (or any other sync
> method).

OK, but I think you're suggesting building a whole new data structure to
know which ones need notifying;  that sounds like a lot of extra
complexity for not much gain.

Dave

> (Hope I didn't miss anything important along the way)
> 
> Thanks,
> 
> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
