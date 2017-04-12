Received: from eggs.gnu.org ([2001:4830:134:3::10]:33182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cyR37-0004jV-6V
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 18:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cyR36-0003WJ-57
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 18:47:41 -0400
References: <20170412174920.8744-1-eblake@redhat.com>
	<20170412174920.8744-4-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <bdff9bc8-a521-ddd6-3c71-bb97976b75ec@redhat.com>
Date: Wed, 12 Apr 2017 18:47:31 -0400
MIME-Version: 1.0
In-Reply-To: <20170412174920.8744-4-eblake@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/12] dirty-bitmap: Drop unused functions
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



On 04/12/2017 01:49 PM, Eric Blake wrote:
> We had several functions that no one was using, and which used
> sector-based interfaces.  I'm trying to convert towards byte-based
> interfaces, so it's easier to just drop the unused functions:
> 
> bdrv_dirty_bitmap_size
> bdrv_dirty_bitmap_get_meta
> bdrv_dirty_bitmap_reset_meta
> bdrv_dirty_bitmap_meta_granularity
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  include/block/dirty-bitmap.h |  8 --------
>  block/dirty-bitmap.c         | 34 ----------------------------------
>  2 files changed, 42 deletions(-)
> 
> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
> index 9dea14b..a83979d 100644
> --- a/include/block/dirty-bitmap.h
> +++ b/include/block/dirty-bitmap.h
> @@ -30,11 +30,9 @@ void bdrv_enable_dirty_bitmap(BdrvDirtyBitmap *bitmap);
>  BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs);
>  uint32_t bdrv_get_default_bitmap_granularity(BlockDriverState *bs);
>  uint32_t bdrv_dirty_bitmap_granularity(BdrvDirtyBitmap *bitmap);
> -uint32_t bdrv_dirty_bitmap_meta_granularity(BdrvDirtyBitmap *bitmap);
>  bool bdrv_dirty_bitmap_enabled(BdrvDirtyBitmap *bitmap);
>  bool bdrv_dirty_bitmap_frozen(BdrvDirtyBitmap *bitmap);
>  const char *bdrv_dirty_bitmap_name(const BdrvDirtyBitmap *bitmap);
> -int64_t bdrv_dirty_bitmap_size(const BdrvDirtyBitmap *bitmap);
>  DirtyBitmapStatus bdrv_dirty_bitmap_status(BdrvDirtyBitmap *bitmap);
>  int bdrv_get_dirty(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
>                     int64_t sector);
> @@ -42,12 +40,6 @@ void bdrv_set_dirty_bitmap(BdrvDirtyBitmap *bitmap,
>                             int64_t cur_sector, int64_t nr_sectors);
>  void bdrv_reset_dirty_bitmap(BdrvDirtyBitmap *bitmap,
>                               int64_t cur_sector, int64_t nr_sectors);
> -int bdrv_dirty_bitmap_get_meta(BlockDriverState *bs,
> -                               BdrvDirtyBitmap *bitmap, int64_t sector,
> -                               int nb_sectors);
> -void bdrv_dirty_bitmap_reset_meta(BlockDriverState *bs,
> -                                  BdrvDirtyBitmap *bitmap, int64_t sector,
> -                                  int nb_sectors);
>  BdrvDirtyBitmapIter *bdrv_dirty_meta_iter_new(BdrvDirtyBitmap *bitmap);
>  BdrvDirtyBitmapIter *bdrv_dirty_iter_new(BdrvDirtyBitmap *bitmap,
>                                           uint64_t first_sector);
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index 6d8ce5f..32698d5 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -130,35 +130,6 @@ void bdrv_release_meta_dirty_bitmap(BdrvDirtyBitmap *bitmap)
>      bitmap->meta = NULL;
>  }
> 
> -int bdrv_dirty_bitmap_get_meta(BlockDriverState *bs,
> -                               BdrvDirtyBitmap *bitmap, int64_t sector,
> -                               int nb_sectors)
> -{
> -    uint64_t i;
> -    int sectors_per_bit = 1 << hbitmap_granularity(bitmap->meta);
> -
> -    /* To optimize: we can make hbitmap to internally check the range in a
> -     * coarse level, or at least do it word by word. */
> -    for (i = sector; i < sector + nb_sectors; i += sectors_per_bit) {
> -        if (hbitmap_get(bitmap->meta, i)) {
> -            return true;
> -        }
> -    }
> -    return false;
> -}
> -
> -void bdrv_dirty_bitmap_reset_meta(BlockDriverState *bs,
> -                                  BdrvDirtyBitmap *bitmap, int64_t sector,
> -                                  int nb_sectors)
> -{
> -    hbitmap_reset(bitmap->meta, sector, nb_sectors);
> -}
> -
> -int64_t bdrv_dirty_bitmap_size(const BdrvDirtyBitmap *bitmap)
> -{
> -    return bitmap->size;
> -}
> -
>  const char *bdrv_dirty_bitmap_name(const BdrvDirtyBitmap *bitmap)
>  {
>      return bitmap->name;
> @@ -393,11 +364,6 @@ uint32_t bdrv_dirty_bitmap_granularity(BdrvDirtyBitmap *bitmap)
>      return BDRV_SECTOR_SIZE << hbitmap_granularity(bitmap->bitmap);
>  }
> 
> -uint32_t bdrv_dirty_bitmap_meta_granularity(BdrvDirtyBitmap *bitmap)
> -{
> -    return BDRV_SECTOR_SIZE << hbitmap_granularity(bitmap->meta);
> -}
> -
>  BdrvDirtyBitmapIter *bdrv_dirty_iter_new(BdrvDirtyBitmap *bitmap,
>                                           uint64_t first_sector)
>  {
> 

I think it's likely Vladimir is or at least was relying on some of these
for his migration and persistence series.

Might be nice to let him chime in to see how much of a hassle this is.
