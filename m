Received: from eggs.gnu.org ([2001:4830:134:3::10]:52907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gRJ63-0005BV-NG
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 10:46:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gRJ62-0000rl-Up
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 10:46:51 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Mon, 26 Nov 2018 16:46:16 +0100
Message-Id: <20181126154616.18173-1-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1] hw/arm/virt-acpi-build: Fix SMMUv3
 ACPI integration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shannon.zhaosl@gmail.com
Cc: shameerali.kolothum.thodi@huawei.com

The AcpiIortSmmu3 misses 2 32b fields corresponding to the
proximity domain and the device id mapping index.

Also let's report IO-coherent access is supported for
translation table walks, descriptor fetches and queues by
setting the COHACC override flag. Without that, we observe
wrong command opcodes. The DT description also advertises
the dma coherency.

Fixes a703b4f6c1ee ("hw/arm/virt-acpi-build: Add smmuv3 node in IORT table")

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/virt-acpi-build.c    | 1 +
 include/hw/acpi/acpi-defs.h | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 5785fb697c..aa177ba64d 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -448,6 +448,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         smmu->mapping_count = cpu_to_le32(1);
         smmu->mapping_offset = cpu_to_le32(sizeof(*smmu));
         smmu->base_address = cpu_to_le64(vms->memmap[VIRT_SMMU].base);
+        smmu->flags = ACPI_IORT_SMMU_V3_COHACC_OVERRIDE;
         smmu->event_gsiv = cpu_to_le32(irq);
         smmu->pri_gsiv = cpu_to_le32(irq + 1);
         smmu->gerr_gsiv = cpu_to_le32(irq + 2);
diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index af8e023968..c3ee1f517b 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -628,6 +628,12 @@ struct AcpiIortItsGroup {
 } QEMU_PACKED;
 typedef struct AcpiIortItsGroup AcpiIortItsGroup;
 
+enum {
+    ACPI_IORT_SMMU_V3_COHACC_OVERRIDE = 1 << 0,
+    ACPI_IORT_SMMU_V3_HTTU_OVERRIDE   = 3 << 1,
+    ACPI_IORT_SMMU_V3_PXM_VALID       = 1 << 3
+};
+
 struct AcpiIortSmmu3 {
     ACPI_IORT_NODE_HEADER_DEF
     uint64_t base_address;
@@ -639,6 +645,8 @@ struct AcpiIortSmmu3 {
     uint32_t pri_gsiv;
     uint32_t gerr_gsiv;
     uint32_t sync_gsiv;
+    uint32_t pxm;
+    uint32_t id_mapping_index;
     AcpiIortIdMapping id_mapping_array[0];
 } QEMU_PACKED;
 typedef struct AcpiIortSmmu3 AcpiIortSmmu3;
-- 
2.17.2
