Received: from eggs.gnu.org ([2001:4830:134:3::10]:59347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gWQAt-0001Zw-KH
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:21:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gWQAr-0006U9-Kr
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:20:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gWQAr-0006TK-38
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:20:57 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon, 10 Dec 2018 19:10:15 +0100
Message-Id: <1544465415-207855-10-git-send-email-imammedo@redhat.com>
In-Reply-To: <1544465415-207855-1-git-send-email-imammedo@redhat.com>
References: <1544465415-207855-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 9/9] tests: acpi: use AcpiSdtTable::aml instead
 of AcpiSdtTable::header::signature
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

AcpiSdtTable::header::signature is the only remained field from
AcpiTableHeader structure used by tests. Instead of using packed
structure to access signature, just read it directly from table
blob and remove no longer used AcpiSdtTable::header / union and
keep only AcpiSdtTable::aml byte array.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/acpi-utils.h       |  6 +-----
 tests/bios-tables-test.c | 20 +++++++++-----------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
index bc0cd19..8d04f76 100644
--- a/tests/acpi-utils.h
+++ b/tests/acpi-utils.h
@@ -13,15 +13,11 @@
 #ifndef TEST_ACPI_UTILS_H
 #define TEST_ACPI_UTILS_H
 
-#include "hw/acpi/acpi-defs.h"
 #include "libqtest.h"
 
 /* DSDT and SSDTs format */
 typedef struct {
-    union {
-        AcpiTableHeader *header;
-        uint8_t *aml;            /* aml bytecode from guest */
-    };
+    uint8_t *aml;            /* aml bytecode from guest */
     uint32_t aml_len;
     gchar *aml_file;
     gchar *asl;            /* asl code generated from aml */
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 40b224f..1a4e3b3 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -43,6 +43,11 @@ static const char *iasl = stringify(CONFIG_IASL);
 static const char *iasl;
 #endif
 
+static bool compare_signature(const AcpiSdtTable *sdt, const char *signature)
+{
+   return !memcmp(sdt->aml, signature, 4);
+}
+
 static void cleanup_table_descriptor(AcpiSdtTable *table)
 {
     g_free(table->aml);
@@ -128,7 +133,7 @@ static void test_acpi_fadt_table(test_data *data)
     uint8_t *fadt_aml = table.aml;
     uint32_t fadt_len = table.aml_len;
 
-    ACPI_ASSERT_CMP(table.header->signature, "FACP");
+    g_assert(compare_signature(&table, "FACP"));
 
     /* Since DSDT/FACS isn't in RSDT, add them to ASL test list manually */
     acpi_fetch_table(&table.aml, &table.aml_len,
@@ -167,7 +172,7 @@ static void dump_aml_files(test_data *data, bool rebuild)
 
         if (rebuild) {
             aml_file = g_strdup_printf("%s/%s/%.4s%s", data_dir, data->machine,
-                                       (gchar *)&sdt->header->signature, ext);
+                                       sdt->aml, ext);
             fd = g_open(aml_file, O_WRONLY|O_TRUNC|O_CREAT,
                         S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH);
         } else {
@@ -185,11 +190,6 @@ static void dump_aml_files(test_data *data, bool rebuild)
     }
 }
 
-static bool compare_signature(AcpiSdtTable *sdt, const char *signature)
-{
-   return !memcmp(&sdt->header->signature, signature, 4);
-}
-
 static bool load_asl(GArray *sdts, AcpiSdtTable *sdt)
 {
     AcpiSdtTable *temp;
@@ -285,7 +285,7 @@ static GArray *load_expected_aml(test_data *data)
 
 try_again:
         aml_file = g_strdup_printf("%s/%s/%.4s%s", data_dir, data->machine,
-                                   (gchar *)&sdt->header->signature, ext);
+                                   sdt->aml, ext);
         if (getenv("V")) {
             fprintf(stderr, "\nLooking for expected file '%s'\n", aml_file);
         }
@@ -345,14 +345,12 @@ static void test_acpi_asl(test_data *data)
                 fprintf(stderr,
                         "Warning! iasl couldn't parse the expected aml\n");
             } else {
-                uint32_t signature = cpu_to_le32(exp_sdt->header->signature);
                 sdt->tmp_files_retain = true;
                 exp_sdt->tmp_files_retain = true;
                 fprintf(stderr,
                         "acpi-test: Warning! %.4s mismatch. "
                         "Actual [asl:%s, aml:%s], Expected [asl:%s, aml:%s].\n",
-                        (gchar *)&signature,
-                        sdt->asl_file, sdt->aml_file,
+                        exp_sdt->aml, sdt->asl_file, sdt->aml_file,
                         exp_sdt->asl_file, exp_sdt->aml_file);
                 if (getenv("V")) {
                     const char *diff_cmd = getenv("DIFF");
-- 
2.7.4
