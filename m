Received: from eggs.gnu.org ([2001:4830:134:3::10]:46324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ewkMz-0007tS-1b
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 04:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ewkMv-0007Jt-Rl
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 04:05:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56448 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ewkMv-0007Gs-Ly
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 04:05:41 -0400
References: <152044905701.22965.8924520463227226351.stgit@bahia.lan>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <edb53a74-2c21-f0ff-ec9d-2728bfb2a416@redhat.com>
Date: Fri, 16 Mar 2018 16:05:17 +0800
MIME-Version: 1.0
In-Reply-To: <152044905701.22965.8924520463227226351.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio_net: flush uncompleted TX on reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: R Nageswara Sastry <nasastry@in.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>



On 2018=E5=B9=B403=E6=9C=8808=E6=97=A5 02:57, Greg Kurz wrote:
> If the backend could not transmit a packet right away for some reason,
> the packet is queued for asynchronous sending. The corresponding vq
> element is tracked in the async_tx.elem field of the VirtIONetQueue,
> for later freeing when the transmission is complete.
>
> If a reset happens before completion, virtio_net_tx_complete() will pus=
h
> async_tx.elem back to the guest anyway, and we end up with the inuse fl=
ag
> of the vq being equal to -1. The next call to virtqueue_pop() is then
> likely to fail with "Virtqueue size exceeded".
>
> This can be reproduced easily by starting a guest without a net backend=
,
> doing a system reset when it is booted, and finally snapshotting it.
>
> The appropriate fix is to ensure that such an asynchronous transmission
> cannot survive a device reset. So for all queues, we first try to send
> the packet again, and eventually we purge it if the backend still could
> not deliver it.
>
> Reported-by: R. Nageswara Sastry <nasastry@in.ibm.com>
> Buglink: https://github.com/open-power-host-os/qemu/issues/37
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   hw/net/virtio-net.c |   11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 188744e17d57..eea3cdb2c700 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -422,6 +422,7 @@ static RxFilterInfo *virtio_net_query_rxfilter(NetC=
lientState *nc)
>   static void virtio_net_reset(VirtIODevice *vdev)
>   {
>       VirtIONet *n =3D VIRTIO_NET(vdev);
> +    int i;
>  =20
>       /* Reset back to compatibility mode */
>       n->promisc =3D 1;
> @@ -445,6 +446,16 @@ static void virtio_net_reset(VirtIODevice *vdev)
>       memcpy(&n->mac[0], &n->nic->conf->macaddr, sizeof(n->mac));
>       qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
>       memset(n->vlans, 0, MAX_VLAN >> 3);
> +
> +    /* Flush any async TX */
> +    for (i =3D 0;  i < n->max_queues; i++) {
> +        NetClientState *nc =3D qemu_get_subqueue(n->nic, i);
> +
> +        if (!qemu_net_queue_flush(nc->peer->incoming_queue)) {
> +            qemu_net_queue_purge(nc->peer->incoming_queue, nc);
> +        }

Looks like we can use qemu_flush_or_purge_queued_packets(nc->peer) here.

But a questions, you said it could be reproduced without a backend, in=20
this case nc->peer should be NULL I believe or we won't even get here=20
since qemu_sendv_packet_async() won't return zero?

Thanks

> +        assert(!virtio_net_get_subqueue(nc)->async_tx.elem);
> +    }
>   }
>  =20
>   static void peer_test_vnet_hdr(VirtIONet *n)
>
>
