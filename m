Received: from eggs.gnu.org ([209.51.188.92]:53681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hIrC0-0003cU-O0
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:54:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hIrBz-0007Rc-II
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:54:20 -0400
Date: Tue, 23 Apr 2019 10:54:06 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190423085406.GD9041@localhost.localdomain>
References: <20190422152315.74361-1-vsementsov@virtuozzo.com>
	<20190422152315.74361-3-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422152315.74361-3-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v4 2/3] block/io: bdrv_pdiscard: support
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, fam@euphon.net, stefanha@redhat.com, den@virtuozzo.com, eblake@redhat.com

Am 22.04.2019 um 17:23 hat Vladimir Sementsov-Ogievskiy geschrieben:
> This fixes at least one overflow in qcow2_process_discards, which
> passes 64bit region length to bdrv_pdiscard where bytes (or sectors in
> the past) parameter is int since its introduction in 0b919fae.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  include/block/block.h |  4 ++--
>  block/io.c            | 16 ++++++++--------
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/include/block/block.h b/include/block/block.h
> index c7a26199aa..69fa18867e 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -432,8 +432,8 @@ void bdrv_drain_all(void);
>      AIO_WAIT_WHILE(bdrv_get_aio_context(bs_),              \
>                     cond); })
>  
> -int bdrv_pdiscard(BdrvChild *child, int64_t offset, int bytes);
> -int bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int bytes);
> +int bdrv_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes);
> +int bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes);
>  int bdrv_has_zero_init_1(BlockDriverState *bs);
>  int bdrv_has_zero_init(BlockDriverState *bs);
>  bool bdrv_unallocated_blocks_are_zero(BlockDriverState *bs);
> diff --git a/block/io.c b/block/io.c
> index dfc153b8d8..35c4157669 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2653,7 +2653,7 @@ int bdrv_flush(BlockDriverState *bs)
>  typedef struct DiscardCo {
>      BdrvChild *child;
>      int64_t offset;
> -    int bytes;
> +    int64_t bytes;
>      int ret;
>  } DiscardCo;
>  static void coroutine_fn bdrv_pdiscard_co_entry(void *opaque)
> @@ -2664,14 +2664,15 @@ static void coroutine_fn bdrv_pdiscard_co_entry(void *opaque)
>      aio_wait_kick();
>  }
>  
> -int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int bytes)
> +int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset,
> +                                  int64_t bytes)
>  {
>      BdrvTrackedRequest req;
>      int max_pdiscard, ret;
>      int head, tail, align;
>      BlockDriverState *bs = child->bs;
>  
> -    if (!bs || !bs->drv) {
> +    if (!bs || !bs->drv || !bdrv_is_inserted(bs)) {
>          return -ENOMEDIUM;
>      }

Ok, this comes from bdrv_is_inserted(). Priority of errors is changed,
but that shouldn't be a problem.

In fact, I wonder why bdrv_check_byte_request() should check
bdrv_is_inserted() at all. If the drive is empty and we perform the
request, we'll get an error anyway. No real reason to check beforehand
and slow down the success path.

But this is an issue separate from your patch. We can consider removing
the bdrv_is_inserted() call in a follow-up.

> @@ -2679,9 +2680,8 @@ int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int bytes)
>          return -EPERM;
>      }
>  
> -    ret = bdrv_check_byte_request(bs, offset, bytes);
> -    if (ret < 0) {
> -        return ret;
> +    if (offset < 0) {
> +        return -EIO;
>      }

This loses the check for the maximum size (and therefore integer
overflows). I think we want to check for bytes > INT64_MAX - offset,
too.

>      /* Do nothing if disabled.  */
> @@ -2716,7 +2716,7 @@ int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int bytes)
>      assert(max_pdiscard >= bs->bl.request_alignment);
>  
>      while (bytes > 0) {
> -        int num = bytes;
> +        int64_t num = bytes;
>  
>          if (head) {
>              /* Make small requests to get to alignment boundaries. */
> @@ -2778,7 +2778,7 @@ out:
>      return ret;
>  }
>  
> -int bdrv_pdiscard(BdrvChild *child, int64_t offset, int bytes)
> +int bdrv_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes)
>  {
>      Coroutine *co;
>      DiscardCo rwco = {

Kevin
