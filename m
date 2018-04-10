Received: from eggs.gnu.org ([2001:4830:134:3::10]:45108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f5ncm-0005TU-Qh
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 03:23:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f5nch-0008NZ-Pe
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 03:23:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41230 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1f5nch-0008NJ-JN
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 03:23:23 -0400
References: <1522846444-31725-1-git-send-email-wexu@redhat.com>
	<1522846444-31725-4-git-send-email-wexu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6a78b53a-0830-74de-5447-63ecab67e5ed@redhat.com>
Date: Tue, 10 Apr 2018 15:23:03 +0800
MIME-Version: 1.0
In-Reply-To: <1522846444-31725-4-git-send-email-wexu@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/8] virtio: add empty check for packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wexu@redhat.com, mst@redhat.com, tiwei.bie@intel.com, jfreimann@redhat.com, qemu-devel@nongnu.org



On 2018=E5=B9=B404=E6=9C=8804=E6=97=A5 20:53, wexu@redhat.com wrote:
> From: Wei Xu <wexu@redhat.com>
>
> helper for ring empty check.

And descriptor read.

>
> Signed-off-by: Wei Xu <wexu@redhat.com>
> ---
>   hw/virtio/virtio.c | 62 +++++++++++++++++++++++++++++++++++++++++++++=
++++++---
>   1 file changed, 59 insertions(+), 3 deletions(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 73a35a4..478df3d 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -24,6 +24,9 @@
>   #include "hw/virtio/virtio-access.h"
>   #include "sysemu/dma.h"
>  =20
> +#define AVAIL_DESC_PACKED(b) ((b) << 7)
> +#define USED_DESC_PACKED(b)  ((b) << 15)

Can we pass value other than 1 to this macro?

> +
>   /*
>    * The alignment to use between consumer and producer parts of vring.
>    * x86 pagesize again. This is the default, used by transports like P=
CI
> @@ -446,10 +449,27 @@ int virtio_queue_ready(VirtQueue *vq)
>       return vq->vring.avail !=3D 0;
>   }
>  =20
> +static void vring_desc_read_packed(VirtIODevice *vdev, VRingDescPacked=
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
> +static inline bool is_desc_avail(struct VRingDescPacked* desc)
> +{
> +    return (!!(desc->flags & AVAIL_DESC_PACKED(1)) !=3D
> +            !!(desc->flags & USED_DESC_PACKED(1)));

Don't we need to care about endian here?

> +}
> +
>   /* Fetch avail_idx from VQ memory only when we really need to know if
>    * guest has added some buffers.
>    * Called within rcu_read_lock().  */
> -static int virtio_queue_empty_rcu(VirtQueue *vq)
> +static int virtio_queue_empty_split_rcu(VirtQueue *vq)
>   {
>       if (unlikely(!vq->vring.avail)) {
>           return 1;
> @@ -462,7 +482,7 @@ static int virtio_queue_empty_rcu(VirtQueue *vq)
>       return vring_avail_idx(vq) =3D=3D vq->last_avail_idx;
>   }
>  =20
> -int virtio_queue_empty(VirtQueue *vq)
> +static int virtio_queue_empty_split(VirtQueue *vq)
>   {
>       bool empty;
>  =20
> @@ -480,6 +500,42 @@ int virtio_queue_empty(VirtQueue *vq)
>       return empty;
>   }
>  =20
> +static int virtio_queue_empty_packed_rcu(VirtQueue *vq)
> +{
> +    struct VRingDescPacked desc;
> +    VRingMemoryRegionCaches *cache;
> +
> +    if (unlikely(!vq->packed.desc)) {
> +        return 1;
> +    }
> +
> +    cache =3D vring_get_region_caches(vq);
> +    vring_desc_read_packed(vq->vdev, &desc, &cache->desc_packed, vq->l=
ast_avail_idx);
> +
> +    /* Make sure we see the updated flag */
> +    smp_mb();

What we need here is to make sure flag is read before all other fields,=20
looks like this barrier can't.

> +    return !is_desc_avail(&desc);
> +}
> +
> +static int virtio_queue_empty_packed(VirtQueue *vq)
> +{
> +    bool empty;
> +
> +    rcu_read_lock();
> +    empty =3D virtio_queue_empty_packed_rcu(vq);
> +    rcu_read_unlock();
> +    return empty;
> +}
> +
> +int virtio_queue_empty(VirtQueue *vq)
> +{
> +    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
> +        return virtio_queue_empty_packed(vq);
> +    } else {
> +        return virtio_queue_empty_split(vq);
> +    }
> +}
> +
>   static void virtqueue_unmap_sg(VirtQueue *vq, const VirtQueueElement =
*elem,
>                                  unsigned int len)
>   {
> @@ -951,7 +1007,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
>           return NULL;
>       }
>       rcu_read_lock();
> -    if (virtio_queue_empty_rcu(vq)) {
> +    if (virtio_queue_empty_split_rcu(vq)) {

I think you'd better have a switch inside virtio_queue_empty_rcu() like=20
virtio_queue_empty() here.

Thanks

>           goto done;
>       }
>       /* Needed after virtio_queue_empty(), see comment in
