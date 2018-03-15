Received: from eggs.gnu.org ([2001:4830:134:3::10]:34661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ewYuU-0008Cb-W6
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:51:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ewYuU-0007nL-6d
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:51:35 -0400
References: <20180228180507.3964-1-mreitz@redhat.com>
	<20180228180507.3964-13-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <73d69c62-fdef-2c8f-8a55-ef6a2b9c9ebd@redhat.com>
Date: Thu, 15 Mar 2018 15:51:13 -0400
MIME-Version: 1.0
In-Reply-To: <20180228180507.3964-13-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 12/16] block/dirty-bitmap: Add
 bdrv_dirty_iter_next_area
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>



On 02/28/2018 01:05 PM, Max Reitz wrote:
> This new function allows to look for a consecutively dirty area in a
> dirty bitmap.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  include/block/dirty-bitmap.h |  2 ++
>  block/dirty-bitmap.c         | 55 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
> index e3f4bbf51d..8c8f63e722 100644
> --- a/include/block/dirty-bitmap.h
> +++ b/include/block/dirty-bitmap.h
> @@ -79,6 +79,8 @@ void bdrv_set_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
>  void bdrv_reset_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
>                                      int64_t offset, int64_t bytes);
>  int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter);
> +bool bdrv_dirty_iter_next_area(BdrvDirtyBitmapIter *iter, uint64_t max_offset,
> +                               uint64_t *offset, int *bytes);
>  void bdrv_set_dirty_iter(BdrvDirtyBitmapIter *hbi, int64_t offset);
>  int64_t bdrv_get_dirty_count(BdrvDirtyBitmap *bitmap);
>  int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap);
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index d8e999226e..5d6b8dba89 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -496,6 +496,61 @@ int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter)
>      return hbitmap_iter_next(&iter->hbi, true);
>  }
>  
> +/**
> + * Return the next consecutively dirty area in the dirty bitmap
> + * belonging to the given iterator @iter.
> + *
> + * @max_offset: Maximum value that may be returned for
> + *              *offset + *bytes
> + * @offset:     Will contain the start offset of the next dirty area
> + * @bytes:      Will contain the length of the next dirty area
> + *
> + * Returns: True if a dirty area could be found before max_offset
> + *          (which means that *offset and *bytes then contain valid
> + *          values), false otherwise.
> + *
> + * Note that @iter is never advanced if false is returned.  If an area
> + * is found (which means that true is returned), it will be advanced
> + * past that area.
> + */
> +bool bdrv_dirty_iter_next_area(BdrvDirtyBitmapIter *iter, uint64_t max_offset,
> +                               uint64_t *offset, int *bytes)
> +{
> +    uint32_t granularity = bdrv_dirty_bitmap_granularity(iter->bitmap);
> +    uint64_t gran_max_offset;
> +    int64_t ret;
> +    int size;
> +
> +    if (max_offset == iter->bitmap->size) {
> +        /* If max_offset points to the image end, round it up by the
> +         * bitmap granularity */
> +        gran_max_offset = ROUND_UP(max_offset, granularity);
> +    } else {
> +        gran_max_offset = max_offset;
> +    }
> +
> +    ret = hbitmap_iter_next(&iter->hbi, false);
> +    if (ret < 0 || ret + granularity > gran_max_offset) {
> +        return false;
> +    }
> +
> +    *offset = ret;
> +    size = 0;
> +
> +    assert(granularity <= INT_MAX);
> +
> +    do {
> +        /* Advance iterator */
> +        ret = hbitmap_iter_next(&iter->hbi, true);
> +        size += granularity;
> +    } while (ret + granularity <= gran_max_offset &&
> +             hbitmap_iter_next(&iter->hbi, false) == ret + granularity &&
> +             size <= INT_MAX - granularity);
> +
> +    *bytes = MIN(size, max_offset - *offset);
> +    return true;
> +}
> +
>  /* Called within bdrv_dirty_bitmap_lock..unlock */
>  void bdrv_set_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
>                                    int64_t offset, int64_t bytes)
> 

10, 11, 12:

Reviewed-by: John Snow <jsnow@redhat.com>
