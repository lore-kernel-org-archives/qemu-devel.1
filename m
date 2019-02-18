Received: from eggs.gnu.org ([209.51.188.92]:39975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gvdiG-0008QC-Tw
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 02:51:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gvdiD-0005Q0-0h
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 02:51:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gvdiC-0005GW-Bs
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 02:51:36 -0500
References: <1550118402-4057-1-git-send-email-wexu@redhat.com>
	<1550118402-4057-8-git-send-email-wexu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7d71fb88-2651-41eb-023e-63a11a83cd38@redhat.com>
Date: Mon, 18 Feb 2019 15:51:05 +0800
MIME-Version: 1.0
In-Reply-To: <1550118402-4057-8-git-send-email-wexu@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 07/11] virtio: fill/flush/pop for packed
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
Cc: mst@redhat.com, jfreiman@redhat.com, maxime.coquelin@redhat.com, tiwei.bie@intel.com


On 2019/2/14 =E4=B8=8B=E5=8D=8812:26, wexu@redhat.com wrote:
> From: Wei Xu <wexu@redhat.com>
>
> last_used_idx/wrap_counter should be equal to last_avail_idx/wrap_count=
er
> after a successful flush.
>
> Batching in vhost-net & dpdk testpmd is not equivalently supported in
> userspace backend, but a chained descriptors for Rx is similarly presen=
ted
> as a lightweight batch, so a write barrier is nailed only for the
> first(head) descriptor.
>
> Signed-off-by: Wei Xu <wexu@redhat.com>
> ---
>   hw/virtio/virtio.c | 291 ++++++++++++++++++++++++++++++++++++++++++++=
+++++----
>   1 file changed, 274 insertions(+), 17 deletions(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 832287b..7e276b4 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -379,6 +379,25 @@ static void vring_packed_desc_read(VirtIODevice *v=
dev, VRingPackedDesc *desc,
>       virtio_tswap16s(vdev, &desc->id);
>   }
>  =20
> +static void vring_packed_desc_write_data(VirtIODevice *vdev,
> +                    VRingPackedDesc *desc, MemoryRegionCache *cache, i=
nt i)
> +{
> +    virtio_tswap32s(vdev, &desc->len);
> +    virtio_tswap16s(vdev, &desc->id);
> +    address_space_write_cached(cache,
> +              i * sizeof(VRingPackedDesc) + offsetof(VRingPackedDesc, =
id),
> +              &desc->id, sizeof(desc->id));
> +    address_space_cache_invalidate(cache,
> +              i * sizeof(VRingPackedDesc) + offsetof(VRingPackedDesc, =
id),
> +              sizeof(desc->id));
> +    address_space_write_cached(cache,
> +              i * sizeof(VRingPackedDesc) + offsetof(VRingPackedDesc, =
len),
> +              &desc->len, sizeof(desc->len));
> +    address_space_cache_invalidate(cache,
> +              i * sizeof(VRingPackedDesc) + offsetof(VRingPackedDesc, =
len),
> +              sizeof(desc->len));
> +}
> +
>   static void vring_packed_desc_read_flags(VirtIODevice *vdev,
>                       VRingPackedDesc *desc, MemoryRegionCache *cache, =
int i)
>   {
> @@ -388,6 +407,18 @@ static void vring_packed_desc_read_flags(VirtIODev=
ice *vdev,
>       virtio_tswap16s(vdev, &desc->flags);
>   }
>  =20
> +static void vring_packed_desc_write_flags(VirtIODevice *vdev,
> +                    VRingPackedDesc *desc, MemoryRegionCache *cache, i=
nt i)
> +{
> +    virtio_tswap16s(vdev, &desc->flags);
> +    address_space_write_cached(cache,
> +              i * sizeof(VRingPackedDesc) + offsetof(VRingPackedDesc, =
flags),
> +              &desc->flags, sizeof(desc->flags));
> +    address_space_cache_invalidate(cache,
> +              i * sizeof(VRingPackedDesc) + offsetof(VRingPackedDesc, =
flags),
> +              sizeof(desc->flags));
> +}
> +
>   static inline bool is_desc_avail(struct VRingPackedDesc *desc,
>                                   bool wrap_counter)
>   {
> @@ -554,19 +585,11 @@ bool virtqueue_rewind(VirtQueue *vq, unsigned int=
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
> @@ -578,16 +601,71 @@ void virtqueue_fill(VirtQueue *vq, const VirtQueu=
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
> +    uint16_t head;
> +    VRingMemoryRegionCaches *caches;
> +    VRingPackedDesc desc =3D {
> +        .flags =3D 0,
> +        .id =3D elem->index,
> +        .len =3D len,
> +    };
> +    bool wrap_counter =3D vq->used_wrap_counter;
> +
> +    if (unlikely(!vq->vring.desc)) {
> +        return;
> +    }
> +
> +    head =3D vq->used_idx + idx;
> +    if (head >=3D vq->vring.num) {
> +        head -=3D vq->vring.num;
> +        wrap_counter ^=3D 1;
> +    }
> +    if (wrap_counter) {
> +        desc.flags |=3D (1 << VRING_PACKED_DESC_F_AVAIL);
> +        desc.flags |=3D (1 << VRING_PACKED_DESC_F_USED);
> +    } else {
> +        desc.flags &=3D ~(1 << VRING_PACKED_DESC_F_AVAIL);
> +        desc.flags &=3D ~(1 << VRING_PACKED_DESC_F_USED);
> +    }
> +
> +    caches =3D vring_get_region_caches(vq);
> +    vring_packed_desc_write_data(vq->vdev, &desc, &caches->desc, head)=
;
> +    if (idx =3D=3D 0) {
> +        /*
> +         * Make sure descriptor id and len is written before
> +         * flags for the first used buffer.
> +         */
> +        smp_wmb();
> +    }


I suspect you need to do this unconditionally since this function=20
doesn't do any batched writing to used ring. What it did is to write=20
used descriptors at idx. So there's no reason to supress wmb for the idx=20
!=3D 0. See its usage in virtio-net.c


> +
> +    vring_packed_desc_write_flags(vq->vdev, &desc, &caches->desc, head=
);
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
> @@ -603,6 +681,31 @@ void virtqueue_flush(VirtQueue *vq, unsigned int c=
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
> +    vq->used_idx =3D vq->last_avail_idx;
> +    vq->used_wrap_counter =3D vq->last_avail_wrap_counter;
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
> @@ -1077,7 +1180,7 @@ static void *virtqueue_alloc_element(size_t sz, u=
nsigned out_num, unsigned in_nu
>       return elem;
>   }
>  =20
> -void *virtqueue_pop(VirtQueue *vq, size_t sz)
> +static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
>   {
>       unsigned int i, head, max;
>       VRingMemoryRegionCaches *caches;
> @@ -1092,9 +1195,6 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
>       VRingDesc desc;
>       int rc;
>  =20
> -    if (unlikely(vdev->broken)) {
> -        return NULL;
> -    }
>       rcu_read_lock();
>       if (virtio_queue_empty_rcu(vq)) {
>           goto done;
> @@ -1212,6 +1312,163 @@ err_undo_map:
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
> +    uint16_t id;
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
> +
> +    head =3D vq->last_avail_idx;
> +    i =3D head;
> +
> +    caches =3D vring_get_region_caches(vq);
> +    cache =3D &caches->desc;
> +
> +    /* make sure flags is read before all the other fields */
> +    smp_rmb();
> +    vring_packed_desc_read(vdev, &desc, cache, i);
> +
> +    id =3D desc.id;
> +    if (desc.flags & VRING_DESC_F_INDIRECT) {
> +
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


This looks unnecessary, all indirect descriptor should be available now.


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


Do we allow chain more descriptors than vq size in the case of indirect?=20
According to the spec:

"

The device limits the number of descriptors in a list through a
transport-specific and/or device-specific value. If not limited,
the maximum number of descriptors in a list is the virt queue
size.
"

This looks possible, so the above is probably wrong if the max number of=20
chained descriptors is negotiated through a device specific way.


> +        }
> +
> +        if (cache =3D=3D &indirect_desc_cache) {
> +            if (i =3D=3D max) {
> +                break;
> +            }
> +            vring_packed_desc_read(vq->vdev, &desc, cache, i);
> +        } else if (desc.flags & VRING_DESC_F_NEXT) {
> +            vring_packed_desc_read(vq->vdev, &desc, cache, i);
> +        } else {
> +            break;
> +        }
> +    }
> +
> +    /* Now copy what we have collected and mapped */
> +    elem =3D virtqueue_alloc_element(sz, out_num, in_num);
> +    elem->index =3D id;
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
> +                          1 : elem_entries;
> +    if (vq->last_avail_idx >=3D vq->vring.num) {
> +        vq->last_avail_idx -=3D vq->vring.num;
> +        vq->last_avail_wrap_counter ^=3D 1;
> +    }
> +    vq->inuse++;
> +
> +    vq->shadow_avail_idx =3D vq->last_avail_idx;
> +    vq->avail_wrap_counter =3D vq->last_avail_wrap_counter;


It's better to name this to "shadow_avail_wrap_counter".

Thanks


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
> +    if (unlikely(vq->vdev->broken)) {
> +        return NULL;
> +    }
> +
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
