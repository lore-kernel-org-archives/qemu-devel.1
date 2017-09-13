Received: from eggs.gnu.org ([2001:4830:134:3::10]:33486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dsH4M-0005xe-Vk
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 19:27:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dsH4L-0004bL-Vh
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 19:27:46 -0400
References: <20170912203119.24166-1-eblake@redhat.com>
	<20170912203119.24166-6-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <84d98f85-958f-ad74-6951-68fd4241fcdf@redhat.com>
Date: Wed, 13 Sep 2017 19:27:30 -0400
MIME-Version: 1.0
In-Reply-To: <20170912203119.24166-6-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 05/20] dirty-bitmap: Check for size
 query failure during truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 09/12/2017 04:31 PM, Eric Blake wrote:
> We've previously fixed several places where we failed to account
> for possible errors from bdrv_nb_sectors().  Fix another one by
> making bdrv_dirty_bitmap_truncate() report the error rather then
> silently resizing bitmaps to -1.  Then adjust the sole caller

Nice failure mode. It was not immediately obvious to me that this could
fail, but here we all are.

> bdrv_truncate() to both reduce the likelihood of failure (blindly
> calling bdrv_dirty_bitmap_truncate() after refresh_total_sectors()
> fails was not nice) as well as propagate any actual failures.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v7: new patch [Kevin]
> ---
>  include/block/dirty-bitmap.h |  2 +-
>  block.c                      | 19 ++++++++++++++-----
>  block/dirty-bitmap.c         | 12 ++++++++----
>  3 files changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
> index 8fd842eac9..15101b59d5 100644
> --- a/include/block/dirty-bitmap.h
> +++ b/include/block/dirty-bitmap.h
> @@ -83,7 +83,7 @@ int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter);
>  void bdrv_set_dirty_iter(BdrvDirtyBitmapIter *hbi, int64_t sector_num);
>  int64_t bdrv_get_dirty_count(BdrvDirtyBitmap *bitmap);
>  int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap);
> -void bdrv_dirty_bitmap_truncate(BlockDriverState *bs);
> +int bdrv_dirty_bitmap_truncate(BlockDriverState *bs);
>  bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap);
>  bool bdrv_has_readonly_bitmaps(BlockDriverState *bs);
>  bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap);
> diff --git a/block.c b/block.c
> index ee6a48976e..790dcce360 100644
> --- a/block.c
> +++ b/block.c
> @@ -3450,12 +3450,21 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, PreallocMode prealloc,
>      assert(!(bs->open_flags & BDRV_O_INACTIVE));
> 
>      ret = drv->bdrv_truncate(bs, offset, prealloc, errp);
> -    if (ret == 0) {
> -        ret = refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS);
> -        bdrv_dirty_bitmap_truncate(bs);
> -        bdrv_parent_cb_resize(bs);
> -        atomic_inc(&bs->write_gen);
> +    if (ret < 0) {
> +        return ret;
>      }
> +    ret = refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "Could not refresh total sector count");
> +        return ret;
> +    }
> +    ret = bdrv_dirty_bitmap_truncate(bs);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "Could not refresh total sector count");

You probably meant to write a different error message here.

Also, what happens if the actual truncate call works, but the bitmap
resizing fails? What state does that leave us in?
