Received: from eggs.gnu.org ([2001:4830:134:3::10]:46165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebVPv-0001dR-2J
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:52:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebVPp-00047L-In
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:52:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:23468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ebVPp-00046s-Ch
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:52:53 -0500
Date: Tue, 16 Jan 2018 19:52:50 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1516121887-32738-27-git-send-email-mst@redhat.com>
References: <1516121887-32738-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516121887-32738-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 26/34] tests: acpi: move tested tables array
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

at best it's confusing that array for list of tables to be tested
against reference tables is allocated within test_acpi_dsdt_table()
and at worst it would just overwrite list of tables if they were
added before test_acpi_dsdt_table().
Move array initialization to test_acpi_one() before we start
processing tables.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/bios-tables-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index def81fc..a2f64c8 100644
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
MST
