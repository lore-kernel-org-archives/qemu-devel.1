Received: from eggs.gnu.org ([2001:4830:134:3::10]:46467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebTDs-00087v-RD
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:32:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebTDn-0006Rb-89
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:32:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ebTDn-0006Qc-0F
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:32:19 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F01D187629
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 15:32:17 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 16 Jan 2018 16:30:26 +0100
Message-Id: <1516116626-195863-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v2] tests: acpi: fix FADT not being compared to
 reference table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com

It turns out that FADT isn't actually tested for changes
against reference table, since it happens to be the 1st
table in RSDT which is currently ignored.
Fix it by making sure that all tables from RSDT are added
to test list.

NOTE: FADT contains guest allocated pointers to FACS/DSDT,
zero them out so that possible FACS/DSDT address change
won't affect test results.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v2:
  - fixup FACS/DSDT pointers in FADT to avoid false test
    failure if pointers change ("Michael S. Tsirkin" <mst@redhat.com>)
---
 tests/bios-tables-test.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 81c558e..3a66f66 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -194,6 +194,35 @@ static void test_acpi_fadt_table(test_data *data)
                                  le32_to_cpu(fadt_table->length)));
 }
 
+static void sanitize_fadt_ptrs(test_data *data)
+{
+    /* fixup pointers in FADT */
+    int i;
+
+    for (i = 0; i < data->tables->len; i++) {
+        AcpiSdtTable *sdt = &g_array_index(data->tables, AcpiSdtTable, i);
+
+        if (memcmp(&sdt->header.signature, "FACP", 4)) {
+            continue;
+        }
+
+        /* sdt->aml field offset := spec offset - header size */
+        memset(sdt->aml + 0, 0, 4); /* sanitize FIRMWARE_CTRL(36) ptr */
+        memset(sdt->aml + 4, 0, 4); /* sanitize DSDT(40) ptr */
+        if (sdt->header.revision >= 3) {
+            memset(sdt->aml + 96, 0, 8); /* sanitize X_FIRMWARE_CTRL(132) ptr */
+            memset(sdt->aml + 104, 0, 8); /* sanitize X_DSDT(140) ptr */
+        }
+
+        /* update checksum */
+        sdt->header.checksum = 0;
+        sdt->header.checksum -=
+            acpi_calc_checksum((uint8_t *)sdt, sizeof(AcpiTableHeader)) +
+            acpi_calc_checksum((uint8_t *)sdt->aml, sdt->aml_len);
+        break;
+    }
+}
+
 static void test_acpi_facs_table(test_data *data)
 {
     AcpiFacsDescriptorRev1 *facs_table = &data->facs_table;
@@ -248,14 +277,14 @@ static void test_acpi_dsdt_table(test_data *data)
 /* Load all tables and add to test list directly RSDT referenced tables */
 static void fetch_rsdt_referenced_tables(test_data *data)
 {
-    int tables_nr = data->rsdt_tables_nr - 1; /* fadt is first */
+    int tables_nr = data->rsdt_tables_nr;
     int i;
 
     for (i = 0; i < tables_nr; i++) {
         AcpiSdtTable ssdt_table;
         uint32_t addr;
 
-        addr = le32_to_cpu(data->rsdt_tables_addr[i + 1]); /* fadt is first */
+        addr = le32_to_cpu(data->rsdt_tables_addr[i]);
         fetch_table(&ssdt_table, addr);
 
         /* Add table to ASL test tables list */
@@ -650,6 +679,8 @@ static void test_acpi_one(const char *params, test_data *data)
     test_acpi_dsdt_table(data);
     fetch_rsdt_referenced_tables(data);
 
+    sanitize_fadt_ptrs(data);
+
     if (iasl) {
         if (getenv(ACPI_REBUILD_EXPECTED_AML)) {
             dump_aml_files(data, true);
-- 
2.7.4
