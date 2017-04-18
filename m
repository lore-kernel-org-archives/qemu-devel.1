Received: from eggs.gnu.org ([2001:4830:134:3::10]:47073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1d0RpV-0007Go-2D
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 08:01:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1d0RpT-00068e-RB
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 08:01:57 -0400
References: <20170418013356.3578-1-eblake@redhat.com>
	<20170418013356.3578-21-eblake@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <f43c86f6-2f17-51cd-2a7c-19df53c51b42@openvz.org>
Date: Tue, 18 Apr 2017 13:28:39 +0300
MIME-Version: 1.0
In-Reply-To: <20170418013356.3578-21-eblake@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 20/31] parallels: Switch to
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
Cc: qemu-block@nongnu.org, kwolf@nongnu.org, jsnow@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 04/18/2017 04:33 AM, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Update the parallels driver accordingly.  Note that
> the internal function block_status() is still sector-based, because
> it is still in use by other sector-based functions; but that's okay
> because request_alignment is 512 as a result of those functions.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>


> ---
>  block/parallels.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 8be46a7..2bc1918 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -274,22 +274,25 @@ static coroutine_fn int parallels_co_flush_to_os(BlockDriverState *bs)
>  }
>
>
> -static int64_t coroutine_fn parallels_co_get_block_status(BlockDriverState *bs,
> -        int64_t sector_num, int nb_sectors, int *pnum, BlockDriverState **file)
> +static int64_t coroutine_fn parallels_co_block_status(BlockDriverState *bs,
> +        int64_t offset, int64_t bytes, int64_t *pnum, BlockDriverState **file)
>  {
>      BDRVParallelsState *s = bs->opaque;
> -    int64_t offset;
> +    int count;
>
> +    assert(QEMU_IS_ALIGNED(offset | bytes, BDRV_SECTOR_SIZE));
>      qemu_co_mutex_lock(&s->lock);
> -    offset = block_status(s, sector_num, nb_sectors, pnum);
> +    offset = block_status(s, offset >> BDRV_SECTOR_BITS,
> +                          bytes >> BDRV_SECTOR_BITS, &count);
>      qemu_co_mutex_unlock(&s->lock);
>
>      if (offset < 0) {
>          return 0;
>      }
>
> +    *pnum = count * BDRV_SECTOR_SIZE;
>      *file = bs->file->bs;
> -    return (offset << BDRV_SECTOR_BITS) |
> +    return (offset & BDRV_BLOCK_OFFSET_MASK) |
>          BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID;
>  }
>
> @@ -775,7 +778,7 @@ static BlockDriver bdrv_parallels = {
>      .bdrv_open		= parallels_open,
>      .bdrv_close		= parallels_close,
>      .bdrv_child_perm          = bdrv_format_default_perms,
> -    .bdrv_co_get_block_status = parallels_co_get_block_status,
> +    .bdrv_co_block_status     = parallels_co_block_status,
>      .bdrv_has_zero_init       = bdrv_has_zero_init_1,
>      .bdrv_co_flush_to_os      = parallels_co_flush_to_os,
>      .bdrv_co_readv  = parallels_co_readv,
