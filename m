Received: from eggs.gnu.org ([2001:4830:134:3::10]:33075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eFFxl-0002au-Sg
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 03:56:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eFFxj-0006WJ-FV
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 03:55:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eFFxj-0006Pt-6u
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 03:55:55 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A1DA6C053FBA
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 08:55:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 16 Nov 2017 09:55:46 +0100
Message-Id: <1510822546-14763-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11] tests/bios-tables-test: Fix endianess
 problems when passing data to iasl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The bios-tables-test was writing out files that we pass to iasl in
with the wrong endianness in the header when running on a big endian
host. So instead of storing mixed endian information in our structures,
let's keep everything in little endian and byte-swap it only when we
need a value in the code.

Reported-by: Daniel P. Berrange <berrange@redhat.com>
Buglink: https://bugs.launchpad.net/qemu/+bug/1724570
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/acpi-utils.h       | 27 +++++----------------------
 tests/bios-tables-test.c | 42 ++++++++++++++++++++++--------------------
 2 files changed, 27 insertions(+), 42 deletions(-)

diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
index f8d8723..d5ca5b6 100644
--- a/tests/acpi-utils.h
+++ b/tests/acpi-utils.h
@@ -28,24 +28,9 @@ typedef struct {
     bool tmp_files_retain;   /* do not delete the temp asl/aml */
 } AcpiSdtTable;
 
-#define ACPI_READ_FIELD(field, addr)           \
-    do {                                       \
-        switch (sizeof(field)) {               \
-        case 1:                                \
-            field = readb(addr);               \
-            break;                             \
-        case 2:                                \
-            field = readw(addr);               \
-            break;                             \
-        case 4:                                \
-            field = readl(addr);               \
-            break;                             \
-        case 8:                                \
-            field = readq(addr);               \
-            break;                             \
-        default:                               \
-            g_assert(false);                   \
-        }                                      \
+#define ACPI_READ_FIELD(field, addr)            \
+    do {                                        \
+        memread(addr, &field, sizeof(field));   \
         addr += sizeof(field);                  \
     } while (0);
 
@@ -74,16 +59,14 @@ typedef struct {
     } while (0);
 
 #define ACPI_ASSERT_CMP(actual, expected) do { \
-    uint32_t ACPI_ASSERT_CMP_le = cpu_to_le32(actual); \
     char ACPI_ASSERT_CMP_str[5] = {}; \
-    memcpy(ACPI_ASSERT_CMP_str, &ACPI_ASSERT_CMP_le, 4); \
+    memcpy(ACPI_ASSERT_CMP_str, &actual, 4); \
     g_assert_cmpstr(ACPI_ASSERT_CMP_str, ==, expected); \
 } while (0)
 
 #define ACPI_ASSERT_CMP64(actual, expected) do { \
-    uint64_t ACPI_ASSERT_CMP_le = cpu_to_le64(actual); \
     char ACPI_ASSERT_CMP_str[9] = {}; \
-    memcpy(ACPI_ASSERT_CMP_str, &ACPI_ASSERT_CMP_le, 8); \
+    memcpy(ACPI_ASSERT_CMP_str, &actual, 8); \
     g_assert_cmpstr(ACPI_ASSERT_CMP_str, ==, expected); \
 } while (0)
 
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 564da45..e28e0c9 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -96,17 +96,20 @@ static void test_acpi_rsdp_table(test_data *data)
 static void test_acpi_rsdt_table(test_data *data)
 {
     AcpiRsdtDescriptorRev1 *rsdt_table = &data->rsdt_table;
-    uint32_t addr = data->rsdp_table.rsdt_physical_address;
+    uint32_t addr = le32_to_cpu(data->rsdp_table.rsdt_physical_address);
     uint32_t *tables;
     int tables_nr;
     uint8_t checksum;
+    uint32_t rsdt_table_length;
 
     /* read the header */
     ACPI_READ_TABLE_HEADER(rsdt_table, addr);
     ACPI_ASSERT_CMP(rsdt_table->signature, "RSDT");
 
+    rsdt_table_length = le32_to_cpu(rsdt_table->length);
+
     /* compute the table entries in rsdt */
-    tables_nr = (rsdt_table->length - sizeof(AcpiRsdtDescriptorRev1)) /
+    tables_nr = (rsdt_table_length - sizeof(AcpiRsdtDescriptorRev1)) /
                 sizeof(uint32_t);
     g_assert(tables_nr > 0);
 
@@ -114,7 +117,7 @@ static void test_acpi_rsdt_table(test_data *data)
     tables = g_new0(uint32_t, tables_nr);
     ACPI_READ_ARRAY_PTR(tables, tables_nr, addr);
 
-    checksum = acpi_calc_checksum((uint8_t *)rsdt_table, rsdt_table->length) +
+    checksum = acpi_calc_checksum((uint8_t *)rsdt_table, rsdt_table_length) +
                acpi_calc_checksum((uint8_t *)tables,
                                   tables_nr * sizeof(uint32_t));
     g_assert(!checksum);
@@ -130,7 +133,7 @@ static void test_acpi_fadt_table(test_data *data)
     uint32_t addr;
 
     /* FADT table comes first */
-    addr = data->rsdt_tables_addr[0];
+    addr = le32_to_cpu(data->rsdt_tables_addr[0]);
     ACPI_READ_TABLE_HEADER(fadt_table, addr);
 
     ACPI_READ_FIELD(fadt_table->firmware_ctrl, addr);
@@ -187,13 +190,14 @@ static void test_acpi_fadt_table(test_data *data)
     ACPI_READ_GENERIC_ADDRESS(fadt_table->xgpe1_block, addr);
 
     ACPI_ASSERT_CMP(fadt_table->signature, "FACP");
-    g_assert(!acpi_calc_checksum((uint8_t *)fadt_table, fadt_table->length));
+    g_assert(!acpi_calc_checksum((uint8_t *)fadt_table,
+                                 le32_to_cpu(fadt_table->length)));
 }
 
 static void test_acpi_facs_table(test_data *data)
 {
     AcpiFacsDescriptorRev1 *facs_table = &data->facs_table;
-    uint32_t addr = data->fadt_table.firmware_ctrl;
+    uint32_t addr = le32_to_cpu(data->fadt_table.firmware_ctrl);
 
     ACPI_READ_FIELD(facs_table->signature, addr);
     ACPI_READ_FIELD(facs_table->length, addr);
@@ -212,7 +216,8 @@ static void test_dst_table(AcpiSdtTable *sdt_table, uint32_t addr)
 
     ACPI_READ_TABLE_HEADER(&sdt_table->header, addr);
 
-    sdt_table->aml_len = sdt_table->header.length - sizeof(AcpiTableHeader);
+    sdt_table->aml_len = le32_to_cpu(sdt_table->header.length)
+                         - sizeof(AcpiTableHeader);
     sdt_table->aml = g_malloc0(sdt_table->aml_len);
     ACPI_READ_ARRAY_PTR(sdt_table->aml, sdt_table->aml_len, addr);
 
@@ -226,7 +231,7 @@ static void test_dst_table(AcpiSdtTable *sdt_table, uint32_t addr)
 static void test_acpi_dsdt_table(test_data *data)
 {
     AcpiSdtTable dsdt_table;
-    uint32_t addr = data->fadt_table.dsdt;
+    uint32_t addr = le32_to_cpu(data->fadt_table.dsdt);
 
     memset(&dsdt_table, 0, sizeof(dsdt_table));
     data->tables = g_array_new(false, true, sizeof(AcpiSdtTable));
@@ -245,9 +250,10 @@ static void test_acpi_tables(test_data *data)
 
     for (i = 0; i < tables_nr; i++) {
         AcpiSdtTable ssdt_table;
+        uint32_t addr;
 
         memset(&ssdt_table, 0, sizeof(ssdt_table));
-        uint32_t addr = data->rsdt_tables_addr[i + 1]; /* fadt is first */
+        addr = le32_to_cpu(data->rsdt_tables_addr[i + 1]); /* fadt is first */
         test_dst_table(&ssdt_table, addr);
         g_array_append_val(data->tables, ssdt_table);
     }
@@ -268,9 +274,8 @@ static void dump_aml_files(test_data *data, bool rebuild)
         g_assert(sdt->aml);
 
         if (rebuild) {
-            uint32_t signature = cpu_to_le32(sdt->header.signature);
             aml_file = g_strdup_printf("%s/%s/%.4s%s", data_dir, data->machine,
-                                       (gchar *)&signature, ext);
+                                       (gchar *)&sdt->header.signature, ext);
             fd = g_open(aml_file, O_WRONLY|O_TRUNC|O_CREAT,
                         S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH);
         } else {
@@ -381,7 +386,6 @@ static GArray *load_expected_aml(test_data *data)
     GArray *exp_tables = g_array_new(false, true, sizeof(AcpiSdtTable));
     for (i = 0; i < data->tables->len; ++i) {
         AcpiSdtTable exp_sdt;
-        uint32_t signature;
         gchar *aml_file = NULL;
         const char *ext = data->variant ? data->variant : "";
 
@@ -390,11 +394,9 @@ static GArray *load_expected_aml(test_data *data)
         memset(&exp_sdt, 0, sizeof(exp_sdt));
         exp_sdt.header.signature = sdt->header.signature;
 
-        signature = cpu_to_le32(sdt->header.signature);
-
 try_again:
         aml_file = g_strdup_printf("%s/%s/%.4s%s", data_dir, data->machine,
-                                   (gchar *)&signature, ext);
+                                   (gchar *)&sdt->header.signature, ext);
         if (getenv("V")) {
             fprintf(stderr, "\nLooking for expected file '%s'\n", aml_file);
         }
@@ -571,12 +573,12 @@ static void test_smbios_structs(test_data *data)
 {
     DECLARE_BITMAP(struct_bitmap, SMBIOS_MAX_TYPE+1) = { 0 };
     struct smbios_21_entry_point *ep_table = &data->smbios_ep_table;
-    uint32_t addr = ep_table->structure_table_address;
+    uint32_t addr = le32_to_cpu(ep_table->structure_table_address);
     int i, len, max_len = 0;
     uint8_t type, prv, crt;
 
     /* walk the smbios tables */
-    for (i = 0; i < ep_table->number_of_structures; i++) {
+    for (i = 0; i < le16_to_cpu(ep_table->number_of_structures); i++) {
 
         /* grab type and formatted area length from struct header */
         type = readb(addr);
@@ -608,9 +610,9 @@ static void test_smbios_structs(test_data *data)
     }
 
     /* total table length and max struct size must match entry point values */
-    g_assert_cmpuint(ep_table->structure_table_length, ==,
-                     addr - ep_table->structure_table_address);
-    g_assert_cmpuint(ep_table->max_structure_size, ==, max_len);
+    g_assert_cmpuint(le16_to_cpu(ep_table->structure_table_length), ==,
+                     addr - le32_to_cpu(ep_table->structure_table_address));
+    g_assert_cmpuint(le16_to_cpu(ep_table->max_structure_size), ==, max_len);
 
     /* required struct types must all be present */
     for (i = 0; i < data->required_struct_types_len; i++) {
-- 
1.8.3.1
