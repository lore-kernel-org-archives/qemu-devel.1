Received: from eggs.gnu.org ([2001:4830:134:3::10]:40787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gBw9F-0006pr-I9
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 02:14:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gBw9A-0004Wc-H2
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 02:14:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gBw96-00049h-Mr
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 02:14:30 -0400
References: <1539266915-15216-1-git-send-email-wexu@redhat.com>
	<1539266915-15216-8-git-send-email-wexu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <59562881-dba6-1843-9ebb-3f80a1d37e15@redhat.com>
Date: Mon, 15 Oct 2018 14:14:11 +0800
MIME-Version: 1.0
In-Reply-To: <1539266915-15216-8-git-send-email-wexu@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [[RFC v3 07/12] virtio: fill/flush/pop for packed
 ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wexu@redhat.com, qemu-devel@nongnu.org
Cc: tiwei.bie@intel.com, jfreimann@redhat.com, maxime.coquelin@redhat.com



On 2018=E5=B9=B410=E6=9C=8811=E6=97=A5 22:08, wexu@redhat.com wrote:
> From: Wei Xu <wexu@redhat.com>
>
> Signed-off-by: Wei Xu <wexu@redhat.com>
> ---
>   hw/virtio/virtio.c | 258 ++++++++++++++++++++++++++++++++++++++++++++=
++++++---
>   1 file changed, 244 insertions(+), 14 deletions(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 13c6c98..d12a7e3 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -386,6 +386,21 @@ static void vring_packed_desc_read(VirtIODevice *v=
dev, VRingPackedDesc *desc,
>       virtio_tswap16s(vdev, &desc->id);
>   }
>  =20
> +static void vring_packed_desc_write(VirtIODevice *vdev, VRingPackedDes=
c *desc,
> +                            MemoryRegionCache *cache, int i)
> +{
> +    virtio_tswap64s(vdev, &desc->addr);
> +    virtio_tswap32s(vdev, &desc->len);
> +    virtio_tswap16s(vdev, &desc->id);
> +    virtio_tswap16s(vdev, &desc->flags);
> +    address_space_write_cached(cache,
> +                               sizeof(VRingPackedDesc) * i, desc,
> +                               sizeof(VRingPackedDesc));
> +    address_space_cache_invalidate(cache,
> +                                   sizeof(VRingPackedDesc) * i,
> +                                   sizeof(VRingPackedDesc));
> +}
> +
>   static void vring_packed_desc_read_flags(VirtIODevice *vdev,
>                       VRingPackedDesc *desc, MemoryRegionCache *cache, =
int i)
>   {
> @@ -559,19 +574,11 @@ bool virtqueue_rewind(VirtQueue *vq, unsigned int=
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
> @@ -583,16 +590,64 @@ void virtqueue_fill(VirtQueue *vq, const VirtQueu=
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
> +    VRingPackedDesc desc =3D {
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

Is this a must for reading descriptor once more? Shouldn't device=20
maintain its own used_wrap_counter?

> +
> +    w =3D (desc.flags & AVAIL_DESC_PACKED(1)) >> 7;
> +    desc.flags &=3D ~(AVAIL_DESC_PACKED(1) | USED_DESC_PACKED(1));
> +    desc.flags |=3D AVAIL_DESC_PACKED(w) | USED_DESC_PACKED(w);
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

This is wrong in two places:

- What you want is to make sure flag was updated after all other fields,=20
you can do it in vring_packed_desc_write()
- A write barrier instead of a full barrier is needed.

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
> @@ -608,6 +663,33 @@ void virtqueue_flush(VirtQueue *vq, unsigned int c=
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
> @@ -1091,7 +1173,7 @@ static void *virtqueue_alloc_element(size_t sz, u=
nsigned out_num, unsigned in_nu
>       return elem;
>   }
>  =20
> -void *virtqueue_pop(VirtQueue *vq, size_t sz)
> +static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
>   {
>       unsigned int i, head, max;
>       VRingMemoryRegionCaches *caches;
> @@ -1226,6 +1308,154 @@ err_undo_map:
>       goto done;
>   }
>  =20
> +static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
> +{
> +    unsigned int i, head, max;
> +    VRingMemoryRegionCaches *caches;
> +    MemoryRegionCache indirect_desc_cache =3D MEMORY_REGION_CACHE_INVA=
LID;
> +    MemoryRegionCache *cache;
> +    int64_t len;
> +    VirtIODevice *vdev =3D vq->vdev;
> +    VirtQueueElement *elem =3D NULL;
> +    unsigned out_num, in_num, elem_entries;
> +    hwaddr addr[VIRTQUEUE_MAX_SIZE];
> +    struct iovec iov[VIRTQUEUE_MAX_SIZE];
> +    VRingPackedDesc desc;
> +
> +    if (unlikely(vdev->broken)) {
> +        return NULL;
> +    }
> +
> +    rcu_read_lock();
> +    if (virtio_queue_packed_empty_rcu(vq)) {
> +        goto done;
> +    }
> +
> +    /* When we start there are none of either input nor output. */
> +    out_num =3D in_num =3D elem_entries =3D 0;
> +
> +    max =3D vq->vring.num;
> +
> +    if (vq->inuse >=3D vq->vring.num) {
> +        virtio_error(vdev, "Virtqueue size exceeded");
> +        goto done;
> +    }

The above is duplicated with split version, please unify them.

> +
> +    head =3D vq->last_avail_idx;
> +    i =3D head;
> +
> +    caches =3D vring_get_region_caches(vq);
> +    cache =3D &caches->desc;
> +    vring_packed_desc_read(vdev, &desc, cache, i);
> +    /* Make sure we see all the fields*/
> +    smp_rmb();

This is wrong, as I've pointed out.

> +    if (desc.flags & VRING_DESC_F_INDIRECT) {
> +        if (desc.len % sizeof(VRingPackedDesc)) {
> +            virtio_error(vdev, "Invalid size for indirect buffer table=
");
> +            goto done;
> +        }
> +
> +        /* loop over the indirect descriptor table */
> +        len =3D address_space_cache_init(&indirect_desc_cache, vdev->d=
ma_as,
> +                                       desc.addr, desc.len, false);
> +        cache =3D &indirect_desc_cache;
> +        if (len < desc.len) {
> +            virtio_error(vdev, "Cannot map indirect buffer");
> +            goto done;
> +        }
> +
> +        max =3D desc.len / sizeof(VRingPackedDesc);
> +        i =3D 0;
> +        vring_packed_desc_read(vdev, &desc, cache, i);
> +        /* Make sure we see all the fields*/
> +        smp_rmb();
> +    }
> +
> +    /* Collect all the descriptors */
> +    while (1) {
> +        bool map_ok;
> +
> +        if (desc.flags & VRING_DESC_F_WRITE) {
> +            map_ok =3D virtqueue_map_desc(vdev, &in_num, addr + out_nu=
m,
> +                                        iov + out_num,
> +                                        VIRTQUEUE_MAX_SIZE - out_num, =
true,
> +                                        desc.addr, desc.len);
> +        } else {
> +            if (in_num) {
> +                virtio_error(vdev, "Incorrect order for descriptors");
> +                goto err_undo_map;
> +            }
> +            map_ok =3D virtqueue_map_desc(vdev, &out_num, addr, iov,
> +                                        VIRTQUEUE_MAX_SIZE, false,
> +                                        desc.addr, desc.len);
> +        }
> +        if (!map_ok) {
> +            goto err_undo_map;
> +        }
> +
> +        /* If we've got too many, that implies a descriptor loop. */
> +        if (++elem_entries > max) {
> +            virtio_error(vdev, "Looped descriptor");
> +            goto err_undo_map;
> +        }
> +
> +        if (++i >=3D vq->vring.num) {
> +            i -=3D vq->vring.num;
> +        }
> +
> +        if (desc.flags & VRING_DESC_F_NEXT) {
> +            vring_packed_desc_read(vq->vdev, &desc, cache, i);
> +            /* Make sure we see all the fields*/
> +            smp_rmb();

This looks unnecessary.

Thanks

> +        } else {
> +            break;
> +        }
> +    }
> +
> +    /* Now copy what we have collected and mapped */
> +    elem =3D virtqueue_alloc_element(sz, out_num, in_num);
> +    for (i =3D 0; i < out_num; i++) {
> +        elem->out_addr[i] =3D addr[i];
> +        elem->out_sg[i] =3D iov[i];
> +    }
> +    for (i =3D 0; i < in_num; i++) {
> +        elem->in_addr[i] =3D addr[head + out_num + i];
> +        elem->in_sg[i] =3D iov[out_num + i];
> +    }
> +
> +    vq->last_avail_idx +=3D (cache =3D=3D &indirect_desc_cache) ?
> +                          1 : out_num + in_num;
> +    if (vq->last_avail_idx >=3D vq->vring.num) {
> +        vq->last_avail_idx -=3D vq->vring.num;
> +        vq->avail_wrap_counter =3D !vq->avail_wrap_counter;
> +    }
> +    vq->inuse++;
> +
> +    vq->event_idx =3D vq->last_avail_idx;
> +    vq->event_wrap_counter =3D vq->avail_wrap_counter;
> +
> +    trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
> +done:
> +    address_space_cache_destroy(&indirect_desc_cache);
> +    rcu_read_unlock();
> +
> +    return elem;
> +
> +err_undo_map:
> +    virtqueue_undo_map_desc(out_num, in_num, iov);
> +    g_free(elem);
> +    goto done;
> +}
> +
> +void *virtqueue_pop(VirtQueue *vq, size_t sz)
> +{
> +    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
> +        return virtqueue_packed_pop(vq, sz);
> +    } else {
> +        return virtqueue_split_pop(vq, sz);
> +    }
> +}
> +
>   /* virtqueue_drop_all:
>    * @vq: The #VirtQueue
>    * Drops all queued buffers and indicates them to the guest
