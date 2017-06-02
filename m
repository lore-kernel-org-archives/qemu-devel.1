Received: from eggs.gnu.org ([2001:4830:134:3::10]:46990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dGtim-0005NV-FZ
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 17:03:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dGtil-00040H-5p
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 17:03:00 -0400
References: <20170602112158.232757-1-vsementsov@virtuozzo.com>
	<20170602112158.232757-11-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <ccd143a1-e6dd-a08c-5747-cd46bbbf0429@redhat.com>
Date: Fri, 2 Jun 2017 17:02:47 -0400
MIME-Version: 1.0
In-Reply-To: <20170602112158.232757-11-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v20 10/30] block/dirty-bitmap: add readonly
 field to BdrvDirtyBitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org



On 06/02/2017 07:21 AM, Vladimir Sementsov-Ogievskiy wrote:
> It will be needed in following commits for persistent bitmaps.
> If bitmap is loaded from read-only storage (and we can't mark it
> "in use" in this storage) corresponding BdrvDirtyBitmap should be
> read-only.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/dirty-bitmap.c         | 32 ++++++++++++++++++++++++++++++++
>  block/io.c                   |  8 ++++++++
>  blockdev.c                   |  6 ++++++
>  include/block/dirty-bitmap.h |  4 ++++
>  4 files changed, 50 insertions(+)
> 
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index f25428868c..1c9ffb292a 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -45,6 +45,12 @@ struct BdrvDirtyBitmap {
>      bool disabled;              /* Bitmap is disabled. It skips all writes to
>                                     the device */
>      int active_iterators;       /* How many iterators are active */
> +    bool readonly;              /* Bitmap is read-only and may be changed only
> +                                   by deserialize* functions. This field blocks

In what way do the deserialize functions change the bitmaps, again?

> +                                   any changing operations on owning image
> +                                   (writes and discards), if bitmap is readonly
> +                                   such operations must fail and not change
> +                                   image or this bitmap */
>      QLIST_ENTRY(BdrvDirtyBitmap) list;
>  };
>  
> @@ -437,6 +443,7 @@ void bdrv_set_dirty_bitmap(BdrvDirtyBitmap *bitmap,
>                             int64_t cur_sector, int64_t nr_sectors)
>  {
>      assert(bdrv_dirty_bitmap_enabled(bitmap));
> +    assert(!bdrv_dirty_bitmap_readonly(bitmap));

I still feel as if bdrv_dirty_bitmap_enabled() can return false if
bdrv_dirty_bitmap_readonly is true, and you wouldn't have to edit these
parts, but I don't care enough to press the issue.

>      hbitmap_set(bitmap->bitmap, cur_sector, nr_sectors);
>  }
>  
> @@ -444,12 +451,14 @@ void bdrv_reset_dirty_bitmap(BdrvDirtyBitmap *bitmap,
>                               int64_t cur_sector, int64_t nr_sectors)
>  {
>      assert(bdrv_dirty_bitmap_enabled(bitmap));
> +    assert(!bdrv_dirty_bitmap_readonly(bitmap));
>      hbitmap_reset(bitmap->bitmap, cur_sector, nr_sectors);
>  }
>  
>  void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out)
>  {
>      assert(bdrv_dirty_bitmap_enabled(bitmap));
> +    assert(!bdrv_dirty_bitmap_readonly(bitmap));
>      if (!out) {
>          hbitmap_reset_all(bitmap->bitmap);
>      } else {
> @@ -520,6 +529,7 @@ void bdrv_set_dirty(BlockDriverState *bs, int64_t cur_sector,
>          if (!bdrv_dirty_bitmap_enabled(bitmap)) {
>              continue;
>          }
> +        assert(!bdrv_dirty_bitmap_readonly(bitmap));

Highlighting the difference in strictness between "disabled" and "readonly."

>          hbitmap_set(bitmap->bitmap, cur_sector, nr_sectors);
>      }
>  }
> @@ -541,3 +551,25 @@ int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap)
>  {
>      return hbitmap_count(bitmap->meta);
>  }
> +
> +bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap)
> +{
> +    return bitmap->readonly;
> +}
> +
> +void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap, bool value)
> +{
> +    bitmap->readonly = value;
> +}
> +
> +bool bdrv_has_readonly_bitmaps(BlockDriverState *bs)
> +{
> +    BdrvDirtyBitmap *bm;
> +    QLIST_FOREACH(bm, &bs->dirty_bitmaps, list) {
> +        if (bm->readonly) {
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> diff --git a/block/io.c b/block/io.c
> index fdd7485c22..0e28a1f595 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1349,6 +1349,10 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
>      uint64_t bytes_remaining = bytes;
>      int max_transfer;
>  
> +    if (bdrv_has_readonly_bitmaps(bs)) {
> +        return -EPERM;
> +    }
> +

Should this be a dynamic error, or an assertion? We should probably
endeavor to never actually hit this circumstance (we should not have
readonly bitmaps on a RW node.)

>      assert(is_power_of_2(align));
>      assert((offset & (align - 1)) == 0);
>      assert((bytes & (align - 1)) == 0);
> @@ -2437,6 +2441,10 @@ int coroutine_fn bdrv_co_pdiscard(BlockDriverState *bs, int64_t offset,
>          return -ENOMEDIUM;
>      }
>  
> +    if (bdrv_has_readonly_bitmaps(bs)) {
> +        return -EPERM;
> +    }
> +
>      ret = bdrv_check_byte_request(bs, offset, count);
>      if (ret < 0) {
>          return ret;
> diff --git a/blockdev.c b/blockdev.c
> index c63f4e82c7..2b397abf66 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2033,6 +2033,9 @@ static void block_dirty_bitmap_clear_prepare(BlkActionState *common,
>      } else if (!bdrv_dirty_bitmap_enabled(state->bitmap)) {
>          error_setg(errp, "Cannot clear a disabled bitmap");
>          return;
> +    } else if (bdrv_dirty_bitmap_readonly(state->bitmap)) {
> +        error_setg(errp, "Cannot clear a readonly bitmap");
> +        return;
>      }

Probably getting close to easier to specify what state we DO allow
bitmaps to be cleared in (enabled/active, not frozen, disabled or readonly.)

>  
>      bdrv_clear_dirty_bitmap(state->bitmap, &state->backup);
> @@ -2813,6 +2816,9 @@ void qmp_block_dirty_bitmap_clear(const char *node, const char *name,
>                     "Bitmap '%s' is currently disabled and cannot be cleared",
>                     name);
>          goto out;
> +    } else if (bdrv_dirty_bitmap_readonly(bitmap)) {
> +        error_setg(errp, "Bitmap '%s' is readonly and cannot be cleared", name);
> +        goto out;
>      }

Random thought, maybe qmp_block_dirty_bitmap_clear should utilize the
transactional action core to perform this action instead of
reimplementing it. This has nothing to do with you, though.

>  
>      bdrv_clear_dirty_bitmap(bitmap, NULL);
> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
> index 1e17729ac2..aa6d47ee00 100644
> --- a/include/block/dirty-bitmap.h
> +++ b/include/block/dirty-bitmap.h
> @@ -75,4 +75,8 @@ void bdrv_dirty_bitmap_deserialize_ones(BdrvDirtyBitmap *bitmap,
>                                          bool finish);
>  void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap);
>  
> +bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap);
> +void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap, bool value);
> +bool bdrv_has_readonly_bitmaps(BlockDriverState *bs);
> +
>  #endif
> 

Reviewed-by: John Snow <jsnow@redhat.com>
