Received: from eggs.gnu.org ([2001:4830:134:3::10]:42725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dACHk-0006pg-9j
	for qemu-devel@nongnu.org; Mon, 15 May 2017 05:27:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dACHf-0007Mq-HH
	for qemu-devel@nongnu.org; Mon, 15 May 2017 05:27:24 -0400
Received: from mga03.intel.com ([134.134.136.65]:62775)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dACHf-0007MN-7K
	for qemu-devel@nongnu.org; Mon, 15 May 2017 05:27:19 -0400
Message-ID: <591974EB.2010409@intel.com>
Date: Mon, 15 May 2017 17:29:15 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1494478641-24549-1-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1494478641-24549-1-git-send-email-wei.w.wang@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] virtio-net: keep the packet layout intact
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, jasowang@redhat.com, stefanha@gmail.com, marcandre.lureau@gmail.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Cc: jan.scheurich@ericsson.com

Ping for comments, thanks.

On 05/11/2017 12:57 PM, Wei Wang wrote:
> The current implementation may change the packet layout when
> vnet_hdr needs an endianness swap. The layout change causes
> one more iov to be added to the iov[] passed from the guest, which
> is a barrier to making the TX queue size 1024 due to the possible
> off-by-one issue.
>
> This patch changes the implementation to remain the packet layout
> intact. In this case, the number of iov[] passed to writev will be
> equal to the number obtained from the guest.
>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>   hw/net/virtio-net.c | 29 ++++++++++++++---------------
>   1 file changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 7d091c9..a51e9a8 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1287,8 +1287,7 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
>       for (;;) {
>           ssize_t ret;
>           unsigned int out_num;
> -        struct iovec sg[VIRTQUEUE_MAX_SIZE], sg2[VIRTQUEUE_MAX_SIZE + 1], *out_sg;
> -        struct virtio_net_hdr_mrg_rxbuf mhdr;
> +        struct iovec sg[VIRTQUEUE_MAX_SIZE], mhdr, *out_sg;
>   
>           elem = virtqueue_pop(q->tx_vq, sizeof(VirtQueueElement));
>           if (!elem) {
> @@ -1305,7 +1304,10 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
>           }
>   
>           if (n->has_vnet_hdr) {
> -            if (iov_to_buf(out_sg, out_num, 0, &mhdr, n->guest_hdr_len) <
> +            /* Buffer to copy vnet_hdr and the possible adjacent data */
> +            mhdr.iov_len = out_sg[0].iov_len;
> +            mhdr.iov_base = g_malloc0(mhdr.iov_len);
> +            if (iov_to_buf(out_sg, out_num, 0, mhdr.iov_base, mhdr.iov_len) <
>                   n->guest_hdr_len) {
>                   virtio_error(vdev, "virtio-net header incorrect");
>                   virtqueue_detach_element(q->tx_vq, elem, 0);
> @@ -1313,17 +1315,12 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
>                   return -EINVAL;
>               }
>               if (n->needs_vnet_hdr_swap) {
> -                virtio_net_hdr_swap(vdev, (void *) &mhdr);
> -                sg2[0].iov_base = &mhdr;
> -                sg2[0].iov_len = n->guest_hdr_len;
> -                out_num = iov_copy(&sg2[1], ARRAY_SIZE(sg2) - 1,
> -                                   out_sg, out_num,
> -                                   n->guest_hdr_len, -1);
> -                if (out_num == VIRTQUEUE_MAX_SIZE) {
> -                    goto drop;
> -		}
> -                out_num += 1;
> -                out_sg = sg2;
> +                virtio_net_hdr_swap(vdev, mhdr.iov_base);
> +                /* Copy the first iov where the vnet_hdr resides in */
> +                out_num = iov_copy(sg, 1, &mhdr, 1, 0, mhdr.iov_len);
> +                out_num += iov_copy(sg + 1, ARRAY_SIZE(sg) - 1, out_sg + 1,
> +                                    elem->out_num - 1, 0, -1);
> +                out_sg = sg;
>   	    }
>           }
>           /*
> @@ -1345,13 +1342,15 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
>   
>           ret = qemu_sendv_packet_async(qemu_get_subqueue(n->nic, queue_index),
>                                         out_sg, out_num, virtio_net_tx_complete);
> +        if (n->has_vnet_hdr) {
> +            g_free(mhdr.iov_base);
> +        }
>           if (ret == 0) {
>               virtio_queue_set_notification(q->tx_vq, 0);
>               q->async_tx.elem = elem;
>               return -EBUSY;
>           }
>   
> -drop:
>           virtqueue_push(q->tx_vq, elem, 0);
>           virtio_notify(vdev, q->tx_vq);
>           g_free(elem);
