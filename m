Received: from eggs.gnu.org ([2001:4830:134:3::10]:36798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1elwoE-0002t8-2D
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 08:09:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1elwoC-0006Da-Ve
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 08:09:14 -0500
Date: Wed, 14 Feb 2018 14:08:48 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180214130848.GC4766@localhost.localdomain>
References: <20180213202701.15858-1-eblake@redhat.com>
	<20180213202701.15858-20-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213202701.15858-20-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 19/21] vpc: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 13.02.2018 um 21:26 hat Eric Blake geschrieben:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Update the vpc driver accordingly.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> 
> ---
> v7: tweak commit message and type of 'n' [Fam]
> v6: no change
> v5: fix incorrect rounding in 'map' and bad loop condition [Vladimir]
> v4: rebase to interface tweak
> v3: rebase to master
> v2: drop get_sector_offset() [Kevin], rebase to mapping flag
> ---
>  block/vpc.c | 45 +++++++++++++++++++++++----------------------
>  1 file changed, 23 insertions(+), 22 deletions(-)
> 
> diff --git a/block/vpc.c b/block/vpc.c
> index cfa5144e867..fba4492fd7b 100644
> --- a/block/vpc.c
> +++ b/block/vpc.c
> @@ -706,53 +706,54 @@ fail:
>      return ret;
>  }
> 
> -static int64_t coroutine_fn vpc_co_get_block_status(BlockDriverState *bs,
> -        int64_t sector_num, int nb_sectors, int *pnum, BlockDriverState **file)
> +static int coroutine_fn vpc_co_block_status(BlockDriverState *bs,
> +                                            bool want_zero,
> +                                            int64_t offset, int64_t bytes,
> +                                            int64_t *pnum, int64_t *map,
> +                                            BlockDriverState **file)
>  {
>      BDRVVPCState *s = bs->opaque;
>      VHDFooter *footer = (VHDFooter*) s->footer_buf;
> -    int64_t start, offset;
> +    int64_t image_offset;
>      bool allocated;
> -    int64_t ret;
> -    int n;
> +    int ret;
> +    int64_t n;
> 
>      if (be32_to_cpu(footer->type) == VHD_FIXED) {
> -        *pnum = nb_sectors;
> +        *pnum = bytes;
> +        *map = offset;
>          *file = bs->file->bs;
> -        return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
> -               (sector_num << BDRV_SECTOR_BITS);
> +        return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID;
>      }
> 
>      qemu_co_mutex_lock(&s->lock);
> 
> -    offset = get_image_offset(bs, sector_num << BDRV_SECTOR_BITS, false, NULL);
> -    start = offset;
> -    allocated = (offset != -1);
> +    image_offset = get_image_offset(bs, offset, false, NULL);
> +    allocated = (image_offset != -1);
>      *pnum = 0;
>      ret = 0;
> 
>      do {
>          /* All sectors in a block are contiguous (without using the bitmap) */
> -        n = ROUND_UP(sector_num + 1, s->block_size / BDRV_SECTOR_SIZE)
> -          - sector_num;
> -        n = MIN(n, nb_sectors);
> +        n = ROUND_UP(offset + 1, s->block_size) - offset;
> +        n = MIN(n, bytes);
> 
>          *pnum += n;
> -        sector_num += n;
> -        nb_sectors -= n;
> +        offset += n;
> +        bytes -= n;
>          /* *pnum can't be greater than one block for allocated
>           * sectors since there is always a bitmap in between. */
>          if (allocated) {
>              *file = bs->file->bs;
> -            ret = BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID | start;
> +            *map = image_offset;

This does work, but only because the loop isn't actually looping for
allocated == true. In the old code, it was obvious that start was
assigned only once and never changed during the loop, but image_offset
changes in each loop iteration.

It would probably be cleaner and more obviously correct to move the
assignment of *map to before the loop.

Kevin
