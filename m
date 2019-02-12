Received: from eggs.gnu.org ([209.51.188.92]:42533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gtYFh-0008Rs-OO
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:37:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gtYFd-0000Ot-NM
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:37:33 -0500
Received: from 2.mo5.mail-out.ovh.net ([178.33.109.111]:51038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gtYFb-0008Qn-D6
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:37:27 -0500
Received: from player694.ha.ovh.net (unknown [10.109.160.253])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id A483A213F7C
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 14:37:12 +0100 (CET)
Date: Tue, 12 Feb 2019 14:37:00 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190212143700.444c2b86@bahia.lan>
In-Reply-To: <1549951304-26100-1-git-send-email-changpeng.liu@intel.com>
References: <1549951304-26100-1-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: qemu-devel@nongnu.org, ldoktor@redhat.com, mst@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, sgarzare@redhat.com

On Tue, 12 Feb 2019 14:01:44 +0800
Changpeng Liu <changpeng.liu@intel.com> wrote:

> Commit caa1ee43 "vhost-user-blk: add discard/write zeroes features support"
> introduced extra fields to existing struct virtio_blk_config, when
> migration was executed from older QEMU version to current head, it

A hint about the breakage is often a good practice, as it helps
people to find the fix if they hit the issue.

> will break the migration.  While here, set the correct config size

"While here" usually means that the corresponding change isn't strictly
needed. I don't believe this is the case here since fixing the config
size is precisely the goal of this patch.

> when initializing the host driver, for now, discard/write zeroes
> are not supported by virtio-blk host driver, so set the config

As mentioned by Michael, there's no such thing as a "host driver".
Just say virtio-blk.

> size as before, users can change config size when adding the new
> feature bits support.
> 

What about ?

Commit caa1ee43 "vhost-user-blk: add discard/write zeroes features
support" added fields to struct virtio_blk_config. This changes
the size of the config space and breaks migration from QEMU 3.1
and older:

qemu-system-ppc64: get_pci_config_device: Bad config data: i=0x10 read: 41 device: 1 cmask: ff wmask: 80 w1cmask:0
qemu-system-ppc64: Failed to load PCIDevice:config
qemu-system-ppc64: Failed to load virtio-blk:virtio
qemu-system-ppc64: error while loading state for instance 0x0 of device 'pci@800000020000000:01.0/virtio-blk'
qemu-system-ppc64: load of migration failed: Invalid argument

Since virtio-blk doesn't support the "discard" and "write zeroes"
features, it shouldn't even expose the associated fields in the
config space actually. Just include all fields up to num_queues to
match QEMU 3.1 and older.

> Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> ---

LGTM

Reviewed-by: Greg Kurz <groug@kaod.org>
Tested-by: Greg Kurz <groug@kaod.org>

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
>  static void virtio_blk_init_request(VirtIOBlock *s, VirtQueue *vq,
>                                      VirtIOBlockReq *req)
>  {
> @@ -761,7 +764,7 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
>      blkcfg.alignment_offset = 0;
>      blkcfg.wce = blk_enable_write_cache(s->blk);
>      virtio_stw_p(vdev, &blkcfg.num_queues, s->conf.num_queues);
> -    memcpy(config, &blkcfg, sizeof(struct virtio_blk_config));
> +    memcpy(config, &blkcfg, VIRTIO_BLK_CFG_SIZE);
>  }
>  
>  static void virtio_blk_set_config(VirtIODevice *vdev, const uint8_t *config)
> @@ -769,7 +772,7 @@ static void virtio_blk_set_config(VirtIODevice *vdev, const uint8_t *config)
>      VirtIOBlock *s = VIRTIO_BLK(vdev);
>      struct virtio_blk_config blkcfg;
>  
> -    memcpy(&blkcfg, config, sizeof(blkcfg));
> +    memcpy(&blkcfg, config, VIRTIO_BLK_CFG_SIZE);
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
