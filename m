Received: from eggs.gnu.org ([2001:4830:134:3::10]:45711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cEl3z-0008Cg-3z
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 17:51:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cEl3y-0001VR-5X
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 17:51:47 -0500
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
	<1479835586-74394-9-git-send-email-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <080c81f9-6360-8b0f-2f77-14f10f7ac244@redhat.com>
Date: Wed, 7 Dec 2016 17:51:38 -0500
MIME-Version: 1.0
In-Reply-To: <1479835586-74394-9-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/21] block: introduce auto-loading bitmaps
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



On 11/22/2016 12:26 PM, Vladimir Sementsov-Ogievskiy wrote:
> Auto loading bitmaps are bitmaps store in the disk image, which should
> be loaded when the image is opened and become BdrvDirtyBitmaps for the
> corresponding drive.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block.c                   | 14 ++++++++++++++
>  include/block/block.h     |  2 ++
>  include/block/block_int.h |  3 +++
>  3 files changed, 19 insertions(+)
> 
> diff --git a/block.c b/block.c
> index 39ddea3..450379c 100644
> --- a/block.c
> +++ b/block.c
> @@ -1137,6 +1137,13 @@ static int bdrv_open_common(BlockDriverState *bs, BdrvChild *file,
>          goto free_and_fail;
>      }
>  
> +    bdrv_load_autoloading_dirty_bitmaps(bs, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        ret = -EINVAL;
> +        goto free_and_fail;
> +    }
> +
>      assert(bdrv_opt_mem_align(bs) != 0);
>      assert(bdrv_min_mem_align(bs) != 0);
>      assert(is_power_of_2(bs->bl.request_alignment));
> @@ -4093,3 +4100,10 @@ void bdrv_del_child(BlockDriverState *parent_bs, BdrvChild *child, Error **errp)
>  
>      parent_bs->drv->bdrv_del_child(parent_bs, child, errp);
>  }
> +
> +void bdrv_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp)
> +{
> +    if (bs->drv && bs->drv->bdrv_load_autoloading_dirty_bitmaps) {
> +        bs->drv->bdrv_load_autoloading_dirty_bitmaps(bs, errp);
> +    }
> +}
> diff --git a/include/block/block.h b/include/block/block.h
> index 49bb0b2..f701da2 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -552,4 +552,6 @@ void bdrv_add_child(BlockDriverState *parent, BlockDriverState *child,
>                      Error **errp);
>  void bdrv_del_child(BlockDriverState *parent, BdrvChild *child, Error **errp);
>  
> +void bdrv_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp);
> +
>  #endif
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 83a423c..ca955f0 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -320,6 +320,9 @@ struct BlockDriver {
>      void (*bdrv_del_child)(BlockDriverState *parent, BdrvChild *child,
>                             Error **errp);
>  
> +    void (*bdrv_load_autoloading_dirty_bitmaps)(BlockDriverState *bs,
> +                                                Error **errp);
> +
>      QLIST_ENTRY(BlockDriver) list;
>  };
>  
> 

If you address Max's comments:

Reviewed-by: John Snow <jsnow@redhat.com>
