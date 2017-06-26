Received: from eggs.gnu.org ([2001:4830:134:3::10]:51653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dPKY6-0003wj-QY
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 23:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dPKY3-0005vn-K8
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 23:18:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dPKY3-0005vb-Ab
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 23:18:47 -0400
References: <1498185154-29015-1-git-send-email-wei.w.wang@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9c3402b1-961d-b953-ca6c-188b03ed756b@redhat.com>
Date: Mon, 26 Jun 2017 11:18:37 +0800
MIME-Version: 1.0
In-Reply-To: <1498185154-29015-1-git-send-email-wei.w.wang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/2] virtio-net: enable configurable tx
 queue size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>, mst@redhat.com, eblake@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Cc: stefanha@gmail.com, armbru@redhat.com, jan.scheurich@ericsson.com, marcandre.lureau@gmail.com, pbonzini@redhat.com



On 2017=E5=B9=B406=E6=9C=8823=E6=97=A5 10:32, Wei Wang wrote:
> This patch enables the virtio-net tx queue size to be configurable
> between 256 (the default queue size) and 1024 by the user when the
> vhost-user backend is used.
>
> Currently, the maximum tx queue size for other backends is 512 due
> to the following limitations:
> - QEMU backend: the QEMU backend implementation in some cases may
> send 1024+1 iovs to writev.
> - Vhost_net backend: there are possibilities that the guest sends
> a vring_desc of memory which corsses a MemoryRegion thereby
> generating more than 1024 iovs after translattion from guest-physical
> address in the backend.
>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>   hw/net/virtio-net.c            | 45 +++++++++++++++++++++++++++++++++=
---------
>   include/hw/virtio/virtio-net.h |  1 +
>   2 files changed, 37 insertions(+), 9 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 91eddaf..d13ca60 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -34,8 +34,11 @@
>  =20
>   /* previously fixed value */
>   #define VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE 256
> +#define VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE 256
> +
>   /* for now, only allow larger queues; with virtio-1, guest can downsi=
ze */
>   #define VIRTIO_NET_RX_QUEUE_MIN_SIZE VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE
> +#define VIRTIO_NET_TX_QUEUE_MIN_SIZE VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE
>  =20
>   /*
>    * Calculate the number of bytes up to and including the given 'field=
' of
> @@ -1508,15 +1511,18 @@ static void virtio_net_add_queue(VirtIONet *n, =
int index)
>  =20
>       n->vqs[index].rx_vq =3D virtio_add_queue(vdev, n->net_conf.rx_que=
ue_size,
>                                              virtio_net_handle_rx);
> +

Unnecessary whitespace change.

>       if (n->net_conf.tx && !strcmp(n->net_conf.tx, "timer")) {
>           n->vqs[index].tx_vq =3D
> -            virtio_add_queue(vdev, 256, virtio_net_handle_tx_timer);
> +            virtio_add_queue(vdev, n->net_conf.tx_queue_size,
> +                             virtio_net_handle_tx_timer);
>           n->vqs[index].tx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
>                                                 virtio_net_tx_timer,
>                                                 &n->vqs[index]);
>       } else {
>           n->vqs[index].tx_vq =3D
> -            virtio_add_queue(vdev, 256, virtio_net_handle_tx_bh);
> +            virtio_add_queue(vdev, n->net_conf.tx_queue_size,
> +                             virtio_net_handle_tx_bh);
>           n->vqs[index].tx_bh =3D qemu_bh_new(virtio_net_tx_bh, &n->vqs=
[index]);
>       }
>  =20
> @@ -1927,6 +1933,17 @@ static void virtio_net_device_realize(DeviceStat=
e *dev, Error **errp)
>           return;
>       }
>  =20
> +    if (n->net_conf.tx_queue_size < VIRTIO_NET_TX_QUEUE_MIN_SIZE ||
> +        n->net_conf.tx_queue_size > VIRTQUEUE_MAX_SIZE ||
> +        !is_power_of_2(n->net_conf.tx_queue_size)) {
> +        error_setg(errp, "Invalid tx_queue_size (=3D %" PRIu16 "), "
> +                   "must be a power of 2 between %d and %d",
> +                   n->net_conf.tx_queue_size, VIRTIO_NET_TX_QUEUE_MIN_=
SIZE,
> +                   VIRTQUEUE_MAX_SIZE);
> +        virtio_cleanup(vdev);
> +        return;
> +    }
> +
>       n->max_queues =3D MAX(n->nic_conf.peers.queues, 1);
>       if (n->max_queues * 2 + 1 > VIRTIO_QUEUE_MAX) {
>           error_setg(errp, "Invalid number of queues (=3D %" PRIu32 "),=
 "
> @@ -1947,17 +1964,11 @@ static void virtio_net_device_realize(DeviceSta=
te *dev, Error **errp)
>           error_report("Defaulting to \"bh\"");
>       }
>  =20
> -    for (i =3D 0; i < n->max_queues; i++) {
> -        virtio_net_add_queue(n, i);
> -    }
> -
> -    n->ctrl_vq =3D virtio_add_queue(vdev, 64, virtio_net_handle_ctrl);
>       qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);
>       memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
>       n->status =3D VIRTIO_NET_S_LINK_UP;
>       n->announce_timer =3D timer_new_ms(QEMU_CLOCK_VIRTUAL,
>                                        virtio_net_announce_timer, n);
> -

Unnecessary whitespace change.

>       if (n->netclient_type) {
>           /*
>            * Happen when virtio_net_set_netclient_name has been called.
> @@ -1968,6 +1979,21 @@ static void virtio_net_device_realize(DeviceStat=
e *dev, Error **errp)
>           n->nic =3D qemu_new_nic(&net_virtio_info, &n->nic_conf,
>                                 object_get_typename(OBJECT(dev)), dev->=
id, n);
>       }
> +    nc =3D qemu_get_queue(n->nic);
> +
> +    /*
> +     * Currently, backends other than vhost-user don't support 1024 qu=
eue
> +     * size.
> +     */
> +    if (n->net_conf.tx_queue_size =3D=3D VIRTQUEUE_MAX_SIZE &&
> +        nc->peer->info->type !=3D NET_CLIENT_DRIVER_VHOST_USER) {
> +        n->net_conf.tx_queue_size =3D VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE=
;

Do we really want assume all vhost-user backend support 1024 queue size?

> +    }
> +
> +    for (i =3D 0; i < n->max_queues; i++) {
> +        virtio_net_add_queue(n, i);
> +    }

Any reason to move virtio_net_add_queue() here?

> +    n->ctrl_vq =3D virtio_add_queue(vdev, 64, virtio_net_handle_ctrl);
>  =20
>       peer_test_vnet_hdr(n);
>       if (peer_has_vnet_hdr(n)) {
> @@ -1990,7 +2016,6 @@ static void virtio_net_device_realize(DeviceState=
 *dev, Error **errp)
>  =20
>       n->vlans =3D g_malloc0(MAX_VLAN >> 3);
>  =20
> -    nc =3D qemu_get_queue(n->nic);
>       nc->rxfilter_notify_enabled =3D 1;
>  =20
>       n->qdev =3D dev;
> @@ -2106,6 +2131,8 @@ static Property virtio_net_properties[] =3D {
>       DEFINE_PROP_STRING("tx", VirtIONet, net_conf.tx),
>       DEFINE_PROP_UINT16("rx_queue_size", VirtIONet, net_conf.rx_queue_=
size,
>                          VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE),
> +    DEFINE_PROP_UINT16("tx_queue_size", VirtIONet, net_conf.tx_queue_s=
ize,
> +                       VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE),
>       DEFINE_PROP_UINT16("host_mtu", VirtIONet, net_conf.mtu, 0),
>       DEFINE_PROP_BOOL("x-mtu-bypass-backend", VirtIONet, mtu_bypass_ba=
ckend,
>                        true),
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-=
net.h
> index 602b486..b81b6a4 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -36,6 +36,7 @@ typedef struct virtio_net_conf
>       int32_t txburst;
>       char *tx;
>       uint16_t rx_queue_size;
> +    uint16_t tx_queue_size;
>       uint16_t mtu;
>   } virtio_net_conf;
>  =20
