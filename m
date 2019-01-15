Received: from eggs.gnu.org ([209.51.188.92]:33873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUxM-0006Ra-Ql
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:05:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUxH-0002Py-4h
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:05:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjUxG-0002Fi-KB
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:04:58 -0500
Date: Tue, 15 Jan 2019 15:04:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-13-mst@redhat.com>
References: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 12/49] tests: acpi: reuse fetch_table() in
 vmgenid-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Ben Warren <ben@skyportsystems.com>

From: Igor Mammedov <imammedo@redhat.com>

Move fetch_table() into acpi-utils.c renaming it to acpi_fetch_table()
and reuse it in vmgenid-test that reads RSDT and then tables it references,
to find and parse VMGNEID SSDT.
While at it wrap RSDT referenced tables enumeration into FOREACH macro
(similar to what we do with QLIST_FOREACH & co) to reuse it with bios and
vmgenid tests.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/acpi-utils.h       | 23 +++++----------
 tests/acpi-utils.c       | 35 +++++++++++++++++-----
 tests/bios-tables-test.c | 55 ++++++++--------------------------
 tests/vmgenid-test.c     | 64 +++++++++++++---------------------------
 4 files changed, 67 insertions(+), 110 deletions(-)

diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
index 1b0e80d45c..1aa00db2b6 100644
--- a/tests/acpi-utils.h
+++ b/tests/acpi-utils.h
@@ -22,7 +22,7 @@ typedef struct {
         AcpiTableHeader *header;
         uint8_t *aml;            /* aml bytecode from guest */
     };
-    gsize aml_len;
+    uint32_t aml_len;
     gchar *aml_file;
     gchar *asl;            /* asl code generated from aml */
     gsize asl_len;
@@ -47,19 +47,6 @@ typedef struct {
 #define ACPI_READ_ARRAY(qts, arr, addr)                                 \
     ACPI_READ_ARRAY_PTR(qts, arr, sizeof(arr) / sizeof(arr[0]), addr)
 
-#define ACPI_READ_TABLE_HEADER(qts, table, addr)                 \
-    do {                                                         \
-        ACPI_READ_FIELD(qts, (table)->signature, addr);          \
-        ACPI_READ_FIELD(qts, (table)->length, addr);             \
-        ACPI_READ_FIELD(qts, (table)->revision, addr);           \
-        ACPI_READ_FIELD(qts, (table)->checksum, addr);           \
-        ACPI_READ_ARRAY(qts, (table)->oem_id, addr);             \
-        ACPI_READ_ARRAY(qts, (table)->oem_table_id, addr);       \
-        ACPI_READ_FIELD(qts, (table)->oem_revision, addr);       \
-        ACPI_READ_ARRAY(qts, (table)->asl_compiler_id, addr);    \
-        ACPI_READ_FIELD(qts, (table)->asl_compiler_revision, addr);     \
-    } while (0)
-
 #define ACPI_ASSERT_CMP(actual, expected) do { \
     char ACPI_ASSERT_CMP_str[5] = {}; \
     memcpy(ACPI_ASSERT_CMP_str, &actual, 4); \
@@ -73,11 +60,17 @@ typedef struct {
 } while (0)
 
 
+#define ACPI_FOREACH_RSDT_ENTRY(table, table_len, entry_ptr, entry_size) \
+    for (entry_ptr = table + 36 /* 1st Entry */;                         \
+         entry_ptr < table + table_len;                                  \
+         entry_ptr += entry_size)
 
 uint8_t acpi_calc_checksum(const uint8_t *data, int len);
 uint32_t acpi_find_rsdp_address(QTestState *qts);
-uint32_t acpi_get_rsdt_address(uint8_t *rsdp_table);
 uint64_t acpi_get_xsdt_address(uint8_t *rsdp_table);
 void acpi_parse_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table);
+void acpi_fetch_table(QTestState *qts, uint8_t **aml, uint32_t *aml_len,
+                      const uint8_t *addr_ptr, const char *sig,
+                      bool verify_checksum);
 
 #endif  /* TEST_ACPI_UTILS_H */
diff --git a/tests/acpi-utils.c b/tests/acpi-utils.c
index 17abcc43a4..cc33b460ab 100644
--- a/tests/acpi-utils.c
+++ b/tests/acpi-utils.c
@@ -51,14 +51,6 @@ uint32_t acpi_find_rsdp_address(QTestState *qts)
     return off;
 }
 
-uint32_t acpi_get_rsdt_address(uint8_t *rsdp_table)
-{
-    uint32_t rsdt_physical_address;
-
-    memcpy(&rsdt_physical_address, &rsdp_table[16 /* RsdtAddress offset */], 4);
-    return le32_to_cpu(rsdt_physical_address);
-}
-
 uint64_t acpi_get_xsdt_address(uint8_t *rsdp_table)
 {
     uint64_t xsdt_physical_address;
@@ -92,3 +84,30 @@ void acpi_parse_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table)
 
     ACPI_ASSERT_CMP64(*((uint64_t *)(rsdp_table)), "RSD PTR ");
 }
+
+/** acpi_fetch_table
+ *  load ACPI table at @addr_ptr offset pointer into buffer and return it in
+ *  @aml, its length in @aml_len and check that signature/checksum matches
+ *  actual one.
+ */
+void acpi_fetch_table(QTestState *qts, uint8_t **aml, uint32_t *aml_len,
+                      const uint8_t *addr_ptr, const char *sig,
+                      bool verify_checksum)
+{
+    uint32_t addr, len;
+
+    memcpy(&addr, addr_ptr , sizeof(addr));
+    addr = le32_to_cpu(addr);
+    qtest_memread(qts, addr + 4, &len, 4); /* Length of ACPI table */
+    *aml_len = le32_to_cpu(len);
+    *aml = g_malloc0(*aml_len);
+    /* get whole table */
+    qtest_memread(qts, addr, *aml, *aml_len);
+
+    if (sig) {
+        ACPI_ASSERT_CMP(**aml, sig);
+    }
+    if (verify_checksum) {
+        g_assert(!acpi_calc_checksum(*aml, *aml_len));
+    }
+}
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 0f6dd844c5..8fdd1c173a 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -72,34 +72,6 @@ static void free_test_data(test_data *data)
     g_array_free(data->tables, true);
 }
 
-/** fetch_table
- *   load ACPI table at @addr_ptr offset pointer into table descriptor
- *   @sdt_table and check that signature/checksum matches actual one.
- */
-static void fetch_table(QTestState *qts, AcpiSdtTable *sdt_table,
-                        uint8_t *addr_ptr, const char *sig,
-                        bool verify_checksum)
-{
-    uint32_t addr;
-
-    memcpy(&addr, addr_ptr , sizeof(addr));
-    addr = le32_to_cpu(addr);
-
-    qtest_memread(qts, addr + 4 /* Length of ACPI table */,
-                  &sdt_table->aml_len, 4);
-    sdt_table->aml_len = le32_to_cpu(sdt_table->aml_len);
-    sdt_table->aml = g_malloc0(sdt_table->aml_len);
-    /* get whole table */
-    qtest_memread(qts, addr, sdt_table->aml, sdt_table->aml_len);
-
-    if (sig) {
-        ACPI_ASSERT_CMP(sdt_table->header->signature, sig);
-    }
-    if (verify_checksum) {
-        g_assert(!acpi_calc_checksum(sdt_table->aml, sdt_table->aml_len));
-    }
-}
-
 static void test_acpi_rsdp_address(test_data *data)
 {
     uint32_t off = acpi_find_rsdp_address(data->qts);
@@ -132,23 +104,19 @@ static void test_acpi_rsdp_table(test_data *data)
 
 static void test_acpi_rsdt_table(test_data *data)
 {
-    const int entry_size = 4 /* 32-bit Entry size */;
-    const int tables_off = 36 /* 1st Entry */;
     AcpiSdtTable rsdt = {};
-    int i, table_len, table_nr;
+    uint8_t *ent;
 
-    fetch_table(data->qts, &rsdt, &data->rsdp_table[16 /* RsdtAddress */],
-                "RSDT", true);
+    /* read RSDT table */
+    acpi_fetch_table(data->qts, &rsdt.aml, &rsdt.aml_len,
+                     &data->rsdp_table[16 /* RsdtAddress */], "RSDT", true);
 
     /* Load all tables and add to test list directly RSDT referenced tables */
-    table_len = le32_to_cpu(rsdt.header->length);
-    table_nr = (table_len - tables_off) / entry_size;
-    for (i = 0; i < table_nr; i++) {
+    ACPI_FOREACH_RSDT_ENTRY(rsdt.aml, rsdt.aml_len, ent, 4 /* Entry size */) {
         AcpiSdtTable ssdt_table = {};
 
-        fetch_table(data->qts, &ssdt_table,
-                    rsdt.aml + tables_off + i * entry_size, NULL, true);
-
+        acpi_fetch_table(data->qts, &ssdt_table.aml, &ssdt_table.aml_len, ent,
+                         NULL, true);
         /* Add table to ASL test tables list */
         g_array_append_val(data->tables, ssdt_table);
     }
@@ -164,11 +132,12 @@ static void test_acpi_fadt_table(test_data *data)
     ACPI_ASSERT_CMP(table.header->signature, "FACP");
 
     /* Since DSDT/FACS isn't in RSDT, add them to ASL test list manually */
-    fetch_table(data->qts, &table, fadt_aml + 36 /* FIRMWARE_CTRL */,
-                "FACS", false);
+    acpi_fetch_table(data->qts, &table.aml, &table.aml_len,
+                     fadt_aml + 36 /* FIRMWARE_CTRL */, "FACS", false);
     g_array_append_val(data->tables, table);
 
-    fetch_table(data->qts, &table, fadt_aml + 40 /* DSDT */, "DSDT", true);
+    acpi_fetch_table(data->qts, &table.aml, &table.aml_len,
+                     fadt_aml + 40 /* DSDT */, "DSDT", true);
     g_array_append_val(data->tables, table);
 }
 
@@ -355,7 +324,7 @@ try_again:
             fprintf(stderr, "Using expected file '%s'\n", aml_file);
         }
         ret = g_file_get_contents(aml_file, (gchar **)&exp_sdt.aml,
-                                  &exp_sdt.aml_len, &error);
+                                  (gsize *)&exp_sdt.aml_len, &error);
         g_assert(ret);
         g_assert_no_error(error);
         g_assert(exp_sdt.aml);
diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
index 1c1d435bbd..52cdd83ec0 100644
--- a/tests/vmgenid-test.c
+++ b/tests/vmgenid-test.c
@@ -23,26 +23,13 @@
                                   */
 #define RSDP_ADDR_INVALID 0x100000 /* RSDP must be below this address */
 
-typedef struct {
-    AcpiTableHeader header;
-    gchar name_op;
-    gchar vgia[4];
-    gchar val_op;
-    uint32_t vgia_val;
-} QEMU_PACKED VgidTable;
-
 static uint32_t acpi_find_vgia(QTestState *qts)
 {
     uint32_t rsdp_offset;
     uint32_t guid_offset = 0;
     uint8_t rsdp_table[36 /* ACPI 2.0+ RSDP size */];
-    uint32_t rsdt, rsdt_table_length;
-    AcpiRsdtDescriptorRev1 rsdt_table;
-    size_t tables_nr;
-    uint32_t *tables;
-    AcpiTableHeader ssdt_table;
-    VgidTable vgid_table;
-    int i;
+    uint32_t rsdt_len, table_length;
+    uint8_t *rsdt, *ent;
 
     /* Wait for guest firmware to finish and start the payload. */
     boot_sector_test(qts);
@@ -52,48 +39,37 @@ static uint32_t acpi_find_vgia(QTestState *qts)
 
     g_assert_cmphex(rsdp_offset, <, RSDP_ADDR_INVALID);
 
+
     acpi_parse_rsdp_table(qts, rsdp_offset, rsdp_table);
+    acpi_fetch_table(qts, &rsdt, &rsdt_len, &rsdp_table[16 /* RsdtAddress */],
+                     "RSDT", true);
 
-    rsdt = acpi_get_rsdt_address(rsdp_table);
-    g_assert(rsdt);
+    ACPI_FOREACH_RSDT_ENTRY(rsdt, rsdt_len, ent, 4 /* Entry size */) {
+        uint8_t *table_aml;
 
-    /* read the header */
-    ACPI_READ_TABLE_HEADER(qts, &rsdt_table, rsdt);
-    ACPI_ASSERT_CMP(rsdt_table.signature, "RSDT");
-    rsdt_table_length = le32_to_cpu(rsdt_table.length);
-
-    /* compute the table entries in rsdt */
-    g_assert_cmpint(rsdt_table_length, >, sizeof(AcpiRsdtDescriptorRev1));
-    tables_nr = (rsdt_table_length - sizeof(AcpiRsdtDescriptorRev1)) /
-                sizeof(uint32_t);
-
-    /* get the addresses of the tables pointed by rsdt */
-    tables = g_new0(uint32_t, tables_nr);
-    ACPI_READ_ARRAY_PTR(qts, tables, tables_nr, rsdt);
-
-    for (i = 0; i < tables_nr; i++) {
-        uint32_t addr = le32_to_cpu(tables[i]);
-        ACPI_READ_TABLE_HEADER(qts, &ssdt_table, addr);
-        if (!strncmp((char *)ssdt_table.oem_table_id, "VMGENID", 7)) {
+        acpi_fetch_table(qts, &table_aml, &table_length, ent, NULL, true);
+        if (!memcmp(table_aml + 16 /* OEM Table ID */, "VMGENID", 7)) {
+            uint32_t vgia_val;
+            uint8_t *aml = &table_aml[36 /* AML byte-code start */];
             /* the first entry in the table should be VGIA
              * That's all we need
              */
-            ACPI_READ_FIELD(qts, vgid_table.name_op, addr);
-            g_assert(vgid_table.name_op == 0x08);  /* name */
-            ACPI_READ_ARRAY(qts, vgid_table.vgia, addr);
-            g_assert(memcmp(vgid_table.vgia, "VGIA", 4) == 0);
-            ACPI_READ_FIELD(qts, vgid_table.val_op, addr);
-            g_assert(vgid_table.val_op == 0x0C);  /* dword */
-            ACPI_READ_FIELD(qts, vgid_table.vgia_val, addr);
+            g_assert(aml[0 /* name_op*/] == 0x08);
+            g_assert(memcmp(&aml[1 /* name */], "VGIA", 4) == 0);
+            g_assert(aml[5 /* value op */] == 0x0C /* dword */);
+            memcpy(&vgia_val, &aml[6 /* value */], 4);
+
             /* The GUID is written at a fixed offset into the fw_cfg file
              * in order to implement the "OVMF SDT Header probe suppressor"
              * see docs/specs/vmgenid.txt for more details
              */
-            guid_offset = le32_to_cpu(vgid_table.vgia_val) + VMGENID_GUID_OFFSET;
+            guid_offset = le32_to_cpu(vgia_val) + VMGENID_GUID_OFFSET;
+            g_free(table_aml);
             break;
         }
+        g_free(table_aml);
     }
-    g_free(tables);
+    g_free(rsdt);
     return guid_offset;
 }
 
-- 
MST
