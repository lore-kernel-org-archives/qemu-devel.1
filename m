Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9487CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:55:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9155E205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKubpUJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9155E205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNeWg-0004Z0-ML
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdiy-0007rz-Lr
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdit-0007ib-AW
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:24 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:41162)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iNdir-0007hK-6y
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:17 -0400
Received: by mail-wr1-x42e.google.com with SMTP id p4so26246056wrm.8
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9ccuGquyvu+pMYDj2Caw3rtJDYChmE+/auv7h93x5vY=;
 b=bKubpUJphpZfDjYQFrqDqmixDiAVXh3yW5A9YvnE0TRr5+5CL8w5++Mzi47BfYET4i
 94z3QIpEcsslxqafrTFDJIDUuxQCDE8ewnhH2QiXXyMO3k+127AuEuX/IbrA6xxoPA+D
 6JG1qOBFyRHcqOAETmTk7JyvF50unP6Ed1uP7PEWSIsCGwVvdT8IYuakrRKvCCV682FX
 q59UxQfutUkcIcCPSmyUl+nHB76Db5nNxymfFs1YH81jP/eLMXdC+QauNuqHrLrq0WPN
 u4e6ZDl8zCHhNeYvNctm09bNW7qRrtIbe1fj8D7CNYRPkKwCRAkqTDDyouXOFblt6ofu
 T39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=9ccuGquyvu+pMYDj2Caw3rtJDYChmE+/auv7h93x5vY=;
 b=bBIcqWXbY5s4MJV5IkqfZ4jsJsNmDFR7Dq0N0cAITloWyZOdvkoLuBfyPgKwN59gLc
 XJyWS4gIUMerfyKixX0cE3EWtQxKpTL5k8QYk/QRj7mLTmshW8aBdjfPW0cjFuwyn3ig
 PazCaghF03JPak+0jIlhvzXdyDy8Twr6VgxHh51/ClYafbUjTOytp7kK9cmn5LZXNanv
 dfV2aIgdD0uOKBok5PIOOjArBjxnAUS9jLBkuJrY6G9Ls/6JC9+6hLUKAOdGUVY6zl7K
 rEco4QsZRusf/QFgy7/yWPOcEtigSGCOmGiySAEFmEhU2i+n1Amw8uPq8CiFENrdkuxe
 rDbA==
X-Gm-Message-State: APjAAAWsR3WSD6rtSqymQPLOCSL3QVPH0w4OSQx3fABl21CvvfeqLsve
 fFxmCHDtD/0fjjJc3hSSvR//4RiZ
X-Google-Smtp-Source: APXvYqx5AZGurfO5tD2oOjEF8MuJq3aqgyv5tHwUEI59DrKz+a9P0lpru9ZZw7TV67VG6sO9BR4Ppw==
X-Received: by 2002:a5d:62c5:: with SMTP id o5mr4386152wrv.388.1571925853766; 
 Thu, 24 Oct 2019 07:04:13 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b7sm10610155wrn.53.2019.10.24.07.04.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:04:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/39] hw/i386: split PCMachineState deriving X86MachineState
 from it
Date: Thu, 24 Oct 2019 16:03:30 +0200
Message-Id: <1571925835-31930-15-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
Cc: Sergio Lopez <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Split up PCMachineState and PCMachineClass and derive X86MachineState
and X86MachineClass from them. This allows sharing code with non-PC
x86 machine types.

Signed-off-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/cpu_hotplug.c |  10 +--
 hw/i386/acpi-build.c  |  29 ++++----
 hw/i386/amd_iommu.c   |   3 +-
 hw/i386/intel_iommu.c |   3 +-
 hw/i386/pc.c          | 178 +++++++++++++++++---------------------------------
 hw/i386/pc_piix.c     |  43 ++++++------
 hw/i386/pc_q35.c      |  35 +++++-----
 hw/i386/x86.c         | 140 ++++++++++++++++++++++++++++++++++-----
 hw/i386/xen/xen-hvm.c |  28 ++++----
 hw/intc/ioapic.c      |   2 +-
 include/hw/i386/pc.h  |  27 +-------
 include/hw/i386/x86.h |  58 +++++++++++++++-
 12 files changed, 326 insertions(+), 230 deletions(-)

diff --git a/hw/acpi/cpu_hotplug.c b/hw/acpi/cpu_hotplug.c
index 6e8293a..3ac2045 100644
--- a/hw/acpi/cpu_hotplug.c
+++ b/hw/acpi/cpu_hotplug.c
@@ -128,7 +128,7 @@ void build_legacy_cpu_hotplug_aml(Aml *ctx, MachineState *machine,
     Aml *one = aml_int(1);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(machine);
-    PCMachineState *pcms = PC_MACHINE(machine);
+    X86MachineState *x86ms = X86_MACHINE(machine);
 
     /*
      * _MAT method - creates an madt apic buffer
@@ -236,9 +236,9 @@ void build_legacy_cpu_hotplug_aml(Aml *ctx, MachineState *machine,
     /* The current AML generator can cover the APIC ID range [0..255],
      * inclusive, for VCPU hotplug. */
     QEMU_BUILD_BUG_ON(ACPI_CPU_HOTPLUG_ID_LIMIT > 256);
-    if (pcms->apic_id_limit > ACPI_CPU_HOTPLUG_ID_LIMIT) {
+    if (x86ms->apic_id_limit > ACPI_CPU_HOTPLUG_ID_LIMIT) {
         error_report("max_cpus is too large. APIC ID of last CPU is %u",
-                     pcms->apic_id_limit - 1);
+                     x86ms->apic_id_limit - 1);
         exit(1);
     }
 
@@ -315,8 +315,8 @@ void build_legacy_cpu_hotplug_aml(Aml *ctx, MachineState *machine,
      * ith up to 255 elements. Windows guests up to win2k8 fail when
      * VarPackageOp is used.
      */
-    pkg = pcms->apic_id_limit <= 255 ? aml_package(pcms->apic_id_limit) :
-                                       aml_varpackage(pcms->apic_id_limit);
+    pkg = x86ms->apic_id_limit <= 255 ? aml_package(x86ms->apic_id_limit) :
+                                        aml_varpackage(x86ms->apic_id_limit);
 
     for (i = 0, apic_idx = 0; i < apic_ids->len; i++) {
         int apic_id = apic_ids->cpus[i].arch_id;
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 1d077a7..bc0256e 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -361,6 +361,7 @@ static void
 build_madt(GArray *table_data, BIOSLinker *linker, PCMachineState *pcms)
 {
     MachineClass *mc = MACHINE_GET_CLASS(pcms);
+    X86MachineState *x86ms = X86_MACHINE(pcms);
     const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(MACHINE(pcms));
     int madt_start = table_data->len;
     AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(pcms->acpi_dev);
@@ -390,7 +391,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, PCMachineState *pcms)
     io_apic->address = cpu_to_le32(IO_APIC_DEFAULT_ADDRESS);
     io_apic->interrupt = cpu_to_le32(0);
 
-    if (pcms->apic_xrupt_override) {
+    if (x86ms->apic_xrupt_override) {
         intsrcovr = acpi_data_push(table_data, sizeof *intsrcovr);
         intsrcovr->type   = ACPI_APIC_XRUPT_OVERRIDE;
         intsrcovr->length = sizeof(*intsrcovr);
@@ -1831,6 +1832,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     CrsRangeSet crs_range_set;
     PCMachineState *pcms = PC_MACHINE(machine);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(machine);
+    X86MachineState *x86ms = X86_MACHINE(machine);
     AcpiMcfgInfo mcfg;
     uint32_t nr_mem = machine->ram_slots;
     int root_bus_limit = 0xFF;
@@ -2103,7 +2105,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
          * with half of the 16-bit control register. Hence, the total size
          * of the i/o region used is FW_CFG_CTL_SIZE; when using DMA, the
          * DMA control register is located at FW_CFG_DMA_IO_BASE + 4 */
-        uint8_t io_size = object_property_get_bool(OBJECT(pcms->fw_cfg),
+        uint8_t io_size = object_property_get_bool(OBJECT(x86ms->fw_cfg),
                                                    "dma_enabled", NULL) ?
                           ROUND_UP(FW_CFG_CTL_SIZE, 4) + sizeof(dma_addr_t) :
                           FW_CFG_CTL_SIZE;
@@ -2336,6 +2338,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
     int srat_start, numa_start, slots;
     uint64_t mem_len, mem_base, next_base;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
+    X86MachineState *x86ms = X86_MACHINE(machine);
     const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(machine);
     PCMachineState *pcms = PC_MACHINE(machine);
     ram_addr_t hotplugabble_address_space_size =
@@ -2406,16 +2409,16 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
         }
 
         /* Cut out the ACPI_PCI hole */
-        if (mem_base <= pcms->below_4g_mem_size &&
-            next_base > pcms->below_4g_mem_size) {
-            mem_len -= next_base - pcms->below_4g_mem_size;
+        if (mem_base <= x86ms->below_4g_mem_size &&
+            next_base > x86ms->below_4g_mem_size) {
+            mem_len -= next_base - x86ms->below_4g_mem_size;
             if (mem_len > 0) {
                 numamem = acpi_data_push(table_data, sizeof *numamem);
                 build_srat_memory(numamem, mem_base, mem_len, i - 1,
                                   MEM_AFFINITY_ENABLED);
             }
             mem_base = 1ULL << 32;
-            mem_len = next_base - pcms->below_4g_mem_size;
+            mem_len = next_base - x86ms->below_4g_mem_size;
             next_base = mem_base + mem_len;
         }
 
@@ -2634,6 +2637,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
 {
     PCMachineState *pcms = PC_MACHINE(machine);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    X86MachineState *x86ms = X86_MACHINE(machine);
     GArray *table_offsets;
     unsigned facs, dsdt, rsdt, fadt;
     AcpiPmInfo pm;
@@ -2795,7 +2799,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
          */
         int legacy_aml_len =
             pcmc->legacy_acpi_table_size +
-            ACPI_BUILD_LEGACY_CPU_AML_SIZE * pcms->apic_id_limit;
+            ACPI_BUILD_LEGACY_CPU_AML_SIZE * x86ms->apic_id_limit;
         int legacy_table_size =
             ROUND_UP(tables_blob->len - aml_len + legacy_aml_len,
                      ACPI_BUILD_ALIGN_SIZE);
@@ -2885,13 +2889,14 @@ void acpi_setup(void)
 {
     PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    X86MachineState *x86ms = X86_MACHINE(pcms);
     AcpiBuildTables tables;
     AcpiBuildState *build_state;
     Object *vmgenid_dev;
     TPMIf *tpm;
     static FwCfgTPMConfig tpm_config;
 
-    if (!pcms->fw_cfg) {
+    if (!x86ms->fw_cfg) {
         ACPI_BUILD_DPRINTF("No fw cfg. Bailing out.\n");
         return;
     }
@@ -2922,7 +2927,7 @@ void acpi_setup(void)
         acpi_add_rom_blob(acpi_build_update, build_state,
                           tables.linker->cmd_blob, "etc/table-loader", 0);
 
-    fw_cfg_add_file(pcms->fw_cfg, ACPI_BUILD_TPMLOG_FILE,
+    fw_cfg_add_file(x86ms->fw_cfg, ACPI_BUILD_TPMLOG_FILE,
                     tables.tcpalog->data, acpi_data_len(tables.tcpalog));
 
     tpm = tpm_find();
@@ -2932,13 +2937,13 @@ void acpi_setup(void)
             .tpm_version = tpm_get_version(tpm),
             .tpmppi_version = TPM_PPI_VERSION_1_30
         };
-        fw_cfg_add_file(pcms->fw_cfg, "etc/tpm/config",
+        fw_cfg_add_file(x86ms->fw_cfg, "etc/tpm/config",
                         &tpm_config, sizeof tpm_config);
     }
 
     vmgenid_dev = find_vmgenid_dev();
     if (vmgenid_dev) {
-        vmgenid_add_fw_cfg(VMGENID(vmgenid_dev), pcms->fw_cfg,
+        vmgenid_add_fw_cfg(VMGENID(vmgenid_dev), x86ms->fw_cfg,
                            tables.vmgenid);
     }
 
@@ -2951,7 +2956,7 @@ void acpi_setup(void)
         uint32_t rsdp_size = acpi_data_len(tables.rsdp);
 
         build_state->rsdp = g_memdup(tables.rsdp->data, rsdp_size);
-        fw_cfg_add_file_callback(pcms->fw_cfg, ACPI_BUILD_RSDP_FILE,
+        fw_cfg_add_file_callback(x86ms->fw_cfg, ACPI_BUILD_RSDP_FILE,
                                  acpi_build_update, NULL, build_state,
                                  build_state->rsdp, rsdp_size, true);
         build_state->rsdp_mr = NULL;
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index d372636..d55dbf0 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1540,6 +1540,7 @@ static void amdvi_realize(DeviceState *dev, Error **err)
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(dev);
     MachineState *ms = MACHINE(qdev_get_machine());
     PCMachineState *pcms = PC_MACHINE(ms);
+    X86MachineState *x86ms = X86_MACHINE(ms);
     PCIBus *bus = pcms->bus;
 
     s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
@@ -1568,7 +1569,7 @@ static void amdvi_realize(DeviceState *dev, Error **err)
     }
 
     /* Pseudo address space under root PCI bus. */
-    pcms->ioapic_as = amdvi_host_dma_iommu(bus, s, AMDVI_IOAPIC_SB_DEVID);
+    x86ms->ioapic_as = amdvi_host_dma_iommu(bus, s, AMDVI_IOAPIC_SB_DEVID);
 
     /* set up MMIO */
     memory_region_init_io(&s->mmio, OBJECT(s), &mmio_mem_ops, s, "amdvi-mmio",
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 771bed2..14e4e6a 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3733,6 +3733,7 @@ static void vtd_realize(DeviceState *dev, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
     PCMachineState *pcms = PC_MACHINE(ms);
+    X86MachineState *x86ms = X86_MACHINE(ms);
     PCIBus *bus = pcms->bus;
     IntelIOMMUState *s = INTEL_IOMMU_DEVICE(dev);
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(dev);
@@ -3773,7 +3774,7 @@ static void vtd_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(s), 0, Q35_HOST_BRIDGE_IOMMU_ADDR);
     pci_setup_iommu(bus, vtd_host_dma_iommu, dev);
     /* Pseudo address space under root PCI bus. */
-    pcms->ioapic_as = vtd_host_dma_iommu(bus, s, Q35_PSEUDO_DEVFN_IOAPIC);
+    x86ms->ioapic_as = vtd_host_dma_iommu(bus, s, Q35_PSEUDO_DEVFN_IOAPIC);
     qemu_add_machine_init_done_notifier(&vtd_machine_done_notify);
 }
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 4a1bc95..e6ad1f1 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -79,7 +79,6 @@
 #include "qapi/qapi-visit-common.h"
 #include "qapi/visitor.h"
 #include "hw/core/cpu.h"
-#include "hw/nmi.h"
 #include "hw/usb.h"
 #include "hw/i386/intel_iommu.h"
 #include "hw/net/ne2000-isa.h"
@@ -680,17 +679,18 @@ void pc_cmos_init(PCMachineState *pcms,
 {
     int val;
     static pc_cmos_init_late_arg arg;
+    X86MachineState *x86ms = X86_MACHINE(pcms);
 
     /* various important CMOS locations needed by PC/Bochs bios */
 
     /* memory size */
     /* base memory (first MiB) */
-    val = MIN(pcms->below_4g_mem_size / KiB, 640);
+    val = MIN(x86ms->below_4g_mem_size / KiB, 640);
     rtc_set_memory(s, 0x15, val);
     rtc_set_memory(s, 0x16, val >> 8);
     /* extended memory (next 64MiB) */
-    if (pcms->below_4g_mem_size > 1 * MiB) {
-        val = (pcms->below_4g_mem_size - 1 * MiB) / KiB;
+    if (x86ms->below_4g_mem_size > 1 * MiB) {
+        val = (x86ms->below_4g_mem_size - 1 * MiB) / KiB;
     } else {
         val = 0;
     }
@@ -701,8 +701,8 @@ void pc_cmos_init(PCMachineState *pcms,
     rtc_set_memory(s, 0x30, val);
     rtc_set_memory(s, 0x31, val >> 8);
     /* memory between 16MiB and 4GiB */
-    if (pcms->below_4g_mem_size > 16 * MiB) {
-        val = (pcms->below_4g_mem_size - 16 * MiB) / (64 * KiB);
+    if (x86ms->below_4g_mem_size > 16 * MiB) {
+        val = (x86ms->below_4g_mem_size - 16 * MiB) / (64 * KiB);
     } else {
         val = 0;
     }
@@ -711,14 +711,14 @@ void pc_cmos_init(PCMachineState *pcms,
     rtc_set_memory(s, 0x34, val);
     rtc_set_memory(s, 0x35, val >> 8);
     /* memory above 4GiB */
-    val = pcms->above_4g_mem_size / 65536;
+    val = x86ms->above_4g_mem_size / 65536;
     rtc_set_memory(s, 0x5b, val);
     rtc_set_memory(s, 0x5c, val >> 8);
     rtc_set_memory(s, 0x5d, val >> 16);
 
     object_property_add_link(OBJECT(pcms), "rtc_state",
                              TYPE_ISA_DEVICE,
-                             (Object **)&pcms->rtc,
+                             (Object **)&x86ms->rtc,
                              object_property_allow_set_link,
                              OBJ_PROP_LINK_STRONG, &error_abort);
     object_property_set_link(OBJECT(pcms), OBJECT(s),
@@ -907,7 +907,7 @@ void pc_acpi_smi_interrupt(void *opaque, int irq, int level)
  */
 void pc_smp_parse(MachineState *ms, QemuOpts *opts)
 {
-    PCMachineState *pcms = PC_MACHINE(ms);
+    X86MachineState *x86ms = X86_MACHINE(ms);
 
     if (opts) {
         unsigned cpus    = qemu_opt_get_number(opts, "cpus", 0);
@@ -971,7 +971,7 @@ void pc_smp_parse(MachineState *ms, QemuOpts *opts)
         ms->smp.cpus = cpus;
         ms->smp.cores = cores;
         ms->smp.threads = threads;
-        pcms->smp_dies = dies;
+        x86ms->smp_dies = dies;
     }
 
     if (ms->smp.cpus > 1) {
@@ -1024,10 +1024,11 @@ void pc_machine_done(Notifier *notifier, void *data)
 {
     PCMachineState *pcms = container_of(notifier,
                                         PCMachineState, machine_done);
+    X86MachineState *x86ms = X86_MACHINE(pcms);
     PCIBus *bus = pcms->bus;
 
     /* set the number of CPUs */
-    rtc_set_cpus_count(pcms->rtc, pcms->boot_cpus);
+    rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
 
     if (bus) {
         int extra_hosts = 0;
@@ -1038,23 +1039,23 @@ void pc_machine_done(Notifier *notifier, void *data)
                 extra_hosts++;
             }
         }
-        if (extra_hosts && pcms->fw_cfg) {
+        if (extra_hosts && x86ms->fw_cfg) {
             uint64_t *val = g_malloc(sizeof(*val));
             *val = cpu_to_le64(extra_hosts);
-            fw_cfg_add_file(pcms->fw_cfg,
+            fw_cfg_add_file(x86ms->fw_cfg,
                     "etc/extra-pci-roots", val, sizeof(*val));
         }
     }
 
     acpi_setup();
-    if (pcms->fw_cfg) {
-        fw_cfg_build_smbios(MACHINE(pcms), pcms->fw_cfg);
-        fw_cfg_build_feature_control(MACHINE(pcms), pcms->fw_cfg);
+    if (x86ms->fw_cfg) {
+        fw_cfg_build_smbios(MACHINE(pcms), x86ms->fw_cfg);
+        fw_cfg_build_feature_control(MACHINE(pcms), x86ms->fw_cfg);
         /* update FW_CFG_NB_CPUS to account for -device added CPUs */
-        fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
+        fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
     }
 
-    if (pcms->apic_id_limit > 255 && !xen_enabled()) {
+    if (x86ms->apic_id_limit > 255 && !xen_enabled()) {
         IntelIOMMUState *iommu = INTEL_IOMMU_DEVICE(x86_iommu_get_default());
 
         if (!iommu || !x86_iommu_ir_supported(X86_IOMMU_DEVICE(iommu)) ||
@@ -1072,8 +1073,9 @@ void pc_guest_info_init(PCMachineState *pcms)
 {
     int i;
     MachineState *ms = MACHINE(pcms);
+    X86MachineState *x86ms = X86_MACHINE(pcms);
 
-    pcms->apic_xrupt_override = kvm_allows_irq0_override();
+    x86ms->apic_xrupt_override = kvm_allows_irq0_override();
     pcms->numa_nodes = ms->numa_state->num_nodes;
     pcms->node_mem = g_malloc0(pcms->numa_nodes *
                                     sizeof *pcms->node_mem);
@@ -1098,11 +1100,12 @@ void xen_load_linux(PCMachineState *pcms)
 {
     int i;
     FWCfgState *fw_cfg;
+    X86MachineState *x86ms = X86_MACHINE(pcms);
 
     assert(MACHINE(pcms)->kernel_filename != NULL);
 
     fw_cfg = fw_cfg_init_io(FW_CFG_IO_BASE);
-    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
     rom_set_fw(fw_cfg);
 
     x86_load_linux(pcms, fw_cfg);
@@ -1113,7 +1116,7 @@ void xen_load_linux(PCMachineState *pcms)
                !strcmp(option_rom[i].name, "multiboot.bin"));
         rom_add_option(option_rom[i].name, option_rom[i].bootindex);
     }
-    pcms->fw_cfg = fw_cfg;
+    x86ms->fw_cfg = fw_cfg;
 }
 
 void pc_memory_init(PCMachineState *pcms,
@@ -1128,9 +1131,10 @@ void pc_memory_init(PCMachineState *pcms,
     MachineState *machine = MACHINE(pcms);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    X86MachineState *x86ms = X86_MACHINE(pcms);
 
-    assert(machine->ram_size == pcms->below_4g_mem_size +
-                                pcms->above_4g_mem_size);
+    assert(machine->ram_size == x86ms->below_4g_mem_size +
+                                x86ms->above_4g_mem_size);
 
     linux_boot = (machine->kernel_filename != NULL);
 
@@ -1144,17 +1148,17 @@ void pc_memory_init(PCMachineState *pcms,
     *ram_memory = ram;
     ram_below_4g = g_malloc(sizeof(*ram_below_4g));
     memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g", ram,
-                             0, pcms->below_4g_mem_size);
+                             0, x86ms->below_4g_mem_size);
     memory_region_add_subregion(system_memory, 0, ram_below_4g);
-    e820_add_entry(0, pcms->below_4g_mem_size, E820_RAM);
-    if (pcms->above_4g_mem_size > 0) {
+    e820_add_entry(0, x86ms->below_4g_mem_size, E820_RAM);
+    if (x86ms->above_4g_mem_size > 0) {
         ram_above_4g = g_malloc(sizeof(*ram_above_4g));
         memory_region_init_alias(ram_above_4g, NULL, "ram-above-4g", ram,
-                                 pcms->below_4g_mem_size,
-                                 pcms->above_4g_mem_size);
+                                 x86ms->below_4g_mem_size,
+                                 x86ms->above_4g_mem_size);
         memory_region_add_subregion(system_memory, 0x100000000ULL,
                                     ram_above_4g);
-        e820_add_entry(0x100000000ULL, pcms->above_4g_mem_size, E820_RAM);
+        e820_add_entry(0x100000000ULL, x86ms->above_4g_mem_size, E820_RAM);
     }
 
     if (!pcmc->has_reserved_memory &&
@@ -1188,7 +1192,7 @@ void pc_memory_init(PCMachineState *pcms,
         }
 
         machine->device_memory->base =
-            ROUND_UP(0x100000000ULL + pcms->above_4g_mem_size, 1 * GiB);
+            ROUND_UP(0x100000000ULL + x86ms->above_4g_mem_size, 1 * GiB);
 
         if (pcmc->enforce_aligned_dimm) {
             /* size device region assuming 1G page max alignment per slot */
@@ -1223,7 +1227,7 @@ void pc_memory_init(PCMachineState *pcms,
                                         1);
 
     fw_cfg = fw_cfg_arch_create(machine,
-                                pcms->boot_cpus, pcms->apic_id_limit);
+                                x86ms->boot_cpus, x86ms->apic_id_limit);
 
     rom_set_fw(fw_cfg);
 
@@ -1246,10 +1250,10 @@ void pc_memory_init(PCMachineState *pcms,
     for (i = 0; i < nb_option_roms; i++) {
         rom_add_option(option_rom[i].name, option_rom[i].bootindex);
     }
-    pcms->fw_cfg = fw_cfg;
+    x86ms->fw_cfg = fw_cfg;
 
     /* Init default IOAPIC address space */
-    pcms->ioapic_as = &address_space_memory;
+    x86ms->ioapic_as = &address_space_memory;
 
     /* Init ACPI memory hotplug IO base address */
     pcms->memhp_io_base = ACPI_MEMORY_HOTPLUG_BASE;
@@ -1264,6 +1268,7 @@ uint64_t pc_pci_hole64_start(void)
     PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     MachineState *ms = MACHINE(pcms);
+    X86MachineState *x86ms = X86_MACHINE(pcms);
     uint64_t hole64_start = 0;
 
     if (pcmc->has_reserved_memory && ms->device_memory->base) {
@@ -1272,7 +1277,7 @@ uint64_t pc_pci_hole64_start(void)
             hole64_start += memory_region_size(&ms->device_memory->mr);
         }
     } else {
-        hole64_start = 0x100000000ULL + pcms->above_4g_mem_size;
+        hole64_start = 0x100000000ULL + x86ms->above_4g_mem_size;
     }
 
     return ROUND_UP(hole64_start, 1 * GiB);
@@ -1611,6 +1616,7 @@ static void pc_cpu_plug(HotplugHandler *hotplug_dev,
     Error *local_err = NULL;
     X86CPU *cpu = X86_CPU(dev);
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
+    X86MachineState *x86ms = X86_MACHINE(pcms);
 
     if (pcms->acpi_dev) {
         hotplug_handler_plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_err);
@@ -1620,12 +1626,12 @@ static void pc_cpu_plug(HotplugHandler *hotplug_dev,
     }
 
     /* increment the number of CPUs */
-    pcms->boot_cpus++;
-    if (pcms->rtc) {
-        rtc_set_cpus_count(pcms->rtc, pcms->boot_cpus);
+    x86ms->boot_cpus++;
+    if (x86ms->rtc) {
+        rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
     }
-    if (pcms->fw_cfg) {
-        fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
+    if (x86ms->fw_cfg) {
+        fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
     }
 
     found_cpu = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, NULL);
@@ -1671,6 +1677,7 @@ static void pc_cpu_unplug_cb(HotplugHandler *hotplug_dev,
     Error *local_err = NULL;
     X86CPU *cpu = X86_CPU(dev);
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
+    X86MachineState *x86ms = X86_MACHINE(pcms);
 
     hotplug_handler_unplug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_err);
     if (local_err) {
@@ -1682,10 +1689,10 @@ static void pc_cpu_unplug_cb(HotplugHandler *hotplug_dev,
     object_property_set_bool(OBJECT(dev), false, "realized", NULL);
 
     /* decrement the number of CPUs */
-    pcms->boot_cpus--;
+    x86ms->boot_cpus--;
     /* Update the number of CPUs in CMOS */
-    rtc_set_cpus_count(pcms->rtc, pcms->boot_cpus);
-    fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
+    rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
+    fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
  out:
     error_propagate(errp, local_err);
 }
@@ -1701,6 +1708,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     CPUX86State *env = &cpu->env;
     MachineState *ms = MACHINE(hotplug_dev);
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
+    X86MachineState *x86ms = X86_MACHINE(pcms);
     unsigned int smp_cores = ms->smp.cores;
     unsigned int smp_threads = ms->smp.threads;
 
@@ -1710,7 +1718,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
         return;
     }
 
-    env->nr_dies = pcms->smp_dies;
+    env->nr_dies = x86ms->smp_dies;
 
     /*
      * If APIC ID is not set,
@@ -1718,13 +1726,13 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
      */
     if (cpu->apic_id == UNASSIGNED_APIC_ID) {
         int max_socket = (ms->smp.max_cpus - 1) /
-                                smp_threads / smp_cores / pcms->smp_dies;
+                                smp_threads / smp_cores / x86ms->smp_dies;
 
         /*
          * die-id was optional in QEMU 4.0 and older, so keep it optional
          * if there's only one die per socket.
          */
-        if (cpu->die_id < 0 && pcms->smp_dies == 1) {
+        if (cpu->die_id < 0 && x86ms->smp_dies == 1) {
             cpu->die_id = 0;
         }
 
@@ -1739,9 +1747,9 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
         if (cpu->die_id < 0) {
             error_setg(errp, "CPU die-id is not set");
             return;
-        } else if (cpu->die_id > pcms->smp_dies - 1) {
+        } else if (cpu->die_id > x86ms->smp_dies - 1) {
             error_setg(errp, "Invalid CPU die-id: %u must be in range 0:%u",
-                       cpu->die_id, pcms->smp_dies - 1);
+                       cpu->die_id, x86ms->smp_dies - 1);
             return;
         }
         if (cpu->core_id < 0) {
@@ -1765,7 +1773,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
         topo.die_id = cpu->die_id;
         topo.core_id = cpu->core_id;
         topo.smt_id = cpu->thread_id;
-        cpu->apic_id = apicid_from_topo_ids(pcms->smp_dies, smp_cores,
+        cpu->apic_id = apicid_from_topo_ids(x86ms->smp_dies, smp_cores,
                                             smp_threads, &topo);
     }
 
@@ -1773,7 +1781,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     if (!cpu_slot) {
         MachineState *ms = MACHINE(pcms);
 
-        x86_topo_ids_from_apicid(cpu->apic_id, pcms->smp_dies,
+        x86_topo_ids_from_apicid(cpu->apic_id, x86ms->smp_dies,
                                  smp_cores, smp_threads, &topo);
         error_setg(errp,
             "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
@@ -1795,7 +1803,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     /* TODO: move socket_id/core_id/thread_id checks into x86_cpu_realizefn()
      * once -smp refactoring is complete and there will be CPU private
      * CPUState::nr_cores and CPUState::nr_threads fields instead of globals */
-    x86_topo_ids_from_apicid(cpu->apic_id, pcms->smp_dies,
+    x86_topo_ids_from_apicid(cpu->apic_id, x86ms->smp_dies,
                              smp_cores, smp_threads, &topo);
     if (cpu->socket_id != -1 && cpu->socket_id != topo.pkg_id) {
         error_setg(errp, "property socket-id: %u doesn't match set apic-id:"
@@ -1977,45 +1985,6 @@ pc_machine_get_device_memory_region_size(Object *obj, Visitor *v,
     visit_type_int(v, name, &value, errp);
 }
 
-static void pc_machine_get_max_ram_below_4g(Object *obj, Visitor *v,
-                                            const char *name, void *opaque,
-                                            Error **errp)
-{
-    PCMachineState *pcms = PC_MACHINE(obj);
-    uint64_t value = pcms->max_ram_below_4g;
-
-    visit_type_size(v, name, &value, errp);
-}
-
-static void pc_machine_set_max_ram_below_4g(Object *obj, Visitor *v,
-                                            const char *name, void *opaque,
-                                            Error **errp)
-{
-    PCMachineState *pcms = PC_MACHINE(obj);
-    Error *error = NULL;
-    uint64_t value;
-
-    visit_type_size(v, name, &value, &error);
-    if (error) {
-        error_propagate(errp, error);
-        return;
-    }
-    if (value > 4 * GiB) {
-        error_setg(&error,
-                   "Machine option 'max-ram-below-4g=%"PRIu64
-                   "' expects size less than or equal to 4G", value);
-        error_propagate(errp, error);
-        return;
-    }
-
-    if (value < 1 * MiB) {
-        warn_report("Only %" PRIu64 " bytes of RAM below the 4GiB boundary,"
-                    "BIOS may not work with less than 1MiB", value);
-    }
-
-    pcms->max_ram_below_4g = value;
-}
-
 static void pc_machine_get_vmport(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
 {
@@ -2121,7 +2090,6 @@ static void pc_machine_initfn(Object *obj)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
 
-    pcms->max_ram_below_4g = 0; /* use default */
     pcms->smm = ON_OFF_AUTO_AUTO;
 #ifdef CONFIG_VMPORT
     pcms->vmport = ON_OFF_AUTO_AUTO;
@@ -2133,7 +2101,6 @@ static void pc_machine_initfn(Object *obj)
     pcms->smbus_enabled = true;
     pcms->sata_enabled = true;
     pcms->pit_enabled = true;
-    pcms->smp_dies = 1;
 
     pc_system_flash_create(pcms);
 }
@@ -2164,23 +2131,6 @@ static void pc_machine_wakeup(MachineState *machine)
     cpu_synchronize_all_post_reset();
 }
 
-static void x86_nmi(NMIState *n, int cpu_index, Error **errp)
-{
-    /* cpu index isn't used */
-    CPUState *cs;
-
-    CPU_FOREACH(cs) {
-        X86CPU *cpu = X86_CPU(cs);
-
-        if (!cpu->apic_state) {
-            cpu_interrupt(cs, CPU_INTERRUPT_NMI);
-        } else {
-            apic_deliver_nmi(cpu->apic_state);
-        }
-    }
-}
-
-
 static bool pc_hotplug_allowed(MachineState *ms, DeviceState *dev, Error **errp)
 {
     X86IOMMUState *iommu = x86_iommu_get_default();
@@ -2205,7 +2155,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     PCMachineClass *pcmc = PC_MACHINE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
-    NMIClass *nc = NMI_CLASS(oc);
 
     pcmc->pci_enabled = true;
     pcmc->has_acpi_build = true;
@@ -2241,7 +2190,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     hc->plug = pc_machine_device_plug_cb;
     hc->unplug_request = pc_machine_device_unplug_request_cb;
     hc->unplug = pc_machine_device_unplug_cb;
-    nc->nmi_monitor_handler = x86_nmi;
     mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
     mc->nvdimm_supported = true;
     mc->numa_mem_supported = true;
@@ -2250,13 +2198,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
         pc_machine_get_device_memory_region_size, NULL,
         NULL, NULL, &error_abort);
 
-    object_class_property_add(oc, PC_MACHINE_MAX_RAM_BELOW_4G, "size",
-        pc_machine_get_max_ram_below_4g, pc_machine_set_max_ram_below_4g,
-        NULL, NULL, &error_abort);
-
-    object_class_property_set_description(oc, PC_MACHINE_MAX_RAM_BELOW_4G,
-        "Maximum ram below the 4G boundary (32bit boundary)", &error_abort);
-
     object_class_property_add(oc, PC_MACHINE_SMM, "OnOffAuto",
         pc_machine_get_smm, pc_machine_set_smm,
         NULL, NULL, &error_abort);
@@ -2281,7 +2222,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
 
 static const TypeInfo pc_machine_info = {
     .name = TYPE_PC_MACHINE,
-    .parent = TYPE_MACHINE,
+    .parent = TYPE_X86_MACHINE,
     .abstract = true,
     .instance_size = sizeof(PCMachineState),
     .instance_init = pc_machine_initfn,
@@ -2289,7 +2230,6 @@ static const TypeInfo pc_machine_info = {
     .class_init = pc_machine_class_init,
     .interfaces = (InterfaceInfo[]) {
          { TYPE_HOTPLUG_HANDLER },
-         { TYPE_NMI },
          { }
     },
 };
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 1396451..0afa8fe 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -74,6 +74,7 @@ static void pc_init1(MachineState *machine,
 {
     PCMachineState *pcms = PC_MACHINE(machine);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    X86MachineState *x86ms = X86_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
     int i;
@@ -126,11 +127,11 @@ static void pc_init1(MachineState *machine,
     if (xen_enabled()) {
         xen_hvm_init(pcms, &ram_memory);
     } else {
-        if (!pcms->max_ram_below_4g) {
-            pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
+        if (!x86ms->max_ram_below_4g) {
+            x86ms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
         }
-        lowmem = pcms->max_ram_below_4g;
-        if (machine->ram_size >= pcms->max_ram_below_4g) {
+        lowmem = x86ms->max_ram_below_4g;
+        if (machine->ram_size >= x86ms->max_ram_below_4g) {
             if (pcmc->gigabyte_align) {
                 if (lowmem > 0xc0000000) {
                     lowmem = 0xc0000000;
@@ -139,17 +140,17 @@ static void pc_init1(MachineState *machine,
                     warn_report("Large machine and max_ram_below_4g "
                                 "(%" PRIu64 ") not a multiple of 1G; "
                                 "possible bad performance.",
-                                pcms->max_ram_below_4g);
+                                x86ms->max_ram_below_4g);
                 }
             }
         }
 
         if (machine->ram_size >= lowmem) {
-            pcms->above_4g_mem_size = machine->ram_size - lowmem;
-            pcms->below_4g_mem_size = lowmem;
+            x86ms->above_4g_mem_size = machine->ram_size - lowmem;
+            x86ms->below_4g_mem_size = lowmem;
         } else {
-            pcms->above_4g_mem_size = 0;
-            pcms->below_4g_mem_size = machine->ram_size;
+            x86ms->above_4g_mem_size = 0;
+            x86ms->below_4g_mem_size = machine->ram_size;
         }
     }
 
@@ -191,19 +192,19 @@ static void pc_init1(MachineState *machine,
     gsi_state = g_malloc0(sizeof(*gsi_state));
     if (kvm_ioapic_in_kernel()) {
         kvm_pc_setup_irq_routing(pcmc->pci_enabled);
-        pcms->gsi = qemu_allocate_irqs(kvm_pc_gsi_handler, gsi_state,
+        x86ms->gsi = qemu_allocate_irqs(kvm_pc_gsi_handler, gsi_state,
                                        GSI_NUM_PINS);
     } else {
-        pcms->gsi = qemu_allocate_irqs(gsi_handler, gsi_state, GSI_NUM_PINS);
+        x86ms->gsi = qemu_allocate_irqs(gsi_handler, gsi_state, GSI_NUM_PINS);
     }
 
     if (pcmc->pci_enabled) {
         pci_bus = i440fx_init(host_type,
                               pci_type,
-                              &i440fx_state, &piix3_devfn, &isa_bus, pcms->gsi,
+                              &i440fx_state, &piix3_devfn, &isa_bus, x86ms->gsi,
                               system_memory, system_io, machine->ram_size,
-                              pcms->below_4g_mem_size,
-                              pcms->above_4g_mem_size,
+                              x86ms->below_4g_mem_size,
+                              x86ms->above_4g_mem_size,
                               pci_memory, ram_memory);
         pcms->bus = pci_bus;
     } else {
@@ -213,7 +214,7 @@ static void pc_init1(MachineState *machine,
                               &error_abort);
         no_hpet = 1;
     }
-    isa_bus_irqs(isa_bus, pcms->gsi);
+    isa_bus_irqs(isa_bus, x86ms->gsi);
 
     if (kvm_pic_in_kernel()) {
         i8259 = kvm_i8259_init(isa_bus);
@@ -231,7 +232,7 @@ static void pc_init1(MachineState *machine,
         ioapic_init_gsi(gsi_state, "i440fx");
     }
 
-    pc_register_ferr_irq(pcms->gsi[13]);
+    pc_register_ferr_irq(x86ms->gsi[13]);
 
     pc_vga_init(isa_bus, pcmc->pci_enabled ? pci_bus : NULL);
 
@@ -241,7 +242,7 @@ static void pc_init1(MachineState *machine,
     }
 
     /* init basic PC hardware */
-    pc_basic_device_init(isa_bus, pcms->gsi, &rtc_state, true,
+    pc_basic_device_init(isa_bus, x86ms->gsi, &rtc_state, true,
                          (pcms->vmport != ON_OFF_AUTO_ON), pcms->pit_enabled,
                          0x4);
 
@@ -288,7 +289,7 @@ else {
         smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
         /* TODO: Populate SPD eeprom data.  */
         pcms->smbus = piix4_pm_init(pci_bus, piix3_devfn + 3, 0xb100,
-                                    pcms->gsi[9], smi_irq,
+                                    x86ms->gsi[9], smi_irq,
                                     pc_machine_is_smm_enabled(pcms),
                                     &piix4_pm);
         smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
@@ -304,7 +305,7 @@ else {
 
     if (machine->nvdimms_state->is_enabled) {
         nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
-                               pcms->fw_cfg, OBJECT(pcms));
+                               x86ms->fw_cfg, OBJECT(pcms));
     }
 }
 
@@ -729,7 +730,7 @@ DEFINE_I440FX_MACHINE(v1_4, "pc-i440fx-1.4", pc_compat_1_4_fn,
 
 static void pc_i440fx_1_3_machine_options(MachineClass *m)
 {
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+    X86MachineClass *x86mc = X86_MACHINE_CLASS(m);
     static GlobalProperty compat[] = {
         PC_CPU_MODEL_IDS("1.3.0")
         { "usb-tablet", "usb_version", "1" },
@@ -740,7 +741,7 @@ static void pc_i440fx_1_3_machine_options(MachineClass *m)
 
     pc_i440fx_1_4_machine_options(m);
     m->hw_version = "1.3.0";
-    pcmc->compat_apic_id_mode = true;
+    x86mc->compat_apic_id_mode = true;
     compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
 }
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 8920bd8..374ac6c 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -116,6 +116,7 @@ static void pc_q35_init(MachineState *machine)
 {
     PCMachineState *pcms = PC_MACHINE(machine);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    X86MachineState *x86ms = X86_MACHINE(machine);
     Q35PCIHost *q35_host;
     PCIHostState *phb;
     PCIBus *host_bus;
@@ -153,27 +154,27 @@ static void pc_q35_init(MachineState *machine)
     /* Handle the machine opt max-ram-below-4g.  It is basically doing
      * min(qemu limit, user limit).
      */
-    if (!pcms->max_ram_below_4g) {
-        pcms->max_ram_below_4g = 1ULL << 32; /* default: 4G */;
+    if (!x86ms->max_ram_below_4g) {
+        x86ms->max_ram_below_4g = 4 * GiB;
     }
-    if (lowmem > pcms->max_ram_below_4g) {
-        lowmem = pcms->max_ram_below_4g;
+    if (lowmem > x86ms->max_ram_below_4g) {
+        lowmem = x86ms->max_ram_below_4g;
         if (machine->ram_size - lowmem > lowmem &&
             lowmem & (1 * GiB - 1)) {
             warn_report("There is possibly poor performance as the ram size "
                         " (0x%" PRIx64 ") is more then twice the size of"
                         " max-ram-below-4g (%"PRIu64") and"
                         " max-ram-below-4g is not a multiple of 1G.",
-                        (uint64_t)machine->ram_size, pcms->max_ram_below_4g);
+                        (uint64_t)machine->ram_size, x86ms->max_ram_below_4g);
         }
     }
 
     if (machine->ram_size >= lowmem) {
-        pcms->above_4g_mem_size = machine->ram_size - lowmem;
-        pcms->below_4g_mem_size = lowmem;
+        x86ms->above_4g_mem_size = machine->ram_size - lowmem;
+        x86ms->below_4g_mem_size = lowmem;
     } else {
-        pcms->above_4g_mem_size = 0;
-        pcms->below_4g_mem_size = machine->ram_size;
+        x86ms->above_4g_mem_size = 0;
+        x86ms->below_4g_mem_size = machine->ram_size;
     }
 
     if (xen_enabled()) {
@@ -214,10 +215,10 @@ static void pc_q35_init(MachineState *machine)
     gsi_state = g_malloc0(sizeof(*gsi_state));
     if (kvm_ioapic_in_kernel()) {
         kvm_pc_setup_irq_routing(pcmc->pci_enabled);
-        pcms->gsi = qemu_allocate_irqs(kvm_pc_gsi_handler, gsi_state,
+        x86ms->gsi = qemu_allocate_irqs(kvm_pc_gsi_handler, gsi_state,
                                        GSI_NUM_PINS);
     } else {
-        pcms->gsi = qemu_allocate_irqs(gsi_handler, gsi_state, GSI_NUM_PINS);
+        x86ms->gsi = qemu_allocate_irqs(gsi_handler, gsi_state, GSI_NUM_PINS);
     }
 
     /* create pci host bus */
@@ -232,9 +233,9 @@ static void pc_q35_init(MachineState *machine)
                              MCH_HOST_PROP_SYSTEM_MEM, NULL);
     object_property_set_link(OBJECT(q35_host), OBJECT(system_io),
                              MCH_HOST_PROP_IO_MEM, NULL);
-    object_property_set_int(OBJECT(q35_host), pcms->below_4g_mem_size,
+    object_property_set_int(OBJECT(q35_host), x86ms->below_4g_mem_size,
                             PCI_HOST_BELOW_4G_MEM_SIZE, NULL);
-    object_property_set_int(OBJECT(q35_host), pcms->above_4g_mem_size,
+    object_property_set_int(OBJECT(q35_host), x86ms->above_4g_mem_size,
                             PCI_HOST_ABOVE_4G_MEM_SIZE, NULL);
     /* pci */
     qdev_init_nofail(DEVICE(q35_host));
@@ -256,7 +257,7 @@ static void pc_q35_init(MachineState *machine)
     ich9_lpc = ICH9_LPC_DEVICE(lpc);
     lpc_dev = DEVICE(lpc);
     for (i = 0; i < GSI_NUM_PINS; i++) {
-        qdev_connect_gpio_out_named(lpc_dev, ICH9_GPIO_GSI, i, pcms->gsi[i]);
+        qdev_connect_gpio_out_named(lpc_dev, ICH9_GPIO_GSI, i, x86ms->gsi[i]);
     }
     pci_bus_irqs(host_bus, ich9_lpc_set_irq, ich9_lpc_map_irq, ich9_lpc,
                  ICH9_LPC_NB_PIRQS);
@@ -280,7 +281,7 @@ static void pc_q35_init(MachineState *machine)
         ioapic_init_gsi(gsi_state, "q35");
     }
 
-    pc_register_ferr_irq(pcms->gsi[13]);
+    pc_register_ferr_irq(x86ms->gsi[13]);
 
     assert(pcms->vmport != ON_OFF_AUTO__MAX);
     if (pcms->vmport == ON_OFF_AUTO_AUTO) {
@@ -288,7 +289,7 @@ static void pc_q35_init(MachineState *machine)
     }
 
     /* init basic PC hardware */
-    pc_basic_device_init(isa_bus, pcms->gsi, &rtc_state, !mc->no_floppy,
+    pc_basic_device_init(isa_bus, x86ms->gsi, &rtc_state, !mc->no_floppy,
                          (pcms->vmport != ON_OFF_AUTO_ON), pcms->pit_enabled,
                          0xff0104);
 
@@ -331,7 +332,7 @@ static void pc_q35_init(MachineState *machine)
 
     if (machine->nvdimms_state->is_enabled) {
         nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
-                               pcms->fw_cfg, OBJECT(pcms));
+                               x86ms->fw_cfg, OBJECT(pcms));
     }
 }
 
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 71fb093..de4fed0 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -65,13 +65,14 @@ uint32_t x86_cpu_apic_id_from_index(PCMachineState *pcms,
                                     unsigned int cpu_index)
 {
     MachineState *ms = MACHINE(pcms);
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    X86MachineState *x86ms = X86_MACHINE(pcms);
+    X86MachineClass *x86mc = X86_MACHINE_GET_CLASS(x86ms);
     uint32_t correct_id;
     static bool warned;
 
-    correct_id = x86_apicid_from_cpu_idx(pcms->smp_dies, ms->smp.cores,
+    correct_id = x86_apicid_from_cpu_idx(x86ms->smp_dies, ms->smp.cores,
                                          ms->smp.threads, cpu_index);
-    if (pcmc->compat_apic_id_mode) {
+    if (x86mc->compat_apic_id_mode) {
         if (cpu_index != correct_id && !warned && !qtest_enabled()) {
             error_report("APIC IDs set in compatibility mode, "
                          "CPU topology won't match the configuration");
@@ -88,11 +89,12 @@ void x86_cpu_new(PCMachineState *pcms, int64_t apic_id, Error **errp)
     Object *cpu = NULL;
     Error *local_err = NULL;
     CPUX86State *env = NULL;
+    X86MachineState *x86ms = X86_MACHINE(pcms);
 
     cpu = object_new(MACHINE(pcms)->cpu_type);
 
     env = &X86_CPU(cpu)->env;
-    env->nr_dies = pcms->smp_dies;
+    env->nr_dies = x86ms->smp_dies;
 
     object_property_set_uint(cpu, apic_id, "apic-id", &local_err);
     object_property_set_bool(cpu, true, "realized", &local_err);
@@ -108,6 +110,7 @@ void x86_cpus_init(PCMachineState *pcms)
     MachineState *ms = MACHINE(pcms);
     MachineClass *mc = MACHINE_GET_CLASS(pcms);
     PCMachineClass *pcmc = PC_MACHINE_CLASS(mc);
+    X86MachineState *x86ms = X86_MACHINE(pcms);
 
     x86_cpu_set_default_version(pcmc->default_cpu_version);
 
@@ -119,8 +122,8 @@ void x86_cpus_init(PCMachineState *pcms)
      *
      * This is used for FW_CFG_MAX_CPUS. See comments on fw_cfg_arch_create().
      */
-    pcms->apic_id_limit = x86_cpu_apic_id_from_index(pcms,
-                                                     ms->smp.max_cpus - 1) + 1;
+    x86ms->apic_id_limit = x86_cpu_apic_id_from_index(pcms,
+                                                      ms->smp.max_cpus - 1) + 1;
     possible_cpus = mc->possible_cpu_arch_ids(ms);
     for (i = 0; i < ms->smp.cpus; i++) {
         x86_cpu_new(pcms, possible_cpus->cpus[i].arch_id, &error_fatal);
@@ -140,11 +143,11 @@ x86_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
 int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
 {
    X86CPUTopoInfo topo;
-   PCMachineState *pcms = PC_MACHINE(ms);
+   X86MachineState *x86ms = X86_MACHINE(ms);
 
    assert(idx < ms->possible_cpus->len);
    x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
-                            pcms->smp_dies, ms->smp.cores,
+                            x86ms->smp_dies, ms->smp.cores,
                             ms->smp.threads, &topo);
    return topo.pkg_id % ms->numa_state->num_nodes;
 }
@@ -152,6 +155,7 @@ int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
 const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
 {
     PCMachineState *pcms = PC_MACHINE(ms);
+    X86MachineState *x86ms = X86_MACHINE(ms);
     int i;
     unsigned int max_cpus = ms->smp.max_cpus;
 
@@ -175,11 +179,11 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
         ms->possible_cpus->cpus[i].arch_id =
             x86_cpu_apic_id_from_index(pcms, i);
         x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
-                                 pcms->smp_dies, ms->smp.cores,
+                                 x86ms->smp_dies, ms->smp.cores,
                                  ms->smp.threads, &topo);
         ms->possible_cpus->cpus[i].props.has_socket_id = true;
         ms->possible_cpus->cpus[i].props.socket_id = topo.pkg_id;
-        if (pcms->smp_dies > 1) {
+        if (x86ms->smp_dies > 1) {
             ms->possible_cpus->cpus[i].props.has_die_id = true;
             ms->possible_cpus->cpus[i].props.die_id = topo.die_id;
         }
@@ -191,6 +195,22 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
     return ms->possible_cpus;
 }
 
+static void x86_nmi(NMIState *n, int cpu_index, Error **errp)
+{
+    /* cpu index isn't used */
+    CPUState *cs;
+
+    CPU_FOREACH(cs) {
+        X86CPU *cpu = X86_CPU(cs);
+
+        if (!cpu->apic_state) {
+            cpu_interrupt(cs, CPU_INTERRUPT_NMI);
+        } else {
+            apic_deliver_nmi(cpu->apic_state);
+        }
+    }
+}
+
 static long get_file_size(FILE *f)
 {
     long where, size;
@@ -328,6 +348,7 @@ void x86_load_linux(PCMachineState *pcms,
     char *vmode;
     MachineState *machine = MACHINE(pcms);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    X86MachineState *x86ms = X86_MACHINE(pcms);
     struct setup_data *setup_data;
     const char *kernel_filename = machine->kernel_filename;
     const char *initrd_filename = machine->initrd_filename;
@@ -400,11 +421,12 @@ void x86_load_linux(PCMachineState *pcms,
                             initrd_filename, gerr->message);
                     exit(1);
                 }
-                pcms->initrd_mapped_file = mapped_file;
+                x86ms->initrd_mapped_file = mapped_file;
 
                 initrd_data = g_mapped_file_get_contents(mapped_file);
                 initrd_size = g_mapped_file_get_length(mapped_file);
-                initrd_max = pcms->below_4g_mem_size - pcmc->acpi_data_size - 1;
+                initrd_max =
+                    x86ms->below_4g_mem_size - pcmc->acpi_data_size - 1;
                 if (initrd_size >= initrd_max) {
                     fprintf(stderr, "qemu: initrd is too large, cannot support."
                             "(max: %"PRIu32", need %"PRId64")\n",
@@ -472,8 +494,8 @@ void x86_load_linux(PCMachineState *pcms,
         initrd_max = 0x37ffffff;
     }
 
-    if (initrd_max >= pcms->below_4g_mem_size - pcmc->acpi_data_size) {
-        initrd_max = pcms->below_4g_mem_size - pcmc->acpi_data_size - 1;
+    if (initrd_max >= x86ms->below_4g_mem_size - pcmc->acpi_data_size) {
+        initrd_max = x86ms->below_4g_mem_size - pcmc->acpi_data_size - 1;
     }
 
     fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_ADDR, cmdline_addr);
@@ -544,7 +566,7 @@ void x86_load_linux(PCMachineState *pcms,
                     initrd_filename, gerr->message);
             exit(1);
         }
-        pcms->initrd_mapped_file = mapped_file;
+        x86ms->initrd_mapped_file = mapped_file;
 
         initrd_data = g_mapped_file_get_contents(mapped_file);
         initrd_size = g_mapped_file_get_length(mapped_file);
@@ -688,3 +710,91 @@ void x86_bios_rom_init(MemoryRegion *rom_memory, bool isapc_ram_fw)
                                 (uint32_t)(-bios_size),
                                 bios);
 }
+
+static void x86_machine_get_max_ram_below_4g(Object *obj, Visitor *v,
+                                             const char *name, void *opaque,
+                                             Error **errp)
+{
+    X86MachineState *x86ms = X86_MACHINE(obj);
+    uint64_t value = x86ms->max_ram_below_4g;
+
+    visit_type_size(v, name, &value, errp);
+}
+
+static void x86_machine_set_max_ram_below_4g(Object *obj, Visitor *v,
+                                             const char *name, void *opaque,
+                                             Error **errp)
+{
+    X86MachineState *x86ms = X86_MACHINE(obj);
+    Error *error = NULL;
+    uint64_t value;
+
+    visit_type_size(v, name, &value, &error);
+    if (error) {
+        error_propagate(errp, error);
+        return;
+    }
+    if (value > 4 * GiB) {
+        error_setg(&error,
+                   "Machine option 'max-ram-below-4g=%"PRIu64
+                   "' expects size less than or equal to 4G", value);
+        error_propagate(errp, error);
+        return;
+    }
+
+    if (value < 1 * MiB) {
+        warn_report("Only %" PRIu64 " bytes of RAM below the 4GiB boundary,"
+                    "BIOS may not work with less than 1MiB", value);
+    }
+
+    x86ms->max_ram_below_4g = value;
+}
+
+static void x86_machine_initfn(Object *obj)
+{
+    X86MachineState *x86ms = X86_MACHINE(obj);
+
+    x86ms->max_ram_below_4g = 0; /* use default */
+    x86ms->smp_dies = 1;
+}
+
+static void x86_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    X86MachineClass *x86mc = X86_MACHINE_CLASS(oc);
+    NMIClass *nc = NMI_CLASS(oc);
+
+    mc->cpu_index_to_instance_props = x86_cpu_index_to_props;
+    mc->get_default_cpu_node_id = x86_get_default_cpu_node_id;
+    mc->possible_cpu_arch_ids = x86_possible_cpu_arch_ids;
+    x86mc->compat_apic_id_mode = false;
+    nc->nmi_monitor_handler = x86_nmi;
+
+    object_class_property_add(oc, X86_MACHINE_MAX_RAM_BELOW_4G, "size",
+        x86_machine_get_max_ram_below_4g, x86_machine_set_max_ram_below_4g,
+        NULL, NULL, &error_abort);
+
+    object_class_property_set_description(oc, X86_MACHINE_MAX_RAM_BELOW_4G,
+        "Maximum ram below the 4G boundary (32bit boundary)", &error_abort);
+}
+
+static const TypeInfo x86_machine_info = {
+    .name = TYPE_X86_MACHINE,
+    .parent = TYPE_MACHINE,
+    .abstract = true,
+    .instance_size = sizeof(X86MachineState),
+    .instance_init = x86_machine_initfn,
+    .class_size = sizeof(X86MachineClass),
+    .class_init = x86_machine_class_init,
+    .interfaces = (InterfaceInfo[]) {
+         { TYPE_NMI },
+         { }
+    },
+};
+
+static void x86_machine_register_types(void)
+{
+    type_register_static(&x86_machine_info);
+}
+
+type_init(x86_machine_register_types)
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 6b5e5bb..95f23a2 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -197,11 +197,13 @@ qemu_irq *xen_interrupt_controller_init(void)
 static void xen_ram_init(PCMachineState *pcms,
                          ram_addr_t ram_size, MemoryRegion **ram_memory_p)
 {
+    X86MachineState *x86ms = X86_MACHINE(pcms);
     MemoryRegion *sysmem = get_system_memory();
     ram_addr_t block_len;
-    uint64_t user_lowmem = object_property_get_uint(qdev_get_machine(),
-                                                    PC_MACHINE_MAX_RAM_BELOW_4G,
-                                                    &error_abort);
+    uint64_t user_lowmem =
+        object_property_get_uint(qdev_get_machine(),
+                                 X86_MACHINE_MAX_RAM_BELOW_4G,
+                                 &error_abort);
 
     /* Handle the machine opt max-ram-below-4g.  It is basically doing
      * min(xen limit, user limit).
@@ -214,20 +216,20 @@ static void xen_ram_init(PCMachineState *pcms,
     }
 
     if (ram_size >= user_lowmem) {
-        pcms->above_4g_mem_size = ram_size - user_lowmem;
-        pcms->below_4g_mem_size = user_lowmem;
+        x86ms->above_4g_mem_size = ram_size - user_lowmem;
+        x86ms->below_4g_mem_size = user_lowmem;
     } else {
-        pcms->above_4g_mem_size = 0;
-        pcms->below_4g_mem_size = ram_size;
+        x86ms->above_4g_mem_size = 0;
+        x86ms->below_4g_mem_size = ram_size;
     }
-    if (!pcms->above_4g_mem_size) {
+    if (!x86ms->above_4g_mem_size) {
         block_len = ram_size;
     } else {
         /*
          * Xen does not allocate the memory continuously, it keeps a
          * hole of the size computed above or passed in.
          */
-        block_len = (1ULL << 32) + pcms->above_4g_mem_size;
+        block_len = (1ULL << 32) + x86ms->above_4g_mem_size;
     }
     memory_region_init_ram(&ram_memory, NULL, "xen.ram", block_len,
                            &error_fatal);
@@ -244,12 +246,12 @@ static void xen_ram_init(PCMachineState *pcms,
      */
     memory_region_init_alias(&ram_lo, NULL, "xen.ram.lo",
                              &ram_memory, 0xc0000,
-                             pcms->below_4g_mem_size - 0xc0000);
+                             x86ms->below_4g_mem_size - 0xc0000);
     memory_region_add_subregion(sysmem, 0xc0000, &ram_lo);
-    if (pcms->above_4g_mem_size > 0) {
+    if (x86ms->above_4g_mem_size > 0) {
         memory_region_init_alias(&ram_hi, NULL, "xen.ram.hi",
                                  &ram_memory, 0x100000000ULL,
-                                 pcms->above_4g_mem_size);
+                                 x86ms->above_4g_mem_size);
         memory_region_add_subregion(sysmem, 0x100000000ULL, &ram_hi);
     }
 }
@@ -265,7 +267,7 @@ void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
         /* RAM already populated in Xen */
         fprintf(stderr, "%s: do not alloc "RAM_ADDR_FMT
                 " bytes of ram at "RAM_ADDR_FMT" when runstate is INMIGRATE\n",
-                __func__, size, ram_addr); 
+                __func__, size, ram_addr);
         return;
     }
 
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 1ede055..ead14e1 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -89,7 +89,7 @@ static void ioapic_entry_parse(uint64_t entry, struct ioapic_entry_info *info)
 
 static void ioapic_service(IOAPICCommonState *s)
 {
-    AddressSpace *ioapic_as = PC_MACHINE(qdev_get_machine())->ioapic_as;
+    AddressSpace *ioapic_as = X86_MACHINE(qdev_get_machine())->ioapic_as;
     struct ioapic_entry_info info;
     uint8_t i;
     uint32_t mask;
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index f135ae8..13c4eac 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -8,6 +8,7 @@
 #include "hw/block/flash.h"
 #include "net/net.h"
 #include "hw/i386/ioapic.h"
+#include "hw/i386/x86.h"
 
 #include "qemu/range.h"
 #include "qemu/bitmap.h"
@@ -27,7 +28,7 @@
  */
 struct PCMachineState {
     /*< private >*/
-    MachineState parent_obj;
+    X86MachineState parent_obj;
 
     /* <public> */
 
@@ -36,16 +37,11 @@ struct PCMachineState {
 
     /* Pointers to devices and objects: */
     HotplugHandler *acpi_dev;
-    ISADevice *rtc;
     PCIBus *bus;
     I2CBus *smbus;
-    FWCfgState *fw_cfg;
-    qemu_irq *gsi;
     PFlashCFI01 *flash[2];
-    GMappedFile *initrd_mapped_file;
 
     /* Configuration options: */
-    uint64_t max_ram_below_4g;
     OnOffAuto vmport;
     OnOffAuto smm;
 
@@ -54,30 +50,16 @@ struct PCMachineState {
     bool sata_enabled;
     bool pit_enabled;
 
-    /* RAM information (sizes, addresses, configuration): */
-    ram_addr_t below_4g_mem_size, above_4g_mem_size;
-
-    /* CPU and apic information: */
-    bool apic_xrupt_override;
-    unsigned apic_id_limit;
-    uint16_t boot_cpus;
-    unsigned smp_dies;
-
     /* NUMA information: */
     uint64_t numa_nodes;
     uint64_t *node_mem;
 
-    /* Address space used by IOAPIC device. All IOAPIC interrupts
-     * will be translated to MSI messages in the address space. */
-    AddressSpace *ioapic_as;
-
     /* ACPI Memory hotplug IO base address */
     hwaddr memhp_io_base;
 };
 
 #define PC_MACHINE_ACPI_DEVICE_PROP "acpi-device"
 #define PC_MACHINE_DEVMEM_REGION_SIZE "device-memory-region-size"
-#define PC_MACHINE_MAX_RAM_BELOW_4G "max-ram-below-4g"
 #define PC_MACHINE_VMPORT           "vmport"
 #define PC_MACHINE_SMM              "smm"
 #define PC_MACHINE_SMBUS            "smbus"
@@ -102,7 +84,7 @@ struct PCMachineState {
  */
 typedef struct PCMachineClass {
     /*< private >*/
-    MachineClass parent_class;
+    X86MachineClass parent_class;
 
     /*< public >*/
 
@@ -144,9 +126,6 @@ typedef struct PCMachineClass {
 
     /* use PVH to load kernels that support this feature */
     bool pvh_enabled;
-
-    /* Enables contiguous-apic-ID mode */
-    bool compat_apic_id_mode;
 } PCMachineClass;
 
 #define TYPE_PC_MACHINE "generic-pc-machine"
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 71e2b69..d15713e 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -17,7 +17,63 @@
 #ifndef HW_I386_X86_H
 #define HW_I386_X86_H
 
+#include "qemu-common.h"
+#include "exec/hwaddr.h"
+#include "qemu/notify.h"
+
 #include "hw/boards.h"
+#include "hw/nmi.h"
+
+typedef struct {
+    /*< private >*/
+    MachineClass parent;
+
+    /*< public >*/
+
+    /* Enables contiguous-apic-ID mode */
+    bool compat_apic_id_mode;
+} X86MachineClass;
+
+typedef struct {
+    /*< private >*/
+    MachineState parent;
+
+    /*< public >*/
+
+    /* Pointers to devices and objects: */
+    ISADevice *rtc;
+    FWCfgState *fw_cfg;
+    qemu_irq *gsi;
+    GMappedFile *initrd_mapped_file;
+
+    /* Configuration options: */
+    uint64_t max_ram_below_4g;
+
+    /* RAM information (sizes, addresses, configuration): */
+    ram_addr_t below_4g_mem_size, above_4g_mem_size;
+
+    /* CPU and apic information: */
+    bool apic_xrupt_override;
+    unsigned apic_id_limit;
+    uint16_t boot_cpus;
+    unsigned smp_dies;
+
+    /*
+     * Address space used by IOAPIC device. All IOAPIC interrupts
+     * will be translated to MSI messages in the address space.
+     */
+    AddressSpace *ioapic_as;
+} X86MachineState;
+
+#define X86_MACHINE_MAX_RAM_BELOW_4G "max-ram-below-4g"
+
+#define TYPE_X86_MACHINE   MACHINE_TYPE_NAME("x86")
+#define X86_MACHINE(obj) \
+    OBJECT_CHECK(X86MachineState, (obj), TYPE_X86_MACHINE)
+#define X86_MACHINE_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(X86MachineClass, obj, TYPE_X86_MACHINE)
+#define X86_MACHINE_CLASS(class) \
+    OBJECT_CLASS_CHECK(X86MachineClass, class, TYPE_X86_MACHINE)
 
 uint32_t x86_cpu_apic_id_from_index(PCMachineState *pcms,
                                     unsigned int cpu_index);
@@ -30,6 +86,6 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms);
 
 void x86_bios_rom_init(MemoryRegion *rom_memory, bool isapc_ram_fw);
 
-void x86_load_linux(PCMachineState *x86ms, FWCfgState *fw_cfg);
+void x86_load_linux(PCMachineState *pcms, FWCfgState *fw_cfg);
 
 #endif
-- 
1.8.3.1



