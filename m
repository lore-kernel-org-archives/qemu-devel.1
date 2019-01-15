Received: from eggs.gnu.org ([209.51.188.92]:34033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUxQ-0006W9-LG
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:05:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUxK-0002XR-HH
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:05:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjUxI-0002DT-9y
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:05:02 -0500
Date: Tue, 15 Jan 2019 15:04:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-12-mst@redhat.com>
References: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 11/49] tests: acpi: reuse fetch_table() for
 fetching FACS and DSDT
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

It allows to remove a bit more of code duplication and
reuse common utility to get ACPI tables from guest (modulo RSDP).

While at it, consolidate signature checking into fetch_table() instead
of open-codding it.

Considering FACS is special and doesn't have checksum, make checksum
validation optin, the same goes for signature verification.

PS:
By pure accident, patch also fixes FACS not being tested against
reference table since it wasn't added to data::tables list.
But we managed not to regress it since reference file was added
by commit
   (d25979380 acpi unit-test: add test files)
back in 2013

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/bios-tables-test.c | 78 ++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 48 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 8082adce41..0f6dd844c5 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -28,9 +28,6 @@ typedef struct {
     const char *variant;
     uint32_t rsdp_addr;
     uint8_t rsdp_table[36 /* ACPI 2.0+ RSDP size */];
-    uint32_t dsdt_addr;
-    uint32_t facs_addr;
-    AcpiFacsDescriptorRev1 facs_table;
     GArray *tables;
     uint32_t smbios_ep_addr;
     struct smbios_21_entry_point smbios_ep_table;
@@ -76,11 +73,18 @@ static void free_test_data(test_data *data)
 }
 
 /** fetch_table
- *   load ACPI table at @addr into table descriptor @sdt_table
- *   and check that header checksum matches actual one.
+ *   load ACPI table at @addr_ptr offset pointer into table descriptor
+ *   @sdt_table and check that signature/checksum matches actual one.
  */
-static void fetch_table(QTestState *qts, AcpiSdtTable *sdt_table, uint32_t addr)
+static void fetch_table(QTestState *qts, AcpiSdtTable *sdt_table,
+                        uint8_t *addr_ptr, const char *sig,
+                        bool verify_checksum)
 {
+    uint32_t addr;
+
+    memcpy(&addr, addr_ptr , sizeof(addr));
+    addr = le32_to_cpu(addr);
+
     qtest_memread(qts, addr + 4 /* Length of ACPI table */,
                   &sdt_table->aml_len, 4);
     sdt_table->aml_len = le32_to_cpu(sdt_table->aml_len);
@@ -88,7 +92,12 @@ static void fetch_table(QTestState *qts, AcpiSdtTable *sdt_table, uint32_t addr)
     /* get whole table */
     qtest_memread(qts, addr, sdt_table->aml, sdt_table->aml_len);
 
-    g_assert(!acpi_calc_checksum(sdt_table->aml, sdt_table->aml_len));
+    if (sig) {
+        ACPI_ASSERT_CMP(sdt_table->header->signature, sig);
+    }
+    if (verify_checksum) {
+        g_assert(!acpi_calc_checksum(sdt_table->aml, sdt_table->aml_len));
+    }
 }
 
 static void test_acpi_rsdp_address(test_data *data)
@@ -123,15 +132,13 @@ static void test_acpi_rsdp_table(test_data *data)
 
 static void test_acpi_rsdt_table(test_data *data)
 {
-    uint32_t addr = acpi_get_rsdt_address(data->rsdp_table);
     const int entry_size = 4 /* 32-bit Entry size */;
     const int tables_off = 36 /* 1st Entry */;
     AcpiSdtTable rsdt = {};
     int i, table_len, table_nr;
-    uint32_t *entry;
 
-    fetch_table(data->qts, &rsdt, addr);
-    ACPI_ASSERT_CMP(rsdt.header->signature, "RSDT");
+    fetch_table(data->qts, &rsdt, &data->rsdp_table[16 /* RsdtAddress */],
+                "RSDT", true);
 
     /* Load all tables and add to test list directly RSDT referenced tables */
     table_len = le32_to_cpu(rsdt.header->length);
@@ -139,9 +146,8 @@ static void test_acpi_rsdt_table(test_data *data)
     for (i = 0; i < table_nr; i++) {
         AcpiSdtTable ssdt_table = {};
 
-        entry = (uint32_t *)(rsdt.aml + tables_off + i * entry_size);
-        addr = le32_to_cpu(*entry);
-        fetch_table(data->qts, &ssdt_table, addr);
+        fetch_table(data->qts, &ssdt_table,
+                    rsdt.aml + tables_off + i * entry_size, NULL, true);
 
         /* Add table to ASL test tables list */
         g_array_append_val(data->tables, ssdt_table);
@@ -152,12 +158,18 @@ static void test_acpi_rsdt_table(test_data *data)
 static void test_acpi_fadt_table(test_data *data)
 {
     /* FADT table is 1st */
-    AcpiSdtTable *fadt = &g_array_index(data->tables, typeof(*fadt), 0);
+    AcpiSdtTable table = g_array_index(data->tables, typeof(table), 0);
+    uint8_t *fadt_aml = table.aml;
 
-    ACPI_ASSERT_CMP(fadt->header->signature, "FACP");
+    ACPI_ASSERT_CMP(table.header->signature, "FACP");
 
-    memcpy(&data->facs_addr, fadt->aml + 36 /* FIRMWARE_CTRL */, 4);
-    memcpy(&data->dsdt_addr, fadt->aml + 40 /* DSDT */, 4);
+    /* Since DSDT/FACS isn't in RSDT, add them to ASL test list manually */
+    fetch_table(data->qts, &table, fadt_aml + 36 /* FIRMWARE_CTRL */,
+                "FACS", false);
+    g_array_append_val(data->tables, table);
+
+    fetch_table(data->qts, &table, fadt_aml + 40 /* DSDT */, "DSDT", true);
+    g_array_append_val(data->tables, table);
 }
 
 static void sanitize_fadt_ptrs(test_data *data)
@@ -189,34 +201,6 @@ static void sanitize_fadt_ptrs(test_data *data)
     }
 }
 
-static void test_acpi_facs_table(test_data *data)
-{
-    AcpiFacsDescriptorRev1 *facs_table = &data->facs_table;
-    uint32_t addr = le32_to_cpu(data->facs_addr);
-
-    ACPI_READ_FIELD(data->qts, facs_table->signature, addr);
-    ACPI_READ_FIELD(data->qts, facs_table->length, addr);
-    ACPI_READ_FIELD(data->qts, facs_table->hardware_signature, addr);
-    ACPI_READ_FIELD(data->qts, facs_table->firmware_waking_vector, addr);
-    ACPI_READ_FIELD(data->qts, facs_table->global_lock, addr);
-    ACPI_READ_FIELD(data->qts, facs_table->flags, addr);
-    ACPI_READ_ARRAY(data->qts, facs_table->resverved3, addr);
-
-    ACPI_ASSERT_CMP(facs_table->signature, "FACS");
-}
-
-static void test_acpi_dsdt_table(test_data *data)
-{
-    AcpiSdtTable dsdt_table = {};
-    uint32_t addr = le32_to_cpu(data->dsdt_addr);
-
-    fetch_table(data->qts, &dsdt_table, addr);
-    ACPI_ASSERT_CMP(dsdt_table.header->signature, "DSDT");
-
-    /* Since DSDT isn't in RSDT, add DSDT to ASL test tables list manually */
-    g_array_append_val(data->tables, dsdt_table);
-}
-
 static void dump_aml_files(test_data *data, bool rebuild)
 {
     AcpiSdtTable *sdt;
@@ -600,8 +584,6 @@ static void test_acpi_one(const char *params, test_data *data)
     test_acpi_rsdp_table(data);
     test_acpi_rsdt_table(data);
     test_acpi_fadt_table(data);
-    test_acpi_facs_table(data);
-    test_acpi_dsdt_table(data);
 
     sanitize_fadt_ptrs(data);
 
-- 
MST
