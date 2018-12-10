Received: from eggs.gnu.org ([2001:4830:134:3::10]:59236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gWQAm-0001Wt-NW
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:20:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gWQAj-0006NJ-HZ
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:20:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gWQAj-0006Lw-8R
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:20:49 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon, 10 Dec 2018 19:10:09 +0100
Message-Id: <1544465415-207855-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1544465415-207855-1-git-send-email-imammedo@redhat.com>
References: <1544465415-207855-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 3/9] tests: acpi: make sure FADT is fetched
 only once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>

Whole FADT is fetched as part of RSDT referenced tables in
fetch_rsdt_referenced_tables() albeit a bit later than when FADT
is partially parsed in fadt_fetch_facs_and_dsdt_ptrs().
However there is no reason for calling fetch_rsdt_referenced_tables()
so late, just move it right after we fetched RSDT and before
fadt_fetch_facs_and_dsdt_ptrs(). That way we can reuse whole FADT
fetched by fetch_rsdt_referenced_tables() and avoid duplicate
custom fields fetching in fadt_fetch_facs_and_dsdt_ptrs().

While at it rename fadt_fetch_facs_and_dsdt_ptrs() to
test_acpi_fadt_table(). The follow up patch will merge
fadt_fetch_facs_and_dsdt_ptrs() into test_acpi_rsdt_table(),
so that we would end up calling only test_acpi_FOO_table()
for consistency for tables that require special processing.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/bios-tables-test.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 1666cf7..5faf75f 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -139,18 +139,15 @@ static void test_acpi_rsdt_table(test_data *data)
     data->rsdt_tables_nr = tables_nr;
 }
 
-static void fadt_fetch_facs_and_dsdt_ptrs(test_data *data)
+static void test_acpi_fadt_table(test_data *data)
 {
-    uint32_t addr;
-    AcpiTableHeader hdr;
+    /* FADT table is 1st */
+    AcpiSdtTable *fadt = &g_array_index(data->tables, typeof(*fadt), 0);
 
-    /* FADT table comes first */
-    addr = le32_to_cpu(data->rsdt_tables_addr[0]);
-    ACPI_READ_TABLE_HEADER(&hdr, addr);
-    ACPI_ASSERT_CMP(hdr.signature, "FACP");
+    ACPI_ASSERT_CMP(fadt->header->signature, "FACP");
 
-    ACPI_READ_FIELD(data->facs_addr, addr);
-    ACPI_READ_FIELD(data->dsdt_addr, addr);
+    memcpy(&data->facs_addr, fadt->aml + 36 /* FIRMWARE_CTRL */, 4);
+    memcpy(&data->dsdt_addr, fadt->aml + 40 /* DSDT */, 4);
 }
 
 static void sanitize_fadt_ptrs(test_data *data)
@@ -622,10 +619,10 @@ static void test_acpi_one(const char *params, test_data *data)
     test_acpi_rsdp_address(data);
     test_acpi_rsdp_table(data);
     test_acpi_rsdt_table(data);
-    fadt_fetch_facs_and_dsdt_ptrs(data);
+    fetch_rsdt_referenced_tables(data);
+    test_acpi_fadt_table(data);
     test_acpi_facs_table(data);
     test_acpi_dsdt_table(data);
-    fetch_rsdt_referenced_tables(data);
 
     sanitize_fadt_ptrs(data);
 
-- 
2.7.4
