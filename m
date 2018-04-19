Received: from eggs.gnu.org ([2001:4830:134:3::10]:40883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f9IL1-0008Dj-1l
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:47:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f9IKz-0006Js-Rs
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:47:35 -0400
References: <20180416114414.18406-1-vsementsov@virtuozzo.com>
	<20180416114414.18406-6-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <3cd7df2d-f741-4283-2612-87d98151c6a4@redhat.com>
Date: Thu, 19 Apr 2018 18:47:18 -0400
MIME-Version: 1.0
In-Reply-To: <20180416114414.18406-6-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/7] blockdev: refactor
 block-dirty-bitmap-clear transaction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, den@openvz.org, Stefan Hajnoczi <stefanha@redhat.com>



On 04/16/2018 07:44 AM, Vladimir Sementsov-Ogievskiy wrote:
> bdrv_clear_dirty_bitmap do not fail, so we can call it in transaction
> commit, avoiding any rollback.
> 
> After this, bdrv_undo_clear_dirty_bitmap() becomes unused, so, drop it.
> 

I'm trying to remember why we ever bothered doing it the other way. Is
it because of timings with respect to other operations and we wanted the
"clear" to take effect sooner rather than later to co-operate with other
commands?

(You and Nikolay hinted about similar problems in the Libvirt PULL api
thread, too. It continues to be an issue.)

Hopping in my time machine:

https://lists.gnu.org/archive/html/qemu-devel/2015-05/msg01229.html

(Oh, I wrote it...)

Looks like it was a conscious decision to avoid ordering conflicts with
other block jobs.

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/block_int.h |  1 -
>  block/dirty-bitmap.c      |  9 ---------
>  blockdev.c                | 16 +---------------
>  3 files changed, 1 insertion(+), 25 deletions(-)
> 
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 189666efa5..22059c8119 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -1087,7 +1087,6 @@ bool blk_dev_is_medium_locked(BlockBackend *blk);
>  void bdrv_set_dirty(BlockDriverState *bs, int64_t offset, int64_t bytes);
>  
>  void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out);
> -void bdrv_undo_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap *in);
>  
>  void bdrv_inc_in_flight(BlockDriverState *bs);
>  void bdrv_dec_in_flight(BlockDriverState *bs);
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index 1812e17549..3c69a8eed9 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -607,15 +607,6 @@ void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out)
>      bdrv_dirty_bitmap_unlock(bitmap);
>  }
>  
> -void bdrv_undo_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap *in)
> -{
> -    HBitmap *tmp = bitmap->bitmap;
> -    assert(bdrv_dirty_bitmap_enabled(bitmap));
> -    assert(!bdrv_dirty_bitmap_readonly(bitmap));
> -    bitmap->bitmap = in;
> -    hbitmap_free(tmp);
> -}
> -
>  uint64_t bdrv_dirty_bitmap_serialization_size(const BdrvDirtyBitmap *bitmap,
>                                                uint64_t offset, uint64_t bytes)
>  {
> diff --git a/blockdev.c b/blockdev.c
> index c31bf3d98d..88eae60c1c 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2050,7 +2050,6 @@ typedef struct BlockDirtyBitmapState {
>      BlkActionState common;
>      BdrvDirtyBitmap *bitmap;
>      BlockDriverState *bs;
> -    HBitmap *backup;
>      bool prepared;
>  } BlockDirtyBitmapState;
>  
> @@ -2129,18 +2128,6 @@ static void block_dirty_bitmap_clear_prepare(BlkActionState *common,
>          error_setg(errp, "Cannot clear a readonly bitmap");
>          return;
>      }
> -
> -    bdrv_clear_dirty_bitmap(state->bitmap, &state->backup);
> -}
> -
> -static void block_dirty_bitmap_clear_abort(BlkActionState *common)
> -{
> -    BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
> -                                             common, common);
> -
> -    if (state->backup) {
> -        bdrv_undo_clear_dirty_bitmap(state->bitmap, state->backup);
> -    }
>  }
>  
>  static void block_dirty_bitmap_clear_commit(BlkActionState *common)
> @@ -2148,7 +2135,7 @@ static void block_dirty_bitmap_clear_commit(BlkActionState *common)
>      BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
>                                               common, common);
>  
> -    hbitmap_free(state->backup);
> +    bdrv_clear_dirty_bitmap(state->bitmap, NULL);
>  }
>  
>  static void abort_prepare(BlkActionState *common, Error **errp)
> @@ -2210,7 +2197,6 @@ static const BlkActionOps actions[] = {
>          .instance_size = sizeof(BlockDirtyBitmapState),
>          .prepare = block_dirty_bitmap_clear_prepare,
>          .commit = block_dirty_bitmap_clear_commit,
> -        .abort = block_dirty_bitmap_clear_abort,
>      }
>  };
>  
> 
