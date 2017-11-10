Received: from eggs.gnu.org ([2001:4830:134:3::10]:47209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eCxTw-0005Sd-1M
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 19:47:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eCxTv-0001Ke-6N
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 19:47:40 -0500
References: <20171030163309.75770-1-vsementsov@virtuozzo.com>
	<20171030163309.75770-2-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <2ca07f02-1e53-9132-4395-6d7cafa06b41@redhat.com>
Date: Thu, 9 Nov 2017 19:47:22 -0500
MIME-Version: 1.0
In-Reply-To: <20171030163309.75770-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 01/14] block/dirty-bitmap: add
 bdrv_dirty_bitmap_enable_successor()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, famz@redhat.com, lirans@il.ibm.com, quintela@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, amit.shah@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com



On 10/30/2017 12:32 PM, Vladimir Sementsov-Ogievskiy wrote:
> Enabling bitmap successor is necessary to enable successors of bitmaps
> being migrated before target vm start.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/dirty-bitmap.h | 1 +
>  block/dirty-bitmap.c         | 8 ++++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
> index 3579a7597c..93d4336505 100644
> --- a/include/block/dirty-bitmap.h
> +++ b/include/block/dirty-bitmap.h
> @@ -20,6 +20,7 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
>  BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
>                                             BdrvDirtyBitmap *bitmap,
>                                             Error **errp);
> +void bdrv_dirty_bitmap_enable_successor(BdrvDirtyBitmap *bitmap);
>  BdrvDirtyBitmap *bdrv_find_dirty_bitmap(BlockDriverState *bs,
>                                          const char *name);
>  void bdrv_dirty_bitmap_make_anon(BdrvDirtyBitmap *bitmap);
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index bd04e991b1..81adbeb6d4 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -237,6 +237,14 @@ int bdrv_dirty_bitmap_create_successor(BlockDriverState *bs,
>      return 0;
>  }
>  
> +/* Called with BQL taken. */
> +void bdrv_dirty_bitmap_enable_successor(BdrvDirtyBitmap *bitmap)
> +{
> +    qemu_mutex_lock(bitmap->mutex);
> +    bdrv_enable_dirty_bitmap(bitmap->successor);
> +    qemu_mutex_unlock(bitmap->mutex);
> +}
> +
>  /**
>   * For a bitmap with a successor, yield our name to the successor,
>   * delete the old bitmap, and return a handle to the new bitmap.
> 

Mechanically correct; though I haven't looked forward to how it's used yet.

Reviewed-by: John Snow <jsnow@redhat.com>
