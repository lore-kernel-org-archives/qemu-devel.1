Received: from eggs.gnu.org ([2001:4830:134:3::10]:43463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1g0nSu-0004r9-W9
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 08:44:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1g0nSq-0002OW-73
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 08:44:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1g0nSq-0002Mf-0i
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 08:44:48 -0400
References: <20180908130448.24516-1-liujunjie23@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <eda4b55d-5401-3a85-147e-d83742897343@redhat.com>
Date: Fri, 14 Sep 2018 20:44:30 +0800
MIME-Version: 1.0
In-Reply-To: <20180908130448.24516-1-liujunjie23@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] clean up callback when del virtqueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: liujunjie <liujunjie23@huawei.com>, mst@redhat.com
Cc: weidong.huang@huawei.com, wangxinxin.wang@huawei.com, qemu-devel@nongnu.org, arei.gonglei@huawei.com, jianjay.zhou@huawei.com



On 2018=E5=B9=B409=E6=9C=8808=E6=97=A5 21:04, liujunjie wrote:
> Before, we did not clear callback like handle_output when delete
> the virtqueue which may result be segmentfault.
> The scene is as follows:
> 1. Start a vm with multiqueue vhost-net,
> 2. then we write VIRTIO_PCI_GUEST_FEATURES in PCI configuration to
> triger multiqueue disable in this vm which will delete the virtqueue.
> In this step, the tx_bh is deleted but the callback virtio_net_handle_t=
x_bh
> still exist.
> 3. Finally, we write VIRTIO_PCI_QUEUE_NOTIFY in PCI configuration to
> notify the deleted virtqueue. In this way, virtio_net_handle_tx_bh
> will be called and qemu will be crashed.

Good catch.

>
> Although the way described above is uncommon, we had better reinforce i=
t.
>
> Signed-off-by: liujunjie <liujunjie23@huawei.com>
> ---
>   hw/net/virtio-net.c | 4 +++-
>   hw/virtio/virtio.c  | 3 +++
>   2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index f154756..9bb20e3 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1467,7 +1467,9 @@ static void virtio_net_handle_tx_bh(VirtIODevice =
*vdev, VirtQueue *vq)
>           return;
>       }
>       virtio_queue_set_notification(vq, 0);
> -    qemu_bh_schedule(q->tx_bh);
> +    if (q->tx_bh) {
> +        qemu_bh_schedule(q->tx_bh);
> +    }

I believe this is not necessary since handle_output is NULL now?

>   }
>  =20
>   static void virtio_net_tx_timer(void *opaque)
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index d4e4d98..7577518 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1604,6 +1604,9 @@ void virtio_del_queue(VirtIODevice *vdev, int n)
>  =20
>       vdev->vq[n].vring.num =3D 0;
>       vdev->vq[n].vring.num_default =3D 0;
> +    vdev->vq[n].vring.align =3D 0;

Is this related or fix for another bug?

Thanks

> +    vdev->vq[n].handle_output =3D NULL;
> +    vdev->vq[n].handle_aio_output =3D NULL;
>   }
>  =20
>   static void virtio_set_isr(VirtIODevice *vdev, int value)
