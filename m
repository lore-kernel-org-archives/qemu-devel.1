Received: from eggs.gnu.org ([2001:4830:134:3::10]:35747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ccKUy-0000Bg-I9
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 18:21:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ccKUw-0003oo-Oh
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 18:21:04 -0500
References: <20170203094018.15493-1-vsementsov@virtuozzo.com>
	<20170203094018.15493-12-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <72ced0d7-1ec1-c1e2-362f-f010d6d942e7@redhat.com>
Date: Fri, 10 Feb 2017 18:20:55 -0500
MIME-Version: 1.0
In-Reply-To: <20170203094018.15493-12-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/24] block: introduce persistent dirty
 bitmaps
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



On 02/03/2017 04:40 AM, Vladimir Sementsov-Ogievskiy wrote:
> New field BdrvDirtyBitmap.persistent means, that bitmap should be saved
> on bdrv_close, using format driver. Format driver should maintain bitmap
> storing.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  block.c                      | 32 ++++++++++++++++++++++++++++++++
>  block/dirty-bitmap.c         | 26 ++++++++++++++++++++++++++
>  block/qcow2-bitmap.c         |  1 +
>  include/block/block.h        |  1 +
>  include/block/block_int.h    |  2 ++
>  include/block/dirty-bitmap.h |  6 ++++++
>  6 files changed, 68 insertions(+)
> 
> diff --git a/block.c b/block.c
> index 56f030c562..970e4ca50e 100644
> --- a/block.c
> +++ b/block.c
> @@ -2321,6 +2321,7 @@ void bdrv_reopen_abort(BDRVReopenState *reopen_state)
>  static void bdrv_close(BlockDriverState *bs)
>  {
>      BdrvAioNotifier *ban, *ban_next;
> +    Error *local_err = NULL;
>  
>      assert(!bs->job);
>      assert(!bs->refcnt);
> @@ -2329,6 +2330,12 @@ static void bdrv_close(BlockDriverState *bs)
>      bdrv_flush(bs);
>      bdrv_drain(bs); /* in case flush left pending I/O */
>  
> +    bdrv_store_persistent_dirty_bitmaps(bs, &local_err);
> +    if (local_err != NULL) {
> +        error_report_err(local_err);
> +        error_report("Persistent bitmaps are lost for node '%s'",
> +                     bdrv_get_device_or_node_name(bs));
> +    }

Ouch! I guess there's not much else we can do here, eh?

>      bdrv_release_named_dirty_bitmaps(bs);
>      assert(QLIST_EMPTY(&bs->dirty_bitmaps));
>  
> @@ -4107,3 +4114,28 @@ void bdrv_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>          bs->drv->bdrv_load_autoloading_dirty_bitmaps(bs, errp);
>      }
>  }
> +
> +void bdrv_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
> +{
> +    BlockDriver *drv = bs->drv;
> +
> +    if (!bdrv_has_persistent_bitmaps(bs)) {
> +        return;
> +    }
> +
> +    if (!drv) {
> +        error_setg_errno(errp, ENOMEDIUM,
> +                         "Can't store persistent bitmaps to %s",
> +                         bdrv_get_device_or_node_name(bs));
> +        return;
> +    }
> +
> +    if (!drv->bdrv_store_persistent_dirty_bitmaps) {
> +        error_setg_errno(errp, ENOTSUP,
> +                         "Can't store persistent bitmaps to %s",
> +                         bdrv_get_device_or_node_name(bs));
> +        return;
> +    }
> +

I suppose this is for the case for where we have added a persistent
bitmap during runtime, but the driver does not support it?

I'd rather fail this type of thing earlier if possible, but I'm not that
far in your series yet.

> +    drv->bdrv_store_persistent_dirty_bitmaps(bs, errp);
> +}
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index 2d27494dc7..4d026df1bd 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -44,6 +44,7 @@ struct BdrvDirtyBitmap {
>      int64_t size;               /* Size of the bitmap (Number of sectors) */
>      bool disabled;              /* Bitmap is read-only */
>      int active_iterators;       /* How many iterators are active */
> +    bool persistent;            /* bitmap must be saved to owner disk image */
>      bool autoload;              /* For persistent bitmaps: bitmap must be
>                                     autoloaded on image opening */
>      QLIST_ENTRY(BdrvDirtyBitmap) list;
> @@ -73,6 +74,7 @@ void bdrv_dirty_bitmap_make_anon(BdrvDirtyBitmap *bitmap)
>      g_free(bitmap->name);
>      bitmap->name = NULL;
>  
> +    bitmap->persistent = false;
>      bitmap->autoload = false;
>  }
>  
> @@ -242,6 +244,8 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
>      bitmap->name = NULL;
>      successor->name = name;
>      bitmap->successor = NULL;
> +    successor->persistent = bitmap->persistent;
> +    bitmap->persistent = false;
>      successor->autoload = bitmap->autoload;
>      bitmap->autoload = false;
>      bdrv_release_dirty_bitmap(bs, bitmap);
> @@ -556,3 +560,25 @@ bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap)
>  {
>      return bitmap->autoload;
>  }
> +
> +void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap, bool persistent)
> +{
> +    bitmap->persistent = persistent;
> +}
> +
> +bool bdrv_dirty_bitmap_get_persistance(BdrvDirtyBitmap *bitmap)
> +{
> +    return bitmap->persistent;
> +}
> +
> +bool bdrv_has_persistent_bitmaps(BlockDriverState *bs)
> +{
> +    BdrvDirtyBitmap *bm;
> +    QLIST_FOREACH(bm, &bs->dirty_bitmaps, list) {
> +        if (bm->persistent) {
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}

Probably not worth optimizing.

> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index bcbb0491ee..9af658a0f4 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -707,6 +707,7 @@ void qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>                  goto fail;
>              }
>  
> +            bdrv_dirty_bitmap_set_persistance(bitmap, true);
>              bdrv_dirty_bitmap_set_autoload(bitmap, true);
>              bm->flags |= BME_FLAG_IN_USE;
>              created_dirty_bitmaps =
> diff --git a/include/block/block.h b/include/block/block.h
> index 154ac7f955..0a20d68f0f 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -552,5 +552,6 @@ void bdrv_add_child(BlockDriverState *parent, BlockDriverState *child,
>  void bdrv_del_child(BlockDriverState *parent, BdrvChild *child, Error **errp);
>  
>  void bdrv_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp);
> +void bdrv_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
>  
>  #endif
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 6b2b50c6a2..c3505da56e 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -322,6 +322,8 @@ struct BlockDriver {
>  
>      void (*bdrv_load_autoloading_dirty_bitmaps)(BlockDriverState *bs,
>                                                  Error **errp);
> +    void (*bdrv_store_persistent_dirty_bitmaps)(BlockDriverState *bs,
> +                                                Error **errp);
>  
>      QLIST_ENTRY(BlockDriver) list;
>  };
> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
> index 45a389a20a..8dbd16b040 100644
> --- a/include/block/dirty-bitmap.h
> +++ b/include/block/dirty-bitmap.h
> @@ -77,4 +77,10 @@ void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap);
>  
>  void bdrv_dirty_bitmap_set_autoload(BdrvDirtyBitmap *bitmap, bool autoload);
>  bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap);
> +void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap,
> +                                                bool persistent);
> +bool bdrv_dirty_bitmap_get_persistance(BdrvDirtyBitmap *bitmap);
> +
> +bool bdrv_has_persistent_bitmaps(BlockDriverState *bs);
> +
>  #endif
> 

Reviewed-by: John Snow <jsnow@redhat.com>
