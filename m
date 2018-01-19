Received: from eggs.gnu.org ([2001:4830:134:3::10]:60188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecgLy-00088f-0R
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 18:45:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecgLw-0005JE-3o
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 18:45:45 -0500
References: <20180116125427.18540-1-vsementsov@virtuozzo.com>
	<20180116125427.18540-3-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <a76da111-c253-c9b9-91f8-aa5b6f590c57@redhat.com>
Date: Fri, 19 Jan 2018 18:45:31 -0500
MIME-Version: 1.0
In-Reply-To: <20180116125427.18540-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/6] block/dirty-bitmap: add lock to
 bdrv_enable/disable_dirty_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mnestratov@virtuozzo.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>



On 01/16/2018 07:54 AM, Vladimir Sementsov-Ogievskiy wrote:
> Add locks and remove comments about BQL accordingly to
> dirty_bitmap_mutex definition in block_int.h.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/dirty-bitmap.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index 3777be1985..d0a10c4f5d 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -389,18 +389,20 @@ void bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>      }
>  }
>  
> -/* Called with BQL taken.  */
>  void bdrv_disable_dirty_bitmap(BdrvDirtyBitmap *bitmap)
>  {
> +    bdrv_dirty_bitmap_lock(bitmap);
>      assert(!bdrv_dirty_bitmap_frozen(bitmap));
>      bitmap->disabled = true;
> +    bdrv_dirty_bitmap_unlock(bitmap);
>  }
>  
> -/* Called with BQL taken.  */
>  void bdrv_enable_dirty_bitmap(BdrvDirtyBitmap *bitmap)
>  {
> +    bdrv_dirty_bitmap_lock(bitmap);
>      assert(!bdrv_dirty_bitmap_frozen(bitmap));
>      bitmap->disabled = false;
> +    bdrv_dirty_bitmap_unlock(bitmap);
>  }
>  
>  BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs)
> 

Reviewed-by: John Snow <jsnow@redhat.com>
