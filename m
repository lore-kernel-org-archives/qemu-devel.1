Received: from eggs.gnu.org ([2001:4830:134:3::10]:49039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eEODG-00075L-BU
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 18:32:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eEODF-0006QI-9X
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 18:32:22 -0500
References: <20171030163309.75770-1-vsementsov@virtuozzo.com>
	<20171030163309.75770-5-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <a593e984-5d1e-a95c-9b80-dbe82227b8f9@redhat.com>
Date: Mon, 13 Nov 2017 18:32:05 -0500
MIME-Version: 1.0
In-Reply-To: <20171030163309.75770-5-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 04/14] block/dirty-bitmap: add
 bdrv_dirty_bitmap_set_frozen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, famz@redhat.com
Cc: kwolf@redhat.com, peter.maydell@linaro.org, lirans@il.ibm.com, quintela@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, amit.shah@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com



On 10/30/2017 12:32 PM, Vladimir Sementsov-Ogievskiy wrote:
> Make it possible to set bitmap 'frozen' without a successor.
> This is needed to protect the bitmap during outgoing bitmap postcopy
> migration.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/dirty-bitmap.h |  1 +
>  block/dirty-bitmap.c         | 22 ++++++++++++++++++++--
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
> index a9e2a92e4f..ae6d697850 100644
> --- a/include/block/dirty-bitmap.h
> +++ b/include/block/dirty-bitmap.h
> @@ -39,6 +39,7 @@ uint32_t bdrv_get_default_bitmap_granularity(BlockDriverState *bs);
>  uint32_t bdrv_dirty_bitmap_granularity(const BdrvDirtyBitmap *bitmap);
>  bool bdrv_dirty_bitmap_enabled(BdrvDirtyBitmap *bitmap);
>  bool bdrv_dirty_bitmap_frozen(BdrvDirtyBitmap *bitmap);
> +void bdrv_dirty_bitmap_set_frozen(BdrvDirtyBitmap *bitmap, bool frozen);
>  const char *bdrv_dirty_bitmap_name(const BdrvDirtyBitmap *bitmap);
>  int64_t bdrv_dirty_bitmap_size(const BdrvDirtyBitmap *bitmap);
>  DirtyBitmapStatus bdrv_dirty_bitmap_status(BdrvDirtyBitmap *bitmap);
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index 7578863aa1..67fc6bd6e0 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -40,6 +40,8 @@ struct BdrvDirtyBitmap {
>      QemuMutex *mutex;
>      HBitmap *bitmap;            /* Dirty bitmap implementation */
>      HBitmap *meta;              /* Meta dirty bitmap */
> +    bool frozen;                /* Bitmap is frozen, it can't be modified
> +                                   through QMP */

I hesitate, because this now means that we have two independent bits of
state we need to update and maintain consistency with.

Before:

Frozen: "Bitmap has a successor and is no longer itself recording
writes, though we are guaranteed to have a successor doing so on our
behalf."

After:

Frozen: "Bitmap may or may not have a successor, but it is disabled with
an even more limited subset of tasks than a traditionally disabled bitmap."

This changes the meaning of "frozen" a little, and I am not sure that is
a problem as such, but it does make the interface seem a little
"fuzzier" than it did prior.

>      BdrvDirtyBitmap *successor; /* Anonymous child; implies frozen status */
>      char *name;                 /* Optional non-empty unique ID */
>      int64_t size;               /* Size of the bitmap, in bytes */
> @@ -183,13 +185,22 @@ const char *bdrv_dirty_bitmap_name(const BdrvDirtyBitmap *bitmap)
>  /* Called with BQL taken.  */
>  bool bdrv_dirty_bitmap_frozen(BdrvDirtyBitmap *bitmap)
>  {
> -    return bitmap->successor;
> +    return bitmap->frozen;
> +}

Are there any cases where we will be unfrozen, but actually have a
successor now? If so, under what circumstances does that happen?

> +
> +/* Called with BQL taken.  */
> +void bdrv_dirty_bitmap_set_frozen(BdrvDirtyBitmap *bitmap, bool frozen)
> +{
> +    qemu_mutex_lock(bitmap->mutex);
> +    assert(bitmap->successor == NULL);
> +    bitmap->frozen = frozen;
> +    qemu_mutex_unlock(bitmap->mutex);
>  }
>  

OK, so we can only "set frozen" (or unset) if we don't have a successor.

>  /* Called with BQL taken.  */
>  bool bdrv_dirty_bitmap_enabled(BdrvDirtyBitmap *bitmap)
>  {
> -    return !(bitmap->disabled || bitmap->successor);
> +    return !(bitmap->disabled || (bitmap->successor != NULL));
>  }
>  

I guess this just makes 'successor' more obviously non-boolean, which is
fine.

>  /* Called with BQL taken.  */
> @@ -234,6 +245,7 @@ int bdrv_dirty_bitmap_create_successor(BlockDriverState *bs,
>  
>      /* Install the successor and freeze the parent */
>      bitmap->successor = child;
> +    bitmap->frozen = true;
>      return 0;
>  }
>  
> @@ -266,6 +278,8 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
>      name = bitmap->name;
>      bitmap->name = NULL;
>      successor->name = name;
> +    assert(bitmap->frozen);
> +    bitmap->frozen = false;
>      bitmap->successor = NULL;
>      successor->persistent = bitmap->persistent;
>      bitmap->persistent = false;
> @@ -298,6 +312,8 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
>          return NULL;
>      }
>      bdrv_release_dirty_bitmap(bs, successor);
> +    assert(parent->frozen);
> +    parent->frozen = false;
>      parent->successor = NULL;
>  
>      return parent;
> @@ -439,6 +455,8 @@ void bdrv_dirty_bitmap_release_successor(BlockDriverState *bs,
>  
>      if (parent->successor) {
>          bdrv_release_dirty_bitmap_locked(bs, parent->successor);
> +        assert(parent->frozen);
> +        parent->frozen = false;
>          parent->successor = NULL;
>      }
>  
> 

Tentatively:

Reviewed-by: John Snow <jsnow@redhat.com>

Fam, any thoughts?

--John
