Return-Path: <SRS0=1g4J=U5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B493C5B57E
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 10:23:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A092204FD
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 10:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dgkNHFnq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A092204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhWzb-0003H7-7e
	for qemu-devel@archiver.kernel.org; Sun, 30 Jun 2019 06:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47007)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <hongbo.zhang@linaro.org>) id 1hhWxQ-0001Sx-OQ
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 06:21:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hongbo.zhang@linaro.org>) id 1hhWxN-0004EF-MN
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 06:21:16 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:33774)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
 id 1hhWxN-0004Cz-6q
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 06:21:13 -0400
Received: by mail-pf1-x442.google.com with SMTP id x15so5126946pfq.0
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 03:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=5oD05dphrRbZ7JrCgkcfAPZGRaVpSL2TcmyWvWdRW8Y=;
 b=dgkNHFnqp2zS/FirS0NU9A9njlC5T5Zd+iloE9kH/g0eeKu21cMzdaUJV56CCxg2Sl
 8ZNKllBoa9vAV1EuEbJJu0IwvstioCWwhIQy9FCLGvqfNOH/VbLRnDbDcEDvQ6n9WByw
 AJOUNRaotsPG00WKutFLfkllGJEVcPUUL7pg2/D7MU+FVL6YhB/uWNtBZJ4MHs1X6Sbi
 mW9TZIcbGUPGoaZUAvu0DWIUkIsa3QIp5g02PDL3SqmtH96MY5r4SKo4a+Xrg8WEO8FX
 KgajbD2xZPUB+ert0JROCj0PTnb4AYaDXAKCZfaDH/6N958frlqv3MWn0FGHveFb9xs+
 MXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=5oD05dphrRbZ7JrCgkcfAPZGRaVpSL2TcmyWvWdRW8Y=;
 b=mMGEDGS+W/8riOKDwiali+Nyu5kp3BaQxXRfEm2OYA2IOdaB9t9rd5JfnJPxGgIKGM
 LyK8McZkJ+fOktuVbvizGxuNiO4eSMhLh2fGVmOHsSmtjKT+ulFUA+2Qe8S5SFtkjE18
 Qio94+D0rJyXiWRa+ZDRKJdx28AhYZ133b4p2oGY2UMG9rVa1Jyw4uQfWx5WlOom9FhJ
 5ktHkbVwfhAvsEF/8wphjDLIYkLMx2UD/qRyuYy70bsJP52ROxZU0WTP0cbxtnK7PVtH
 oExhLqH5cxYDf72XyvHrS6aZ9DsdZn+E8Bqd0f+Etg+z3dxlvfapDL9Rx12b+0hNNZLH
 npuw==
X-Gm-Message-State: APjAAAUGkgkcPS0rc8cXj1qAO2+HJbAx4OmSf2BnoJCwQBAmWAyMd4Uw
 NMAXa+5axPeoKtZVKjhQ5tJing==
X-Google-Smtp-Source: APXvYqwHZoYzrcvP65cQxUlEWoRI/mY7VTuWMJOhV1EqcI+3dHCxqNCxnffhbAmkD1wEKlxx+T+1rw==
X-Received: by 2002:a17:90a:b011:: with SMTP id
 x17mr24482364pjq.113.1561890071457; 
 Sun, 30 Jun 2019 03:21:11 -0700 (PDT)
Received: from localhost.localdomain ([114.246.94.159])
 by smtp.gmail.com with ESMTPSA id m100sm8714549pje.12.2019.06.30.03.21.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 30 Jun 2019 03:21:10 -0700 (PDT)
From: Hongbo Zhang <hongbo.zhang@linaro.org>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Date: Sun, 30 Jun 2019 18:20:33 +0800
Message-Id: <1561890034-15921-2-git-send-email-hongbo.zhang@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561890034-15921-1-git-send-email-hongbo.zhang@linaro.org>
References: <1561890034-15921-1-git-send-email-hongbo.zhang@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v9 1/2] hw/arm: Add arm SBSA reference machine,
 skeleton part
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
Cc: Hongbo Zhang <hongbo.zhang@linaro.org>, radoslaw.biernacki@linaro.org,
 leif.lindholm@linaro.org, ard.biesheuvel@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For the Aarch64, there is one machine 'virt', it is primarily meant to
run on KVM and execute virtualization workloads, but we need an
environment as faithful as possible to physical hardware, for supporting
firmware and OS development for pysical Aarch64 machines.

This patch introduces new machine type 'sbsa-ref' with main features:
 - Based on 'virt' machine type.
 - A new memory map.
 - CPU type cortex-a57.
 - EL2 and EL3 are enabled.
 - GIC version 3.
 - System bus AHCI controller.
 - System bus EHCI controller.
 - CDROM and hard disc on AHCI bus.
 - E1000E ethernet card on PCIE bus.
 - VGA display adaptor on PCIE bus.
 - No virtio deivces.
 - No fw_cfg device.
 - No ACPI table supplied.
 - Only minimal device tree nodes.

Arm Trusted Firmware and UEFI porting to this are done accordingly, and
it should supply ACPI tables to load OS, the minimal device tree nodes
supplied from this platform are only to pass the dynamic info reflecting
command line input to firmware, not for loading OS.

To make the review easier, this task is split into two patches, the
fundamental sceleton part and the peripheral devices part, this patch is
the first part.

Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
---
 default-configs/arm-softmmu.mak |   1 +
 hw/arm/Kconfig                  |  16 +++
 hw/arm/Makefile.objs            |   1 +
 hw/arm/sbsa-ref.c               | 281 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 299 insertions(+)
 create mode 100644 hw/arm/sbsa-ref.c

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 1f2e0e7..f9fdb73 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -19,6 +19,7 @@ CONFIG_SX1=y
 CONFIG_NSERIES=y
 CONFIG_STELLARIS=y
 CONFIG_REALVIEW=y
+CONFIG_SBSA_REF=y
 CONFIG_VERSATILE=y
 CONFIG_VEXPRESS=y
 CONFIG_ZYNQ=y
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 9aced9d..18e47b2 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -184,6 +184,22 @@ config REALVIEW
     select DS1338 # I2C RTC+NVRAM
     select USB_OHCI
 
+config SBSA_REF
+    bool
+    imply PCI_DEVICES
+    select A15MPCORE
+    select AHCI
+    select ARM_SMMUV3
+    select GPIO_KEY
+    select PCI_EXPRESS
+    select PCI_EXPRESS_GENERIC_BRIDGE
+    select PFLASH_CFI01
+    select PL011 # UART
+    select PL031 # RTC
+    select PL061 # GPIO
+    select PLATFORM_BUS
+    select USB_EHCI_SYSBUS
+
 config SABRELITE
     bool
     select FSL_IMX6
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 994e67d..43ce8d5 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -19,6 +19,7 @@ obj-$(CONFIG_SPITZ) += spitz.o
 obj-$(CONFIG_TOSA) += tosa.o
 obj-$(CONFIG_Z2) += z2.o
 obj-$(CONFIG_REALVIEW) += realview.o
+obj-$(CONFIG_SBSA_REF) += sbsa-ref.o
 obj-$(CONFIG_STELLARIS) += stellaris.o
 obj-$(CONFIG_COLLIE) += collie.o
 obj-$(CONFIG_VERSATILE) += versatilepb.o
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
new file mode 100644
index 0000000..eaf97e8
--- /dev/null
+++ b/hw/arm/sbsa-ref.c
@@ -0,0 +1,281 @@
+/*
+ * ARM SBSA Reference Platform emulation
+ *
+ * Copyright (c) 2018 Linaro Limited
+ * Written by Hongbo Zhang <hongbo.zhang@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/units.h"
+#include "sysemu/numa.h"
+#include "sysemu/sysemu.h"
+#include "exec/address-spaces.h"
+#include "exec/hwaddr.h"
+#include "kvm_arm.h"
+#include "hw/arm/boot.h"
+#include "hw/boards.h"
+#include "hw/intc/arm_gicv3_common.h"
+
+#define RAMLIMIT_GB 8192
+#define RAMLIMIT_BYTES (RAMLIMIT_GB * GiB)
+
+enum {
+    SBSA_FLASH,
+    SBSA_MEM,
+    SBSA_CPUPERIPHS,
+    SBSA_GIC_DIST,
+    SBSA_GIC_REDIST,
+    SBSA_SMMU,
+    SBSA_UART,
+    SBSA_RTC,
+    SBSA_PCIE,
+    SBSA_PCIE_MMIO,
+    SBSA_PCIE_MMIO_HIGH,
+    SBSA_PCIE_PIO,
+    SBSA_PCIE_ECAM,
+    SBSA_GPIO,
+    SBSA_SECURE_UART,
+    SBSA_SECURE_UART_MM,
+    SBSA_SECURE_MEM,
+    SBSA_AHCI,
+    SBSA_EHCI,
+};
+
+typedef struct MemMapEntry {
+    hwaddr base;
+    hwaddr size;
+} MemMapEntry;
+
+typedef struct {
+    MachineState parent;
+    struct arm_boot_info bootinfo;
+    int smp_cpus;
+    void *fdt;
+    int fdt_size;
+    int psci_conduit;
+} SBSAMachineState;
+
+#define TYPE_SBSA_MACHINE   MACHINE_TYPE_NAME("sbsa-ref")
+#define SBSA_MACHINE(obj) \
+    OBJECT_CHECK(SBSAMachineState, (obj), TYPE_SBSA_MACHINE)
+
+static const MemMapEntry sbsa_ref_memmap[] = {
+    /* 512M boot ROM */
+    [SBSA_FLASH] =              {          0, 0x20000000 },
+    /* 512M secure memory */
+    [SBSA_SECURE_MEM] =         { 0x20000000, 0x20000000 },
+    /* Space reserved for CPU peripheral devices */
+    [SBSA_CPUPERIPHS] =         { 0x40000000, 0x00040000 },
+    [SBSA_GIC_DIST] =           { 0x40060000, 0x00010000 },
+    [SBSA_GIC_REDIST] =         { 0x40080000, 0x04000000 },
+    [SBSA_UART] =               { 0x60000000, 0x00001000 },
+    [SBSA_RTC] =                { 0x60010000, 0x00001000 },
+    [SBSA_GPIO] =               { 0x60020000, 0x00001000 },
+    [SBSA_SECURE_UART] =        { 0x60030000, 0x00001000 },
+    [SBSA_SECURE_UART_MM] =     { 0x60040000, 0x00001000 },
+    [SBSA_SMMU] =               { 0x60050000, 0x00020000 },
+    /* Space here reserved for more SMMUs */
+    [SBSA_AHCI] =               { 0x60100000, 0x00010000 },
+    [SBSA_EHCI] =               { 0x60110000, 0x00010000 },
+    /* Space here reserved for other devices */
+    [SBSA_PCIE_PIO] =           { 0x7fff0000, 0x00010000 },
+    /* 32-bit address PCIE MMIO space */
+    [SBSA_PCIE_MMIO] =          { 0x80000000, 0x70000000 },
+    /* 256M PCIE ECAM space */
+    [SBSA_PCIE_ECAM] =          { 0xf0000000, 0x10000000 },
+    /* ~1TB PCIE MMIO space (4GB to 1024GB boundary) */
+    [SBSA_PCIE_MMIO_HIGH] =     { 0x100000000ULL, 0xFF00000000ULL },
+    [SBSA_MEM] =                { 0x10000000000ULL, RAMLIMIT_BYTES },
+};
+
+static const int sbsa_ref_irqmap[] = {
+    [SBSA_UART] = 1,
+    [SBSA_RTC] = 2,
+    [SBSA_PCIE] = 3, /* ... to 6 */
+    [SBSA_GPIO] = 7,
+    [SBSA_SECURE_UART] = 8,
+    [SBSA_SECURE_UART_MM] = 9,
+    [SBSA_AHCI] = 10,
+    [SBSA_EHCI] = 11,
+};
+
+static void sbsa_ref_init(MachineState *machine)
+{
+    SBSAMachineState *sms = SBSA_MACHINE(machine);
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    MemoryRegion *sysmem = get_system_memory();
+    MemoryRegion *secure_sysmem = NULL;
+    MemoryRegion *ram = g_new(MemoryRegion, 1);
+    const CPUArchIdList *possible_cpus;
+    int n, sbsa_max_cpus;
+
+    if (strcmp(machine->cpu_type, ARM_CPU_TYPE_NAME("cortex-a57"))) {
+        error_report("sbsa-ref: CPU type other than the built-in "
+                     "cortex-a57 not supported");
+        exit(1);
+    }
+
+    if (kvm_enabled()) {
+        error_report("sbsa-ref: KVM is not supported for this machine");
+        exit(1);
+    }
+
+    /*
+     * This machine has EL3 enabled, external firmware should supply PSCI
+     * implementation, so the QEMU's internal PSCI is disabled.
+     */
+    sms->psci_conduit = QEMU_PSCI_CONDUIT_DISABLED;
+
+    sbsa_max_cpus = sbsa_ref_memmap[SBSA_GIC_REDIST].size / GICV3_REDIST_SIZE;
+
+    if (max_cpus > sbsa_max_cpus) {
+        error_report("Number of SMP CPUs requested (%d) exceeds max CPUs "
+                     "supported by machine 'sbsa-ref' (%d)",
+                     max_cpus, sbsa_max_cpus);
+        exit(1);
+    }
+
+    sms->smp_cpus = smp_cpus;
+
+    if (machine->ram_size > sbsa_ref_memmap[SBSA_MEM].size) {
+        error_report("sbsa-ref: cannot model more than %dGB RAM", RAMLIMIT_GB);
+        exit(1);
+    }
+
+    possible_cpus = mc->possible_cpu_arch_ids(machine);
+    for (n = 0; n < possible_cpus->len; n++) {
+        Object *cpuobj;
+        CPUState *cs;
+
+        if (n >= smp_cpus) {
+            break;
+        }
+
+        cpuobj = object_new(possible_cpus->cpus[n].type);
+        object_property_set_int(cpuobj, possible_cpus->cpus[n].arch_id,
+                                "mp-affinity", NULL);
+
+        cs = CPU(cpuobj);
+        cs->cpu_index = n;
+
+        numa_cpu_pre_plug(&possible_cpus->cpus[cs->cpu_index], DEVICE(cpuobj),
+                          &error_fatal);
+
+        if (object_property_find(cpuobj, "reset-cbar", NULL)) {
+            object_property_set_int(cpuobj,
+                                    sbsa_ref_memmap[SBSA_CPUPERIPHS].base,
+                                    "reset-cbar", &error_abort);
+        }
+
+        object_property_set_link(cpuobj, OBJECT(sysmem), "memory",
+                                 &error_abort);
+
+        object_property_set_link(cpuobj, OBJECT(secure_sysmem),
+                                 "secure-memory", &error_abort);
+
+        object_property_set_bool(cpuobj, true, "realized", &error_fatal);
+        object_unref(cpuobj);
+    }
+
+    memory_region_allocate_system_memory(ram, NULL, "sbsa-ref.ram",
+                                         machine->ram_size);
+    memory_region_add_subregion(sysmem, sbsa_ref_memmap[SBSA_MEM].base, ram);
+
+    sms->bootinfo.ram_size = machine->ram_size;
+    sms->bootinfo.kernel_filename = machine->kernel_filename;
+    sms->bootinfo.nb_cpus = smp_cpus;
+    sms->bootinfo.board_id = -1;
+    sms->bootinfo.loader_start = sbsa_ref_memmap[SBSA_MEM].base;
+    arm_load_kernel(ARM_CPU(first_cpu), &sms->bootinfo);
+}
+
+static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
+{
+    uint8_t clustersz = ARM_DEFAULT_CPUS_PER_CLUSTER;
+    return arm_cpu_mp_affinity(idx, clustersz);
+}
+
+static const CPUArchIdList *sbsa_ref_possible_cpu_arch_ids(MachineState *ms)
+{
+    SBSAMachineState *sms = SBSA_MACHINE(ms);
+    int n;
+
+    if (ms->possible_cpus) {
+        assert(ms->possible_cpus->len == max_cpus);
+        return ms->possible_cpus;
+    }
+
+    ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
+                                  sizeof(CPUArchId) * max_cpus);
+    ms->possible_cpus->len = max_cpus;
+    for (n = 0; n < ms->possible_cpus->len; n++) {
+        ms->possible_cpus->cpus[n].type = ms->cpu_type;
+        ms->possible_cpus->cpus[n].arch_id =
+            sbsa_ref_cpu_mp_affinity(sms, n);
+        ms->possible_cpus->cpus[n].props.has_thread_id = true;
+        ms->possible_cpus->cpus[n].props.thread_id = n;
+    }
+    return ms->possible_cpus;
+}
+
+static CpuInstanceProperties
+sbsa_ref_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(ms);
+
+    assert(cpu_index < possible_cpus->len);
+    return possible_cpus->cpus[cpu_index].props;
+}
+
+static int64_t
+sbsa_ref_get_default_cpu_node_id(const MachineState *ms, int idx)
+{
+    return idx % nb_numa_nodes;
+}
+
+static void sbsa_ref_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->init = sbsa_ref_init;
+    mc->desc = "QEMU 'SBSA Reference' ARM Virtual Machine";
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a57");
+    mc->max_cpus = 512;
+    mc->pci_allow_0_address = true;
+    mc->minimum_page_bits = 12;
+    mc->block_default_type = IF_IDE;
+    mc->no_cdrom = 1;
+    mc->default_ram_size = 1 * GiB;
+    mc->default_cpus = 4;
+    mc->possible_cpu_arch_ids = sbsa_ref_possible_cpu_arch_ids;
+    mc->cpu_index_to_instance_props = sbsa_ref_cpu_index_to_props;
+    mc->get_default_cpu_node_id = sbsa_ref_get_default_cpu_node_id;
+}
+
+static const TypeInfo sbsa_ref_info = {
+    .name          = TYPE_SBSA_MACHINE,
+    .parent        = TYPE_MACHINE,
+    .class_init    = sbsa_ref_class_init,
+};
+
+static void sbsa_ref_machine_init(void)
+{
+    type_register_static(&sbsa_ref_info);
+}
+
+type_init(sbsa_ref_machine_init);
-- 
2.7.4


