Received: from eggs.gnu.org ([2001:4830:134:3::10]:47244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ecH59-00052K-TK
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:46:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ecH58-0004vy-Mq
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:46:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ecH58-0004v9-GV
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:46:42 -0500
Date: Thu, 18 Jan 2018 22:46:40 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1516308132-10272-25-git-send-email-mst@redhat.com>
References: <1516308132-10272-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516308132-10272-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v4 24/29] tests: acpi: init table descriptor in
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

remove code duplication and make sure that table descriptor
passed in for initialization is in expected state.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/bios-tables-test.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index a2f64c8..4b357cd 100644
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
MST
