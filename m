Received: from eggs.gnu.org ([2001:4830:134:3::10]:54306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejrZR-0006NB-Nu
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejrZQ-0008SU-Lo
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50916 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ejrZQ-0008Rd-EO
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:20 -0500
Date: Thu, 8 Feb 2018 21:09:19 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1518116908-10852-24-git-send-email-mst@redhat.com>
References: <1518116908-10852-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518116908-10852-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 23/26] tests: acpi: fix FADT not being compared
 to reference table
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

It turns out that FADT isn't actually tested for changes
against reference table, since it happens to be the 1st
table in RSDT which is currently ignored.
Fix it by making sure that all tables from RSDT are added
to test list.

NOTE: FADT contains guest allocated pointers to FACS/DSDT,
zero them out so that possible FACS/DSDT address change
won't affect test results.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/bios-tables-test.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index b354aaa..2b332ed 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -194,6 +194,35 @@ static void test_acpi_fadt_table(test_data *data)
                                  le32_to_cpu(fadt_table->length)));
 }
 
+static void sanitize_fadt_ptrs(test_data *data)
+{
+    /* fixup pointers in FADT */
+    int i;
+
+    for (i = 0; i < data->tables->len; i++) {
+        AcpiSdtTable *sdt = &g_array_index(data->tables, AcpiSdtTable, i);
+
+        if (memcmp(&sdt->header.signature, "FACP", 4)) {
+            continue;
+        }
+
+        /* sdt->aml field offset := spec offset - header size */
+        memset(sdt->aml + 0, 0, 4); /* sanitize FIRMWARE_CTRL(36) ptr */
+        memset(sdt->aml + 4, 0, 4); /* sanitize DSDT(40) ptr */
+        if (sdt->header.revision >= 3) {
+            memset(sdt->aml + 96, 0, 8); /* sanitize X_FIRMWARE_CTRL(132) ptr */
+            memset(sdt->aml + 104, 0, 8); /* sanitize X_DSDT(140) ptr */
+        }
+
+        /* update checksum */
+        sdt->header.checksum = 0;
+        sdt->header.checksum -=
+            acpi_calc_checksum((uint8_t *)sdt, sizeof(AcpiTableHeader)) +
+            acpi_calc_checksum((uint8_t *)sdt->aml, sdt->aml_len);
+        break;
+    }
+}
+
 static void test_acpi_facs_table(test_data *data)
 {
     AcpiFacsDescriptorRev1 *facs_table = &data->facs_table;
@@ -248,14 +277,14 @@ static void test_acpi_dsdt_table(test_data *data)
 /* Load all tables and add to test list directly RSDT referenced tables */
 static void fetch_rsdt_referenced_tables(test_data *data)
 {
-    int tables_nr = data->rsdt_tables_nr - 1; /* fadt is first */
+    int tables_nr = data->rsdt_tables_nr;
     int i;
 
     for (i = 0; i < tables_nr; i++) {
         AcpiSdtTable ssdt_table;
         uint32_t addr;
 
-        addr = le32_to_cpu(data->rsdt_tables_addr[i + 1]); /* fadt is first */
+        addr = le32_to_cpu(data->rsdt_tables_addr[i]);
         fetch_table(&ssdt_table, addr);
 
         /* Add table to ASL test tables list */
@@ -650,6 +679,8 @@ static void test_acpi_one(const char *params, test_data *data)
     test_acpi_dsdt_table(data);
     fetch_rsdt_referenced_tables(data);
 
+    sanitize_fadt_ptrs(data);
+
     if (iasl) {
         if (getenv(ACPI_REBUILD_EXPECTED_AML)) {
             dump_aml_files(data, true);
-- 
MST
