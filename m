Received: from eggs.gnu.org ([2001:4830:134:3::10]:35769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cviAT-0007IT-Qb
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 06:28:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cviAQ-0003pP-Fh
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 06:28:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cviAQ-0003ox-7D
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 06:27:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1F7C580480
	for <qemu-devel@nongnu.org>; Wed,  5 Apr 2017 10:27:56 +0000 (UTC)
Date: Wed, 5 Apr 2017 11:27:50 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170405102749.GA4066@work-vm>
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-31-quintela@redhat.com>
	<20170330065652.GH20667@pxdev.xzpeter.org>
	<20170331152555.GN4514@work-vm>
	<20170401071501.GM3981@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170401071501.GM3981@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH 30/51] ram: Move src_page_req* to RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org

* Peter Xu (peterx@redhat.com) wrote:
> On Fri, Mar 31, 2017 at 04:25:56PM +0100, Dr. David Alan Gilbert wrote:
> > * Peter Xu (peterx@redhat.com) wrote:
> > > On Thu, Mar 23, 2017 at 09:45:23PM +0100, Juan Quintela wrote:
> > > > This are the last postcopy fields still at MigrationState.  Once there
> > > 
> > > s/This/These/
> > > 
> > > > Move MigrationSrcPageRequest to ram.c and remove MigrationState
> > > > parameters where appropiate.
> > > > 
> > > > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > > 
> > > Reviewed-by: Peter Xu <peterx@redhat.com>
> > > 
> > > One question below though...
> > > 
> > > [...]
> > > 
> > > > @@ -1191,19 +1204,18 @@ static bool get_queued_page(RAMState *rs, MigrationState *ms,
> > > >   *
> > > >   * It should be empty at the end anyway, but in error cases there may
> > > >   * xbe some left.
> > > > - *
> > > > - * @ms: current migration state
> > > >   */
> > > > -void flush_page_queue(MigrationState *ms)
> > > > +void flush_page_queue(void)
> > > >  {
> > > > -    struct MigrationSrcPageRequest *mspr, *next_mspr;
> > > > +    struct RAMSrcPageRequest *mspr, *next_mspr;
> > > > +    RAMState *rs = &ram_state;
> > > >      /* This queue generally should be empty - but in the case of a failed
> > > >       * migration might have some droppings in.
> > > >       */
> > > >      rcu_read_lock();
> > > 
> > > Could I ask why we are taking the RCU read lock rather than the mutex
> > > here?
> > 
> > It's a good question whether we need anything at all.
> > flush_page_queue is called only from migrate_fd_cleanup.
> > migrate_fd_cleanup is called either from a backhalf, which I think has the bql,
> > or from a failure path in migrate_fd_connect.
> > migrate_fd_connect is called from migration_channel_connect and rdma_start_outgoing_migration
> > which I think both end up at monitor commands so also in the bql.
> > 
> > So I think we can probably just lose the rcu_read_lock/unlock.
> 
> Thanks for the confirmation.
> 
> (ps: even if we are not with bql, we should not need this
>  rcu_read_lock, right? My understanding is: if we want to protect
>  src_page_requests, we should need the mutex, not rcu lock; while for
>  the memory_region_unref() since we have had the reference, looks like
>  we don't need any kind of locking either)

Right; I guess the memory_region_unref might cause the memory region
to be cleanup up in that loop without the rcu locks, but I don't think
it's a problem even if they are cleaned up.

Dave

> > 
> > Dave
> > 
> > > 
> > > > -    QSIMPLEQ_FOREACH_SAFE(mspr, &ms->src_page_requests, next_req, next_mspr) {
> > > > +    QSIMPLEQ_FOREACH_SAFE(mspr, &rs->src_page_requests, next_req, next_mspr) {
> > > >          memory_region_unref(mspr->rb->mr);
> > > > -        QSIMPLEQ_REMOVE_HEAD(&ms->src_page_requests, next_req);
> > > > +        QSIMPLEQ_REMOVE_HEAD(&rs->src_page_requests, next_req);
> > > >          g_free(mspr);
> > > >      }
> > > >      rcu_read_unlock();
> > > 
> > > Thanks,
> > > 
> > > -- peterx
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
> -- peterx
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
