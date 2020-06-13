Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44314C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 21:48:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CA6B20789
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 21:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA6B20789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkE0j-00023o-8d
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 17:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jkDxP-0005Wc-Pj; Sat, 13 Jun 2020 17:44:55 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43308 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jkDxM-00037Y-Ti; Sat, 13 Jun 2020 17:44:55 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 73BE68C24A74F8661BE4;
 Sun, 14 Jun 2020 05:44:50 +0800 (CST)
Received: from A190218597.china.huawei.com (10.47.30.60) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Sun, 14 Jun 2020 05:44:41 +0800
From: Salil Mehta <salil.mehta@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: [PATCH RFC 05/22] arm/cpuhp: Pre-create disabled possible vcpus
 @machine init
Date: Sat, 13 Jun 2020 22:36:12 +0100
Message-ID: <20200613213629.21984-6-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20200613213629.21984-1-salil.mehta@huawei.com>
References: <20200613213629.21984-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.30.60]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32;
 envelope-from=salil.mehta@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/13 17:44:20
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

In ARMv8 architecture, GIC needs all the vcpus to be created and present when
it is initialized. This is because:
1. GICC and MPIDR association must be fixed at the VM initialization time.
   This is represented by register GIC_TYPER(mp_afffinity, proc_num)
2. GICC(cpu interfaces), GICR(redistributors) etc all must be initialized
   at the boot time as well.
3. Memory regions associated with GICR etc. cannot be changed(add/del/mod)
   after VM has inited.

This patch adds the support to pre-create all such possible vcpus within the
host using the KVM interface as part of the virt machine initialization. These
vcpus could later be attached to QOM/ACPI while they are actually hot plugged
and made present.

NOTE: There is some refactoring related to the kvm_destroy_vcpu/kvm_get_vcpu
      (to make use of the common code) has been intentionaly left out in RFC
      version to avoid obscuring the framework change of the cpu hotplug. The
      existing code being presented in this patch could further be optimized
      later.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 accel/kvm/kvm-all.c  | 31 +++++++++++++++++++++++++++++
 hw/arm/virt.c        | 46 ++++++++++++++++++++++++++++++++++++++++++--
 include/sysemu/kvm.h |  2 ++
 target/arm/kvm.c     | 32 ++++++++++++++++++++++++++++++
 target/arm/kvm_arm.h | 11 +++++++++++
 5 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d06cc04079..8e1c7b3d13 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -329,6 +329,37 @@ err:
     return ret;
 }
 
+void kvm_park_vcpu(CPUState *cs)
+{
+    unsigned long vcpu_id = cs->cpu_index;
+    struct KVMParkedVcpu *vcpu;
+
+    vcpu = g_malloc0(sizeof(*vcpu));
+    vcpu->vcpu_id = vcpu_id;
+    vcpu->kvm_fd = cs->kvm_fd;
+    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
+}
+
+int kvm_create_vcpu(CPUState *cpu)
+{
+    unsigned long vcpu_id = cpu->cpu_index;
+    KVMState *s = kvm_state;
+    int ret = 0;
+
+    DPRINTF("kvm_create_vcpu\n");
+
+    ret = kvm_vm_ioctl(s, KVM_CREATE_VCPU, (void *)vcpu_id);
+    if (ret < 0) {
+        goto err;
+    }
+    cpu->kvm_fd = ret;
+    cpu->kvm_state = s;
+    cpu->vcpu_dirty = true;
+
+err:
+    return ret;
+}
+
 int kvm_destroy_vcpu(CPUState *cpu)
 {
     KVMState *s = kvm_state;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 184bed8716..8040473d30 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1828,14 +1828,56 @@ static void machvirt_init(MachineState *machine)
     possible_cpus = mc->possible_cpu_arch_ids(machine);
     for (n = 0; n < possible_cpus->len; n++) {
         Object *cpuobj;
+        CPUState *cs;
 
         cpuobj = object_new(possible_cpus->cpus[n].type);
+        cs = CPU(cpuobj);
 
         aarch64 &= object_property_get_bool(cpuobj, "aarch64", NULL);
         object_property_set_int(cpuobj, n, "core-id", NULL);
 
-        object_property_set_bool(cpuobj, true, "realized", &error_fatal);
-        object_unref(cpuobj);
+        if (n < vms->smp_cpus) {
+            char *core_id = g_strdup_printf("core%d", n);
+            qdev_set_id(DEVICE(cpuobj),core_id);
+            object_property_set_bool(cpuobj, true, "realized", &error_fatal);
+            g_free(core_id);
+            object_unref(OBJECT(cs));
+        } else {
+            CPUArchId *cpu_slot;
+            /* handling for vcpus which are yet to be hot-plugged */
+            cs->cpu_index = n;
+            /* ARM host vcpu features need to be fixed at the boot time */
+            virt_cpu_set_properties(cpuobj, &possible_cpus->cpus[n]);
+            /*
+             * For KVM, we shall be pre-creating the now disabled/un-plugged
+             * possbile host vcpus and park them till the time they are
+             * actually hot plugged. This is required to pre-size the host
+             * GICC and GICR with the all possible vcpus for this VM.
+             */
+            if (kvm_enabled()) {
+               kvm_arm_create_host_vcpu(ARM_CPU(cs));
+            }
+            /*
+             * Add disabled vcpu to cpu slot during the init phase of the virt machine.
+             * 1. We need this ARMCPU object during the GIC init. This object
+             *    will facilitate in pre-realizing the gic. Any info like
+             *    mp-affinity(required to derive gicr_type) etc could still be
+             *    fetched while preserving QOM abstraction akin to realized
+             *    vcpus.
+             * 2. Now, after initialization of the virt machine is complete we could use
+             *    two approaches to deal with this ARMCPU object:
+             *    (i) re-use this ARMCPU object during hotplug of this vcpu.
+             *                             OR
+             *    (ii) defer release this ARMCPU object after gic has been
+             *         initialized or during pre-plug phase when a vcpu is
+             *         hotplugged.
+             *
+             *    We will use the (ii) approach and release the ARMCPU objects after GIC
+             *    and machine has been initialized in machine_init_done() phase
+             */
+             cpu_slot = virt_find_cpu_slot(machine, cs->cpu_index);
+             cpu_slot->cpu = OBJECT(cs);
+        }
     }
     fdt_add_timer_nodes(vms);
     fdt_add_cpu_nodes(vms);
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 3b2250471c..ca06bfeb17 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -218,7 +218,9 @@ int kvm_has_intx_set_mask(void);
 
 int kvm_init_vcpu(CPUState *cpu);
 int kvm_cpu_exec(CPUState *cpu);
+int kvm_create_vcpu(CPUState *cpu);
 int kvm_destroy_vcpu(CPUState *cpu);
+void kvm_park_vcpu(CPUState *cs);
 
 /**
  * kvm_arm_supports_user_irq
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 4bdbe6dcac..9fd447d111 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -597,6 +597,38 @@ void kvm_arm_reset_vcpu(ARMCPU *cpu)
     write_list_to_cpustate(cpu);
 }
 
+void kvm_arm_create_host_vcpu(ARMCPU *cpu)
+{
+    CPUState *cs = CPU(cpu);
+    unsigned long vcpu_id = cs->cpu_index;
+    int ret;
+
+    ret = kvm_create_vcpu(cs);
+    if (ret < 0) {
+        error_report("Failed to create host vcpu %ld", vcpu_id);
+        abort();
+    }
+
+    /*
+     * Initialize the vcpu in the host. This will reset the sys regs
+     * for this vcpu and related registers like MPIDR_EL1 etc. also
+     * gets programmed during this call to host. These are referred
+     * later while setting device attributes of the GICR during GICv3
+     * reset
+     */
+    ret = kvm_arch_init_vcpu(cs);
+    if (ret < 0) {
+        error_report("Failed to initialize host vcpu %ld", vcpu_id);
+        abort();
+    }
+
+    /*
+     * park the created vcpu. shall be used during kvm_get_vcpu() when
+     * threads are created during realization of ARM vcpus
+     */
+    kvm_park_vcpu(cs);
+}
+
 /*
  * Update KVM's MP_STATE based on what QEMU thinks it is
  */
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 48bf5e16d5..a9e316cfee 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -155,6 +155,17 @@ void kvm_arm_cpu_post_load(ARMCPU *cpu);
  */
 void kvm_arm_reset_vcpu(ARMCPU *cpu);
 
+/**
+ * kvm_arm_create_host_vcpu:
+ * @cpu: ARMCPU
+ *
+ * Called at to pre create all possible kvm vcpus within the the host at the
+ * virt machine init time. This will also init this pre-created vcpu and
+ * hence result in vcpu reset at host. These pre created and inited vcpus
+ * shall be parked for use when ARM vcpus are actually realized.
+ */
+void kvm_arm_create_host_vcpu(ARMCPU *cpu);
+
 /**
  * kvm_arm_init_serror_injection:
  * @cs: CPUState
-- 
2.17.1



