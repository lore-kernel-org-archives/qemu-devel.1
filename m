Received: from eggs.gnu.org ([2001:4830:134:3::10]:33318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1fPieT-0000al-1M
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 02:07:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1fPieP-0002mi-NC
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 02:07:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42708 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1fPieP-0002mS-HZ
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 02:07:29 -0400
Date: Mon, 4 Jun 2018 14:07:23 +0800
From: Wei Xu <wexu@redhat.com>
Message-ID: <20180604060723.GA13354@wei-ubt>
References: <1522846444-31725-1-git-send-email-wexu@redhat.com>
	<1522846444-31725-8-git-send-email-wexu@redhat.com>
	<3302231d-bb95-1cba-9d6b-87e6c8b76c00@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3302231d-bb95-1cba-9d6b-87e6c8b76c00@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 7/8] virtio: get avail bytes check for
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
Cc: mst@redhat.com, tiwei.bie@intel.com, jfreimann@redhat.com, qemu-devel@nongnu.org

On Wed, Apr 11, 2018 at 11:03:24AM +0800, Jason Wang wrote:
>=20
>=20
> On 2018=E5=B9=B404=E6=9C=8804=E6=97=A5 20:54, wexu@redhat.com wrote:
> >From: Wei Xu <wexu@redhat.com>
> >
> >mostly as same as 1.0, copy it separately for
> >prototype, need a refactoring.
> >
> >Signed-off-by: Wei Xu <wexu@redhat.com>
> >---
> >  hw/virtio/virtio.c | 142 +++++++++++++++++++++++++++++++++++++++++++=
++++++++--
> >  1 file changed, 139 insertions(+), 3 deletions(-)
> >
> >diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >index def07c6..cf726f3 100644
> >--- a/hw/virtio/virtio.c
> >+++ b/hw/virtio/virtio.c
> >@@ -836,9 +836,9 @@ static int virtqueue_read_next_desc(VirtIODevice *=
vdev, VRingDesc *desc,
> >      return VIRTQUEUE_READ_DESC_MORE;
> >  }
> >-void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
> >-                               unsigned int *out_bytes,
> >-                               unsigned max_in_bytes, unsigned max_ou=
t_bytes)
> >+static void virtqueue_get_avail_bytes_split(VirtQueue *vq,
> >+                            unsigned int *in_bytes, unsigned int *out=
_bytes,
> >+                            unsigned max_in_bytes, unsigned max_out_b=
ytes)
> >  {
> >      VirtIODevice *vdev =3D vq->vdev;
> >      unsigned int max, idx;
> >@@ -961,6 +961,142 @@ err:
> >      goto done;
> >  }
> >+static void virtqueue_get_avail_bytes_packed(VirtQueue *vq,
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
> >+    VRingDescPacked desc;
> >+
> >+    if (unlikely(!vq->packed.desc)) {
> >+        if (in_bytes) {
> >+            *in_bytes =3D 0;
> >+        }
> >+        if (out_bytes) {
> >+            *out_bytes =3D 0;
> >+        }
> >+        return;
> >+    }
> >+
> >+    rcu_read_lock();
> >+    idx =3D vq->last_avail_idx;
> >+    total_bufs =3D in_total =3D out_total =3D 0;
> >+
> >+    max =3D vq->packed.num;
> >+    caches =3D vring_get_region_caches(vq);
> >+    if (caches->desc.len < max * sizeof(VRingDescPacked)) {
> >+        virtio_error(vdev, "Cannot map descriptor ring");
> >+        goto err;
> >+    }
> >+
> >+    desc_cache =3D &caches->desc;
> >+    vring_desc_read_packed(vdev, &desc, desc_cache, idx);
> >+    while (is_desc_avail(&desc)) {
> >+        unsigned int num_bufs;
> >+        unsigned int i;
> >+
> >+        num_bufs =3D total_bufs;
> >+
> >+        if (desc.flags & VRING_DESC_F_INDIRECT) {
> >+            if (desc.len % sizeof(VRingDescPacked)) {
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
> >+            max =3D desc.len / sizeof(VRingDescPacked);
> >+            num_bufs =3D i =3D 0;
> >+            vring_desc_read_packed(vdev, &desc, desc_cache, i);
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
> >+                vring_desc_read_packed(vdev, &desc, desc_cache,
> >+                                       ++i % vq->packed.num);
> >+            } else {
> >+                vring_desc_read_packed(vdev, &desc, desc_cache,
> >+                                       ++idx % vq->packed.num);
> >+            }
>=20
> Need to make sure desc.flags was read before other fields, otherwise we=
 may
> get stale address.

OK, need a barrier here, thanks.

Wei

>=20
> Thanks
>=20
> >+        } while (desc.flags & VRING_DESC_F_NEXT);
> >+
> >+        if (desc_cache =3D=3D &indirect_desc_cache) {
> >+            address_space_cache_destroy(&indirect_desc_cache);
> >+            total_bufs++;
> >+            /* We missed one step on for indirect desc */
> >+            idx++;
> >+        } else {
> >+            total_bufs =3D num_bufs;
> >+        }
> >+
> >+        desc_cache =3D &caches->desc;
> >+        vring_desc_read_packed(vdev, &desc, desc_cache, idx % vq->pac=
ked.num);
> >+    }
> >+
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
> >+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
> >+        virtqueue_get_avail_bytes_packed(vq, in_bytes, out_bytes,
> >+                                         max_in_bytes, max_out_bytes)=
;
> >+    } else {
> >+        virtqueue_get_avail_bytes_split(vq, in_bytes, out_bytes,
> >+                                        max_in_bytes, max_out_bytes);
> >+    }
> >+}
> >+
> >  int virtqueue_avail_bytes(VirtQueue *vq, unsigned int in_bytes,
> >                            unsigned int out_bytes)
> >  {
>=20
>=20
