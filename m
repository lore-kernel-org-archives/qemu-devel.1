Received: from eggs.gnu.org ([2001:4830:134:3::10]:49824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLcy-0003QZ-Ri
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLcx-00056x-UL
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:24 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fWLcx-00053n-NT
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:23 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLcu-0003t1-6A
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:57:20 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 13:56:54 +0100
Message-Id: <20180622125713.15303-10-peter.maydell@linaro.org>
In-Reply-To: <20180622125713.15303-1-peter.maydell@linaro.org>
References: <20180622125713.15303-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 09/28] hw/arm/virt-acpi-build: Advertise one or
 two GICR structures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Auger <eric.auger@redhat.com>

Depending on the number of smp_cpus we now register one or two
GICR structures.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Message-id: 1529072910-16156-7-git-send-email-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt-acpi-build.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 74f5744e87b..eefd1d48f79 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -670,6 +670,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 
     if (vms->gic_version == 3) {
         AcpiMadtGenericTranslator *gic_its;
+        int nb_redist_regions = virt_gicv3_redist_region_count(vms);
         AcpiMadtGenericRedistributor *gicr = acpi_data_push(table_data,
                                                          sizeof *gicr);
 
@@ -678,6 +679,14 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         gicr->base_address = cpu_to_le64(memmap[VIRT_GIC_REDIST].base);
         gicr->range_length = cpu_to_le32(memmap[VIRT_GIC_REDIST].size);
 
+        if (nb_redist_regions == 2) {
+            gicr = acpi_data_push(table_data, sizeof(*gicr));
+            gicr->type = ACPI_APIC_GENERIC_REDISTRIBUTOR;
+            gicr->length = sizeof(*gicr);
+            gicr->base_address = cpu_to_le64(memmap[VIRT_GIC_REDIST2].base);
+            gicr->range_length = cpu_to_le32(memmap[VIRT_GIC_REDIST2].size);
+        }
+
         if (its_class_name() && !vmc->no_its) {
             gic_its = acpi_data_push(table_data, sizeof *gic_its);
             gic_its->type = ACPI_APIC_GENERIC_TRANSLATOR;
-- 
2.17.1
