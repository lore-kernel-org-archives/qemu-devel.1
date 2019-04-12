Received: from eggs.gnu.org ([209.51.188.92]:38131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt3r-0001f7-KO
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:05:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt3p-0004Mu-Lq
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:05:31 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri, 12 Apr 2019 12:03:40 +0200
Message-Id: <20190412100354.6409-14-eric.auger@redhat.com>
In-Reply-To: <20190412100354.6409-1-eric.auger@redhat.com>
References: <20190412100354.6409-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC v3 13/27] hw/arm/smmuv3: Implement dummy replay
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

The default implementation of memory_region_iommu_replay() shall
not be used as it forces the translation of the whole RAM range.
The purpose of this function is to update the shadow page tables.
However in case of nested stage, there is no shadow page table so
we can simply return.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmuv3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 96d4147533..8db605adab 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1507,6 +1507,11 @@ static int smmuv3_get_attr(IOMMUMemoryRegion *iomm=
u,
     return -EINVAL;
 }
=20
+static inline void
+smmuv3_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
+{
+}
+
 static void smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
                                                   void *data)
 {
@@ -1515,6 +1520,7 @@ static void smmuv3_iommu_memory_region_class_init(O=
bjectClass *klass,
     imrc->translate =3D smmuv3_translate;
     imrc->notify_flag_changed =3D smmuv3_notify_flag_changed;
     imrc->get_attr =3D smmuv3_get_attr;
+    imrc->replay =3D smmuv3_replay;
 }
=20
 static const TypeInfo smmuv3_type_info =3D {
--=20
2.20.1
