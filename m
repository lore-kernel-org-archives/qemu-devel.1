Received: from eggs.gnu.org ([2001:4830:134:3::10]:37660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS6rm-0002b0-T7
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS6rj-0008DO-Nq
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:18:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dS6rj-0008Bq-DY
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:18:35 -0400
Date: Mon, 3 Jul 2017 22:18:28 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170703220017-mutt-send-email-mst@kernel.org>
References: <1498617479-5809-1-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1498617479-5809-1-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v4] virtio-net: enable configurable tx
 queue size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: jasowang@redhat.com, eblake@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, armbru@redhat.com, stefanha@gmail.com, marcandre.lureau@gmail.com, pbonzini@redhat.com

On Wed, Jun 28, 2017 at 10:37:59AM +0800, Wei Wang wrote:
> This patch enables the virtio-net tx queue size to be configurable
> between 256 (the default queue size) and 1024 by the user when the
> vhost-user backend is used.
> 
> Currently, the maximum tx queue size for other backends is 512 due
> to the following limitations:
> - QEMU backend: the QEMU backend implementation in some cases may
> send 1024+1 iovs to writev.
> - Vhost_net backend: there are possibilities that the guest sends
> a vring_desc of memory which crosses a MemoryRegion thereby
> generating more than 1024 iovs after translation from guest-physical
> address in the backend.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>

I was going to apply this, but run into a host of issues:

This segfaults:
$ ./x86_64-softmmu/qemu-system-x86_64 -device virtio-net,tx_queue_size=1024
Segmentation fault (core dumped)

I tried to tweak this code a bit to avoid the crash, and I run into a further issue:
$ ./x86_64-softmmu/qemu-system-x86_64 -device virtio-net,tx_queue_size=1024
Bad ram offset aa49002
Aborted (core dumped)

the second issue is especially concerning.



> ---
>  hw/net/virtio-net.c            | 32 ++++++++++++++++++++++++++++++--
>  include/hw/virtio/virtio-net.h |  1 +
>  2 files changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 91eddaf..a1fc0db 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -34,8 +34,11 @@
>  
>  /* previously fixed value */
>  #define VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE 256
> +#define VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE 256
> +
>  /* for now, only allow larger queues; with virtio-1, guest can downsize */
>  #define VIRTIO_NET_RX_QUEUE_MIN_SIZE VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE
> +#define VIRTIO_NET_TX_QUEUE_MIN_SIZE VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE
>  
>  /*
>   * Calculate the number of bytes up to and including the given 'field' of
> @@ -1508,15 +1511,18 @@ static void virtio_net_add_queue(VirtIONet *n, int index)
>  
>      n->vqs[index].rx_vq = virtio_add_queue(vdev, n->net_conf.rx_queue_size,
>                                             virtio_net_handle_rx);
> +
>      if (n->net_conf.tx && !strcmp(n->net_conf.tx, "timer")) {
>          n->vqs[index].tx_vq =
> -            virtio_add_queue(vdev, 256, virtio_net_handle_tx_timer);
> +            virtio_add_queue(vdev, n->net_conf.tx_queue_size,
> +                             virtio_net_handle_tx_timer);
>          n->vqs[index].tx_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
>                                                virtio_net_tx_timer,
>                                                &n->vqs[index]);
>      } else {
>          n->vqs[index].tx_vq =
> -            virtio_add_queue(vdev, 256, virtio_net_handle_tx_bh);
> +            virtio_add_queue(vdev, n->net_conf.tx_queue_size,
> +                             virtio_net_handle_tx_bh);
>          n->vqs[index].tx_bh = qemu_bh_new(virtio_net_tx_bh, &n->vqs[index]);
>      }
>  
> @@ -1927,6 +1933,17 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> +    if (n->net_conf.tx_queue_size < VIRTIO_NET_TX_QUEUE_MIN_SIZE ||
> +        n->net_conf.tx_queue_size > VIRTQUEUE_MAX_SIZE ||
> +        !is_power_of_2(n->net_conf.tx_queue_size)) {
> +        error_setg(errp, "Invalid tx_queue_size (= %" PRIu16 "), "
> +                   "must be a power of 2 between %d and %d",
> +                   n->net_conf.tx_queue_size, VIRTIO_NET_TX_QUEUE_MIN_SIZE,
> +                   VIRTQUEUE_MAX_SIZE);
> +        virtio_cleanup(vdev);
> +        return;
> +    }
> +
>      n->max_queues = MAX(n->nic_conf.peers.queues, 1);
>      if (n->max_queues * 2 + 1 > VIRTIO_QUEUE_MAX) {
>          error_setg(errp, "Invalid number of queues (= %" PRIu32 "), "
> @@ -1947,6 +1964,15 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>          error_report("Defaulting to \"bh\"");
>      }
>  
> +    /*
> +     * Currently, backends other than vhost-user don't support 1024 queue
> +     * size.
> +     */
> +    if (n->net_conf.tx_queue_size == VIRTQUEUE_MAX_SIZE &&

I'd prefer >= here.

> +        n->nic_conf.peers.ncs[0]->info->type != NET_CLIENT_DRIVER_VHOST_USER) {
> +        n->net_conf.tx_queue_size = VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE;
> +    }
> +
>      for (i = 0; i < n->max_queues; i++) {
>          virtio_net_add_queue(n, i);
>      }
> @@ -2106,6 +2132,8 @@ static Property virtio_net_properties[] = {
>      DEFINE_PROP_STRING("tx", VirtIONet, net_conf.tx),
>      DEFINE_PROP_UINT16("rx_queue_size", VirtIONet, net_conf.rx_queue_size,
>                         VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE),
> +    DEFINE_PROP_UINT16("tx_queue_size", VirtIONet, net_conf.tx_queue_size,
> +                       VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE),
>      DEFINE_PROP_UINT16("host_mtu", VirtIONet, net_conf.mtu, 0),
>      DEFINE_PROP_BOOL("x-mtu-bypass-backend", VirtIONet, mtu_bypass_backend,
>                       true),
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
> index 602b486..b81b6a4 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -36,6 +36,7 @@ typedef struct virtio_net_conf
>      int32_t txburst;
>      char *tx;
>      uint16_t rx_queue_size;
> +    uint16_t tx_queue_size;
>      uint16_t mtu;
>  } virtio_net_conf;
>  
> -- 
> 2.7.4
