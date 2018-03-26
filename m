Received: from eggs.gnu.org ([2001:4830:134:3::10]:35949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f0PIW-0001xJ-Br
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 06:24:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f0PIV-0004rd-4K
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 06:24:16 -0400
References: <20180323164254.26487-2-pbonzini@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <39eabba4-ce6d-8b5b-f3a8-78dde910ec2e@virtuozzo.com>
Date: Mon, 26 Mar 2018 13:24:04 +0300
MIME-Version: 1.0
In-Reply-To: <20180323164254.26487-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] block: simplify code around releasing
 bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

23.03.2018 19:42, Paolo Bonzini wrote:
> QLIST_REMOVE does not require walking the list, and once the "bitmap"
> argument is removed from bdrv_do_release_matching_dirty_bitmap_locked
> the code simplifies a lot and it is worth inlining everything in the
> callers of bdrv_do_release_matching_dirty_bitmap.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   block/dirty-bitmap.c | 81 +++++++++++++++++++---------------------------------
>   1 file changed, 30 insertions(+), 51 deletions(-)
>
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index 13bb5066a4..c0fb49bf7b 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -250,48 +250,15 @@ void bdrv_dirty_bitmap_enable_successor(BdrvDirtyBitmap *bitmap)
>   }
>   
>   /* Called within bdrv_dirty_bitmap_lock..unlock */

Worth adding "Called with BQL taken" to the comment?

> -static void bdrv_do_release_matching_dirty_bitmap_locked(
> -    BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
> -    bool (*cond)(BdrvDirtyBitmap *bitmap))
> +static void bdrv_release_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap)
>   {
> -    BdrvDirtyBitmap *bm, *next;
> -
> -    QLIST_FOREACH_SAFE(bm, &bs->dirty_bitmaps, list, next) {
> -        if ((!bitmap || bm == bitmap) && (!cond || cond(bm))) {
> -            assert(!bm->active_iterators);
> -            assert(!bdrv_dirty_bitmap_frozen(bm));
> -            assert(!bm->meta);
> -            QLIST_REMOVE(bm, list);
> -            hbitmap_free(bm->bitmap);
> -            g_free(bm->name);
> -            g_free(bm);
> -
> -            if (bitmap) {
> -                return;
> -            }
> -        }
> -    }
> -
> -    if (bitmap) {
> -        abort();
> -    }
> -}
> -
> -/* Called with BQL taken.  */
> -static void bdrv_do_release_matching_dirty_bitmap(
> -    BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
> -    bool (*cond)(BdrvDirtyBitmap *bitmap))
> -{
> -    bdrv_dirty_bitmaps_lock(bs);
> -    bdrv_do_release_matching_dirty_bitmap_locked(bs, bitmap, cond);
> -    bdrv_dirty_bitmaps_unlock(bs);
> -}
> -
> -/* Called within bdrv_dirty_bitmap_lock..unlock */
> -static void bdrv_release_dirty_bitmap_locked(BlockDriverState *bs,
> -                                             BdrvDirtyBitmap *bitmap)
> -{
> -    bdrv_do_release_matching_dirty_bitmap_locked(bs, bitmap, NULL);
> +    assert(!bitmap->active_iterators);
> +    assert(!bdrv_dirty_bitmap_frozen(bitmap));
> +    assert(!bitmap->meta);
> +    QLIST_REMOVE(bitmap, list);
> +    hbitmap_free(bitmap->bitmap);
> +    g_free(bitmap->name);
> +    g_free(bitmap);
>   }
>   
>   /**
> @@ -344,7 +311,7 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
>           error_setg(errp, "Merging of parent and successor bitmap failed");
>           return NULL;
>       }
> -    bdrv_release_dirty_bitmap_locked(bs, successor);
> +    bdrv_release_dirty_bitmap_locked(successor);
>       parent->successor = NULL;
>   
>       return parent;
> @@ -382,15 +349,12 @@ void bdrv_dirty_bitmap_truncate(BlockDriverState *bs, int64_t bytes)
>       bdrv_dirty_bitmaps_unlock(bs);
>   }
>   
> -static bool bdrv_dirty_bitmap_has_name(BdrvDirtyBitmap *bitmap)
> -{
> -    return !!bdrv_dirty_bitmap_name(bitmap);
> -}
> -
>   /* Called with BQL taken.  */
>   void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap)
>   {
> -    bdrv_do_release_matching_dirty_bitmap(bs, bitmap, NULL);
> +    bdrv_dirty_bitmaps_lock(bs);
> +    bdrv_release_dirty_bitmap_locked(bitmap);
> +    bdrv_dirty_bitmaps_unlock(bs);
>   }
>   
>   /**
> @@ -401,7 +365,15 @@ void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap)
>    */
>   void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs)
>   {
> -    bdrv_do_release_matching_dirty_bitmap(bs, NULL, bdrv_dirty_bitmap_has_name);
> +    BdrvDirtyBitmap *bm, *next;
> +
> +    bdrv_dirty_bitmaps_lock(bs);
> +    QLIST_FOREACH_SAFE(bm, &bs->dirty_bitmaps, list, next) {
> +        if (bdrv_dirty_bitmap_name(bm)) {
> +            bdrv_release_dirty_bitmap_locked(bm);
> +        }
> +    }
> +    bdrv_dirty_bitmaps_unlock(bs);
>   }
>   
>   /**
> @@ -412,8 +384,15 @@ void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs)
>    */

worth adding "Called with BQL taken." to the comment? 
bdrv_release_named_dirty_bitmaps functions has it.

>   void bdrv_release_persistent_dirty_bitmaps(BlockDriverState *bs)
>   {
> -    bdrv_do_release_matching_dirty_bitmap(bs, NULL,
> -                                          bdrv_dirty_bitmap_get_persistance);
> +    BdrvDirtyBitmap *bm, *next;
> +
> +    bdrv_dirty_bitmaps_lock(bs);
> +    QLIST_FOREACH_SAFE(bm, &bs->dirty_bitmaps, list, next) {
> +        if (bdrv_dirty_bitmap_get_persistance(bm)) {
> +            bdrv_release_dirty_bitmap_locked(bm);
> +        }
> +    }
> +    bdrv_dirty_bitmaps_unlock(bs);
>   }
>   
>   /**

anyway,

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir
