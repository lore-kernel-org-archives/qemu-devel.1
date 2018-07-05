Received: from eggs.gnu.org ([2001:4830:134:3::10]:36330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fb9MH-0001MA-SZ
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:52:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fb9MG-0005iO-OS
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:52:01 -0400
References: <20180703105305.45398-1-vsementsov@virtuozzo.com>
	<20180703105305.45398-2-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <d7e510dc-c6f6-3d5b-b716-0df88759440c@redhat.com>
Date: Thu, 5 Jul 2018 14:51:39 -0400
MIME-Version: 1.0
In-Reply-To: <20180703105305.45398-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] drity-bitmap: refactor merge: separte
 can_merge
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



On 07/03/2018 06:53 AM, Vladimir Sementsov-Ogievskiy wrote:
> Separate can_merge, to reuse it for transaction support for merge
> command.
> 
> Also, switch some asserts to errors.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/dirty-bitmap.h |  3 +++
>  include/qemu/hbitmap.h       |  8 ++++++++
>  block/dirty-bitmap.c         | 32 +++++++++++++++++++++++++++-----
>  blockdev.c                   | 10 ----------
>  util/hbitmap.c               |  6 +++++-
>  5 files changed, 43 insertions(+), 16 deletions(-)
> 
> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
> index 288dc6adb6..412a333c02 100644
> --- a/include/block/dirty-bitmap.h
> +++ b/include/block/dirty-bitmap.h
> @@ -71,6 +71,9 @@ void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap,
>  void bdrv_dirty_bitmap_set_qmp_locked(BdrvDirtyBitmap *bitmap, bool qmp_locked);
>  void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
>                               Error **errp);
> +bool bdrv_can_merge_dirty_bitmap(BdrvDirtyBitmap *dst,
> +                                 const BdrvDirtyBitmap *src,
> +                                 Error **errp);
>  
>  /* Functions that require manual locking.  */
>  void bdrv_dirty_bitmap_lock(BdrvDirtyBitmap *bitmap);
> diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
> index ddca52c48e..d08bc20ea3 100644
> --- a/include/qemu/hbitmap.h
> +++ b/include/qemu/hbitmap.h
> @@ -85,6 +85,14 @@ void hbitmap_truncate(HBitmap *hb, uint64_t size);
>  bool hbitmap_merge(HBitmap *a, const HBitmap *b);
>  
>  /**
> + * hbitmap_can_merge:
> + *
> + * Returns same value as hbitmap_merge, but do not do actual merge.
> + *
> + */
> +bool hbitmap_can_merge(HBitmap *a, const HBitmap *b);
> +
> +/**
>   * hbitmap_empty:
>   * @hb: HBitmap to operate on.
>   *
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index db1782ec1f..1137224aaa 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -784,6 +784,30 @@ int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t offset)
>      return hbitmap_next_zero(bitmap->bitmap, offset);
>  }
>  
> +bool bdrv_can_merge_dirty_bitmap(BdrvDirtyBitmap *dst,
> +                                 const BdrvDirtyBitmap *src,
> +                                 Error **errp)
> +{
> +    if (bdrv_dirty_bitmap_frozen(dst)) {
> +        error_setg(errp, "Bitmap '%s' is frozen and cannot be modified",
> +                   dst->name);
> +        return false;
> +    }
> +
> +    if (bdrv_dirty_bitmap_readonly(dst)) {
> +        error_setg(errp, "Bitmap '%s' is readonly and cannot be modified",
> +                   dst->name);
> +        return false;
> +    }
> +
> +    if (!hbitmap_can_merge(dst->bitmap, src->bitmap)) {
> +        error_setg(errp, "Bitmaps are incompatible and can't be merged");
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>  void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
>                               Error **errp)
>  {
> @@ -792,11 +816,9 @@ void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
>  
>      qemu_mutex_lock(dest->mutex);
>  
> -    assert(bdrv_dirty_bitmap_enabled(dest));

Slight behavior change by removing this, but it makes sense.

> -    assert(!bdrv_dirty_bitmap_readonly(dest));
> -
> -    if (!hbitmap_merge(dest->bitmap, src->bitmap)) {
> -        error_setg(errp, "Bitmaps are incompatible and can't be merged");
> +    if (bdrv_can_merge_dirty_bitmap(dest, src, errp)) {
> +        bool ret = hbitmap_merge(dest->bitmap, src->bitmap);
> +        assert(ret);

Might as well just assert(hbitmap_merge(...));

>      }
>  
>      qemu_mutex_unlock(dest->mutex);
> diff --git a/blockdev.c b/blockdev.c
> index 58d7570932..63c4d33124 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2955,16 +2955,6 @@ void qmp_x_block_dirty_bitmap_merge(const char *node, const char *dst_name,
>          return;
>      }
>  
> -    if (bdrv_dirty_bitmap_frozen(dst)) {
> -        error_setg(errp, "Bitmap '%s' is frozen and cannot be modified",
> -                   dst_name);
> -        return;
> -    } else if (bdrv_dirty_bitmap_readonly(dst)) {
> -        error_setg(errp, "Bitmap '%s' is readonly and cannot be modified",
> -                   dst_name);
> -        return;
> -    }
> -
>      src = bdrv_find_dirty_bitmap(bs, src_name);
>      if (!src) {
>          error_setg(errp, "Dirty bitmap '%s' not found", src_name);
> diff --git a/util/hbitmap.c b/util/hbitmap.c
> index bcd304041a..b56377b043 100644
> --- a/util/hbitmap.c
> +++ b/util/hbitmap.c
> @@ -723,6 +723,10 @@ void hbitmap_truncate(HBitmap *hb, uint64_t size)
>      }
>  }
>  
> +bool hbitmap_can_merge(HBitmap *a, const HBitmap *b)
> +{
> +    return (a->size == b->size) && (a->granularity == b->granularity);
> +}
>  
>  /**
>   * Given HBitmaps A and B, let A := A (BITOR) B.
> @@ -736,7 +740,7 @@ bool hbitmap_merge(HBitmap *a, const HBitmap *b)
>      int i;
>      uint64_t j;
>  
> -    if ((a->size != b->size) || (a->granularity != b->granularity)) {
> +    if (!hbitmap_can_merge(a, b)) {
>          return false;
>      }
>  
> 

Reviewed-by: John Snow <jsnow@redhat.com>
