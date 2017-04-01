Received: from eggs.gnu.org ([2001:4830:134:3::10]:48354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cuDFk-0001qd-3a
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 03:15:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cuDFd-0005Nt-V7
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 03:15:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cuDFd-0005MU-MT
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 03:15:09 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DBEE9C057EC9
	for <qemu-devel@nongnu.org>; Sat,  1 Apr 2017 07:15:07 +0000 (UTC)
Date: Sat, 1 Apr 2017 15:15:01 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170401071501.GM3981@pxdev.xzpeter.org>
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-31-quintela@redhat.com>
	<20170330065652.GH20667@pxdev.xzpeter.org>
	<20170331152555.GN4514@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170331152555.GN4514@work-vm>
Subject: Re: [Qemu-devel] [PATCH 30/51] ram: Move src_page_req* to RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org

On Fri, Mar 31, 2017 at 04:25:56PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Thu, Mar 23, 2017 at 09:45:23PM +0100, Juan Quintela wrote:
> > > This are the last postcopy fields still at MigrationState.  Once there
> > 
> > s/This/These/
> > 
> > > Move MigrationSrcPageRequest to ram.c and remove MigrationState
> > > parameters where appropiate.
> > > 
> > > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > 
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > 
> > One question below though...
> > 
> > [...]
> > 
> > > @@ -1191,19 +1204,18 @@ static bool get_queued_page(RAMState *rs, MigrationState *ms,
> > >   *
> > >   * It should be empty at the end anyway, but in error cases there may
> > >   * xbe some left.
> > > - *
> > > - * @ms: current migration state
> > >   */
> > > -void flush_page_queue(MigrationState *ms)
> > > +void flush_page_queue(void)
> > >  {
> > > -    struct MigrationSrcPageRequest *mspr, *next_mspr;
> > > +    struct RAMSrcPageRequest *mspr, *next_mspr;
> > > +    RAMState *rs = &ram_state;
> > >      /* This queue generally should be empty - but in the case of a failed
> > >       * migration might have some droppings in.
> > >       */
> > >      rcu_read_lock();
> > 
> > Could I ask why we are taking the RCU read lock rather than the mutex
> > here?
> 
> It's a good question whether we need anything at all.
> flush_page_queue is called only from migrate_fd_cleanup.
> migrate_fd_cleanup is called either from a backhalf, which I think has the bql,
> or from a failure path in migrate_fd_connect.
> migrate_fd_connect is called from migration_channel_connect and rdma_start_outgoing_migration
> which I think both end up at monitor commands so also in the bql.
> 
> So I think we can probably just lose the rcu_read_lock/unlock.

Thanks for the confirmation.

(ps: even if we are not with bql, we should not need this
 rcu_read_lock, right? My understanding is: if we want to protect
 src_page_requests, we should need the mutex, not rcu lock; while for
 the memory_region_unref() since we have had the reference, looks like
 we don't need any kind of locking either)

> 
> Dave
> 
> > 
> > > -    QSIMPLEQ_FOREACH_SAFE(mspr, &ms->src_page_requests, next_req, next_mspr) {
> > > +    QSIMPLEQ_FOREACH_SAFE(mspr, &rs->src_page_requests, next_req, next_mspr) {
> > >          memory_region_unref(mspr->rb->mr);
> > > -        QSIMPLEQ_REMOVE_HEAD(&ms->src_page_requests, next_req);
> > > +        QSIMPLEQ_REMOVE_HEAD(&rs->src_page_requests, next_req);
> > >          g_free(mspr);
> > >      }
> > >      rcu_read_unlock();
> > 
> > Thanks,
> > 
> > -- peterx
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- peterx
