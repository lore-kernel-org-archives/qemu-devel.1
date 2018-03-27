Received: from eggs.gnu.org ([2001:4830:134:3::10]:45835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1f0pOP-0003KJ-Ur
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:16:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1f0pOO-0006o2-S1
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:16:05 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 27 Mar 2018 16:15:21 +0200
Message-Id: <1522160122-10744-8-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1522160122-10744-1-git-send-email-eric.auger@redhat.com>
References: <1522160122-10744-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC 7/8] hw/arm/virt-acpi-build: Handle multiple GICR
 structures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: drjones@redhat.com, wei@redhat.com, marc.zyngier@arm.com, cdall@kernel.org, zhaoshenglong@huawei.com

In case multiple redistributor regions were registered,
let's add the corresponding GICR structures in the MADT
ACPI table.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt-acpi-build.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index c7c6a57..aefc1b4 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -43,6 +43,7 @@
 #include "hw/pci/pcie_host.h"
 #include "hw/pci/pci.h"
 #include "hw/arm/virt.h"
+#include "hw/intc/arm_gicv3.h"
 #include "sysemu/numa.h"
 #include "kvm_arm.h"
 
@@ -618,14 +619,22 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     }
 
     if (vms->gic_version == 3) {
+        GICv3State *s = (GICv3State *)vms->gic;
+        int r;
+
         AcpiMadtGenericTranslator *gic_its;
-        AcpiMadtGenericRedistributor *gicr = acpi_data_push(table_data,
-                                                         sizeof *gicr);
 
-        gicr->type = ACPI_APIC_GENERIC_REDISTRIBUTOR;
-        gicr->length = sizeof(*gicr);
-        gicr->base_address = cpu_to_le64(memmap[VIRT_GIC_REDIST].base);
-        gicr->range_length = cpu_to_le32(memmap[VIRT_GIC_REDIST].size);
+        for (r = 0; r <  s->nb_redist_regions; r++) {
+            AcpiMadtGenericRedistributor *gicr = acpi_data_push(table_data,
+                                                                sizeof *gicr);
+
+            gicr->type = ACPI_APIC_GENERIC_REDISTRIBUTOR;
+            gicr->length = sizeof(*gicr);
+            gicr->base_address = cpu_to_le64(s->redist_region[r].base);
+            /* count redistributors of 2 x 64kB pages */
+            gicr->range_length =
+                cpu_to_le64((uint64_t)s->redist_region[r].count << 17);
+        }
 
         if (its_class_name() && !vmc->no_its) {
             gic_its = acpi_data_push(table_data, sizeof *gic_its);
-- 
2.5.5
