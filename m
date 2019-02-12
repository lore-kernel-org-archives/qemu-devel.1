Received: from eggs.gnu.org ([209.51.188.92]:45396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gtYQp-0002TB-1W
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:49:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gtYQn-0007Xj-Ad
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:49:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gtYQn-0007Ub-1Z
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:49:01 -0500
Date: Tue, 12 Feb 2019 08:48:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190212084531-mutt-send-email-mst@kernel.org>
References: <1549951304-26100-1-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549951304-26100-1-git-send-email-changpeng.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2] virtio-blk: set correct config size for
 the host driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changpeng Liu <changpeng.liu@intel.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, sgarzare@redhat.com, dgilbert@redhat.com, ldoktor@redhat.com

On Tue, Feb 12, 2019 at 02:01:44PM +0800, Changpeng Liu wrote:
> Commit caa1ee43 "vhost-user-blk: add discard/write zeroes features support"
> introduced extra fields to existing struct virtio_blk_config, when
> migration was executed from older QEMU version to current head, it
> will break the migration.  While here, set the correct config size
> when initializing the host driver, for now, discard/write zeroes
> are not supported by virtio-blk host driver, so set the config
> size as before, users can change config size when adding the new
> feature bits support.
> 
> Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>


Pls rewrite commit log as suggested in this thread
and repost.

> ---
>  hw/block/virtio-blk.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 9a87b3b..846b7b9 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -28,6 +28,9 @@
>  #include "hw/virtio/virtio-bus.h"
>  #include "hw/virtio/virtio-access.h"
>  
> +#define VIRTIO_BLK_CFG_SIZE (offsetof(struct virtio_blk_config, num_queues) + \
> +                             sizeof_field(struct virtio_blk_config, num_queues))
> +

I would just do offsetof(max_discard_sectors)
with a comment "we don't support discard yet, hide associated config
fields".

>  static void virtio_blk_init_request(VirtIOBlock *s, VirtQueue *vq,
>                                      VirtIOBlockReq *req)
>  {
> @@ -761,7 +764,7 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
>      blkcfg.alignment_offset = 0;
>      blkcfg.wce = blk_enable_write_cache(s->blk);
>      virtio_stw_p(vdev, &blkcfg.num_queues, s->conf.num_queues);
> -    memcpy(config, &blkcfg, sizeof(struct virtio_blk_config));
> +    memcpy(config, &blkcfg, VIRTIO_BLK_CFG_SIZE);


Let's add QEMU_BUILD_BUG_ON(VIRTIO_BLK_CFG_SIZE <= sizeof(struct
virtio_blk_config)) just for documentation purposes.

>  }
>  
>  static void virtio_blk_set_config(VirtIODevice *vdev, const uint8_t *config)
> @@ -769,7 +772,7 @@ static void virtio_blk_set_config(VirtIODevice *vdev, const uint8_t *config)
>      VirtIOBlock *s = VIRTIO_BLK(vdev);
>      struct virtio_blk_config blkcfg;
>  
> -    memcpy(&blkcfg, config, sizeof(blkcfg));
> +    memcpy(&blkcfg, config, VIRTIO_BLK_CFG_SIZE);


Here too, QEMU_BUILD_BUG_ON(VIRTIO_BLK_CFG_SIZE <= sizeof(blkcfg))

>  
>      aio_context_acquire(blk_get_aio_context(s->blk));
>      blk_set_enable_write_cache(s->blk, blkcfg.wce != 0);
> @@ -952,8 +955,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> -    virtio_init(vdev, "virtio-blk", VIRTIO_ID_BLOCK,
> -                sizeof(struct virtio_blk_config));
> +    virtio_init(vdev, "virtio-blk", VIRTIO_ID_BLOCK, VIRTIO_BLK_CFG_SIZE);
>  
>      s->blk = conf->conf.blk;
>      s->rq = NULL;
> -- 
> 1.9.3
