Received: from eggs.gnu.org ([2001:4830:134:3::10]:40748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ey76e-0001Nd-10
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 22:34:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ey76a-0006yh-Qx
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 22:34:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50592 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ey76a-0006pr-Lt
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 22:34:28 -0400
References: <152120204902.1103.7114773412109402452.stgit@bahia.lan>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <181e938f-76b7-84b2-96f1-1f8832236e23@redhat.com>
Date: Tue, 20 Mar 2018 10:34:09 +0800
MIME-Version: 1.0
In-Reply-To: <152120204902.1103.7114773412109402452.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] virtio_net: flush uncompleted TX on
 reset
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



On 2018=E5=B9=B403=E6=9C=8816=E6=97=A5 20:07, Greg Kurz wrote:
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
> This can be reproduced easily by starting a guest with an hubport backe=
nd
> that is not connected to a functional network, eg,
>
>   -device virtio-net-pci,netdev=3Dhub0 -netdev hubport,id=3Dhub0,hubid=3D=
0
>
> and no other -netdev hubport,hubid=3D0 on the command line.
>
> The appropriate fix is to ensure that such an asynchronous transmission
> cannot survive a device reset. So for all queues, we first try to send
> the packet again, and eventually we purge it if the backend still could
> not deliver it.
>
> Reported-by: R. Nageswara Sastry <nasastry@in.ibm.com>
> Buglink: https://github.com/open-power-host-os/qemu/issues/37
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Tested-by: R. Nageswara Sastry <nasastry@in.ibm.com>
> ---
> v2: - make qemu_flush_or_purge_queued_packets() extern and use it
>      - reworded reproducer paragraph in changelog
> ---
>   hw/net/virtio-net.c |    8 ++++++++
>   include/net/net.h   |    1 +
>   net/net.c           |    1 -
>   3 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 188744e17d57..e5ed35489380 100644
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
> @@ -445,6 +446,13 @@ static void virtio_net_reset(VirtIODevice *vdev)
>       memcpy(&n->mac[0], &n->nic->conf->macaddr, sizeof(n->mac));
>       qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
>       memset(n->vlans, 0, MAX_VLAN >> 3);
> +
> +    /* Flush any async TX */
> +    for (i =3D 0;  i < n->max_queues; i++) {
> +        NetClientState *nc =3D qemu_get_subqueue(n->nic, i);
> +        qemu_flush_or_purge_queued_packets(nc->peer, true);
> +        assert(!virtio_net_get_subqueue(nc)->async_tx.elem);
> +    }
>   }
>  =20
>   static void peer_test_vnet_hdr(VirtIONet *n)
> diff --git a/include/net/net.h b/include/net/net.h
> index a943e968a3dc..1f7341e4592b 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -153,6 +153,7 @@ ssize_t qemu_send_packet_async(NetClientState *nc, =
const uint8_t *buf,
>                                  int size, NetPacketSent *sent_cb);
>   void qemu_purge_queued_packets(NetClientState *nc);
>   void qemu_flush_queued_packets(NetClientState *nc);
> +void qemu_flush_or_purge_queued_packets(NetClientState *nc, bool purge=
);
>   void qemu_format_nic_info_str(NetClientState *nc, uint8_t macaddr[6])=
;
>   bool qemu_has_ufo(NetClientState *nc);
>   bool qemu_has_vnet_hdr(NetClientState *nc);
> diff --git a/net/net.c b/net/net.c
> index 5222e450698c..29f83983e55d 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -595,7 +595,6 @@ void qemu_purge_queued_packets(NetClientState *nc)
>       qemu_net_queue_purge(nc->peer->incoming_queue, nc);
>   }
>  =20
> -static
>   void qemu_flush_or_purge_queued_packets(NetClientState *nc, bool purg=
e)
>   {
>       nc->receive_disabled =3D 0;
>
>

Applied and queued for -stable.

Thanks
