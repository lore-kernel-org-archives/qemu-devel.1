Received: from eggs.gnu.org ([2001:4830:134:3::10]:51270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ga00s-0004qM-RM
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 10:13:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ga00p-0008Gu-3Q
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 10:13:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ga00o-0008Fp-Ok
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 10:13:22 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 20 Dec 2018 16:02:55 +0100
Message-Id: <1545318175-261559-1-git-send-email-imammedo@redhat.com>
In-Reply-To: <20181218161008.3882-30-mst@redhat.com>
References: <20181218161008.3882-30-mst@redhat.com>
Subject: [Qemu-devel] [PATCH v3 29/30] hw: acpi: Remove AcpiRsdpDescriptor
 and fix tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, peter.maydell@linaro.org, sameo@linux.intel.com

From: Samuel Ortiz <sameo@linux.intel.com>

The only remaining AcpiRsdpDescriptor users are the ACPI utils for the
BIOS table tests.
We remove that dependency and can thus remove the structure itself.

Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v3:
  fix conflicts with
    commit 273e3d92cfa26ae07a72657b75b4b76105a0fbc4
      "tests/acpi-utils: Drop dependence on global_qtest"
---
 include/hw/acpi/acpi-defs.h | 13 ------------
 tests/acpi-utils.h          |  5 +++--
 tests/acpi-utils.c          | 49 ++++++++++++++++++++++++++++++++++++---------
 tests/bios-tables-test.c    | 22 +++++++++++++++-----
 tests/vmgenid-test.c        |  8 +++++---
 5 files changed, 64 insertions(+), 33 deletions(-)

diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index 8425ecb..5021cb9 100644
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
index 791bd54..c5b0e12 100644
--- a/tests/acpi-utils.h
+++ b/tests/acpi-utils.h
@@ -74,7 +74,8 @@ typedef struct {
 
 uint8_t acpi_calc_checksum(const uint8_t *data, int len);
 uint32_t acpi_find_rsdp_address(QTestState *qts);
-void acpi_parse_rsdp_table(QTestState *qts, uint32_t addr,
-                           AcpiRsdpDescriptor *rsdp_table);
+uint32_t acpi_get_rsdt_address(uint8_t *rsdp_table);
+uint64_t acpi_get_xsdt_address(uint8_t *rsdp_table);
+void acpi_parse_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table);
 
 #endif  /* TEST_ACPI_UTILS_H */
diff --git a/tests/acpi-utils.c b/tests/acpi-utils.c
index 7b444a7..17abcc4 100644
--- a/tests/acpi-utils.c
+++ b/tests/acpi-utils.c
@@ -51,15 +51,44 @@ uint32_t acpi_find_rsdp_address(QTestState *qts)
     return off;
 }
 
-void acpi_parse_rsdp_table(QTestState *qts, uint32_t addr,
-                           AcpiRsdpDescriptor *rsdp_table)
+uint32_t acpi_get_rsdt_address(uint8_t *rsdp_table)
 {
-    ACPI_READ_FIELD(qts, rsdp_table->signature, addr);
-    ACPI_ASSERT_CMP64(rsdp_table->signature, "RSD PTR ");
-
-    ACPI_READ_FIELD(qts, rsdp_table->checksum, addr);
-    ACPI_READ_ARRAY(qts, rsdp_table->oem_id, addr);
-    ACPI_READ_FIELD(qts, rsdp_table->revision, addr);
-    ACPI_READ_FIELD(qts, rsdp_table->rsdt_physical_address, addr);
-    ACPI_READ_FIELD(qts, rsdp_table->length, addr);
+    uint32_t rsdt_physical_address;
+
+    memcpy(&rsdt_physical_address, &rsdp_table[16 /* RsdtAddress offset */], 4);
+    return le32_to_cpu(rsdt_physical_address);
+}
+
+uint64_t acpi_get_xsdt_address(uint8_t *rsdp_table)
+{
+    uint64_t xsdt_physical_address;
+    uint8_t revision = rsdp_table[15 /* Revision offset */];
+
+    /* We must have revision 2 if we're looking for an XSDT pointer */
+    g_assert(revision == 2);
+
+    memcpy(&xsdt_physical_address, &rsdp_table[24 /* XsdtAddress offset */], 8);
+    return le64_to_cpu(xsdt_physical_address);
+}
+
+void acpi_parse_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table)
+{
+    uint8_t revision;
+
+    /* Read mandatory revision 0 table data (20 bytes) first */
+    qtest_memread(qts, addr, rsdp_table, 20);
+    revision = rsdp_table[15 /* Revision offset */];
+
+    switch (revision) {
+    case 0: /* ACPI 1.0 RSDP */
+        break;
+    case 2: /* ACPI 2.0+ RSDP */
+        /* Read the rest of the RSDP table */
+        qtest_memread(qts, addr + 20, rsdp_table + 20, 16);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    ACPI_ASSERT_CMP64(*((uint64_t *)(rsdp_table)), "RSD PTR ");
 }
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 2b60046..d455b2a 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -27,7 +27,7 @@ typedef struct {
     const char *machine;
     const char *variant;
     uint32_t rsdp_addr;
-    AcpiRsdpDescriptor rsdp_table;
+    uint8_t rsdp_table[36 /* ACPI 2.0+ RSDP size */];
     AcpiRsdtDescriptorRev1 rsdt_table;
     uint32_t dsdt_addr;
     uint32_t facs_addr;
@@ -86,19 +86,31 @@ static void test_acpi_rsdp_address(test_data *data)
 
 static void test_acpi_rsdp_table(test_data *data)
 {
-    AcpiRsdpDescriptor *rsdp_table = &data->rsdp_table;
+    uint8_t *rsdp_table = data->rsdp_table, revision;
     uint32_t addr = data->rsdp_addr;
 
     acpi_parse_rsdp_table(data->qts, addr, rsdp_table);
+    revision = rsdp_table[15 /* Revision offset */];
 
-    /* rsdp checksum is not for the whole table, but for the first 20 bytes */
-    g_assert(!acpi_calc_checksum((uint8_t *)rsdp_table, 20));
+    switch (revision) {
+    case 0: /* ACPI 1.0 RSDP */
+        /* With rev 1, checksum is only for the first 20 bytes */
+        g_assert(!acpi_calc_checksum(rsdp_table,  20));
+        break;
+    case 2: /* ACPI 2.0+ RSDP */
+        /* With revision 2, we have 2 checksums */
+        g_assert(!acpi_calc_checksum(rsdp_table, 20));
+        g_assert(!acpi_calc_checksum(rsdp_table, 36));
+        break;
+    default:
+        g_assert_not_reached();
+    }
 }
 
 static void test_acpi_rsdt_table(test_data *data)
 {
     AcpiRsdtDescriptorRev1 *rsdt_table = &data->rsdt_table;
-    uint32_t addr = le32_to_cpu(data->rsdp_table.rsdt_physical_address);
+    uint32_t addr = acpi_get_rsdt_address(data->rsdp_table);
     uint32_t *tables;
     int tables_nr;
     uint8_t checksum;
diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
index 84449ce..1c1d435 100644
--- a/tests/vmgenid-test.c
+++ b/tests/vmgenid-test.c
@@ -35,7 +35,7 @@ static uint32_t acpi_find_vgia(QTestState *qts)
 {
     uint32_t rsdp_offset;
     uint32_t guid_offset = 0;
-    AcpiRsdpDescriptor rsdp_table;
+    uint8_t rsdp_table[36 /* ACPI 2.0+ RSDP size */];
     uint32_t rsdt, rsdt_table_length;
     AcpiRsdtDescriptorRev1 rsdt_table;
     size_t tables_nr;
@@ -52,9 +52,11 @@ static uint32_t acpi_find_vgia(QTestState *qts)
 
     g_assert_cmphex(rsdp_offset, <, RSDP_ADDR_INVALID);
 
-    acpi_parse_rsdp_table(qts, rsdp_offset, &rsdp_table);
+    acpi_parse_rsdp_table(qts, rsdp_offset, rsdp_table);
+
+    rsdt = acpi_get_rsdt_address(rsdp_table);
+    g_assert(rsdt);
 
-    rsdt = le32_to_cpu(rsdp_table.rsdt_physical_address);
     /* read the header */
     ACPI_READ_TABLE_HEADER(qts, &rsdt_table, rsdt);
     ACPI_ASSERT_CMP(rsdt_table.signature, "RSDT");
-- 
2.7.4
