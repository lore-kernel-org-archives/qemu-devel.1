Received: from eggs.gnu.org ([2001:4830:134:3::10]:59656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmv-0008SC-J8
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmt-00066q-BC
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:37 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1euLmt-00065e-2a
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:35 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1euLms-00077L-3Z
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 17:26:34 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Mar 2018 17:26:13 +0000
Message-Id: <20180309172622.4277-17-peter.maydell@linaro.org>
In-Reply-To: <20180309172622.4277-1-peter.maydell@linaro.org>
References: <20180309172622.4277-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/25] target/arm: Add "-cpu max" support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Add support for "-cpu max" for ARM guests. This CPU type behaves
like "-cpu host" when KVM is enabled, and like a system CPU with
the maximum possible feature set otherwise. (Note that this means
it won't be migratable across versions, as we will likely add
features to it in future.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20180308130626.12393-4-peter.maydell@linaro.org
---
 target/arm/cpu-qom.h |  2 ++
 target/arm/cpu.c     | 24 ++++++++++++++++++++++++
 target/arm/cpu64.c   | 21 +++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
index a42495bac9..d135ff8e06 100644
--- a/target/arm/cpu-qom.h
+++ b/target/arm/cpu-qom.h
@@ -33,6 +33,8 @@ struct arm_boot_info;
 #define ARM_CPU_GET_CLASS(obj) \
     OBJECT_GET_CLASS(ARMCPUClass, (obj), TYPE_ARM_CPU)
 
+#define TYPE_ARM_MAX_CPU "max-" TYPE_ARM_CPU
+
 /**
  * ARMCPUClass:
  * @parent_realize: The parent class' realize handler.
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5d76844981..2292ad91f6 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1702,6 +1702,27 @@ static void pxa270c5_initfn(Object *obj)
     cpu->reset_sctlr = 0x00000078;
 }
 
+#ifndef TARGET_AARCH64
+/* -cpu max: if KVM is enabled, like -cpu host (best possible with this host);
+ * otherwise, a CPU with as many features enabled as our emulation supports.
+ * The version of '-cpu max' for qemu-system-aarch64 is defined in cpu64.c;
+ * this only needs to handle 32 bits.
+ */
+static void arm_max_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    if (kvm_enabled()) {
+        kvm_arm_set_cpu_features_from_host(cpu);
+    } else {
+        cortex_a15_initfn(obj);
+        /* In future we might add feature bits here even if the
+         * real-world A15 doesn't implement them.
+         */
+    }
+}
+#endif
+
 #ifdef CONFIG_USER_ONLY
 static void arm_any_initfn(Object *obj)
 {
@@ -1769,6 +1790,9 @@ static const ARMCPUInfo arm_cpus[] = {
     { .name = "pxa270-b1",   .initfn = pxa270b1_initfn },
     { .name = "pxa270-c0",   .initfn = pxa270c0_initfn },
     { .name = "pxa270-c5",   .initfn = pxa270c5_initfn },
+#ifndef TARGET_AARCH64
+    { .name = "max",         .initfn = arm_max_initfn },
+#endif
 #ifdef CONFIG_USER_ONLY
     { .name = "any",         .initfn = arm_any_initfn },
 #endif
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index f12a485820..89b2f4eaed 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -28,6 +28,7 @@
 #include "hw/arm/arm.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
+#include "kvm_arm.h"
 
 static inline void set_feature(CPUARMState *env, int feature)
 {
@@ -214,6 +215,25 @@ static void aarch64_a53_initfn(Object *obj)
     define_arm_cp_regs(cpu, cortex_a57_a53_cp_reginfo);
 }
 
+/* -cpu max: if KVM is enabled, like -cpu host (best possible with this host);
+ * otherwise, a CPU with as many features enabled as our emulation supports.
+ * The version of '-cpu max' for qemu-system-arm is defined in cpu.c;
+ * this only needs to handle 64 bits.
+ */
+static void aarch64_max_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    if (kvm_enabled()) {
+        kvm_arm_set_cpu_features_from_host(cpu);
+    } else {
+        aarch64_a57_initfn(obj);
+        /* In future we might add feature bits here even if the
+         * real-world A57 doesn't implement them.
+         */
+    }
+}
+
 #ifdef CONFIG_USER_ONLY
 static void aarch64_any_initfn(Object *obj)
 {
@@ -249,6 +269,7 @@ typedef struct ARMCPUInfo {
 static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "cortex-a57",         .initfn = aarch64_a57_initfn },
     { .name = "cortex-a53",         .initfn = aarch64_a53_initfn },
+    { .name = "max",                .initfn = aarch64_max_initfn },
 #ifdef CONFIG_USER_ONLY
     { .name = "any",         .initfn = aarch64_any_initfn },
 #endif
-- 
2.16.2
