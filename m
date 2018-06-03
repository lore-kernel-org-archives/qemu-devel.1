Received: from eggs.gnu.org ([2001:4830:134:3::10]:40923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1fPVlL-00036J-0g
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 12:21:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1fPVlH-0004sg-RJ
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 12:21:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35892 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1fPVlH-0004r6-LP
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 12:21:43 -0400
Date: Mon, 4 Jun 2018 00:21:36 +0800
From: Wei Xu <wexu@redhat.com>
Message-ID: <20180603162136.GB24012@wei-ubt>
References: <1522846444-31725-1-git-send-email-wexu@redhat.com>
	<1522846444-31725-2-git-send-email-wexu@redhat.com>
	<e6c4138a-df93-a342-6cbe-b7d5b9a64567@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e6c4138a-df93-a342-6cbe-b7d5b9a64567@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/8] virtio: feature bit,
 data structure for packed ring
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

On Tue, Apr 10, 2018 at 03:05:24PM +0800, Jason Wang wrote:
>=20
>=20
> On 2018=E5=B9=B404=E6=9C=8804=E6=97=A5 20:53, wexu@redhat.com wrote:
> >From: Wei Xu <wexu@redhat.com>
> >
> >Only minimum definitions from the spec are included
> >for prototype.
> >
> >Signed-off-by: Wei Xu <wexu@redhat.com>
> >---
> >  hw/virtio/virtio.c                             | 47 ++++++++++++++++=
+++++++---
> >  include/hw/virtio/virtio.h                     | 12 ++++++-
> >  include/standard-headers/linux/virtio_config.h |  2 ++
> >  3 files changed, 56 insertions(+), 5 deletions(-)
> >
> >diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >index 006d3d1..9a6bfe7 100644
> >--- a/hw/virtio/virtio.c
> >+++ b/hw/virtio/virtio.c
> >@@ -39,6 +39,14 @@ typedef struct VRingDesc
> >      uint16_t next;
> >  } VRingDesc;
> >+typedef struct VRingDescPacked
> >+{
> >+    uint64_t addr;
> >+    uint32_t len;
> >+    uint16_t id;
> >+    uint16_t flags;
> >+} VRingDescPacked;
> >+
> >  typedef struct VRingAvail
> >  {
> >      uint16_t flags;
> >@@ -61,9 +69,18 @@ typedef struct VRingUsed
> >  typedef struct VRingMemoryRegionCaches {
> >      struct rcu_head rcu;
> >-    MemoryRegionCache desc;
> >-    MemoryRegionCache avail;
> >-    MemoryRegionCache used;
> >+    union {
> >+        struct {
> >+            MemoryRegionCache desc;
> >+            MemoryRegionCache avail;
> >+            MemoryRegionCache used;
> >+        };
> >+        struct {
> >+            MemoryRegionCache desc_packed;
> >+            MemoryRegionCache driver;
> >+            MemoryRegionCache device;
> >+        };
> >+    };
>=20
> I think we can reuse exist memory region caches? Especially consider
> device/driver area could be treated as a renaming of avail/used area.
>=20
> E.g desc for desc_packed, avail for driver area and used for device are=
a.

Yes, I will take it.

>=20
> >  } VRingMemoryRegionCaches;
> >  typedef struct VRing
> >@@ -77,10 +94,31 @@ typedef struct VRing
> >      VRingMemoryRegionCaches *caches;
> >  } VRing;
> >+typedef struct VRingPackedDescEvent {
> >+    uint16_t desc_event_off:15,
> >+             desc_event_wrap:1;
> >+    uint16_t desc_event_flags:2;
> >+} VRingPackedDescEvent ;
> >+
> >+typedef struct VRingPacked
> >+{
> >+    unsigned int num;
> >+    unsigned int num_default;
> >+    unsigned int align;
> >+    hwaddr desc;
> >+    hwaddr driver;
> >+    hwaddr device;
> >+    VRingMemoryRegionCaches *caches;
> >+} VRingPacked;
>=20
> Same here, can we reuse VRing here?

Yes.

>=20
> >+
> >  struct VirtQueue
> >  {
> >-    VRing vring;
> >+    union {
> >+        struct VRing vring;
> >+        struct VRingPacked packed;
> >+    };
> >+    uint8_t wrap_counter:1;
> >      /* Next head to pop */
> >      uint16_t last_avail_idx;
> >@@ -1220,6 +1258,7 @@ void virtio_reset(void *opaque)
> >          vdev->vq[i].vring.num =3D vdev->vq[i].vring.num_default;
> >          vdev->vq[i].inuse =3D 0;
> >          virtio_virtqueue_reset_region_cache(&vdev->vq[i]);
> >+        vdev->vq[i].wrap_counter =3D 1;
> >      }
> >  }
> >diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> >index 098bdaa..563e88e 100644
> >--- a/include/hw/virtio/virtio.h
> >+++ b/include/hw/virtio/virtio.h
> >@@ -46,6 +46,14 @@ typedef struct VirtQueueElement
> >      unsigned int index;
> >      unsigned int out_num;
> >      unsigned int in_num;
> >+
> >+    /* Number of descriptors used by packed ring */
>=20
> Do you mean the number of chained descriptors?

These has been removed.

>=20
> >+    uint16_t count;
> >+    uint8_t wrap_counter:1;
>=20
> What's the use of this bit? If you refer to my v1 vhost code, I used to=
 have
> this, but it won't work for OOO completion e.g when zerocopy is disable=
d.
> I've dropped it now.
>=20
> This is tricky and can only work when device complete descriptors in or=
der.

Same here.

>=20
> >+    /* FIXME: Length of every used buffer for a descriptor,
> >+       move to dynamical allocating due to out/in sgs numbers */
> >+    uint32_t len[VIRTQUEUE_MAX_SIZE];
>=20
> Can you explain more about this?

Also here.

>=20
> >+
> >      hwaddr *in_addr;
> >      hwaddr *out_addr;
> >      struct iovec *in_sg;
> >@@ -262,7 +270,9 @@ typedef struct VirtIORNGConf VirtIORNGConf;
> >      DEFINE_PROP_BIT64("any_layout", _state, _field, \
> >                        VIRTIO_F_ANY_LAYOUT, true), \
> >      DEFINE_PROP_BIT64("iommu_platform", _state, _field, \
> >-                      VIRTIO_F_IOMMU_PLATFORM, false)
> >+                      VIRTIO_F_IOMMU_PLATFORM, false), \
> >+    DEFINE_PROP_BIT64("ring_packed", _state, _field, \
> >+                      VIRTIO_F_RING_PACKED, true)
>=20
> Remember to disable this for old machine types in next version.

Sure, will do.

>=20
> Thanks
>=20
> >  hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
> >  hwaddr virtio_queue_get_avail_addr(VirtIODevice *vdev, int n);
> >diff --git a/include/standard-headers/linux/virtio_config.h b/include/=
standard-headers/linux/virtio_config.h
> >index b777069..6ee5529 100644
> >--- a/include/standard-headers/linux/virtio_config.h
> >+++ b/include/standard-headers/linux/virtio_config.h
> >@@ -71,4 +71,6 @@
> >   * this is for compatibility with legacy systems.
> >   */
> >  #define VIRTIO_F_IOMMU_PLATFORM		33
> >+
> >+#define VIRTIO_F_RING_PACKED		34
> >  #endif /* _LINUX_VIRTIO_CONFIG_H */
>=20
