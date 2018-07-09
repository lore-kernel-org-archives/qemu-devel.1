Received: from eggs.gnu.org ([2001:4830:134:3::10]:40734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fcXzL-0001LG-O5
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fcXzJ-0005jy-U3
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:22:07 -0400
Date: Mon, 9 Jul 2018 23:21:52 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180709152152.GE17581@lemon.usersys.redhat.com>
References: <20180706183051.197403-1-vsementsov@virtuozzo.com>
	<20180706183051.197403-2-vsementsov@virtuozzo.com>
	<20180709011552.GA14487@lemon.usersys.redhat.com>
	<54b51ddc-7718-9ac5-a8f4-75dc6b7422c1@virtuozzo.com>
	<20180709131726.GD17581@lemon.usersys.redhat.com>
	<94d8638d-8316-f6e6-3437-cac6554f8568@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94d8638d-8316-f6e6-3437-cac6554f8568@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/4] block/io: fix copy_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pl@kamp.de, pbonzini@redhat.com, ronniesahlberg@gmail.com, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, jsnow@redhat.com, den@openvz.org

On Mon, 07/09 17:38, Vladimir Sementsov-Ogievskiy wrote:
> 09.07.2018 16:17, Fam Zheng wrote:
> > On Mon, 07/09 12:43, Vladimir Sementsov-Ogievskiy wrote:
> > > 09.07.2018 04:15, Fam Zheng wrote:
> > > > On Fri, 07/06 21:30, Vladimir Sementsov-Ogievskiy wrote:
> > > > > Here two things are fixed:
> > > > > 
> > > > > 1. Architecture
> > > > > 
> > > > > On each recursion step, we go to the child of src or dst, only for one
> > > > > of them. So, it's wrong to create tracked requests for both on each
> > > > > step. It leads to tracked requests duplication.
> > > > > 
> > > > > 2. Wait for serializing requests on write path independently of
> > > > >      BDRV_REQ_NO_SERIALISING
> > > > > 
> > > > > Before commit 9ded4a01149 "backup: Use copy offloading",
> > > > > BDRV_REQ_NO_SERIALISING was used for only one case: read in
> > > > > copy-on-write operation during backup. Also, the flag was handled only
> > > > > on read path (in bdrv_co_preadv and bdrv_aligned_preadv).
> > > > > 
> > > > > After 9ded4a01149, flag is used for not waiting serializing operations
> > > > > on backup target (in same case of copy-on-write operation). This
> > > > > behavior change is unsubstantiated and potentially dangerous, let's
> > > > > drop it and add additional asserts and documentation.
> > > > > 
> > > > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > > > > ---
> > > > >    include/block/block.h |  13 +++++++
> > > > >    block/io.c            | 103 +++++++++++++++++++++++++++++++-------------------
> > > > >    2 files changed, 78 insertions(+), 38 deletions(-)
> > > > > 
> > > > > diff --git a/include/block/block.h b/include/block/block.h
> > > > > index e5c7759a0c..a06a4d27de 100644
> > > > > --- a/include/block/block.h
> > > > > +++ b/include/block/block.h
> > > > > @@ -50,6 +50,19 @@ typedef enum {
> > > > >         * opened with BDRV_O_UNMAP.
> > > > >         */
> > > > >        BDRV_REQ_MAY_UNMAP          = 0x4,
> > > > > +
> > > > > +    /* The BDRV_REQ_NO_SERIALISING means that we don't want to
> > > > > +     * wait_serialising_requests(), when reading.
> > > > > +     *
> > > > > +     * This flag is used for backup copy on write operation, when we need to
> > > > > +     * read old data before write (write notifier triggered). It is ok, due to
> > > > > +     * we already waited for serializing requests in initiative write (see
> > > > > +     * bdrv_aligned_pwritev), and it is necessary for the case when initiative
> > > > > +     * write is serializing itself (we'll dead lock waiting it).
> > > > > +     *
> > > > > +     * The described case is the only usage for the flag for now, so, it is
> > > > > +     * supported only for read operation and restricted for write.
> > > > > +     */
> > > > >        BDRV_REQ_NO_SERIALISING     = 0x8,
> > > > >        BDRV_REQ_FUA                = 0x10,
> > > > >        BDRV_REQ_WRITE_COMPRESSED   = 0x20,
> > > > > diff --git a/block/io.c b/block/io.c
> > > > > index 1a2272fad3..621b21c455 100644
> > > > > --- a/block/io.c
> > > > > +++ b/block/io.c
> > > > > @@ -1572,6 +1572,8 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
> > > > >        max_transfer = QEMU_ALIGN_DOWN(MIN_NON_ZERO(bs->bl.max_transfer, INT_MAX),
> > > > >                                       align);
> > > > > +    /* BDRV_REQ_NO_SERIALISING is only for read operation */
> > > > > +    assert(!(flags & BDRV_REQ_NO_SERIALISING));
> > > > >        waited = wait_serialising_requests(req);
> > > > >        assert(!waited || !req->serialising);
> > > > >        assert(req->overlap_offset <= offset);
> > > > > @@ -2888,15 +2890,19 @@ void bdrv_unregister_buf(BlockDriverState *bs, void *host)
> > > > >        }
> > > > >    }
> > > > > -static int coroutine_fn bdrv_co_copy_range_internal(BdrvChild *src,
> > > > > -                                                    uint64_t src_offset,
> > > > > -                                                    BdrvChild *dst,
> > > > > -                                                    uint64_t dst_offset,
> > > > > -                                                    uint64_t bytes,
> > > > > -                                                    BdrvRequestFlags flags,
> > > > > -                                                    bool recurse_src)
> > > > > +/* Common part of bdrv_co_copy_range_from and bdrv_co_copy_range_to.
> > > > > + *
> > > > > + * Return -errno on failure,
> > > > > + *        0 if successfully handled by bdrv_co_pwrite_zeroes
> > > > > + *        1 to continue copy_range operation
> > > > > + */
> > > > > +static int coroutine_fn bdrv_co_copy_range_check(BdrvChild *src,
> > > > > +                                                 uint64_t src_offset,
> > > > > +                                                 BdrvChild *dst,
> > > > > +                                                 uint64_t dst_offset,
> > > > > +                                                 uint64_t bytes,
> > > > > +                                                 BdrvRequestFlags flags)
> > > > >    {
> > > > > -    BdrvTrackedRequest src_req, dst_req;
> > > > >        int ret;
> > > > >        if (!dst || !dst->bs) {
> > > > > @@ -2923,33 +2929,8 @@ static int coroutine_fn bdrv_co_copy_range_internal(BdrvChild *src,
> > > > >            || src->bs->encrypted || dst->bs->encrypted) {
> > > > >            return -ENOTSUP;
> > > > >        }
> > > > > -    bdrv_inc_in_flight(src->bs);
> > > > > -    bdrv_inc_in_flight(dst->bs);
> > > > > -    tracked_request_begin(&src_req, src->bs, src_offset,
> > > > > -                          bytes, BDRV_TRACKED_READ);
> > > > > -    tracked_request_begin(&dst_req, dst->bs, dst_offset,
> > > > > -                          bytes, BDRV_TRACKED_WRITE);
> > > > > -    if (!(flags & BDRV_REQ_NO_SERIALISING)) {
> > > > > -        wait_serialising_requests(&src_req);
> > > > > -        wait_serialising_requests(&dst_req);
> > > > > -    }
> > > > > -    if (recurse_src) {
> > > > > -        ret = src->bs->drv->bdrv_co_copy_range_from(src->bs,
> > > > > -                                                    src, src_offset,
> > > > > -                                                    dst, dst_offset,
> > > > > -                                                    bytes, flags);
> > > > > -    } else {
> > > > > -        ret = dst->bs->drv->bdrv_co_copy_range_to(dst->bs,
> > > > > -                                                  src, src_offset,
> > > > > -                                                  dst, dst_offset,
> > > > > -                                                  bytes, flags);
> > > > > -    }
> > > > > -    tracked_request_end(&src_req);
> > > > > -    tracked_request_end(&dst_req);
> > > > > -    bdrv_dec_in_flight(src->bs);
> > > > > -    bdrv_dec_in_flight(dst->bs);
> > > > > -    return ret;
> > > > > +    return 1;
> > > > >    }
> > > > >    /* Copy range from @src to @dst.
> > > > > @@ -2960,8 +2941,31 @@ int coroutine_fn bdrv_co_copy_range_from(BdrvChild *src, uint64_t src_offset,
> > > > >                                             BdrvChild *dst, uint64_t dst_offset,
> > > > >                                             uint64_t bytes, BdrvRequestFlags flags)
> > > > >    {
> > > > > -    return bdrv_co_copy_range_internal(src, src_offset, dst, dst_offset,
> > > > > -                                       bytes, flags, true);
> > > > > +    BdrvTrackedRequest req;
> > > > > +    int ret;
> > > > > +
> > > > > +    ret = bdrv_co_copy_range_check(src, src_offset, dst, dst_offset, bytes,
> > > > > +                                   flags);
> > > > I don't like a function called _check to already do I/O here. Instead, I think
> > > > this is cleaner:
> > > > 
> > > > ---
> > > > 
> > > > 
> > > > diff --git a/block/io.c b/block/io.c
> > > > index 1a2272fad3..694a94dfae 100644
> > > > --- a/block/io.c
> > > > +++ b/block/io.c
> > > > @@ -2923,32 +2923,34 @@ static int coroutine_fn bdrv_co_copy_range_internal(BdrvChild *src,
> > > >            || src->bs->encrypted || dst->bs->encrypted) {
> > > >            return -ENOTSUP;
> > > >        }
> > > > -    bdrv_inc_in_flight(src->bs);
> > > > -    bdrv_inc_in_flight(dst->bs);
> > > > -    tracked_request_begin(&src_req, src->bs, src_offset,
> > > > -                          bytes, BDRV_TRACKED_READ);
> > > > -    tracked_request_begin(&dst_req, dst->bs, dst_offset,
> > > > -                          bytes, BDRV_TRACKED_WRITE);
> > > > -    if (!(flags & BDRV_REQ_NO_SERIALISING)) {
> > > > -        wait_serialising_requests(&src_req);
> > > > -        wait_serialising_requests(&dst_req);
> > > > -    }
> > > >        if (recurse_src) {
> > > > +        bdrv_inc_in_flight(src->bs);
> > > > +        tracked_request_begin(&src_req, src->bs, src_offset,
> > > > +                              bytes, BDRV_TRACKED_READ);
> > > > +        if (!(flags & BDRV_REQ_NO_SERIALISING)) {
> > > > +            wait_serialising_requests(&src_req);
> > > > +        }
> > > >            ret = src->bs->drv->bdrv_co_copy_range_from(src->bs,
> > > >                                                        src, src_offset,
> > > >                                                        dst, dst_offset,
> > > >                                                        bytes, flags);
> > > > +        tracked_request_end(&src_req);
> > > > +        bdrv_dec_in_flight(src->bs);
> > > >        } else {
> > > > +        bdrv_inc_in_flight(dst->bs);
> > > > +        tracked_request_begin(&dst_req, dst->bs, dst_offset,
> > > > +                              bytes, BDRV_TRACKED_WRITE);
> > > > +        /* BDRV_REQ_NO_SERIALISING is only for read operation, so we ignore it
> > > > +         * in flags. */
> > > > +        wait_serialising_requests(&dst_req);
> > > >            ret = dst->bs->drv->bdrv_co_copy_range_to(dst->bs,
> > > >                                                      src, src_offset,
> > > >                                                      dst, dst_offset,
> > > >                                                      bytes, flags);
> > > > +        tracked_request_end(&dst_req);
> > > > +        bdrv_dec_in_flight(dst->bs);
> > > >        }
> > > > -    tracked_request_end(&src_req);
> > > > -    tracked_request_end(&dst_req);
> > > > -    bdrv_dec_in_flight(src->bs);
> > > > -    bdrv_dec_in_flight(dst->bs);
> > > >        return ret;
> > > >    }
> > > A matter of taste, I think. I decided, that such way only stresses that
> > > these functions have more different than similar content and went another
> > > one.
> > But then you have to use a specialized return value to designate "handled with
> > write zeroes", which makes the code harder to read.
> > 
> > Fam
> 
> Hmm, didn't care about this, it's normal return semantics for a lot of
> functions in qemu nbd code, I'm used to it.
> Oops, missed that it's your code and you are its maintainer) Will resend, if
> you are not comfortable with such semantics. I assume, you agree with the
> fix itself..

Yes, the fix is good. Actually I'll have to add some new code on top of your fix
after QEMU 3.0.  I planned to call it bdrv_co_copy_range_check(), but it will do
completely different things than this patch: it will do a recursion to see if
all drivers are happy with the parameters, with no side effect (e.g. no qcow2
cluster allocation). That's one reason why I prefer we don't split the "zero
write" code and the copy offloading code to multiple functions now; besides, my
version of bdrv_co_copy_range_check() will have to be called outside of the
actual I/O recursion. My impression is that even though one of them can change
the name, having two checking helpers around is still confusing.

Also, v3 of "block: Fix dst reading after tail copy offloading" series is pending
on this series as well. I appreciate if you resend. :)

Fam
