Received: from eggs.gnu.org ([208.118.235.92]:48141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gcWaJ-0002A7-3t
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:24:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gcWaE-0003UE-2n
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:24:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gcWaD-0003PS-EC
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:24:21 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 27 Dec 2018 15:13:32 +0100
Message-Id: <1545920014-114011-7-git-send-email-imammedo@redhat.com>
In-Reply-To: <1545920014-114011-1-git-send-email-imammedo@redhat.com>
References: <1545920014-114011-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v2 6/8] tests: smbios: fetch whole table in one
 step instead of reading it step by step
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, wainersm@redhat.com

replace a bunch of ACPI_READ_ARRAY/ACPI_READ_FIELD macro, that read
SMBIOS table field by field with one memread() to fetch whole table
at once and drop no longer used ACPI_READ_ARRAY/ACPI_READ_FIELD macro.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
V2:
  rebase: s/memread/qtest_memread/
---
 tests/acpi-utils.h       | 17 -----------------
 tests/bios-tables-test.c | 15 +--------------
 2 files changed, 1 insertion(+), 31 deletions(-)

diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
index 1aa00db..cb7183e 100644
--- a/tests/acpi-utils.h
+++ b/tests/acpi-utils.h
@@ -30,23 +30,6 @@ typedef struct {
     bool tmp_files_retain;   /* do not delete the temp asl/aml */
 } AcpiSdtTable;
 
-#define ACPI_READ_FIELD(qts, field, addr)                \
-    do {                                                 \
-        qtest_memread(qts, addr, &field, sizeof(field)); \
-        addr += sizeof(field);                           \
-    } while (0)
-
-#define ACPI_READ_ARRAY_PTR(qts, arr, length, addr)      \
-    do {                                                 \
-        int idx;                                         \
-        for (idx = 0; idx < length; ++idx) {             \
-            ACPI_READ_FIELD(qts, arr[idx], addr);        \
-        }                                                \
-    } while (0)
-
-#define ACPI_READ_ARRAY(qts, arr, addr)                                 \
-    ACPI_READ_ARRAY_PTR(qts, arr, sizeof(arr) / sizeof(arr[0]), addr)
-
 #define ACPI_ASSERT_CMP(actual, expected) do { \
     char ACPI_ASSERT_CMP_str[5] = {}; \
     memcpy(ACPI_ASSERT_CMP_str, &actual, 4); \
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 8fdd1c1..dcd6be8 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -406,32 +406,19 @@ static bool smbios_ep_table_ok(test_data *data)
     struct smbios_21_entry_point *ep_table = &data->smbios_ep_table;
     uint32_t addr = data->smbios_ep_addr;
 
-    ACPI_READ_ARRAY(data->qts, ep_table->anchor_string, addr);
+    qtest_memread(data->qts, addr, ep_table, sizeof(*ep_table));
     if (memcmp(ep_table->anchor_string, "_SM_", 4)) {
         return false;
     }
-    ACPI_READ_FIELD(data->qts, ep_table->checksum, addr);
-    ACPI_READ_FIELD(data->qts, ep_table->length, addr);
-    ACPI_READ_FIELD(data->qts, ep_table->smbios_major_version, addr);
-    ACPI_READ_FIELD(data->qts, ep_table->smbios_minor_version, addr);
-    ACPI_READ_FIELD(data->qts, ep_table->max_structure_size, addr);
-    ACPI_READ_FIELD(data->qts, ep_table->entry_point_revision, addr);
-    ACPI_READ_ARRAY(data->qts, ep_table->formatted_area, addr);
-    ACPI_READ_ARRAY(data->qts, ep_table->intermediate_anchor_string, addr);
     if (memcmp(ep_table->intermediate_anchor_string, "_DMI_", 5)) {
         return false;
     }
-    ACPI_READ_FIELD(data->qts, ep_table->intermediate_checksum, addr);
-    ACPI_READ_FIELD(data->qts, ep_table->structure_table_length, addr);
     if (ep_table->structure_table_length == 0) {
         return false;
     }
-    ACPI_READ_FIELD(data->qts, ep_table->structure_table_address, addr);
-    ACPI_READ_FIELD(data->qts, ep_table->number_of_structures, addr);
     if (ep_table->number_of_structures == 0) {
         return false;
     }
-    ACPI_READ_FIELD(data->qts, ep_table->smbios_bcd_revision, addr);
     if (acpi_calc_checksum((uint8_t *)ep_table, sizeof *ep_table) ||
         acpi_calc_checksum((uint8_t *)ep_table + 0x10,
                            sizeof *ep_table - 0x10)) {
-- 
2.7.4
