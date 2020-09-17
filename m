Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA9FC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 03:26:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D517206C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 03:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D517206C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIkYp-0002ww-L5
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 23:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kIkUR-00054e-DZ; Wed, 16 Sep 2020 23:21:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4747 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kIkUM-0004RL-LY; Wed, 16 Sep 2020 23:21:43 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id D3C28BAC7ABDFF61A6C6;
 Thu, 17 Sep 2020 11:21:08 +0800 (CST)
Received: from localhost (10.174.185.104) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Thu, 17 Sep 2020
 11:20:58 +0800
From: Ying Fang <fangying1@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [RFC PATCH 06/12] hw/arm/virt-acpi-build: distinguish possible and
 present cpus
Date: Thu, 17 Sep 2020 11:20:27 +0800
Message-ID: <20200917032033.2020-7-fangying1@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200917032033.2020-1-fangying1@huawei.com>
References: <20200917032033.2020-1-fangying1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.185.104]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191; envelope-from=fangying1@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 23:21:09
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, drjones@redhat.com,
 zhang.zhanghailiang@huawei.com, alex.chen@huawei.com, shannon.zhaosl@gmail.com,
 qemu-arm@nongnu.org, alistair.francis@wdc.com,
 Ying Fang <fangying1@huawei.com>, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When building ACPI tables regarding CPUs we should always build
them for the number of possible CPUs, not the number of present
CPUs. We then ensure only the present CPUs are enabled.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Ying Fang <fangying1@huawei.com>
---
 hw/arm/virt-acpi-build.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 9efd7a3881..f1d574b5d3 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -56,14 +56,18 @@
 
 #define ARM_SPI_BASE 32
 
-static void acpi_dsdt_add_cpus(Aml *scope, int smp_cpus)
+static void acpi_dsdt_add_cpus(Aml *scope, VirtMachineState *vms)
 {
     uint16_t i;
+    CPUArchIdList *possible_cpus = MACHINE(vms)->possible_cpus;
 
-    for (i = 0; i < smp_cpus; i++) {
+    for (i = 0; i < possible_cpus->len; i++) {
         Aml *dev = aml_device("C%.03X", i);
         aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0007")));
         aml_append(dev, aml_name_decl("_UID", aml_int(i)));
+        if (possible_cpus->cpus[i].cpu == NULL) {
+            aml_append(dev, aml_name_decl("_STA", aml_int(0)));
+        }
         aml_append(scope, dev);
     }
 }
@@ -635,6 +639,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     const int *irqmap = vms->irqmap;
     AcpiMadtGenericDistributor *gicd;
     AcpiMadtGenericMsiFrame *gic_msi;
+    int possible_cpus = MACHINE(vms)->possible_cpus->len;
     int i;
 
     acpi_data_push(table_data, sizeof(AcpiMultipleApicTable));
@@ -645,7 +650,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     gicd->base_address = cpu_to_le64(memmap[VIRT_GIC_DIST].base);
     gicd->version = vms->gic_version;
 
-    for (i = 0; i < vms->smp_cpus; i++) {
+    for (i = 0; i < possible_cpus; i++) {
         AcpiMadtGenericCpuInterface *gicc = acpi_data_push(table_data,
                                                            sizeof(*gicc));
         ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(i));
@@ -660,7 +665,9 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         gicc->cpu_interface_number = cpu_to_le32(i);
         gicc->arm_mpidr = cpu_to_le64(armcpu->mp_affinity);
         gicc->uid = cpu_to_le32(i);
-        gicc->flags = cpu_to_le32(ACPI_MADT_GICC_ENABLED);
+        if (i < vms->smp_cpus) {
+            gicc->flags = cpu_to_le32(ACPI_MADT_GICC_ENABLED);
+        }
 
         if (arm_feature(&armcpu->env, ARM_FEATURE_PMU)) {
             gicc->performance_interrupt = cpu_to_le32(PPI(VIRTUAL_PMU_IRQ));
@@ -764,7 +771,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
      * the RTC ACPI device at all when using UEFI.
      */
     scope = aml_scope("\\_SB");
-    acpi_dsdt_add_cpus(scope, vms->smp_cpus);
+    acpi_dsdt_add_cpus(scope, vms);
     acpi_dsdt_add_uart(scope, &memmap[VIRT_UART],
                        (irqmap[VIRT_UART] + ARM_SPI_BASE));
     if (vmc->acpi_expose_flash) {
-- 
2.23.0


