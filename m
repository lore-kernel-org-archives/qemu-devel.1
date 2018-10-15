Received: from eggs.gnu.org ([2001:4830:134:3::10]:44022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gBtr3-0001EZ-S8
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 23:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gBtr0-0007Gf-M5
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 23:47:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gBtr0-0007F1-DV
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 23:47:38 -0400
References: <1539266915-15216-1-git-send-email-wexu@redhat.com>
	<1539266915-15216-7-git-send-email-wexu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d0333d37-a06b-4c10-3892-5d7f4bb97f58@redhat.com>
Date: Mon, 15 Oct 2018 11:47:28 +0800
MIME-Version: 1.0
In-Reply-To: <1539266915-15216-7-git-send-email-wexu@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [[RFC v3 06/12] virtio: get avail bytes check for
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
Cc: tiwei.bie@intel.com, jfreimann@redhat.com, maxime.coquelin@redhat.com



On 2018=E5=B9=B410=E6=9C=8811=E6=97=A5 22:08, wexu@redhat.com wrote:
> From: Wei Xu <wexu@redhat.com>
>
> Same thought as 1.0 except a bit confused when trying to reuse
> 'shadow_avail_idx', so the interrelated new event_idx and the wrap
> counter for notifications has been introduced in previous patch.
>
> Signed-off-by: Wei Xu <wexu@redhat.com>
> ---
>   hw/virtio/virtio.c | 176 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++-
>   1 file changed, 173 insertions(+), 3 deletions(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 86f88da..13c6c98 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -375,6 +375,17 @@ int virtio_queue_ready(VirtQueue *vq)
>       return vq->vring.avail !=3D 0;
>   }
>  =20
> +static void vring_packed_desc_read(VirtIODevice *vdev, VRingPackedDesc=
 *desc,
> +                            MemoryRegionCache *cache, int i)
> +{
> +    address_space_read_cached(cache, i * sizeof(VRingPackedDesc),
> +                              desc, sizeof(VRingPackedDesc));
> +    virtio_tswap16s(vdev, &desc->flags);
> +    virtio_tswap64s(vdev, &desc->addr);
> +    virtio_tswap32s(vdev, &desc->len);
> +    virtio_tswap16s(vdev, &desc->id);
> +}
> +
>   static void vring_packed_desc_read_flags(VirtIODevice *vdev,
>                       VRingPackedDesc *desc, MemoryRegionCache *cache, =
int i)
>   {
> @@ -672,9 +683,9 @@ static int virtqueue_read_next_desc(VirtIODevice *v=
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
> @@ -797,6 +808,165 @@ err:
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
> +    VRingPackedDesc desc;
> +    bool wrap_counter;
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
> +    wrap_counter =3D vq->avail_wrap_counter;
> +    total_bufs =3D in_total =3D out_total =3D 0;
> +
> +    max =3D vq->vring.num;
> +    caches =3D vring_get_region_caches(vq);
> +    if (caches->desc.len < max * sizeof(VRingPackedDesc)) {
> +        virtio_error(vdev, "Cannot map descriptor ring");
> +        goto err;
> +    }

The above is mostly duplicated with split version. Can we unify them and=20
start the different version here?

> +
> +    desc_cache =3D &caches->desc;
> +    vring_packed_desc_read(vdev, &desc, desc_cache, idx);
> +    /* Make sure we see all the fields*/
> +    smp_rmb();

This looks strange. Do you want to make sure the flags were read before=20
other fields of descriptor?

You probably need a helper which did:

vring_packed_desc_read_flags(&desc)
if (is_desc_avail(&desc) {
 =C2=A0=C2=A0=C2=A0 smp_rmb();
 =C2=A0=C2=A0=C2=A0 return true;
}
return false;

> +    while (is_desc_avail(&desc, wrap_counter)) {
> +        unsigned int num_bufs;
> +        unsigned int i =3D 0;
> +
> +        num_bufs =3D total_bufs;
> +
> +        if (desc.flags & VRING_DESC_F_INDIRECT) {
> +            if (desc.len % sizeof(VRingPackedDesc)) {
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

Do we need to destroy desc cache here?

> +            }
> +
> +            max =3D desc.len / sizeof(VRingPackedDesc);
> +            num_bufs =3D i =3D 0;
> +            vring_packed_desc_read(vdev, &desc, desc_cache, i);
> +            /* Make sure we see all the fields*/
> +            smp_rmb();

All fields have already been read by us, why need this barrier?

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
> +                if (++i > vq->vring.num) {
> +                    virtio_error(vdev, "Looped descriptor");
> +                    goto err;
> +                }

This duplicates with the above num_bufs check I think? And it's better=20
to check them before the avail bytes calculation.

> +                vring_packed_desc_read(vdev, &desc, desc_cache, i);
> +            } else {
> +                if (++idx >=3D vq->vring.num) {
> +                    idx -=3D vq->vring.num;
> +                    wrap_counter =3D !wrap_counter;
> +                }
> +                vring_packed_desc_read(vdev, &desc, desc_cache, idx);
> +            }
> +            /* Make sure we see the flags */
> +            smp_rmb();

This is also suspicious. For commenting, we usually mention the order we=20
want like

"make sure XXX is read/write before YYY."

> +        } while (desc.flags & VRING_DESC_F_NEXT);

Why not implement a split version of virtqueue_read_next_desc() and hide=20
all e.g wrap counter & barrier stuffs there?

> +
> +        if (desc_cache =3D=3D &indirect_desc_cache) {
> +            address_space_cache_destroy(&indirect_desc_cache);
> +            total_bufs++;
> +            /* We missed one step on for indirect desc */
> +            idx++;
> +            if (++idx >=3D vq->vring.num) {
> +                idx -=3D vq->vring.num;
> +                wrap_counter =3D !wrap_counter;
> +            }
> +        } else {
> +            total_bufs =3D num_bufs;
> +        }
> +
> +        desc_cache =3D &caches->desc;
> +        vring_packed_desc_read(vdev, &desc, desc_cache, idx);
> +        /* Make sure we see all the fields */
> +        smp_rmb();

Need to better comment for explaining this barrier as well.

> +    }
> +
> +    /* Set up index and wrap counter for an interrupt when no enough d=
esc */

I don't get what did this mean?

Thanks

> +    vq->event_idx =3D idx;
> +    vq->event_wrap_counter =3D wrap_counter;
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
