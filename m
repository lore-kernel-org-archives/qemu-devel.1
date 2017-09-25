Received: from eggs.gnu.org ([2001:4830:134:3::10]:43823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dwVdj-0007w3-Aw
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 11:49:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dwVdg-0000wh-U6
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 11:49:47 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:33093 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dwVdg-0000vd-Id
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 11:49:44 -0400
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170913181910.29688-13-mreitz@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <042b7c75-96a8-a695-5702-289eb68b5f54@virtuozzo.com>
Date: Mon, 25 Sep 2017 18:49:35 +0300
MIME-Version: 1.0
In-Reply-To: <20170913181910.29688-13-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 12/18] block/dirty-bitmap: Add
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

I have a patch on list, which adds hbitmap_next_zero function, it may help
https://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg00809.html

13.09.2017 21:19, Max Reitz wrote:
> This new function allows to look for a consecutively dirty area in a
> dirty bitmap.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   include/block/dirty-bitmap.h |  2 ++
>   block/dirty-bitmap.c         | 52 ++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 54 insertions(+)
>
> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
> index a79a58d2c3..7654748700 100644
> --- a/include/block/dirty-bitmap.h
> +++ b/include/block/dirty-bitmap.h
> @@ -90,6 +90,8 @@ void bdrv_set_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
>   void bdrv_reset_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
>                                       int64_t cur_sector, int64_t nr_sectors);
>   int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter);
> +bool bdrv_dirty_iter_next_area(BdrvDirtyBitmapIter *iter, uint64_t max_offset,
> +                               uint64_t *offset, int *bytes);
>   void bdrv_set_dirty_iter(BdrvDirtyBitmapIter *hbi, int64_t sector_num);
>   int64_t bdrv_get_dirty_count(BdrvDirtyBitmap *bitmap);
>   int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap);
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index aee57cf8c8..81b2f78016 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -550,6 +550,58 @@ int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter)
>       return hbitmap_iter_next(&iter->hbi, true);
>   }
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
> + */
> +bool bdrv_dirty_iter_next_area(BdrvDirtyBitmapIter *iter, uint64_t max_offset,
> +                               uint64_t *offset, int *bytes)
> +{
> +    uint32_t granularity = bdrv_dirty_bitmap_granularity(iter->bitmap);
> +    uint64_t gran_max_offset;
> +    int sector_gran = granularity >> BDRV_SECTOR_BITS;
> +    int64_t ret;
> +    int size;
> +
> +    if (DIV_ROUND_UP(max_offset, BDRV_SECTOR_SIZE) == iter->bitmap->size) {
> +        /* If max_offset points to the image end, round it up by the
> +         * bitmap granularity */
> +        gran_max_offset = ROUND_UP(max_offset, granularity);
> +    } else {
> +        gran_max_offset = max_offset;
> +    }
> +
> +    ret = hbitmap_iter_next(&iter->hbi, false);
> +    if (ret < 0 || (ret << BDRV_SECTOR_BITS) + granularity > gran_max_offset) {
> +        return false;
> +    }
> +
> +    *offset = ret << BDRV_SECTOR_BITS;
> +    size = 0;
> +
> +    assert(granularity <= INT_MAX);
> +
> +    do {
> +        /* Advance iterator */
> +        ret = hbitmap_iter_next(&iter->hbi, true);
> +        size += granularity;
> +    } while ((ret << BDRV_SECTOR_BITS) + granularity <= gran_max_offset &&
> +             hbitmap_iter_next(&iter->hbi, false) == ret + sector_gran &&
> +             size <= INT_MAX - granularity);
> +
> +    *bytes = MIN(size, max_offset - *offset);
> +    return true;
> +}
> +
>   /* Called within bdrv_dirty_bitmap_lock..unlock */
>   void bdrv_set_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
>                                     int64_t cur_sector, int64_t nr_sectors)


-- 
Best regards,
Vladimir
