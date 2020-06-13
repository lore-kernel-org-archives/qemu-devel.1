Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9EDC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 21:51:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ADB720792
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 21:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ADB720792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkE3P-0006e8-Cf
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 17:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jkDxM-0005Vd-J1; Sat, 13 Jun 2020 17:44:53 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60708 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jkDxH-00037G-SN; Sat, 13 Jun 2020 17:44:51 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 6697AA3006FAB5AE2476;
 Sun, 14 Jun 2020 05:44:45 +0800 (CST)
Received: from A190218597.china.huawei.com (10.47.30.60) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Sun, 14 Jun 2020 05:44:35 +0800
From: Salil Mehta <salil.mehta@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: [PATCH RFC 04/22] arm/cpuhp: Machine init time change common to vcpu
 {cold|hot}-plug
Date: Sat, 13 Jun 2020 22:36:11 +0100
Message-ID: <20200613213629.21984-5-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20200613213629.21984-1-salil.mehta@huawei.com>
References: <20200613213629.21984-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.30.60]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35;
 envelope-from=salil.mehta@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/13 17:44:26
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, sudeep.holla@arm.com,
 gshan@redhat.com, mst@redhat.com, jiakernel2@gmail.com, maz@kernel.org,
 zhukeqian1@huawei.com, david@redhat.com, richard.henderson@linaro.org,
 linuxarm@huawei.com, eric.auger@redhat.com, james.morse@arm.com,
 catalin.marinas@arm.com, imammedo@redhat.com,
 Salil Mehta <salil.mehta@huawei.com>, pbonzini@redhat.com,
 mehta.salil.lnk@gmail.com, maran.wilson@oracle.com, will@kernel.org,
 wangxiongfeng2@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This refactors (+) introduces the common logic required during the
initialization of both cold and hot plugged vcpus. This also initializes the
*disabled* state of the vcpus which shall be used further during init phases
of various other components like GIC, PMU, ACPI etc as part of the virt machine
initialization.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/arm/virt.c         | 250 +++++++++++++++++++++++++++++++++---------
 include/hw/arm/virt.h |   2 +
 target/arm/cpu.c      |   7 ++
 target/arm/cpu64.c    |   9 ++
 4 files changed, 214 insertions(+), 54 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index c4ed955776..184bed8716 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -203,6 +203,8 @@ static const char *valid_cpus[] = {
     ARM_CPU_TYPE_NAME("max"),
 };
 
+static CPUArchId *virt_find_cpu_slot(MachineState *ms, int vcpuid);
+
 static bool cpu_type_valid(const char *cpu)
 {
     int i;
@@ -1657,6 +1659,62 @@ static void finalize_gic_version(VirtMachineState *vms)
     }
 }
 
+static void virt_cpu_set_properties(Object *cpuobj, const CPUArchId *cpu_slot)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    MemoryRegion *sysmem = get_system_memory();
+    VirtMachineState *vms = VIRT_MACHINE(ms);
+    uint64_t mp_affinity = cpu_slot->arch_id;
+    CPUState *cs = CPU(cpuobj);
+    VirtMachineClass *vmc;
+
+    vmc = VIRT_MACHINE_GET_CLASS(ms);
+
+    /* now, set the cpu object property values */
+    object_property_set_int(cpuobj, mp_affinity, "mp-affinity", NULL);
+
+    numa_cpu_pre_plug(cpu_slot, DEVICE(cpuobj), &error_fatal);
+
+    if (!vms->secure) {
+        object_property_set_bool(cpuobj, false, "has_el3", NULL);
+    }
+
+    if (!vms->virt && object_property_find(cpuobj, "has_el2", NULL)) {
+        object_property_set_bool(cpuobj, false, "has_el2", NULL);
+    }
+
+    if (vms->psci_conduit != QEMU_PSCI_CONDUIT_DISABLED) {
+        object_property_set_int(cpuobj, vms->psci_conduit, "psci-conduit",
+                                NULL);
+        /* Secondary CPUs start in PSCI powered-down state */
+        if (cs->cpu_index > 0)
+            object_property_set_bool(cpuobj, true, "start-powered-off",
+                                     NULL);
+    }
+
+    if (vmc->kvm_no_adjvtime &&
+        object_property_find(cpuobj, "kvm-no-adjvtime", NULL)) {
+        object_property_set_bool(cpuobj, true, "kvm-no-adjvtime", NULL);
+    }
+
+    if (vmc->no_pmu && object_property_find(cpuobj, "pmu", NULL)) {
+        object_property_set_bool(cpuobj, false, "pmu", NULL);
+    }
+
+    if (object_property_find(cpuobj, "reset-cbar", NULL)) {
+        object_property_set_int(cpuobj, vms->memmap[VIRT_CPUPERIPHS].base,
+                                "reset-cbar", &error_abort);
+    }
+
+    object_property_set_link(cpuobj, OBJECT(sysmem), "memory",
+                             &error_abort);
+
+    if (vms->secure) {
+        object_property_set_link(cpuobj, OBJECT(vms->secure_sysmem),
+                                 "secure-memory", &error_abort);
+    }
+}
+
 static void machvirt_init(MachineState *machine)
 {
     VirtMachineState *vms = VIRT_MACHINE(machine);
@@ -1706,6 +1764,7 @@ static void machvirt_init(MachineState *machine)
         memory_region_init(secure_sysmem, OBJECT(machine), "secure-memory",
                            UINT64_MAX);
         memory_region_add_subregion_overlap(secure_sysmem, 0, sysmem, -1);
+        vms->secure_sysmem = secure_sysmem;
     }
 
     firmware_loaded = virt_firmware_init(vms, sysmem,
@@ -1749,6 +1808,14 @@ static void machvirt_init(MachineState *machine)
     }
 
     vms->smp_cpus = smp_cpus;
+    vms->max_cpus = max_cpus;
+    if (vms->gic_version < VIRT_GIC_VERSION_3) {
+        warn_report("For GICv%d max-cpus must be equal to smp-cpus",
+                    vms->gic_version);
+        warn_report("Overriding specified max-cpus(%d) with smp-cpus(%d)",
+                     max_cpus, smp_cpus);
+        vms->max_cpus = smp_cpus;
+    }
 
     if (vms->virt && kvm_enabled()) {
         error_report("mach-virt: KVM does not support providing "
@@ -1761,65 +1828,12 @@ static void machvirt_init(MachineState *machine)
     possible_cpus = mc->possible_cpu_arch_ids(machine);
     for (n = 0; n < possible_cpus->len; n++) {
         Object *cpuobj;
-        CPUState *cs;
-
-        if (n >= smp_cpus) {
-            break;
-        }
 
         cpuobj = object_new(possible_cpus->cpus[n].type);
-        object_property_set_int(cpuobj, possible_cpus->cpus[n].arch_id,
-                                "mp-affinity", NULL);
-
-        cs = CPU(cpuobj);
-        cs->cpu_index = n;
-
-        numa_cpu_pre_plug(&possible_cpus->cpus[cs->cpu_index], DEVICE(cpuobj),
-                          &error_fatal);
 
         aarch64 &= object_property_get_bool(cpuobj, "aarch64", NULL);
         object_property_set_int(cpuobj, n, "core-id", NULL);
 
-        if (!vms->secure) {
-            object_property_set_bool(cpuobj, false, "has_el3", NULL);
-        }
-
-        if (!vms->virt && object_property_find(cpuobj, "has_el2", NULL)) {
-            object_property_set_bool(cpuobj, false, "has_el2", NULL);
-        }
-
-        if (vms->psci_conduit != QEMU_PSCI_CONDUIT_DISABLED) {
-            object_property_set_int(cpuobj, vms->psci_conduit,
-                                    "psci-conduit", NULL);
-
-            /* Secondary CPUs start in PSCI powered-down state */
-            if (n > 0) {
-                object_property_set_bool(cpuobj, true,
-                                         "start-powered-off", NULL);
-            }
-        }
-
-        if (vmc->kvm_no_adjvtime &&
-            object_property_find(cpuobj, "kvm-no-adjvtime", NULL)) {
-            object_property_set_bool(cpuobj, true, "kvm-no-adjvtime", NULL);
-        }
-
-        if (vmc->no_pmu && object_property_find(cpuobj, "pmu", NULL)) {
-            object_property_set_bool(cpuobj, false, "pmu", NULL);
-        }
-
-        if (object_property_find(cpuobj, "reset-cbar", NULL)) {
-            object_property_set_int(cpuobj, vms->memmap[VIRT_CPUPERIPHS].base,
-                                    "reset-cbar", &error_abort);
-        }
-
-        object_property_set_link(cpuobj, OBJECT(sysmem), "memory",
-                                 &error_abort);
-        if (vms->secure) {
-            object_property_set_link(cpuobj, OBJECT(secure_sysmem),
-                                     "secure-memory", &error_abort);
-        }
-
         object_property_set_bool(cpuobj, true, "realized", &error_fatal);
         object_unref(cpuobj);
     }
@@ -2106,6 +2120,71 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
     return ms->possible_cpus;
 }
 
+static int virt_archid_cmp(const void *a, const void *b)
+{
+   CPUArchId *archid_a = (CPUArchId *)a;
+   CPUArchId *archid_b = (CPUArchId *)b;
+
+   return archid_a->arch_id - archid_b->arch_id;
+}
+
+static CPUArchId *virt_find_cpu_slot(MachineState *ms, int vcpuid)
+{
+    VirtMachineState *vms = VIRT_MACHINE(ms);
+    CPUArchId arch_id, *found_cpu;
+    uint64_t mp_affinity;
+
+    mp_affinity = virt_cpu_mp_affinity(vms, vcpuid);
+    arch_id.arch_id = mp_affinity;
+    found_cpu = bsearch(&arch_id, ms->possible_cpus->cpus,
+                        ms->possible_cpus->len,
+                        sizeof(*ms->possible_cpus->cpus), virt_archid_cmp);
+
+    assert (found_cpu);
+
+    /*
+     * RFC: Question:
+     * For KVM/TCG, MPIDR for vcpu is derived using vcpu-id.
+     * In fact, as of now there is a linear relation between
+     * vcpu-id and mpidr(see below fig.) as derived in host
+     * kvm. Slot-id is the index where vcpu with certain
+     * arch-id(=mpidr/ap-affinity) is plugged.
+     *
+     * Therefore, for now we could use the vcpu-id as slot
+     * index for getting CPUArchId of the vcpu coresponding
+     * to this slot(this view is not perfectly consistent
+     * with the ARM specification view of MPIDR_EL1).
+     * QEMU/KVM view of cpu topology makes it bit difficult
+     * to use topo-info(pkg-id, core-id, thread-id) with
+     * device_add/-device interface which might not match
+     * with what actual underlying host cpu supports.
+     * therefore question is do we care about this? and
+     * is it okay to have view of thread-id inconsistent
+     * with the host cpu? How should QEMU create PPTT
+     * for the Guest?
+     *
+     *          +----+----+----+----+----+----+----+----+
+     * MASK     |  F    F |  F   F  |  F   F  |  0   F  |
+     *          +----+----+----+----+----+----+----+----+
+     *
+     *          |         | cluster | cluster |    |core|
+     *          |<---------Package-id-------->|    |core|
+     *
+     *          +----+----+----+----+----+----+----+----+
+     * MPIDR    |||  Res  |   Aff2  |   Aff1  |  Aff0   |
+     *          +----+----+----+----+----+----+----+----+
+     *                     \         \         \   |    |
+     *                      \   8bit  \   8bit  \  |4bit|
+     *                       \<------->\<------->\ |<-->|
+     *                        \         \         \|    |
+     *          +----+----+----+----+----+----+----+----+
+     * VCPU-ID  |  Byte4  |  Byte2  |  Byte1  |  Byte0  |
+     *          +----+----+----+----+----+----+----+----+
+     */
+
+    return found_cpu;
+}
+
 static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                  Error **errp)
 {
@@ -2151,11 +2230,71 @@ out:
     error_propagate(errp, local_err);
 }
 
+static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
+                              Error **errp)
+{
+    MachineState *ms = MACHINE(hotplug_dev);
+    ARMCPU *cpu = ARM_CPU(dev);
+    CPUState *cs = CPU(dev);
+    CPUArchId *cpu_slot;
+
+    /* sanity check the cpu */
+    if (!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
+        error_setg(errp, "Invalid CPU type, expected cpu type: '%s'",
+                   ms->cpu_type);
+        return;
+    }
+
+    if ((cpu->core_id < 0) || (cpu->core_id >= ms->possible_cpus->len)) {
+        error_setg(errp, "Invalid core-id %u specified, must be in range 1:%u",
+                   cpu->core_id, ms->possible_cpus->len - 1);
+        return;
+    }
+
+    /*
+     * RFC: Question:
+     * For now we are not taking into account of other topo info like
+     * thread-id, socket-id to generate arch-id/mp-affinity.
+     * The way KVM/Host generates mpidr value and the way ARM spec
+     * identifies uniquely cpu within the heirarchy is bit inconsistent.
+     * Perhaps needs more discussion on this? Hence, directly using
+     * core_id as cpu_index for now. Ideally, slot-index found out using
+     * the topo info should have been the cpu-index.
+     */
+    cs->cpu_index = cpu->core_id;
+
+    cpu_slot = virt_find_cpu_slot(ms, cpu->core_id);
+    if (qemu_present_cpu(CPU(cpu_slot->cpu))) {
+        error_setg(errp, "cpu %d with arch-id %" PRIu64 " exists",
+                   cpu->core_id, cpu_slot->arch_id);
+        return;
+    }
+    virt_cpu_set_properties(OBJECT(cs), cpu_slot);
+}
+
+static void virt_cpu_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
+                          Error **errp)
+{
+    MachineState *ms = MACHINE(hotplug_dev);
+    ARMCPU *cpu = ARM_CPU(dev);
+    CPUState *cs = CPU(dev);
+    CPUArchId *cpu_slot;
+
+    /* insert the cold/hot-plugged vcpu in the slot */
+    cpu_slot = virt_find_cpu_slot(ms, cpu->core_id);
+    cpu_slot->cpu = OBJECT(dev);
+
+    cs->disabled = false;
+    return;
+}
+
 static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
                                             DeviceState *dev, Error **errp)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         virt_memory_pre_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
+        virt_cpu_pre_plug(hotplug_dev, dev, errp);
     }
 }
 
@@ -2172,6 +2311,8 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
     }
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         virt_memory_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
+        virt_cpu_plug(hotplug_dev, dev, errp);
     }
     if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
         PCIDevice *pdev = PCI_DEVICE(dev);
@@ -2193,7 +2334,8 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
                                                         DeviceState *dev)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE) ||
-       (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM))) {
+       (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) ||
+       (object_dynamic_cast(OBJECT(dev), TYPE_CPU))){
         return HOTPLUG_HANDLER(machine);
     }
     if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 31878ddc72..5b8ba64ec2 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -127,6 +127,7 @@ typedef struct {
     DeviceState *platform_bus_dev;
     FWCfgState *fw_cfg;
     PFlashCFI01 *flash[2];
+    MemoryRegion *secure_sysmem;
     bool secure;
     bool highmem;
     bool highmem_ecam;
@@ -142,6 +143,7 @@ typedef struct {
     char *pciehb_nodename;
     const int *irqmap;
     int smp_cpus;
+    int max_cpus;
     void *fdt;
     int fdt_size;
     uint32_t clock_phandle;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 33a58086a9..0c9f5f970e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2131,6 +2131,12 @@ static gchar *arm_gdb_arch_name(CPUState *cs)
     return g_strdup("arm");
 }
 
+static int64_t arm_cpu_get_arch_id(CPUState *cs)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    return cpu->mp_affinity;
+}
+
 static void arm_cpu_class_init(ObjectClass *oc, void *data)
 {
     ARMCPUClass *acc = ARM_CPU_CLASS(oc);
@@ -2147,6 +2153,7 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
     cc->has_work = arm_cpu_has_work;
     cc->cpu_exec_interrupt = arm_cpu_exec_interrupt;
     cc->dump_state = arm_cpu_dump_state;
+    cc->get_arch_id = arm_cpu_get_arch_id;
     cc->set_pc = arm_cpu_set_pc;
     cc->synchronize_from_tb = arm_cpu_synchronize_from_tb;
     cc->gdb_read_register = arm_cpu_gdb_read_register;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index cbc5c3868f..41e69cd53f 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -766,11 +766,18 @@ static void aarch64_cpu_set_aarch64(Object *obj, bool value, Error **errp)
 
 static void aarch64_cpu_initfn(Object *obj)
 {
+    CPUState *cs = CPU(obj);
+
     object_property_add_bool(obj, "aarch64", aarch64_cpu_get_aarch64,
                              aarch64_cpu_set_aarch64);
     object_property_set_description(obj, "aarch64",
                                     "Set on/off to enable/disable aarch64 "
                                     "execution state ");
+    /*
+     * we start every ARM64 vcpu as disabled possible vcpu. It needs to be
+     * enabled explicitly
+     */
+    cs->disabled = true;
 }
 
 static void aarch64_cpu_finalizefn(Object *obj)
@@ -785,7 +792,9 @@ static gchar *aarch64_gdb_arch_name(CPUState *cs)
 static void aarch64_cpu_class_init(ObjectClass *oc, void *data)
 {
     CPUClass *cc = CPU_CLASS(oc);
+    DeviceClass *dc = DEVICE_CLASS(oc);
 
+    dc->user_creatable = true;
     cc->cpu_exec_interrupt = arm_cpu_exec_interrupt;
     cc->gdb_read_register = aarch64_cpu_gdb_read_register;
     cc->gdb_write_register = aarch64_cpu_gdb_write_register;
-- 
2.17.1



