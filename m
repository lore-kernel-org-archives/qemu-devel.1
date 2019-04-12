Received: from eggs.gnu.org ([209.51.188.92]:37861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt3O-00019a-L5
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:05:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt3M-0003xH-Uk
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:05:02 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri, 12 Apr 2019 12:03:34 +0200
Message-Id: <20190412100354.6409-8-eric.auger@redhat.com>
In-Reply-To: <20190412100354.6409-1-eric.auger@redhat.com>
References: <20190412100354.6409-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC v3 07/27] hw/arm/smmuv3: Advertise VFIO_NESTED
 and MSI_TRANSLATE attributes
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

Virtual SMMUv3 requires physical nested stages for VFIO integration
and translates MSIs. So let's advertise those attributes.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v2 -> v3:
- also advertise MSI_TRANSLATE
---
 hw/arm/smmuv3.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index fd8ec7860e..761d722395 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1490,6 +1490,20 @@ static void smmuv3_notify_flag_changed(IOMMUMemory=
Region *iommu,
     }
 }
=20
+static int smmuv3_get_attr(IOMMUMemoryRegion *iommu,
+                           enum IOMMUMemoryRegionAttr attr,
+                           void *data)
+{
+    if (attr =3D=3D IOMMU_ATTR_VFIO_NESTED) {
+        *(bool *) data =3D true;
+        return 0;
+    } else if (attr =3D=3D IOMMU_ATTR_MSI_TRANSLATE) {
+        *(bool *) data =3D true;
+        return 0;
+    }
+    return -EINVAL;
+}
+
 static void smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
                                                   void *data)
 {
@@ -1497,6 +1511,7 @@ static void smmuv3_iommu_memory_region_class_init(O=
bjectClass *klass,
=20
     imrc->translate =3D smmuv3_translate;
     imrc->notify_flag_changed =3D smmuv3_notify_flag_changed;
+    imrc->get_attr =3D smmuv3_get_attr;
 }
=20
 static const TypeInfo smmuv3_type_info =3D {
--=20
2.20.1
