Received: from eggs.gnu.org ([2001:4830:134:3::10]:38433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eKniw-0003sk-0B
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:00:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eKniF-0006B1-8g
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:59:33 -0500
Date: Fri, 1 Dec 2017 15:40:47 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171201144047.GE4147@localhost.localdomain>
References: <20171201014242.16877-1-eblake@redhat.com>
	<20171201014242.16877-2-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171201014242.16877-2-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 01/20] block: Add
 .bdrv_co_block_status() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

Am 01.12.2017 um 02:42 hat Eric Blake geschrieben:
> We are gradually moving away from sector-based interfaces, towards
> byte-based. Now that the block layer exposes byte-based allocation,
> it's time to tackle the drivers.  Add a new callback that operates
> on as small as byte boundaries. Subsequent patches will then update
> individual drivers, then finally remove .bdrv_co_get_block_status().
> The old code now uses a goto in order to minimize churn at that later
> removal.  Update documentation in this patch so that the later
> removal can be a straight delete.
> 
> The new code also passes through the 'want_zero' hint, which will
> allow subsequent patches to further optimize callers that only care
> about how much of the image is allocated (want_zero is false),
> rather than full details about runs of zeroes and which offsets the
> allocation actually maps to (want_zero is true).
> 
> Note that most drivers give sector-aligned answers, except at
> end-of-file, even when request_alignment is smaller than a sector.
> However, bdrv_getlength() is sector-aligned (even though it gives a
> byte answer), often by exceeding the actual file size.  If we were to
> give back strict results, at least file-posix.c would report a
> transition from DATA to HOLE at the end of a file even in the middle
> of a sector, which can throw off callers; so we intentionally lie and
> state that any partial sector at the end of a file has the same
> status for the entire sector.  Maybe at some future day we can
> report actual file size instead of rounding up, but not for this
> series.

In what way does this throw off callers in practice?

The rounding will lead to strange effects, and I'm not sure that dealing
with them is any easier than fixing the callers. Imagine an image file
like this (very small example, file size 384 bytes):

    0    128      384  512
    |    |        |    |
    +----+--------+----+
    |Hole|  Data  |    |
    +----+--------+----+
                  |
                  EOF

bdrv_co_block_status(offset=0, bytes=512) returns 512 bytes of HOLE.
bdrv_co_block_status(offset=128, bytes=512) returns 384 bytes of DATA.
bdrv_co_block_status(offset=384, bytes=512) returns 128 bytes of HOLE.

This is not only contradictory, but the first one is almost begging for
data corruption because it returns HOLE for a region that actually
contains data.

The only excuse I can imagine is that we say that this can never happen
because drivers use 512 byte granularity anyway. But why are we
introducing the new interface then? I don't think this semantics is
compatible with a bytes-based driver interface.

> We also add an assertion that any driver using the new callback will
> make progress (the only time pnum will be 0 is if the block layer
> already handled an out-of-bounds request, or if there is an error).
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v5: rebase to master, typo fix, document more block layer guarantees
> v4: rebase to master
> v3: no change
> v2: improve alignment handling, ensure all iotests still pass
> ---
>  include/block/block.h     |  9 ++++-----
>  include/block/block_int.h | 14 +++++++++++---
>  block/io.c                | 31 ++++++++++++++++++++++++++-----
>  3 files changed, 41 insertions(+), 13 deletions(-)
> 
> diff --git a/include/block/block.h b/include/block/block.h
> index c05cac57e5..798e98f783 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -136,11 +136,10 @@ typedef struct HDGeometry {
>   *                 that the block layer recompute the answer from the returned
>   *                 BDS; must be accompanied by just BDRV_BLOCK_OFFSET_VALID.
>   *
> - * If BDRV_BLOCK_OFFSET_VALID is set, bits 9-62 (BDRV_BLOCK_OFFSET_MASK) of
> - * the return value (old interface) or the entire map parameter (new
> - * interface) represent the offset in the returned BDS that is allocated for
> - * the corresponding raw data.  However, whether that offset actually
> - * contains data also depends on BDRV_BLOCK_DATA, as follows:
> + * If BDRV_BLOCK_OFFSET_VALID is set, the map parameter represents the
> + * host offset within the returned BDS that is allocated for the
> + * corresponding raw guest data.  However, whether that offset
> + * actually contains data also depends on BDRV_BLOCK_DATA, as follows:
>   *
>   * DATA ZERO OFFSET_VALID
>   *  t    t        t       sectors read as zero, returned file is zero at offset
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index a5482775ec..071263c40f 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -206,13 +206,21 @@ struct BlockDriver {
>       * bdrv_is_allocated[_above].  The driver should answer only
>       * according to the current layer, and should not set
>       * BDRV_BLOCK_ALLOCATED, but may set BDRV_BLOCK_RAW.  See block.h
> -     * for the meaning of _DATA, _ZERO, and _OFFSET_VALID.  The block
> -     * layer guarantees input aligned to request_alignment, as well as
> -     * non-NULL pnum and file.
> +     * for the meaning of _DATA, _ZERO, and _OFFSET_VALID.  As a hint,
> +     * the flag want_zero is true if the caller cares more about
> +     * precise mappings (favor _OFFSET_VALID/_ZERO) or false for
> +     * overall allocation (favor larger *pnum).  The block layer
> +     * guarantees input clamped to bdrv_getlength() and aligned to
> +     * request_alignment, as well as non-NULL pnum, map, and file;
> +     * in turn, the driver must return an error or set pnum to an
> +     * aligned non-zero value.
>       */
>      int64_t coroutine_fn (*bdrv_co_get_block_status)(BlockDriverState *bs,
>          int64_t sector_num, int nb_sectors, int *pnum,
>          BlockDriverState **file);
> +    int coroutine_fn (*bdrv_co_block_status)(BlockDriverState *bs,
> +        bool want_zero, int64_t offset, int64_t bytes, int64_t *pnum,
> +        int64_t *map, BlockDriverState **file);
> 
>      /*
>       * Invalidate any cached meta-data.
> diff --git a/block/io.c b/block/io.c
> index 6773926fc1..5967f3a298 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1889,7 +1889,7 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
> 
>      /* Must be non-NULL or bdrv_getlength() would have failed */
>      assert(bs->drv);
> -    if (!bs->drv->bdrv_co_get_block_status) {
> +    if (!bs->drv->bdrv_co_get_block_status && !bs->drv->bdrv_co_block_status) {
>          *pnum = bytes;
>          ret = BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED;
>          if (offset + bytes == total_size) {
> @@ -1906,13 +1906,14 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
>      bdrv_inc_in_flight(bs);
> 
>      /* Round out to request_alignment boundaries */
> -    /* TODO: until we have a byte-based driver callback, we also have to
> -     * round out to sectors, even if that is bigger than request_alignment */
> -    align = MAX(bs->bl.request_alignment, BDRV_SECTOR_SIZE);
> +    align = bs->bl.request_alignment;
> +    if (bs->drv->bdrv_co_get_block_status && align < BDRV_SECTOR_SIZE) {
> +        align = BDRV_SECTOR_SIZE;
> +    }
>      aligned_offset = QEMU_ALIGN_DOWN(offset, align);
>      aligned_bytes = ROUND_UP(offset + bytes, align) - aligned_offset;
> 
> -    {
> +    if (bs->drv->bdrv_co_get_block_status) {
>          int count; /* sectors */
>          int64_t longret;
> 
> @@ -1937,8 +1938,28 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
>          }
>          ret = longret & ~BDRV_BLOCK_OFFSET_MASK;
>          *pnum = count * BDRV_SECTOR_SIZE;
> +        goto refine;
>      }
> 
> +    ret = bs->drv->bdrv_co_block_status(bs, want_zero, aligned_offset,
> +                                        aligned_bytes, pnum, &local_map,
> +                                        &local_file);
> +    if (ret < 0) {
> +        *pnum = 0;
> +        goto out;
> +    }
> +    assert(*pnum); /* The block driver must make progress */
> +
> +    /*
> +     * total_size is always sector-aligned, by sometimes exceeding actual
> +     * file size. Expand pnum if it lands mid-sector due to end-of-file.
> +     */
> +    if (QEMU_ALIGN_UP(*pnum + aligned_offset,

aligned_offset + *pnum wouldn be the more conventional order.

> +                      BDRV_SECTOR_SIZE) == total_size) {
> +        *pnum = total_size - aligned_offset;
> +    }
> +refine:
>      /*
>       * The driver's result must be a multiple of request_alignment.
>       * Clamp pnum and adjust map to original request.

Kevin
