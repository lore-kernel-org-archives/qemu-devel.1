Received: from eggs.gnu.org ([2001:4830:134:3::10]:35212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liujunjie23@huawei.com>) id 1g0n1B-0005qB-Ow
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 08:16:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liujunjie23@huawei.com>) id 1g0n17-0002Yn-1w
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 08:16:13 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2339 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liujunjie23@huawei.com>)
	id 1g0n16-0002SK-EL
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 08:16:08 -0400
From: "liujunjie (A)" <liujunjie23@huawei.com>
Date: Fri, 14 Sep 2018 12:15:50 +0000
Message-ID: <B526101FCAB4654DB0892B650DEFC5550870FE3C@DGGEMM501-MBX.china.huawei.com>
References: <20180908130448.24516-1-liujunjie23@huawei.com>
In-Reply-To: <20180908130448.24516-1-liujunjie23@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] clean up callback when del virtqueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>
Cc: "wangxin (U)" <wangxinxin.wang@huawei.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

ping

> -----Original Message-----
> From: liujunjie (A)
> Sent: Saturday, September 08, 2018 9:05 PM
> To: mst@redhat.com; jasowang@redhat.com
> Cc: wangxin (U) <wangxinxin.wang@huawei.com>; Zhoujian (jay)
> <jianjay.zhou@huawei.com>; Gonglei (Arei) <arei.gonglei@huawei.com>;
> Huangweidong (C) <weidong.huang@huawei.com>; qemu-devel@nongnu.org;
> liujunjie (A) <liujunjie23@huawei.com>
> Subject: [PATCH] clean up callback when del virtqueue
>=20
> Before, we did not clear callback like handle_output when delete the virt=
queue
> which may result be segmentfault.
> The scene is as follows:
> 1. Start a vm with multiqueue vhost-net, 2. then we write
> VIRTIO_PCI_GUEST_FEATURES in PCI configuration to triger multiqueue disab=
le
> in this vm which will delete the virtqueue.
> In this step, the tx_bh is deleted but the callback virtio_net_handle_tx_=
bh still
> exist.
> 3. Finally, we write VIRTIO_PCI_QUEUE_NOTIFY in PCI configuration to noti=
fy
> the deleted virtqueue. In this way, virtio_net_handle_tx_bh will be calle=
d and
> qemu will be crashed.
>=20
> Although the way described above is uncommon, we had better reinforce it.
>=20
> Signed-off-by: liujunjie <liujunjie23@huawei.com>
> ---
>  hw/net/virtio-net.c | 4 +++-
>  hw/virtio/virtio.c  | 3 +++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c index f154756..9bb=
20e3
> 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1467,7 +1467,9 @@ static void virtio_net_handle_tx_bh(VirtIODevice
> *vdev, VirtQueue *vq)
>          return;
>      }
>      virtio_queue_set_notification(vq, 0);
> -    qemu_bh_schedule(q->tx_bh);
> +    if (q->tx_bh) {
> +        qemu_bh_schedule(q->tx_bh);
> +    }
>  }
>=20
>  static void virtio_net_tx_timer(void *opaque) diff --git a/hw/virtio/vir=
tio.c
> b/hw/virtio/virtio.c index d4e4d98..7577518 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1604,6 +1604,9 @@ void virtio_del_queue(VirtIODevice *vdev, int n)
>=20
>      vdev->vq[n].vring.num =3D 0;
>      vdev->vq[n].vring.num_default =3D 0;
> +    vdev->vq[n].vring.align =3D 0;
> +    vdev->vq[n].handle_output =3D NULL;
> +    vdev->vq[n].handle_aio_output =3D NULL;
>  }
>=20
>  static void virtio_set_isr(VirtIODevice *vdev, int value)
> --
> 1.8.3.1
>=20
