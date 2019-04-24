Received: from eggs.gnu.org ([209.51.188.92]:33946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hJILt-0008ST-GX
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:54:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hJIJ7-0004Rl-Rv
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:51:30 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hJIJ7-0004Q0-Np
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:51:29 -0400
Received: by mail-qt1-f194.google.com with SMTP id y49so1592393qta.7
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 06:51:29 -0700 (PDT)
Date: Wed, 24 Apr 2019 09:51:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190424095058-mutt-send-email-mst@kernel.org>
References: <20190409055850.25797-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409055850.25797-1-jasowang@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V3] vhost_net: don't set backend for the
 uninitialized virtqueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, yuri.benditovich@daynix.com

On Tue, Apr 09, 2019 at 01:58:50PM +0800, Jason Wang wrote:
> We used to set backend unconditionally, this won't work for some
> guests (e.g windows driver) who may not initialize all virtqueues. For
> kernel backend, this will fail since it may try to validate the rings
> during setting backend.
> 
> Fixing this by simply skipping the backend set when we find desc is
> not ready.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Changes from V1:
> - introduce a generic helper to check if a virtqueue is enabled
> ---
>  hw/net/vhost_net.c         | 10 ++++++++++
>  hw/virtio/virtio.c         |  5 +++++
>  include/hw/virtio/virtio.h |  1 +
>  3 files changed, 16 insertions(+)
> 
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index be3cc88370..a6b719035c 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -244,6 +244,11 @@ static int vhost_net_start_one(struct vhost_net *net,
>          qemu_set_fd_handler(net->backend, NULL, NULL, NULL);
>          file.fd = net->backend;
>          for (file.index = 0; file.index < net->dev.nvqs; ++file.index) {
> +            if (!virtio_queue_enabled(dev, net->dev.vq_index +
> +                                      file.index)) {
> +                /* Queue might not be ready for start */
> +                continue;
> +            }
>              r = vhost_net_set_backend(&net->dev, &file);
>              if (r < 0) {
>                  r = -errno;
> @@ -256,6 +261,11 @@ fail:
>      file.fd = -1;
>      if (net->nc->info->type == NET_CLIENT_DRIVER_TAP) {
>          while (file.index-- > 0) {
> +            if (!virtio_queue_enabled(dev, net->dev.vq_index +
> +                                      file.index)) {
> +                /* Queue might not be ready for start */
> +                continue;
> +            }
>              int r = vhost_net_set_backend(&net->dev, &file);
>              assert(r >= 0);
>          }
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 2626a895cb..28056a7ef7 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2318,6 +2318,11 @@ hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n)
>      return vdev->vq[n].vring.desc;
>  }
>  
> +bool virtio_queue_enabled(VirtIODevice *vdev, int n)
> +{
> +    return virtio_queue_get_desc_addr(vdev, n) != 0;
> +}
> +
>  hwaddr virtio_queue_get_avail_addr(VirtIODevice *vdev, int n)
>  {
>      return vdev->vq[n].vring.avail;
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index ce9516236a..7140381e3a 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -282,6 +282,7 @@ typedef struct VirtIORNGConf VirtIORNGConf;
>                        VIRTIO_F_IOMMU_PLATFORM, false)
>  
>  hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
> +bool virtio_queue_enabled(VirtIODevice *vdev, int n);
>  hwaddr virtio_queue_get_avail_addr(VirtIODevice *vdev, int n);
>  hwaddr virtio_queue_get_used_addr(VirtIODevice *vdev, int n);
>  hwaddr virtio_queue_get_desc_size(VirtIODevice *vdev, int n);
> -- 
> 2.19.1
