Received: from eggs.gnu.org ([2001:4830:134:3::10]:60570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eKNBu-00034t-Lh
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 06:39:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eKNBp-0005OK-Ht
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 06:39:42 -0500
References: <20171012185916.22776-1-eblake@redhat.com>
	<20171012185916.22776-18-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <0517a634-6585-2d3b-25b7-14d470adecc1@virtuozzo.com>
Date: Thu, 30 Nov 2017 14:39:24 +0300
MIME-Version: 1.0
In-Reply-To: <20171012185916.22776-18-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v4 17/20] vmdk: Switch to
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
> byte-based.  Update the vmdk driver accordingly.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>
> ---
> v4: rebase to interface tweak
> v3: no change
> v2: rebase to mapping flag
> ---
>   block/vmdk.c | 28 +++++++++++++---------------
>   1 file changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/block/vmdk.c b/block/vmdk.c
> index c665bcc977..624b5c296a 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -1303,25 +1303,27 @@ static inline uint64_t vmdk_find_index_in_cluster(VmdkExtent *extent,
>       return offset / BDRV_SECTOR_SIZE;
>   }
>
> -static int64_t coroutine_fn vmdk_co_get_block_status(BlockDriverState *bs,
> -        int64_t sector_num, int nb_sectors, int *pnum, BlockDriverState **file)
> +static int coroutine_fn vmdk_co_block_status(BlockDriverState *bs,
> +                                             bool want_zero,
> +                                             int64_t offset, int64_t bytes,
> +                                             int64_t *pnum, int64_t *map,
> +                                             BlockDriverState **file)
>   {
>       BDRVVmdkState *s = bs->opaque;
>       int64_t index_in_cluster, n, ret;
> -    uint64_t offset;
> +    uint64_t cluster_offset;
>       VmdkExtent *extent;
>
> -    extent = find_extent(s, sector_num, NULL);
> +    extent = find_extent(s, offset >> BDRV_SECTOR_BITS, NULL);
>       if (!extent) {
>           return 0;
>       }
>       qemu_co_mutex_lock(&s->lock);
> -    ret = get_cluster_offset(bs, extent, NULL,
> -                             sector_num * 512, false, &offset,
> +    ret = get_cluster_offset(bs, extent, NULL, offset, false, &cluster_offset,
>                                0, 0);
>       qemu_co_mutex_unlock(&s->lock);
>
> -    index_in_cluster = vmdk_find_index_in_cluster(extent, sector_num);
> +    index_in_cluster = vmdk_find_offset_in_cluster(extent, offset);

vmdk_find_index_in_cluster becomes unused. with it dropped:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

>       switch (ret) {
>       case VMDK_ERROR:
>           ret = -EIO;
> @@ -1336,18 +1338,14 @@ static int64_t coroutine_fn vmdk_co_get_block_status(BlockDriverState *bs,
>           ret = BDRV_BLOCK_DATA;
>           if (!extent->compressed) {
>               ret |= BDRV_BLOCK_OFFSET_VALID;
> -            ret |= (offset + (index_in_cluster << BDRV_SECTOR_BITS))
> -                    & BDRV_BLOCK_OFFSET_MASK;
> +            *map = cluster_offset + index_in_cluster;
>           }
>           *file = extent->file->bs;
>           break;
>       }
>
> -    n = extent->cluster_sectors - index_in_cluster;
> -    if (n > nb_sectors) {
> -        n = nb_sectors;
> -    }
> -    *pnum = n;
> +    n = extent->cluster_sectors * BDRV_SECTOR_SIZE - index_in_cluster;
> +    *pnum = MIN(n, bytes);
>       return ret;
>   }
>
> @@ -2393,7 +2391,7 @@ static BlockDriver bdrv_vmdk = {
>       .bdrv_close                   = vmdk_close,
>       .bdrv_create                  = vmdk_create,
>       .bdrv_co_flush_to_disk        = vmdk_co_flush,
> -    .bdrv_co_get_block_status     = vmdk_co_get_block_status,
> +    .bdrv_co_block_status         = vmdk_co_block_status,
>       .bdrv_get_allocated_file_size = vmdk_get_allocated_file_size,
>       .bdrv_has_zero_init           = vmdk_has_zero_init,
>       .bdrv_get_specific_info       = vmdk_get_specific_info,


-- 
Best regards,
Vladimir
