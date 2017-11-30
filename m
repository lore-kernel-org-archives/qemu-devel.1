Received: from eggs.gnu.org ([2001:4830:134:3::10]:44936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eKNrr-0007iR-Fe
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:23:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eKNrq-0003PY-B8
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:23:03 -0500
References: <20171012185916.22776-1-eblake@redhat.com>
	<20171012185916.22776-19-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2798892b-cd79-e958-9a26-5ff6ee9185fd@virtuozzo.com>
Date: Thu, 30 Nov 2017 15:22:46 +0300
MIME-Version: 1.0
In-Reply-To: <20171012185916.22776-19-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v4 18/20] vpc: Switch to
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
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

12.10.2017 21:59, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Update the vpc driver accordingly.  Drop the now-unused
> get_sector_offset().
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>
> ---
> v4: rebase to interface tweak
> v3: rebase to master
> v2: drop get_sector_offset() [Kevin], rebase to mapping flag
> ---
>   block/vpc.c | 42 ++++++++++++++++++++++--------------------
>   1 file changed, 22 insertions(+), 20 deletions(-)
>
> diff --git a/block/vpc.c b/block/vpc.c
> index 1576d7b595..4100ce1ed3 100644
> --- a/block/vpc.c
> +++ b/block/vpc.c
> @@ -705,52 +705,54 @@ fail:
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
> +    int64_t start, image_offset;
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
> -    allocated = (offset != -1);
> +    image_offset = get_image_offset(bs, offset, false, NULL);
> +    start = image_offset & BDRV_BLOCK_OFFSET_MASK;

why do you do so? round down to sector boundary? does it mean,
that *map will corresponds not to offset, but to some previous byte?

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
> +            *map = start;
> +            ret = BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID;
>               break;
>           }
> -        if (nb_sectors == 0) {
> +        if (bytes == 0) {
>               break;
>           }
> -        offset = get_image_offset(bs, sector_num << BDRV_SECTOR_BITS, false,
> -                                  NULL);
> +        image_offset = get_image_offset(bs, offset, false, NULL);
>       } while (offset == -1);

image_offset here?

>
>       qemu_co_mutex_unlock(&s->lock);
> @@ -1097,7 +1099,7 @@ static BlockDriver bdrv_vpc = {
>
>       .bdrv_co_preadv             = vpc_co_preadv,
>       .bdrv_co_pwritev            = vpc_co_pwritev,
> -    .bdrv_co_get_block_status   = vpc_co_get_block_status,
> +    .bdrv_co_block_status       = vpc_co_block_status,
>
>       .bdrv_get_info          = vpc_get_info,
>


-- 
Best regards,
Vladimir
