Received: from eggs.gnu.org ([2001:4830:134:3::10]:60712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eJaqe-0006wq-Bh
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 03:02:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eJaqZ-0003Ue-E5
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 03:02:32 -0500
References: <20171012185916.22776-1-eblake@redhat.com>
	<20171012185916.22776-2-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c93fc092-bc8c-d293-a775-48301302a1f2@virtuozzo.com>
Date: Tue, 28 Nov 2017 11:02:06 +0300
MIME-Version: 1.0
In-Reply-To: <20171012185916.22776-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v4 01/20] block: Add
 .bdrv_co_block_status() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, jsnow@redhat.com

12.10.2017 21:58, Eric Blake wrote:
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
> about how much of the image is allocated (mapping is false), rather
> than full details about runs of zeroes and which offsets the
> allocation actually maps to (mapping is true).
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
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>
> ---
> v4: rebase to master
> v3: no change
> v2: improve alignment handling, ensure all iotests still pass
> ---
>   include/block/block.h     |  9 ++++-----
>   include/block/block_int.h | 12 +++++++++---
>   block/io.c                | 30 +++++++++++++++++++++++++-----
>   3 files changed, 38 insertions(+), 13 deletions(-)
>
> diff --git a/include/block/block.h b/include/block/block.h
> index fbc21daf62..c5d6b2c933 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -136,11 +136,10 @@ typedef struct HDGeometry {
>    *                 that the block layer recompute the answer from the returned
>    *                 BDS; must be accompanied by just BDRV_BLOCK_OFFSET_VALID.
>    *
> - * If BDRV_BLOCK_OFFSET_VALID is set, bits 9-62 (BDRV_BLOCK_OFFSET_MASK) of
> - * the return value (old interface) or the entire map parameter (new
> - * interface) represent the offset in the returned BDS that is allocated for
> - * the corresponding raw data.  However, whether that offset actually
> - * contains data also depends on BDRV_BLOCK_DATA, as follows:
> + * If BDRV_BLOCK_OFFSET_VALID is set, the map parameter represents the
> + * host offset within the returned BDS that is allocated for the
> + * corresponding raw guest data.  However, whether that offset
> + * actually contains data also depends on BDRV_BLOCK_DATA, as follows:
>    *
>    * DATA ZERO OFFSET_VALID
>    *  t    t        t       sectors read as zero, returned file is zero at offset
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 4b9b23a08d..4153cd646d 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -206,13 +206,19 @@ struct BlockDriver {
>        * bdrv_is_allocated[_above].  The driver should answer only
>        * according to the current layer, and should not set
>        * BDRV_BLOCK_ALLOCATED, but may set BDRV_BLOCK_RAW.  See block.h
> -     * for the meaning of _DATA, _ZERO, and _OFFSET_VALID.  The block
> -     * layer guarantees input aligned to request_alignment, as well as
> -     * non-NULL pnum and file.
> +     * for the meaning of _DATA, _ZERO, and _OFFSET_VALID.  As a hint,
> +     * the flag want_zero is true if the caller cares more about
> +     * precise mappings (favor _OFFSET_VALID/_ZERO) or false for
> +     * overall allocation (favor larger *pnum).  The block layer
> +     * guarantees input aligned to request_alignment, as well as
> +     * non-NULL pnum, map, and file.
>        */
>       int64_t coroutine_fn (*bdrv_co_get_block_status)(BlockDriverState *bs,
>           int64_t sector_num, int nb_sectors, int *pnum,
>           BlockDriverState **file);
> +    int coroutine_fn (*bdrv_co_block_status)(BlockDriverState *bd,

s/bd/bs

> +        bool want_zero, int64_t offset, int64_t bytes, int64_t *pnum,
> +        int64_t *map, BlockDriverState **file);
>
>       /*
>        * Invalidate any cached meta-data.
> diff --git a/block/io.c b/block/io.c
> index e4caa4acf1..ef9ea44667 100644

[...]

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


-- 
Best regards,
Vladimir
