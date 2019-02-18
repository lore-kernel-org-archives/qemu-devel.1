Received: from eggs.gnu.org ([209.51.188.92]:46622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gvmRU-0008NO-VT
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 12:10:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gvmRS-0006KN-Ur
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 12:10:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gvmRM-0006An-L2
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 12:10:50 -0500
Date: Tue, 19 Feb 2019 01:07:25 +0800
From: Wei Xu <wexu@redhat.com>
Message-ID: <20190218170725.GB28793@wei-ubt>
References: <1550118402-4057-1-git-send-email-wexu@redhat.com>
	<1550118402-4057-7-git-send-email-wexu@redhat.com>
	<e847bd20-e6be-758c-4163-bb28ad4be7f5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e847bd20-e6be-758c-4163-bb28ad4be7f5@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 06/11] virtio: get avail bytes check for
 packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, tiwei.bie@intel.com, jfreiman@redhat.com, mst@redhat.com

On Mon, Feb 18, 2019 at 03:27:21PM +0800, Jason Wang wrote:
>=20
> On 2019/2/14 =E4=B8=8B=E5=8D=8812:26, wexu@redhat.com wrote:
> >From: Wei Xu <wexu@redhat.com>
> >
> >Add packed ring headcount check.
> >
> >Common part of split/packed ring are kept.
> >
> >Signed-off-by: Wei Xu <wexu@redhat.com>
> >---
> >  hw/virtio/virtio.c | 197 +++++++++++++++++++++++++++++++++++++++++++=
+++++-----
> >  1 file changed, 179 insertions(+), 18 deletions(-)
> >
> >diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >index f2ff980..832287b 100644
> >--- a/hw/virtio/virtio.c
> >+++ b/hw/virtio/virtio.c
> >@@ -368,6 +368,17 @@ int virtio_queue_ready(VirtQueue *vq)
> >      return vq->vring.avail !=3D 0;
> >  }
> >+static void vring_packed_desc_read(VirtIODevice *vdev, VRingPackedDes=
c *desc,
> >+                            MemoryRegionCache *cache, int i)
> >+{
> >+    address_space_read_cached(cache, i * sizeof(VRingPackedDesc),
> >+                              desc, sizeof(VRingPackedDesc));
> >+    virtio_tswap16s(vdev, &desc->flags);
> >+    virtio_tswap64s(vdev, &desc->addr);
> >+    virtio_tswap32s(vdev, &desc->len);
> >+    virtio_tswap16s(vdev, &desc->id);
> >+}
> >+
> >  static void vring_packed_desc_read_flags(VirtIODevice *vdev,
> >                      VRingPackedDesc *desc, MemoryRegionCache *cache,=
 int i)
> >  {
> >@@ -667,9 +678,9 @@ static int virtqueue_read_next_desc(VirtIODevice *=
vdev, VRingDesc *desc,
> >      return VIRTQUEUE_READ_DESC_MORE;
> >  }
> >-void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
> >-                               unsigned int *out_bytes,
> >-                               unsigned max_in_bytes, unsigned max_ou=
t_bytes)
> >+static void virtqueue_split_get_avail_bytes(VirtQueue *vq,
> >+                            unsigned int *in_bytes, unsigned int *out=
_bytes,
> >+                            unsigned max_in_bytes, unsigned max_out_b=
ytes)
> >  {
> >      VirtIODevice *vdev =3D vq->vdev;
> >      unsigned int max, idx;
> >@@ -679,27 +690,12 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, un=
signed int *in_bytes,
> >      int64_t len =3D 0;
> >      int rc;
> >-    if (unlikely(!vq->vring.desc)) {
> >-        if (in_bytes) {
> >-            *in_bytes =3D 0;
> >-        }
> >-        if (out_bytes) {
> >-            *out_bytes =3D 0;
> >-        }
> >-        return;
> >-    }
> >-
> >      rcu_read_lock();
> >      idx =3D vq->last_avail_idx;
> >      total_bufs =3D in_total =3D out_total =3D 0;
> >      max =3D vq->vring.num;
> >      caches =3D vring_get_region_caches(vq);
> >-    if (caches->desc.len < max * sizeof(VRingDesc)) {
> >-        virtio_error(vdev, "Cannot map descriptor ring");
> >-        goto err;
> >-    }
> >-
> >      while ((rc =3D virtqueue_num_heads(vq, idx)) > 0) {
> >          MemoryRegionCache *desc_cache =3D &caches->desc;
> >          unsigned int num_bufs;
> >@@ -792,6 +788,171 @@ err:
> >      goto done;
> >  }
> >+static void virtqueue_packed_get_avail_bytes(VirtQueue *vq,
> >+                            unsigned int *in_bytes, unsigned int *out=
_bytes,
> >+                            unsigned max_in_bytes, unsigned max_out_b=
ytes)
> >+{
> >+    VirtIODevice *vdev =3D vq->vdev;
> >+    unsigned int max, idx;
> >+    unsigned int total_bufs, in_total, out_total;
> >+    MemoryRegionCache *desc_cache;
> >+    VRingMemoryRegionCaches *caches;
> >+    MemoryRegionCache indirect_desc_cache =3D MEMORY_REGION_CACHE_INV=
ALID;
> >+    int64_t len =3D 0;
> >+    VRingPackedDesc desc;
> >+    bool wrap_counter;
> >+
> >+    rcu_read_lock();
> >+    idx =3D vq->last_avail_idx;
> >+    wrap_counter =3D vq->last_avail_wrap_counter;
> >+    total_bufs =3D in_total =3D out_total =3D 0;
> >+
> >+    max =3D vq->vring.num;
> >+    caches =3D vring_get_region_caches(vq);
> >+    desc_cache =3D &caches->desc;
> >+    vring_packed_desc_read_flags(vdev, &desc, desc_cache, idx);
> >+    while (is_desc_avail(&desc, wrap_counter)) {
> >+        unsigned int num_bufs;
> >+        unsigned int i =3D 0;
> >+
> >+        num_bufs =3D total_bufs;
> >+
> >+        /* Make sure flags has been read before all the fields. */
> >+        smp_rmb();
> >+        vring_packed_desc_read(vdev, &desc, desc_cache, idx);
>=20
>=20
> It's better to have single function to deal with reading flags and
> descriptors and check its availability like packed ring.

There is something different between split and packed ring here.
For split ring, 'avail_idx' and descriptor are separately used so the
interfaces of them are straightforward, while the flag and data fields
of the descriptors for packed ring are mixed and independent accesses to
them have been brought in, it is good to use them as what they are suppos=
ed
to work. :)

Another neat way is to pack the two operations to a new one, but it would
introduce memory cache parameter passing.

So personally I prefer to keep it unchanged, still want to sort it out?

>=20
>=20
> >+
> >+        if (desc.flags & VRING_DESC_F_INDIRECT) {
> >+            if (desc.len % sizeof(VRingPackedDesc)) {
> >+                virtio_error(vdev, "Invalid size for indirect buffer =
table");
> >+                goto err;
> >+            }
> >+
> >+            /* If we've got too many, that implies a descriptor loop.=
 */
> >+            if (num_bufs >=3D max) {
> >+                virtio_error(vdev, "Looped descriptor");
> >+                goto err;
> >+            }
> >+
> >+            /* loop over the indirect descriptor table */
> >+            len =3D address_space_cache_init(&indirect_desc_cache,
> >+                                           vdev->dma_as,
> >+                                           desc.addr, desc.len, false=
);
> >+            desc_cache =3D &indirect_desc_cache;
> >+            if (len < desc.len) {
> >+                virtio_error(vdev, "Cannot map indirect buffer");
> >+                goto err;
> >+            }
> >+
> >+            max =3D desc.len / sizeof(VRingPackedDesc);
> >+            num_bufs =3D i =3D 0;
> >+            vring_packed_desc_read(vdev, &desc, desc_cache, i);
> >+        }
> >+
> >+        do {
> >+            /* If we've got too many, that implies a descriptor loop.=
 */
> >+            if (++num_bufs > max) {
> >+                virtio_error(vdev, "Looped descriptor");
> >+                goto err;
> >+            }
> >+
> >+            if (desc.flags & VRING_DESC_F_WRITE) {
> >+                in_total +=3D desc.len;
> >+            } else {
> >+                out_total +=3D desc.len;
> >+            }
> >+            if (in_total >=3D max_in_bytes && out_total >=3D max_out_=
bytes) {
> >+                goto done;
> >+            }
> >+
> >+            if (desc_cache =3D=3D &indirect_desc_cache) {
> >+                if (++i >=3D max) {
> >+                    break;
> >+                }
> >+                vring_packed_desc_read(vdev, &desc, desc_cache, i);
> >+            } else {
> >+                if (++idx >=3D vq->vring.num) {
> >+                    idx -=3D vq->vring.num;
> >+                    wrap_counter ^=3D 1;
> >+                }
> >+                vring_packed_desc_read(vdev, &desc, desc_cache, idx);
> >+            }
> >+            /* Make sure flags has been read after all the other fiel=
ds */
> >+            smp_rmb();
>=20
>=20
> I don't think we need this according to the spec:
>=20
> "
>=20
> The driver always makes the first descriptor in the list
> available after the rest of the list has been written out into
> the ring. This guarantees that the device will never observe a
> partial scatter/gather list in the ring.
>=20
> "
>=20
> So when the first is available, the rest of the chain should be availab=
le,
> otherwise device may see partial chain.

As always, I will remove it, thanks a lot.

Wei

>=20
> Thanks
>=20
>=20
> >+        } while (desc.flags & VRING_DESC_F_NEXT);
> >+
> >+        if (desc_cache =3D=3D &indirect_desc_cache) {
> >+            address_space_cache_destroy(&indirect_desc_cache);
> >+            total_bufs++;
> >+            /* We missed one step on for indirect desc */
> >+            idx++;
> >+            if (++idx >=3D vq->vring.num) {
> >+                idx -=3D vq->vring.num;
> >+                wrap_counter ^=3D 1;
> >+            }
> >+        } else {
> >+            total_bufs =3D num_bufs;
> >+        }
> >+
> >+        desc_cache =3D &caches->desc;
> >+        vring_packed_desc_read_flags(vdev, &desc, desc_cache, idx);
> >+    }
> >+
> >+    /* Record the index and wrap counter for a kick we want */
> >+    vq->shadow_avail_idx =3D idx;
> >+    vq->avail_wrap_counter =3D wrap_counter;
> >+done:
> >+    address_space_cache_destroy(&indirect_desc_cache);
> >+    if (in_bytes) {
> >+        *in_bytes =3D in_total;
> >+    }
> >+    if (out_bytes) {
> >+        *out_bytes =3D out_total;
> >+    }
> >+    rcu_read_unlock();
> >+    return;
> >+
> >+err:
> >+    in_total =3D out_total =3D 0;
> >+    goto done;
> >+}
> >+
> >+void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
> >+                               unsigned int *out_bytes,
> >+                               unsigned max_in_bytes, unsigned max_ou=
t_bytes)
> >+{
> >+    uint16_t desc_size;
> >+    VRingMemoryRegionCaches *caches;
> >+
> >+    if (unlikely(!vq->vring.desc)) {
> >+        goto err;
> >+    }
> >+
> >+    caches =3D vring_get_region_caches(vq);
> >+    desc_size =3D virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PAC=
KED) ?
> >+                                sizeof(VRingPackedDesc) : sizeof(VRin=
gDesc);
> >+    if (caches->desc.len < vq->vring.num * desc_size) {
> >+        virtio_error(vq->vdev, "Cannot map descriptor ring");
> >+        goto err;
> >+    }
> >+
> >+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
> >+        virtqueue_packed_get_avail_bytes(vq, in_bytes, out_bytes,
> >+                                         max_in_bytes, max_out_bytes)=
;
> >+    } else {
> >+        virtqueue_split_get_avail_bytes(vq, in_bytes, out_bytes,
> >+                                        max_in_bytes, max_out_bytes);
> >+    }
> >+
> >+    return;
> >+err:
> >+    if (in_bytes) {
> >+        *in_bytes =3D 0;
> >+    }
> >+    if (out_bytes) {
> >+        *out_bytes =3D 0;
> >+    }
> >+}
> >+
> >  int virtqueue_avail_bytes(VirtQueue *vq, unsigned int in_bytes,
> >                            unsigned int out_bytes)
> >  {
>=20
