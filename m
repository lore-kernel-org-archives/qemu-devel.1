Received: from eggs.gnu.org ([2001:4830:134:3::10]:51811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYqJv-0000uG-0n
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:08:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYqJt-0003az-Pw
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:08:02 -0400
Date: Fri, 29 Jun 2018 12:07:52 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180629100752.GE15588@localhost.localdomain>
References: <1529415820-7750-1-git-send-email-ari@tuxera.com>
	<1529415820-7750-3-git-send-email-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529415820-7750-3-git-send-email-ari@tuxera.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/8] block: Add a mechanism for passing
 a block driver a block configuration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ari Sundholm <ari@tuxera.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, "open list:Block I/O path" <qemu-block@nongnu.org>

Am 19.06.2018 um 15:43 hat Ari Sundholm geschrieben:
> A block driver may need to know about the block configuration, most
> critically the sector sizes, of a block backend for alignment purposes
> or for some other reason.

It makes sense to me that you need to know alignment constraints of the
thing you are calling (i.e. your child nodes), but I don't really see
why you would need to know anything about the parent nodes. I'm doubtful
that this is a good thing to add.

I hope that the rest of the series will tell me why you are wanting this
information, but if we keep it, it needs a better explanation in the
commit message.

> It doesn't seem like qemu has an existing
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

> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 327e478..74c470e 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -465,6 +465,15 @@ struct BlockDriver {
>      void (*bdrv_abort_perm_update)(BlockDriverState *bs);
>  
>      /**
> +     * Called to inform the driver of the block configuration of the virtual
> +     * block device.
> +     *
> +     * This function is called by a block device realization function if the
> +     * device wants to inform the block driver of its block configuration.
> +     */
> +    void (*bdrv_apply_blkconf)(BlockDriverState *bs, BlockConf *conf);

This interface can't really work. Block nodes (BlockDriverStates) can
have an arbitrary number of parents, which can be attached and detached
dynamically. This interface basically assumes that there is one device
attached to the node, it will always stay attached and its configuration
stays the same.

Is this function supposed to be called only once? (That assumption
wouldn't hold true.) If not, does a second call mean that a second
parent was attached, or does it update the information of the existing
parent?

How is this information useful when one parent calls the function and
provides BlockConf, but the other doesn't and the block driver doesn't
know about this?

> diff --git a/block/io.c b/block/io.c
> index b7beaee..3a06843 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2932,3 +2932,25 @@ int coroutine_fn bdrv_co_copy_range(BdrvChild *src, uint64_t src_offset,
>      bdrv_dec_in_flight(dst_bs);
>      return ret;
>  }
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

You probably want to propagate to all children instead of singling out
bs->file and bs->backing.

Kevin
