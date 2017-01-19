Received: from eggs.gnu.org ([2001:4830:134:3::10]:47435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPq-0000xg-Gi
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPo-00059n-Po
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:14 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cUDPo-0004w9-Id
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:12 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPn-0003FZ-Pb
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:10:11 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 14:09:52 +0000
Message-Id: <1484834995-26826-34-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
References: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 33/36] hw/arm/virt-acpi-build: use SMC if
 booting in EL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Andrew Jones <drjones@redhat.com>

Signed-off-by: Andrew Jones <drjones@redhat.com>
Acked-by: Alistair Francis <alistair.francis@xilinx.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1483977924-14522-16-git-send-email-peter.maydell@linaro.org
[PMM: look at vms->psci_conduit rather than vms->virt
 to decide whether to use HVC or SMC, and report no
 PSCI support at all for the 'PSCI disabled' case]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt-acpi-build.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 50d52f6..73aca9e 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -650,16 +650,30 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 }
 
 /* FADT */
-static void
-build_fadt(GArray *table_data, BIOSLinker *linker, unsigned dsdt_tbl_offset)
+static void build_fadt(GArray *table_data, BIOSLinker *linker,
+                       VirtMachineState *vms, unsigned dsdt_tbl_offset)
 {
     AcpiFadtDescriptorRev5_1 *fadt = acpi_data_push(table_data, sizeof(*fadt));
     unsigned dsdt_entry_offset = (char *)&fadt->dsdt - table_data->data;
+    uint16_t bootflags;
+
+    switch (vms->psci_conduit) {
+    case QEMU_PSCI_CONDUIT_DISABLED:
+        bootflags = 0;
+        break;
+    case QEMU_PSCI_CONDUIT_HVC:
+        bootflags = ACPI_FADT_ARM_PSCI_COMPLIANT | ACPI_FADT_ARM_PSCI_USE_HVC;
+        break;
+    case QEMU_PSCI_CONDUIT_SMC:
+        bootflags = ACPI_FADT_ARM_PSCI_COMPLIANT;
+        break;
+    default:
+        g_assert_not_reached();
+    }
 
-    /* Hardware Reduced = 1 and use PSCI 0.2+ and with HVC */
+    /* Hardware Reduced = 1 and use PSCI 0.2+ */
     fadt->flags = cpu_to_le32(1 << ACPI_FADT_F_HW_REDUCED_ACPI);
-    fadt->arm_boot_flags = cpu_to_le16(ACPI_FADT_ARM_PSCI_COMPLIANT |
-                                       ACPI_FADT_ARM_PSCI_USE_HVC);
+    fadt->arm_boot_flags = cpu_to_le16(bootflags);
 
     /* ACPI v5.1 (fadt->revision.fadt->minor_revision) */
     fadt->minor_revision = 0x1;
@@ -745,7 +759,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
 
     /* FADT MADT GTDT MCFG SPCR pointed to by RSDT */
     acpi_add_table(table_offsets, tables_blob);
-    build_fadt(tables_blob, tables->linker, dsdt);
+    build_fadt(tables_blob, tables->linker, vms, dsdt);
 
     acpi_add_table(table_offsets, tables_blob);
     build_madt(tables_blob, tables->linker, vms);
-- 
2.7.4
