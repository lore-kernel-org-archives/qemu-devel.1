Received: from eggs.gnu.org ([2001:4830:134:3::10]:57624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8jwQ-0003Hd-HB
	for qemu-devel@nongnu.org; Thu, 11 May 2017 04:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8jwM-0003xR-Ka
	for qemu-devel@nongnu.org; Thu, 11 May 2017 04:59:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d8jwM-0003wi-DK
	for qemu-devel@nongnu.org; Thu, 11 May 2017 04:59:18 -0400
Date: Thu, 11 May 2017 16:59:01 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170511085901.GI28293@pxdev.xzpeter.org>
References: <1494403315-12760-1-git-send-email-peterx@redhat.com>
	<1494403315-12760-13-git-send-email-peterx@redhat.com>
	<2a328f26-bf49-a0e8-1582-2179720b0cb1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2a328f26-bf49-a0e8-1582-2179720b0cb1@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 12/12] vhost: iommu: cache static
 mapping if there is
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, "Michael S . Tsirkin" <mst@redhat.com>, yi.l.liu@intel.com, Marcel Apfelbaum <marcel@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>

On Thu, May 11, 2017 at 04:35:21PM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B405=E6=9C=8810=E6=97=A5 16:01, Peter Xu wrote:
> >This patch pre-heat vhost iotlb cache when passthrough mode enabled.
> >
> >Sometimes, even if user specified iommu_platform for vhost devices,
> >IOMMU might still be disabled. One case is passthrough mode in VT-d
> >implementation. We can detect this by observing iommu_list. If it's
> >empty, it means IOMMU translation is disabled, then we can actually
> >pre-heat the translation (it'll be static mapping then) by first
> >invalidating all IOTLB, then cache existing memory ranges into vhost
> >backend iotlb using 1:1 mapping.
> >
> >Signed-off-by: Peter Xu <peterx@redhat.com>
> >---
> >  hw/virtio/trace-events |  4 ++++
> >  hw/virtio/vhost.c      | 49 ++++++++++++++++++++++++++++++++++++++++=
+++++++++
> >  2 files changed, 53 insertions(+)
> >
> >diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> >index 1f7a7c1..54dcbb3 100644
> >--- a/hw/virtio/trace-events
> >+++ b/hw/virtio/trace-events
> >@@ -24,3 +24,7 @@ virtio_balloon_handle_output(const char *name, uint6=
4_t gpa) "section name: %s g
> >  virtio_balloon_get_config(uint32_t num_pages, uint32_t actual) "num_=
pages: %d actual: %d"
> >  virtio_balloon_set_config(uint32_t actual, uint32_t oldactual) "actu=
al: %d oldactual: %d"
> >  virtio_balloon_to_target(uint64_t target, uint32_t num_pages) "ballo=
on target: %"PRIx64" num_pages: %d"
> >+
> >+# hw/virtio/vhost.c
> >+vhost_iommu_commit(void) ""
> >+vhost_iommu_static_preheat(void) ""
> >diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >index 0001e60..1c92e62 100644
> >--- a/hw/virtio/vhost.c
> >+++ b/hw/virtio/vhost.c
> >@@ -27,6 +27,7 @@
> >  #include "hw/virtio/virtio-access.h"
> >  #include "migration/migration.h"
> >  #include "sysemu/dma.h"
> >+#include "trace.h"
> >  /* enabled until disconnected backend stabilizes */
> >  #define _VHOST_DEBUG 1
> >@@ -730,6 +731,11 @@ static void vhost_iommu_unmap_notify(IOMMUNotifie=
r *n, IOMMUTLBEntry *iotlb)
> >      }
> >  }
> >+static bool vhost_iommu_mr_enabled(struct vhost_dev *dev)
> >+{
> >+    return !QLIST_EMPTY(&dev->iommu_list);
> >+}
> >+
> >  static void vhost_iommu_region_add(MemoryListener *listener,
> >                                     MemoryRegionSection *section)
> >  {
> >@@ -782,6 +788,48 @@ static void vhost_iommu_region_del(MemoryListener=
 *listener,
> >      }
> >  }
> >+static void vhost_iommu_commit(MemoryListener *listener)
> >+{
> >+    struct vhost_dev *dev =3D container_of(listener, struct vhost_dev=
,
> >+                                         iommu_listener);
> >+    struct vhost_memory_region *r;
> >+    int i;
> >+
> >+    trace_vhost_iommu_commit();
> >+
> >+    if (!vhost_iommu_mr_enabled(dev)) {
> >+        /*
> >+        * This means iommu_platform is enabled, however iommu memory
> >+        * region is disabled, e.g., when device passthrough is setup.
> >+        * Then, no translation is needed any more.
> >+        *
> >+        * Let's first invalidate the whole IOTLB, then pre-heat the
> >+        * static mapping by looping over vhost memory ranges.
> >+        */
> >+
> >+        if (dev->vhost_ops->vhost_invalidate_device_iotlb(dev, 0,
> >+                                                          UINT64_MAX-=
1)) {
> >+            error_report("%s: flush existing IOTLB failed", __func__)=
;
> >+            return;
> >+        }
> >+
> >+        for (i =3D 0; i < dev->mem->nregions; i++) {
> >+            r =3D &dev->mem->regions[i];
> >+            /* Vhost regions are writable RAM, so IOMMU_RW suites. */
> >+            if (dev->vhost_ops->vhost_update_device_iotlb(dev,
> >+                                                          r->guest_ph=
ys_addr,
> >+                                                          r->userspac=
e_addr,
> >+                                                          r->memory_s=
ize,
> >+                                                          IOMMU_RW)) =
{
> >+                error_report("%s: pre-heat static mapping failed", __=
func__);
> >+                return;
> >+            }
> >+        }
> >+
> >+        trace_vhost_iommu_static_preheat();
> >+    }
> >+}
>=20
> Looks like vfio does the map in region_add(), if we can have different =
types
> of memory regions (e.g some were under an IOMMU but others were not), d=
o we
> need to switch to do this in vhost_iommu_region_add() ?

Currently this is only a pre-heat of cache only if IOMMU is totally
disabled (!vhost_iommu_mr_enabled(dev) means no IOMMU memory regions).
This patch won't be activated without this condition, so for the cases
(non-x86 platforms) where there are some IOMMU regions, it'll be just
automatically disabled. And, I don't really quite sure whether we
should cache non-IOMMU regions when there are some IOMMU regions... So
imho we can keep this until one day we really want to support some
non-x86 platforms for vhost-dmar, then we can work on top. Thanks,

--=20
Peter Xu
