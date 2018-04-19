Received: from eggs.gnu.org ([2001:4830:134:3::10]:44499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f9G1G-0002BA-VK
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 16:19:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f9G1F-0007MN-NK
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 16:19:02 -0400
References: <20180323164254.26487-1-pbonzini@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <36e1f0e4-4245-4cfe-9018-e37ebad3c8ec@redhat.com>
Date: Thu, 19 Apr 2018 16:18:39 -0400
MIME-Version: 1.0
In-Reply-To: <20180323164254.26487-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: remove
 bdrv_dirty_bitmap_make_anon
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org



On 03/23/2018 12:42 PM, Paolo Bonzini wrote:
> All this function is doing will be repeated by
> bdrv_do_release_matching_dirty_bitmap_locked, except
> resetting bm->persistent.  But even that does not matter
> because the bitmap will be freed.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/dirty-bitmap.c         | 9 ---------
>  blockdev.c                   | 1 -
>  include/block/dirty-bitmap.h | 1 -
>  3 files changed, 11 deletions(-)
> 
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index e27b3096dd..13bb5066a4 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -97,15 +97,6 @@ BdrvDirtyBitmap *bdrv_find_dirty_bitmap(BlockDriverState *bs, const char *name)
>      return NULL;
>  }
>  
> -/* Called with BQL taken.  */
> -void bdrv_dirty_bitmap_make_anon(BdrvDirtyBitmap *bitmap)
> -{
> -    assert(!bdrv_dirty_bitmap_frozen(bitmap));
> -    g_free(bitmap->name);
> -    bitmap->name = NULL;
> -    bitmap->persistent = false;
> -}
> -
>  /* Called with BQL taken.  */
>  BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
>                                            uint32_t granularity,
> diff --git a/blockdev.c b/blockdev.c
> index c31bf3d98d..6eb18c4ef1 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2881,7 +2881,6 @@ void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
>          }
>      }
>  
> -    bdrv_dirty_bitmap_make_anon(bitmap);
>      bdrv_release_dirty_bitmap(bs, bitmap);
>  }
>  
> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
> index 1ff8949b1b..5a51a78b63 100644
> --- a/include/block/dirty-bitmap.h
> +++ b/include/block/dirty-bitmap.h
> @@ -24,7 +24,6 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
>  void bdrv_dirty_bitmap_enable_successor(BdrvDirtyBitmap *bitmap);
>  BdrvDirtyBitmap *bdrv_find_dirty_bitmap(BlockDriverState *bs,
>                                          const char *name);
> -void bdrv_dirty_bitmap_make_anon(BdrvDirtyBitmap *bitmap);
>  void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap);
>  void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs);
>  void bdrv_release_persistent_dirty_bitmaps(BlockDriverState *bs);
> 

Just a weird artifact of the way in which we used to think this
subsystem would work; that maybe we'd want to return named bitmaps to
being anonymous.

Thanks, applied to my bitmaps tree:

https://github.com/jnsnow/qemu/commits/bitmaps
https://github.com/jnsnow/qemu.git

--js
