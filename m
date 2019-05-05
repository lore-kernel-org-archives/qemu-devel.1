Received: from eggs.gnu.org ([209.51.188.92]:48896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hN5UA-0000Hc-VK
	for qemu-devel@nongnu.org; Sat, 04 May 2019 20:58:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hN5U9-0002Tb-Ds
	for qemu-devel@nongnu.org; Sat, 04 May 2019 20:58:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:18134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hN5U9-0002Sj-5q
	for qemu-devel@nongnu.org; Sat, 04 May 2019 20:58:33 -0400
Date: Sun, 5 May 2019 08:58:01 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190505005801.GA20071@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
	<1556808723-226478-3-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556808723-226478-3-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 02/15] tests: acpi: make
 acpi_fetch_table() take size of fetched table pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Wei Yang <richardw.yang@linux.intel.com>, Andrew Jones <drjones@redhat.com>, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Ben Warren <ben@skyportsystems.com>, xuwei5@hisilicon.com, xuwei5@huawei.com, linuxarm@huawei.com

On Thu, May 02, 2019 at 04:51:50PM +0200, Igor Mammedov wrote:
>Currently acpi_fetch_table() assumes 32 bit size of table pointer
>in ACPI tables. However X_foo variants are 64 bit, prepare
>acpi_fetch_table() to handle both by adding an argument
>for addr_ptr pointed entry size. Follow up commits will use that
>to read XSDT and X_foo entries in ACPI tables.
>
>Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

>---
> tests/acpi-utils.h       |  2 +-
> tests/acpi-utils.c       | 10 ++++++----
> tests/bios-tables-test.c |  8 ++++----
> tests/vmgenid-test.c     |  4 ++--
> 4 files changed, 13 insertions(+), 11 deletions(-)
>
>diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
>index 4cd5553..92285b7 100644
>--- a/tests/acpi-utils.h
>+++ b/tests/acpi-utils.h
>@@ -49,7 +49,7 @@ uint32_t acpi_find_rsdp_address(QTestState *qts);
> uint64_t acpi_get_xsdt_address(uint8_t *rsdp_table);
> void acpi_fetch_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table);
> void acpi_fetch_table(QTestState *qts, uint8_t **aml, uint32_t *aml_len,
>-                      const uint8_t *addr_ptr, const char *sig,
>+                      const uint8_t *addr_ptr, int addr_size, const char *sig,
>                       bool verify_checksum);
> 
> #endif  /* TEST_ACPI_UTILS_H */
>diff --git a/tests/acpi-utils.c b/tests/acpi-utils.c
>index 633d8f5..644c87b 100644
>--- a/tests/acpi-utils.c
>+++ b/tests/acpi-utils.c
>@@ -91,13 +91,15 @@ void acpi_fetch_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table)
>  *  actual one.
>  */
> void acpi_fetch_table(QTestState *qts, uint8_t **aml, uint32_t *aml_len,
>-                      const uint8_t *addr_ptr, const char *sig,
>+                      const uint8_t *addr_ptr, int addr_size, const char *sig,
>                       bool verify_checksum)
> {
>-    uint32_t addr, len;
>+    uint32_t len;
>+    uint64_t addr = 0;
> 
>-    memcpy(&addr, addr_ptr , sizeof(addr));
>-    addr = le32_to_cpu(addr);
>+    g_assert(addr_size == 4 || addr_size == 8);
>+    memcpy(&addr, addr_ptr , addr_size);
>+    addr = le64_to_cpu(addr);
>     qtest_memread(qts, addr + 4, &len, 4); /* Length of ACPI table */
>     *aml_len = le32_to_cpu(len);
>     *aml = g_malloc0(*aml_len);
>diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
>index 6a678bf..86b592c 100644
>--- a/tests/bios-tables-test.c
>+++ b/tests/bios-tables-test.c
>@@ -114,14 +114,14 @@ static void test_acpi_rsdt_table(test_data *data)
> 
>     /* read RSDT table */
>     acpi_fetch_table(data->qts, &rsdt.aml, &rsdt.aml_len,
>-                     &data->rsdp_table[16 /* RsdtAddress */], "RSDT", true);
>+                     &data->rsdp_table[16 /* RsdtAddress */], 4, "RSDT", true);
> 
>     /* Load all tables and add to test list directly RSDT referenced tables */
>     ACPI_FOREACH_RSDT_ENTRY(rsdt.aml, rsdt.aml_len, ent, 4 /* Entry size */) {
>         AcpiSdtTable ssdt_table = {};
> 
>         acpi_fetch_table(data->qts, &ssdt_table.aml, &ssdt_table.aml_len, ent,
>-                         NULL, true);
>+                         4, NULL, true);
>         /* Add table to ASL test tables list */
>         g_array_append_val(data->tables, ssdt_table);
>     }
>@@ -139,11 +139,11 @@ static void test_acpi_fadt_table(test_data *data)
> 
>     /* Since DSDT/FACS isn't in RSDT, add them to ASL test list manually */
>     acpi_fetch_table(data->qts, &table.aml, &table.aml_len,
>-                     fadt_aml + 36 /* FIRMWARE_CTRL */, "FACS", false);
>+                     fadt_aml + 36 /* FIRMWARE_CTRL */, 4, "FACS", false);
>     g_array_append_val(data->tables, table);
> 
>     acpi_fetch_table(data->qts, &table.aml, &table.aml_len,
>-                     fadt_aml + 40 /* DSDT */, "DSDT", true);
>+                     fadt_aml + 40 /* DSDT */, 4, "DSDT", true);
>     g_array_append_val(data->tables, table);
> 
>     memset(fadt_aml + 36, 0, 4); /* sanitize FIRMWARE_CTRL ptr */
>diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
>index f400184..85d8e64 100644
>--- a/tests/vmgenid-test.c
>+++ b/tests/vmgenid-test.c
>@@ -42,12 +42,12 @@ static uint32_t acpi_find_vgia(QTestState *qts)
> 
>     acpi_fetch_rsdp_table(qts, rsdp_offset, rsdp_table);
>     acpi_fetch_table(qts, &rsdt, &rsdt_len, &rsdp_table[16 /* RsdtAddress */],
>-                     "RSDT", true);
>+                     4, "RSDT", true);
> 
>     ACPI_FOREACH_RSDT_ENTRY(rsdt, rsdt_len, ent, 4 /* Entry size */) {
>         uint8_t *table_aml;
> 
>-        acpi_fetch_table(qts, &table_aml, &table_length, ent, NULL, true);
>+        acpi_fetch_table(qts, &table_aml, &table_length, ent, 4, NULL, true);
>         if (!memcmp(table_aml + 16 /* OEM Table ID */, "VMGENID", 7)) {
>             uint32_t vgia_val;
>             uint8_t *aml = &table_aml[36 /* AML byte-code start */];
>-- 
>2.7.4

-- 
Wei Yang
Help you, Help me
