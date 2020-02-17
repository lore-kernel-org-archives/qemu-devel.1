Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5FDC7619B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:47:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 961892067D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 961892067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3b7f-0004bC-Ls
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 02:47:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39421)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xuyandong2@huawei.com>) id 1j3b2z-0004LA-By
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 02:42:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xuyandong2@huawei.com>) id 1j3b2x-0000Zz-A7
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 02:42:29 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3228 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <xuyandong2@huawei.com>)
 id 1j3b2r-0000PB-Tp; Mon, 17 Feb 2020 02:42:22 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id C8D79CF0072849C02661;
 Mon, 17 Feb 2020 15:42:19 +0800 (CST)
Received: from localhost (10.175.124.177) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Mon, 17 Feb 2020
 15:42:12 +0800
From: Xu Yandong <xuyandong2@huawei.com>
To: <peter.maydell@linaro.org>
Subject: [PATCH RFC 15/16] hw/arm: move shared cpu related functions to arm.c
 and export them
Date: Mon, 17 Feb 2020 02:51:27 -0500
Message-ID: <1581925888-103620-16-git-send-email-xuyandong2@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581925888-103620-1-git-send-email-xuyandong2@huawei.com>
References: <1581925888-103620-1-git-send-email-xuyandong2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.177]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: zhang.zhanghailiang@huawei.com, slp@redhat.com,
 Xu Yandong <xuyandong2@huawei.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 wu.wubin@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move cpu related functions that will be shared between VIRT and
non-VIRT machine types to arm.c.

Signed-off-by: Xu Yandong <xuyandong2@huawei.com>
---
 hw/arm/arm.c          | 89 ++++++++++++++++++++++++++++++++++++++++++
 hw/arm/virt.c         | 91 +------------------------------------------
 include/hw/arm/arm.h  |  3 ++
 include/hw/arm/virt.h |  1 -
 4 files changed, 94 insertions(+), 90 deletions(-)

diff --git a/hw/arm/arm.c b/hw/arm/arm.c
index 7d880dd8e7..8bb5d92d2e 100644
--- a/hw/arm/arm.c
+++ b/hw/arm/arm.c
@@ -39,6 +39,28 @@
 #include "hw/intc/arm_gic.h"
 #include "kvm_arm.h"
 
+static const char *valid_cpus[] = {
+    ARM_CPU_TYPE_NAME("cortex-a7"),
+    ARM_CPU_TYPE_NAME("cortex-a15"),
+    ARM_CPU_TYPE_NAME("cortex-a53"),
+    ARM_CPU_TYPE_NAME("cortex-a57"),
+    ARM_CPU_TYPE_NAME("cortex-a72"),
+    ARM_CPU_TYPE_NAME("host"),
+    ARM_CPU_TYPE_NAME("max"),
+};
+
+bool cpu_type_valid(const char *cpu)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(valid_cpus); i++) {
+        if (strcmp(cpu, valid_cpus[i]) == 0) {
+            return true;
+        }
+    }
+    return false;
+}
+
 void create_fdt(ArmMachineState *ams)
 {
     MachineState *ms = MACHINE(ams);
@@ -543,6 +565,70 @@ static void virt_set_gic_version(Object *obj, const char *value, Error **errp)
     }
 }
 
+static uint64_t virt_cpu_mp_affinity(ArmMachineState *ams, int idx)
+{
+    uint8_t clustersz = ARM_DEFAULT_CPUS_PER_CLUSTER;
+    ArmMachineClass *amc = ARM_MACHINE_GET_CLASS(ams);
+
+    if (!amc->disallow_affinity_adjustment) {
+        /* Adjust MPIDR like 64-bit KVM hosts, which incorporate the
+         * GIC's target-list limitations. 32-bit KVM hosts currently
+         * always create clusters of 4 CPUs, but that is expected to
+         * change when they gain support for gicv3. When KVM is enabled
+         * it will override the changes we make here, therefore our
+         * purposes are to make TCG consistent (with 64-bit KVM hosts)
+         * and to improve SGI efficiency.
+         */
+        if (ams->gic_version == 3) {
+            clustersz = GICV3_TARGETLIST_BITS;
+        } else {
+            clustersz = GIC_TARGETLIST_BITS;
+        }
+    }
+    return arm_cpu_mp_affinity(idx, clustersz);
+}
+
+
+static CpuInstanceProperties
+virt_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(ms);
+
+    assert(cpu_index < possible_cpus->len);
+    return possible_cpus->cpus[cpu_index].props;
+}
+
+
+static int64_t virt_get_default_cpu_node_id(const MachineState *ms, int idx)
+{
+    return idx % ms->numa_state->num_nodes;
+}
+
+static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
+{
+    int n;
+    unsigned int max_cpus = ms->smp.max_cpus;
+    ArmMachineState *ams = ARM_MACHINE(ms);
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
+            virt_cpu_mp_affinity(ams, n);
+        ms->possible_cpus->cpus[n].props.has_thread_id = true;
+        ms->possible_cpus->cpus[n].props.thread_id = n;
+    }
+    return ms->possible_cpus;
+}
+
 static void arm_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -555,6 +641,9 @@ static void arm_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
     mc->numa_mem_supported = true;
     mc->auto_enable_numa_with_memhp = true;
+    mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
+    mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
+    mc->possible_cpu_arch_ids = virt_possible_cpu_arch_ids;
 }
 
 static void arm_instance_init(Object *obj)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 2f498ea687..14d20d5c46 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -182,28 +182,6 @@ static const int a15irqmap[] = {
     [VIRT_PLATFORM_BUS] = 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS -1 */
 };
 
-static const char *valid_cpus[] = {
-    ARM_CPU_TYPE_NAME("cortex-a7"),
-    ARM_CPU_TYPE_NAME("cortex-a15"),
-    ARM_CPU_TYPE_NAME("cortex-a53"),
-    ARM_CPU_TYPE_NAME("cortex-a57"),
-    ARM_CPU_TYPE_NAME("cortex-a72"),
-    ARM_CPU_TYPE_NAME("host"),
-    ARM_CPU_TYPE_NAME("max"),
-};
-
-static bool cpu_type_valid(const char *cpu)
-{
-    int i;
-
-    for (i = 0; i < ARRAY_SIZE(valid_cpus); i++) {
-        if (strcmp(cpu, valid_cpus[i]) == 0) {
-            return true;
-        }
-    }
-    return false;
-}
-
 static void fdt_add_its_gic_node(VirtMachineState *vms)
 {
     char *nodename;
@@ -1030,30 +1008,6 @@ void virt_machine_done(Notifier *notifier, void *data)
     virt_build_smbios(vms);
 }
 
-static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
-{
-    uint8_t clustersz = ARM_DEFAULT_CPUS_PER_CLUSTER;
-    ArmMachineState *ams = ARM_MACHINE(vms);
-    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
-
-    if (!vmc->disallow_affinity_adjustment) {
-        /* Adjust MPIDR like 64-bit KVM hosts, which incorporate the
-         * GIC's target-list limitations. 32-bit KVM hosts currently
-         * always create clusters of 4 CPUs, but that is expected to
-         * change when they gain support for gicv3. When KVM is enabled
-         * it will override the changes we make here, therefore our
-         * purposes are to make TCG consistent (with 64-bit KVM hosts)
-         * and to improve SGI efficiency.
-         */
-        if (ams->gic_version == 3) {
-            clustersz = GICV3_TARGETLIST_BITS;
-        } else {
-            clustersz = GIC_TARGETLIST_BITS;
-        }
-    }
-    return arm_cpu_mp_affinity(idx, clustersz);
-}
-
 static void virt_set_memmap(VirtMachineState *vms)
 {
     MachineState *ms = MACHINE(vms);
@@ -1460,45 +1414,6 @@ static void virt_set_iommu(Object *obj, const char *value, Error **errp)
     }
 }
 
-static CpuInstanceProperties
-virt_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
-{
-    MachineClass *mc = MACHINE_GET_CLASS(ms);
-    const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(ms);
-
-    assert(cpu_index < possible_cpus->len);
-    return possible_cpus->cpus[cpu_index].props;
-}
-
-static int64_t virt_get_default_cpu_node_id(const MachineState *ms, int idx)
-{
-    return idx % ms->numa_state->num_nodes;
-}
-
-static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
-{
-    int n;
-    unsigned int max_cpus = ms->smp.max_cpus;
-    VirtMachineState *vms = VIRT_MACHINE(ms);
-
-    if (ms->possible_cpus) {
-        assert(ms->possible_cpus->len == max_cpus);
-        return ms->possible_cpus;
-    }
-
-    ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
-                                  sizeof(CPUArchId) * max_cpus);
-    ms->possible_cpus->len = max_cpus;
-    for (n = 0; n < ms->possible_cpus->len; n++) {
-        ms->possible_cpus->cpus[n].type = ms->cpu_type;
-        ms->possible_cpus->cpus[n].arch_id =
-            virt_cpu_mp_affinity(vms, n);
-        ms->possible_cpus->cpus[n].props.has_thread_id = true;
-        ms->possible_cpus->cpus[n].props.thread_id = n;
-    }
-    return ms->possible_cpus;
-}
-
 static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                  Error **errp)
 {
@@ -1624,9 +1539,6 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_AMD_XGBE);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_PLATFORM);
-    mc->possible_cpu_arch_ids = virt_possible_cpu_arch_ids;
-    mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
-    mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
     mc->kvm_type = virt_kvm_type;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
@@ -1833,10 +1745,11 @@ DEFINE_VIRT_MACHINE(2, 7)
 static void virt_machine_2_6_options(MachineClass *mc)
 {
     VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+    ArmMachineClass *amc = ARM_MACHINE_CLASS(OBJECT_CLASS(mc));
 
     virt_machine_2_7_options(mc);
     compat_props_add(mc->compat_props, hw_compat_2_6, hw_compat_2_6_len);
-    vmc->disallow_affinity_adjustment = true;
+    amc->disallow_affinity_adjustment = true;
     /* Disable PMU for 2.6 as PMU support was first introduced in 2.7 */
     vmc->no_pmu = true;
 }
diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
index 372f4dea28..37a419b784 100644
--- a/include/hw/arm/arm.h
+++ b/include/hw/arm/arm.h
@@ -86,6 +86,7 @@ typedef struct MemMapEntry {
 
 typedef struct {
     MachineClass parent;
+    bool disallow_affinity_adjustment;
     bool claim_edge_triggered_timers;
 } ArmMachineClass;
 
@@ -112,6 +113,8 @@ typedef struct {
 #define ARM_MACHINE_CLASS(klass) \
     OBJECT_CLASS_CHECK(ArmMachineClass, klass, TYPE_ARM_MACHINE)
 
+bool cpu_type_valid(const char *cpu);
+
 void create_fdt(ArmMachineState *ams);
 
 void fdt_add_timer_nodes(const ArmMachineState *ams);
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 8276e2c02c..aa66cd78d5 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -47,7 +47,6 @@ typedef enum VirtIOMMUType {
 
 typedef struct {
     ArmMachineClass parent;
-    bool disallow_affinity_adjustment;
     bool no_its;
     bool no_pmu;
     bool smbios_old_sys_ver;
-- 
2.18.1


