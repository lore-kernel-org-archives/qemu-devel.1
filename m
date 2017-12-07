Received: from eggs.gnu.org ([2001:4830:134:3::10]:38900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eN0hP-0008KO-CM
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 13:15:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eN0hO-0006ov-7A
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 13:15:07 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  7 Dec 2017 18:14:51 +0000
Message-Id: <1512670493-18114-5-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1512670493-18114-1-git-send-email-peter.maydell@linaro.org>
References: <1512670493-18114-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 4/6] target/arm: Add "-cpu max" support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Eduardo Habkost <ehabkost@redhat.com>, "Richard W . M . Jones" <rjones@redhat.com>

Add support for "-cpu max" for ARM guests. This CPU type behaves
like "-cpu host" when KVM is enabled, and like a system CPU with
the maximum possible feature set otherwise. (Note that this means
it won't be migratable across versions, as we will likely add
features to it in future.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-qom.h |  2 ++
 target/arm/cpu.c     | 24 ++++++++++++++++++++++++
 target/arm/cpu64.c   | 21 +++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
index a42495b..d135ff8 100644
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
index 9304277..190da97 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1628,6 +1628,27 @@ static void pxa270c5_initfn(Object *obj)
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
@@ -1691,6 +1712,9 @@ static const ARMCPUInfo arm_cpus[] = {
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
index 670c07a..38dcf32 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -28,6 +28,7 @@
 #include "hw/arm/arm.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
+#include "kvm_arm.h"
 
 static inline void set_feature(CPUARMState *env, int feature)
 {
@@ -212,6 +213,25 @@ static void aarch64_a53_initfn(Object *obj)
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
@@ -240,6 +260,7 @@ typedef struct ARMCPUInfo {
 static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "cortex-a57",         .initfn = aarch64_a57_initfn },
     { .name = "cortex-a53",         .initfn = aarch64_a53_initfn },
+    { .name = "max",                .initfn = aarch64_max_initfn },
 #ifdef CONFIG_USER_ONLY
     { .name = "any",         .initfn = aarch64_any_initfn },
 #endif
-- 
2.7.4
