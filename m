Received: from eggs.gnu.org ([2001:4830:134:3::10]:58865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQO-0008TE-Nd
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:34:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQN-0001qB-KL
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:34:52 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fqIQN-0001pa-9g
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:34:51 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQM-0008Tr-DF
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:34:50 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 14:34:15 +0100
Message-Id: <20180816133438.17061-8-peter.maydell@linaro.org>
In-Reply-To: <20180816133438.17061-1-peter.maydell@linaro.org>
References: <20180816133438.17061-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/30] target/arm: Add sve-max-vq cpu property
 to -cpu max
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

This allows the default (and maximum) vector length to be set
from the command-line.  Which is extraordinarily helpful in
debugging problems depending on vector length without having to
bake knowledge of PR_SET_SVE_VL into every guest binary.

Cc: qemu-stable@nongnu.org (3.0.1)
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h     |  3 +++
 linux-user/syscall.c | 19 +++++++++++++------
 target/arm/cpu.c     |  6 +++---
 target/arm/cpu64.c   | 29 +++++++++++++++++++++++++++++
 target/arm/helper.c  |  7 +++++--
 5 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4289c33ef4c..a81f3d83cd2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -857,6 +857,9 @@ struct ARMCPU {
 
     /* Used to synchronize KVM and QEMU in-kernel device levels */
     uint8_t device_irq_level;
+
+    /* Used to set the maximum vector length the cpu will support.  */
+    uint32_t sve_max_vq;
 };
 
 static inline ARMCPU *arm_env_get_cpu(CPUARMState *env)
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index dfc851cc35f..5a4af76c032 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -10848,15 +10848,22 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_AARCH64
         case TARGET_PR_SVE_SET_VL:
-            /* We cannot support either PR_SVE_SET_VL_ONEXEC
-               or PR_SVE_VL_INHERIT.  Therefore, anything above
-               ARM_MAX_VQ results in EINVAL.  */
+            /*
+             * We cannot support either PR_SVE_SET_VL_ONEXEC or
+             * PR_SVE_VL_INHERIT.  Note the kernel definition
+             * of sve_vl_valid allows for VQ=512, i.e. VL=8192,
+             * even though the current architectural maximum is VQ=16.
+             */
             ret = -TARGET_EINVAL;
             if (arm_feature(cpu_env, ARM_FEATURE_SVE)
-                && arg2 >= 0 && arg2 <= ARM_MAX_VQ * 16 && !(arg2 & 15)) {
+                && arg2 >= 0 && arg2 <= 512 * 16 && !(arg2 & 15)) {
                 CPUARMState *env = cpu_env;
-                int old_vq = (env->vfp.zcr_el[1] & 0xf) + 1;
-                int vq = MAX(arg2 / 16, 1);
+                ARMCPU *cpu = arm_env_get_cpu(env);
+                uint32_t vq, old_vq;
+
+                old_vq = (env->vfp.zcr_el[1] & 0xf) + 1;
+                vq = MAX(arg2 / 16, 1);
+                vq = MIN(vq, cpu->sve_max_vq);
 
                 if (vq < old_vq) {
                     aarch64_sve_narrow_vq(env, vq);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 3848ef46aa9..a4d46db13ae 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -168,9 +168,9 @@ static void arm_cpu_reset(CPUState *s)
         env->cp15.cpacr_el1 = deposit64(env->cp15.cpacr_el1, 16, 2, 3);
         env->cp15.cptr_el[3] |= CPTR_EZ;
         /* with maximum vector length */
-        env->vfp.zcr_el[1] = ARM_MAX_VQ - 1;
-        env->vfp.zcr_el[2] = ARM_MAX_VQ - 1;
-        env->vfp.zcr_el[3] = ARM_MAX_VQ - 1;
+        env->vfp.zcr_el[1] = cpu->sve_max_vq - 1;
+        env->vfp.zcr_el[2] = env->vfp.zcr_el[1];
+        env->vfp.zcr_el[3] = env->vfp.zcr_el[1];
 #else
         /* Reset into the highest available EL */
         if (arm_feature(env, ARM_FEATURE_EL3)) {
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index d0581d59d82..800bff780e2 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -29,6 +29,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
 #include "kvm_arm.h"
+#include "qapi/visitor.h"
 
 static inline void set_feature(CPUARMState *env, int feature)
 {
@@ -217,6 +218,29 @@ static void aarch64_a53_initfn(Object *obj)
     define_arm_cp_regs(cpu, cortex_a57_a53_cp_reginfo);
 }
 
+static void cpu_max_get_sve_vq(Object *obj, Visitor *v, const char *name,
+                               void *opaque, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    visit_type_uint32(v, name, &cpu->sve_max_vq, errp);
+}
+
+static void cpu_max_set_sve_vq(Object *obj, Visitor *v, const char *name,
+                               void *opaque, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    Error *err = NULL;
+
+    visit_type_uint32(v, name, &cpu->sve_max_vq, &err);
+
+    if (!err && (cpu->sve_max_vq == 0 || cpu->sve_max_vq > ARM_MAX_VQ)) {
+        error_setg(&err, "unsupported SVE vector length");
+        error_append_hint(&err, "Valid sve-max-vq in range [1-%d]\n",
+                          ARM_MAX_VQ);
+    }
+    error_propagate(errp, err);
+}
+
 /* -cpu max: if KVM is enabled, like -cpu host (best possible with this host);
  * otherwise, a CPU with as many features enabled as our emulation supports.
  * The version of '-cpu max' for qemu-system-arm is defined in cpu.c;
@@ -253,6 +277,10 @@ static void aarch64_max_initfn(Object *obj)
         cpu->ctr = 0x80038003; /* 32 byte I and D cacheline size, VIPT icache */
         cpu->dcz_blocksize = 7; /*  512 bytes */
 #endif
+
+        cpu->sve_max_vq = ARM_MAX_VQ;
+        object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_vq,
+                            cpu_max_set_sve_vq, NULL, NULL, &error_fatal);
     }
 }
 
@@ -405,6 +433,7 @@ void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq)
     uint64_t pmask;
 
     assert(vq >= 1 && vq <= ARM_MAX_VQ);
+    assert(vq <= arm_env_get_cpu(env)->sve_max_vq);
 
     /* Zap the high bits of the zregs.  */
     for (i = 0; i < 32; i++) {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8b07bf214ec..873a0c215db 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12437,9 +12437,12 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
             zcr_len = 0;
         } else {
             int current_el = arm_current_el(env);
+            ARMCPU *cpu = arm_env_get_cpu(env);
 
-            zcr_len = env->vfp.zcr_el[current_el <= 1 ? 1 : current_el];
-            zcr_len &= 0xf;
+            zcr_len = cpu->sve_max_vq - 1;
+            if (current_el <= 1) {
+                zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[1]);
+            }
             if (current_el < 2 && arm_feature(env, ARM_FEATURE_EL2)) {
                 zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[2]);
             }
-- 
2.18.0
