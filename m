Received: from eggs.gnu.org ([2001:4830:134:3::10]:40992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fQP9I-0006tA-4V
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 23:30:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fQP9E-0000vG-R1
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 23:30:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42028 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fQP9E-0000uj-LC
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 23:30:08 -0400
References: <1528225683-11413-1-git-send-email-wexu@redhat.com>
	<1528225683-11413-6-git-send-email-wexu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f94057e1-5d6f-c90d-5b21-d1cd561d6d53@redhat.com>
Date: Wed, 6 Jun 2018 11:29:54 +0800
MIME-Version: 1.0
In-Reply-To: <1528225683-11413-6-git-send-email-wexu@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 5/8] virtio: queue pop for packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wexu@redhat.com, qemu-devel@nongnu.org
Cc: jfreimann@redhat.com, tiwei.bie@intel.com, mst@redhat.com



On 2018=E5=B9=B406=E6=9C=8806=E6=97=A5 03:08, wexu@redhat.com wrote:
> From: Wei Xu <wexu@redhat.com>
>
> Signed-off-by: Wei Xu <wexu@redhat.com>
> ---
>   hw/virtio/virtio.c | 145 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++-
>   1 file changed, 144 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index cdbb5af..0160d03 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1041,7 +1041,7 @@ static void *virtqueue_alloc_element(size_t sz, u=
nsigned out_num, unsigned in_nu
>       return elem;
>   }
>  =20
> -void *virtqueue_pop(VirtQueue *vq, size_t sz)
> +static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
>   {
>       unsigned int i, head, max;
>       VRingMemoryRegionCaches *caches;
> @@ -1176,6 +1176,149 @@ err_undo_map:
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
> +    VRingDescPacked desc;
> +
> +    if (unlikely(vdev->broken)) {
> +        return NULL;
> +    }
> +
> +    rcu_read_lock();
> +    if (virtio_queue_packed_empty_rcu(vq)) {
> +        goto done;
> +    }

Instead of depending on the barriers inside=20
virtio_queue_packed_empty_rcu(). I think it's better to keep a smp_rmb()=20
here with comments.

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
> +    if (virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
> +        /* FIXME: TBD */
> +    }

This part could be removed.

> +
> +    head =3D vq->last_avail_idx;
> +    i =3D head;
> +
> +    caches =3D vring_get_region_caches(vq);
> +    cache =3D &caches->desc;
> +    vring_packed_desc_read(vdev, &desc, cache, i);

I think we'd better find a way to avoid reading descriptor twice.

Thanks

> +    if (desc.flags & VRING_DESC_F_INDIRECT) {
> +        if (desc.len % sizeof(VRingDescPacked)) {
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
> +        max =3D desc.len / sizeof(VRingDescPacked);
> +        i =3D 0;
> +        vring_packed_desc_read(vdev, &desc, cache, i);
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
