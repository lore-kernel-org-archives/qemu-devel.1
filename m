Received: from eggs.gnu.org ([209.51.188.92]:33951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUxO-0006TJ-6s
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:05:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUxK-0002WL-3r
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:05:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjUxI-0002Bb-D9
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:05:01 -0500
Date: Tue, 15 Jan 2019 15:04:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-10-mst@redhat.com>
References: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 09/49] tests: acpi: make sure FADT is fetched
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

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
Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/bios-tables-test.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 3f20bbd24e..b2a40bbda3 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -141,18 +141,15 @@ static void test_acpi_rsdt_table(test_data *data)
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
-    ACPI_READ_TABLE_HEADER(data->qts, &hdr, addr);
-    ACPI_ASSERT_CMP(hdr.signature, "FACP");
+    ACPI_ASSERT_CMP(fadt->header->signature, "FACP");
 
-    ACPI_READ_FIELD(data->qts, data->facs_addr, addr);
-    ACPI_READ_FIELD(data->qts, data->dsdt_addr, addr);
+    memcpy(&data->facs_addr, fadt->aml + 36 /* FIRMWARE_CTRL */, 4);
+    memcpy(&data->dsdt_addr, fadt->aml + 40 /* DSDT */, 4);
 }
 
 static void sanitize_fadt_ptrs(test_data *data)
@@ -628,10 +625,10 @@ static void test_acpi_one(const char *params, test_data *data)
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
MST
