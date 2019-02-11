Received: from eggs.gnu.org ([209.51.188.92]:49548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gtIHq-0001y9-Sf
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 15:34:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gtIHg-0004bY-Ej
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 15:34:35 -0500
References: <20190206170205.13061-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <649b8765-bf1d-aeae-eef5-4c4a4ebc875a@redhat.com>
Date: Mon, 11 Feb 2019 15:25:39 -0500
MIME-Version: 1.0
In-Reply-To: <20190206170205.13061-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] blockdev: acquire aio_context for bitmap
 add/remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Cc: vsementsov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>



On 2/6/19 12:02 PM, John Snow wrote:
> When bitmaps are persistent, they may incur a disk read or write when bitmaps
> are added or removed. For configurations like virtio-dataplane, failing to
> acquire this lock will abort QEMU when disk IO occurs.
> 
> We used to acquire aio_context as part of the bitmap lookup, so re-introduce
> the lock for just the cases that have an IO penalty.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1672010
> Reported-By: Aihua Liang <aliang@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  blockdev.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/blockdev.c b/blockdev.c
> index fb18e9c975..ce458de037 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2820,6 +2820,7 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
>  {
>      BlockDriverState *bs;
>      BdrvDirtyBitmap *bitmap;
> +    AioContext *aio_context = NULL;
>  
>      if (!name || name[0] == '\0') {
>          error_setg(errp, "Bitmap name cannot be empty");
> @@ -2854,10 +2855,12 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
>          disabled = false;
>      }
>  
> -    if (persistent &&
> -        !bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp))
> -    {
> -        return;
> +    if (persistent) {
> +        aio_context = bdrv_get_aio_context(bs);
> +        aio_context_acquire(aio_context);
> +        if (!bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp)) {
> +            goto out;
> +        }
>      }
>  
>      bitmap = bdrv_create_dirty_bitmap(bs, granularity, name, errp);
> @@ -2870,6 +2873,10 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
>      }
>  
>      bdrv_dirty_bitmap_set_persistance(bitmap, persistent);
> + out:
> +    if (aio_context) {
> +        aio_context_release(aio_context);
> +    }
>  }
>  
>  void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
> @@ -2878,6 +2885,7 @@ void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
>      BlockDriverState *bs;
>      BdrvDirtyBitmap *bitmap;
>      Error *local_err = NULL;
> +    AioContext *aio_context = NULL;
>  
>      bitmap = block_dirty_bitmap_lookup(node, name, &bs, errp);
>      if (!bitmap || !bs) {
> @@ -2892,14 +2900,20 @@ void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
>      }
>  
>      if (bdrv_dirty_bitmap_get_persistance(bitmap)) {
> +        aio_context = bdrv_get_aio_context(bs);
> +        aio_context_acquire(aio_context);
>          bdrv_remove_persistent_dirty_bitmap(bs, name, &local_err);
>          if (local_err != NULL) {
>              error_propagate(errp, local_err);
> -            return;
> +            goto out;
>          }
>      }
>  
>      bdrv_release_dirty_bitmap(bs, bitmap);
> + out:
> +    if (aio_context) {
> +        aio_context_release(aio_context);
> +    }
>  }
>  
>  /**
> 

If this looks noncontroversial to everyone (Paolo said he agreed with
Kevin's advice on the general approach here) I'm keen to merge it this week.

May I take it through my tree, or should I be patient and wait for you,
Kevin?
