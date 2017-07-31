Received: from eggs.gnu.org ([2001:4830:134:3::10]:57724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dcCu1-0003rE-DG
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:46:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dcCty-0008Eh-Rh
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:46:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dcCty-0008De-Kz
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:46:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 58D76A5296
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 15:41:04 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon, 31 Jul 2017 17:40:50 +0200
Message-Id: <1501515652-33372-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1501515652-33372-1-git-send-email-imammedo@redhat.com>
References: <1501515652-33372-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 3/5] tests: acpi: rename
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

Main purpose of test_dst_table() is loading a table from QEMU
with checking that checksum in header matches actual one,
rename it reflect main action it performs.

Likewise test_acpi_tables() name is to broad, while the function
only loads tables referenced by RSDT, rename it to reflect it.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/bios-tables-test.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index adbcc55..ed32e9a 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -206,7 +206,11 @@ static void test_acpi_facs_table(test_data *data)
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
 
@@ -229,14 +233,15 @@ static void test_acpi_dsdt_table(test_data *data)
     AcpiSdtTable dsdt_table;
     uint32_t addr = data->fadt_table.dsdt;
 
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
@@ -245,7 +250,7 @@ static void test_acpi_tables(test_data *data)
         AcpiSdtTable ssdt_table;
 
         uint32_t addr = data->rsdt_tables_addr[i + 1]; /* fadt is first */
-        test_dst_table(&ssdt_table, addr);
+        fetch_table(&ssdt_table, addr);
         g_array_append_val(data->tables, ssdt_table);
     }
 }
@@ -638,7 +643,7 @@ static void test_acpi_one(const char *params, test_data *data)
     test_acpi_fadt_table(data);
     test_acpi_facs_table(data);
     test_acpi_dsdt_table(data);
-    test_acpi_tables(data);
+    fetch_rsdt_referenced_tables(data);
 
     if (iasl) {
         if (getenv(ACPI_REBUILD_EXPECTED_AML)) {
-- 
2.7.4
