Received: from eggs.gnu.org ([209.51.188.92]:49453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMD4A-00053V-6u
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMD49-0002mb-0k
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hMD48-0002mC-O7
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:04 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  2 May 2019 16:51:51 +0200
Message-Id: <1556808723-226478-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
References: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v4 03/15] tests: acpi: make RSDT test routine
 handle XSDT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gonglei <arei.gonglei@huawei.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Wei Yang <richardw.yang@linux.intel.com>, Andrew Jones <drjones@redhat.com>, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Ben Warren <ben@skyportsystems.com>, xuwei5@hisilicon.com, xuwei5@huawei.com, linuxarm@huawei.com

If RSDP revision is more than 0 fetch table pointed by XSDT
and fallback to legacy RSDT table otherwise.

While at it drop unused acpi_get_xsdt_address().

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
PS:
 it doesn't affect existing pc/q35 machines as they use RSDP.revision == 0
 but it will be used by followup patch to enable testing arm/virt
 board which uses provides XSDT table.

v4:
 * move out acpi_parse_rsdp_table() hunk to
   "tests: acpi: make pointer to RSDP  64bit"
   where it belongs
---
 tests/acpi-utils.h       |  1 -
 tests/acpi-utils.c       | 12 ------------
 tests/bios-tables-test.c | 20 ++++++++++++++------
 3 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
index 92285b7..f55ccf9 100644
--- a/tests/acpi-utils.h
+++ b/tests/acpi-utils.h
@@ -46,7 +46,6 @@ typedef struct {
 
 uint8_t acpi_calc_checksum(const uint8_t *data, int len);
 uint32_t acpi_find_rsdp_address(QTestState *qts);
-uint64_t acpi_get_xsdt_address(uint8_t *rsdp_table);
 void acpi_fetch_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table);
 void acpi_fetch_table(QTestState *qts, uint8_t **aml, uint32_t *aml_len,
                       const uint8_t *addr_ptr, int addr_size, const char *sig,
diff --git a/tests/acpi-utils.c b/tests/acpi-utils.c
index 644c87b..a0d49c4 100644
--- a/tests/acpi-utils.c
+++ b/tests/acpi-utils.c
@@ -51,18 +51,6 @@ uint32_t acpi_find_rsdp_address(QTestState *qts)
     return off;
 }
 
-uint64_t acpi_get_xsdt_address(uint8_t *rsdp_table)
-{
-    uint64_t xsdt_physical_address;
-    uint8_t revision = rsdp_table[15 /* Revision offset */];
-
-    /* We must have revision 2 if we're looking for an XSDT pointer */
-    g_assert(revision == 2);
-
-    memcpy(&xsdt_physical_address, &rsdp_table[24 /* XsdtAddress offset */], 8);
-    return le64_to_cpu(xsdt_physical_address);
-}
-
 void acpi_fetch_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table)
 {
     uint8_t revision;
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 86b592c..d6ab121 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -107,21 +107,29 @@ static void test_acpi_rsdp_table(test_data *data)
     }
 }
 
-static void test_acpi_rsdt_table(test_data *data)
+static void test_acpi_rxsdt_table(test_data *data)
 {
+    const char *sig = "RSDT";
     AcpiSdtTable rsdt = {};
+    int entry_size = 4;
+    int addr_off = 16 /* RsdtAddress */;
     uint8_t *ent;
 
-    /* read RSDT table */
+    if (data->rsdp_table[15 /* Revision offset */] != 0) {
+        addr_off = 24 /* XsdtAddress */;
+        entry_size = 8;
+        sig = "XSDT";
+    }
+    /* read [RX]SDT table */
     acpi_fetch_table(data->qts, &rsdt.aml, &rsdt.aml_len,
-                     &data->rsdp_table[16 /* RsdtAddress */], 4, "RSDT", true);
+                     &data->rsdp_table[addr_off], entry_size, sig, true);
 
     /* Load all tables and add to test list directly RSDT referenced tables */
-    ACPI_FOREACH_RSDT_ENTRY(rsdt.aml, rsdt.aml_len, ent, 4 /* Entry size */) {
+    ACPI_FOREACH_RSDT_ENTRY(rsdt.aml, rsdt.aml_len, ent, entry_size) {
         AcpiSdtTable ssdt_table = {};
 
         acpi_fetch_table(data->qts, &ssdt_table.aml, &ssdt_table.aml_len, ent,
-                         4, NULL, true);
+                         entry_size, NULL, true);
         /* Add table to ASL test tables list */
         g_array_append_val(data->tables, ssdt_table);
     }
@@ -521,7 +529,7 @@ static void test_acpi_one(const char *params, test_data *data)
     data->tables = g_array_new(false, true, sizeof(AcpiSdtTable));
     test_acpi_rsdp_address(data);
     test_acpi_rsdp_table(data);
-    test_acpi_rsdt_table(data);
+    test_acpi_rxsdt_table(data);
     test_acpi_fadt_table(data);
 
     if (iasl) {
-- 
2.7.4
