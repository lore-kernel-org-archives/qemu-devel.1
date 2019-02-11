Received: from eggs.gnu.org ([209.51.188.92]:37160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gt05d-0005Za-0h
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 20:08:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gt05X-0008A2-8e
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 20:08:52 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:43588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gt05Q-00082b-5x
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 20:08:42 -0500
Received: by mail-pg1-x541.google.com with SMTP id v28so4197817pgk.10
	for <qemu-devel@nongnu.org>; Sun, 10 Feb 2019 17:08:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 10 Feb 2019 17:08:07 -0800
Message-Id: <20190211010829.29869-5-richard.henderson@linaro.org>
In-Reply-To: <20190211010829.29869-1-richard.henderson@linaro.org>
References: <20190211010829.29869-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 04/26] target/arm: Add MTE_ACTIVE to tb_flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

When MTE is fully enabled, i.e. access to tags are enabled and
tag checks affect the PE, then arrange to perform the check
while stripping the TBI.

The check is not yet implemented, just the plumbing to that point.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Clean TBI bits exactly.
    Fix license to lgpl 2.1.
---
 target/arm/cpu.h           | 12 ++++++++
 target/arm/helper-a64.h    |  2 ++
 target/arm/internals.h     | 18 ++++++++++++
 target/arm/translate.h     |  2 ++
 target/arm/helper.c        | 51 ++++++++++++++++++++++++++--------
 target/arm/mte_helper.c    | 57 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c |  9 +++++-
 target/arm/Makefile.objs   |  2 +-
 8 files changed, 140 insertions(+), 13 deletions(-)
 create mode 100644 target/arm/mte_helper.c

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 20be9fb53a..2776df6981 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1215,6 +1215,7 @@ void pmu_init(ARMCPU *cpu);
 #define PSTATE_BTYPE (3U << 10)
 #define PSTATE_IL (1U << 20)
 #define PSTATE_SS (1U << 21)
+#define PSTATE_TCO (1U << 25)
 #define PSTATE_V (1U << 28)
 #define PSTATE_C (1U << 29)
 #define PSTATE_Z (1U << 30)
@@ -3071,6 +3072,7 @@ FIELD(TBFLAG_A64, PAUTH_ACTIVE, 8, 1)
 FIELD(TBFLAG_A64, BT, 9, 1)
 FIELD(TBFLAG_A64, BTYPE, 10, 2)
 FIELD(TBFLAG_A64, TBID, 12, 2)
+FIELD(TBFLAG_A64, MTE_ACTIVE, 14, 1)
 
 static inline bool bswap_code(bool sctlr_b)
 {
@@ -3361,6 +3363,16 @@ static inline bool isar_feature_aa64_bti(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, BT) != 0;
 }
 
+static inline bool isar_feature_aa64_mte_insn_reg(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, MTE) != 0;
+}
+
+static inline bool isar_feature_aa64_mte(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, MTE) >= 2;
+}
+
 /*
  * Forward to the above feature tests given an ARMCPU pointer.
  */
diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index a915c1247f..fa4c371a47 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -102,3 +102,5 @@ DEF_HELPER_FLAGS_3(autda, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(autdb, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_2(xpaci, TCG_CALL_NO_RWG_SE, i64, env, i64)
 DEF_HELPER_FLAGS_2(xpacd, TCG_CALL_NO_RWG_SE, i64, env, i64)
+
+DEF_HELPER_FLAGS_2(mte_check, TCG_CALL_NO_WG, i64, env, i64)
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 587a1ddf58..6c018e773c 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -983,4 +983,22 @@ static inline int exception_target_el(CPUARMState *env)
     return target_el;
 }
 
+/* Determine if allocation tags are available.  */
+static inline bool allocation_tag_access_enabled(CPUARMState *env, int el,
+                                                 uint64_t sctlr)
+{
+    if (el < 3
+        && arm_feature(env, ARM_FEATURE_EL3)
+        && !(env->cp15.scr_el3 & SCR_ATA)) {
+        return false;
+    }
+    if (el < 2
+        && arm_feature(env, ARM_FEATURE_EL2)
+        && !(arm_hcr_el2_eff(env) & HCR_ATA)) {
+        return false;
+    }
+    sctlr &= (el == 0 ? SCTLR_ATA0 : SCTLR_ATA);
+    return sctlr != 0;
+}
+
 #endif
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 33af50a13f..5a101e1c6d 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -70,6 +70,8 @@ typedef struct DisasContext {
     bool ss_same_el;
     /* True if v8.3-PAuth is active.  */
     bool pauth_active;
+    /* True if v8.5-MTE tag checks affect the PE.  */
+    bool mte_active;
     /* True with v8.5-BTI and SCTLR_ELx.BT* set.  */
     bool bt;
     /*
diff --git a/target/arm/helper.c b/target/arm/helper.c
index d4abbb5076..e73bdbf041 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1862,6 +1862,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     if (cpu_isar_feature(aa64_pauth, cpu)) {
         valid_mask |= SCR_API | SCR_APK;
     }
+    if (cpu_isar_feature(aa64_mte, cpu)) {
+        valid_mask |= SCR_ATA;
+    }
 
     /* Clear all-context RES0 bits.  */
     value &= valid_mask;
@@ -4056,22 +4059,31 @@ static void sctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     ARMCPU *cpu = arm_env_get_cpu(env);
 
-    if (raw_read(env, ri) == value) {
-        /* Skip the TLB flush if nothing actually changed; Linux likes
-         * to do a lot of pointless SCTLR writes.
-         */
-        return;
-    }
-
     if (arm_feature(env, ARM_FEATURE_PMSA) && !cpu->has_mpu) {
         /* M bit is RAZ/WI for PMSA with no MPU implemented */
         value &= ~SCTLR_M;
     }
 
-    raw_write(env, ri, value);
+    if (!cpu_isar_feature(aa64_mte, cpu)) {
+        if (ri->opc1 == 6) { /* SCTLR_EL3 */
+            value &= ~(SCTLR_ITFSB | SCTLR_TCF | SCTLR_ATA);
+        } else {
+            value &= ~(SCTLR_ITFSB | SCTLR_TCF0 | SCTLR_TCF |
+                       SCTLR_ATA0 | SCTLR_ATA);
+        }
+    }
+
     /* ??? Lots of these bits are not implemented.  */
-    /* This may enable/disable the MMU, so do a TLB flush.  */
-    tlb_flush(CPU(cpu));
+
+    if (raw_read(env, ri) != value) {
+        /*
+         * This may enable/disable the MMU, so do a TLB flush.
+         * Skip the TLB flush if nothing actually changed;
+         * Linux likes to do a lot of pointless SCTLR writes.
+         */
+        raw_write(env, ri, value);
+        tlb_flush(CPU(cpu));
+    }
 }
 
 static CPAccessResult fpexc32_access(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4564,6 +4576,9 @@ static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     if (cpu_isar_feature(aa64_pauth, cpu)) {
         valid_mask |= HCR_API | HCR_APK;
     }
+    if (cpu_isar_feature(aa64_mte, cpu)) {
+        valid_mask |= HCR_ATA;
+    }
 
     /* Clear RES0 bits.  */
     value &= valid_mask;
@@ -13756,6 +13771,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
     if (is_a64(env)) {
         ARMCPU *cpu = arm_env_get_cpu(env);
         uint64_t sctlr;
+        int tbid;
 
         *pc = env->pc;
         flags = FIELD_DP32(flags, TBFLAG_ANY, AARCH64_STATE, 1);
@@ -13764,7 +13780,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         {
             ARMMMUIdx stage1 = stage_1_mmu_idx(mmu_idx);
             ARMVAParameters p0 = aa64_va_parameters_both(env, 0, stage1);
-            int tbii, tbid;
+            int tbii;
 
             /* FIXME: ARMv8.1-VHE S2 translation regime.  */
             if (regime_el(env, stage1) < 2) {
@@ -13817,6 +13833,19 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
             }
             flags = FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
         }
+
+        /*
+         * If MTE is enabled, and tag checks affect the PE,
+         * then we check the tag as we strip the TBI field.
+         * Note that if TBI is disabled, all accesses are unchecked.
+         */
+        if (tbid
+            && cpu_isar_feature(aa64_mte, cpu)
+            && allocation_tag_access_enabled(env, current_el, sctlr)
+            && !(env->pstate & PSTATE_TCO)
+            && (sctlr & (current_el == 0 ? SCTLR_TCF0 : SCTLR_TCF))) {
+            flags = FIELD_DP32(flags, TBFLAG_A64, MTE_ACTIVE, 1);
+        }
     } else {
         *pc = env->regs[15];
         flags = FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
new file mode 100644
index 0000000000..f1174d6f9f
--- /dev/null
+++ b/target/arm/mte_helper.c
@@ -0,0 +1,57 @@
+/*
+ * ARM v8.5-MemTag Operations
+ *
+ * Copyright (c) 2019 Linaro, Ltd.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "internals.h"
+#include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
+#include "exec/helper-proto.h"
+
+
+static uint64_t strip_tbi(CPUARMState *env, uint64_t ptr)
+{
+    /*
+     * We know some TBI is enabled, because MTE is enabled enough to
+     * arrive here.  We simply need to check how to apply the TBI strip.
+     */
+    if (arm_current_el(env) >= 2) {
+        /* FIXME: ARMv8.1-VHE S2 translation regime.  */
+        /* Only one address space half, and TBI enabled.  */
+        return extract64(ptr, 0, 56);
+    } else {
+        /*
+         * Two address space halves, but we don't know for sure that
+         * TBI is enabled for both halves.  Check.
+         */
+        uint64_t tcr = env->cp15.tcr_el[1].raw_tcr;
+        bool tbi = extract64(tcr, 37 + extract64(ptr, 55, 1), 1);
+
+        if (tbi) {
+            return sextract64(ptr, 0, 56);
+        }
+        return ptr;
+    }
+}
+
+uint64_t HELPER(mte_check)(CPUARMState *env, uint64_t ptr)
+{
+    /* Only unchecked implemented so far.  */
+    return strip_tbi(env, ptr);
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index ba139bba26..e782a0e579 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -343,7 +343,13 @@ static void gen_a64_set_pc(DisasContext *s, TCGv_i64 src)
 static TCGv_i64 clean_data_tbi(DisasContext *s, TCGv_i64 addr)
 {
     TCGv_i64 clean = new_tmp_a64(s);
-    gen_top_byte_ignore(s, clean, addr, s->tbid);
+
+    /* FIXME: SP+OFS is always unchecked.  */
+    if (s->tbid && s->mte_active) {
+        gen_helper_mte_check(clean, cpu_env, addr);
+    } else {
+        gen_top_byte_ignore(s, clean, addr, s->tbid);
+    }
     return clean;
 }
 
@@ -14041,6 +14047,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->pauth_active = FIELD_EX32(tb_flags, TBFLAG_A64, PAUTH_ACTIVE);
     dc->bt = FIELD_EX32(tb_flags, TBFLAG_A64, BT);
     dc->btype = FIELD_EX32(tb_flags, TBFLAG_A64, BTYPE);
+    dc->mte_active = FIELD_EX32(tb_flags, TBFLAG_A64, MTE_ACTIVE);
     dc->vec_len = 0;
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index 1a4fc06448..c86cb1af5c 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -8,7 +8,7 @@ obj-y += translate.o op_helper.o helper.o cpu.o
 obj-y += neon_helper.o iwmmxt_helper.o vec_helper.o
 obj-y += gdbstub.o
 obj-$(TARGET_AARCH64) += cpu64.o translate-a64.o helper-a64.o gdbstub64.o
-obj-$(TARGET_AARCH64) += pauth_helper.o
+obj-$(TARGET_AARCH64) += pauth_helper.o mte_helper.o
 obj-y += crypto_helper.o
 obj-$(CONFIG_SOFTMMU) += arm-powerctl.o
 
-- 
2.17.2
