Received: from eggs.gnu.org ([2001:4830:134:3::10]:40460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eReTE-0006SB-He
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:31:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eReTD-00036J-Ng
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:31:40 -0500
Date: Wed, 20 Dec 2017 21:31:33 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171220133133.GE10812@lemon>
References: <20171220103412.13048-1-kwolf@redhat.com>
	<20171220103412.13048-4-kwolf@redhat.com>
	<20171220131618.GD10812@lemon>
	<20171220132425.GC6374@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171220132425.GC6374@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH 03/19] block: Make bdrv_drain() driver
 callbacks non-recursive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, qemu-devel@nongnu.org

On Wed, 12/20 14:24, Kevin Wolf wrote:
> Am 20.12.2017 um 14:16 hat Fam Zheng geschrieben:
> > On Wed, 12/20 11:33, Kevin Wolf wrote:
> > > bdrv_drain_begin() doesn't increase bs->quiesce_counter recursively,
> > 
> > Pretty trivial but:
> > 
> > s/bdrv_drain_begin/bdrv_drained_begin/
> 
> Yes, thanks.
> 
> > > which means that the child nodes are not actually drained. To keep this
> > > consistent, we also shouldn't call the block driver callbacks.
> > > 
> > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > ---
> > >  block/io.c | 16 +++++++++-------
> > >  1 file changed, 9 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/block/io.c b/block/io.c
> > > index b94740b8ff..91a52e2d82 100644
> > > --- a/block/io.c
> > > +++ b/block/io.c
> > > @@ -158,7 +158,7 @@ static void coroutine_fn bdrv_drain_invoke_entry(void *opaque)
> > >  }
> > >  
> > >  /* Recursively call BlockDriver.bdrv_co_drain_begin/end callbacks */
> > > -static void bdrv_drain_invoke(BlockDriverState *bs, bool begin)
> > > +static void bdrv_drain_invoke(BlockDriverState *bs, bool begin, bool recursive)
> > >  {
> > >      BdrvChild *child, *tmp;
> > >      BdrvCoDrainData data = { .bs = bs, .done = false, .begin = begin};
> > > @@ -172,8 +172,10 @@ static void bdrv_drain_invoke(BlockDriverState *bs, bool begin)
> > >      bdrv_coroutine_enter(bs, data.co);
> > >      BDRV_POLL_WHILE(bs, !data.done);
> > >  
> > > -    QLIST_FOREACH_SAFE(child, &bs->children, next, tmp) {
> > > -        bdrv_drain_invoke(child->bs, begin);
> > > +    if (recursive) {
> > > +        QLIST_FOREACH_SAFE(child, &bs->children, next, tmp) {
> > > +            bdrv_drain_invoke(child->bs, begin, true);
> > > +        }
> > >      }
> > >  }
> > >  
> > > @@ -265,7 +267,7 @@ void bdrv_drained_begin(BlockDriverState *bs)
> > >          bdrv_parent_drained_begin(bs);
> > >      }
> > >  
> > > -    bdrv_drain_invoke(bs, true);
> > > +    bdrv_drain_invoke(bs, true, false);
> > 
> > I'm not sure I understand this patch. If we call bdrv_drained_begin on a quorum
> > BDS that has a QED child, we do want to call bdrv_qed_co_drain_begin() on the
> > child, don't we? I think after this patch, we don't do that any more?
> > 
> > The same question arises when I look at throttle_co_drain_begin()..
> 
> We don't increase bs->quiesce_counter for child nodes and don't notify
> their parents, so they aren't really drained. Calling the BlcokDriver
> callbacks is the only thing we did recursively. We should do one thing
> consistently, and for bdrv_drained_begin/end() that is draining a single
> node without the children.
> 
> Later in the series, I introduce a bdrv_subtree_drained_begin/end()
> which doesn't only call the callbacks recursively, but also increases
> bs->quiesce_counter etc. so that the child nodes are actually drained.
> 
> There are use cases for both functions.
> 

OK, thanks.

Reviewed-by: Fam Zheng <famz@redhat.com>
