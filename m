Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BF7C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 15:58:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DCA3222C0
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 15:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DCA3222C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGPyE-0000fo-Qv
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 11:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iGPuU-0006Ll-H9
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 11:54:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iGPuS-0000Y2-JI
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 11:54:25 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44636 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iGPuO-0000QO-93; Fri, 04 Oct 2019 11:54:20 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id BB987C4B2364335D9FB1;
 Fri,  4 Oct 2019 23:54:12 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.202.227.237) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Fri, 4 Oct 2019 23:54:03 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <eric.auger@redhat.com>,
 <imammedo@redhat.com>
Subject: [PATCH 1/5] hw/arm: Align ACPI blob len to PAGE size
Date: Fri, 4 Oct 2019 16:52:58 +0100
Message-ID: <20191004155302.4632-2-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20191004155302.4632-1-shameerali.kolothum.thodi@huawei.com>
References: <20191004155302.4632-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: peter.maydell@linaro.org, lersek@redhat.com, linuxarm@huawei.com,
 xuwei5@hisilicon.com, shannon.zhaosl@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If ACPI blob length modifications happens after the initial
virt_acpi_build() call, and the changed blob length is within
the PAGE size boundary, then the revised size is not seen by
the firmware on Guest reboot. The is because in the
virt_acpi_build_update() -> acpi_ram_update() -> qemu_ram_resize()
path, qemu_ram_resize() uses ram_block size which is aligned
to PAGE size and the "resize callback" to update the size seen
by firmware is not getting invoked. Hence align ACPI blob sizes
to PAGE boundary.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
More details on this issue can be found here,
https://patchwork.kernel.org/patch/11154757/

---
 hw/arm/virt-acpi-build.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 4cd50175e0..074e0c858e 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -790,6 +790,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     GArray *table_offsets;
     unsigned dsdt, xsdt;
     GArray *tables_blob = tables->table_data;
+    GArray *cmd_blob = tables->linker->cmd_blob;
     MachineState *ms = MACHINE(vms);
 
     table_offsets = g_array_new(false, true /* clear */,
@@ -854,6 +855,19 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
         build_rsdp(tables->rsdp, tables->linker, &rsdp_data);
     }
 
+    /*
+     * Align the ACPI blob lengths to PAGE size so that on ACPI table
+     * regeneration, the length that firmware sees really gets updated
+     * through 'resize' callback in qemu_ram_resize() in the
+     * virt_acpi_build_update() -> acpi_ram_update() -> qemu_ram_resize()
+     * path.
+     */
+    g_array_set_size(tables_blob,
+                     TARGET_PAGE_ALIGN(acpi_data_len(tables_blob)));
+    g_array_set_size(tables->rsdp,
+                     TARGET_PAGE_ALIGN(acpi_data_len(tables->rsdp)));
+    g_array_set_size(cmd_blob,
+                     TARGET_PAGE_ALIGN(acpi_data_len(cmd_blob)));
     /* Cleanup memory that's no longer used. */
     g_array_free(table_offsets, true);
 }
-- 
2.17.1



