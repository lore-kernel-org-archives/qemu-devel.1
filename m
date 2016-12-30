Received: from eggs.gnu.org ([2001:4830:134:3::10]:51027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cMu8h-0001NV-Lg
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 05:10:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cMu8f-0005jn-Gm
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 05:10:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cMu8f-0005jf-9l
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 05:10:17 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 30 Dec 2016 18:09:16 +0800
Message-Id: <1483092559-24488-8-git-send-email-jasowang@redhat.com>
In-Reply-To: <1483092559-24488-1-git-send-email-jasowang@redhat.com>
References: <1483092559-24488-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PATCH V4 07/10] acpi: add ATSR for q35
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peterx@redhat.com, cornelia.huck@de.ibm.com, wexu@redhat.com, vkaplans@redhat.com, Jason Wang <jasowang@redhat.com>

This patch provides ATSR which was a requirement for software that
wants to enable ATS on endpoint devices behind a Root Port. This is
done simply by setting ALL_PORTS which indicates all PCI-Express Root
Ports support ATS transactions.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/i386/acpi-build.c        |  9 +++++++++
 include/hw/acpi/acpi-defs.h | 12 ++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 42ecf61..4609db1 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2575,6 +2575,7 @@ build_dmar_q35(GArray *table_data, BIOSLinker *linker)
 
     AcpiTableDmar *dmar;
     AcpiDmarHardwareUnit *drhd;
+    AcpiDmarRootPortATS *atsr;
     uint8_t dmar_flags = 0;
     X86IOMMUState *iommu = x86_iommu_get_default();
     AcpiDmarDeviceScope *scope = NULL;
@@ -2608,6 +2609,14 @@ build_dmar_q35(GArray *table_data, BIOSLinker *linker)
     scope->path[0].device = PCI_SLOT(Q35_PSEUDO_DEVFN_IOAPIC);
     scope->path[0].function = PCI_FUNC(Q35_PSEUDO_DEVFN_IOAPIC);
 
+    if (iommu->dt_supported) {
+        atsr = acpi_data_push(table_data, sizeof(*atsr));
+        atsr->type = cpu_to_le16(ACPI_DMAR_TYPE_ATSR);
+        atsr->length = cpu_to_le16(sizeof(*atsr));
+        atsr->flags = ACPI_DMAR_ATSR_ALL_PORTS;
+        atsr->pci_segment = cpu_to_le16(0);
+    }
+
     build_header(linker, table_data, (void *)(table_data->data + dmar_start),
                  "DMAR", table_data->len - dmar_start, 1, NULL, NULL);
 }
diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index 154f3b8..e4dd523 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -638,8 +638,20 @@ struct AcpiDmarHardwareUnit {
 } QEMU_PACKED;
 typedef struct AcpiDmarHardwareUnit AcpiDmarHardwareUnit;
 
+/* Type 2: Root Port ATS Capability Reporting Structure */
+struct AcpiDmarRootPortATS {
+    uint16_t type;
+    uint16_t length;
+    uint8_t flags;
+    uint8_t reserved;
+    uint16_t pci_segment;
+    AcpiDmarDeviceScope scope[0];
+} QEMU_PACKED;
+typedef struct AcpiDmarRootPortATS AcpiDmarRootPortATS;
+
 /* Masks for Flags field above */
 #define ACPI_DMAR_INCLUDE_PCI_ALL   1
+#define ACPI_DMAR_ATSR_ALL_PORTS    1
 
 /*
  * Input Output Remapping Table (IORT)
-- 
2.7.4
