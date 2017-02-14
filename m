Received: from eggs.gnu.org ([2001:4830:134:3::10]:47496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cdkdp-0005ag-Kh
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 16:28:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cdkdo-0008Px-DJ
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 16:28:05 -0500
References: <1487091579-67092-1-git-send-email-vsementsov@virtuozzo.com>
	<1487091579-67092-15-git-send-email-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <da31221f-9a45-ab8c-c3d8-8ce220d8b364@redhat.com>
Date: Tue, 14 Feb 2017 16:27:58 -0500
MIME-Version: 1.0
In-Reply-To: <1487091579-67092-15-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/25] block: add
 bdrv_can_store_new_dirty_bitmap
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
> This will be needed to check some restrictions before making bitmap
> persistent in qmp-block-dirty-bitmap-add (this functionality will be
> added by future patch)
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  block.c                   | 22 ++++++++++++++++++++++
>  include/block/block.h     |  2 ++
>  include/block/block_int.h |  4 ++++
>  3 files changed, 28 insertions(+)
> 
> diff --git a/block.c b/block.c
> index 970e4ca..d5f8af8 100644
> --- a/block.c
> +++ b/block.c
> @@ -4139,3 +4139,25 @@ void bdrv_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>  
>      drv->bdrv_store_persistent_dirty_bitmaps(bs, errp);
>  }
> +
> +bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
> +                                     uint32_t granularity, Error **errp)
> +{
> +    BlockDriver *drv = bs->drv;
> +
> +    if (!drv) {
> +        error_setg_errno(errp, ENOMEDIUM,
> +                         "Can't store persistent bitmaps to %s",
> +                         bdrv_get_device_or_node_name(bs));
> +        return false;
> +    }
> +
> +    if (!drv->bdrv_can_store_new_dirty_bitmap) {
> +        error_setg_errno(errp, ENOTSUP,
> +                         "Can't store persistent bitmaps to %s",
> +                         bdrv_get_device_or_node_name(bs));
> +        return false;
> +    }
> +
> +    return drv->bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp);
> +}
> diff --git a/include/block/block.h b/include/block/block.h
> index 0a20d68..ebf99b3 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -553,5 +553,7 @@ void bdrv_del_child(BlockDriverState *parent, BdrvChild *child, Error **errp);
>  
>  void bdrv_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp);
>  void bdrv_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
> +bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
> +                                     uint32_t granularity, Error **errp);
>  
>  #endif
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index c3505da..db68067 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -324,6 +324,10 @@ struct BlockDriver {
>                                                  Error **errp);
>      void (*bdrv_store_persistent_dirty_bitmaps)(BlockDriverState *bs,
>                                                  Error **errp);
> +    bool (*bdrv_can_store_new_dirty_bitmap)(BlockDriverState *bs,
> +                                            const char *name,
> +                                            uint32_t granularity,
> +                                            Error **errp);
>  
>      QLIST_ENTRY(BlockDriver) list;
>  };
> 

Reviewed-by: John Snow <jsnow@redhat.com>
