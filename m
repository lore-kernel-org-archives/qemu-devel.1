Received: from eggs.gnu.org ([2001:4830:134:3::10]:56282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqIv-0007Y2-HV
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:04:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqIq-00021d-Az
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:04:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dnqIq-000200-2k
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:04:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 28491C056819
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 18:04:23 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri,  1 Sep 2017 13:03:35 -0500
Message-Id: <20170901180340.30009-25-eblake@redhat.com>
In-Reply-To: <20170901180340.30009-1-eblake@redhat.com>
References: <20170901180340.30009-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v6 24/29] bios-tables-test: Drop dependence on
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
Cc: armbru@redhat.com, pbonzini@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

As a general rule, we prefer avoiding implicit global state
because it makes code harder to safely copy and paste without
thinking about the global state.  Although bios-tables-test does
not maintain parallel qtest connections, it's just as easy to be
explicit about the state; once all tests have been cleaned up, a
later patch can then get rid of global_qtest and a layer of
wrappers in libqtest.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/bios-tables-test.c | 78 +++++++++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 38 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 75b29df493..976792f2c5 100644
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
-    uint32_t off = acpi_find_rsdp_address(global_qtest);
+    uint32_t off = acpi_find_rsdp_address(data->qts);
     g_assert_cmphex(off, <, 0x100000);
     data->rsdp_addr = off;
 }
@@ -87,7 +88,7 @@ static void test_acpi_rsdp_table(test_data *data)
     AcpiRsdpDescriptor *rsdp_table = &data->rsdp_table;
     uint32_t addr = data->rsdp_addr;

-    acpi_parse_rsdp_table(global_qtest, addr, rsdp_table);
+    acpi_parse_rsdp_table(data->qts, addr, rsdp_table);

     /* rsdp checksum is not for the whole table, but for the first 20 bytes */
     g_assert(!acpi_calc_checksum((uint8_t *)rsdp_table, 20));
@@ -102,7 +103,7 @@ static void test_acpi_rsdt_table(test_data *data)
     uint8_t checksum;

     /* read the header */
-    ACPI_READ_TABLE_HEADER(global_qtest, rsdt_table, addr);
+    ACPI_READ_TABLE_HEADER(data->qts, rsdt_table, addr);
     ACPI_ASSERT_CMP(rsdt_table->signature, "RSDT");

     /* compute the table entries in rsdt */
@@ -112,7 +113,7 @@ static void test_acpi_rsdt_table(test_data *data)

     /* get the addresses of the tables pointed by rsdt */
     tables = g_new0(uint32_t, tables_nr);
-    ACPI_READ_ARRAY_PTR(global_qtest, tables, tables_nr, addr);
+    ACPI_READ_ARRAY_PTR(data->qts, tables, tables_nr, addr);

     checksum = acpi_calc_checksum((uint8_t *)rsdt_table, rsdt_table->length) +
                acpi_calc_checksum((uint8_t *)tables,
@@ -128,7 +129,7 @@ static void test_acpi_fadt_table(test_data *data)
 {
     AcpiFadtDescriptorRev3 *fadt_table = &data->fadt_table;
     uint32_t addr;
-    QTestState *qts = global_qtest;
+    QTestState *qts = data->qts;

     /* FADT table comes first */
     addr = data->rsdt_tables_addr[0];
@@ -196,26 +197,27 @@ static void test_acpi_facs_table(test_data *data)
     AcpiFacsDescriptorRev1 *facs_table = &data->facs_table;
     uint32_t addr = data->fadt_table.firmware_ctrl;

-    ACPI_READ_FIELD(global_qtest, facs_table->signature, addr);
-    ACPI_READ_FIELD(global_qtest, facs_table->length, addr);
-    ACPI_READ_FIELD(global_qtest, facs_table->hardware_signature, addr);
-    ACPI_READ_FIELD(global_qtest, facs_table->firmware_waking_vector, addr);
-    ACPI_READ_FIELD(global_qtest, facs_table->global_lock, addr);
-    ACPI_READ_FIELD(global_qtest, facs_table->flags, addr);
-    ACPI_READ_ARRAY(global_qtest, facs_table->resverved3, addr);
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

-    ACPI_READ_TABLE_HEADER(global_qtest, &sdt_table->header, addr);
+    ACPI_READ_TABLE_HEADER(data->qts, &sdt_table->header, addr);

     sdt_table->aml_len = sdt_table->header.length - sizeof(AcpiTableHeader);
     sdt_table->aml = g_malloc0(sdt_table->aml_len);
-    ACPI_READ_ARRAY_PTR(global_qtest, sdt_table->aml, sdt_table->aml_len, addr);
+    ACPI_READ_ARRAY_PTR(data->qts, sdt_table->aml, sdt_table->aml_len, addr);

     checksum = acpi_calc_checksum((uint8_t *)sdt_table,
                                   sizeof(AcpiTableHeader)) +
@@ -232,7 +234,7 @@ static void test_acpi_dsdt_table(test_data *data)
     memset(&dsdt_table, 0, sizeof(dsdt_table));
     data->tables = g_array_new(false, true, sizeof(AcpiSdtTable));

-    test_dst_table(&dsdt_table, addr);
+    test_dst_table(data, &dsdt_table, addr);
     ACPI_ASSERT_CMP(dsdt_table.header.signature, "DSDT");

     /* Place DSDT first */
@@ -249,7 +251,7 @@ static void test_acpi_tables(test_data *data)

         memset(&ssdt_table, 0, sizeof(ssdt_table));
         uint32_t addr = data->rsdt_tables_addr[i + 1]; /* fadt is first */
-        test_dst_table(&ssdt_table, addr);
+        test_dst_table(data, &ssdt_table, addr);
         g_array_append_val(data->tables, ssdt_table);
     }
 }
@@ -493,32 +495,32 @@ static bool smbios_ep_table_ok(test_data *data)
     struct smbios_21_entry_point *ep_table = &data->smbios_ep_table;
     uint32_t addr = data->smbios_ep_addr;

-    ACPI_READ_ARRAY(global_qtest, ep_table->anchor_string, addr);
+    ACPI_READ_ARRAY(data->qts, ep_table->anchor_string, addr);
     if (memcmp(ep_table->anchor_string, "_SM_", 4)) {
         return false;
     }
-    ACPI_READ_FIELD(global_qtest, ep_table->checksum, addr);
-    ACPI_READ_FIELD(global_qtest, ep_table->length, addr);
-    ACPI_READ_FIELD(global_qtest, ep_table->smbios_major_version, addr);
-    ACPI_READ_FIELD(global_qtest, ep_table->smbios_minor_version, addr);
-    ACPI_READ_FIELD(global_qtest, ep_table->max_structure_size, addr);
-    ACPI_READ_FIELD(global_qtest, ep_table->entry_point_revision, addr);
-    ACPI_READ_ARRAY(global_qtest, ep_table->formatted_area, addr);
-    ACPI_READ_ARRAY(global_qtest, ep_table->intermediate_anchor_string, addr);
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
-    ACPI_READ_FIELD(global_qtest, ep_table->intermediate_checksum, addr);
-    ACPI_READ_FIELD(global_qtest, ep_table->structure_table_length, addr);
+    ACPI_READ_FIELD(data->qts, ep_table->intermediate_checksum, addr);
+    ACPI_READ_FIELD(data->qts, ep_table->structure_table_length, addr);
     if (ep_table->structure_table_length == 0) {
         return false;
     }
-    ACPI_READ_FIELD(global_qtest, ep_table->structure_table_address, addr);
-    ACPI_READ_FIELD(global_qtest, ep_table->number_of_structures, addr);
+    ACPI_READ_FIELD(data->qts, ep_table->structure_table_address, addr);
+    ACPI_READ_FIELD(data->qts, ep_table->number_of_structures, addr);
     if (ep_table->number_of_structures == 0) {
         return false;
     }
-    ACPI_READ_FIELD(global_qtest, ep_table->smbios_bcd_revision, addr);
+    ACPI_READ_FIELD(data->qts, ep_table->smbios_bcd_revision, addr);
     if (acpi_calc_checksum((uint8_t *)ep_table, sizeof *ep_table) ||
         acpi_calc_checksum((uint8_t *)ep_table + 0x10,
                            sizeof *ep_table - 0x10)) {
@@ -537,7 +539,7 @@ static void test_smbios_entry_point(test_data *data)
         int i;

         for (i = 0; i < sizeof sig - 1; ++i) {
-            sig[i] = readb(off + i);
+            sig[i] = qtest_readb(data->qts, off + i);
         }

         if (!memcmp(sig, "_SM_", sizeof sig)) {
@@ -580,9 +582,9 @@ static void test_smbios_structs(test_data *data)
     for (i = 0; i < ep_table->number_of_structures; i++) {

         /* grab type and formatted area length from struct header */
-        type = readb(addr);
+        type = qtest_readb(data->qts, addr);
         g_assert_cmpuint(type, <=, SMBIOS_MAX_TYPE);
-        len = readb(addr + 1);
+        len = qtest_readb(data->qts, addr + 1);

         /* single-instance structs must not have been encountered before */
         if (smbios_single_instance(type)) {
@@ -594,7 +596,7 @@ static void test_smbios_structs(test_data *data)
         prv = crt = 1;
         while (prv || crt) {
             prv = crt;
-            crt = readb(addr + len);
+            crt = qtest_readb(data->qts, addr + len);
             len++;
         }

@@ -631,9 +633,9 @@ static void test_acpi_one(const char *params, test_data *data)
                            data->machine, "kvm:tcg",
                            params ? params : "", disk);

-    qtest_start(args);
+    data->qts = qtest_init(args);

-    boot_sector_test(global_qtest);
+    boot_sector_test(data->qts);

     test_acpi_rsdp_address(data);
     test_acpi_rsdp_table(data);
@@ -654,7 +656,7 @@ static void test_acpi_one(const char *params, test_data *data)
     test_smbios_entry_point(data);
     test_smbios_structs(data);

-    qtest_quit(global_qtest);
+    qtest_quit(data->qts);
     g_free(args);
 }

-- 
2.13.5
