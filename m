Received: from eggs.gnu.org ([209.51.188.92]:33835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gm1PO-0005KF-8A
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:08:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gm1PJ-0000Su-87
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:08:23 -0500
From: Thomas Huth <thuth@redhat.com>
References: <1545149484-4929-1-git-send-email-thuth@redhat.com>
Message-ID: <25d1e73d-ca73-9cb4-d959-8353f49f36b7@redhat.com>
Date: Tue, 22 Jan 2019 15:19:35 +0100
MIME-Version: 1.0
In-Reply-To: <1545149484-4929-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [QEMU PATCH] block: Remove blk_attach_dev_legacy()
 / legacy_dev code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, paul.durrant@citrix.com

On 2018-12-18 17:11, Thomas Huth wrote:
> The last user of blk_attach_dev_legacy() is the code in xen_disk.c.
> It passes a pointer to a XenBlkDev as second parameter. XenBlkDev
> is derived from XenDevice which in turn is derived from DeviceState
> since commit 3a6c9172ac5951e ("xen: create qdev for each backend device").
> Thus the code can also simply use blk_attach_dev() with a pointer
> to the DeviceState instead.
> So we can finally remove all code related to the "legacy_dev" flag, too,
> and turn the related "void *" in block-backend.c into "DeviceState *"
> to fix some of the remaining TODOs there.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Note: I haven't tested the Xen code since I don't have a working Xen
>  installation at hand. I'd appreciate if someone could check it...

Ping?

>  block/block-backend.c          | 54 +++++++-----------------------------------
>  hw/block/xen_disk.c            |  6 +++--
>  include/sysemu/block-backend.h |  5 ++--
>  3 files changed, 15 insertions(+), 50 deletions(-)
> 
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 60d37a0..3c3118f 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -47,9 +47,7 @@ struct BlockBackend {
>      QTAILQ_ENTRY(BlockBackend) monitor_link; /* for monitor_block_backends */
>      BlockBackendPublic public;
>  
> -    void *dev;                  /* attached device model, if any */
> -    bool legacy_dev;            /* true if dev is not a DeviceState */
> -    /* TODO change to DeviceState when all users are qdevified */
> +    DeviceState *dev;           /* attached device model, if any */
>      const BlockDevOps *dev_ops;
>      void *dev_opaque;
>  
> @@ -836,7 +834,11 @@ void blk_get_perm(BlockBackend *blk, uint64_t *perm, uint64_t *shared_perm)
>      *shared_perm = blk->shared_perm;
>  }
>  
> -static int blk_do_attach_dev(BlockBackend *blk, void *dev)
> +/*
> + * Attach device model @dev to @blk.
> + * Return 0 on success, -EBUSY when a device model is attached already.
> + */
> +int blk_attach_dev(BlockBackend *blk, DeviceState *dev)
>  {
>      if (blk->dev) {
>          return -EBUSY;
> @@ -851,40 +853,16 @@ static int blk_do_attach_dev(BlockBackend *blk, void *dev)
>  
>      blk_ref(blk);
>      blk->dev = dev;
> -    blk->legacy_dev = false;
>      blk_iostatus_reset(blk);
>  
>      return 0;
>  }
>  
>  /*
> - * Attach device model @dev to @blk.
> - * Return 0 on success, -EBUSY when a device model is attached already.
> - */
> -int blk_attach_dev(BlockBackend *blk, DeviceState *dev)
> -{
> -    return blk_do_attach_dev(blk, dev);
> -}
> -
> -/*
> - * Attach device model @dev to @blk.
> - * @blk must not have a device model attached already.
> - * TODO qdevified devices don't use this, remove when devices are qdevified
> - */
> -void blk_attach_dev_legacy(BlockBackend *blk, void *dev)
> -{
> -    if (blk_do_attach_dev(blk, dev) < 0) {
> -        abort();
> -    }
> -    blk->legacy_dev = true;
> -}
> -
> -/*
>   * Detach device model @dev from @blk.
>   * @dev must be currently attached to @blk.
>   */
> -void blk_detach_dev(BlockBackend *blk, void *dev)
> -/* TODO change to DeviceState *dev when all users are qdevified */
> +void blk_detach_dev(BlockBackend *blk, DeviceState *dev)
>  {
>      assert(blk->dev == dev);
>      blk->dev = NULL;
> @@ -898,8 +876,7 @@ void blk_detach_dev(BlockBackend *blk, void *dev)
>  /*
>   * Return the device model attached to @blk if any, else null.
>   */
> -void *blk_get_attached_dev(BlockBackend *blk)
> -/* TODO change to return DeviceState * when all users are qdevified */
> +DeviceState *blk_get_attached_dev(BlockBackend *blk)
>  {
>      return blk->dev;
>  }
> @@ -908,10 +885,7 @@ void *blk_get_attached_dev(BlockBackend *blk)
>   * device attached to the BlockBackend. */
>  char *blk_get_attached_dev_id(BlockBackend *blk)
>  {
> -    DeviceState *dev;
> -
> -    assert(!blk->legacy_dev);
> -    dev = blk->dev;
> +    DeviceState *dev = blk->dev;
>  
>      if (!dev) {
>          return g_strdup("");
> @@ -949,11 +923,6 @@ BlockBackend *blk_by_dev(void *dev)
>  void blk_set_dev_ops(BlockBackend *blk, const BlockDevOps *ops,
>                       void *opaque)
>  {
> -    /* All drivers that use blk_set_dev_ops() are qdevified and we want to keep
> -     * it that way, so we can assume blk->dev, if present, is a DeviceState if
> -     * blk->dev_ops is set. Non-device users may use dev_ops without device. */
> -    assert(!blk->legacy_dev);
> -
>      blk->dev_ops = ops;
>      blk->dev_opaque = opaque;
>  
> @@ -979,8 +948,6 @@ void blk_dev_change_media_cb(BlockBackend *blk, bool load, Error **errp)
>          bool tray_was_open, tray_is_open;
>          Error *local_err = NULL;
>  
> -        assert(!blk->legacy_dev);
> -
>          tray_was_open = blk_dev_is_tray_open(blk);
>          blk->dev_ops->change_media_cb(blk->dev_opaque, load, &local_err);
>          if (local_err) {
> @@ -1779,9 +1746,6 @@ void blk_eject(BlockBackend *blk, bool eject_flag)
>      BlockDriverState *bs = blk_bs(blk);
>      char *id;
>  
> -    /* blk_eject is only called by qdevified devices */
> -    assert(!blk->legacy_dev);
> -
>      if (bs) {
>          bdrv_eject(bs, eject_flag);
>      }
> diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
> index 36eff94..9605caf 100644
> --- a/hw/block/xen_disk.c
> +++ b/hw/block/xen_disk.c
> @@ -801,7 +801,9 @@ static int blk_connect(struct XenDevice *xendev)
>           * so we can blk_unref() unconditionally */
>          blk_ref(blkdev->blk);
>      }
> -    blk_attach_dev_legacy(blkdev->blk, blkdev);
> +    if (blk_attach_dev(blkdev->blk, DEVICE(blkdev)) < 0) {
> +        return -1;
> +    }
>      blkdev->file_size = blk_getlength(blkdev->blk);
>      if (blkdev->file_size < 0) {
>          BlockDriverState *bs = blk_bs(blkdev->blk);
> @@ -951,7 +953,7 @@ static void blk_disconnect(struct XenDevice *xendev)
>  
>      if (blkdev->blk) {
>          blk_set_aio_context(blkdev->blk, qemu_get_aio_context());
> -        blk_detach_dev(blkdev->blk, blkdev);
> +        blk_detach_dev(blkdev->blk, DEVICE(blkdev));
>          blk_unref(blkdev->blk);
>          blkdev->blk = NULL;
>      }
> diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
> index c96bcde..39507d6 100644
> --- a/include/sysemu/block-backend.h
> +++ b/include/sysemu/block-backend.h
> @@ -110,9 +110,8 @@ void blk_iostatus_disable(BlockBackend *blk);
>  void blk_iostatus_reset(BlockBackend *blk);
>  void blk_iostatus_set_err(BlockBackend *blk, int error);
>  int blk_attach_dev(BlockBackend *blk, DeviceState *dev);
> -void blk_attach_dev_legacy(BlockBackend *blk, void *dev);
> -void blk_detach_dev(BlockBackend *blk, void *dev);
> -void *blk_get_attached_dev(BlockBackend *blk);
> +void blk_detach_dev(BlockBackend *blk, DeviceState *dev);
> +DeviceState *blk_get_attached_dev(BlockBackend *blk);
>  char *blk_get_attached_dev_id(BlockBackend *blk);
>  BlockBackend *blk_by_dev(void *dev);
>  BlockBackend *blk_by_qdev_id(const char *id, Error **errp);
> 
