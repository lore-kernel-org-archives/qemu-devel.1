Received: from eggs.gnu.org ([2001:4830:134:3::10]:43454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fzU72-00005k-UA
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 17:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fzU71-0002c3-KM
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 17:52:52 -0400
References: <20180706113630.25222-1-vsementsov@virtuozzo.com>
	<20180706113630.25222-3-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <44037793-aa04-e25a-1299-32706f237ad9@redhat.com>
Date: Mon, 10 Sep 2018 17:52:42 -0400
MIME-Version: 1.0
In-Reply-To: <20180706113630.25222-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/4] dirty-bitmap: restore bitmap after
 merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, den@openvz.org

We actually don't restore anything just yet, so this commit message is a
little off I think.

On 07/06/2018 07:36 AM, Vladimir Sementsov-Ogievskiy wrote:
> Add backup parameter to bdrv_merge_dirty_bitmap() and refactor
> bdrv_undo_clear_dirty_bitmap() to use it both for undo clean and merge.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/block_int.h    |  2 +-
>  include/block/dirty-bitmap.h |  2 +-
>  include/qemu/hbitmap.h       | 25 ++++++++++++++++---------
>  block/dirty-bitmap.c         | 21 ++++++++++++++++-----
>  blockdev.c                   |  4 ++--
>  util/hbitmap.c               | 11 ++++++++---
>  6 files changed, 44 insertions(+), 21 deletions(-)
> 
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index af71b414be..64e38b4fae 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -1144,7 +1144,7 @@ bool blk_dev_is_medium_locked(BlockBackend *blk);
>  void bdrv_set_dirty(BlockDriverState *bs, int64_t offset, int64_t bytes);
>  
>  void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out);
> -void bdrv_undo_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap *in);
> +void bdrv_restore_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap *backup);
>  
>  void bdrv_inc_in_flight(BlockDriverState *bs);
>  void bdrv_dec_in_flight(BlockDriverState *bs);
> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
> index 259bd27c40..201ff7f20b 100644
> --- a/include/block/dirty-bitmap.h
> +++ b/include/block/dirty-bitmap.h
> @@ -71,7 +71,7 @@ void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap,
>                                         bool persistent);
>  void bdrv_dirty_bitmap_set_qmp_locked(BdrvDirtyBitmap *bitmap, bool qmp_locked);
>  void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
> -                             Error **errp);
> +                             HBitmap **backup, Error **errp);
>  
>  /* Functions that require manual locking.  */
>  void bdrv_dirty_bitmap_lock(BdrvDirtyBitmap *bitmap);
> diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
> index ddca52c48e..a7cb780592 100644
> --- a/include/qemu/hbitmap.h
> +++ b/include/qemu/hbitmap.h
> @@ -73,16 +73,23 @@ void hbitmap_truncate(HBitmap *hb, uint64_t size);
>  
>  /**
>   * hbitmap_merge:
> - * @a: The bitmap to store the result in.
> - * @b: The bitmap to merge into @a.
> - * @return true if the merge was successful,
> - *         false if it was not attempted.
> - *
> - * Merge two bitmaps together.
> - * A := A (BITOR) B.
> - * B is left unmodified.
> + *
> + * Store result of merging @a and @b into @result.
> + * @result is allowed to be equal to @a or @b.
> + *
> + * Return true if the merge was successful,
> + *        false if it was not attempted.
> + */
> +bool hbitmap_merge(const HBitmap *a, const HBitmap *b, HBitmap *result);

I wonder if this confuses any optimization or analysis tools. I'll
assume it's safe.

> +
> +/**
> + * hbitmap_can_merge:
> + *
> + * hbitmap_can_merge(a, b) && hbitmap_can_merge(a, result) is sufficient and
> + * necessary for hbitmap_merge will not fail.
> + *
>   */
> -bool hbitmap_merge(HBitmap *a, const HBitmap *b);
> +bool hbitmap_can_merge(const HBitmap *a, const HBitmap *b);
>  
>  /**
>   * hbitmap_empty:
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index 6c8761e027..8ac933cf1c 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -314,7 +314,7 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
>          return NULL;
>      }
>  
> -    if (!hbitmap_merge(parent->bitmap, successor->bitmap)) {
> +    if (!hbitmap_merge(parent->bitmap, successor->bitmap, parent->bitmap)) {
>          error_setg(errp, "Merging of parent and successor bitmap failed");
>          return NULL;
>      }
> @@ -633,12 +633,12 @@ void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out)
>      bdrv_dirty_bitmap_unlock(bitmap);
>  }
>  
> -void bdrv_undo_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap *in)
> +void bdrv_restore_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap *backup)
>  {
>      HBitmap *tmp = bitmap->bitmap;
>      assert(bdrv_dirty_bitmap_enabled(bitmap));
>      assert(!bdrv_dirty_bitmap_readonly(bitmap));
> -    bitmap->bitmap = in;
> +    bitmap->bitmap = backup;
>      hbitmap_free(tmp);
>  }
>  
> @@ -791,8 +791,10 @@ int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t offset)
>  }
>  
>  void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
> -                             Error **errp)
> +                             HBitmap **backup, Error **errp)
>  {
> +    bool ret;
> +
>      /* only bitmaps from one bds are supported */
>      assert(dest->mutex == src->mutex);
>  
> @@ -810,11 +812,20 @@ void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
>          goto out;
>      }
>  
> -    if (!hbitmap_merge(dest->bitmap, src->bitmap)) {
> +    if (!hbitmap_can_merge(dest->bitmap, src->bitmap)) {
>          error_setg(errp, "Bitmaps are incompatible and can't be merged");
>          goto out;
>      }
>  
> +    if (backup) {
> +        *backup = dest->bitmap;
> +        dest->bitmap = hbitmap_alloc(dest->size, hbitmap_granularity(*backup));
> +        ret = hbitmap_merge(*backup, src->bitmap, dest->bitmap);
> +    } else {
> +        ret = hbitmap_merge(dest->bitmap, src->bitmap, dest->bitmap);
> +    }
> +    assert(ret);
> +
>  out:
>      qemu_mutex_unlock(dest->mutex);
>  }
> diff --git a/blockdev.c b/blockdev.c
> index 902338e815..9cb29ca63e 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2032,7 +2032,7 @@ static void block_dirty_bitmap_clear_abort(BlkActionState *common)
>                                               common, common);
>  
>      if (state->backup) {
> -        bdrv_undo_clear_dirty_bitmap(state->bitmap, state->backup);
> +        bdrv_restore_dirty_bitmap(state->bitmap, state->backup);
>      }
>  }
>  
> @@ -2961,7 +2961,7 @@ void qmp_x_block_dirty_bitmap_merge(const char *node, const char *dst_name,
>          return;
>      }
>  
> -    bdrv_merge_dirty_bitmap(dst, src, errp);
> +    bdrv_merge_dirty_bitmap(dst, src, NULL, errp);
>  }
>  
>  BlockDirtyBitmapSha256 *qmp_x_debug_block_dirty_bitmap_sha256(const char *node,
> diff --git a/util/hbitmap.c b/util/hbitmap.c
> index bcd304041a..d5aca5159f 100644
> --- a/util/hbitmap.c
> +++ b/util/hbitmap.c
> @@ -723,6 +723,10 @@ void hbitmap_truncate(HBitmap *hb, uint64_t size)
>      }
>  }
>  
> +bool hbitmap_can_merge(const HBitmap *a, const HBitmap *b)
> +{
> +    return (a->size == b->size) && (a->granularity == b->granularity);
> +}
>  
>  /**
>   * Given HBitmaps A and B, let A := A (BITOR) B.
> @@ -731,14 +735,15 @@ void hbitmap_truncate(HBitmap *hb, uint64_t size)
>   * @return true if the merge was successful,
>   *         false if it was not attempted.
>   */
> -bool hbitmap_merge(HBitmap *a, const HBitmap *b)
> +bool hbitmap_merge(const HBitmap *a, const HBitmap *b, HBitmap *result)
>  {
>      int i;
>      uint64_t j;
>  
> -    if ((a->size != b->size) || (a->granularity != b->granularity)) {
> +    if (!hbitmap_can_merge(a, b) || !hbitmap_can_merge(a, result)) {
>          return false;
>      }
> +    assert(hbitmap_can_merge(b, result));

This line might really be overkill, but I suppose it doesn't take long
to check, so no harm.

>  
>      if (hbitmap_count(b) == 0) {
>          return true;
> @@ -750,7 +755,7 @@ bool hbitmap_merge(HBitmap *a, const HBitmap *b)
>       */
>      for (i = HBITMAP_LEVELS - 1; i >= 0; i--) {
>          for (j = 0; j < a->sizes[i]; j++) {
> -            a->levels[i][j] |= b->levels[i][j];
> +            result->levels[i][j] = a->levels[i][j] | b->levels[i][j];
>          }
>      }
>  
> 

This patch really does two things; Refactors undo_clear and adds the new
merge functionality, but not worth respinning just to separate two
trivial changes.

Only minor comments, so:

Reviewed-by: John Snow <jsnow@redhat.com>
