Received: from eggs.gnu.org ([2001:4830:134:3::10]:52163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dhBoV-0001Hq-1N
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 05:37:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dhBoU-00081R-6u
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 05:37:35 -0400
References: <20170710163029.129912-1-vsementsov@virtuozzo.com>
	<20170710163029.129912-8-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <7ee5b6bb-7406-4539-652f-a57c6088f8ff@virtuozzo.com>
Date: Mon, 14 Aug 2017 12:37:15 +0300
MIME-Version: 1.0
In-Reply-To: <20170710163029.129912-8-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v7 07/16] block/dirty-bitmap: add
 bdrv_dirty_bitmap_release_successor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com

10.07.2017 19:30, Vladimir Sementsov-Ogievskiy wrote:
> To just release successor and unfreeze bitmap without any additional
> work.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   block/dirty-bitmap.c         | 13 +++++++++++++
>   include/block/dirty-bitmap.h |  2 ++
>   2 files changed, 15 insertions(+)
>
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index 7b598c36bf..b5678d2d25 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -303,6 +303,19 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
>       return parent;
>   }
>   
> +/* Called with BQL taken. */
> +void bdrv_dirty_bitmap_release_successor(BlockDriverState *bs,
> +                                         BdrvDirtyBitmap *parent)
> +{
> +    qemu_mutex_lock(parent->mutex);
> +
> +    if (parent->successor) {
> +        bdrv_release_dirty_bitmap(bs, parent->successor);

this will try to lock same mutex and deadlock.

> +        parent->successor = NULL;
> +    }
> +
> +    qemu_mutex_unlock(parent->mutex);
> +}
>   /**
>    * Truncates _all_ bitmaps attached to a BDS.
>    * Called with BQL taken.
> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
> index d00a7a4b7c..fa2f670050 100644
> --- a/include/block/dirty-bitmap.h
> +++ b/include/block/dirty-bitmap.h
> @@ -20,6 +20,8 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
>   BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
>                                              BdrvDirtyBitmap *bitmap,
>                                              Error **errp);
> +void bdrv_dirty_bitmap_release_successor(BlockDriverState *bs,
> +                                         BdrvDirtyBitmap *bitmap);
>   void bdrv_dirty_bitmap_enable_successor(BdrvDirtyBitmap *bitmap);
>   BdrvDirtyBitmap *bdrv_find_dirty_bitmap(BlockDriverState *bs,
>                                           const char *name);


-- 
Best regards,
Vladimir
