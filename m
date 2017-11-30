Received: from eggs.gnu.org ([2001:4830:134:3::10]:53619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eKKl5-0004Lz-0g
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 04:03:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eKKl4-0005gP-1J
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 04:03:51 -0500
References: <20171012185916.22776-1-eblake@redhat.com>
	<20171012185916.22776-10-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ea4f3617-a892-4fa1-4605-39d162a8df04@virtuozzo.com>
Date: Thu, 30 Nov 2017 12:03:34 +0300
MIME-Version: 1.0
In-Reply-To: <20171012185916.22776-10-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v4 09/20] parallels: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>, jsnow@redhat.com

12.10.2017 21:59, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Update the parallels driver accordingly.  Note that
> the internal function block_status() is still sector-based, because
> it is still in use by other sector-based functions; but that's okay
> because request_alignment is 512 as a result of those functions.
> For now, no optimizations are added based on the mapping hint.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>
> ---
> v4: rebase to interface tweak, R-b dropped
> v3: no change
> v2: rebase to mapping parameter; it is ignored, so R-b kept
> ---
>   block/parallels.c | 22 +++++++++++++++-------
>   1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 2b6c6e5709..4a086f29e9 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -278,23 +278,31 @@ static coroutine_fn int parallels_co_flush_to_os(BlockDriverState *bs)
>   }
>
>
> -static int64_t coroutine_fn parallels_co_get_block_status(BlockDriverState *bs,
> -        int64_t sector_num, int nb_sectors, int *pnum, BlockDriverState **file)
> +static int coroutine_fn parallels_co_block_status(BlockDriverState *bs,
> +                                                  bool want_zero,
> +                                                  int64_t offset,
> +                                                  int64_t bytes,
> +                                                  int64_t *pnum,
> +                                                  int64_t *map,
> +                                                  BlockDriverState **file)
>   {
>       BDRVParallelsState *s = bs->opaque;
> -    int64_t offset;
> +    int count;
>
> +    assert(QEMU_IS_ALIGNED(offset | bytes, BDRV_SECTOR_SIZE));
>       qemu_co_mutex_lock(&s->lock);
> -    offset = block_status(s, sector_num, nb_sectors, pnum);
> +    offset = block_status(s, offset >> BDRV_SECTOR_BITS,
> +                          bytes >> BDRV_SECTOR_BITS, &count);
>       qemu_co_mutex_unlock(&s->lock);
>
>       if (offset < 0) {

pnum=count*BDRV_SECTOR_SIZE and map=0 setting missed here.

>           return 0;
>       }
>
> +    *pnum = count * BDRV_SECTOR_SIZE;
> +    *map = offset;
>       *file = bs->file->bs;
> -    return (offset << BDRV_SECTOR_BITS) |
> -        BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID;
> +    return BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID;
>   }
>
>   static coroutine_fn int parallels_co_writev(BlockDriverState *bs,
> @@ -781,7 +789,7 @@ static BlockDriver bdrv_parallels = {
>       .bdrv_open		= parallels_open,
>       .bdrv_close		= parallels_close,
>       .bdrv_child_perm          = bdrv_format_default_perms,
> -    .bdrv_co_get_block_status = parallels_co_get_block_status,
> +    .bdrv_co_block_status     = parallels_co_block_status,
>       .bdrv_has_zero_init       = bdrv_has_zero_init_1,
>       .bdrv_co_flush_to_os      = parallels_co_flush_to_os,
>       .bdrv_co_readv  = parallels_co_readv,


-- 
Best regards,
Vladimir
