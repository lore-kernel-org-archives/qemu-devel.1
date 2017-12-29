Received: from eggs.gnu.org ([2001:4830:134:3::10]:41915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUwPE-0004Gi-AO
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 10:17:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUwPC-0005zT-Aq
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 10:17:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eUwPC-0005yi-4H
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 10:17:06 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 42D21C047B69
	for <qemu-devel@nongnu.org>; Fri, 29 Dec 2017 15:17:05 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 29 Dec 2017 16:16:38 +0100
Message-Id: <1514560602-280058-2-git-send-email-imammedo@redhat.com>
In-Reply-To: <1514560602-280058-1-git-send-email-imammedo@redhat.com>
References: <1514560602-280058-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] tests: acpi: move tested tables array
 allocation outside of test_acpi_dsdt_table()
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

at best it's confusing that array for list of tables to be tested
against reference tables is allocated within test_acpi_dsdt_table()
and at worst it would just overwrite list of tables if they were
added before test_acpi_dsdt_table().
Move array initialization to test_acpi_one() before we start
processing tables.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/bios-tables-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index e28e0c9..a5639d1 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -234,12 +234,11 @@ static void test_acpi_dsdt_table(test_data *data)
     uint32_t addr = le32_to_cpu(data->fadt_table.dsdt);
 
     memset(&dsdt_table, 0, sizeof(dsdt_table));
-    data->tables = g_array_new(false, true, sizeof(AcpiSdtTable));
 
     test_dst_table(&dsdt_table, addr);
     ACPI_ASSERT_CMP(dsdt_table.header.signature, "DSDT");
 
-    /* Place DSDT first */
+    /* Since DSDT isn't in RSDT, add DSDT to ASL test tables list manually */
     g_array_append_val(data->tables, dsdt_table);
 }
 
@@ -636,6 +635,7 @@ static void test_acpi_one(const char *params, test_data *data)
 
     boot_sector_test();
 
+    data->tables = g_array_new(false, true, sizeof(AcpiSdtTable));
     test_acpi_rsdp_address(data);
     test_acpi_rsdp_table(data);
     test_acpi_rsdt_table(data);
-- 
2.7.4
