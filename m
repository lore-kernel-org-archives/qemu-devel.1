Received: from eggs.gnu.org ([2001:4830:134:3::10]:59638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmv-0008S1-BR
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmt-00066b-3T
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:37 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1euLms-00063U-RR
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:35 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1euLml-00074m-2j
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 17:26:27 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Mar 2018 17:26:03 +0000
Message-Id: <20180309172622.4277-7-peter.maydell@linaro.org>
In-Reply-To: <20180309172622.4277-1-peter.maydell@linaro.org>
References: <20180309172622.4277-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/25] linux-user: Implement aarch64
 PR_SVE_SET/GET_VL
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

As an implementation choice, widening VL has zeroed the
previously inaccessible portion of the sve registers.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20180303143823.27055-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/aarch64/target_syscall.h |  3 +++
 target/arm/cpu.h                    |  1 +
 linux-user/syscall.c                | 27 ++++++++++++++++++++++++
 target/arm/cpu64.c                  | 41 +++++++++++++++++++++++++++++++++++++
 4 files changed, 72 insertions(+)

diff --git a/linux-user/aarch64/target_syscall.h b/linux-user/aarch64/target_syscall.h
index 604ab99b14..205265e619 100644
--- a/linux-user/aarch64/target_syscall.h
+++ b/linux-user/aarch64/target_syscall.h
@@ -19,4 +19,7 @@ struct target_pt_regs {
 #define TARGET_MLOCKALL_MCL_CURRENT 1
 #define TARGET_MLOCKALL_MCL_FUTURE  2
 
+#define TARGET_PR_SVE_SET_VL  50
+#define TARGET_PR_SVE_GET_VL  51
+
 #endif /* AARCH64_TARGET_SYSCALL_H */
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 3fa8fdad21..36711cdb50 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -866,6 +866,7 @@ int arm_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
 #ifdef TARGET_AARCH64
 int aarch64_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int aarch64_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
+void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
 #endif
 
 target_ulong do_arm_semihosting(CPUARMState *env);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index a8abfd421d..b4f7b14fbe 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -10672,6 +10672,33 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             break;
         }
 #endif
+#ifdef TARGET_AARCH64
+        case TARGET_PR_SVE_SET_VL:
+            /* We cannot support either PR_SVE_SET_VL_ONEXEC
+               or PR_SVE_VL_INHERIT.  Therefore, anything above
+               ARM_MAX_VQ results in EINVAL.  */
+            ret = -TARGET_EINVAL;
+            if (arm_feature(cpu_env, ARM_FEATURE_SVE)
+                && arg2 >= 0 && arg2 <= ARM_MAX_VQ * 16 && !(arg2 & 15)) {
+                CPUARMState *env = cpu_env;
+                int old_vq = (env->vfp.zcr_el[1] & 0xf) + 1;
+                int vq = MAX(arg2 / 16, 1);
+
+                if (vq < old_vq) {
+                    aarch64_sve_narrow_vq(env, vq);
+                }
+                env->vfp.zcr_el[1] = vq - 1;
+                ret = vq * 16;
+            }
+            break;
+        case TARGET_PR_SVE_GET_VL:
+            ret = -TARGET_EINVAL;
+            if (arm_feature(cpu_env, ARM_FEATURE_SVE)) {
+                CPUARMState *env = cpu_env;
+                ret = ((env->vfp.zcr_el[1] & 0xf) + 1) * 16;
+            }
+            break;
+#endif /* AARCH64 */
         case PR_GET_SECCOMP:
         case PR_SET_SECCOMP:
             /* Disable seccomp to prevent the target disabling syscalls we
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index dd9ba973f7..f12a485820 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -368,3 +368,44 @@ static void aarch64_cpu_register_types(void)
 }
 
 type_init(aarch64_cpu_register_types)
+
+/* The manual says that when SVE is enabled and VQ is widened the
+ * implementation is allowed to zero the previously inaccessible
+ * portion of the registers.  The corollary to that is that when
+ * SVE is enabled and VQ is narrowed we are also allowed to zero
+ * the now inaccessible portion of the registers.
+ *
+ * The intent of this is that no predicate bit beyond VQ is ever set.
+ * Which means that some operations on predicate registers themselves
+ * may operate on full uint64_t or even unrolled across the maximum
+ * uint64_t[4].  Performing 4 bits of host arithmetic unconditionally
+ * may well be cheaper than conditionals to restrict the operation
+ * to the relevant portion of a uint16_t[16].
+ *
+ * TODO: Need to call this for changes to the real system registers
+ * and EL state changes.
+ */
+void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq)
+{
+    int i, j;
+    uint64_t pmask;
+
+    assert(vq >= 1 && vq <= ARM_MAX_VQ);
+
+    /* Zap the high bits of the zregs.  */
+    for (i = 0; i < 32; i++) {
+        memset(&env->vfp.zregs[i].d[2 * vq], 0, 16 * (ARM_MAX_VQ - vq));
+    }
+
+    /* Zap the high bits of the pregs and ffr.  */
+    pmask = 0;
+    if (vq & 3) {
+        pmask = ~(-1ULL << (16 * (vq & 3)));
+    }
+    for (j = vq / 4; j < ARM_MAX_VQ / 4; j++) {
+        for (i = 0; i < 17; ++i) {
+            env->vfp.pregs[i].p[j] &= pmask;
+        }
+        pmask = 0;
+    }
+}
-- 
2.16.2
