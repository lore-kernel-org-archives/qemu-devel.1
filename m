Received: from eggs.gnu.org ([209.51.188.92]:49329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gmhzL-0002R2-Aq
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 11:36:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gmhzJ-0002Ni-4S
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 11:36:23 -0500
Date: Thu, 24 Jan 2019 17:36:14 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190124163614.GM4601@localhost.localdomain>
References: <20190124141731.21509-1-kwolf@redhat.com>
	<bcf01a3b-fea8-d170-416a-f04d78a63822@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcf01a3b-fea8-d170-416a-f04d78a63822@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] file-posix: Cache lseek result for data
 regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Am 24.01.2019 um 17:18 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 24.01.2019 17:17, Kevin Wolf wrote:
> > Depending on the exact image layout and the storage backend (tmpfs is
> > konwn to have very slow SEEK_HOLE/SEEK_DATA), caching lseek results can
> > save us a lot of time e.g. during a mirror block job or qemu-img convert
> > with a fragmented source image (.bdrv_co_block_status on the protocol
> > layer can be called for every single cluster in the extreme case).
> > 
> > We may only cache data regions because of possible concurrent writers.
> > This means that we can later treat a recently punched hole as data, but
> > this is safe. We can't cache holes because then we might treat recently
> > written data as holes, which can cause corruption.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>

> > @@ -1555,8 +1561,17 @@ static int handle_aiocb_write_zeroes_unmap(void *opaque)
> >   {
> >       RawPosixAIOData *aiocb = opaque;
> >       BDRVRawState *s G_GNUC_UNUSED = aiocb->bs->opaque;
> > +    struct seek_data_cache *sdc;
> >       int ret;
> >   
> > +    /* Invalidate seek_data_cache if it overlaps */
> > +    sdc = &s->seek_data_cache;
> > +    if (sdc->valid && !(sdc->end < aiocb->aio_offset ||
> > +                        sdc->start > aiocb->aio_offset + aiocb->aio_nbytes))
> 
> to be presize: <= and >=

Yes, you're right.

> > +    {
> > +        sdc->valid = false;
> > +    }
> > +
> >       /* First try to write zeros and unmap at the same time */
> >   
> 
> 
> Why not to drop cache on handle_aiocb_write_zeroes()? Otherwise, we'll return DATA
> for these regions which may unallocated read-as-zero, if I'm not mistaken.

handle_aiocb_write_zeroes() is not allowed to unmap things, so we don't
need to invalidate the cache there.

> >   #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
> > @@ -1634,11 +1649,20 @@ static int handle_aiocb_discard(void *opaque)
> >       RawPosixAIOData *aiocb = opaque;
> >       int ret = -EOPNOTSUPP;
> >       BDRVRawState *s = aiocb->bs->opaque;
> > +    struct seek_data_cache *sdc;
> >   
> >       if (!s->has_discard) {
> >           return -ENOTSUP;
> >       }
> >   
> > +    /* Invalidate seek_data_cache if it overlaps */
> > +    sdc = &s->seek_data_cache;
> > +    if (sdc->valid && !(sdc->end < aiocb->aio_offset ||
> > +                        sdc->start > aiocb->aio_offset + aiocb->aio_nbytes))
> 
> and <= and >=
> 
> and if add same to handle_aiocb_write_zeroes(), then it worth to
> create helper function to invalidate cache.

Ok.

> > +    {
> > +        sdc->valid = false;
> > +    }
> > +
> >       if (aiocb->aio_type & QEMU_AIO_BLKDEV) {
> >   #ifdef BLKDISCARD
> >           do {
> > @@ -2424,6 +2448,8 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
> >                                               int64_t *map,
> >                                               BlockDriverState **file)
> >   {
> > +    BDRVRawState *s = bs->opaque;
> > +    struct seek_data_cache *sdc;
> >       off_t data = 0, hole = 0;
> >       int ret;
> >   
> > @@ -2439,6 +2465,14 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
> >           return BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID;
> >       }
> >   
> > +    sdc = &s->seek_data_cache;
> > +    if (sdc->valid && sdc->start <= offset && sdc->end > offset) {
> > +        *pnum = MIN(bytes, sdc->end - offset);
> > +        *map = offset;
> > +        *file = bs;
> > +        return BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID;
> > +    }
> > +
> >       ret = find_allocation(bs, offset, &data, &hole);
> >       if (ret == -ENXIO) {
> >           /* Trailing hole */
> > @@ -2451,14 +2485,27 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
> >       } else if (data == offset) {
> >           /* On a data extent, compute bytes to the end of the extent,
> >            * possibly including a partial sector at EOF. */
> > -        *pnum = MIN(bytes, hole - offset);
> > +        *pnum = hole - offset;
> 
> hmm, why? At least you didn't mention it in commit-message..

We want to cache the whole range returned by lseek(), not just whatever
the raw_co_block_status() caller wanted to know.

For the returned value, *pnum is adjusted to MIN(bytes, *pnum) below...

> >           ret = BDRV_BLOCK_DATA;
> >       } else {
> >           /* On a hole, compute bytes to the beginning of the next extent.  */
> >           assert(hole == offset);
> > -        *pnum = MIN(bytes, data - offset);
> > +        *pnum = data - offset;
> >           ret = BDRV_BLOCK_ZERO;
> >       }
> > +
> > +    /* Caching allocated ranges is okay even if another process writes to the
> > +     * same file because we allow declaring things allocated even if there is a
> > +     * hole. However, we cannot cache holes without risking corruption. */
> > +    if (ret == BDRV_BLOCK_DATA) {
> > +        *sdc = (struct seek_data_cache) {
> > +            .valid  = true,
> > +            .start  = offset,
> > +            .end    = offset + *pnum,
> > +        };
> > +    }
> > +
> > +    *pnum = MIN(*pnum, bytes);

...here.

So what we return doesn't change.

> >       *map = offset;
> >       *file = bs;
> >       return ret | BDRV_BLOCK_OFFSET_VALID;

Kevin
