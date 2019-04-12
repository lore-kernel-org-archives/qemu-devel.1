Received: from eggs.gnu.org ([209.51.188.92]:38372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt4N-0002Dk-LW
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:06:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt4L-0004ml-NX
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:06:03 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri, 12 Apr 2019 12:03:44 +0200
Message-Id: <20190412100354.6409-18-eric.auger@redhat.com>
In-Reply-To: <20190412100354.6409-1-eric.auger@redhat.com>
References: <20190412100354.6409-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC v3 17/27] hw/vfio/common: Introduce
 vfio_alloc_guest_iommu helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: alex.williamson@redhat.com, mst@redhat.com, jean-philippe.brucker@arm.com, peterx@redhat.com, yi.l.liu@intel.com, vincent.stehle@arm.com

Soon this code will be called several times. So let's introduce
an helper.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/vfio/common.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 0853c8c376..cf876d5264 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -24,6 +24,7 @@
 #include <linux/kvm.h>
 #endif
 #include <linux/vfio.h>
+#include <linux/iommu.h>
=20
 #include "hw/vfio/vfio-common.h"
 #include "hw/vfio/vfio.h"
@@ -480,6 +481,19 @@ out:
     rcu_read_unlock();
 }
=20
+static VFIOGuestIOMMU *vfio_alloc_guest_iommu(VFIOContainer *container,
+                                              IOMMUMemoryRegion *iommu,
+                                              hwaddr offset)
+{
+    VFIOGuestIOMMU *giommu =3D g_new0(VFIOGuestIOMMU, 1);
+
+    giommu->container =3D container;
+    giommu->iommu =3D iommu;
+    giommu->iommu_offset =3D offset;
+    /* notifier will be registered separately */
+    return giommu;
+}
+
 static void vfio_listener_region_add(MemoryListener *listener,
                                      MemoryRegionSection *section)
 {
@@ -587,6 +601,7 @@ static void vfio_listener_region_add(MemoryListener *=
listener,
     if (memory_region_is_iommu(section->mr)) {
         VFIOGuestIOMMU *giommu;
         IOMMUMemoryRegion *iommu_mr =3D IOMMU_MEMORY_REGION(section->mr)=
;
+        hwaddr offset;
         int iommu_idx;
=20
         trace_vfio_listener_region_add_iommu(iova, end);
@@ -596,11 +611,11 @@ static void vfio_listener_region_add(MemoryListener=
 *listener,
          * would be the right place to wire that up (tell the KVM
          * device emulation the VFIO iommu handles to use).
          */
-        giommu =3D g_malloc0(sizeof(*giommu));
-        giommu->iommu =3D iommu_mr;
-        giommu->iommu_offset =3D section->offset_within_address_space -
-                               section->offset_within_region;
-        giommu->container =3D container;
+
+        offset =3D section->offset_within_address_space -
+                    section->offset_within_region;
+        giommu =3D vfio_alloc_guest_iommu(container, iommu_mr, offset);
+
         llend =3D int128_add(int128_make64(section->offset_within_region=
),
                            section->size);
         llend =3D int128_sub(llend, int128_one());
--=20
2.20.1
