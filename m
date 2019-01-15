Received: from eggs.gnu.org ([209.51.188.92]:34103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUxW-0006g0-3G
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:05:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUxJ-0002Uj-GV
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:05:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58409)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjUxH-0002Cl-Tw
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:05:01 -0500
Date: Tue, 15 Jan 2019 15:04:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-11-mst@redhat.com>
References: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 10/49] tests: acpi: simplify rsdt handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

RSDT referenced tables always have length at offset 4 and checksum at
offset 9, that's enough for reusing fetch_table() and replacing custom
RSDT fetching code with it.
While at it
 * merge fetch_rsdt_referenced_tables() into test_acpi_rsdt_table()
 * drop test_data::rsdt_table/rsdt_tables_addr/rsdt_tables_nr since
   we need this data only for duration of test_acpi_rsdt_table() to
   fetch other tables and use locals instead.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/bios-tables-test.c | 133 ++++++++++++++++-----------------------
 1 file changed, 53 insertions(+), 80 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index b2a40bbda3..8082adce41 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -28,12 +28,9 @@ typedef struct {
     const char *variant;
     uint32_t rsdp_addr;
     uint8_t rsdp_table[36 /* ACPI 2.0+ RSDP size */];
-    AcpiRsdtDescriptorRev1 rsdt_table;
     uint32_t dsdt_addr;
     uint32_t facs_addr;
     AcpiFacsDescriptorRev1 facs_table;
-    uint32_t *rsdt_tables_addr;
-    int rsdt_tables_nr;
     GArray *tables;
     uint32_t smbios_ep_addr;
     struct smbios_21_entry_point smbios_ep_table;
@@ -50,33 +47,50 @@ static const char *iasl = stringify(CONFIG_IASL);
 static const char *iasl;
 #endif
 
+static void cleanup_table_descriptor(AcpiSdtTable *table)
+{
+    g_free(table->aml);
+    if (table->aml_file &&
+        !table->tmp_files_retain &&
+        g_strstr_len(table->aml_file, -1, "aml-")) {
+        unlink(table->aml_file);
+    }
+    g_free(table->aml_file);
+    g_free(table->asl);
+    if (table->asl_file &&
+        !table->tmp_files_retain) {
+        unlink(table->asl_file);
+    }
+    g_free(table->asl_file);
+}
+
 static void free_test_data(test_data *data)
 {
-    AcpiSdtTable *temp;
     int i;
 
-    g_free(data->rsdt_tables_addr);
-
     for (i = 0; i < data->tables->len; ++i) {
-        temp = &g_array_index(data->tables, AcpiSdtTable, i);
-        g_free(temp->aml);
-        if (temp->aml_file &&
-            !temp->tmp_files_retain &&
-            g_strstr_len(temp->aml_file, -1, "aml-")) {
-            unlink(temp->aml_file);
-        }
-        g_free(temp->aml_file);
-        g_free(temp->asl);
-        if (temp->asl_file &&
-            !temp->tmp_files_retain) {
-            unlink(temp->asl_file);
-        }
-        g_free(temp->asl_file);
+        cleanup_table_descriptor(&g_array_index(data->tables, AcpiSdtTable, i));
     }
 
     g_array_free(data->tables, true);
 }
 
+/** fetch_table
+ *   load ACPI table at @addr into table descriptor @sdt_table
+ *   and check that header checksum matches actual one.
+ */
+static void fetch_table(QTestState *qts, AcpiSdtTable *sdt_table, uint32_t addr)
+{
+    qtest_memread(qts, addr + 4 /* Length of ACPI table */,
+                  &sdt_table->aml_len, 4);
+    sdt_table->aml_len = le32_to_cpu(sdt_table->aml_len);
+    sdt_table->aml = g_malloc0(sdt_table->aml_len);
+    /* get whole table */
+    qtest_memread(qts, addr, sdt_table->aml, sdt_table->aml_len);
+
+    g_assert(!acpi_calc_checksum(sdt_table->aml, sdt_table->aml_len));
+}
+
 static void test_acpi_rsdp_address(test_data *data)
 {
     uint32_t off = acpi_find_rsdp_address(data->qts);
@@ -109,36 +123,30 @@ static void test_acpi_rsdp_table(test_data *data)
 
 static void test_acpi_rsdt_table(test_data *data)
 {
-    AcpiRsdtDescriptorRev1 *rsdt_table = &data->rsdt_table;
     uint32_t addr = acpi_get_rsdt_address(data->rsdp_table);
-    uint32_t *tables;
-    int tables_nr;
-    uint8_t checksum;
-    uint32_t rsdt_table_length;
+    const int entry_size = 4 /* 32-bit Entry size */;
+    const int tables_off = 36 /* 1st Entry */;
+    AcpiSdtTable rsdt = {};
+    int i, table_len, table_nr;
+    uint32_t *entry;
 
-    /* read the header */
-    ACPI_READ_TABLE_HEADER(data->qts, rsdt_table, addr);
-    ACPI_ASSERT_CMP(rsdt_table->signature, "RSDT");
+    fetch_table(data->qts, &rsdt, addr);
+    ACPI_ASSERT_CMP(rsdt.header->signature, "RSDT");
 
-    rsdt_table_length = le32_to_cpu(rsdt_table->length);
+    /* Load all tables and add to test list directly RSDT referenced tables */
+    table_len = le32_to_cpu(rsdt.header->length);
+    table_nr = (table_len - tables_off) / entry_size;
+    for (i = 0; i < table_nr; i++) {
+        AcpiSdtTable ssdt_table = {};
 
-    /* compute the table entries in rsdt */
-    tables_nr = (rsdt_table_length - sizeof(AcpiRsdtDescriptorRev1)) /
-                sizeof(uint32_t);
-    g_assert(tables_nr > 0);
+        entry = (uint32_t *)(rsdt.aml + tables_off + i * entry_size);
+        addr = le32_to_cpu(*entry);
+        fetch_table(data->qts, &ssdt_table, addr);
 
-    /* get the addresses of the tables pointed by rsdt */
-    tables = g_new0(uint32_t, tables_nr);
-    ACPI_READ_ARRAY_PTR(data->qts, tables, tables_nr, addr);
-
-    checksum = acpi_calc_checksum((uint8_t *)rsdt_table, rsdt_table_length) +
-               acpi_calc_checksum((uint8_t *)tables,
-                                  tables_nr * sizeof(uint32_t));
-    g_assert(!checksum);
-
-   /* SSDT tables after FADT */
-    data->rsdt_tables_addr = tables;
-    data->rsdt_tables_nr = tables_nr;
+        /* Add table to ASL test tables list */
+        g_array_append_val(data->tables, ssdt_table);
+    }
+    cleanup_table_descriptor(&rsdt);
 }
 
 static void test_acpi_fadt_table(test_data *data)
@@ -197,22 +205,6 @@ static void test_acpi_facs_table(test_data *data)
     ACPI_ASSERT_CMP(facs_table->signature, "FACS");
 }
 
-/** fetch_table
- *   load ACPI table at @addr into table descriptor @sdt_table
- *   and check that header checksum matches actual one.
- */
-static void fetch_table(QTestState *qts, AcpiSdtTable *sdt_table, uint32_t addr)
-{
-    qtest_memread(qts, addr + 4 /* Length of ACPI table */,
-                  &sdt_table->aml_len, 4);
-    sdt_table->aml_len = le32_to_cpu(sdt_table->aml_len);
-    sdt_table->aml = g_malloc0(sdt_table->aml_len);
-    /* get whole table */
-    qtest_memread(qts, addr, sdt_table->aml, sdt_table->aml_len);
-
-    g_assert(!acpi_calc_checksum(sdt_table->aml, sdt_table->aml_len));
-}
-
 static void test_acpi_dsdt_table(test_data *data)
 {
     AcpiSdtTable dsdt_table = {};
@@ -225,24 +217,6 @@ static void test_acpi_dsdt_table(test_data *data)
     g_array_append_val(data->tables, dsdt_table);
 }
 
-/* Load all tables and add to test list directly RSDT referenced tables */
-static void fetch_rsdt_referenced_tables(test_data *data)
-{
-    int tables_nr = data->rsdt_tables_nr;
-    int i;
-
-    for (i = 0; i < tables_nr; i++) {
-        AcpiSdtTable ssdt_table = {};
-        uint32_t addr;
-
-        addr = le32_to_cpu(data->rsdt_tables_addr[i]);
-        fetch_table(data->qts, &ssdt_table, addr);
-
-        /* Add table to ASL test tables list */
-        g_array_append_val(data->tables, ssdt_table);
-    }
-}
-
 static void dump_aml_files(test_data *data, bool rebuild)
 {
     AcpiSdtTable *sdt;
@@ -625,7 +599,6 @@ static void test_acpi_one(const char *params, test_data *data)
     test_acpi_rsdp_address(data);
     test_acpi_rsdp_table(data);
     test_acpi_rsdt_table(data);
-    fetch_rsdt_referenced_tables(data);
     test_acpi_fadt_table(data);
     test_acpi_facs_table(data);
     test_acpi_dsdt_table(data);
-- 
MST
