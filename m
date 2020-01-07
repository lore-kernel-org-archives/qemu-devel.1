Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047B0C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 09:29:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA1A120656
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 09:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1A120656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iolAp-0004T2-TL
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 04:29:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prime.zeng@hisilicon.com>) id 1iol5C-0005Xe-9z
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 04:23:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prime.zeng@hisilicon.com>) id 1iol52-00080o-Pu
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 04:23:19 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2229 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prime.zeng@hisilicon.com>)
 id 1iol4x-0007kv-Qa; Tue, 07 Jan 2020 04:23:12 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id B80F5282A2F41FAD5E84;
 Tue,  7 Jan 2020 17:23:03 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Tue, 7 Jan 2020 17:22:55 +0800
From: Zeng Tao <prime.zeng@hisilicon.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH] hw/arm/acpi: Pack the SRAT processors structure by node_id
 ascending order
Date: Tue, 7 Jan 2020 17:18:49 +0800
Message-ID: <1578388729-55540-1-git-send-email-prime.zeng@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, Shannon
 Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Zeng Tao <prime.zeng@hisilicon.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When booting the guest linux with the following numa configuration:
-numa node,node_id=1,cpus=0-3
-numa node,node_id=0,cpus=4-7
We can get the following numa topology in the guest system:
Architecture:          aarch64
Byte Order:            Little Endian
CPU(s):                8
On-line CPU(s) list:   0-7
Thread(s) per core:    1
Core(s) per socket:    8
Socket(s):             1
NUMA node(s):          2
L1d cache:             unknown size
L1i cache:             unknown size
L2 cache:              unknown size
NUMA node0 CPU(s):     0-3
NUMA node1 CPU(s):     4-7
The Cpus 0-3 is assigned with NUMA node 1 in QEMU while it get NUMA node
0 in the guest.

In fact, In the linux kernel, numa_node_id is allocated per the ACPI
SRAT processors structure order,so the cpu 0 will be the first one to
allocate its NUMA node id, so it gets the NUMA node 0.

To fix this issue, we pack the SRAT processors structure in numa node id
order but not the default cpu number order.

Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
---
 hw/arm/virt-acpi-build.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index bd5f771..497192b 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -520,7 +520,8 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     AcpiSystemResourceAffinityTable *srat;
     AcpiSratProcessorGiccAffinity *core;
     AcpiSratMemoryAffinity *numamem;
-    int i, srat_start;
+    int i, j, srat_start;
+    uint32_t node_id;
     uint64_t mem_base;
     MachineClass *mc = MACHINE_GET_CLASS(vms);
     MachineState *ms = MACHINE(vms);
@@ -530,13 +531,19 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     srat = acpi_data_push(table_data, sizeof(*srat));
     srat->reserved1 = cpu_to_le32(1);
 
-    for (i = 0; i < cpu_list->len; ++i) {
-        core = acpi_data_push(table_data, sizeof(*core));
-        core->type = ACPI_SRAT_PROCESSOR_GICC;
-        core->length = sizeof(*core);
-        core->proximity = cpu_to_le32(cpu_list->cpus[i].props.node_id);
-        core->acpi_processor_uid = cpu_to_le32(i);
-        core->flags = cpu_to_le32(1);
+    for (i = 0; i < ms->numa_state->num_nodes; ++i) {
+        for (j = 0; j < cpu_list->len; ++j) {
+            node_id = cpu_to_le32(cpu_list->cpus[j].props.node_id);
+            if (node_id != i) {
+                continue;
+            }
+            core = acpi_data_push(table_data, sizeof(*core));
+            core->type = ACPI_SRAT_PROCESSOR_GICC;
+            core->length = sizeof(*core);
+            core->proximity = node_id;
+            core->acpi_processor_uid = cpu_to_le32(j);
+            core->flags = cpu_to_le32(1);
+        }
     }
 
     mem_base = vms->memmap[VIRT_MEM].base;
-- 
2.8.1


