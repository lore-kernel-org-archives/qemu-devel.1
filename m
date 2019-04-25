Received: from eggs.gnu.org ([209.51.188.92]:52437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJZft-0001uL-12
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:24:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJZfp-0008Nz-UL
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:24:08 -0400
Received: from mga12.intel.com ([192.55.52.136]:21131)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hJZfm-0008LB-Gq
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:24:03 -0400
Date: Thu, 25 Apr 2019 16:23:31 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190425082331.GH24829@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
	<1556170489-131927-2-git-send-email-imammedo@redhat.com>
	<20190425072256.GA24344@richard>
	<20190425100751.11ac20bf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425100751.11ac20bf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 01/13] tests: acpi: make RSDT test
 routine handle XSDT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, Andrew Jones <drjones@redhat.com>, Ben Warren <ben@skyportsystems.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Gonglei <arei.gonglei@huawei.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>

On Thu, Apr 25, 2019 at 10:07:51AM +0200, Igor Mammedov wrote:
>On Thu, 25 Apr 2019 15:22:56 +0800
>Wei Yang <richardw.yang@linux.intel.com> wrote:
>
>> On Thu, Apr 25, 2019 at 07:34:37AM +0200, Igor Mammedov wrote:
>> >If RSDP revision is more than 0 fetch table pointed by XSDT
>> >and fallback to legacy RSDT table otherwise.
>> >
>> >While at it drop unused acpi_get_xsdt_address().  
>> 
>> Would it be proper to split this into another patch?
>
>it should be fine to remove code that's being replaced by new one
>which substitutes the former within the same patch.
>but if you insist I can split it into another patch.

I am fine with this included.

>
>> >
>> >Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>> >---
>> >PS:
>> > it doesn't affect existing pc/q35 machines as they use RSDP.revision == 0
>> > but it will be used by followup patch to enable testing arm/virt
>> > board which uses provides XSDT table.
>> >---
>> > tests/acpi-utils.h       |  3 +--
>> > tests/acpi-utils.c       | 14 +-------------
>> > tests/bios-tables-test.c | 18 +++++++++++++-----
>> > 3 files changed, 15 insertions(+), 20 deletions(-)
>> >
>> >diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
>> >index ef388bb..8c68201 100644
>> >--- a/tests/acpi-utils.h
>> >+++ b/tests/acpi-utils.h
>> >@@ -46,8 +46,7 @@ typedef struct {
>> > 
>> > uint8_t acpi_calc_checksum(const uint8_t *data, int len);
>> > uint32_t acpi_find_rsdp_address(QTestState *qts);
>> >-uint64_t acpi_get_xsdt_address(uint8_t *rsdp_table);
>> >-void acpi_parse_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table);
>> >+void acpi_parse_rsdp_table(QTestState *qts, uint64_t addr, uint8_t *rsdp_table);  
>> 
>> Would you mind giving some hint of this change?
>thanks for spotting it. IT certainly doesn't belong to this patch.
>I'll need to recheck if supporting 64bit address fields is done properly
>and find another place where to move this hunk.
>
>> 
>> > void acpi_fetch_table(QTestState *qts, uint8_t **aml, uint32_t *aml_len,
>> >                       const uint8_t *addr_ptr, const char *sig,
>> >                       bool verify_checksum);
>> >diff --git a/tests/acpi-utils.c b/tests/acpi-utils.c
>> >index cc33b46..9a6d1d3 100644
>> >--- a/tests/acpi-utils.c
>> >+++ b/tests/acpi-utils.c
>> >@@ -51,19 +51,7 @@ uint32_t acpi_find_rsdp_address(QTestState *qts)
>> >     return off;
>> > }
>> > 
>> >-uint64_t acpi_get_xsdt_address(uint8_t *rsdp_table)
>> >-{
>> >-    uint64_t xsdt_physical_address;
>> >-    uint8_t revision = rsdp_table[15 /* Revision offset */];
>> >-
>> >-    /* We must have revision 2 if we're looking for an XSDT pointer */
>> >-    g_assert(revision == 2);
>> >-
>> >-    memcpy(&xsdt_physical_address, &rsdp_table[24 /* XsdtAddress offset */], 8);
>> >-    return le64_to_cpu(xsdt_physical_address);
>> >-}
>> >-
>> >-void acpi_parse_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table)
>> >+void acpi_parse_rsdp_table(QTestState *qts, uint64_t addr, uint8_t *rsdp_table)
>> > {
>> >     uint8_t revision;
>> > 
>> >diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
>> >index a506dcb..24bd102 100644
>> >--- a/tests/bios-tables-test.c
>> >+++ b/tests/bios-tables-test.c
>> >@@ -107,17 +107,25 @@ static void test_acpi_rsdp_table(test_data *data)
>> >     }
>> > }
>> > 
>> >-static void test_acpi_rsdt_table(test_data *data)
>> >+static void test_acpi_rxsdt_table(test_data *data)
>> > {
>> >+    const char *sig = "RSDT";
>> >     AcpiSdtTable rsdt = {};
>> >+    int entry_size = 4;
>> >+    int addr_off = 16 /* RsdtAddress */;
>> >     uint8_t *ent;
>> > 
>> >-    /* read RSDT table */
>> >+    if (data->rsdp_table[15 /* Revision offset */] != 0) {
>> >+        addr_off = 24 /* XsdtAddress */;
>> >+        entry_size = 8;
>> >+        sig = "XSDT";
>> >+    }
>> >+    /* read [RX]SDT table */
>> >     acpi_fetch_table(data->qts, &rsdt.aml, &rsdt.aml_len,
>> >-                     &data->rsdp_table[16 /* RsdtAddress */], "RSDT", true);
>> >+                     &data->rsdp_table[addr_off], sig, true);
>> > 
>> >     /* Load all tables and add to test list directly RSDT referenced tables */
>> >-    ACPI_FOREACH_RSDT_ENTRY(rsdt.aml, rsdt.aml_len, ent, 4 /* Entry size */) {
>> >+    ACPI_FOREACH_RSDT_ENTRY(rsdt.aml, rsdt.aml_len, ent, entry_size) {
>> >         AcpiSdtTable ssdt_table = {};
>> > 
>> >         acpi_fetch_table(data->qts, &ssdt_table.aml, &ssdt_table.aml_len, ent,
>> >@@ -521,7 +529,7 @@ static void test_acpi_one(const char *params, test_data *data)
>> >     data->tables = g_array_new(false, true, sizeof(AcpiSdtTable));
>> >     test_acpi_rsdp_address(data);
>> >     test_acpi_rsdp_table(data);
>> >-    test_acpi_rsdt_table(data);
>> >+    test_acpi_rxsdt_table(data);
>> >     test_acpi_fadt_table(data);
>> > 
>> >     if (iasl) {
>> >-- 
>> >2.7.4  
>> 

-- 
Wei Yang
Help you, Help me
