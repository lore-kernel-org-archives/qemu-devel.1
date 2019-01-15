Received: from eggs.gnu.org ([209.51.188.92]:33661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUxJ-0006Og-Ni
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:05:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUxG-0002Ok-Lm
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:05:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjUxG-0002Ag-1L
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:04:58 -0500
Date: Tue, 15 Jan 2019 15:04:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-9-mst@redhat.com>
References: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 08/49] tests: acpi: use AcpiSdtTable::aml in
 consistent way
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

Currently in the 1st case we store table body fetched from QEMU in
AcpiSdtTable::aml minus it's header but in the 2nd case when we
load reference aml from disk, it holds whole blob including header.
More over in the 1st case, we read header in separate AcpiSdtTable::header
structure and then jump over hoops to fixup tables and combine both.

Treat AcpiSdtTable::aml as whole table blob approach in both cases
and when fetching tables from QEMU, first get table length and then
fetch whole table into AcpiSdtTable::aml instead if doing it field
by field.

As result
 * AcpiSdtTable::aml is used in consistent manner
 * FADT fixups use offsets from spec instead of being shifted by
   header length
 * calculating checksums and dumping blobs becomes simpler

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/acpi-utils.h       |  6 ++--
 tests/bios-tables-test.c | 62 +++++++++++++++-------------------------
 2 files changed, 27 insertions(+), 41 deletions(-)

diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
index c5b0e12aa2..1b0e80d45c 100644
--- a/tests/acpi-utils.h
+++ b/tests/acpi-utils.h
@@ -18,8 +18,10 @@
 
 /* DSDT and SSDTs format */
 typedef struct {
-    AcpiTableHeader header;
-    gchar *aml;            /* aml bytecode from guest */
+    union {
+        AcpiTableHeader *header;
+        uint8_t *aml;            /* aml bytecode from guest */
+    };
     gsize aml_len;
     gchar *aml_file;
     gchar *asl;            /* asl code generated from aml */
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index d455b2abfc..3f20bbd24e 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -163,29 +163,23 @@ static void sanitize_fadt_ptrs(test_data *data)
     for (i = 0; i < data->tables->len; i++) {
         AcpiSdtTable *sdt = &g_array_index(data->tables, AcpiSdtTable, i);
 
-        if (memcmp(&sdt->header.signature, "FACP", 4)) {
+        if (memcmp(&sdt->header->signature, "FACP", 4)) {
             continue;
         }
 
         /* check original FADT checksum before sanitizing table */
-        g_assert(!(uint8_t)(
-            acpi_calc_checksum((uint8_t *)sdt, sizeof(AcpiTableHeader)) +
-            acpi_calc_checksum((uint8_t *)sdt->aml, sdt->aml_len)
-        ));
+        g_assert(!acpi_calc_checksum(sdt->aml, sdt->aml_len));
 
-        /* sdt->aml field offset := spec offset - header size */
-        memset(sdt->aml + 0, 0, 4); /* sanitize FIRMWARE_CTRL(36) ptr */
-        memset(sdt->aml + 4, 0, 4); /* sanitize DSDT(40) ptr */
-        if (sdt->header.revision >= 3) {
-            memset(sdt->aml + 96, 0, 8); /* sanitize X_FIRMWARE_CTRL(132) ptr */
-            memset(sdt->aml + 104, 0, 8); /* sanitize X_DSDT(140) ptr */
+        memset(sdt->aml + 36, 0, 4); /* sanitize FIRMWARE_CTRL ptr */
+        memset(sdt->aml + 40, 0, 4); /* sanitize DSDT ptr */
+        if (sdt->header->revision >= 3) {
+            memset(sdt->aml + 132, 0, 8); /* sanitize X_FIRMWARE_CTRL ptr */
+            memset(sdt->aml + 140, 0, 8); /* sanitize X_DSDT ptr */
         }
 
         /* update checksum */
-        sdt->header.checksum = 0;
-        sdt->header.checksum -=
-            acpi_calc_checksum((uint8_t *)sdt, sizeof(AcpiTableHeader)) +
-            acpi_calc_checksum((uint8_t *)sdt->aml, sdt->aml_len);
+        sdt->header->checksum = 0;
+        sdt->header->checksum -= acpi_calc_checksum(sdt->aml, sdt->aml_len);
         break;
     }
 }
@@ -212,30 +206,23 @@ static void test_acpi_facs_table(test_data *data)
  */
 static void fetch_table(QTestState *qts, AcpiSdtTable *sdt_table, uint32_t addr)
 {
-    uint8_t checksum;
-
-    memset(sdt_table, 0, sizeof(*sdt_table));
-    ACPI_READ_TABLE_HEADER(qts, &sdt_table->header, addr);
-
-    sdt_table->aml_len = le32_to_cpu(sdt_table->header.length)
-                         - sizeof(AcpiTableHeader);
+    qtest_memread(qts, addr + 4 /* Length of ACPI table */,
+                  &sdt_table->aml_len, 4);
+    sdt_table->aml_len = le32_to_cpu(sdt_table->aml_len);
     sdt_table->aml = g_malloc0(sdt_table->aml_len);
-    ACPI_READ_ARRAY_PTR(qts, sdt_table->aml, sdt_table->aml_len, addr);
+    /* get whole table */
+    qtest_memread(qts, addr, sdt_table->aml, sdt_table->aml_len);
 
-    checksum = acpi_calc_checksum((uint8_t *)sdt_table,
-                                  sizeof(AcpiTableHeader)) +
-               acpi_calc_checksum((uint8_t *)sdt_table->aml,
-                                  sdt_table->aml_len);
-    g_assert(!checksum);
+    g_assert(!acpi_calc_checksum(sdt_table->aml, sdt_table->aml_len));
 }
 
 static void test_acpi_dsdt_table(test_data *data)
 {
-    AcpiSdtTable dsdt_table;
+    AcpiSdtTable dsdt_table = {};
     uint32_t addr = le32_to_cpu(data->dsdt_addr);
 
     fetch_table(data->qts, &dsdt_table, addr);
-    ACPI_ASSERT_CMP(dsdt_table.header.signature, "DSDT");
+    ACPI_ASSERT_CMP(dsdt_table.header->signature, "DSDT");
 
     /* Since DSDT isn't in RSDT, add DSDT to ASL test tables list manually */
     g_array_append_val(data->tables, dsdt_table);
@@ -248,7 +235,7 @@ static void fetch_rsdt_referenced_tables(test_data *data)
     int i;
 
     for (i = 0; i < tables_nr; i++) {
-        AcpiSdtTable ssdt_table;
+        AcpiSdtTable ssdt_table = {};
         uint32_t addr;
 
         addr = le32_to_cpu(data->rsdt_tables_addr[i]);
@@ -275,7 +262,7 @@ static void dump_aml_files(test_data *data, bool rebuild)
 
         if (rebuild) {
             aml_file = g_strdup_printf("%s/%s/%.4s%s", data_dir, data->machine,
-                                       (gchar *)&sdt->header.signature, ext);
+                                       (gchar *)&sdt->header->signature, ext);
             fd = g_open(aml_file, O_WRONLY|O_TRUNC|O_CREAT,
                         S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH);
         } else {
@@ -284,8 +271,6 @@ static void dump_aml_files(test_data *data, bool rebuild)
         }
         g_assert(fd >= 0);
 
-        ret = qemu_write_full(fd, sdt, sizeof(AcpiTableHeader));
-        g_assert(ret == sizeof(AcpiTableHeader));
         ret = qemu_write_full(fd, sdt->aml, sdt->aml_len);
         g_assert(ret == sdt->aml_len);
 
@@ -297,7 +282,7 @@ static void dump_aml_files(test_data *data, bool rebuild)
 
 static bool compare_signature(AcpiSdtTable *sdt, const char *signature)
 {
-   return !memcmp(&sdt->header.signature, signature, 4);
+   return !memcmp(&sdt->header->signature, signature, 4);
 }
 
 static bool load_asl(GArray *sdts, AcpiSdtTable *sdt)
@@ -395,11 +380,10 @@ static GArray *load_expected_aml(test_data *data)
         sdt = &g_array_index(data->tables, AcpiSdtTable, i);
 
         memset(&exp_sdt, 0, sizeof(exp_sdt));
-        exp_sdt.header.signature = sdt->header.signature;
 
 try_again:
         aml_file = g_strdup_printf("%s/%s/%.4s%s", data_dir, data->machine,
-                                   (gchar *)&sdt->header.signature, ext);
+                                   (gchar *)&sdt->header->signature, ext);
         if (getenv("V")) {
             fprintf(stderr, "Looking for expected file '%s'\n", aml_file);
         }
@@ -415,7 +399,7 @@ try_again:
         if (getenv("V")) {
             fprintf(stderr, "Using expected file '%s'\n", aml_file);
         }
-        ret = g_file_get_contents(aml_file, &exp_sdt.aml,
+        ret = g_file_get_contents(aml_file, (gchar **)&exp_sdt.aml,
                                   &exp_sdt.aml_len, &error);
         g_assert(ret);
         g_assert_no_error(error);
@@ -459,7 +443,7 @@ static void test_acpi_asl(test_data *data)
                 fprintf(stderr,
                         "Warning! iasl couldn't parse the expected aml\n");
             } else {
-                uint32_t signature = cpu_to_le32(exp_sdt->header.signature);
+                uint32_t signature = cpu_to_le32(exp_sdt->header->signature);
                 sdt->tmp_files_retain = true;
                 exp_sdt->tmp_files_retain = true;
                 fprintf(stderr,
-- 
MST
