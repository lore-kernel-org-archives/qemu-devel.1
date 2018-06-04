Received: from eggs.gnu.org ([2001:4830:134:3::10]:40729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1fPjaZ-0005Tn-UP
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 03:07:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1fPjaV-00028m-St
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 03:07:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44112 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1fPjaV-00028b-M3
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 03:07:31 -0400
Date: Mon, 4 Jun 2018 15:07:25 +0800
From: Wei Xu <wexu@redhat.com>
Message-ID: <20180604070725.GB13354@wei-ubt>
References: <1522846444-31725-1-git-send-email-wexu@redhat.com>
	<1522846444-31725-9-git-send-email-wexu@redhat.com>
	<f5b909a6-c72e-352a-cd5c-2871d82d0190@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f5b909a6-c72e-352a-cd5c-2871d82d0190@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 8/8] virtio: queue pop support for packed
 ring
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

On Wed, Apr 11, 2018 at 10:43:40AM +0800, Jason Wang wrote:
>=20
>=20
> On 2018=E5=B9=B404=E6=9C=8804=E6=97=A5 20:54, wexu@redhat.com wrote:
> >From: Wei Xu <wexu@redhat.com>
> >
> >cloned from split ring pop, a global static length array
> >and the inside-element length array are introduced to
> >easy prototype, this consumes more memory and it is valuable
> >to move to dynamic allocation as the out/in sg does.
>=20
> To ease the reviewer, I suggest to reorder this patch to patch 4.

OK.

>=20
> >
> >Signed-off-by: Wei Xu <wexu@redhat.com>
> >---
> >  hw/virtio/virtio.c | 154 +++++++++++++++++++++++++++++++++++++++++++=
+++++++++-
> >  1 file changed, 153 insertions(+), 1 deletion(-)
> >
> >diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >index cf726f3..0eafb38 100644
> >--- a/hw/virtio/virtio.c
> >+++ b/hw/virtio/virtio.c
> >@@ -1221,7 +1221,7 @@ static void *virtqueue_alloc_element(size_t sz, =
unsigned out_num, unsigned in_nu
> >      return elem;
> >  }
> >-void *virtqueue_pop(VirtQueue *vq, size_t sz)
> >+static void *virtqueue_pop_split(VirtQueue *vq, size_t sz)
> >  {
> >      unsigned int i, head, max;
> >      VRingMemoryRegionCaches *caches;
> >@@ -1356,6 +1356,158 @@ err_undo_map:
> >      goto done;
> >  }
> >+static uint16_t dma_len[VIRTQUEUE_MAX_SIZE];
>=20
> This looks odd.

This has been removed.

>=20
> >+static void *virtqueue_pop_packed(VirtQueue *vq, size_t sz)
> >+{
> >+    unsigned int i, head, max;
> >+    VRingMemoryRegionCaches *caches;
> >+    MemoryRegionCache indirect_desc_cache =3D MEMORY_REGION_CACHE_INV=
ALID;
> >+    MemoryRegionCache *cache;
> >+    int64_t len;
> >+    VirtIODevice *vdev =3D vq->vdev;
> >+    VirtQueueElement *elem =3D NULL;
> >+    unsigned out_num, in_num, elem_entries;
> >+    hwaddr addr[VIRTQUEUE_MAX_SIZE];
> >+    struct iovec iov[VIRTQUEUE_MAX_SIZE];
> >+    VRingDescPacked desc;
> >+    uint8_t wrap_counter;
> >+
> >+    if (unlikely(vdev->broken)) {
> >+        return NULL;
> >+    }
> >+
> >+    vq->last_avail_idx %=3D vq->packed.num;
>=20
> Queue size could not be a power of 2.

Has replaced it with subtraction.

>=20
> >+
> >+    rcu_read_lock();
> >+    if (virtio_queue_empty_packed_rcu(vq)) {
> >+        goto done;
> >+    }
> >+
> >+    /* When we start there are none of either input nor output. */
> >+    out_num =3D in_num =3D elem_entries =3D 0;
> >+
> >+    max =3D vq->vring.num;
> >+
> >+    if (vq->inuse >=3D vq->vring.num) {
> >+        virtio_error(vdev, "Virtqueue size exceeded");
> >+        goto done;
> >+    }
> >+
> >+    if (virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
> >+        /* FIXME: TBD */
> >+    }
> >+
> >+    head =3D vq->last_avail_idx;
> >+    i =3D head;
> >+
> >+    caches =3D vring_get_region_caches(vq);
> >+    cache =3D &caches->desc_packed;
> >+    vring_desc_read_packed(vdev, &desc, cache, i);
> >+    if (desc.flags & VRING_DESC_F_INDIRECT) {
> >+        if (desc.len % sizeof(VRingDescPacked)) {
> >+            virtio_error(vdev, "Invalid size for indirect buffer tabl=
e");
> >+            goto done;
> >+        }
> >+
> >+        /* loop over the indirect descriptor table */
> >+        len =3D address_space_cache_init(&indirect_desc_cache, vdev->=
dma_as,
> >+                                       desc.addr, desc.len, false);
> >+        cache =3D &indirect_desc_cache;
> >+        if (len < desc.len) {
> >+            virtio_error(vdev, "Cannot map indirect buffer");
> >+            goto done;
> >+        }
> >+
> >+        max =3D desc.len / sizeof(VRingDescPacked);
> >+        i =3D 0;
> >+        vring_desc_read_packed(vdev, &desc, cache, i);
> >+    }
> >+
> >+    wrap_counter =3D vq->wrap_counter;
> >+    /* Collect all the descriptors */
> >+    while (1) {
> >+        bool map_ok;
> >+
> >+        if (desc.flags & VRING_DESC_F_WRITE) {
> >+            map_ok =3D virtqueue_map_desc(vdev, &in_num, addr + out_n=
um,
> >+                                        iov + out_num,
> >+                                        VIRTQUEUE_MAX_SIZE - out_num,=
 true,
> >+                                        desc.addr, desc.len);
> >+        } else {
> >+            if (in_num) {
> >+                virtio_error(vdev, "Incorrect order for descriptors")=
;
> >+                goto err_undo_map;
> >+            }
> >+            map_ok =3D virtqueue_map_desc(vdev, &out_num, addr, iov,
> >+                                        VIRTQUEUE_MAX_SIZE, false,
> >+                                        desc.addr, desc.len);
> >+        }
> >+        if (!map_ok) {
> >+            goto err_undo_map;
> >+        }
> >+
> >+        /* If we've got too many, that implies a descriptor loop. */
> >+        if (++elem_entries > max) {
> >+            virtio_error(vdev, "Looped descriptor");
> >+            goto err_undo_map;
> >+        }
> >+
> >+        dma_len[i++] =3D desc.len;
> >+        /* Toggle wrap_counter for non indirect desc */
> >+        if ((i =3D=3D vq->packed.num) && (cache !=3D &indirect_desc_c=
ache)) {
> >+            vq->wrap_counter ^=3D 1;
> >+        }
> >+
> >+        if (desc.flags & VRING_DESC_F_NEXT) {
> >+            vring_desc_read_packed(vq->vdev, &desc, cache, i % vq->pa=
cked.num);
> >+        } else {
> >+            break;
> >+        }
> >+    }
> >+
> >+    /* Now copy what we have collected and mapped */
> >+    elem =3D virtqueue_alloc_element(sz, out_num, in_num);
> >+    elem->index =3D head;
>=20
> This seems wrong, we could not assume buffer id is last_avail_idx.

Yes, I have revised it.

>=20
> >+    elem->wrap_counter =3D wrap_counter;
> >+    elem->count =3D (cache =3D=3D &indirect_desc_cache) ? 1 : out_num=
 + in_num;
> >+    for (i =3D 0; i < out_num; i++) {
> >+        /* DMA Done by marking the length as 0 */
>=20
> This seems unnecessary, spec said:
>=20
> "
> In a used descriptor, Element Address is unused. Element Length specifi=
es
> the length of the buffer that has
> been initialized (written to) by the device.
> Element length is reserved for used descriptors without the
> VIRTQ_DESC_F_WRITE flag, and is ignored
> by drivers.
> "

I am not sure, it seems it breaks Tx if I do not set it, so I copied it f=
rom
vhost, see vhost_add_used_and_signal(..., 0) in handle_tx().

>=20
> >+        elem->len[i] =3D 0;
> >+        elem->out_addr[i] =3D addr[i];
> >+        elem->out_sg[i] =3D iov[i];
> >+    }
> >+    for (i =3D 0; i < in_num; i++) {
> >+        elem->len[out_num + i] =3D dma_len[head + out_num + i];
>=20
> Shouldn't elem->len be determined by virtqueue_fill()?
>=20
> >+        elem->in_addr[i] =3D addr[out_num + i];
> >+        elem->in_sg[i] =3D iov[out_num + i];
> >+    }
> >+
> >+    vq->last_avail_idx +=3D elem->count;
> >+    vq->last_avail_idx %=3D vq->packed.num;
>=20
> Same here, num could not be a power of 2.

Revised.

>=20
> >+    vq->inuse +=3D elem->count;
> >+
> >+    trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
> >+done:
> >+    address_space_cache_destroy(&indirect_desc_cache);
> >+    rcu_read_unlock();
> >+
> >+    return elem;
> >+
> >+err_undo_map:
> >+    virtqueue_undo_map_desc(out_num, in_num, iov);
> >+    g_free(elem);
> >+    goto done;
>=20
> Only few minors difference with split version, can we manage to unify t=
hem?

Yes, will try to do it in next version.

Wei

>=20
> >+}
> >+
> >+void *virtqueue_pop(VirtQueue *vq, size_t sz)
> >+{
> >+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
> >+        return virtqueue_pop_packed(vq, sz);
> >+    } else {
> >+        return virtqueue_pop_split(vq, sz);
> >+    }
> >+}
> >+
> >  /* virtqueue_drop_all:
> >   * @vq: The #VirtQueue
> >   * Drops all queued buffers and indicates them to the guest
>=20
> Thanks
>=20
>=20
