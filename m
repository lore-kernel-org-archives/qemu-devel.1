Received: from eggs.gnu.org ([2001:4830:134:3::10]:42096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fQPI4-0001BY-Ch
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 23:39:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fQPI3-0005tf-8w
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 23:39:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59546 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fQPI3-0005tP-1l
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 23:39:15 -0400
References: <1528225683-11413-1-git-send-email-wexu@redhat.com>
	<1528225683-11413-7-git-send-email-wexu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b47bd06f-f140-454d-d862-74821cedddaa@redhat.com>
Date: Wed, 6 Jun 2018 11:39:00 +0800
MIME-Version: 1.0
In-Reply-To: <1528225683-11413-7-git-send-email-wexu@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 6/8] virtio: flush/push for packed ring
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



On 2018=E5=B9=B406=E6=9C=8806=E6=97=A5 03:08, wexu@redhat.com wrote:
> From: Wei Xu <wexu@redhat.com>
>
> Signed-off-by: Wei Xu <wexu@redhat.com>
> Signed-off-by: Wei Xu <wexu@redhat.com>
> ---
>   hw/virtio/virtio.c | 109 ++++++++++++++++++++++++++++++++++++++++++++=
++-------
>   1 file changed, 96 insertions(+), 13 deletions(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 0160d03..6f2da83 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -371,6 +371,21 @@ static void vring_packed_desc_read(VirtIODevice *v=
dev, VRingDescPacked *desc,
>       virtio_tswap16s(vdev, &desc->flags);
>   }
>  =20
> +static void vring_packed_desc_write(VirtIODevice *vdev, VRingDescPacke=
d *desc,
> +                            MemoryRegionCache *cache, int i)
> +{
> +    virtio_tswap64s(vdev, &desc->addr);
> +    virtio_tswap32s(vdev, &desc->len);
> +    virtio_tswap16s(vdev, &desc->id);
> +    virtio_tswap16s(vdev, &desc->flags);
> +    address_space_write_cached(cache,
> +                               sizeof(VRingDescPacked) * i, desc,
> +                               sizeof(VRingDescPacked));
> +    address_space_cache_invalidate(cache,
> +                                   sizeof(VRingDescPacked) * i,
> +                                   sizeof(VRingDescPacked));

Is there a guarantee that flags was wrote before all other fields?

> +}
> +
>   static inline bool is_desc_avail(struct VRingDescPacked *desc)
>   {
>       return !!(desc->flags & AVAIL_DESC_PACKED(1)) !=3D
> @@ -526,19 +541,11 @@ bool virtqueue_rewind(VirtQueue *vq, unsigned int=
 num)
>   }
>  =20
>   /* Called within rcu_read_lock().  */
> -void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
> +static void virtqueue_split_fill(VirtQueue *vq, const VirtQueueElement=
 *elem,
>                       unsigned int len, unsigned int idx)
>   {
>       VRingUsedElem uelem;
>  =20
> -    trace_virtqueue_fill(vq, elem, len, idx);
> -
> -    virtqueue_unmap_sg(vq, elem, len);
> -
> -    if (unlikely(vq->vdev->broken)) {
> -        return;
> -    }
> -
>       if (unlikely(!vq->vring.used)) {
>           return;
>       }
> @@ -550,16 +557,64 @@ void virtqueue_fill(VirtQueue *vq, const VirtQueu=
eElement *elem,
>       vring_used_write(vq, &uelem, idx);
>   }
>  =20
> -/* Called within rcu_read_lock().  */
> -void virtqueue_flush(VirtQueue *vq, unsigned int count)
> +static void virtqueue_packed_fill(VirtQueue *vq, const VirtQueueElemen=
t *elem,
> +                        unsigned int len, unsigned int idx)
>   {
> -    uint16_t old, new;
> +    uint16_t w, head;
> +    VRingMemoryRegionCaches *caches;
> +    VRingDescPacked desc =3D {
> +        .addr =3D 0,
> +        .flags =3D 0,
> +    };
> +
> +    if (unlikely(!vq->vring.desc)) {
> +        return;
> +    }
> +
> +    caches =3D vring_get_region_caches(vq);
> +    head =3D vq->used_idx + idx;
> +    head =3D head >=3D vq->vring.num ? (head - vq->vring.num) : head;
> +    vring_packed_desc_read(vq->vdev, &desc, &caches->desc, head);
> +
> +    w =3D (desc.flags & AVAIL_DESC_PACKED(1)) >> 7;
> +    desc.flags &=3D ~(AVAIL_DESC_PACKED(1) | USED_DESC_PACKED(1));
> +    desc.flags |=3D AVAIL_DESC_PACKED(w) | USED_DESC_PACKED(w);

Why need read descriptor here? We should set the used counter by our own=20
(e.g we have used_wrap_counter).

> +    if (!(desc.flags & VRING_DESC_F_INDIRECT)) {
> +        if (!(desc.flags & VRING_DESC_F_WRITE)) {
> +            desc.len =3D 0;
> +        } else {
> +            desc.len =3D len;
> +        }
> +    }
> +    vring_packed_desc_write(vq->vdev, &desc, &caches->desc, head);
> +
> +    /* Make sure flags has been updated */
> +    smp_mb();

This looks wrong, and if you think it's correct, you need a better=20
comment to explain, e.g how it was paired with other.

Thanks

> +}
> +
> +void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
> +                    unsigned int len, unsigned int idx)
> +{
> +    trace_virtqueue_fill(vq, elem, len, idx);
> +
> +    virtqueue_unmap_sg(vq, elem, len);
>  =20
>       if (unlikely(vq->vdev->broken)) {
> -        vq->inuse -=3D count;
>           return;
>       }
>  =20
> +    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
> +        virtqueue_packed_fill(vq, elem, len, idx);
> +    } else {
> +        virtqueue_split_fill(vq, elem, len, idx);
> +    }
> +}
> +
> +/* Called within rcu_read_lock().  */
> +static void virtqueue_split_flush(VirtQueue *vq, unsigned int count)
> +{
> +    uint16_t old, new;
> +
>       if (unlikely(!vq->vring.used)) {
>           return;
>       }
> @@ -575,6 +630,34 @@ void virtqueue_flush(VirtQueue *vq, unsigned int c=
ount)
>           vq->signalled_used_valid =3D false;
>   }
>  =20
> +static void virtqueue_packed_flush(VirtQueue *vq, unsigned int count)
> +{
> +    if (unlikely(!vq->vring.desc)) {
> +        return;
> +    }
> +
> +    vq->inuse -=3D count;
> +    vq->used_idx +=3D count;
> +    if (vq->used_idx >=3D vq->vring.num) {
> +        vq->used_idx -=3D vq->vring.num;
> +        vq->used_wrap_counter =3D !vq->used_wrap_counter;
> +    }
> +}
> +
> +void virtqueue_flush(VirtQueue *vq, unsigned int count)
> +{
> +    if (unlikely(vq->vdev->broken)) {
> +        vq->inuse -=3D count;
> +        return;
> +    }
> +
> +    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
> +        virtqueue_packed_flush(vq, count);
> +    } else {
> +        virtqueue_split_flush(vq, count);
> +    }
> +}
> +
>   void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
>                       unsigned int len)
>   {
