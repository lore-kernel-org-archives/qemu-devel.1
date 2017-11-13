Received: from eggs.gnu.org ([2001:4830:134:3::10]:49761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eEN2n-0000q6-H8
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 17:17:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eEN2m-0005hF-KG
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 17:17:29 -0500
References: <20171030163309.75770-1-vsementsov@virtuozzo.com>
	<20171030163309.75770-4-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <9cabd666-c925-055c-fdaf-5102e8540503@redhat.com>
Date: Mon, 13 Nov 2017 17:17:13 -0500
MIME-Version: 1.0
In-Reply-To: <20171030163309.75770-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 03/14] block/dirty-bitmap: add
 bdrv_dirty_bitmap_release_successor
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
> To just release successor and unfreeze bitmap without any additional
> work.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>  include/block/dirty-bitmap.h |  2 ++
>  block/dirty-bitmap.c         | 14 ++++++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
> index 93d4336505..a9e2a92e4f 100644
> --- a/include/block/dirty-bitmap.h
> +++ b/include/block/dirty-bitmap.h
> @@ -20,6 +20,8 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
>  BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
>                                             BdrvDirtyBitmap *bitmap,
>                                             Error **errp);
> +void bdrv_dirty_bitmap_release_successor(BlockDriverState *bs,
> +                                         BdrvDirtyBitmap *bitmap);
>  void bdrv_dirty_bitmap_enable_successor(BdrvDirtyBitmap *bitmap);
>  BdrvDirtyBitmap *bdrv_find_dirty_bitmap(BlockDriverState *bs,
>                                          const char *name);
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index 981f99d362..7578863aa1 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -431,6 +431,20 @@ void bdrv_enable_dirty_bitmap(BdrvDirtyBitmap *bitmap)
>      bitmap->disabled = false;
>  }
>  
> +/* Called with BQL taken. */
> +void bdrv_dirty_bitmap_release_successor(BlockDriverState *bs,
> +                                         BdrvDirtyBitmap *parent)
> +{
> +    qemu_mutex_lock(parent->mutex);
> +
> +    if (parent->successor) {
> +        bdrv_release_dirty_bitmap_locked(bs, parent->successor);
> +        parent->successor = NULL;
> +    }
> +
> +    qemu_mutex_unlock(parent->mutex);
> +}
> +
>  BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs)
>  {
>      BdrvDirtyBitmap *bm;
> 

Not sure what this is useful for just yet, but it looks okay, tentatively..

Reviewed-by: John Snow <jsnow@redhat.com>
