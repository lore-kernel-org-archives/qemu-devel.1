Received: from eggs.gnu.org ([2001:4830:134:3::10]:37458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fQOZa-0004sL-3s
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 22:53:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fQOZW-0000Jl-Vy
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 22:53:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60990 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fQOZW-0000JR-L3
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 22:53:14 -0400
References: <1528225683-11413-1-git-send-email-wexu@redhat.com>
	<1528225683-11413-3-git-send-email-wexu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0fc39c64-10d6-1d7f-5516-cb01cf85c79d@redhat.com>
Date: Wed, 6 Jun 2018 10:53:07 +0800
MIME-Version: 1.0
In-Reply-To: <1528225683-11413-3-git-send-email-wexu@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 2/8] virtio: memory cache for packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wexu@redhat.com, qemu-devel@nongnu.org
Cc: tiwei.bie@intel.com, mst@redhat.com, jfreimann@redhat.com



On 2018=E5=B9=B406=E6=9C=8806=E6=97=A5 03:07, wexu@redhat.com wrote:
> From: Wei Xu <wexu@redhat.com>
>
> Mostly reuse memory cache with 1.0 except for the offset calculation.
>
> Signed-off-by: Wei Xu <wexu@redhat.com>
> ---
>   hw/virtio/virtio.c | 29 ++++++++++++++++++++---------
>   1 file changed, 20 insertions(+), 9 deletions(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index e192a9a..f6c0689 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -150,11 +150,8 @@ static void virtio_init_region_cache(VirtIODevice =
*vdev, int n)
>       VRingMemoryRegionCaches *old =3D vq->vring.caches;
>       VRingMemoryRegionCaches *new;
>       hwaddr addr, size;
> -    int event_size;
>       int64_t len;
>  =20
> -    event_size =3D virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVE=
NT_IDX) ? 2 : 0;
> -
>       addr =3D vq->vring.desc;
>       if (!addr) {
>           return;
> @@ -168,7 +165,7 @@ static void virtio_init_region_cache(VirtIODevice *=
vdev, int n)
>           goto err_desc;
>       }
>  =20
> -    size =3D virtio_queue_get_used_size(vdev, n) + event_size;
> +    size =3D virtio_queue_get_used_size(vdev, n);
>       len =3D address_space_cache_init(&new->used, vdev->dma_as,
>                                      vq->vring.used, size, true);
>       if (len < size) {
> @@ -176,7 +173,7 @@ static void virtio_init_region_cache(VirtIODevice *=
vdev, int n)
>           goto err_used;
>       }
>  =20
> -    size =3D virtio_queue_get_avail_size(vdev, n) + event_size;
> +    size =3D virtio_queue_get_avail_size(vdev, n);
>       len =3D address_space_cache_init(&new->avail, vdev->dma_as,
>                                      vq->vring.avail, size, false);
>       if (len < size) {
> @@ -2320,14 +2317,28 @@ hwaddr virtio_queue_get_desc_size(VirtIODevice =
*vdev, int n)
>  =20
>   hwaddr virtio_queue_get_avail_size(VirtIODevice *vdev, int n)

I would rather rename this to virtio_queue_get_driver_size().

>   {
> -    return offsetof(VRingAvail, ring) +
> -        sizeof(uint16_t) * vdev->vq[n].vring.num;
> +    int s;
> +
> +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> +        return sizeof(struct VRingPackedDescEvent);
> +    } else {
> +        s =3D virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX) ?=
 2 : 0;
> +        return offsetof(VRingAvail, ring) +
> +            sizeof(uint16_t) * vdev->vq[n].vring.num + s;
> +    }
>   }
>  =20
>   hwaddr virtio_queue_get_used_size(VirtIODevice *vdev, int n)

virtio_queue_get_device_size().

Thanks

>   {
> -    return offsetof(VRingUsed, ring) +
> -        sizeof(VRingUsedElem) * vdev->vq[n].vring.num;
> +    int s;
> +
> +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> +        return sizeof(struct VRingPackedDescEvent);
> +    } else {
> +        s =3D virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX) ?=
 2 : 0;
> +        return offsetof(VRingUsed, ring) +
> +            sizeof(VRingUsedElem) * vdev->vq[n].vring.num + s;
> +    }
>   }
>  =20
>   uint16_t virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n)
