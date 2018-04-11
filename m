Received: from eggs.gnu.org ([2001:4830:134:3::10]:51299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f65yJ-000593-Pn
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 22:58:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f65yG-0003Re-Lw
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 22:58:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37318 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1f65yG-0003RH-GJ
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 22:58:52 -0400
References: <1522846444-31725-1-git-send-email-wexu@redhat.com>
	<1522846444-31725-7-git-send-email-wexu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7629facd-d005-6248-4cb8-12720ff248db@redhat.com>
Date: Wed, 11 Apr 2018 10:58:30 +0800
MIME-Version: 1.0
In-Reply-To: <1522846444-31725-7-git-send-email-wexu@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/8] virtio: flush/push support for packed
 ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wexu@redhat.com, mst@redhat.com, tiwei.bie@intel.com, jfreimann@redhat.com, qemu-devel@nongnu.org



On 2018=E5=B9=B404=E6=9C=8804=E6=97=A5 20:54, wexu@redhat.com wrote:
> From: Wei Xu <wexu@redhat.com>
>
> Signed-off-by: Wei Xu <wexu@redhat.com>
> ---
>   hw/virtio/virtio.c | 104 ++++++++++++++++++++++++++++++++++++++++++++=
+--------
>   1 file changed, 90 insertions(+), 14 deletions(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 95a4681..def07c6 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -26,6 +26,7 @@
>  =20
>   #define AVAIL_DESC_PACKED(b) ((b) << 7)
>   #define USED_DESC_PACKED(b)  ((b) << 15)
> +#define VIRTQ_F_DESC_USED(w)  (AVAIL_DESC_PACKED(w) | USED_DESC_PACKED=
(w))
>  =20
>   /*
>    * The alignment to use between consumer and producer parts of vring.
> @@ -636,19 +637,11 @@ bool virtqueue_rewind(VirtQueue *vq, unsigned int=
 num)
>   }
>  =20
>   /* Called within rcu_read_lock().  */
> -void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
> +static void virtqueue_fill_split(VirtQueue *vq, const VirtQueueElement=
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
> @@ -660,16 +653,66 @@ void virtqueue_fill(VirtQueue *vq, const VirtQueu=
eElement *elem,
>       vring_used_write(vq, &uelem, idx);
>   }
>  =20
> -/* Called within rcu_read_lock().  */
> -void virtqueue_flush(VirtQueue *vq, unsigned int count)
> +static void virtqueue_fill_packed(VirtQueue *vq, const VirtQueueElemen=
t *elem)
>   {
> -    uint16_t old, new;
> +    uint16_t i, w, head;
> +    VRingMemoryRegionCaches *caches;
> +    VRingDescPacked desc =3D {
> +        .addr =3D 0,
> +        .flags =3D 0,
> +    };
> +
> +    if (unlikely(!vq->packed.desc)) {
> +        return;
> +    }
> +
> +    w =3D elem->wrap_counter;
> +    caches =3D vring_get_region_caches(vq);
> +    for (i =3D 0; i < elem->count; i++) {
> +        head =3D (elem->index + i) % vq->packed.num;

This looks strange, we should get the location from vq->used_idx.

> +        /* Don't toggle the first one since it is the originally one *=
/
> +        if ((i > 0) && (!head)) {
> +            w ^=3D 1;
> +        }
> +
> +        desc.id =3D elem->index;
> +        desc.flags =3D VIRTQ_F_DESC_USED(w);
> +        desc.len =3D elem->len[i];

This should be determined by the caller, especially for the WRITE=20
descriptor.

> +        virtio_tswap16s(vq->vdev, &desc.id);
> +        virtio_tswap32s(vq->vdev, &desc.len);
> +        virtio_tswap16s(vq->vdev, &desc.flags);
> +        address_space_write_cached(&caches->desc,
> +                                   sizeof(VRingDescPacked) * head, &de=
sc,
> +                                   sizeof(VRingDescPacked));

We should make sure flags is written after other fileds. So need a wmb()=20
between the two writes.

> +        address_space_cache_invalidate(&caches->desc,
> +                                       sizeof(VRingDescPacked) * head,
> +                                       sizeof(VRingDescPacked));
> +    }

Have you tested the case when elem->count is greater than one? According=20
to the spec device only need to write a single used descriptor for the=20
whole list.

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
> +        virtqueue_fill_packed(vq, elem);
> +    } else {
> +        virtqueue_fill_split(vq, elem, len, idx);
> +    }
> +}
> +
> +/* Called within rcu_read_lock().  */
> +static void virtqueue_flush_split(VirtQueue *vq, unsigned int count)
> +{
> +    uint16_t old, new;
> +
>       if (unlikely(!vq->vring.used)) {
>           return;
>       }
> @@ -685,12 +728,45 @@ void virtqueue_flush(VirtQueue *vq, unsigned int =
count)
>           vq->signalled_used_valid =3D false;
>   }
>  =20
> +static void virtqueue_flush_packed(VirtQueue *vq, unsigned int count)
> +{
> +    if (unlikely(!vq->packed.desc)) {
> +        return;
> +    }
> +
> +    vq->inuse -=3D count;
> +
> +    /* FIXME: is this correct? */
> +    if (vq->inuse) {
> +        return;
> +    }

I think the semantics here is write flags here.

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
> +        virtqueue_flush_packed(vq, count);
> +    } else {
> +        virtqueue_flush_split(vq, count);
> +    }
> +}
> +
>   void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
>                       unsigned int len)
>   {
>       rcu_read_lock();
>       virtqueue_fill(vq, elem, len, 0);
> -    virtqueue_flush(vq, 1);
> +    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
> +        /* FIXME: How to deal with the length field for chained desc *=
/
> +        virtqueue_flush(vq, elem->count);
> +    } else {
> +        virtqueue_flush(vq, 1);
> +    }
>       rcu_read_unlock();
>   }
>  =20

Thanks
