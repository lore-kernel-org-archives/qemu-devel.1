Received: from eggs.gnu.org ([2001:4830:134:3::10]:37504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1d0pdM-00061n-9B
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 09:27:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1d0pdL-0006rJ-4U
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 09:27:00 -0400
Date: Wed, 19 Apr 2017 15:26:50 +0200
From: Niels de Vos <ndevos@redhat.com>
Message-ID: <20170419132650.GF17454@ndevos-x240.usersys.redhat.com>
References: <20170418013356.3578-1-eblake@redhat.com>
	<20170418013356.3578-15-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170418013356.3578-15-eblake@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 14/31] gluster: Switch to
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
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Mon, Apr 17, 2017 at 08:33:39PM -0500, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Update the gluster driver accordingly.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/gluster.c | 47 +++++++++++++++++++++++------------------------
>  1 file changed, 23 insertions(+), 24 deletions(-)

Looks good to me, thanks.

Reviewed-by: Niels de Vos <ndevos@redhat.com>


> diff --git a/block/gluster.c b/block/gluster.c
> index 1d4e2f7..3f252c6 100644
> --- a/block/gluster.c
> +++ b/block/gluster.c
> @@ -1332,24 +1332,24 @@ exit:
>  /*
>   * Returns the allocation status of the specified sectors.
>   *
> - * If 'sector_num' is beyond the end of the disk image the return value is 0
> + * If 'offset' is beyond the end of the disk image the return value is 0
>   * and 'pnum' is set to 0.
>   *
> - * 'pnum' is set to the number of sectors (including and immediately following
> - * the specified sector) that are known to be in the same
> + * 'pnum' is set to the number of bytes (including and immediately following
> + * the specified offset) that are known to be in the same
>   * allocated/unallocated state.
>   *
> - * 'nb_sectors' is the max value 'pnum' should be set to.  If nb_sectors goes
> + * 'bytes' is the max value 'pnum' should be set to.  If bytes goes
>   * beyond the end of the disk image it will be clamped.
>   *
> - * (Based on raw_co_get_block_status() from file-posix.c.)
> + * (Based on raw_co_block_status() from file-posix.c.)
>   */
> -static int64_t coroutine_fn qemu_gluster_co_get_block_status(
> -        BlockDriverState *bs, int64_t sector_num, int nb_sectors, int *pnum,
> +static int64_t coroutine_fn qemu_gluster_co_block_status(
> +        BlockDriverState *bs, int64_t offset, int64_t bytes, int64_t *pnum,
>          BlockDriverState **file)
>  {
>      BDRVGlusterState *s = bs->opaque;
> -    off_t start, data = 0, hole = 0;
> +    off_t data = 0, hole = 0;
>      int64_t total_size;
>      int ret = -EINVAL;
> 
> @@ -1357,41 +1357,40 @@ static int64_t coroutine_fn qemu_gluster_co_get_block_status(
>          return ret;
>      }
> 
> -    start = sector_num * BDRV_SECTOR_SIZE;
>      total_size = bdrv_getlength(bs);
>      if (total_size < 0) {
>          return total_size;
> -    } else if (start >= total_size) {
> +    } else if (offset >= total_size) {
>          *pnum = 0;
>          return 0;
> -    } else if (start + nb_sectors * BDRV_SECTOR_SIZE > total_size) {
> -        nb_sectors = DIV_ROUND_UP(total_size - start, BDRV_SECTOR_SIZE);
> +    } else if (offset + bytes > total_size) {
> +        bytes = total_size - offset;
>      }
> 
> -    ret = find_allocation(bs, start, &data, &hole);
> +    ret = find_allocation(bs, offset, &data, &hole);
>      if (ret == -ENXIO) {
>          /* Trailing hole */
> -        *pnum = nb_sectors;
> +        *pnum = bytes;
>          ret = BDRV_BLOCK_ZERO;
>      } else if (ret < 0) {
>          /* No info available, so pretend there are no holes */
> -        *pnum = nb_sectors;
> +        *pnum = bytes;
>          ret = BDRV_BLOCK_DATA;
> -    } else if (data == start) {
> +    } else if (data == offset) {
>          /* On a data extent, compute sectors to the end of the extent,
>           * possibly including a partial sector at EOF. */
> -        *pnum = MIN(nb_sectors, DIV_ROUND_UP(hole - start, BDRV_SECTOR_SIZE));
> +        *pnum = MIN(bytes, hole - offset);
>          ret = BDRV_BLOCK_DATA;
>      } else {
>          /* On a hole, compute sectors to the beginning of the next extent.  */
> -        assert(hole == start);
> -        *pnum = MIN(nb_sectors, (data - start) / BDRV_SECTOR_SIZE);
> +        assert(hole == offset);
> +        *pnum = MIN(bytes, data - offset);
>          ret = BDRV_BLOCK_ZERO;
>      }
> 
>      *file = bs;
> 
> -    return ret | BDRV_BLOCK_OFFSET_VALID | start;
> +    return ret | BDRV_BLOCK_OFFSET_VALID | (offset & BDRV_BLOCK_OFFSET_MASK);
>  }
> 
> 
> @@ -1419,7 +1418,7 @@ static BlockDriver bdrv_gluster = {
>  #ifdef CONFIG_GLUSTERFS_ZEROFILL
>      .bdrv_co_pwrite_zeroes        = qemu_gluster_co_pwrite_zeroes,
>  #endif
> -    .bdrv_co_get_block_status     = qemu_gluster_co_get_block_status,
> +    .bdrv_co_block_status         = qemu_gluster_co_block_status,
>      .create_opts                  = &qemu_gluster_create_opts,
>  };
> 
> @@ -1447,7 +1446,7 @@ static BlockDriver bdrv_gluster_tcp = {
>  #ifdef CONFIG_GLUSTERFS_ZEROFILL
>      .bdrv_co_pwrite_zeroes        = qemu_gluster_co_pwrite_zeroes,
>  #endif
> -    .bdrv_co_get_block_status     = qemu_gluster_co_get_block_status,
> +    .bdrv_co_block_status         = qemu_gluster_co_block_status,
>      .create_opts                  = &qemu_gluster_create_opts,
>  };
> 
> @@ -1475,7 +1474,7 @@ static BlockDriver bdrv_gluster_unix = {
>  #ifdef CONFIG_GLUSTERFS_ZEROFILL
>      .bdrv_co_pwrite_zeroes        = qemu_gluster_co_pwrite_zeroes,
>  #endif
> -    .bdrv_co_get_block_status     = qemu_gluster_co_get_block_status,
> +    .bdrv_co_block_status         = qemu_gluster_co_block_status,
>      .create_opts                  = &qemu_gluster_create_opts,
>  };
> 
> @@ -1509,7 +1508,7 @@ static BlockDriver bdrv_gluster_rdma = {
>  #ifdef CONFIG_GLUSTERFS_ZEROFILL
>      .bdrv_co_pwrite_zeroes        = qemu_gluster_co_pwrite_zeroes,
>  #endif
> -    .bdrv_co_get_block_status     = qemu_gluster_co_get_block_status,
> +    .bdrv_co_block_status         = qemu_gluster_co_block_status,
>      .create_opts                  = &qemu_gluster_create_opts,
>  };
> 
> -- 
> 2.9.3
> 
> 
