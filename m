Received: from eggs.gnu.org ([2001:4830:134:3::10]:48119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dE6lL-0006ud-FV
	for qemu-devel@nongnu.org; Fri, 26 May 2017 00:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dE6lG-00084J-GL
	for qemu-devel@nongnu.org; Fri, 26 May 2017 00:22:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dE6lG-00084B-73
	for qemu-devel@nongnu.org; Fri, 26 May 2017 00:22:02 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4094780B22
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 04:22:01 +0000 (UTC)
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
	<1495649128-10529-6-git-send-email-vyasevic@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <af25fa79-1f05-90eb-bd61-fc22d22a2629@redhat.com>
Date: Fri, 26 May 2017 12:21:50 +0800
MIME-Version: 1.0
In-Reply-To: <1495649128-10529-6-git-send-email-vyasevic@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/12] virtio-net: Allow qemu_announce_self
 to trigger virtio announcements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladislav Yasevich <vyasevic@redhat.com>, qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com
Cc: germano@redhat.com, lvivier@redhat.com, jdenemar@redhat.com, kashyap@redhat.com, armbru@redhat.com, mst@redhat.com



On 2017=E5=B9=B405=E6=9C=8825=E6=97=A5 02:05, Vladislav Yasevich wrote:
> Expose the virtio-net self annoucement capability and allow
> qemu_announce_self() to call it.
>
> Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
> ---
>   hw/net/virtio-net.c | 32 +++++++++++++++++++++++++++++---
>   1 file changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 1c65825..4adafbd 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -111,14 +111,38 @@ static bool virtio_net_started(VirtIONet *n, uint=
8_t status)
>           (n->status & VIRTIO_NET_S_LINK_UP) && vdev->vm_running;
>   }
>  =20
> +static void __virtio_net_announce(VirtIONet *net)
> +{
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(net);
> +
> +    net->status |=3D VIRTIO_NET_S_ANNOUNCE;
> +    virtio_notify_config(vdev);
> +}
> +
>   static void virtio_net_announce_timer(void *opaque)
>   {
>       VirtIONet *n =3D opaque;
> -    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
>  =20
>       n->announce_timer->round--;
> -    n->status |=3D VIRTIO_NET_S_ANNOUNCE;
> -    virtio_notify_config(vdev);
> +    __virtio_net_announce(n);
> +}
> +
> +static void virtio_net_announce(NetClientState *nc)
> +{
> +    VirtIONet *n =3D qemu_get_nic_opaque(nc);
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> +
> +    /* Make sure the virtio migration announcement timer isn't running
> +     * If it is, let it trigger announcement so that we do not cause
> +     * confusion.
> +     */
> +    if (n->announce_timer->round)
> +        return;
> +
> +    if (virtio_vdev_has_feature(vdev, VIRTIO_NET_F_GUEST_ANNOUNCE) &&
> +        virtio_vdev_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ)) {
> +            __virtio_net_announce(n);
> +    }
>   }
>  =20
>   static void virtio_net_vhost_status(VirtIONet *n, uint8_t status)
> @@ -1834,6 +1858,7 @@ static NetClientInfo net_virtio_info =3D {
>       .receive =3D virtio_net_receive,
>       .link_status_changed =3D virtio_net_set_link_status,
>       .query_rx_filter =3D virtio_net_query_rxfilter,
> +    .announce =3D virtio_net_announce,
>   };
>  =20
>   static bool virtio_net_guest_notifier_pending(VirtIODevice *vdev, int=
 idx)
> @@ -1941,6 +1966,7 @@ static void virtio_net_device_realize(DeviceState=
 *dev, Error **errp)
>       n->status =3D VIRTIO_NET_S_LINK_UP;
>       n->announce_timer =3D qemu_announce_timer_new(qemu_get_announce_p=
arams(),
>                                                   QEMU_CLOCK_VIRTUAL);
> +    n->announce_timer->round =3D 0;
>       n->announce_timer->tm =3D timer_new_ms(QEMU_CLOCK_VIRTUAL,
>                                             virtio_net_announce_timer, =
n);
>  =20

Reviewed-by: Jason Wang <jasowang@redhat.com>
