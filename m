Received: from eggs.gnu.org ([2001:4830:134:3::10]:58168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eswCl-0006W3-2t
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 14:55:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eswCh-0007EK-K3
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 14:55:27 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36184 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eswCh-0007EC-DX
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 14:55:23 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA4C0402291E
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 19:55:22 +0000 (UTC)
Date: Mon, 5 Mar 2018 19:55:13 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180305195513.GW3131@work-vm>
References: <20180216131625.9639-1-dgilbert@redhat.com>
	<20180216131625.9639-21-dgilbert@redhat.com>
	<20180302075107.GM27381@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302075107.GM27381@xz-mi>
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
> On Fri, Feb 16, 2018 at 01:16:16PM +0000, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Add a hook to allow a client userfaultfd to be 'woken'
> > when a page arrives, and a walker that calls that
> > hook for relevant clients given a RAMBlock and offset.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  migration/postcopy-ram.c | 16 ++++++++++++++++
> >  migration/postcopy-ram.h | 10 ++++++++++
> >  2 files changed, 26 insertions(+)
> > 
> > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > index 67deae7e1c..879711968c 100644
> > --- a/migration/postcopy-ram.c
> > +++ b/migration/postcopy-ram.c
> > @@ -824,6 +824,22 @@ static int qemu_ufd_copy_ioctl(int userfault_fd, void *host_addr,
> >      return ret;
> >  }
> >  
> > +int postcopy_notify_shared_wake(RAMBlock *rb, uint64_t offset)
> > +{
> > +    int i;
> > +    MigrationIncomingState *mis = migration_incoming_get_current();
> > +    GArray *pcrfds = mis->postcopy_remote_fds;
> > +
> > +    for (i = 0; i < pcrfds->len; i++) {
> > +        struct PostCopyFD *cur = &g_array_index(pcrfds, struct PostCopyFD, i);
> > +        int ret = cur->waker(cur, rb, offset);
> > +        if (ret) {
> > +            return ret;
> > +        }
> > +    }
> > +    return 0;
> > +}
> > +
> 
> We should know that which FD needs what pages, right?  If with that
> information, we can only notify the ones who have page faulted on
> exactly the same page?  Otherwise we do UFFDIO_WAKE once for each
> client when a page is ready, even if the clients have not page faulted
> at all?

The 'waker' function we call knows that, we don't; see the
'vhost_user_postcopy_waker' in the next patch, and it hunts down whether
the address the waker is called for is one it's responsible for.
Also note that a shared page might be shared between multiple other
programs - not just one.  In our case that could be two vhost-user
devices wired to two separate processes.

> But for the first version, I think it's fine.  And I believe if we
> maintain the faulted addresses we need some way to sync between the
> wake thread and fault thread too.

Hmm can you explain that a bit more?

> And I totally have no idea on how
> this difference will be any kind of bottle neck at all, since I guess
> the network link should still be the postcopy bottleneck considering
> that 10g is mostly what we have now (or even, 1g).
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks.

Dave

> 
> >  /*
> >   * Place a host page (from) at (host) atomically
> >   * returns 0 on success
> > diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
> > index 2e3dd844d5..2b71cf958e 100644
> > --- a/migration/postcopy-ram.h
> > +++ b/migration/postcopy-ram.h
> > @@ -146,6 +146,10 @@ struct PostCopyFD;
> >  
> >  /* ufd is a pointer to the struct uffd_msg *TODO: more Portable! */
> >  typedef int (*pcfdhandler)(struct PostCopyFD *pcfd, void *ufd);
> > +/* Notification to wake, either on place or on reception of
> > + * a fault on something that's already arrived (race)
> > + */
> > +typedef int (*pcfdwake)(struct PostCopyFD *pcfd, RAMBlock *rb, uint64_t offset);
> >  
> >  struct PostCopyFD {
> >      int fd;
> > @@ -153,6 +157,8 @@ struct PostCopyFD {
> >      void *data;
> >      /* Handler to be called whenever we get a poll event */
> >      pcfdhandler handler;
> > +    /* Notification to wake shared client */
> > +    pcfdwake waker;
> >      /* A string to use in error messages */
> >      const char *idstr;
> >  };
> > @@ -162,6 +168,10 @@ struct PostCopyFD {
> >   */
> >  void postcopy_register_shared_ufd(struct PostCopyFD *pcfd);
> >  void postcopy_unregister_shared_ufd(struct PostCopyFD *pcfd);
> > +/* Call each of the shared 'waker's registerd telling them of
> > + * availability of a block.
> > + */
> > +int postcopy_notify_shared_wake(RAMBlock *rb, uint64_t offset);
> >  /* Notify a client ufd that a page is available
> >   * Note: The 'client_address' is in the address space of the client
> >   * program not QEMU
> > -- 
> > 2.14.3
> > 
> 
> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
