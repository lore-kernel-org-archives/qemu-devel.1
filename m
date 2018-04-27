Received: from eggs.gnu.org ([2001:4830:134:3::10]:42975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fBwJQ-0007uk-C3
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 01:52:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fBwJP-0004Dm-Gx
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 01:52:52 -0400
Date: Fri, 27 Apr 2018 13:52:33 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180427055233.GB4217@lemon.usersys.redhat.com>
References: <20180418030424.28980-1-famz@redhat.com>
	<20180418030424.28980-2-famz@redhat.com>
	<20180426145702.GG30991@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426145702.GG30991@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH v2 1/7] block: Introduce
 API for copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, 04/26 15:57, Stefan Hajnoczi wrote:
> On Wed, Apr 18, 2018 at 11:04:18AM +0800, Fam Zheng wrote:
> > diff --git a/block/io.c b/block/io.c
> > index bd9a19a9c4..d274e9525f 100644
> > --- a/block/io.c
> > +++ b/block/io.c
> > @@ -2826,3 +2826,94 @@ void bdrv_unregister_buf(BlockDriverState *bs, void *host)
> >          bdrv_unregister_buf(child->bs, host);
> >      }
> >  }
> > +
> > +static int bdrv_co_copy_range_internal(BdrvChild *src,
> 
> Please remember to use coroutine_fn for coroutines!  This applies to the
> other functions in this patch too.

OK!

> 
> > +int bdrv_co_copy_range(BdrvChild *src, uint64_t src_offset,
> > +                       BdrvChild *dst, uint64_t dst_offset,
> > +                       uint64_t bytes, BdrvRequestFlags flags)
> > +{
> > +    BdrvTrackedRequest src_req, dst_req;
> > +    BlockDriverState *src_bs = src->bs;
> > +    BlockDriverState *dst_bs = dst->bs;
> > +    int ret;
> > +
> > +    bdrv_inc_in_flight(src_bs);
> > +    bdrv_inc_in_flight(dst_bs);
> > +    tracked_request_begin(&src_req, src_bs, src_offset,
> > +                          bytes, BDRV_TRACKED_READ);
> > +    tracked_request_begin(&dst_req, dst_bs, dst_offset,
> > +                          bytes, BDRV_TRACKED_WRITE);
> 
> Tracked requests and in-flight counters are only updated on root nodes.
> This is not how read/write works.  Does drain work on an internal or
> leaf node with multiple parents?

Telling from how bdrv_do_drained_begin is implemented now (recursive both to
parents and children), I think it should work. But you are right this is
inconsistent with read/write code, it seems I could move this it to
bdrv_co_copy_range_internal.

> 
> > diff --git a/include/block/block.h b/include/block/block.h
> > index cdec3639a3..72ac011b2b 100644
> > --- a/include/block/block.h
> > +++ b/include/block/block.h
> > @@ -604,4 +604,8 @@ bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
> >   */
> >  void bdrv_register_buf(BlockDriverState *bs, void *host, size_t size);
> >  void bdrv_unregister_buf(BlockDriverState *bs, void *host);
> > +
> > +int bdrv_co_copy_range(BdrvChild *bs, uint64_t offset,
> > +                       BdrvChild *src, uint64_t src_offset,
> > +                       uint64_t bytes, BdrvRequestFlags flags);
> 
> Please document this new block.h API.

OK.

> 
> These arguments are in the wrong order!  The first BdrvChild is the
> source and the second is the destination.

Right, will fix.

Fam
