Received: from eggs.gnu.org ([2001:4830:134:3::10]:38913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eNfPC-0004GY-JU
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 08:43:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eNfPB-0002rY-KG
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 08:43:02 -0500
References: <20171207203036.14993-1-eblake@redhat.com>
	<20171207203036.14993-19-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <fe8638f1-6cff-e930-f67e-05c57a5f8ad8@virtuozzo.com>
Date: Sat, 9 Dec 2017 16:42:48 +0300
MIME-Version: 1.0
In-Reply-To: <20171207203036.14993-19-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v6 18/20] vpc: Switch to
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
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

07.12.2017 23:30, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Update the vpc driver accordingly.  Drop the now-unused
> get_sector_offset().
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>
> ---
> v5: fix incorrect rounding in 'map' and bad loop condition [Vladimir]
> v4: rebase to interface tweak
> v3: rebase to master
> v2: drop get_sector_offset() [Kevin], rebase to mapping flag
> ---
>   block/vpc.c | 43 ++++++++++++++++++++++---------------------
>   1 file changed, 22 insertions(+), 21 deletions(-)
>
> diff --git a/block/vpc.c b/block/vpc.c
> index 1576d7b595..0000b5b9b4 100644
> --- a/block/vpc.c
> +++ b/block/vpc.c
> @@ -705,53 +705,54 @@ fail:
>       return ret;
>   }
>
> -static int64_t coroutine_fn vpc_co_get_block_status(BlockDriverState *bs,
> -        int64_t sector_num, int nb_sectors, int *pnum, BlockDriverState **file)
> +static int coroutine_fn vpc_co_block_status(BlockDriverState *bs,
> +                                            bool want_zero,
> +                                            int64_t offset, int64_t bytes,
> +                                            int64_t *pnum, int64_t *map,
> +                                            BlockDriverState **file)
>   {
>       BDRVVPCState *s = bs->opaque;
>       VHDFooter *footer = (VHDFooter*) s->footer_buf;
> -    int64_t start, offset;
> +    int64_t image_offset;

image_offset is used instead of both old start and offset vars

>       bool allocated;
> -    int64_t ret;
> +    int ret;
>       int n;
>
>       if (be32_to_cpu(footer->type) == VHD_FIXED) {
> -        *pnum = nb_sectors;
> +        *pnum = bytes;
> +        *map = offset;
>           *file = bs->file->bs;
> -        return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
> -               (sector_num << BDRV_SECTOR_BITS);
> +        return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID;
>       }
>
>       qemu_co_mutex_lock(&s->lock);
>
> -    offset = get_image_offset(bs, sector_num << BDRV_SECTOR_BITS, false, NULL);
> -    start = offset;

... instead of both..

> -    allocated = (offset != -1);
> +    image_offset = get_image_offset(bs, offset, false, NULL);
> +    allocated = (image_offset != -1);
>       *pnum = 0;
>       ret = 0;
>
>       do {
>           /* All sectors in a block are contiguous (without using the bitmap) */
> -        n = ROUND_UP(sector_num + 1, s->block_size / BDRV_SECTOR_SIZE)
> -          - sector_num;
> -        n = MIN(n, nb_sectors);
> +        n = ROUND_UP(offset + 1, s->block_size) - offset;
> +        n = MIN(n, bytes);
>
>           *pnum += n;
> -        sector_num += n;
> -        nb_sectors -= n;
> +        offset += n;
> +        bytes -= n;
>           /* *pnum can't be greater than one block for allocated
>            * sectors since there is always a bitmap in between. */
>           if (allocated) {
>               *file = bs->file->bs;
> -            ret = BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID | start;
> +            *map = image_offset;

image_offset still unchanged as we can go here only on first loop iteration,
so it's ok to use it instead of start.

> +            ret = BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID;
>               break;
>           }
> -        if (nb_sectors == 0) {
> +        if (bytes == 0) {
>               break;
>           }
> -        offset = get_image_offset(bs, sector_num << BDRV_SECTOR_BITS, false,
> -                                  NULL);
> -    } while (offset == -1);
> +        image_offset = get_image_offset(bs, offset, false, NULL);
> +    } while (image_offset == -1);
>
>       qemu_co_mutex_unlock(&s->lock);
>       return ret;
> @@ -1097,7 +1098,7 @@ static BlockDriver bdrv_vpc = {
>
>       .bdrv_co_preadv             = vpc_co_preadv,
>       .bdrv_co_pwritev            = vpc_co_pwritev,
> -    .bdrv_co_get_block_status   = vpc_co_get_block_status,
> +    .bdrv_co_block_status       = vpc_co_block_status,
>
>       .bdrv_get_info          = vpc_get_info,
>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir
