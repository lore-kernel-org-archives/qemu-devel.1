Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E68C2BB85
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 10:58:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D32620731
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 10:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D32620731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLlwE-0001HN-9J
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 06:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <miaoyubo@huawei.com>) id 1jLlvG-00080E-4N
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:57:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <miaoyubo@huawei.com>) id 1jLlvF-0007SH-3n
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:57:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3660 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <miaoyubo@huawei.com>) id 1jLlvE-0007P3-Dq
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:57:36 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id E717FF93C05087F294D7;
 Tue,  7 Apr 2020 18:57:27 +0800 (CST)
Received: from DESKTOP-D7EVK5B.china.huawei.com (10.173.221.29) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Tue, 7 Apr 2020 18:57:20 +0800
From: Yubo Miao <miaoyubo@huawei.com>
To: <peter.maydell@linaro.org>, <shannon.zhaosl@gmail.com>, <lersek@redhat.com>
Subject: [PATCH v5 5/8] acpi: align the size to 128k
Date: Tue, 7 Apr 2020 18:57:03 +0800
Message-ID: <20200407105706.1920-6-miaoyubo@huawei.com>
X-Mailer: git-send-email 2.24.1.windows.2
In-Reply-To: <20200407105706.1920-1-miaoyubo@huawei.com>
References: <20200407105706.1920-1-miaoyubo@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.221.29]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: berrange@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, miaoyubo@huawei.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: miaoyubo <miaoyubo@huawei.com>

If table size is changed between virt_acpi_build and
virt_acpi_build_update, the table size would not be updated to
UEFI, therefore, just align the size to 128kb, which is enough
and same with x86. It would warn if 64k is not enough and the
align size should be updated.

Signed-off-by: miaoyubo <miaoyubo@huawei.com>
---
 hw/arm/virt-acpi-build.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 7bcd04dfb7..89bb768b0c 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -54,6 +54,8 @@
 #include "hw/pci/pci_bridge.h"
 #define ARM_SPI_BASE 32
=20
+#define ACPI_BUILD_TABLE_SIZE             0x20000
+
 static void acpi_dsdt_add_cpus(Aml *scope, int smp_cpus)
 {
     uint16_t i;
@@ -883,6 +885,15 @@ struct AcpiBuildState {
     bool patched;
 } AcpiBuildState;
=20
+static void acpi_align_size(GArray *blob, unsigned align)
+{
+    /*
+     * Align size to multiple of given size. This reduces the chance
+     * we need to change size in the future (breaking cross version migr=
ation).
+     */
+    g_array_set_size(blob, ROUND_UP(acpi_data_len(blob), align));
+}
+
 static
 void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
 {
@@ -953,6 +964,20 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuil=
dTables *tables)
         build_rsdp(tables->rsdp, tables->linker, &rsdp_data);
     }
=20
+    /*
+     * The align size is 128, warn if 64k is not enough therefore
+     * the align size could be resized.
+     */
+    if (tables_blob->len > ACPI_BUILD_TABLE_SIZE / 2) {
+        warn_report("ACPI table size %u exceeds %d bytes,"
+                    " migration may not work",
+                    tables_blob->len, ACPI_BUILD_TABLE_SIZE / 2);
+        error_printf("Try removing CPUs, NUMA nodes, memory slots"
+                     " or PCI bridges.");
+    }
+    acpi_align_size(tables_blob, ACPI_BUILD_TABLE_SIZE);
+
+
     /* Cleanup memory that's no longer used. */
     g_array_free(table_offsets, true);
 }
--=20
2.19.1



