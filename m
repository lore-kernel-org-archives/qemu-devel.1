Received: from eggs.gnu.org ([2001:4830:134:3::10]:52681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gBx1I-0004nz-6r
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 03:10:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gBx18-0002DO-Cm
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 03:10:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gBx17-0002BH-8l
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 03:10:17 -0400
Date: Mon, 15 Oct 2018 15:09:54 +0800
From: Wei Xu <wexu@redhat.com>
Message-ID: <20181015070954.GB27871@wei-ubt>
References: <1539266915-15216-1-git-send-email-wexu@redhat.com>
	<1539266915-15216-4-git-send-email-wexu@redhat.com>
	<fef2ece0-03ca-3eef-3c21-31ee0a6440b7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fef2ece0-03ca-3eef-3c21-31ee0a6440b7@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [[RFC v3 03/12] virtio: init memory cache for
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
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, jfreimann@redhat.com, tiwei.bie@intel.com

On Mon, Oct 15, 2018 at 11:10:12AM +0800, Jason Wang wrote:
>=20
>=20
> On 2018=E5=B9=B410=E6=9C=8811=E6=97=A5 22:08, wexu@redhat.com wrote:
> >From: Wei Xu <wexu@redhat.com>
> >
> >Expand 1.0 by adding offset calculation accordingly.
>=20
> This is only part of what this patch did and I suggest to another patch=
 to
> do this.
>=20
> >
> >Signed-off-by: Wei Xu <wexu@redhat.com>
> >---
> >  hw/virtio/vhost.c          | 16 ++++++++--------
> >  hw/virtio/virtio.c         | 35 +++++++++++++++++++++++------------
> >  include/hw/virtio/virtio.h |  4 ++--
> >  3 files changed, 33 insertions(+), 22 deletions(-)
> >
> >diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >index 569c405..9df2da3 100644
> >--- a/hw/virtio/vhost.c
> >+++ b/hw/virtio/vhost.c
> >@@ -996,14 +996,14 @@ static int vhost_virtqueue_start(struct vhost_de=
v *dev,
> >          r =3D -ENOMEM;
> >          goto fail_alloc_desc;
> >      }
> >-    vq->avail_size =3D s =3D l =3D virtio_queue_get_avail_size(vdev, =
idx);
> >+    vq->avail_size =3D s =3D l =3D virtio_queue_get_driver_size(vdev,=
 idx);
>=20
> Let's try to use a more consistent name. E.g either use avail/used or
> driver/device.
>=20
> I prefer to use avail/used, it can save lots of unnecessary changes.

OK.

>=20
> >      vq->avail_phys =3D a =3D virtio_queue_get_avail_addr(vdev, idx);
> >      vq->avail =3D vhost_memory_map(dev, a, &l, 0);
> >      if (!vq->avail || l !=3D s) {
> >          r =3D -ENOMEM;
> >          goto fail_alloc_avail;
> >      }
> >-    vq->used_size =3D s =3D l =3D virtio_queue_get_used_size(vdev, id=
x);
> >+    vq->used_size =3D s =3D l =3D virtio_queue_get_device_size(vdev, =
idx);
> >      vq->used_phys =3D a =3D virtio_queue_get_used_addr(vdev, idx);
> >      vq->used =3D vhost_memory_map(dev, a, &l, 1);
> >      if (!vq->used || l !=3D s) {
> >@@ -1051,10 +1051,10 @@ static int vhost_virtqueue_start(struct vhost_=
dev *dev,
> >  fail_vector:
> >  fail_kick:
> >  fail_alloc:
> >-    vhost_memory_unmap(dev, vq->used, virtio_queue_get_used_size(vdev=
, idx),
> >+    vhost_memory_unmap(dev, vq->used, virtio_queue_get_device_size(vd=
ev, idx),
> >                         0, 0);
> >  fail_alloc_used:
> >-    vhost_memory_unmap(dev, vq->avail, virtio_queue_get_avail_size(vd=
ev, idx),
> >+    vhost_memory_unmap(dev, vq->avail, virtio_queue_get_driver_size(v=
dev, idx),
> >                         0, 0);
> >  fail_alloc_avail:
> >      vhost_memory_unmap(dev, vq->desc, virtio_queue_get_desc_size(vde=
v, idx),
> >@@ -1101,10 +1101,10 @@ static void vhost_virtqueue_stop(struct vhost_=
dev *dev,
> >                                                  vhost_vq_index);
> >      }
> >-    vhost_memory_unmap(dev, vq->used, virtio_queue_get_used_size(vdev=
, idx),
> >-                       1, virtio_queue_get_used_size(vdev, idx));
> >-    vhost_memory_unmap(dev, vq->avail, virtio_queue_get_avail_size(vd=
ev, idx),
> >-                       0, virtio_queue_get_avail_size(vdev, idx));
> >+    vhost_memory_unmap(dev, vq->used, virtio_queue_get_device_size(vd=
ev, idx),
> >+                       1, virtio_queue_get_device_size(vdev, idx));
> >+    vhost_memory_unmap(dev, vq->avail, virtio_queue_get_driver_size(v=
dev, idx),
> >+                       0, virtio_queue_get_driver_size(vdev, idx));
> >      vhost_memory_unmap(dev, vq->desc, virtio_queue_get_desc_size(vde=
v, idx),
> >                         0, virtio_queue_get_desc_size(vdev, idx));
> >  }
> >diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >index 500eecf..bfb3364 100644
> >--- a/hw/virtio/virtio.c
> >+++ b/hw/virtio/virtio.c
> >@@ -162,11 +162,8 @@ static void virtio_init_region_cache(VirtIODevice=
 *vdev, int n)
> >      VRingMemoryRegionCaches *old =3D vq->vring.caches;
> >      VRingMemoryRegionCaches *new =3D NULL;
> >      hwaddr addr, size;
> >-    int event_size;
> >      int64_t len;
> >-    event_size =3D virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EV=
ENT_IDX) ? 2 : 0;
> >-
> >      addr =3D vq->vring.desc;
> >      if (!addr) {
> >          goto out_no_cache;
> >@@ -174,13 +171,13 @@ static void virtio_init_region_cache(VirtIODevic=
e *vdev, int n)
> >      new =3D g_new0(VRingMemoryRegionCaches, 1);
> >      size =3D virtio_queue_get_desc_size(vdev, n);
> >      len =3D address_space_cache_init(&new->desc, vdev->dma_as,
> >-                                   addr, size, false);
> >+                                   addr, size, true);
>=20
> This looks wrong, for split virtqueue, descriptor ring is read only.

Did know it, I got a segment fault with 'false' case for packed ring,
will add a feature check here, thanks for the tip.

>=20
> >      if (len < size) {
> >          virtio_error(vdev, "Cannot map desc");
> >          goto err_desc;
> >      }
> >-    size =3D virtio_queue_get_used_size(vdev, n) + event_size;
> >+    size =3D virtio_queue_get_device_size(vdev, n);
> >      len =3D address_space_cache_init(&new->used, vdev->dma_as,
> >                                     vq->vring.used, size, true);
> >      if (len < size) {
> >@@ -188,7 +185,7 @@ static void virtio_init_region_cache(VirtIODevice =
*vdev, int n)
> >          goto err_used;
> >      }
> >-    size =3D virtio_queue_get_avail_size(vdev, n) + event_size;
> >+    size =3D virtio_queue_get_driver_size(vdev, n);
> >      len =3D address_space_cache_init(&new->avail, vdev->dma_as,
> >                                     vq->vring.avail, size, false);
> >      if (len < size) {
> >@@ -2339,16 +2336,30 @@ hwaddr virtio_queue_get_desc_size(VirtIODevice=
 *vdev, int n)
> >      return sizeof(VRingDesc) * vdev->vq[n].vring.num;
> >  }
> >-hwaddr virtio_queue_get_avail_size(VirtIODevice *vdev, int n)
> >+hwaddr virtio_queue_get_driver_size(VirtIODevice *vdev, int n)
> >  {
> >-    return offsetof(VRingAvail, ring) +
> >-        sizeof(uint16_t) * vdev->vq[n].vring.num;
> >+    int s;
> >+
> >+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> >+        return sizeof(struct VRingPackedDescEvent);
> >+    } else {
> >+        s =3D virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX) =
? 2 : 0;
> >+        return offsetof(VRingAvail, ring) +
> >+            sizeof(uint16_t) * vdev->vq[n].vring.num + s;
>=20
> I tend to move this to an independent patch.

You mean this two functions?

Wei

>=20
> Thanks
>=20
> >+    }
> >  }
> >-hwaddr virtio_queue_get_used_size(VirtIODevice *vdev, int n)
> >+hwaddr virtio_queue_get_device_size(VirtIODevice *vdev, int n)
> >  {
> >-    return offsetof(VRingUsed, ring) +
> >-        sizeof(VRingUsedElem) * vdev->vq[n].vring.num;
> >+    int s;
> >+
> >+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> >+        return sizeof(struct VRingPackedDescEvent);
> >+    } else {
> >+        s =3D virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX) =
? 2 : 0;
> >+        return offsetof(VRingUsed, ring) +
> >+            sizeof(VRingUsedElem) * vdev->vq[n].vring.num + s;
> >+    }
> >  }
> >  uint16_t virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n)
> >diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> >index 9c1fa07..e323e76 100644
> >--- a/include/hw/virtio/virtio.h
> >+++ b/include/hw/virtio/virtio.h
> >@@ -270,8 +270,8 @@ hwaddr virtio_queue_get_desc_addr(VirtIODevice *vd=
ev, int n);
> >  hwaddr virtio_queue_get_avail_addr(VirtIODevice *vdev, int n);
> >  hwaddr virtio_queue_get_used_addr(VirtIODevice *vdev, int n);
> >  hwaddr virtio_queue_get_desc_size(VirtIODevice *vdev, int n);
> >-hwaddr virtio_queue_get_avail_size(VirtIODevice *vdev, int n);
> >-hwaddr virtio_queue_get_used_size(VirtIODevice *vdev, int n);
> >+hwaddr virtio_queue_get_driver_size(VirtIODevice *vdev, int n);
> >+hwaddr virtio_queue_get_device_size(VirtIODevice *vdev, int n);
> >  uint16_t virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n);
> >  void virtio_queue_set_last_avail_idx(VirtIODevice *vdev, int n, uint=
16_t idx);
> >  void virtio_queue_restore_last_avail_idx(VirtIODevice *vdev, int n);
>=20
>=20
