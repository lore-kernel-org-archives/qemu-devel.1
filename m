Received: from eggs.gnu.org ([2001:4830:134:3::10]:35484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dHuDl-000121-9u
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:47:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dHuDi-0000Pq-97
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:47:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dHuDi-0000PL-2y
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:47:06 -0400
Date: Mon, 5 Jun 2017 18:47:03 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170605184525-mutt-send-email-mst@kernel.org>
References: <1496653049-44530-1-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496653049-44530-1-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v1] virtio-net: enable configurable tx
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
Cc: jasowang@redhat.com, stefanha@gmail.com, marcandre.lureau@gmail.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, jan.scheurich@ericsson.com

On Mon, Jun 05, 2017 at 04:57:29PM +0800, Wei Wang wrote:
> @@ -1910,6 +1958,17 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> +    if (n->net_conf.tx_queue_size < VIRTIO_NET_TX_QUEUE_MIN_SIZE ||
> +        n->net_conf.tx_queue_size > VIRTQUEUE_MAX_SIZE ||
> +        (n->net_conf.tx_queue_size & (n->net_conf.tx_queue_size - 1))) {
> +        error_setg(errp, "Invalid tx_queue_size (= %" PRIu16 "), "
> +                   "must be a power of 2 between %d and %d.",
> +                   n->net_conf.tx_queue_size, VIRTIO_NET_TX_QUEUE_MIN_SIZE,
> +                   VIRTQUEUE_MAX_SIZE);
> +        virtio_cleanup(vdev);
> +        return;
> +    }
> +
>      n->max_queues = MAX(n->nic_conf.peers.queues, 1);
>      if (n->max_queues * 2 + 1 > VIRTIO_QUEUE_MAX) {
>          error_setg(errp, "Invalid number of queues (= %" PRIu32 "), "

Given that some configurations (e.g. legacy guest) ignore the value,
I'm inclined to say just force the value to be within a reasonable
limit.

-- 
MST
