Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C3BC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:11:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B1E420675
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B1E420675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52835 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMDMa-0004YM-A8
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 11:11:08 -0400
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
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ECB42307EA8B;
	Thu,  2 May 2019 14:52:03 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 74A0C71C80;
	Thu,  2 May 2019 14:51:56 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 16:51:51 +0200
Message-Id: <1556808723-226478-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
References: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Thu, 02 May 2019 14:52:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 03/15] tests: acpi: make RSDT test routine
 handle XSDT
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrew Jones <drjones@redhat.com>, Ben Warren <ben@skyportsystems.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Laszlo Ersek <lersek@redhat.com>, linuxarm@huawei.com,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Shannon Zhao <shannon.zhaosl@gmail.com>, Gonglei <arei.gonglei@huawei.com>,
	Wei Yang <richardw.yang@linux.intel.com>, xuwei5@huawei.com,
	xuwei5@hisilicon.com,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502145151.DB2tWgE0gSHr1ITpQG6EkUs3iTotBblo6MKKaJ5XcO0@z>

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


