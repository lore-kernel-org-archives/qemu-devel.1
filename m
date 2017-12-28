Received: from eggs.gnu.org ([2001:4830:134:3::10]:39866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eUQgJ-0003Bd-3S
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 00:24:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eUQgI-0005m9-1R
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 00:24:39 -0500
Date: Thu, 28 Dec 2017 13:24:18 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171228052418.GC9192@lemon>
References: <20171220154945.88410-1-vsementsov@virtuozzo.com>
	<20171220154945.88410-4-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171220154945.88410-4-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v9 03/13] block/dirty-bitmap: add _locked
 version of bdrv_reclaim_dirty_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com

On Wed, 12/20 18:49, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/dirty-bitmap.h |  3 +++
>  block/dirty-bitmap.c         | 25 ++++++++++++++++---------
>  2 files changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
> index 93d4336505..caf1f3d861 100644
> --- a/include/block/dirty-bitmap.h
> +++ b/include/block/dirty-bitmap.h
> @@ -92,5 +92,8 @@ bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs);
>  BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
>                                          BdrvDirtyBitmap *bitmap);
>  char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **errp);
> +BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
> +                                                  BdrvDirtyBitmap *bitmap,
> +                                                  Error **errp);
>  
>  #endif
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index d83da077d5..fe27ddfb83 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -327,15 +327,11 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
>   * The merged parent will be un-frozen, but not explicitly re-enabled.
>   * Called with BQL taken.

Maybe update the comment as

s/Called with BQL taken/Called within bdrv_dirty_bitmap_lock..unlock/

and ...

>   */
> -BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
> -                                           BdrvDirtyBitmap *parent,
> -                                           Error **errp)
> +BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
> +                                                  BdrvDirtyBitmap *parent,
> +                                                  Error **errp)
>  {
> -    BdrvDirtyBitmap *successor;
> -
> -    qemu_mutex_lock(parent->mutex);
> -
> -    successor = parent->successor;
> +    BdrvDirtyBitmap *successor = parent->successor;
>  
>      if (!successor) {
>          error_setg(errp, "Cannot reclaim a successor when none is present");
> @@ -349,9 +345,20 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
>      bdrv_release_dirty_bitmap_locked(bs, successor);
>      parent->successor = NULL;
>  
> +    return parent;
> +}
> +

... move the "Called with BQL taken" comment here?

> +BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
> +                                           BdrvDirtyBitmap *parent,
> +                                           Error **errp)
> +{
> +    BdrvDirtyBitmap *ret;
> +
> +    qemu_mutex_lock(parent->mutex);
> +    ret = bdrv_reclaim_dirty_bitmap_locked(bs, parent, errp);
>      qemu_mutex_unlock(parent->mutex);
>  
> -    return parent;
> +    return ret;
>  }
>  
>  /**
> -- 
> 2.11.1
> 
