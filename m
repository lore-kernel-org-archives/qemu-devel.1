Received: from eggs.gnu.org ([2001:4830:134:3::10]:37849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fnbok-0006r1-HS
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:40:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fnboj-0003G7-D1
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:40:54 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fnboj-0003Fh-5D
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:40:53 -0400
Received: by mail-pf1-x444.google.com with SMTP id d4-v6so2164189pfn.0
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 20:40:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  8 Aug 2018 20:40:33 -0700
Message-Id: <20180809034033.10579-12-richard.henderson@linaro.org>
In-Reply-To: <20180809034033.10579-1-richard.henderson@linaro.org>
References: <20180809034033.10579-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 11/11] target/arm: Add sve-max-vq cpu property
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-stable@nongnu.org

This allows the default (and maximum) vector length to be set
from the command-line.  Which is extraordinarily helpful in
debuging problems depending on vector length without having to
bake knowledge of PR_SET_SVE_VL into every guest binary.

Cc: qemu-stable@nongnu.org (3.0.1)
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h     |  3 +++
 linux-user/syscall.c | 19 +++++++++++++------
 target/arm/cpu.c     |  6 +++---
 target/arm/cpu64.c   | 29 +++++++++++++++++++++++++++++
 target/arm/helper.c  |  7 +++++--
 5 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e310ffc29d..9526ed27cb 100644
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
index dfc851cc35..5a4af76c03 100644
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
index 64a8005a4b..b25898ed4c 100644
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
index d0581d59d8..800bff780e 100644
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
index 66afb08ee0..c24c66d43e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12408,9 +12408,12 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
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
2.17.1
