Received: from eggs.gnu.org ([2001:4830:134:3::10]:38785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSOh-0007gc-OU
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:21:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSOf-0001LL-6W
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:21:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1drSOe-0001Kh-S7
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:21:21 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 11 Sep 2017 12:20:08 -0500
Message-Id: <20170911172022.4738-25-eblake@redhat.com>
In-Reply-To: <20170911172022.4738-1-eblake@redhat.com>
References: <20170911172022.4738-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 24/38] tests/acpi-utils: Drop dependence on
 global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, thuth@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ben Warren <ben@skyportsystems.com>

As a general rule, we prefer avoiding implicit global state
because it makes code harder to safely copy and paste without
thinking about the global state.  Adjust the helper code to
use explicit state instead, and update all callers.

bios-tables-test no longer depends on global_qtest, now that it
passes explicit state through the testsuite data; an assert
proves this fact (although we will get rid of it later, once
global_qtest is gone).

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v7: merge two patches for less churn on bios-tables-test
---
 tests/acpi-utils.h       |  65 ++++++++---------
 tests/acpi-utils.c       |  19 ++---
 tests/bios-tables-test.c | 184 ++++++++++++++++++++++++-----------------------
 tests/vmgenid-test.c     |  18 ++---
 4 files changed, 146 insertions(+), 140 deletions(-)

diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
index f8d87236c6..8ec83f71b1 100644
--- a/tests/acpi-utils.h
+++ b/tests/acpi-utils.h
@@ -28,20 +28,20 @@ typedef struct {
     bool tmp_files_retain;   /* do not delete the temp asl/aml */
 } AcpiSdtTable;

-#define ACPI_READ_FIELD(field, addr)           \
+#define ACPI_READ_FIELD(qts, field, addr)      \
     do {                                       \
         switch (sizeof(field)) {               \
         case 1:                                \
-            field = readb(addr);               \
+            field = qtest_readb(qts, addr);    \
             break;                             \
         case 2:                                \
-            field = readw(addr);               \
+            field = qtest_readw(qts, addr);    \
             break;                             \
         case 4:                                \
-            field = readl(addr);               \
+            field = qtest_readl(qts, addr);    \
             break;                             \
         case 8:                                \
-            field = readq(addr);               \
+            field = qtest_readq(qts, addr);    \
             break;                             \
         default:                               \
             g_assert(false);                   \
@@ -49,28 +49,28 @@ typedef struct {
         addr += sizeof(field);                  \
     } while (0);

-#define ACPI_READ_ARRAY_PTR(arr, length, addr)  \
-    do {                                        \
-        int idx;                                \
-        for (idx = 0; idx < length; ++idx) {    \
-            ACPI_READ_FIELD(arr[idx], addr);    \
-        }                                       \
+#define ACPI_READ_ARRAY_PTR(qts, arr, length, addr)      \
+    do {                                                 \
+        int idx;                                         \
+        for (idx = 0; idx < length; ++idx) {             \
+            ACPI_READ_FIELD(qts, arr[idx], addr);        \
+        }                                                \
     } while (0);

-#define ACPI_READ_ARRAY(arr, addr)                               \
-    ACPI_READ_ARRAY_PTR(arr, sizeof(arr) / sizeof(arr[0]), addr)
+#define ACPI_READ_ARRAY(qts, arr, addr)                                 \
+    ACPI_READ_ARRAY_PTR(qts, arr, sizeof(arr) / sizeof(arr[0]), addr)

-#define ACPI_READ_TABLE_HEADER(table, addr)                      \
+#define ACPI_READ_TABLE_HEADER(qts, table, addr)                 \
     do {                                                         \
-        ACPI_READ_FIELD((table)->signature, addr);               \
-        ACPI_READ_FIELD((table)->length, addr);                  \
-        ACPI_READ_FIELD((table)->revision, addr);                \
-        ACPI_READ_FIELD((table)->checksum, addr);                \
-        ACPI_READ_ARRAY((table)->oem_id, addr);                  \
-        ACPI_READ_ARRAY((table)->oem_table_id, addr);            \
-        ACPI_READ_FIELD((table)->oem_revision, addr);            \
-        ACPI_READ_ARRAY((table)->asl_compiler_id, addr);         \
-        ACPI_READ_FIELD((table)->asl_compiler_revision, addr);   \
+        ACPI_READ_FIELD(qts, (table)->signature, addr);          \
+        ACPI_READ_FIELD(qts, (table)->length, addr);             \
+        ACPI_READ_FIELD(qts, (table)->revision, addr);           \
+        ACPI_READ_FIELD(qts, (table)->checksum, addr);           \
+        ACPI_READ_ARRAY(qts, (table)->oem_id, addr);             \
+        ACPI_READ_ARRAY(qts, (table)->oem_table_id, addr);       \
+        ACPI_READ_FIELD(qts, (table)->oem_revision, addr);       \
+        ACPI_READ_ARRAY(qts, (table)->asl_compiler_id, addr);    \
+        ACPI_READ_FIELD(qts, (table)->asl_compiler_revision, addr);     \
     } while (0);

 #define ACPI_ASSERT_CMP(actual, expected) do { \
@@ -87,18 +87,19 @@ typedef struct {
     g_assert_cmpstr(ACPI_ASSERT_CMP_str, ==, expected); \
 } while (0)

-#define ACPI_READ_GENERIC_ADDRESS(field, addr)       \
-    do {                                             \
-        ACPI_READ_FIELD((field).space_id, addr);     \
-        ACPI_READ_FIELD((field).bit_width, addr);    \
-        ACPI_READ_FIELD((field).bit_offset, addr);   \
-        ACPI_READ_FIELD((field).access_width, addr); \
-        ACPI_READ_FIELD((field).address, addr);      \
+#define ACPI_READ_GENERIC_ADDRESS(qts, field, addr)       \
+    do {                                                  \
+        ACPI_READ_FIELD(qts, (field).space_id, addr);     \
+        ACPI_READ_FIELD(qts, (field).bit_width, addr);    \
+        ACPI_READ_FIELD(qts, (field).bit_offset, addr);   \
+        ACPI_READ_FIELD(qts, (field).access_width, addr); \
+        ACPI_READ_FIELD(qts, (field).address, addr);      \
     } while (0);


 uint8_t acpi_calc_checksum(const uint8_t *data, int len);
-uint32_t acpi_find_rsdp_address(void);
-void acpi_parse_rsdp_table(uint32_t addr, AcpiRsdpDescriptor *rsdp_table);
+uint32_t acpi_find_rsdp_address(QTestState *qts);
+void acpi_parse_rsdp_table(QTestState *qts, uint32_t addr,
+                           AcpiRsdpDescriptor *rsdp_table);

 #endif  /* TEST_ACPI_UTILS_H */
diff --git a/tests/acpi-utils.c b/tests/acpi-utils.c
index 41dc1ea9b4..6dc8ca1a8c 100644
--- a/tests/acpi-utils.c
+++ b/tests/acpi-utils.c
@@ -32,7 +32,7 @@ uint8_t acpi_calc_checksum(const uint8_t *data, int len)
     return sum;
 }

-uint32_t acpi_find_rsdp_address(void)
+uint32_t acpi_find_rsdp_address(QTestState *qts)
 {
     uint32_t off;

@@ -42,7 +42,7 @@ uint32_t acpi_find_rsdp_address(void)
         int i;

         for (i = 0; i < sizeof sig - 1; ++i) {
-            sig[i] = readb(off + i);
+            sig[i] = qtest_readb(qts, off + i);
         }

         if (!memcmp(sig, "RSD PTR ", sizeof sig)) {
@@ -52,14 +52,15 @@ uint32_t acpi_find_rsdp_address(void)
     return off;
 }

-void acpi_parse_rsdp_table(uint32_t addr, AcpiRsdpDescriptor *rsdp_table)
+void acpi_parse_rsdp_table(QTestState *qts, uint32_t addr,
+                           AcpiRsdpDescriptor *rsdp_table)
 {
-    ACPI_READ_FIELD(rsdp_table->signature, addr);
+    ACPI_READ_FIELD(qts, rsdp_table->signature, addr);
     ACPI_ASSERT_CMP64(rsdp_table->signature, "RSD PTR ");

-    ACPI_READ_FIELD(rsdp_table->checksum, addr);
-    ACPI_READ_ARRAY(rsdp_table->oem_id, addr);
-    ACPI_READ_FIELD(rsdp_table->revision, addr);
-    ACPI_READ_FIELD(rsdp_table->rsdt_physical_address, addr);
-    ACPI_READ_FIELD(rsdp_table->length, addr);
+    ACPI_READ_FIELD(qts, rsdp_table->checksum, addr);
+    ACPI_READ_ARRAY(qts, rsdp_table->oem_id, addr);
+    ACPI_READ_FIELD(qts, rsdp_table->revision, addr);
+    ACPI_READ_FIELD(qts, rsdp_table->rsdt_physical_address, addr);
+    ACPI_READ_FIELD(qts, rsdp_table->length, addr);
 }
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index bde62bf1cf..4272ea1496 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -38,6 +38,7 @@ typedef struct {
     struct smbios_21_entry_point smbios_ep_table;
     uint8_t *required_struct_types;
     int required_struct_types_len;
+    QTestState *qts;
 } test_data;

 static char disk[] = "tests/acpi-test-disk-XXXXXX";
@@ -77,7 +78,7 @@ static void free_test_data(test_data *data)

 static void test_acpi_rsdp_address(test_data *data)
 {
-    uint32_t off = acpi_find_rsdp_address();
+    uint32_t off = acpi_find_rsdp_address(data->qts);
     g_assert_cmphex(off, <, 0x100000);
     data->rsdp_addr = off;
 }
@@ -87,7 +88,7 @@ static void test_acpi_rsdp_table(test_data *data)
     AcpiRsdpDescriptor *rsdp_table = &data->rsdp_table;
     uint32_t addr = data->rsdp_addr;

-    acpi_parse_rsdp_table(addr, rsdp_table);
+    acpi_parse_rsdp_table(data->qts, addr, rsdp_table);

     /* rsdp checksum is not for the whole table, but for the first 20 bytes */
     g_assert(!acpi_calc_checksum((uint8_t *)rsdp_table, 20));
@@ -102,7 +103,7 @@ static void test_acpi_rsdt_table(test_data *data)
     uint8_t checksum;

     /* read the header */
-    ACPI_READ_TABLE_HEADER(rsdt_table, addr);
+    ACPI_READ_TABLE_HEADER(data->qts, rsdt_table, addr);
     ACPI_ASSERT_CMP(rsdt_table->signature, "RSDT");

     /* compute the table entries in rsdt */
@@ -112,7 +113,7 @@ static void test_acpi_rsdt_table(test_data *data)

     /* get the addresses of the tables pointed by rsdt */
     tables = g_new0(uint32_t, tables_nr);
-    ACPI_READ_ARRAY_PTR(tables, tables_nr, addr);
+    ACPI_READ_ARRAY_PTR(data->qts, tables, tables_nr, addr);

     checksum = acpi_calc_checksum((uint8_t *)rsdt_table, rsdt_table->length) +
                acpi_calc_checksum((uint8_t *)tables,
@@ -128,63 +129,64 @@ static void test_acpi_fadt_table(test_data *data)
 {
     AcpiFadtDescriptorRev3 *fadt_table = &data->fadt_table;
     uint32_t addr;
+    QTestState *qts = data->qts;

     /* FADT table comes first */
     addr = data->rsdt_tables_addr[0];
-    ACPI_READ_TABLE_HEADER(fadt_table, addr);
+    ACPI_READ_TABLE_HEADER(qts, fadt_table, addr);

-    ACPI_READ_FIELD(fadt_table->firmware_ctrl, addr);
-    ACPI_READ_FIELD(fadt_table->dsdt, addr);
-    ACPI_READ_FIELD(fadt_table->model, addr);
-    ACPI_READ_FIELD(fadt_table->reserved1, addr);
-    ACPI_READ_FIELD(fadt_table->sci_int, addr);
-    ACPI_READ_FIELD(fadt_table->smi_cmd, addr);
-    ACPI_READ_FIELD(fadt_table->acpi_enable, addr);
-    ACPI_READ_FIELD(fadt_table->acpi_disable, addr);
-    ACPI_READ_FIELD(fadt_table->S4bios_req, addr);
-    ACPI_READ_FIELD(fadt_table->reserved2, addr);
-    ACPI_READ_FIELD(fadt_table->pm1a_evt_blk, addr);
-    ACPI_READ_FIELD(fadt_table->pm1b_evt_blk, addr);
-    ACPI_READ_FIELD(fadt_table->pm1a_cnt_blk, addr);
-    ACPI_READ_FIELD(fadt_table->pm1b_cnt_blk, addr);
-    ACPI_READ_FIELD(fadt_table->pm2_cnt_blk, addr);
-    ACPI_READ_FIELD(fadt_table->pm_tmr_blk, addr);
-    ACPI_READ_FIELD(fadt_table->gpe0_blk, addr);
-    ACPI_READ_FIELD(fadt_table->gpe1_blk, addr);
-    ACPI_READ_FIELD(fadt_table->pm1_evt_len, addr);
-    ACPI_READ_FIELD(fadt_table->pm1_cnt_len, addr);
-    ACPI_READ_FIELD(fadt_table->pm2_cnt_len, addr);
-    ACPI_READ_FIELD(fadt_table->pm_tmr_len, addr);
-    ACPI_READ_FIELD(fadt_table->gpe0_blk_len, addr);
-    ACPI_READ_FIELD(fadt_table->gpe1_blk_len, addr);
-    ACPI_READ_FIELD(fadt_table->gpe1_base, addr);
-    ACPI_READ_FIELD(fadt_table->reserved3, addr);
-    ACPI_READ_FIELD(fadt_table->plvl2_lat, addr);
-    ACPI_READ_FIELD(fadt_table->plvl3_lat, addr);
-    ACPI_READ_FIELD(fadt_table->flush_size, addr);
-    ACPI_READ_FIELD(fadt_table->flush_stride, addr);
-    ACPI_READ_FIELD(fadt_table->duty_offset, addr);
-    ACPI_READ_FIELD(fadt_table->duty_width, addr);
-    ACPI_READ_FIELD(fadt_table->day_alrm, addr);
-    ACPI_READ_FIELD(fadt_table->mon_alrm, addr);
-    ACPI_READ_FIELD(fadt_table->century, addr);
-    ACPI_READ_FIELD(fadt_table->boot_flags, addr);
-    ACPI_READ_FIELD(fadt_table->reserved, addr);
-    ACPI_READ_FIELD(fadt_table->flags, addr);
-    ACPI_READ_GENERIC_ADDRESS(fadt_table->reset_register, addr);
-    ACPI_READ_FIELD(fadt_table->reset_value, addr);
-    ACPI_READ_FIELD(fadt_table->arm_boot_flags, addr);
-    ACPI_READ_FIELD(fadt_table->minor_revision, addr);
-    ACPI_READ_FIELD(fadt_table->x_facs, addr);
-    ACPI_READ_FIELD(fadt_table->x_dsdt, addr);
-    ACPI_READ_GENERIC_ADDRESS(fadt_table->xpm1a_event_block, addr);
-    ACPI_READ_GENERIC_ADDRESS(fadt_table->xpm1b_event_block, addr);
-    ACPI_READ_GENERIC_ADDRESS(fadt_table->xpm1a_control_block, addr);
-    ACPI_READ_GENERIC_ADDRESS(fadt_table->xpm1b_control_block, addr);
-    ACPI_READ_GENERIC_ADDRESS(fadt_table->xpm2_control_block, addr);
-    ACPI_READ_GENERIC_ADDRESS(fadt_table->xpm_timer_block, addr);
-    ACPI_READ_GENERIC_ADDRESS(fadt_table->xgpe0_block, addr);
-    ACPI_READ_GENERIC_ADDRESS(fadt_table->xgpe1_block, addr);
+    ACPI_READ_FIELD(qts, fadt_table->firmware_ctrl, addr);
+    ACPI_READ_FIELD(qts, fadt_table->dsdt, addr);
+    ACPI_READ_FIELD(qts, fadt_table->model, addr);
+    ACPI_READ_FIELD(qts, fadt_table->reserved1, addr);
+    ACPI_READ_FIELD(qts, fadt_table->sci_int, addr);
+    ACPI_READ_FIELD(qts, fadt_table->smi_cmd, addr);
+    ACPI_READ_FIELD(qts, fadt_table->acpi_enable, addr);
+    ACPI_READ_FIELD(qts, fadt_table->acpi_disable, addr);
+    ACPI_READ_FIELD(qts, fadt_table->S4bios_req, addr);
+    ACPI_READ_FIELD(qts, fadt_table->reserved2, addr);
+    ACPI_READ_FIELD(qts, fadt_table->pm1a_evt_blk, addr);
+    ACPI_READ_FIELD(qts, fadt_table->pm1b_evt_blk, addr);
+    ACPI_READ_FIELD(qts, fadt_table->pm1a_cnt_blk, addr);
+    ACPI_READ_FIELD(qts, fadt_table->pm1b_cnt_blk, addr);
+    ACPI_READ_FIELD(qts, fadt_table->pm2_cnt_blk, addr);
+    ACPI_READ_FIELD(qts, fadt_table->pm_tmr_blk, addr);
+    ACPI_READ_FIELD(qts, fadt_table->gpe0_blk, addr);
+    ACPI_READ_FIELD(qts, fadt_table->gpe1_blk, addr);
+    ACPI_READ_FIELD(qts, fadt_table->pm1_evt_len, addr);
+    ACPI_READ_FIELD(qts, fadt_table->pm1_cnt_len, addr);
+    ACPI_READ_FIELD(qts, fadt_table->pm2_cnt_len, addr);
+    ACPI_READ_FIELD(qts, fadt_table->pm_tmr_len, addr);
+    ACPI_READ_FIELD(qts, fadt_table->gpe0_blk_len, addr);
+    ACPI_READ_FIELD(qts, fadt_table->gpe1_blk_len, addr);
+    ACPI_READ_FIELD(qts, fadt_table->gpe1_base, addr);
+    ACPI_READ_FIELD(qts, fadt_table->reserved3, addr);
+    ACPI_READ_FIELD(qts, fadt_table->plvl2_lat, addr);
+    ACPI_READ_FIELD(qts, fadt_table->plvl3_lat, addr);
+    ACPI_READ_FIELD(qts, fadt_table->flush_size, addr);
+    ACPI_READ_FIELD(qts, fadt_table->flush_stride, addr);
+    ACPI_READ_FIELD(qts, fadt_table->duty_offset, addr);
+    ACPI_READ_FIELD(qts, fadt_table->duty_width, addr);
+    ACPI_READ_FIELD(qts, fadt_table->day_alrm, addr);
+    ACPI_READ_FIELD(qts, fadt_table->mon_alrm, addr);
+    ACPI_READ_FIELD(qts, fadt_table->century, addr);
+    ACPI_READ_FIELD(qts, fadt_table->boot_flags, addr);
+    ACPI_READ_FIELD(qts, fadt_table->reserved, addr);
+    ACPI_READ_FIELD(qts, fadt_table->flags, addr);
+    ACPI_READ_GENERIC_ADDRESS(qts, fadt_table->reset_register, addr);
+    ACPI_READ_FIELD(qts, fadt_table->reset_value, addr);
+    ACPI_READ_FIELD(qts, fadt_table->arm_boot_flags, addr);
+    ACPI_READ_FIELD(qts, fadt_table->minor_revision, addr);
+    ACPI_READ_FIELD(qts, fadt_table->x_facs, addr);
+    ACPI_READ_FIELD(qts, fadt_table->x_dsdt, addr);
+    ACPI_READ_GENERIC_ADDRESS(qts, fadt_table->xpm1a_event_block, addr);
+    ACPI_READ_GENERIC_ADDRESS(qts, fadt_table->xpm1b_event_block, addr);
+    ACPI_READ_GENERIC_ADDRESS(qts, fadt_table->xpm1a_control_block, addr);
+    ACPI_READ_GENERIC_ADDRESS(qts, fadt_table->xpm1b_control_block, addr);
+    ACPI_READ_GENERIC_ADDRESS(qts, fadt_table->xpm2_control_block, addr);
+    ACPI_READ_GENERIC_ADDRESS(qts, fadt_table->xpm_timer_block, addr);
+    ACPI_READ_GENERIC_ADDRESS(qts, fadt_table->xgpe0_block, addr);
+    ACPI_READ_GENERIC_ADDRESS(qts, fadt_table->xgpe1_block, addr);

     ACPI_ASSERT_CMP(fadt_table->signature, "FACP");
     g_assert(!acpi_calc_checksum((uint8_t *)fadt_table, fadt_table->length));
@@ -195,26 +197,27 @@ static void test_acpi_facs_table(test_data *data)
     AcpiFacsDescriptorRev1 *facs_table = &data->facs_table;
     uint32_t addr = data->fadt_table.firmware_ctrl;

-    ACPI_READ_FIELD(facs_table->signature, addr);
-    ACPI_READ_FIELD(facs_table->length, addr);
-    ACPI_READ_FIELD(facs_table->hardware_signature, addr);
-    ACPI_READ_FIELD(facs_table->firmware_waking_vector, addr);
-    ACPI_READ_FIELD(facs_table->global_lock, addr);
-    ACPI_READ_FIELD(facs_table->flags, addr);
-    ACPI_READ_ARRAY(facs_table->resverved3, addr);
+    ACPI_READ_FIELD(data->qts, facs_table->signature, addr);
+    ACPI_READ_FIELD(data->qts, facs_table->length, addr);
+    ACPI_READ_FIELD(data->qts, facs_table->hardware_signature, addr);
+    ACPI_READ_FIELD(data->qts, facs_table->firmware_waking_vector, addr);
+    ACPI_READ_FIELD(data->qts, facs_table->global_lock, addr);
+    ACPI_READ_FIELD(data->qts, facs_table->flags, addr);
+    ACPI_READ_ARRAY(data->qts, facs_table->resverved3, addr);

     ACPI_ASSERT_CMP(facs_table->signature, "FACS");
 }

-static void test_dst_table(AcpiSdtTable *sdt_table, uint32_t addr)
+static void test_dst_table(test_data *data, AcpiSdtTable *sdt_table,
+                           uint32_t addr)
 {
     uint8_t checksum;

-    ACPI_READ_TABLE_HEADER(&sdt_table->header, addr);
+    ACPI_READ_TABLE_HEADER(data->qts, &sdt_table->header, addr);

     sdt_table->aml_len = sdt_table->header.length - sizeof(AcpiTableHeader);
     sdt_table->aml = g_malloc0(sdt_table->aml_len);
-    ACPI_READ_ARRAY_PTR(sdt_table->aml, sdt_table->aml_len, addr);
+    ACPI_READ_ARRAY_PTR(data->qts, sdt_table->aml, sdt_table->aml_len, addr);

     checksum = acpi_calc_checksum((uint8_t *)sdt_table,
                                   sizeof(AcpiTableHeader)) +
@@ -231,7 +234,7 @@ static void test_acpi_dsdt_table(test_data *data)
     memset(&dsdt_table, 0, sizeof(dsdt_table));
     data->tables = g_array_new(false, true, sizeof(AcpiSdtTable));

-    test_dst_table(&dsdt_table, addr);
+    test_dst_table(data, &dsdt_table, addr);
     ACPI_ASSERT_CMP(dsdt_table.header.signature, "DSDT");

     /* Place DSDT first */
@@ -248,7 +251,7 @@ static void test_acpi_tables(test_data *data)

         memset(&ssdt_table, 0, sizeof(ssdt_table));
         uint32_t addr = data->rsdt_tables_addr[i + 1]; /* fadt is first */
-        test_dst_table(&ssdt_table, addr);
+        test_dst_table(data, &ssdt_table, addr);
         g_array_append_val(data->tables, ssdt_table);
     }
 }
@@ -492,32 +495,32 @@ static bool smbios_ep_table_ok(test_data *data)
     struct smbios_21_entry_point *ep_table = &data->smbios_ep_table;
     uint32_t addr = data->smbios_ep_addr;

-    ACPI_READ_ARRAY(ep_table->anchor_string, addr);
+    ACPI_READ_ARRAY(data->qts, ep_table->anchor_string, addr);
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
+    ACPI_READ_FIELD(data->qts, ep_table->checksum, addr);
+    ACPI_READ_FIELD(data->qts, ep_table->length, addr);
+    ACPI_READ_FIELD(data->qts, ep_table->smbios_major_version, addr);
+    ACPI_READ_FIELD(data->qts, ep_table->smbios_minor_version, addr);
+    ACPI_READ_FIELD(data->qts, ep_table->max_structure_size, addr);
+    ACPI_READ_FIELD(data->qts, ep_table->entry_point_revision, addr);
+    ACPI_READ_ARRAY(data->qts, ep_table->formatted_area, addr);
+    ACPI_READ_ARRAY(data->qts, ep_table->intermediate_anchor_string, addr);
     if (memcmp(ep_table->intermediate_anchor_string, "_DMI_", 5)) {
         return false;
     }
-    ACPI_READ_FIELD(ep_table->intermediate_checksum, addr);
-    ACPI_READ_FIELD(ep_table->structure_table_length, addr);
+    ACPI_READ_FIELD(data->qts, ep_table->intermediate_checksum, addr);
+    ACPI_READ_FIELD(data->qts, ep_table->structure_table_length, addr);
     if (ep_table->structure_table_length == 0) {
         return false;
     }
-    ACPI_READ_FIELD(ep_table->structure_table_address, addr);
-    ACPI_READ_FIELD(ep_table->number_of_structures, addr);
+    ACPI_READ_FIELD(data->qts, ep_table->structure_table_address, addr);
+    ACPI_READ_FIELD(data->qts, ep_table->number_of_structures, addr);
     if (ep_table->number_of_structures == 0) {
         return false;
     }
-    ACPI_READ_FIELD(ep_table->smbios_bcd_revision, addr);
+    ACPI_READ_FIELD(data->qts, ep_table->smbios_bcd_revision, addr);
     if (acpi_calc_checksum((uint8_t *)ep_table, sizeof *ep_table) ||
         acpi_calc_checksum((uint8_t *)ep_table + 0x10,
                            sizeof *ep_table - 0x10)) {
@@ -536,7 +539,7 @@ static void test_smbios_entry_point(test_data *data)
         int i;

         for (i = 0; i < sizeof sig - 1; ++i) {
-            sig[i] = readb(off + i);
+            sig[i] = qtest_readb(data->qts, off + i);
         }

         if (!memcmp(sig, "_SM_", sizeof sig)) {
@@ -579,9 +582,9 @@ static void test_smbios_structs(test_data *data)
     for (i = 0; i < ep_table->number_of_structures; i++) {

         /* grab type and formatted area length from struct header */
-        type = readb(addr);
+        type = qtest_readb(data->qts, addr);
         g_assert_cmpuint(type, <=, SMBIOS_MAX_TYPE);
-        len = readb(addr + 1);
+        len = qtest_readb(data->qts, addr + 1);

         /* single-instance structs must not have been encountered before */
         if (smbios_single_instance(type)) {
@@ -593,7 +596,7 @@ static void test_smbios_structs(test_data *data)
         prv = crt = 1;
         while (prv || crt) {
             prv = crt;
-            crt = readb(addr + len);
+            crt = qtest_readb(data->qts, addr + len);
             len++;
         }

@@ -630,9 +633,9 @@ static void test_acpi_one(const char *params, test_data *data)
                            data->machine, "kvm:tcg",
                            params ? params : "", disk);

-    qtest_start(args);
+    data->qts = qtest_init(args);

-    boot_sector_test(global_qtest);
+    boot_sector_test(data->qts);

     test_acpi_rsdp_address(data);
     test_acpi_rsdp_table(data);
@@ -653,7 +656,8 @@ static void test_acpi_one(const char *params, test_data *data)
     test_smbios_entry_point(data);
     test_smbios_structs(data);

-    qtest_quit(global_qtest);
+    assert(!global_qtest);
+    qtest_quit(data->qts);
     g_free(args);
 }

diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
index 0ea98b86d7..970c6274fd 100644
--- a/tests/vmgenid-test.c
+++ b/tests/vmgenid-test.c
@@ -50,15 +50,15 @@ static uint32_t acpi_find_vgia(void)
     boot_sector_test(global_qtest);

     /* Tables should be initialized now. */
-    rsdp_offset = acpi_find_rsdp_address();
+    rsdp_offset = acpi_find_rsdp_address(global_qtest);

     g_assert_cmphex(rsdp_offset, <, RSDP_ADDR_INVALID);

-    acpi_parse_rsdp_table(rsdp_offset, &rsdp_table);
+    acpi_parse_rsdp_table(global_qtest, rsdp_offset, &rsdp_table);

     rsdt = rsdp_table.rsdt_physical_address;
     /* read the header */
-    ACPI_READ_TABLE_HEADER(&rsdt_table, rsdt);
+    ACPI_READ_TABLE_HEADER(global_qtest, &rsdt_table, rsdt);
     ACPI_ASSERT_CMP(rsdt_table.signature, "RSDT");

     /* compute the table entries in rsdt */
@@ -68,21 +68,21 @@ static uint32_t acpi_find_vgia(void)

     /* get the addresses of the tables pointed by rsdt */
     tables = g_new0(uint32_t, tables_nr);
-    ACPI_READ_ARRAY_PTR(tables, tables_nr, rsdt);
+    ACPI_READ_ARRAY_PTR(global_qtest, tables, tables_nr, rsdt);

     for (i = 0; i < tables_nr; i++) {
-        ACPI_READ_TABLE_HEADER(&ssdt_table, tables[i]);
+        ACPI_READ_TABLE_HEADER(global_qtest, &ssdt_table, tables[i]);
         if (!strncmp((char *)ssdt_table.oem_table_id, "VMGENID", 7)) {
             /* the first entry in the table should be VGIA
              * That's all we need
              */
-            ACPI_READ_FIELD(vgid_table.name_op, tables[i]);
+            ACPI_READ_FIELD(global_qtest, vgid_table.name_op, tables[i]);
             g_assert(vgid_table.name_op == 0x08);  /* name */
-            ACPI_READ_ARRAY(vgid_table.vgia, tables[i]);
+            ACPI_READ_ARRAY(global_qtest, vgid_table.vgia, tables[i]);
             g_assert(memcmp(vgid_table.vgia, "VGIA", 4) == 0);
-            ACPI_READ_FIELD(vgid_table.val_op, tables[i]);
+            ACPI_READ_FIELD(global_qtest, vgid_table.val_op, tables[i]);
             g_assert(vgid_table.val_op == 0x0C);  /* dword */
-            ACPI_READ_FIELD(vgid_table.vgia_val, tables[i]);
+            ACPI_READ_FIELD(global_qtest, vgid_table.vgia_val, tables[i]);
             /* The GUID is written at a fixed offset into the fw_cfg file
              * in order to implement the "OVMF SDT Header probe suppressor"
              * see docs/specs/vmgenid.txt for more details
-- 
2.13.5
