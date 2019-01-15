Received: from eggs.gnu.org ([209.51.188.92]:33474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUxH-0006Ki-5h
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:05:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUxF-0002N4-SJ
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:04:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjUxE-0002Ir-T2
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:04:57 -0500
Date: Tue, 15 Jan 2019 15:04:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-15-mst@redhat.com>
References: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 14/49] tests: acpi: squash
 sanitize_fadt_ptrs() into test_acpi_fadt_table()
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

some parts of sanitize_fadt_ptrs() do redundant job
  - locating FADT
  - checking original checksum

There is no need to do it as test_acpi_fadt_table() already does that,
so drop duplicate code and move remaining fixup code into
test_acpi_fadt_table().

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/bios-tables-test.c | 39 ++++++++++-----------------------------
 1 file changed, 10 insertions(+), 29 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index dcd6be8bbd..9139decc68 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -128,6 +128,7 @@ static void test_acpi_fadt_table(test_data *data)
     /* FADT table is 1st */
     AcpiSdtTable table = g_array_index(data->tables, typeof(table), 0);
     uint8_t *fadt_aml = table.aml;
+    uint32_t fadt_len = table.aml_len;
 
     ACPI_ASSERT_CMP(table.header->signature, "FACP");
 
@@ -139,35 +140,17 @@ static void test_acpi_fadt_table(test_data *data)
     acpi_fetch_table(data->qts, &table.aml, &table.aml_len,
                      fadt_aml + 40 /* DSDT */, "DSDT", true);
     g_array_append_val(data->tables, table);
-}
 
-static void sanitize_fadt_ptrs(test_data *data)
-{
-    /* fixup pointers in FADT */
-    int i;
-
-    for (i = 0; i < data->tables->len; i++) {
-        AcpiSdtTable *sdt = &g_array_index(data->tables, AcpiSdtTable, i);
-
-        if (memcmp(&sdt->header->signature, "FACP", 4)) {
-            continue;
-        }
-
-        /* check original FADT checksum before sanitizing table */
-        g_assert(!acpi_calc_checksum(sdt->aml, sdt->aml_len));
-
-        memset(sdt->aml + 36, 0, 4); /* sanitize FIRMWARE_CTRL ptr */
-        memset(sdt->aml + 40, 0, 4); /* sanitize DSDT ptr */
-        if (sdt->header->revision >= 3) {
-            memset(sdt->aml + 132, 0, 8); /* sanitize X_FIRMWARE_CTRL ptr */
-            memset(sdt->aml + 140, 0, 8); /* sanitize X_DSDT ptr */
-        }
-
-        /* update checksum */
-        sdt->header->checksum = 0;
-        sdt->header->checksum -= acpi_calc_checksum(sdt->aml, sdt->aml_len);
-        break;
+    memset(fadt_aml + 36, 0, 4); /* sanitize FIRMWARE_CTRL ptr */
+    memset(fadt_aml + 40, 0, 4); /* sanitize DSDT ptr */
+    if (fadt_aml[8 /* FADT Major Version */] >= 3) {
+        memset(fadt_aml + 132, 0, 8); /* sanitize X_FIRMWARE_CTRL ptr */
+        memset(fadt_aml + 140, 0, 8); /* sanitize X_DSDT ptr */
     }
+
+    /* update checksum */
+    fadt_aml[9 /* Checksum */] = 0;
+    fadt_aml[9 /* Checksum */] -= acpi_calc_checksum(fadt_aml, fadt_len);
 }
 
 static void dump_aml_files(test_data *data, bool rebuild)
@@ -541,8 +524,6 @@ static void test_acpi_one(const char *params, test_data *data)
     test_acpi_rsdt_table(data);
     test_acpi_fadt_table(data);
 
-    sanitize_fadt_ptrs(data);
-
     if (iasl) {
         if (getenv(ACPI_REBUILD_EXPECTED_AML)) {
             dump_aml_files(data, true);
-- 
MST
