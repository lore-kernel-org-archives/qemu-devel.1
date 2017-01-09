Received: from eggs.gnu.org ([2001:4830:134:3::10]:37366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWW-0002Te-Il
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:54:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWV-00049f-Hi
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:54:00 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cQYWV-00043I-Bo
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:53:59 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWL-0001Om-MM
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:53:49 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jan 2017 11:53:32 +0000
Message-Id: <1483962824-29185-10-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
References: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 09/21] hw/arm/virt-acpi-build: fadt: improve
 flag naming
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
Message-id: 20170102200153.28864-5-drjones@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/acpi/acpi-defs.h | 6 ++----
 hw/arm/virt-acpi-build.c    | 4 ++--
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index 8fe0996..d15b7e5 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -191,10 +191,8 @@ struct AcpiFadtDescriptorRev5_1 {
 
 typedef struct AcpiFadtDescriptorRev5_1 AcpiFadtDescriptorRev5_1;
 
-enum {
-    ACPI_FADT_ARM_USE_PSCI_G_0_2 = 0,
-    ACPI_FADT_ARM_PSCI_USE_HVC = 1,
-};
+#define ACPI_FADT_ARM_PSCI_COMPLIANT  (1 << 0)
+#define ACPI_FADT_ARM_PSCI_USE_HVC    (1 << 1)
 
 /*
  * Serial Port Console Redirection Table (SPCR), Rev. 1.02
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 420cd21..ef0efb8 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -642,8 +642,8 @@ build_fadt(GArray *table_data, BIOSLinker *linker, unsigned dsdt_tbl_offset)
 
     /* Hardware Reduced = 1 and use PSCI 0.2+ and with HVC */
     fadt->flags = cpu_to_le32(1 << ACPI_FADT_F_HW_REDUCED_ACPI);
-    fadt->arm_boot_flags = cpu_to_le16((1 << ACPI_FADT_ARM_USE_PSCI_G_0_2) |
-                                       (1 << ACPI_FADT_ARM_PSCI_USE_HVC));
+    fadt->arm_boot_flags = cpu_to_le16(ACPI_FADT_ARM_PSCI_COMPLIANT |
+                                       ACPI_FADT_ARM_PSCI_USE_HVC);
 
     /* ACPI v5.1 (fadt->revision.fadt->minor_revision) */
     fadt->minor_revision = 0x1;
-- 
2.7.4
