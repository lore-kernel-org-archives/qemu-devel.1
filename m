Received: from eggs.gnu.org ([2001:4830:134:3::10]:33484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQp9z-0007Ld-Qx
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:39:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQp9y-0005Yg-W5
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:39:51 -0500
Received: from mail.kernel.org ([198.145.29.136]:47822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQp9y-0005YA-P7
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:39:50 -0500
Date: Tue, 10 Jan 2017 07:39:46 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484026704-28027-11-git-send-email-mst@redhat.com>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484026704-28027-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 10/41] acpi: add ATSR for q35
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Jason Wang <jasowang@redhat.com>

This patch provides ATSR which was a requirement for software that
wants to enable ATS on endpoint devices behind a Root Port. This is
done simply by setting ALL_PORTS which indicates all PCI-Express Root
Ports support ATS transactions.

Signed-off-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/acpi-defs.h | 12 ++++++++++++
 hw/i386/acpi-build.c        |  9 +++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index d43ec00..4cc3630 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -627,8 +627,20 @@ struct AcpiDmarHardwareUnit {
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
-- 
MST
