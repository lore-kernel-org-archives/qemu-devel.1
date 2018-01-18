Received: from eggs.gnu.org ([2001:4830:134:3::10]:47267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ecH5A-00053V-TK
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:46:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ecH59-0004wX-In
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:46:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ecH59-0004w4-CI
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:46:43 -0500
Date: Thu, 18 Jan 2018 22:46:41 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1516308132-10272-26-git-send-email-mst@redhat.com>
References: <1516308132-10272-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516308132-10272-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v4 25/29] tests: acpi: rename
 test_acpi_tables()/test_dst_table() to reflect its usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

Main purpose of test_dst_table() is loading a table from QEMU
with checking that checksum in header matches actual one,
rename it reflect main action it performs.

Likewise test_acpi_tables() name is to broad, while the function
only loads tables referenced by RSDT, rename it to reflect it.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/bios-tables-test.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 4b357cd..1314ad8 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -210,7 +210,11 @@ static void test_acpi_facs_table(test_data *data)
     ACPI_ASSERT_CMP(facs_table->signature, "FACS");
 }
 
-static void test_dst_table(AcpiSdtTable *sdt_table, uint32_t addr)
+/** fetch_table
+ *   load ACPI table at @addr into table descriptor @sdt_table
+ *   and check that header checksum matches actual one.
+ */
+static void fetch_table(AcpiSdtTable *sdt_table, uint32_t addr)
 {
     uint8_t checksum;
 
@@ -234,14 +238,15 @@ static void test_acpi_dsdt_table(test_data *data)
     AcpiSdtTable dsdt_table;
     uint32_t addr = le32_to_cpu(data->fadt_table.dsdt);
 
-    test_dst_table(&dsdt_table, addr);
+    fetch_table(&dsdt_table, addr);
     ACPI_ASSERT_CMP(dsdt_table.header.signature, "DSDT");
 
     /* Since DSDT isn't in RSDT, add DSDT to ASL test tables list manually */
     g_array_append_val(data->tables, dsdt_table);
 }
 
-static void test_acpi_tables(test_data *data)
+/* Load all tables and add to test list directly RSDT referenced tables */
+static void fetch_rsdt_referenced_tables(test_data *data)
 {
     int tables_nr = data->rsdt_tables_nr - 1; /* fadt is first */
     int i;
@@ -251,7 +256,7 @@ static void test_acpi_tables(test_data *data)
         uint32_t addr;
 
         addr = le32_to_cpu(data->rsdt_tables_addr[i + 1]); /* fadt is first */
-        test_dst_table(&ssdt_table, addr);
+        fetch_table(&ssdt_table, addr);
         g_array_append_val(data->tables, ssdt_table);
     }
 }
@@ -640,7 +645,7 @@ static void test_acpi_one(const char *params, test_data *data)
     test_acpi_fadt_table(data);
     test_acpi_facs_table(data);
     test_acpi_dsdt_table(data);
-    test_acpi_tables(data);
+    fetch_rsdt_referenced_tables(data);
 
     if (iasl) {
         if (getenv(ACPI_REBUILD_EXPECTED_AML)) {
-- 
MST
