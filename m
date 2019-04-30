Received: from eggs.gnu.org ([209.51.188.92]:57806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hLThc-0004LM-9u
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:25:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hLThW-00054k-8z
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:25:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43831)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hLThU-0004zW-AT
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:25:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id a12so21244163wrq.10
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 07:25:38 -0700 (PDT)
Date: Tue, 30 Apr 2019 16:25:28 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190430142528.txmrbzefalq65vpl@steredhat>
References: <20190423125706.26989-1-vsementsov@virtuozzo.com>
	<20190423125706.26989-3-vsementsov@virtuozzo.com>
	<20190430092437.jbecehdkqa4zdavd@steredhat>
	<4dabb261-f2d1-b6e0-8d97-ace159b87a54@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dabb261-f2d1-b6e0-8d97-ace159b87a54@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/3] block/io: bdrv_pdiscard: support
 int64_t bytes parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>, Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>

On Tue, Apr 30, 2019 at 10:03:08AM +0000, Vladimir Sementsov-Ogievskiy wrote:
> 30.04.2019 12:24, Stefano Garzarella wrote:
> > On Tue, Apr 23, 2019 at 03:57:05PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> >> This fixes at least one overflow in qcow2_process_discards, which
> >> passes 64bit region length to bdrv_pdiscard where bytes (or sectors in
> >> the past) parameter is int since its introduction in 0b919fae.
> >>
> >> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >> ---
> >>   include/block/block.h |  4 ++--
> >>   block/io.c            | 16 ++++++++--------
> >>   2 files changed, 10 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/include/block/block.h b/include/block/block.h
> >> index c7a26199aa..69fa18867e 100644
> >> --- a/include/block/block.h
> >> +++ b/include/block/block.h
> >> @@ -432,8 +432,8 @@ void bdrv_drain_all(void);
> >>       AIO_WAIT_WHILE(bdrv_get_aio_context(bs_),              \
> >>                      cond); })
> >>   
> >> -int bdrv_pdiscard(BdrvChild *child, int64_t offset, int bytes);
> >> -int bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int bytes);
> >> +int bdrv_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes);
> >> +int bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes);
> >>   int bdrv_has_zero_init_1(BlockDriverState *bs);
> >>   int bdrv_has_zero_init(BlockDriverState *bs);
> >>   bool bdrv_unallocated_blocks_are_zero(BlockDriverState *bs);
> >> diff --git a/block/io.c b/block/io.c
> >> index dfc153b8d8..16b6c5d855 100644
> >> --- a/block/io.c
> >> +++ b/block/io.c
> >> @@ -2653,7 +2653,7 @@ int bdrv_flush(BlockDriverState *bs)
> >>   typedef struct DiscardCo {
> >>       BdrvChild *child;
> >>       int64_t offset;
> >> -    int bytes;
> >> +    int64_t bytes;
> >>       int ret;
> >>   } DiscardCo;
> >>   static void coroutine_fn bdrv_pdiscard_co_entry(void *opaque)
> >> @@ -2664,14 +2664,15 @@ static void coroutine_fn bdrv_pdiscard_co_entry(void *opaque)
> >>       aio_wait_kick();
> >>   }
> >>   
> >> -int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int bytes)
> >> +int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset,
> >> +                                  int64_t bytes)
> >>   {
> >>       BdrvTrackedRequest req;
> >>       int max_pdiscard, ret;
> >>       int head, tail, align;
> >>       BlockDriverState *bs = child->bs;
> >>   
> >> -    if (!bs || !bs->drv) {
> >> +    if (!bs || !bs->drv || !bdrv_is_inserted(bs)) {
> > 
> > Should we describe this change in the commit message?
> 
> Honestly, don't want to resend the series for this.
> 
> > IIUC you added this check because you removed bdrv_check_byte_request()
> > below,
> > 
> > Maybe we can also remove '!bs->drv', since it is checked in
> > bdrv_is_inserted().
> 
> Hmm, on v4 Kevin commented, that bdrv_is_inserted not needed, and, as I understand, not only
> in bdrv_co_pdiscard it should be removed, but it may be done later. So, I'd prefer to keep it
> as is for now.
> 

Make sense if it will be removed.

> > 
> >>           return -ENOMEDIUM;
> >>       }
> >>   
> >> @@ -2679,9 +2680,8 @@ int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int bytes)
> >>           return -EPERM;
> >>       }
> >>   
> >> -    ret = bdrv_check_byte_request(bs, offset, bytes);
> >> -    if (ret < 0) {
> >> -        return ret;
> >> +    if (offset < 0 || bytes < 0 || bytes > INT64_MAX - offset) {
> >> +        return -EIO;
> >>       }
> > 
> > Should we check if 'bytes' is greater than
> > 'BDRV_REQUEST_MAX_SECTORS << BDRV_SECTOR_BITS'?
> > 
> 
> No, as we are contrariwise trying to support large bytes parameter in bdrv_co_pdiscard, which will
> exceed max request. If @bytes is large, it will be divided into several smaller requests in the
> following loop.
> 

I understood.
I saw that we limit the request to the driver to 'max_pdiscard' or 'INT_MAX'.

As future work, could we use int64_t also for the driver callbacks?

Anyway, the patch LGTM.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano
