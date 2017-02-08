Received: from eggs.gnu.org ([2001:4830:134:3::10]:36482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cbQhD-00081j-Hu
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 06:46:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cbQhC-0001YS-CT
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 06:45:59 -0500
Date: Wed, 8 Feb 2017 19:45:46 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170208114546.GA397@lemon.lan>
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
	<20170203154757.36140-11-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170203154757.36140-11-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 10/18] block/dirty-bitmap: add
 bdrv_load_dirty_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, den@virtuozzo.com, stefanha@redhat.com

On Fri, 02/03 18:47, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/dirty-bitmap.c         | 53 ++++++++++++++++++++++++++++++++++++++++++++
>  include/block/block_int.h    |  4 ++++
>  include/block/dirty-bitmap.h |  3 +++
>  3 files changed, 60 insertions(+)
> 
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index 3b7db1d78c..394d4328d5 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -545,3 +545,56 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
>      return bitmap == NULL ? QLIST_FIRST(&bs->dirty_bitmaps) :
>                              QLIST_NEXT(bitmap, list);
>  }
> +
> +typedef struct BDRVLoadBitmapCo {
> +    BlockDriverState *bs;
> +    const char *name;
> +    Error **errp;
> +    BdrvDirtyBitmap *ret;
> +    bool in_progress;
> +} BDRVLoadBitmapCo;
> +
> +static void bdrv_load_dity_bitmap_co_entry(void *opaque)

Add coroutine_fn?

> +{
> +    BDRVLoadBitmapCo *lbco = opaque;
> +    BlockDriver *drv = lbco->bs->drv;
> +
> +    if (!!drv && !!drv->bdrv_dirty_bitmap_load) {
> +        lbco->ret = drv->bdrv_dirty_bitmap_load(lbco->bs, lbco->name,
> +                                                lbco->errp);
> +    } else if (lbco->bs->file)  {
> +        BlockDriverState *bs = lbco->bs;
> +        lbco->bs = lbco->bs->file->bs;
> +        bdrv_load_dity_bitmap_co_entry(lbco);
> +        if (lbco->ret != NULL) {
> +            QLIST_REMOVE(lbco->ret, list);
> +            QLIST_INSERT_HEAD(&bs->dirty_bitmaps, lbco->ret, list);
> +        }
> +    } else {
> +        lbco->ret = NULL;
> +    }
> +
> +    lbco->in_progress = false;
> +}
> +
> +BdrvDirtyBitmap *bdrv_load_dirty_bitmap(BlockDriverState *bs, const char *name,
> +                                        Error **errp)
> +{
> +    Coroutine *co;
> +    BDRVLoadBitmapCo lbco = {
> +        .bs = bs,
> +        .name = name,
> +        .errp = errp,
> +        .in_progress = true
> +    };
> +
> +    if (qemu_in_coroutine()) {
> +        bdrv_load_dity_bitmap_co_entry(&lbco);
> +    } else {
> +        co = qemu_coroutine_create(bdrv_load_dity_bitmap_co_entry, &lbco);
> +        qemu_coroutine_enter(co);
> +        BDRV_POLL_WHILE(bs, lbco.in_progress);
> +    }
> +
> +    return lbco.ret;
> +}
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 83a423c580..d3770db539 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -222,6 +222,10 @@ struct BlockDriver {
>      int (*bdrv_get_info)(BlockDriverState *bs, BlockDriverInfo *bdi);
>      ImageInfoSpecific *(*bdrv_get_specific_info)(BlockDriverState *bs);
>  
> +    BdrvDirtyBitmap *(*bdrv_dirty_bitmap_load)(BlockDriverState *bs,
> +                                               const char *name,
> +                                               Error **errp);
> +
>      int coroutine_fn (*bdrv_save_vmstate)(BlockDriverState *bs,
>                                            QEMUIOVector *qiov,
>                                            int64_t pos);
> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
> index ff8163ba02..c0c70a8c67 100644
> --- a/include/block/dirty-bitmap.h
> +++ b/include/block/dirty-bitmap.h
> @@ -77,4 +77,7 @@ int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t start);
>  BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
>                                          BdrvDirtyBitmap *bitmap);
>  
> +BdrvDirtyBitmap *bdrv_load_dirty_bitmap(BlockDriverState *bs, const char *name,
> +                                        Error **errp);
> +
>  #endif
> -- 
> 2.11.0
> 

Otherwise looks good!

Fam
