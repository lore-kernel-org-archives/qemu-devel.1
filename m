Received: from eggs.gnu.org ([2001:4830:134:3::10]:56038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eSOQf-0001Rq-7s
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 09:36:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eSOQb-0001Kx-8L
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 09:36:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53374)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eSOQa-0001JO-Vt
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 09:36:01 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBMEYeTT098536
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 09:35:59 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2f11reynm4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 09:35:58 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 22 Dec 2017 09:35:56 -0500
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 22 Dec 2017 09:35:51 -0500
Message-Id: <1513953351-22002-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] acpi: Update TPM2 ACPI table to more recent
 specs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, marcandre.lureau@gmail.com, mst@redhat.com
Cc: Stefan Berger <"Stefan Bergerstefanb"@linux.vnet.ibm.com>

From: Stefan Berger <Stefan Berger stefanb@linux.vnet.ibm.com>

More recent specs of the TPM2 ACPI table add fields for the log area
start address and the log area minimum size, which we already use
for the TCPA table.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/i386/acpi-build.c        | 19 ++++++++++++++-----
 include/hw/acpi/acpi-defs.h |  7 +++++--
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 5a6dee0..18b939e 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2274,16 +2274,25 @@ build_tpm_tcpa(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
 }
 
 static void
-build_tpm2(GArray *table_data, BIOSLinker *linker)
+build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
 {
-    Acpi20TPM2 *tpm2_ptr;
-
-    tpm2_ptr = acpi_data_push(table_data, sizeof *tpm2_ptr);
+    Acpi20TPM2 *tpm2_ptr = acpi_data_push(table_data, sizeof *tpm2_ptr);
+    unsigned log_addr_size = sizeof(tpm2_ptr->log_area_start_address);
+    unsigned log_addr_offset =
+        (char *)&tpm2_ptr->log_area_start_address - table_data->data;
 
     tpm2_ptr->platform_class = cpu_to_le16(TPM2_ACPI_CLASS_CLIENT);
     if (TPM_IS_TIS(tpm_find())) {
         tpm2_ptr->control_area_address = cpu_to_le64(0);
         tpm2_ptr->start_method = cpu_to_le32(TPM2_START_METHOD_MMIO);
+
+        tpm2_ptr->log_area_minimum_length =
+            cpu_to_le32(TPM_LOG_AREA_MINIMUM_SIZE);
+
+        /* log area start address to be filled by Guest linker */
+        bios_linker_loader_add_pointer(linker,
+            ACPI_BUILD_TABLE_FILE, log_addr_offset, log_addr_size,
+            ACPI_BUILD_TPMLOG_FILE, 0);
     } else {
         g_warn_if_reached();
     }
@@ -2695,7 +2704,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
 
         if (misc.tpm_version == TPM_VERSION_2_0) {
             acpi_add_table(table_offsets, tables_blob);
-            build_tpm2(tables_blob, tables->linker);
+            build_tpm2(tables_blob, tables->linker, tables->tcpalog);
         }
     }
     if (pcms->numa_nodes) {
diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index 72be675..80c8099 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -558,8 +558,8 @@ typedef struct Acpi20Tcpa Acpi20Tcpa;
 /*
  * TPM2
  *
- * Following Level 00, Rev 00.37 of specs:
- * http://www.trustedcomputinggroup.org/resources/tcg_acpi_specification
+ * Following Version 1.2, Revision 8 of specs:
+ * https://trustedcomputinggroup.org/tcg-acpi-specification/
  */
 struct Acpi20TPM2 {
     ACPI_TABLE_HEADER_DEF
@@ -567,6 +567,9 @@ struct Acpi20TPM2 {
     uint16_t reserved;
     uint64_t control_area_address;
     uint32_t start_method;
+    uint8_t start_method_params[12];
+    uint32_t log_area_minimum_length;
+    uint64_t log_area_start_address;
 } QEMU_PACKED;
 typedef struct Acpi20TPM2 Acpi20TPM2;
 
-- 
2.5.5
