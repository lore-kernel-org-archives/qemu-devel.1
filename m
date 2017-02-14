Received: from eggs.gnu.org ([2001:4830:134:3::10]:52064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cdml0-00070D-Gq
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 18:43:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cdmkz-0002t7-C2
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 18:43:38 -0500
References: <1487091579-67092-1-git-send-email-vsementsov@virtuozzo.com>
	<1487091579-67092-23-git-send-email-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <8f2dadf9-e2ff-b975-8460-daa8efea51fb@redhat.com>
Date: Tue, 14 Feb 2017 18:43:30 -0500
MIME-Version: 1.0
In-Reply-To: <1487091579-67092-23-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 22/25] block/dirty-bitmap: add
 bdrv_remove_persistent_dirty_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org



On 02/14/2017 11:59 AM, Vladimir Sementsov-Ogievskiy wrote:
> Interface for removing persistent bitmap from its storage.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/dirty-bitmap.c         | 18 ++++++++++++++++++
>  include/block/block_int.h    |  3 +++
>  include/block/dirty-bitmap.h |  3 +++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index b684d8b..05e0aae 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -327,12 +327,30 @@ void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap)
>  /**
>   * Release all named dirty bitmaps attached to a BDS (for use in bdrv_close()).
>   * There must not be any frozen bitmaps attached.
> + * This function does not remove persistent bitmaps from the storage.
>   */
>  void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs)
>  {
>      bdrv_do_release_matching_dirty_bitmap(bs, NULL, true);
>  }
>  
> +/**
> + * Remove persistent dirty bitmap from the storage if it exists.
> + * Absence of bitmap is not an error, because we have the following scenario:
> + * BdrvDirtyBitmap can have .persistent = true but not yet saved and have no
> + * stored version. For such bitmap bdrv_remove_persistent_dirty_bitmap() should
> + * not fail.
> + * This function doesn't release corresponding BdrvDirtyBitmap.
> + */
> +void bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
> +                                         const char *name,
> +                                         Error **errp)
> +{
> +    if (bs->drv && bs->drv->bdrv_remove_persistent_dirty_bitmap) {
> +        bs->drv->bdrv_remove_persistent_dirty_bitmap(bs, name, errp);
> +    }
> +}
> +
>  void bdrv_disable_dirty_bitmap(BdrvDirtyBitmap *bitmap)
>  {
>      assert(!bdrv_dirty_bitmap_frozen(bitmap));
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index db68067..d138555 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -328,6 +328,9 @@ struct BlockDriver {
>                                              const char *name,
>                                              uint32_t granularity,
>                                              Error **errp);
> +    void (*bdrv_remove_persistent_dirty_bitmap)(BlockDriverState *bs,
> +                                                const char *name,
> +                                                Error **errp);
>  
>      QLIST_ENTRY(BlockDriver) list;
>  };
> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
> index b022b34..ce12610 100644
> --- a/include/block/dirty-bitmap.h
> +++ b/include/block/dirty-bitmap.h
> @@ -25,6 +25,9 @@ BdrvDirtyBitmap *bdrv_find_dirty_bitmap(BlockDriverState *bs,
>  void bdrv_dirty_bitmap_make_anon(BdrvDirtyBitmap *bitmap);
>  void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap);
>  void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs);
> +void bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
> +                                         const char *name,
> +                                         Error **errp);
>  void bdrv_disable_dirty_bitmap(BdrvDirtyBitmap *bitmap);
>  void bdrv_enable_dirty_bitmap(BdrvDirtyBitmap *bitmap);
>  BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs);
> 

Reviewed-by: John Snow <jsnow@redhat.com>
