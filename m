Received: from eggs.gnu.org ([2001:4830:134:3::10]:53607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ebTWm-0002kK-HD
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:51:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ebTWj-0003sx-9E
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:51:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52182
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1ebTWj-0003sQ-40
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:51:53 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0GFnjNm102371
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 10:51:52 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fhkkcub6g-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 10:51:52 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 16 Jan 2018 08:51:51 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 16 Jan 2018 10:51:38 -0500
In-Reply-To: <1516117900-11382-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1516117900-11382-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1516117900-11382-3-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 2/4] acpi: build QEMU table for PPI virtual
 memory device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, stefanb@linux.vnet.ibm.com, kevin@koconnor.net, marcandre.lureau@redhat.com, lersek@redhat.com

To avoid having to hard code the base address of the PPI virtual memory
device we introduce a QEMU ACPI table that holds the base address, if a
TPM 1.2 or 2 is used. This table gives us flexibility to move the base
address later on.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/i386/acpi-build.c        | 19 +++++++++++++++++++
 include/hw/acpi/acpi-defs.h |  8 ++++++++
 2 files changed, 27 insertions(+)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 18b939e..522d6d2 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2628,6 +2628,20 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
     return true;
 }
 
+static void build_qemu(GArray *table_data, BIOSLinker *linker,
+                       TPMVersion tpm_version)
+{
+    AcpiTableQemu *qemu = acpi_data_push(table_data, sizeof(*qemu));
+
+    if (tpm_version != TPM_VERSION_UNSPEC) {
+        qemu->tpmppi_addr = TPM_PPI_ADDR_BASE;
+        qemu->tpm_version = tpm_version;
+    }
+
+    build_header(linker, table_data,
+                 (void *)qemu, "QEMU", sizeof(*qemu), 1, "QEMU", "CONF");
+}
+
 static
 void acpi_build(AcpiBuildTables *tables, MachineState *machine)
 {
@@ -2734,6 +2748,11 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
                           &pcms->acpi_nvdimm_state, machine->ram_slots);
     }
 
+    if (misc.tpm_version != TPM_VERSION_UNSPEC) {
+        acpi_add_table(table_offsets, tables_blob);
+        build_qemu(tables_blob, tables->linker, misc.tpm_version);
+    }
+
     /* Add tables supplied by user (if any) */
     for (u = acpi_table_first(); u; u = acpi_table_next(u)) {
         unsigned len = acpi_table_len(u);
diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index 80c8099..98764c1 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -573,6 +573,14 @@ struct Acpi20TPM2 {
 } QEMU_PACKED;
 typedef struct Acpi20TPM2 Acpi20TPM2;
 
+/* QEMU - Custom QEMU table */
+struct AcpiTableQemu {
+    ACPI_TABLE_HEADER_DEF
+    uint32_t tpmppi_addr;
+    uint8_t tpm_version; /* 1 = 1.2, 2 = 2 */
+};
+typedef struct AcpiTableQemu AcpiTableQemu;
+
 /* DMAR - DMA Remapping table r2.2 */
 struct AcpiTableDmar {
     ACPI_TABLE_HEADER_DEF
-- 
2.5.5
