Received: from eggs.gnu.org ([208.118.235.92]:39563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fzTNS-0007uY-61
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 17:05:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fzTKA-0006wE-VY
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 17:02:23 -0400
References: <20180706113630.25222-1-vsementsov@virtuozzo.com>
	<20180706113630.25222-2-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <08bb4c31-672a-c50e-9a48-ea415d8dede4@redhat.com>
Date: Mon, 10 Sep 2018 17:02:14 -0400
MIME-Version: 1.0
In-Reply-To: <20180706113630.25222-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/4] drity-bitmap: switch assert-fails
 to errors in bdrv_merge_dirty_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, den@openvz.org

s/drity-bitmap/dirty-bitmap/g

On 07/06/2018 07:36 AM, Vladimir Sementsov-Ogievskiy wrote:
> Move checks from qmp_x_block_dirty_bitmap_merge() to
> bdrv_merge_dirty_bitmap(), to share them with dirty bitmap merge
> transaction action in future commit.
> 
> Note: for now, only qmp_x_block_dirty_bitmap_merge() calls
> bdrv_merge_dirty_bitmap().
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/dirty-bitmap.c | 15 +++++++++++++--
>  blockdev.c           | 10 ----------
>  2 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index c9b8a6fd52..6c8761e027 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -798,12 +798,23 @@ void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
>  
>      qemu_mutex_lock(dest->mutex);
>  
> -    assert(bdrv_dirty_bitmap_enabled(dest));
> -    assert(!bdrv_dirty_bitmap_readonly(dest));
> +    if (bdrv_dirty_bitmap_frozen(dest)) {
> +        error_setg(errp, "Bitmap '%s' is frozen and cannot be modified",
> +                   dest->name);
> +        goto out;
> +    }
> +
> +    if (bdrv_dirty_bitmap_readonly(dest)) {
> +        error_setg(errp, "Bitmap '%s' is readonly and cannot be modified",
> +                   dest->name);
> +        goto out;
> +    }
>  
>      if (!hbitmap_merge(dest->bitmap, src->bitmap)) {
>          error_setg(errp, "Bitmaps are incompatible and can't be merged");
> +        goto out;

This is unusual right before the out: segment, but harmless.

>      }
>  
> +out:
>      qemu_mutex_unlock(dest->mutex);
>  }
> diff --git a/blockdev.c b/blockdev.c
> index 72f5347df5..902338e815 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2955,16 +2955,6 @@ void qmp_x_block_dirty_bitmap_merge(const char *node, const char *dst_name,
>          return;
>      }
>  
> -    if (bdrv_dirty_bitmap_frozen(dst)) {
> -        error_setg(errp, "Bitmap '%s' is frozen and cannot be modified",
> -                   dst_name);
> -        return;
> -    } else if (bdrv_dirty_bitmap_readonly(dst)) {
> -        error_setg(errp, "Bitmap '%s' is readonly and cannot be modified",
> -                   dst_name);
> -        return;
> -    }
> -
>      src = bdrv_find_dirty_bitmap(bs, src_name);
>      if (!src) {
>          error_setg(errp, "Dirty bitmap '%s' not found", src_name);
> 

When fixing the commit title, we can add:

Reviewed-by: John Snow <jsnow@redhat.com>
