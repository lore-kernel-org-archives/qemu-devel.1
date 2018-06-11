Received: from eggs.gnu.org ([2001:4830:134:3::10]:36809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fSOPY-0000Tw-5J
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:07:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fSOPV-0005Hv-0Q
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:07:12 -0400
References: <1528461148-17925-1-git-send-email-ari@tuxera.com>
	<1528461148-17925-4-git-send-email-ari@tuxera.com>
From: Ari Sundholm <ari@tuxera.com>
Message-ID: <827eb538-c55d-dadd-3b2d-d418cbe90468@tuxera.com>
Date: Mon, 11 Jun 2018 18:06:54 +0300
MIME-Version: 1.0
In-Reply-To: <1528461148-17925-4-git-send-email-ari@tuxera.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 03/10] block: Add a mechanism for
 passing a block driver a block configuration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>Kevin Wolf <kwolf@redhat.com>Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>"open list:Block I/O path" <qemu-block@nongnu.org>

Ping regarding this patch and the ones following it in the series. I 
would very much appreciate any feedback on the new callback and related 
plumbing I'm proposing for passing things like the guest block device 
sector size to block drivers (such as the filter type one proposed 
earlier in this series). Alternative ideas are also welcome.

Thank you,
Ari Sundholm
ari@tuxera.com

On 06/08/2018 03:32 PM, Ari Sundholm wrote:
> A block driver may need to know about the block configuration, most
> critically the sector sizes, of a block backend for alignment purposes
> or for some other reason. It doesn't seem like qemu has an existing
> mechanism for a block backend to convey the required information to
> the relevant block driver when it is being realized.
> 
> The need for this mechanism rises from the fact that a drive may not
> have a backend at the time it is created, as devices are created after
> drives during qemu startup. Therefore, a driver requiring information
> about the block configuration can get this information when a backend
> is created for it at the earliest. The most natural place for this to
> take place seems to be in the realization functions of the various
> block device drivers, such as scsi-hd. The interface proposed here
> allows the block driver to receive information about the block
> configuration and the associated backend through a new callback.
> 
> Signed-off-by: Ari Sundholm <ari@tuxera.com>
> ---
>   block/io.c                | 22 ++++++++++++++++++++++
>   hw/block/block.c          | 12 +++++++++++-
>   include/block/block.h     | 10 ++++++++++
>   include/block/block_int.h |  9 +++++++++
>   include/hw/block/block.h  |  1 +
>   5 files changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/block/io.c b/block/io.c
> index b7beaee..3a06843 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2932,3 +2932,25 @@ int coroutine_fn bdrv_co_copy_range(BdrvChild *src, uint64_t src_offset,
>       bdrv_dec_in_flight(dst_bs);
>       return ret;
>   }
> +
> +void bdrv_apply_blkconf(BlockDriverState *bs, BlockConf *conf)
> +{
> +    BlockDriver *drv = bs->drv;
> +
> +    if (!drv) {
> +        return;
> +    }
> +
> +    if (drv->bdrv_apply_blkconf) {
> +        drv->bdrv_apply_blkconf(bs, conf);
> +        return;
> +    }
> +
> +    if (bs->file && bs->file->bs) {
> +        bdrv_apply_blkconf(bs->file->bs, conf);
> +    }
> +
> +    if (bs->drv->supports_backing && backing_bs(bs)) {
> +        bdrv_apply_blkconf(backing_bs(bs), conf);
> +    }
> +}
> diff --git a/hw/block/block.c b/hw/block/block.c
> index b91e2b6..8c87dbf 100644
> --- a/hw/block/block.c
> +++ b/hw/block/block.c
> @@ -38,7 +38,7 @@ void blkconf_blocksizes(BlockConf *conf)
>       /* fill in detected values if they are not defined via qemu command line */
>       if (!conf->physical_block_size) {
>           if (!backend_ret) {
> -           conf->physical_block_size = blocksizes.phys;
> +            conf->physical_block_size = blocksizes.phys;
>           } else {
>               conf->physical_block_size = BDRV_SECTOR_SIZE;
>           }
> @@ -52,6 +52,16 @@ void blkconf_blocksizes(BlockConf *conf)
>       }
>   }
>   
> +void blkconf_apply_to_blkdrv(BlockConf *conf)
> +{
> +    BlockBackend *blk = conf->blk;
> +    BlockDriverState *bs = blk_bs(blk);
> +
> +    if (bs) {
> +        bdrv_apply_blkconf(bs, conf);
> +    }
> +}
> +
>   bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
>                                      bool resizable, Error **errp)
>   {
> diff --git a/include/block/block.h b/include/block/block.h
> index 312ae01..5d0a8ba 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -10,6 +10,7 @@
>   #include "block/dirty-bitmap.h"
>   #include "block/blockjob.h"
>   #include "qemu/hbitmap.h"
> +#include "hw/block/block.h"
>   
>   /* block.c */
>   typedef struct BlockDriver BlockDriver;
> @@ -650,4 +651,13 @@ void bdrv_unregister_buf(BlockDriverState *bs, void *host);
>   int coroutine_fn bdrv_co_copy_range(BdrvChild *src, uint64_t src_offset,
>                                       BdrvChild *dst, uint64_t dst_offset,
>                                       uint64_t bytes, BdrvRequestFlags flags);
> +
> +/*
> + * bdrv_apply_blkconf:
> + *
> + * Recursively finds the highest-level block drivers among the files and
> + * backing files that accept a block configuration and applies the given block
> + * configuration to them.
> + */
> +void bdrv_apply_blkconf(BlockDriverState *bs, BlockConf *conf);
>   #endif
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 888b7f7..cb82745 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -464,6 +464,15 @@ struct BlockDriver {
>       void (*bdrv_abort_perm_update)(BlockDriverState *bs);
>   
>       /**
> +     * Called to inform the driver of the block configuration of the virtual
> +     * block device.
> +     *
> +     * This function is called by a block device realization function if the
> +     * device wants to inform the block driver of its block configuration.
> +     */
> +    void (*bdrv_apply_blkconf)(BlockDriverState *bs, BlockConf *conf);
> +
> +    /**
>        * Returns in @nperm and @nshared the permissions that the driver for @bs
>        * needs on its child @c, based on the cumulative permissions requested by
>        * the parents in @parent_perm and @parent_shared.
> diff --git a/include/hw/block/block.h b/include/hw/block/block.h
> index d4f4dff..2861995 100644
> --- a/include/hw/block/block.h
> +++ b/include/hw/block/block.h
> @@ -77,6 +77,7 @@ bool blkconf_geometry(BlockConf *conf, int *trans,
>                         unsigned cyls_max, unsigned heads_max, unsigned secs_max,
>                         Error **errp);
>   void blkconf_blocksizes(BlockConf *conf);
> +void blkconf_apply_to_blkdrv(BlockConf *conf);
>   bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
>                                      bool resizable, Error **errp);
>   
> 
