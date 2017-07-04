Received: from eggs.gnu.org ([2001:4830:134:3::10]:38138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dSKNg-0001FQ-FR
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:44:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dSKNe-00042G-Uh
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:44:28 -0400
Date: Tue, 4 Jul 2017 11:44:17 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170704094417.GA4253@noname.str.redhat.com>
References: <20170704084059.6278-1-el13635@mail.ntua.gr>
	<20170704084059.6278-2-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170704084059.6278-2-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH v3 1/4] block: Pass bdrv_* methods to
 bs->file by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, qemu-block <qemu-block@nongnu.org>

Am 04.07.2017 um 10:40 hat Manos Pitsidianakis geschrieben:
> The following functions fail if bs->drv does not implement them:
> 
> bdrv_probe_blocksizes
> bdrv_probe_geometry
> bdrv_truncate
> bdrv_has_zero_init
> bdrv_get_info
> bdrv_media_changed
> bdrv_eject
> bdrv_lock_medium
> bdrv_co_ioctl
> 
> Instead, the call should be passed to bs->file if it exists, to allow
> filter drivers to support those methods without implementing them.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  block.c    | 27 +++++++++++++++++++++++++--
>  block/io.c |  5 +++++
>  2 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/block.c b/block.c
> index 69439628..8a122142 100644
> --- a/block.c
> +++ b/block.c
> @@ -494,6 +494,8 @@ int bdrv_probe_blocksizes(BlockDriverState *bs, BlockSizes *bsz)
>  
>      if (drv && drv->bdrv_probe_blocksizes) {
>          return drv->bdrv_probe_blocksizes(bs, bsz);
> +    } else if (drv && bs->file && bs->file->bs) {

The check for bs->file->bs isn't really necessary, we never have a
BdrvChild with a NULL bs.

> +        return bdrv_probe_blocksizes(bs->file->bs, bsz);
>      }
>  
>      return -ENOTSUP;

This change actually changes existing behaviour. Basically, all of your
additions also apply for qcow2 images or other image formats, and we
need to check whether they make sense there.

bdrv_probe_blocksizes() is used for the default values for the physical
and logical block sizes for block devices if no value is explicitly
specified in -device. This makes sense as it will allow the guest to
optimise its requests so that they align with the block size that is
optimal for the storage that contains the image. (I also think that we
probably should implement .bdrv_probe_blocksizes() not only for
host_device, but also for regular files to get optimal performance by
default.)

Changing the defaults can be a problem for cross-version live migration
if the default values are used. Management tools that want to do live
migration are supposed to explicitly provide all options they can, so
this should be okay.

Eric, does libvirt set the physical/logical block size explicitly? If
not, it would be good if it started to do so.

This hunk is non-trivial enough that it's probably worth a patch of its
own with a detailed commit message explaining why we want this change
and why it is safe.

> @@ -511,6 +513,8 @@ int bdrv_probe_geometry(BlockDriverState *bs, HDGeometry *geo)
>  
>      if (drv && drv->bdrv_probe_geometry) {
>          return drv->bdrv_probe_geometry(bs, geo);
> +    } else if (drv && bs->file && bs->file->bs) {
> +        return bdrv_probe_geometry(bs->file->bs, geo);
>      }
>  
>      return -ENOTSUP;

The probed geometry would refer to the physical image file, not to the
actually presented image. So propagating this to bs->file is wrong for
image formats.

Possibly checking .is_filter in addition would be enough.

If you decide that this is the right field, please add some note to the
comment for the .is_filter declaration that tells about the assumptions
that are made when the field is set. I'm not completely sure what they
are, but maybe something like this: If bs->file != NULL, then all data
exposed by the filter node is mapped at the same offset in bs->file.

> @@ -3406,11 +3410,15 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, Error **errp)
>  
>      assert(child->perm & BLK_PERM_RESIZE);
>  
> +    /* if bs->drv == NULL, bs is closed, so there's nothing to do here */
>      if (!drv) {
>          error_setg(errp, "No medium inserted");
>          return -ENOMEDIUM;
>      }
>      if (!drv->bdrv_truncate) {
> +        if (bs->file && bs->file->bs) {
> +            return bdrv_truncate(bs->file, offset, errp);
> +        }
>          error_setg(errp, "Image format driver does not support resize");
>          return -ENOTSUP;
>      }

This is actively dangerous without an .is_filter check!

All image formats that don't support image resizing would instead just
truncate the image file without considering the format at all.

> @@ -3778,6 +3786,9 @@ int bdrv_has_zero_init(BlockDriverState *bs)
>      if (bs->drv->bdrv_has_zero_init) {
>          return bs->drv->bdrv_has_zero_init(bs);
>      }
> +    if (bs->file && bs->file->bs) {
> +        return bdrv_has_zero_init(bs->file->bs);
> +    }
>  
>      /* safe default */
>      return 0;

This is wrong for image formats.

> @@ -3832,10 +3843,16 @@ void bdrv_get_backing_filename(BlockDriverState *bs,
>  int bdrv_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
>  {
>      BlockDriver *drv = bs->drv;
> -    if (!drv)
> +    /* if bs->drv == NULL, bs is closed, so there's nothing to do here */
> +    if (!drv) {
>          return -ENOMEDIUM;
> -    if (!drv->bdrv_get_info)
> +    }
> +    if (!drv->bdrv_get_info) {
> +        if (bs->file && bs->file->bs) {
> +            return bdrv_get_info(bs->file->bs, bdi);
> +        }
>          return -ENOTSUP;
> +    }
>      memset(bdi, 0, sizeof(*bdi));
>      return drv->bdrv_get_info(bs, bdi);
>  }

Same thing.

> @@ -4205,6 +4222,8 @@ int bdrv_media_changed(BlockDriverState *bs)
>  
>      if (drv && drv->bdrv_media_changed) {
>          return drv->bdrv_media_changed(bs);
> +    } else if (drv && bs->file && bs->file->bs) {
> +        return bdrv_media_changed(bs->file->bs);
>      }
>      return -ENOTSUP;
>  }

This function appears to be unused, so instead of discussing whether
this actually makes sense, we can simply remove it. :-)

> @@ -4218,6 +4237,8 @@ void bdrv_eject(BlockDriverState *bs, bool eject_flag)
>  
>      if (drv && drv->bdrv_eject) {
>          drv->bdrv_eject(bs, eject_flag);
> +    } else if (drv && bs->file && bs->file->bs) {
> +        bdrv_eject(bs->file->bs, eject_flag);
>      }
>  }
>  
> @@ -4233,6 +4254,8 @@ void bdrv_lock_medium(BlockDriverState *bs, bool locked)
>  
>      if (drv && drv->bdrv_lock_medium) {
>          drv->bdrv_lock_medium(bs, locked);
> +    } else if (drv && bs->file && bs->file->bs) {
> +        bdrv_lock_medium(bs->file->bs, locked);
>      }
>  }

I'm not sure if media change can be handled transparently without
explicit support in all drivers in the chain. This is probably even true
for filter drivers.

So I think I would just drop these two hunks from the patch.

> diff --git a/block/io.c b/block/io.c
> index 5c146b5a..c22a9bf2 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2425,6 +2425,11 @@ int bdrv_co_ioctl(BlockDriverState *bs, int req, void *buf)
>      };
>      BlockAIOCB *acb;
>  
> +    if (drv && !drv->bdrv_aio_ioctl && !drv->bdrv_co_ioctl &&
> +        bs->file && bs->file->bs) {
> +        return bdrv_co_ioctl(bs->file->bs, req, buf);
> +    }
> +
>      bdrv_inc_in_flight(bs);
>      if (!drv || (!drv->bdrv_aio_ioctl && !drv->bdrv_co_ioctl)) {
>          co.ret = -ENOTSUP;

This makes me nervous. Basically, SCSI passthrough doesn't work well
with anything that isn't just a file-posix BDS. Bypassing block nodes
for it, whether image formats or filter drivers, might get these drivers
into surprising states and might even break the image.

I'd rather not support bdrv_co_ioctl() for anything that can't
explicitly handle it.

Kevin
