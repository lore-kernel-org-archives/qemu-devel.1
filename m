Received: from eggs.gnu.org ([209.51.188.92]:59774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ggRzy-0005vx-AH
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 05:19:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ggRzv-00080e-Lc
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 05:19:10 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Mon,  7 Jan 2019 11:10:41 +0100
Message-Id: <20190107101041.765-1-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v3] hw/arm/virt-acpi-build: Set COHACC override
 flag in IORT SMMUv3 node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shannon.zhaosl@gmail.com
Cc: shameerali.kolothum.thodi@huawei.com, drjones@redhat.com

Let's report IO-coherent access is supported for translation
table walks, descriptor fetches and queues by setting the COHACC
override flag. Without that, we observe wrong command opcodes.
The DT description also advertises the dma coherency.

Fixes a703b4f6c1ee ("hw/arm/virt-acpi-build: Add smmuv3 node in IORT table")

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Tested-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>

---
v2 -> v3:
- added cpu_to_le32
---
 hw/arm/virt-acpi-build.c    | 1 +
 include/hw/acpi/acpi-defs.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 95fad6f0ce..04b62c714d 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -418,6 +418,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         smmu->mapping_count = cpu_to_le32(1);
         smmu->mapping_offset = cpu_to_le32(sizeof(*smmu));
         smmu->base_address = cpu_to_le64(vms->memmap[VIRT_SMMU].base);
+        smmu->flags = cpu_to_le32(ACPI_IORT_SMMU_V3_COHACC_OVERRIDE);
         smmu->event_gsiv = cpu_to_le32(irq);
         smmu->pri_gsiv = cpu_to_le32(irq + 1);
         smmu->gerr_gsiv = cpu_to_le32(irq + 2);
diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index 5021cb9e79..df37f68757 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -623,6 +623,8 @@ struct AcpiIortItsGroup {
 } QEMU_PACKED;
 typedef struct AcpiIortItsGroup AcpiIortItsGroup;
 
+#define ACPI_IORT_SMMU_V3_COHACC_OVERRIDE 1
+
 struct AcpiIortSmmu3 {
     ACPI_IORT_NODE_HEADER_DEF
     uint64_t base_address;
-- 
2.17.2
