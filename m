Received: from eggs.gnu.org ([2001:4830:134:3::10]:59321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gWQAq-0001Xb-Jd
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:20:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gWQAo-0006SI-P6
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:20:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gWQAo-0006QZ-9y
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:20:54 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon, 10 Dec 2018 19:10:13 +0100
Message-Id: <1544465415-207855-8-git-send-email-imammedo@redhat.com>
In-Reply-To: <1544465415-207855-1-git-send-email-imammedo@redhat.com>
References: <1544465415-207855-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 7/9] tests: smbios: fetch whole table in one
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>

replace a bunch of ACPI_READ_ARRAY/ACPI_READ_FIELD macro, that read
SMBIOS table field by field with one memread() to fetch whole table
at once and drop no longer used ACPI_READ_ARRAY/ACPI_READ_FIELD macro.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/acpi-utils.h       | 17 -----------------
 tests/bios-tables-test.c | 15 +--------------
 2 files changed, 1 insertion(+), 31 deletions(-)

diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
index 1b584d3..bc0cd19 100644
--- a/tests/acpi-utils.h
+++ b/tests/acpi-utils.h
@@ -30,23 +30,6 @@ typedef struct {
     bool tmp_files_retain;   /* do not delete the temp asl/aml */
 } AcpiSdtTable;
 
-#define ACPI_READ_FIELD(field, addr)            \
-    do {                                        \
-        memread(addr, &field, sizeof(field));   \
-        addr += sizeof(field);                  \
-    } while (0)
-
-#define ACPI_READ_ARRAY_PTR(arr, length, addr)  \
-    do {                                        \
-        int idx;                                \
-        for (idx = 0; idx < length; ++idx) {    \
-            ACPI_READ_FIELD(arr[idx], addr);    \
-        }                                       \
-    } while (0)
-
-#define ACPI_READ_ARRAY(arr, addr)                               \
-    ACPI_READ_ARRAY_PTR(arr, sizeof(arr) / sizeof(arr[0]), addr)
-
 #define ACPI_ASSERT_CMP(actual, expected) do { \
     char ACPI_ASSERT_CMP_str[5] = {}; \
     memcpy(ACPI_ASSERT_CMP_str, &actual, 4); \
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 8160fc0..9aa7c86 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -402,32 +402,19 @@ static bool smbios_ep_table_ok(test_data *data)
     struct smbios_21_entry_point *ep_table = &data->smbios_ep_table;
     uint32_t addr = data->smbios_ep_addr;
 
-    ACPI_READ_ARRAY(ep_table->anchor_string, addr);
+    memread(addr, ep_table, sizeof(*ep_table));
     if (memcmp(ep_table->anchor_string, "_SM_", 4)) {
         return false;
     }
-    ACPI_READ_FIELD(ep_table->checksum, addr);
-    ACPI_READ_FIELD(ep_table->length, addr);
-    ACPI_READ_FIELD(ep_table->smbios_major_version, addr);
-    ACPI_READ_FIELD(ep_table->smbios_minor_version, addr);
-    ACPI_READ_FIELD(ep_table->max_structure_size, addr);
-    ACPI_READ_FIELD(ep_table->entry_point_revision, addr);
-    ACPI_READ_ARRAY(ep_table->formatted_area, addr);
-    ACPI_READ_ARRAY(ep_table->intermediate_anchor_string, addr);
     if (memcmp(ep_table->intermediate_anchor_string, "_DMI_", 5)) {
         return false;
     }
-    ACPI_READ_FIELD(ep_table->intermediate_checksum, addr);
-    ACPI_READ_FIELD(ep_table->structure_table_length, addr);
     if (ep_table->structure_table_length == 0) {
         return false;
     }
-    ACPI_READ_FIELD(ep_table->structure_table_address, addr);
-    ACPI_READ_FIELD(ep_table->number_of_structures, addr);
     if (ep_table->number_of_structures == 0) {
         return false;
     }
-    ACPI_READ_FIELD(ep_table->smbios_bcd_revision, addr);
     if (acpi_calc_checksum((uint8_t *)ep_table, sizeof *ep_table) ||
         acpi_calc_checksum((uint8_t *)ep_table + 0x10,
                            sizeof *ep_table - 0x10)) {
-- 
2.7.4
