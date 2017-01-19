Received: from eggs.gnu.org ([2001:4830:134:3::10]:47710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPx-00014m-1h
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPp-0005BF-Qg
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:20 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cUDPp-00059u-Ih
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:13 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPo-0003GQ-O6
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:10:12 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 14:09:54 +0000
Message-Id: <1484834995-26826-36-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
References: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 35/36] target-arm: Enable EL2 feature bit on A53
 and A57
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Enable the ARM_FEATURE_EL2 bit on Cortex-A52 and
Cortex-A57, since this is all now sufficiently implemented
to work with the GICv3. We provide the usual CPU property
to disable it for backwards compatibility with the older
virt boards.

In this commit, we disable the EL2 feature on the
virt and ZynpMP boards, so there is no overall effect.
Another commit will expose a board-level property to
allow the user to enable EL2.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 1483977924-14522-18-git-send-email-peter.maydell@linaro.org
---
 target/arm/cpu.h     |  2 ++
 hw/arm/virt.c        |  4 ++++
 hw/arm/xlnx-zynqmp.c |  2 ++
 target/arm/cpu.c     | 12 ++++++++++++
 target/arm/cpu64.c   |  2 ++
 5 files changed, 22 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 16c7c10..151a5d7 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -577,6 +577,8 @@ struct ARMCPU {
     bool start_powered_off;
     /* CPU currently in PSCI powered-off state */
     bool powered_off;
+    /* CPU has virtualization extension */
+    bool has_el2;
     /* CPU has security extension */
     bool has_el3;
     /* CPU has PMU (Performance Monitor Unit) */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3a6f895..769afa0 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1328,6 +1328,10 @@ static void machvirt_init(MachineState *machine)
             object_property_set_bool(cpuobj, false, "has_el3", NULL);
         }
 
+        if (object_property_find(cpuobj, "has_el2", NULL)) {
+            object_property_set_bool(cpuobj, false, "has_el2", NULL);
+        }
+
         if (vms->psci_conduit != QEMU_PSCI_CONDUIT_DISABLED) {
             object_property_set_int(cpuobj, vms->psci_conduit,
                                     "psci-conduit", NULL);
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 0d86ba3..bc4e66b 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -258,6 +258,8 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
 
         object_property_set_bool(OBJECT(&s->apu_cpu[i]),
                                  s->secure, "has_el3", NULL);
+        object_property_set_bool(OBJECT(&s->apu_cpu[i]),
+                                 false, "has_el2", NULL);
         object_property_set_int(OBJECT(&s->apu_cpu[i]), GIC_BASE_ADDR,
                                 "reset-cbar", &error_abort);
         object_property_set_bool(OBJECT(&s->apu_cpu[i]), true, "realized",
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 93ebbc9..3f2cdb6 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -496,6 +496,9 @@ static Property arm_cpu_reset_hivecs_property =
 static Property arm_cpu_rvbar_property =
             DEFINE_PROP_UINT64("rvbar", ARMCPU, rvbar, 0);
 
+static Property arm_cpu_has_el2_property =
+            DEFINE_PROP_BOOL("has_el2", ARMCPU, has_el2, true);
+
 static Property arm_cpu_has_el3_property =
             DEFINE_PROP_BOOL("has_el3", ARMCPU, has_el3, true);
 
@@ -546,6 +549,11 @@ static void arm_cpu_post_init(Object *obj)
 #endif
     }
 
+    if (arm_feature(&cpu->env, ARM_FEATURE_EL2)) {
+        qdev_property_add_static(DEVICE(obj), &arm_cpu_has_el2_property,
+                                 &error_abort);
+    }
+
     if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
         qdev_property_add_static(DEVICE(obj), &arm_cpu_has_pmu_property,
                                  &error_abort);
@@ -694,6 +702,10 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         cpu->id_aa64pfr0 &= ~0xf000;
     }
 
+    if (!cpu->has_el2) {
+        unset_feature(env, ARM_FEATURE_EL2);
+    }
+
     if (!cpu->has_pmu || !kvm_enabled()) {
         cpu->has_pmu = false;
         unset_feature(env, ARM_FEATURE_PMU);
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 73c7f31..670c07a 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -110,6 +110,7 @@ static void aarch64_a57_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8_SHA256);
     set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
     set_feature(&cpu->env, ARM_FEATURE_CRC);
+    set_feature(&cpu->env, ARM_FEATURE_EL2);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
     set_feature(&cpu->env, ARM_FEATURE_PMU);
     cpu->kvm_target = QEMU_KVM_ARM_TARGET_CORTEX_A57;
@@ -169,6 +170,7 @@ static void aarch64_a53_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8_SHA256);
     set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
     set_feature(&cpu->env, ARM_FEATURE_CRC);
+    set_feature(&cpu->env, ARM_FEATURE_EL2);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
     set_feature(&cpu->env, ARM_FEATURE_PMU);
     cpu->kvm_target = QEMU_KVM_ARM_TARGET_CORTEX_A53;
-- 
2.7.4
