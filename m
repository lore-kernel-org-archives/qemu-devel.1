Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920BEC04AAA
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 08:42:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52A56205C9
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 08:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A56205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52578 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNZCY-00010N-Ht
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 04:42:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hNZ5T-0002tw-Gx
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:35:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hNZ5R-0007MU-AA
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:35:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:60079)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
	id 1hNZ5P-0007KN-FK
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:35:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	06 May 2019 01:34:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,437,1549958400"; d="scan'208";a="155407111"
Received: from xulike-server.sh.intel.com ([10.239.48.134])
	by FMSMGA003.fm.intel.com with ESMTP; 06 May 2019 01:34:56 -0700
From: Like Xu <like.xu@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Mon,  6 May 2019 16:33:14 +0800
Message-Id: <1557131596-25403-9-git-send-email-like.xu@linux.intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1557131596-25403-1-git-send-email-like.xu@linux.intel.com>
References: <1557131596-25403-1-git-send-email-like.xu@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.115
Subject: [Qemu-devel] [PATCH v2 08/10] cpu/topology: add hw/i386 support for
 smp machine properties
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alistair Francis <alistair23@gmail.com>,
	Igor Mammedov <imammedo@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Following the replace rules, the global smp variables in i386
are replaced with smp machine properties. To avoid calling qdev_get_machine()
as much as possible, related funtions for acpi data generations including
init_cpus() are refactored to pass MachineState. No semantic changes.

Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 hw/arm/vexpress.c     |  4 ++--
 hw/i386/acpi-build.c  | 13 ++++++++-----
 hw/i386/kvmvapic.c    |  7 +++++--
 hw/i386/pc.c          | 24 +++++++++++++++---------
 hw/i386/xen/xen-hvm.c |  4 ++++
 target/i386/cpu.c     |  4 +++-
 6 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index d8634f3..19273a2 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -377,8 +377,8 @@ static void a15_daughterboard_init(const VexpressMachineState *vms,
     memory_region_add_subregion(sysmem, 0x80000000, ram);
 
     /* 0x2c000000 A15MPCore private memory region (GIC) */
-    init_cpus(cpu_type, TYPE_A15MPCORE_PRIV, 0x2c000000, pic, vms->secure,
-              vms->virt);
+    init_cpus(machine, cpu_type, TYPE_A15MPCORE_PRIV,
+              0x2c000000, pic, vms->secure, vms->virt);
 
     /* A15 daughterboard peripherals: */
 
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 416da31..29adc17 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -44,6 +44,7 @@
 #include "sysemu/tpm.h"
 #include "hw/acpi/tpm.h"
 #include "hw/acpi/vmgenid.h"
+#include "hw/boards.h"
 #include "sysemu/tpm_backend.h"
 #include "hw/timer/mc146818rtc_regs.h"
 #include "hw/mem/memory-device.h"
@@ -125,7 +126,8 @@ typedef struct FwCfgTPMConfig {
     uint8_t tpmppi_version;
 } QEMU_PACKED FwCfgTPMConfig;
 
-static void init_common_fadt_data(Object *o, AcpiFadtData *data)
+static void init_common_fadt_data(MachineState *ms, Object *o,
+                                  AcpiFadtData *data)
 {
     uint32_t io = object_property_get_uint(o, ACPI_PM_PROP_PM_IO_BASE, NULL);
     AmlAddressSpace as = AML_AS_SYSTEM_IO;
@@ -141,7 +143,8 @@ static void init_common_fadt_data(Object *o, AcpiFadtData *data)
              * CPUs for more than 8 CPUs, "Clustered Logical" mode has to be
              * used
              */
-            ((max_cpus > 8) ? (1 << ACPI_FADT_F_FORCE_APIC_CLUSTER_MODEL) : 0),
+            ((ms->smp.max_cpus > 8) ?
+                        (1 << ACPI_FADT_F_FORCE_APIC_CLUSTER_MODEL) : 0),
         .int_model = 1 /* Multiple APIC */,
         .rtc_century = RTC_CENTURY,
         .plvl2_lat = 0xfff /* C2 state not supported */,
@@ -164,7 +167,7 @@ static void init_common_fadt_data(Object *o, AcpiFadtData *data)
     *data = fadt;
 }
 
-static void acpi_get_pm_info(AcpiPmInfo *pm)
+static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
 {
     Object *piix = piix4_pm_find();
     Object *lpc = ich9_lpc_find();
@@ -174,7 +177,7 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
     pm->pcihp_io_base = 0;
     pm->pcihp_io_len = 0;
 
-    init_common_fadt_data(obj, &pm->fadt);
+    init_common_fadt_data(machine, obj, &pm->fadt);
     if (piix) {
         /* w2k requires FADT(rev1) or it won't boot, keep PC compatible */
         pm->fadt.rev = 1;
@@ -2617,7 +2620,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     AcpiSlicOem slic_oem = { .id = NULL, .table_id = NULL };
     Object *vmgenid_dev;
 
-    acpi_get_pm_info(&pm);
+    acpi_get_pm_info(machine, &pm);
     acpi_get_misc_info(&misc);
     acpi_get_pci_holes(&pci_hole, &pci_hole64);
     acpi_get_slic_oem(&slic_oem);
diff --git a/hw/i386/kvmvapic.c b/hw/i386/kvmvapic.c
index 70f6f26..3fce704 100644
--- a/hw/i386/kvmvapic.c
+++ b/hw/i386/kvmvapic.c
@@ -17,6 +17,7 @@
 #include "sysemu/kvm.h"
 #include "hw/i386/apic_internal.h"
 #include "hw/sysbus.h"
+#include "hw/boards.h"
 #include "tcg/tcg.h"
 
 #define VAPIC_IO_PORT           0x7e
@@ -441,11 +442,12 @@ static void do_patch_instruction(CPUState *cs, run_on_cpu_data data)
 
 static void patch_instruction(VAPICROMState *s, X86CPU *cpu, target_ulong ip)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
     CPUState *cs = CPU(cpu);
     VAPICHandlers *handlers;
     PatchInfo *info;
 
-    if (smp_cpus == 1) {
+    if (ms->smp.cpus == 1) {
         handlers = &s->rom_state.up;
     } else {
         handlers = &s->rom_state.mp;
@@ -746,6 +748,7 @@ static void do_vapic_enable(CPUState *cs, run_on_cpu_data data)
 static void kvmvapic_vm_state_change(void *opaque, int running,
                                      RunState state)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
     VAPICROMState *s = opaque;
     uint8_t *zero;
 
@@ -754,7 +757,7 @@ static void kvmvapic_vm_state_change(void *opaque, int running,
     }
 
     if (s->state == VAPIC_ACTIVE) {
-        if (smp_cpus == 1) {
+        if (ms->smp.cpus == 1) {
             run_on_cpu(first_cpu, do_vapic_enable, RUN_ON_CPU_HOST_PTR(s));
         } else {
             zero = g_malloc0(s->rom_state.vapic_size);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 9bcd867..896c22e 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -932,12 +932,14 @@ void enable_compat_apic_id_mode(void)
  * no concept of "CPU index", and the NUMA tables on fw_cfg need the APIC ID of
  * all CPUs up to max_cpus.
  */
-static uint32_t x86_cpu_apic_id_from_index(unsigned int cpu_index)
+static uint32_t x86_cpu_apic_id_from_index(MachineState *ms,
+                                           unsigned int cpu_index)
 {
     uint32_t correct_id;
     static bool warned;
 
-    correct_id = x86_apicid_from_cpu_idx(smp_cores, smp_threads, cpu_index);
+    correct_id = x86_apicid_from_cpu_idx(ms->smp.cores,
+                                         ms->smp.threads, cpu_index);
     if (compat_apic_id_mode) {
         if (cpu_index != correct_id && !warned && !qtest_enabled()) {
             error_report("APIC IDs set in compatibility mode, "
@@ -1536,7 +1538,7 @@ static void pc_new_cpu(const char *typename, int64_t apic_id, Error **errp)
 
 void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp)
 {
-    int64_t apic_id = x86_cpu_apic_id_from_index(id);
+    int64_t apic_id = x86_cpu_apic_id_from_index(ms, id);
     Error *local_err = NULL;
 
     if (id < 0) {
@@ -1572,9 +1574,10 @@ void pc_cpus_init(PCMachineState *pcms)
      *
      * This is used for FW_CFG_MAX_CPUS. See comments on bochs_bios_init().
      */
-    pcms->apic_id_limit = x86_cpu_apic_id_from_index(max_cpus - 1) + 1;
+    pcms->apic_id_limit = x86_cpu_apic_id_from_index(ms,
+                                                     ms->smp.max_cpus - 1) + 1;
     possible_cpus = mc->possible_cpu_arch_ids(ms);
-    for (i = 0; i < smp_cpus; i++) {
+    for (i = 0; i < ms->smp.cpus; i++) {
         pc_new_cpu(possible_cpus->cpus[i].type, possible_cpus->cpus[i].arch_id,
                    &error_fatal);
     }
@@ -2298,6 +2301,8 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     X86CPU *cpu = X86_CPU(dev);
     MachineState *ms = MACHINE(hotplug_dev);
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
+    unsigned int smp_cores = ms->smp.cores;
+    unsigned int smp_threads = ms->smp.threads;
 
     if(!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
         error_setg(errp, "Invalid CPU type, expected cpu type: '%s'",
@@ -2307,7 +2312,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
 
     /* if APIC ID is not set, set it based on socket/core/thread properties */
     if (cpu->apic_id == UNASSIGNED_APIC_ID) {
-        int max_socket = (max_cpus - 1) / smp_threads / smp_cores;
+        int max_socket = (ms->smp.max_cpus - 1) / smp_threads / smp_cores;
 
         if (cpu->socket_id < 0) {
             error_setg(errp, "CPU socket-id is not set");
@@ -2656,13 +2661,14 @@ static int64_t pc_get_default_cpu_node_id(const MachineState *ms, int idx)
 
    assert(idx < ms->possible_cpus->len);
    x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
-                            smp_cores, smp_threads, &topo);
+                            ms->smp.cores, ms->smp.threads, &topo);
    return topo.pkg_id % nb_numa_nodes;
 }
 
 static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
 {
     int i;
+    unsigned int max_cpus = ms->smp.max_cpus;
 
     if (ms->possible_cpus) {
         /*
@@ -2681,9 +2687,9 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
 
         ms->possible_cpus->cpus[i].type = ms->cpu_type;
         ms->possible_cpus->cpus[i].vcpus_count = 1;
-        ms->possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(i);
+        ms->possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(ms, i);
         x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
-                                 smp_cores, smp_threads, &topo);
+                                 ms->smp.cores, ms->smp.threads, &topo);
         ms->possible_cpus->cpus[i].props.has_socket_id = true;
         ms->possible_cpus->cpus[i].props.socket_id = topo.pkg_id;
         ms->possible_cpus->cpus[i].props.has_core_id = true;
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 2939122..941bd25 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -750,6 +750,8 @@ static ioreq_t *cpu_get_ioreq_from_shared_memory(XenIOState *state, int vcpu)
 /* retval--the number of ioreq packet */
 static ioreq_t *cpu_get_ioreq(XenIOState *state)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
+    unsigned int max_cpus = ms->smp.max_cpus;
     int i;
     evtchn_port_t port;
 
@@ -1377,6 +1379,8 @@ static int xen_map_ioreq_server(XenIOState *state)
 
 void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
 {
+    MachineState *ms = MACHINE(pcms);
+    unsigned int max_cpus = ms->smp.max_cpus;
     int i, rc;
     xen_pfn_t ioreq_pfn;
     XenIOState *state;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 722c551..9c52dd4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -54,6 +54,7 @@
 #include "hw/hw.h"
 #include "hw/xen/xen.h"
 #include "hw/i386/apic_internal.h"
+#include "hw/boards.h"
 #endif
 
 #include "disas/capstone.h"
@@ -5340,9 +5341,10 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
 #ifndef CONFIG_USER_ONLY
+    MachineState *ms = MACHINE(qdev_get_machine());
     qemu_register_reset(x86_cpu_machine_reset_cb, cpu);
 
-    if (cpu->env.features[FEAT_1_EDX] & CPUID_APIC || smp_cpus > 1) {
+    if (cpu->env.features[FEAT_1_EDX] & CPUID_APIC || ms->smp.cpus > 1) {
         x86_cpu_apic_create(cpu, &local_err);
         if (local_err != NULL) {
             goto out;
-- 
1.8.3.1


