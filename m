Received: from eggs.gnu.org ([2001:4830:134:3::10]:43231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edper-0001tt-4x
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:54:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edpep-00049X-UQ
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:54:01 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:42050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1edpep-00048T-LS
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:53:59 -0500
Received: by mail-pf0-x243.google.com with SMTP id b25so8755872pfd.9
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 19:53:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 22 Jan 2018 19:53:48 -0800
Message-Id: <20180123035349.24538-5-richard.henderson@linaro.org>
In-Reply-To: <20180123035349.24538-1-richard.henderson@linaro.org>
References: <20180123035349.24538-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 4/5] target/arm: Add ZCR_ELx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

Define ZCR_EL[1-3].

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    |   5 ++
 target/arm/helper.c | 131 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 3f4f6b6144..17955ad3ef 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -549,6 +549,9 @@ typedef struct CPUARMState {
          */
         float_status fp_status;
         float_status standard_fp_status;
+
+        /* ZCR_EL[1-3] */
+        uint64_t zcr_el[4];
     } vfp;
     uint64_t exclusive_addr;
     uint64_t exclusive_val;
@@ -923,6 +926,8 @@ void pmccntr_sync(CPUARMState *env);
 #define CPTR_TCPAC    (1U << 31)
 #define CPTR_TTA      (1U << 20)
 #define CPTR_TFP      (1U << 10)
+#define CPTR_TZ       (1U << 8)   /* CPTR_EL2 */
+#define CPTR_EZ       (1U << 8)   /* CPTR_EL3 */
 
 #define MDCR_EPMAD    (1U << 21)
 #define MDCR_EDAD     (1U << 20)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index bfce09643b..db67e8ac72 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4266,6 +4266,125 @@ static const ARMCPRegInfo debug_lpae_cp_reginfo[] = {
     REGINFO_SENTINEL
 };
 
+/* Return the exception level to which SVE-disabled exceptions should
+ * be taken, or 0 if SVE is enabled.
+ */
+static int sve_exception_el(CPUARMState *env)
+{
+#ifndef CONFIG_USER_ONLY
+    unsigned current_el = arm_current_el(env);
+
+    /* The CPACR.ZEN controls traps to EL1:
+     * 0, 2 : trap EL0 and EL1 accesses
+     * 1    : trap only EL0 accesses
+     * 3    : trap no accesses
+     */
+    switch (extract32(env->cp15.cpacr_el1, 16, 2)) {
+    default:
+        if (current_el <= 1) {
+            /* Trap to PL1, which might be EL1 or EL3 */
+            if (arm_is_secure(env) && !arm_el_is_aa64(env, 3)) {
+                return 3;
+            }
+            return 1;
+        }
+        break;
+    case 1:
+        if (current_el == 0) {
+            return 1;
+        }
+        break;
+    case 3:
+        break;
+    }
+
+    /* Similarly for CPACR.FPEN, after having checked ZEN.  */
+    switch (extract32(env->cp15.cpacr_el1, 20, 2)) {
+    default:
+        if (current_el <= 1) {
+            if (arm_is_secure(env) && !arm_el_is_aa64(env, 3)) {
+                return 3;
+            }
+            return 1;
+        }
+        break;
+    case 1:
+        if (current_el == 0) {
+            return 1;
+        }
+        break;
+    case 3:
+        break;
+    }
+
+    /* CPTR_EL2.  Check both TZ and TFP.  */
+    if (current_el <= 2
+        && (env->cp15.cptr_el[2] & (CPTR_TFP | CPTR_TZ))
+        && !arm_is_secure_below_el3(env)) {
+        return 2;
+    }
+
+    /* CPTR_EL3.  Check both EZ and TFP.  */
+    if (!(env->cp15.cptr_el[3] & CPTR_EZ)
+        || (env->cp15.cptr_el[3] & CPTR_TFP)) {
+        return 3;
+    }
+#endif
+    return 0;
+}
+
+static CPAccessResult zcr_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                 bool isread)
+{
+    switch (sve_exception_el(env)) {
+    case 3:
+        return CP_ACCESS_TRAP_EL3;
+    case 2:
+        return CP_ACCESS_TRAP_EL2;
+    case 1:
+        return CP_ACCESS_TRAP;
+    }
+    return CP_ACCESS_OK;
+}
+
+static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                      uint64_t value)
+{
+    /* Bits other than [3:0] are RAZ/WI.  */
+    raw_write(env, ri, value & 0xf);
+}
+
+static const ARMCPRegInfo zcr_el1_reginfo = {
+    .name = "ZCR_EL1", .state = ARM_CP_STATE_AA64,
+    .opc0 = 3, .opc1 = 0, .crn = 1, .crm = 2, .opc2 = 0,
+    .access = PL1_RW, .accessfn = zcr_access, .type = ARM_CP_64BIT,
+    .fieldoffset = offsetof(CPUARMState, vfp.zcr_el[1]),
+    .writefn = zcr_write, .raw_writefn = raw_write
+};
+
+static const ARMCPRegInfo zcr_el2_reginfo = {
+    .name = "ZCR_EL2", .state = ARM_CP_STATE_AA64,
+    .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 2, .opc2 = 0,
+    .access = PL2_RW, .accessfn = zcr_access, .type = ARM_CP_64BIT,
+    .fieldoffset = offsetof(CPUARMState, vfp.zcr_el[2]),
+    .writefn = zcr_write, .raw_writefn = raw_write
+};
+
+static const ARMCPRegInfo zcr_no_el2_reginfo = {
+    .name = "ZCR_EL2", .state = ARM_CP_STATE_AA64,
+    .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 2, .opc2 = 0,
+    .access = PL2_RW, .type = ARM_CP_64BIT,
+    .readfn = arm_cp_read_zero, .writefn = arm_cp_write_ignore
+};
+
+static const ARMCPRegInfo zcr_el3_reginfo = {
+    .name = "ZCR_EL3", .state = ARM_CP_STATE_AA64,
+    .opc0 = 3, .opc1 = 6, .crn = 1, .crm = 2, .opc2 = 0,
+    .access = PL3_RW, .accessfn = zcr_access, .type = ARM_CP_64BIT,
+    .fieldoffset = offsetof(CPUARMState, vfp.zcr_el[3]),
+    .writefn = zcr_write, .raw_writefn = raw_write
+};
+
 void hw_watchpoint_update(ARMCPU *cpu, int n)
 {
     CPUARMState *env = &cpu->env;
@@ -5332,6 +5451,18 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         }
         define_one_arm_cp_reg(cpu, &sctlr);
     }
+
+    if (arm_feature(env, ARM_FEATURE_SVE)) {
+        define_one_arm_cp_reg(cpu, &zcr_el1_reginfo);
+        if (arm_feature(env, ARM_FEATURE_EL2)) {
+            define_one_arm_cp_reg(cpu, &zcr_el2_reginfo);
+        } else {
+            define_one_arm_cp_reg(cpu, &zcr_no_el2_reginfo);
+        }
+        if (arm_feature(env, ARM_FEATURE_EL3)) {
+            define_one_arm_cp_reg(cpu, &zcr_el3_reginfo);
+        }
+    }
 }
 
 void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
-- 
2.14.3
