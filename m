Received: from eggs.gnu.org ([2001:4830:134:3::10]:49784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1duEer-0004VL-4u
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:17:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1duEen-0000wp-1G
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:17:33 -0400
Date: Tue, 19 Sep 2017 17:17:19 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170919091719.GE11534@lemon.lan>
References: <20170918185819.5984-1-eblake@redhat.com>
	<20170918185819.5984-6-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170918185819.5984-6-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 05/20] dirty-bitmap: Avoid size query
 failure during truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Mon, 09/18 13:58, Eric Blake wrote:
> We've previously fixed several places where we failed to account
> for possible errors from bdrv_nb_sectors().  Fix another one by
> making bdrv_dirty_bitmap_truncate() take the new size from the
> caller instead of querying itself; then adjust the sole caller
> bdrv_truncate() to pass the size just determined by a successful
> resize, or to skip the bitmap resize on failure, thus avoiding
> sizing the bitmaps to -1.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v8: retitle and rework to avoid possibility of secondary failure [John]
> v7: new patch [Kevin]
> ---
>  include/block/dirty-bitmap.h |  2 +-
>  block.c                      | 15 ++++++++++-----
>  block/dirty-bitmap.c         |  6 +++---
>  3 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
> index 8fd842eac9..7a27590047 100644
> --- a/include/block/dirty-bitmap.h
> +++ b/include/block/dirty-bitmap.h
> @@ -83,7 +83,7 @@ int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter);
>  void bdrv_set_dirty_iter(BdrvDirtyBitmapIter *hbi, int64_t sector_num);
>  int64_t bdrv_get_dirty_count(BdrvDirtyBitmap *bitmap);
>  int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap);
> -void bdrv_dirty_bitmap_truncate(BlockDriverState *bs);
> +void bdrv_dirty_bitmap_truncate(BlockDriverState *bs, int64_t bytes);
>  bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap);
>  bool bdrv_has_readonly_bitmaps(BlockDriverState *bs);
>  bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap);
> diff --git a/block.c b/block.c
> index ee6a48976e..61ee9d4b83 100644
> --- a/block.c
> +++ b/block.c
> @@ -3450,12 +3450,17 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, PreallocMode prealloc,
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

Ugh, if we get here the situation is a bit embarrassing, because...

> +        error_setg_errno(errp, -ret, "Could not refresh total sector count");
> +        return ret;
> +    }
> +    bdrv_dirty_bitmap_truncate(bs, bs->total_sectors * BDRV_SECTOR_SIZE);
> +    bdrv_parent_cb_resize(bs);
> +    atomic_inc(&bs->write_gen);

I think we still want to inc write_gen even if refresh_total_sectors failed, if
drv->bdrv_truncate has succeeded? That way the next bdrv_co_flush will actually
flush the metadata change to disk.

Maybe similarly call bdrv_parent_cb_resize() as long as drv->bdrv_truncate()
succeeded? The effect is the virtual devices notify guest about this "resized"
event, which I think is correct.

Fam
