Received: from eggs.gnu.org ([2001:4830:134:3::10]:41920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUwPE-0004Gk-DJ
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 10:17:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUwPD-000609-DC
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 10:17:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eUwPD-0005ze-7n
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 10:17:07 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7A271820FB
	for <qemu-devel@nongnu.org>; Fri, 29 Dec 2017 15:17:06 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 29 Dec 2017 16:16:39 +0100
Message-Id: <1514560602-280058-3-git-send-email-imammedo@redhat.com>
In-Reply-To: <1514560602-280058-1-git-send-email-imammedo@redhat.com>
References: <1514560602-280058-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 2/5] tests: acpi: init table descriptor in
 test_dst_table()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin " <mst@redhat.com>, Thomas Huth <thuth@redhat.com>

remove code duplication and make sure that table descriptor
passed in for initialization is in expected state.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/bios-tables-test.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index a5639d1..7825483 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -214,6 +214,7 @@ static void test_dst_table(AcpiSdtTable *sdt_table, uint32_t addr)
 {
     uint8_t checksum;
 
+    memset(sdt_table, 0, sizeof(*sdt_table));
     ACPI_READ_TABLE_HEADER(&sdt_table->header, addr);
 
     sdt_table->aml_len = le32_to_cpu(sdt_table->header.length)
@@ -233,8 +234,6 @@ static void test_acpi_dsdt_table(test_data *data)
     AcpiSdtTable dsdt_table;
     uint32_t addr = le32_to_cpu(data->fadt_table.dsdt);
 
-    memset(&dsdt_table, 0, sizeof(dsdt_table));
-
     test_dst_table(&dsdt_table, addr);
     ACPI_ASSERT_CMP(dsdt_table.header.signature, "DSDT");
 
@@ -251,7 +250,6 @@ static void test_acpi_tables(test_data *data)
         AcpiSdtTable ssdt_table;
         uint32_t addr;
 
-        memset(&ssdt_table, 0, sizeof(ssdt_table));
         addr = le32_to_cpu(data->rsdt_tables_addr[i + 1]); /* fadt is first */
         test_dst_table(&ssdt_table, addr);
         g_array_append_val(data->tables, ssdt_table);
-- 
2.7.4
