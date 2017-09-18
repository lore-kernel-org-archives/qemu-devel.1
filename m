Received: from eggs.gnu.org ([2001:4830:134:3::10]:58298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dtqig-0008O1-Uc
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 03:43:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dtqif-0000Cg-Rh
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 03:43:55 -0400
Date: Mon, 18 Sep 2017 09:43:44 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170918074344.GC31915@localhost.localdomain>
References: <20170915101008.16646-1-kwolf@redhat.com>
	<20170915101008.16646-7-kwolf@redhat.com>
	<20170918073741.GJ15551@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170918073741.GJ15551@lemon.lan>
Subject: Re: [Qemu-devel] [PATCH 6/6] block: Fix permissions after
 bdrv_reopen()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, qemu-devel@nongnu.org

Am 18.09.2017 um 09:37 hat Fam Zheng geschrieben:
> On Fri, 09/15 12:10, Kevin Wolf wrote:
> > If we switch between read-only and read-write, the permissions that
> > image format drivers need on bs->file change, too. Make sure to update
> > the permissions during bdrv_reopen().
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  include/block/block.h |  1 +
> >  block.c               | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 65 insertions(+)
> > 
> > diff --git a/include/block/block.h b/include/block/block.h
> > index 082eb2cd9c..3c3af462e4 100644
> > --- a/include/block/block.h
> > +++ b/include/block/block.h
> > @@ -166,6 +166,7 @@ typedef QSIMPLEQ_HEAD(BlockReopenQueue, BlockReopenQueueEntry) BlockReopenQueue;
> >  typedef struct BDRVReopenState {
> >      BlockDriverState *bs;
> >      int flags;
> > +    uint64_t perm, shared_perm;
> >      QDict *options;
> >      QDict *explicit_options;
> >      void *opaque;
> > diff --git a/block.c b/block.c
> > index 204cbb46c7..5c65fac672 100644
> > --- a/block.c
> > +++ b/block.c
> > @@ -2781,6 +2781,10 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
> >      bs_entry->state.explicit_options = explicit_options;
> >      bs_entry->state.flags = flags;
> >  
> > +    /* This needs to be overwritten in bdrv_reopen_prepare() */
> > +    bs_entry->state.perm = UINT64_MAX;
> 
> Probably doesn't matter because as the comment says it will be overwritten soon,
> but is BLK_PERM_ALL more appropriate?

I had BLK_PERM_ALL at first, but after debugging some assertion failures
in gdb, I came to the conclusion that UINT64_MAX is easier to identify as
uninitialised than BLK_PERM_ALL, which could be a valid result of the
permission calculation.

Kevin
