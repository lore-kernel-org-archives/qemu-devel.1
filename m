Received: from eggs.gnu.org ([2001:4830:134:3::10]:40061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fQOyu-0003R2-0u
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 23:19:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fQOyo-0004K9-Vc
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 23:19:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40356 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fQOyo-0004Jx-Pm
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 23:19:22 -0400
References: <1528225683-11413-1-git-send-email-wexu@redhat.com>
	<1528225683-11413-5-git-send-email-wexu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c52aab11-2e0f-f551-5dfb-75d2931c4769@redhat.com>
Date: Wed, 6 Jun 2018 11:19:16 +0800
MIME-Version: 1.0
In-Reply-To: <1528225683-11413-5-git-send-email-wexu@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 4/8] virtio: get avail bytes check for
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
> mostly as same as 1.0 except traversing all desc to feed
> headcount, need a refactor.
>
> Signed-off-by: Wei Xu <wexu@redhat.com>
> ---
>   hw/virtio/virtio.c | 148 ++++++++++++++++++++++++++++++++++++++++++++=
+++++++--
>   1 file changed, 145 insertions(+), 3 deletions(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index bd669a2..cdbb5af 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -650,9 +650,9 @@ static int virtqueue_read_next_desc(VirtIODevice *v=
dev, VRingDesc *desc,
>       return VIRTQUEUE_READ_DESC_MORE;
>   }
>  =20
> -void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
> -                               unsigned int *out_bytes,
> -                               unsigned max_in_bytes, unsigned max_out=
_bytes)
> +static void virtqueue_split_get_avail_bytes(VirtQueue *vq,
> +                            unsigned int *in_bytes, unsigned int *out_=
bytes,
> +                            unsigned max_in_bytes, unsigned max_out_by=
tes)
>   {
>       VirtIODevice *vdev =3D vq->vdev;
>       unsigned int max, idx;
> @@ -775,6 +775,148 @@ err:
>       goto done;
>   }
>  =20
> +static void virtqueue_packed_get_avail_bytes(VirtQueue *vq,
> +                            unsigned int *in_bytes, unsigned int *out_=
bytes,
> +                            unsigned max_in_bytes, unsigned max_out_by=
tes)
> +{
> +    VirtIODevice *vdev =3D vq->vdev;
> +    unsigned int max, idx;
> +    unsigned int total_bufs, in_total, out_total;
> +    MemoryRegionCache *desc_cache;
> +    VRingMemoryRegionCaches *caches;
> +    MemoryRegionCache indirect_desc_cache =3D MEMORY_REGION_CACHE_INVA=
LID;
> +    int64_t len =3D 0;
> +    VRingDescPacked desc;
> +
> +    if (unlikely(!vq->vring.desc)) {
> +        if (in_bytes) {
> +            *in_bytes =3D 0;
> +        }
> +        if (out_bytes) {
> +            *out_bytes =3D 0;
> +        }
> +        return;
> +    }
> +
> +    rcu_read_lock();
> +    idx =3D vq->last_avail_idx;
> +    total_bufs =3D in_total =3D out_total =3D 0;
> +
> +    max =3D vq->vring.num;
> +    caches =3D vring_get_region_caches(vq);
> +    if (caches->desc.len < max * sizeof(VRingDescPacked)) {
> +        virtio_error(vdev, "Cannot map descriptor ring");
> +        goto err;
> +    }
> +
> +    desc_cache =3D &caches->desc;
> +    vring_packed_desc_read(vdev, &desc, desc_cache, idx);
> +    while (is_desc_avail(&desc)) {

So you did vring_packed_desc_read() like:

static void vring_packed_desc_read(VirtIODevice *vdev, VRingDescPacked=20
*desc,
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 MemoryRegionCache *cache, int i)
{
 =C2=A0=C2=A0=C2=A0 address_space_read_cached(cache, i * sizeof(VRingDesc=
Packed),
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 desc, sizeof(VRingDescPacked));
 =C2=A0=C2=A0=C2=A0 virtio_tswap64s(vdev, &desc->addr);
 =C2=A0=C2=A0=C2=A0 virtio_tswap32s(vdev, &desc->len);
 =C2=A0=C2=A0=C2=A0 virtio_tswap16s(vdev, &desc->id);
 =C2=A0=C2=A0=C2=A0 virtio_tswap16s(vdev, &desc->flags);
}

How do you guarantee desc->flags was read before all other fields?

> +        unsigned int num_bufs;
> +        unsigned int i;
> +
> +        num_bufs =3D total_bufs;
> +
> +        if (desc.flags & VRING_DESC_F_INDIRECT) {
> +            if (desc.len % sizeof(VRingDescPacked)) {
> +                virtio_error(vdev, "Invalid size for indirect buffer t=
able");
> +                goto err;
> +            }
> +
> +            /* If we've got too many, that implies a descriptor loop. =
*/
> +            if (num_bufs >=3D max) {
> +                virtio_error(vdev, "Looped descriptor");
> +                goto err;
> +            }
> +
> +            /* loop over the indirect descriptor table */
> +            len =3D address_space_cache_init(&indirect_desc_cache,
> +                                           vdev->dma_as,
> +                                           desc.addr, desc.len, false)=
;
> +            desc_cache =3D &indirect_desc_cache;
> +            if (len < desc.len) {
> +                virtio_error(vdev, "Cannot map indirect buffer");
> +                goto err;
> +            }
> +
> +            max =3D desc.len / sizeof(VRingDescPacked);
> +            num_bufs =3D i =3D 0;
> +            vring_packed_desc_read(vdev, &desc, desc_cache, i);
> +        }
> +
> +        do {
> +            /* If we've got too many, that implies a descriptor loop. =
*/
> +            if (++num_bufs > max) {
> +                virtio_error(vdev, "Looped descriptor");
> +                goto err;
> +            }
> +
> +            if (desc.flags & VRING_DESC_F_WRITE) {
> +                in_total +=3D desc.len;
> +            } else {
> +                out_total +=3D desc.len;
> +            }
> +            if (in_total >=3D max_in_bytes && out_total >=3D max_out_b=
ytes) {
> +                goto done;
> +            }
> +
> +            if (desc_cache =3D=3D &indirect_desc_cache) {
> +                if (++i >=3D vq->vring.num) {
> +                    i -=3D vq->vring.num;
> +                }
> +                vring_packed_desc_read(vdev, &desc, desc_cache, i);
> +            } else {
> +                if (++idx >=3D vq->vring.num) {
> +                    idx -=3D vq->vring.num;
> +                }
> +                vring_packed_desc_read(vdev, &desc, desc_cache, idx);
> +            }

Ok, so the difference is the index, can we use a single index instead of=20
two (i, idx) here?

> +            /* Make sure we see the flags */
> +            smp_mb();

Why need this?

Thanks

> +        } while (desc.flags & VRING_DESC_F_NEXT);
> +
> +        if (desc_cache =3D=3D &indirect_desc_cache) {
> +            address_space_cache_destroy(&indirect_desc_cache);
> +            total_bufs++;
> +            /* We missed one step on for indirect desc */
> +            idx++;
> +        } else {
> +            total_bufs =3D num_bufs;
> +        }
> +
> +        desc_cache =3D &caches->desc;
> +        vring_packed_desc_read(vdev, &desc, desc_cache, idx % vq->vrin=
g.num);
> +    }
> +
> +done:
> +    address_space_cache_destroy(&indirect_desc_cache);
> +    if (in_bytes) {
> +        *in_bytes =3D in_total;
> +    }
> +    if (out_bytes) {
> +        *out_bytes =3D out_total;
> +    }
> +    rcu_read_unlock();
> +    return;
> +
> +err:
> +    in_total =3D out_total =3D 0;
> +    goto done;
> +}
> +
> +void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
> +                               unsigned int *out_bytes,
> +                               unsigned max_in_bytes, unsigned max_out=
_bytes)
> +{
> +    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
> +        virtqueue_packed_get_avail_bytes(vq, in_bytes, out_bytes,
> +                                         max_in_bytes, max_out_bytes);
> +    } else {
> +        virtqueue_split_get_avail_bytes(vq, in_bytes, out_bytes,
> +                                        max_in_bytes, max_out_bytes);
> +    }
> +}
> +
>   int virtqueue_avail_bytes(VirtQueue *vq, unsigned int in_bytes,
>                             unsigned int out_bytes)
>   {
