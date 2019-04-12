Received: from eggs.gnu.org ([209.51.188.92]:38813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt55-0003Kr-OX
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt54-0005Qb-SD
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:06:47 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri, 12 Apr 2019 12:03:50 +0200
Message-Id: <20190412100354.6409-24-eric.auger@redhat.com>
In-Reply-To: <20190412100354.6409-1-eric.auger@redhat.com>
References: <20190412100354.6409-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC v3 23/27] memory: Introduce IOMMU Memory Region
 inject_faults API
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

This new API allows to inject @count iommu_faults into
the IOMMU memory region.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/exec/memory.h | 26 ++++++++++++++++++++++++++
 memory.c              | 12 ++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index aedebc8471..6262de1684 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -400,6 +400,20 @@ typedef struct IOMMUMemoryRegionClass {
      * @iommu: the IOMMUMemoryRegion
      */
     int (*num_indexes)(IOMMUMemoryRegion *iommu);
+
+#ifdef CONFIG_LINUX
+    /* Inject @count faults into the IOMMU memory region
+     *
+     * Optional method: if this method is not provided, then
+     * memory_region_injection_faults() will return -ENOENT
+     *
+     * @iommu: the IOMMU memory region to inject the faults in
+     * @count: number of faults to inject
+     * @buf: fault buffer
+     */
+    int (*inject_faults)(IOMMUMemoryRegion *iommu, int count,
+                         struct iommu_fault *buf);
+#endif
 } IOMMUMemoryRegionClass;
=20
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
@@ -1216,6 +1230,18 @@ int memory_region_iommu_attrs_to_index(IOMMUMemory=
Region *iommu_mr,
  */
 int memory_region_iommu_num_indexes(IOMMUMemoryRegion *iommu_mr);
=20
+#ifdef CONFIG_LINUX
+/**
+ * memory_region_inject_faults : inject @count faults stored in @buf
+ *
+ * @iommu_mr: the IOMMU memory region
+ * @count: number of faults to be injected
+ * @buf: buffer containing the faults
+ */
+int memory_region_inject_faults(IOMMUMemoryRegion *iommu_mr, int count,
+                                struct iommu_fault *buf);
+#endif
+
 /**
  * memory_region_name: get a memory region's name
  *
diff --git a/memory.c b/memory.c
index 8cd3c65872..2eac24cb80 100644
--- a/memory.c
+++ b/memory.c
@@ -2037,6 +2037,18 @@ int memory_region_iommu_num_indexes(IOMMUMemoryReg=
ion *iommu_mr)
     return imrc->num_indexes(iommu_mr);
 }
=20
+#ifdef CONFIG_LINUX
+int memory_region_inject_faults(IOMMUMemoryRegion *iommu_mr, int count,
+                                struct iommu_fault *buf)
+{
+    IOMMUMemoryRegionClass *imrc =3D IOMMU_MEMORY_REGION_GET_CLASS(iommu=
_mr);
+    if (!imrc->inject_faults) {
+        return -ENOENT;
+    }
+    return imrc->inject_faults(iommu_mr, count, buf);
+}
+#endif
+
 void memory_region_set_log(MemoryRegion *mr, bool log, unsigned client)
 {
     uint8_t mask =3D 1 << client;
--=20
2.20.1
