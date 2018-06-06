Received: from eggs.gnu.org ([2001:4830:134:3::10]:39356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fQOpQ-0000s2-Ed
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 23:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fQOpM-000803-Fc
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 23:09:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58776 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fQOpM-0007zQ-AL
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 23:09:36 -0400
References: <1528225683-11413-1-git-send-email-wexu@redhat.com>
	<1528225683-11413-4-git-send-email-wexu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7693b240-762c-12c5-1157-3970f84f9a2f@redhat.com>
Date: Wed, 6 Jun 2018 11:09:29 +0800
MIME-Version: 1.0
In-Reply-To: <1528225683-11413-4-git-send-email-wexu@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 3/8] virtio: empty check and desc read for
 packed ring
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
> helper for ring empty check and descriptor read.
>
> Signed-off-by: Wei Xu <wexu@redhat.com>
> ---
>   hw/virtio/virtio.c | 62 +++++++++++++++++++++++++++++++++++++++++++++=
++++++---
>   1 file changed, 59 insertions(+), 3 deletions(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index f6c0689..bd669a2 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -24,6 +24,9 @@
>   #include "hw/virtio/virtio-access.h"
>   #include "sysemu/dma.h"
>  =20
> +#define AVAIL_DESC_PACKED(b) ((b) << 7)
> +#define USED_DESC_PACKED(b)  ((b) << 15)
> +
>   /*
>    * The alignment to use between consumer and producer parts of vring.
>    * x86 pagesize again. This is the default, used by transports like P=
CI
> @@ -357,10 +360,27 @@ int virtio_queue_ready(VirtQueue *vq)
>       return vq->vring.avail !=3D 0;
>   }
>  =20
> +static void vring_packed_desc_read(VirtIODevice *vdev, VRingDescPacked=
 *desc,
> +                            MemoryRegionCache *cache, int i)
> +{
> +    address_space_read_cached(cache, i * sizeof(VRingDescPacked),
> +                              desc, sizeof(VRingDescPacked));
> +    virtio_tswap64s(vdev, &desc->addr);
> +    virtio_tswap32s(vdev, &desc->len);
> +    virtio_tswap16s(vdev, &desc->id);
> +    virtio_tswap16s(vdev, &desc->flags);
> +}
> +
> +static inline bool is_desc_avail(struct VRingDescPacked *desc)
> +{
> +    return !!(desc->flags & AVAIL_DESC_PACKED(1)) !=3D
> +            !!(desc->flags & USED_DESC_PACKED(1));
> +}

See spec and the discussion in the past for vhost patches:

"""
Thus VIRTQ_DESC_F_AVAIL and VIRTQ_DESC_F_USED bits are different for an=20
available descriptor and
equal for a used descriptor.
Note that this observation is mostly useful for sanity-checking as these=20
are necessary but not sufficient
conditions - for example, all descriptors are zero-initialized. To=20
detect used and available descriptors it is
possible for drivers and devices to keep track of the last observed=20
value of VIRTQ_DESC_F_USED/VIRTQ_-
DESC_F_AVAIL. Other techniques to detect=20
VIRTQ_DESC_F_AVAIL/VIRTQ_DESC_F_USED bit changes
might also be possible.
"""

This may not work especially consider we may do migration or savevm/loadv=
m.

> +
>   /* Fetch avail_idx from VQ memory only when we really need to know if
>    * guest has added some buffers.
>    * Called within rcu_read_lock().  */
> -static int virtio_queue_empty_rcu(VirtQueue *vq)
> +static int virtio_queue_split_empty_rcu(VirtQueue *vq)
>   {
>       if (unlikely(!vq->vring.avail)) {
>           return 1;
> @@ -373,7 +393,7 @@ static int virtio_queue_empty_rcu(VirtQueue *vq)
>       return vring_avail_idx(vq) =3D=3D vq->last_avail_idx;
>   }
>  =20
> -int virtio_queue_empty(VirtQueue *vq)
> +static int virtio_queue_split_empty(VirtQueue *vq)
>   {
>       bool empty;
>  =20
> @@ -391,6 +411,42 @@ int virtio_queue_empty(VirtQueue *vq)
>       return empty;
>   }
>  =20
> +static int virtio_queue_packed_empty_rcu(VirtQueue *vq)
> +{
> +    struct VRingDescPacked desc;
> +    VRingMemoryRegionCaches *cache;
> +
> +    if (unlikely(!vq->vring.desc)) {
> +        return 1;
> +    }
> +
> +    cache =3D vring_get_region_caches(vq);
> +    vring_packed_desc_read(vq->vdev, &desc, &cache->desc, vq->last_ava=
il_idx);
> +

I believe only we only care flag here.

> +    /* Make sure we see the updated flag */
> +    smp_mb();

Why need this?

Note there's a smp_rmb() after virtio_queue_empty_rcu() in virtquue_pop()=
.

> +    return !is_desc_avail(&desc);
> +}
> +
> +static int virtio_queue_packed_empty(VirtQueue *vq)
> +{
> +    bool empty;
> +
> +    rcu_read_lock();
> +    empty =3D virtio_queue_packed_empty_rcu(vq);
> +    rcu_read_unlock();
> +    return empty;
> +}
> +
> +int virtio_queue_empty(VirtQueue *vq)
> +{
> +    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
> +        return virtio_queue_packed_empty(vq);
> +    } else {
> +        return virtio_queue_split_empty(vq);
> +    }
> +}
> +
>   static void virtqueue_unmap_sg(VirtQueue *vq, const VirtQueueElement =
*elem,
>                                  unsigned int len)
>   {
> @@ -862,7 +918,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
>           return NULL;
>       }
>       rcu_read_lock();
> -    if (virtio_queue_empty_rcu(vq)) {
> +    if (virtio_queue_split_empty_rcu(vq)) {

This is meaningless unless you rename virtqueue_pop to=20
virtqueue_pop_split and call it only for split ring.

Thanks

>           goto done;
>       }
>       /* Needed after virtio_queue_empty(), see comment in
