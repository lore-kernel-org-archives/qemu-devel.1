Received: from eggs.gnu.org ([2001:4830:134:3::10]:37918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gRJmu-00019l-30
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:31:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gRJmn-0004fe-Uj
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:31:08 -0500
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon, 26 Nov 2018 17:29:41 +0100
Message-Id: <20181126162942.21258-9-sameo@linux.intel.com>
In-Reply-To: <20181126162942.21258-1-sameo@linux.intel.com>
References: <20181126162942.21258-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 8/8] hw: acpi: Remove AcpiRsdpDescriptor and
 fix tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, Laurent Vivier <lvivier@redhat.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Ben Warren <ben@skyportsystems.com>, Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

We switched to the build_append_*() API for all RSDP callers, and this
patch converts all existing tests depending on this structure.
It is no longer needed and we can thus remove it.

Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
---
 include/hw/acpi/acpi-defs.h | 13 ----------
 tests/acpi-utils.h          |  5 +++-
 tests/acpi-utils.c          | 48 ++++++++++++++++++++++++++++++-------
 tests/bios-tables-test.c    | 27 ++++++++++++++-------
 tests/vmgenid-test.c        |  8 ++++---
 5 files changed, 67 insertions(+), 34 deletions(-)

diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index 9b2f6b8043..abef1d57ae 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -40,19 +40,6 @@ enum {
     ACPI_FADT_F_LOW_POWER_S0_IDLE_CAPABLE,
 };
 
-struct AcpiRsdpDescriptor {        /* Root System Descriptor Pointer */
-    uint64_t signature;              /* ACPI signature, contains "RSD PTR " */
-    uint8_t  checksum;               /* To make sum of struct == 0 */
-    uint8_t  oem_id [6];             /* OEM identification */
-    uint8_t  revision;               /* Must be 0 for 1.0, 2 for 2.0 */
-    uint32_t rsdt_physical_address;  /* 32-bit physical address of RSDT */
-    uint32_t length;                 /* XSDT Length in bytes including hdr */
-    uint64_t xsdt_physical_address;  /* 64-bit physical address of XSDT */
-    uint8_t  extended_checksum;      /* Checksum of entire table */
-    uint8_t  reserved [3];           /* Reserved field must be 0 */
-} QEMU_PACKED;
-typedef struct AcpiRsdpDescriptor AcpiRsdpDescriptor;
-
 typedef struct AcpiRsdpData {
     uint8_t oem_id[6]; /* OEM identification */
     uint8_t revision;  /* Must be 0 for 1.0, 2 for 2.0 */
diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
index ac52abd0dd..fb1a67a21f 100644
--- a/tests/acpi-utils.h
+++ b/tests/acpi-utils.h
@@ -82,6 +82,9 @@ typedef struct {
 
 uint8_t acpi_calc_checksum(const uint8_t *data, int len);
 uint32_t acpi_find_rsdp_address(void);
-void acpi_parse_rsdp_table(uint32_t addr, AcpiRsdpDescriptor *rsdp_table);
+uint32_t acpi_find_rsdt_address(uint8_t *rsdp_table);
+uint64_t acpi_find_xsdt_address(uint8_t *rsdp_table);
+void acpi_parse_rsdp_table(uint32_t addr, uint8_t *rsdp_table,
+                           uint8_t revision);
 
 #endif  /* TEST_ACPI_UTILS_H */
diff --git a/tests/acpi-utils.c b/tests/acpi-utils.c
index 41dc1ea9b4..c8fe2d1342 100644
--- a/tests/acpi-utils.c
+++ b/tests/acpi-utils.c
@@ -52,14 +52,44 @@ uint32_t acpi_find_rsdp_address(void)
     return off;
 }
 
-void acpi_parse_rsdp_table(uint32_t addr, AcpiRsdpDescriptor *rsdp_table)
+uint32_t acpi_find_rsdt_address(uint8_t *rsdp_table)
 {
-    ACPI_READ_FIELD(rsdp_table->signature, addr);
-    ACPI_ASSERT_CMP64(rsdp_table->signature, "RSD PTR ");
-
-    ACPI_READ_FIELD(rsdp_table->checksum, addr);
-    ACPI_READ_ARRAY(rsdp_table->oem_id, addr);
-    ACPI_READ_FIELD(rsdp_table->revision, addr);
-    ACPI_READ_FIELD(rsdp_table->rsdt_physical_address, addr);
-    ACPI_READ_FIELD(rsdp_table->length, addr);
+    uint32_t rsdt_physical_address = *((uint32_t *)(rsdp_table +
+                                                    ACPI_RSDP_RSDT_OFFSET));
+    uint8_t revision = rsdp_table[ACPI_RSDP_REVISION_OFFSET];
+
+    if (revision != ACPI_RSDP_REV_1) {
+        return 0;
+    }
+
+    return le32_to_cpu(rsdt_physical_address);
+}
+
+uint64_t acpi_find_xsdt_address(uint8_t *rsdp_table)
+{
+    uint64_t xsdt_physical_address = *((uint64_t *)(rsdp_table +
+                                                    ACPI_RSDP_XSDT_OFFSET));
+    uint8_t revision = rsdp_table[ACPI_RSDP_REVISION_OFFSET];
+
+    if (revision != ACPI_RSDP_REV_2) {
+        return 0;
+    }
+
+    return le64_to_cpu(xsdt_physical_address);
+}
+
+void acpi_parse_rsdp_table(uint32_t addr, uint8_t *rsdp_table, uint8_t revision)
+{
+    switch (revision) {
+    case ACPI_RSDP_REV_1:
+        memread(addr, rsdp_table, ACPI_RSDP_REV_1_LEN);
+        break;
+    case ACPI_RSDP_REV_2:
+        memread(addr, rsdp_table, ACPI_RSDP_REV_2_LEN);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    ACPI_ASSERT_CMP64(*((uint64_t *)(rsdp_table)), ACPI_RSDP_SIGNATURE);
 }
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index d661d9be62..8cde404bda 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -27,7 +27,8 @@ typedef struct {
     const char *machine;
     const char *variant;
     uint32_t rsdp_addr;
-    AcpiRsdpDescriptor rsdp_table;
+    uint8_t rsdp_table[ACPI_RSDP_REV_2_LEN];
+    uint32_t rsdt_physical_address;
     AcpiRsdtDescriptorRev1 rsdt_table;
     uint32_t dsdt_addr;
     uint32_t facs_addr;
@@ -83,21 +84,31 @@ static void test_acpi_rsdp_address(test_data *data)
     data->rsdp_addr = off;
 }
 
-static void test_acpi_rsdp_table(test_data *data)
+static void test_acpi_rsdp_table(test_data *data, uint8_t revision)
 {
-    AcpiRsdpDescriptor *rsdp_table = &data->rsdp_table;
+    uint8_t *rsdp_table = data->rsdp_table;
     uint32_t addr = data->rsdp_addr;
 
-    acpi_parse_rsdp_table(addr, rsdp_table);
+    acpi_parse_rsdp_table(addr, rsdp_table, revision);
 
-    /* rsdp checksum is not for the whole table, but for the first 20 bytes */
-    g_assert(!acpi_calc_checksum((uint8_t *)rsdp_table, 20));
+    switch (revision) {
+    case ACPI_RSDP_REV_1:
+        /* With rev 1, checksum is only for the first 20 bytes */
+        g_assert(!acpi_calc_checksum(rsdp_table,  ACPI_RSDP_REV_1_LEN));
+        break;
+    case ACPI_RSDP_REV_2:
+        /* With revision 2, we have 2 checksums */
+        g_assert(!acpi_calc_checksum(rsdp_table, ACPI_RSDP_REV_1_LEN));
+        g_assert(!acpi_calc_checksum(rsdp_table, ACPI_RSDP_REV_2_LEN));
+    default:
+        g_assert_not_reached();
+    }
 }
 
 static void test_acpi_rsdt_table(test_data *data)
 {
     AcpiRsdtDescriptorRev1 *rsdt_table = &data->rsdt_table;
-    uint32_t addr = le32_to_cpu(data->rsdp_table.rsdt_physical_address);
+    uint32_t addr = acpi_find_rsdt_address(data->rsdp_table);
     uint32_t *tables;
     int tables_nr;
     uint8_t checksum;
@@ -626,7 +637,7 @@ static void test_acpi_one(const char *params, test_data *data)
 
     data->tables = g_array_new(false, true, sizeof(AcpiSdtTable));
     test_acpi_rsdp_address(data);
-    test_acpi_rsdp_table(data);
+    test_acpi_rsdp_table(data, ACPI_RSDP_REV_1);
     test_acpi_rsdt_table(data);
     fadt_fetch_facs_and_dsdt_ptrs(data);
     test_acpi_facs_table(data);
diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
index 0a6fb55f2e..db5b084c18 100644
--- a/tests/vmgenid-test.c
+++ b/tests/vmgenid-test.c
@@ -35,7 +35,7 @@ static uint32_t acpi_find_vgia(void)
 {
     uint32_t rsdp_offset;
     uint32_t guid_offset = 0;
-    AcpiRsdpDescriptor rsdp_table;
+    uint8_t rsdp_table[ACPI_RSDP_REV_2_LEN];
     uint32_t rsdt, rsdt_table_length;
     AcpiRsdtDescriptorRev1 rsdt_table;
     size_t tables_nr;
@@ -52,9 +52,11 @@ static uint32_t acpi_find_vgia(void)
 
     g_assert_cmphex(rsdp_offset, <, RSDP_ADDR_INVALID);
 
-    acpi_parse_rsdp_table(rsdp_offset, &rsdp_table);
+    acpi_parse_rsdp_table(rsdp_offset, rsdp_table, ACPI_RSDP_REV_1);
+
+    rsdt = acpi_find_rsdt_address(rsdp_table);
+    g_assert(rsdt);
 
-    rsdt = le32_to_cpu(rsdp_table.rsdt_physical_address);
     /* read the header */
     ACPI_READ_TABLE_HEADER(&rsdt_table, rsdt);
     ACPI_ASSERT_CMP(rsdt_table.signature, "RSDT");
-- 
2.19.1
