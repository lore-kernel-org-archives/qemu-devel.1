Received: from eggs.gnu.org ([209.51.188.92]:37757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gt05z-000611-DO
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 20:09:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gt05t-0000CE-E9
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 20:09:15 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gt05s-0008KR-Vi
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 20:09:09 -0500
Received: by mail-pl1-x643.google.com with SMTP id b5so4516159plr.4
	for <qemu-devel@nongnu.org>; Sun, 10 Feb 2019 17:08:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 10 Feb 2019 17:08:21 -0800
Message-Id: <20190211010829.29869-19-richard.henderson@linaro.org>
In-Reply-To: <20190211010829.29869-1-richard.henderson@linaro.org>
References: <20190211010829.29869-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 18/26] target/arm: Implement data cache set
 allocation tags
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

This is DC GVA and DC GZVA.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Use allocation_tag_mem + memset.
---
 target/arm/cpu.h           |  4 +++-
 target/arm/helper-a64.h    |  1 +
 target/arm/helper.c        | 16 ++++++++++++++++
 target/arm/mte_helper.c    | 26 ++++++++++++++++++++++++++
 target/arm/translate-a64.c |  9 +++++++++
 5 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 74633a7a78..ca32939483 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2160,7 +2160,9 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpregid)
 #define ARM_CP_NZCV              (ARM_CP_SPECIAL | 0x0300)
 #define ARM_CP_CURRENTEL         (ARM_CP_SPECIAL | 0x0400)
 #define ARM_CP_DC_ZVA            (ARM_CP_SPECIAL | 0x0500)
-#define ARM_LAST_SPECIAL         ARM_CP_DC_ZVA
+#define ARM_CP_DC_GVA            (ARM_CP_SPECIAL | 0x0600)
+#define ARM_CP_DC_GZVA           (ARM_CP_SPECIAL | 0x0700)
+#define ARM_LAST_SPECIAL         ARM_CP_DC_GZVA
 #define ARM_CP_FPU               0x1000
 #define ARM_CP_SVE               0x2000
 #define ARM_CP_NO_GDB            0x4000
diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index a00364fb4c..4ad900d36e 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -113,3 +113,4 @@ DEF_HELPER_FLAGS_2(stg, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_2(st2g, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_2(stg_parallel, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_2(st2g_parallel, TCG_CALL_NO_WG, i64, env, i64)
+DEF_HELPER_FLAGS_2(dc_gva, TCG_CALL_NO_RWG, void, env, i64)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 74bace81e4..9fac3628e5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5820,6 +5820,22 @@ static const ARMCPRegInfo mte_reginfo[] = {
     { .name = "CIGDVAC", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 14, .opc2 = 5,
       .type = ARM_CP_NOP, .access = PL1_W },
+    { .name = "GVA", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 4, .opc2 = 3,
+      .access = PL0_W, .type = ARM_CP_DC_GVA,
+#ifndef CONFIG_USER_ONLY
+      /* Avoid overhead of an access check that always passes in user-mode */
+      .accessfn = aa64_zva_access,
+#endif
+    },
+    { .name = "GZVA", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 4, .opc2 = 4,
+      .access = PL0_W, .type = ARM_CP_DC_GZVA,
+#ifndef CONFIG_USER_ONLY
+      /* Avoid overhead of an access check that always passes in user-mode */
+      .accessfn = aa64_zva_access,
+#endif
+    },
     REGINFO_SENTINEL
 };
 #endif
diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index 13befdbf86..93f7cccee2 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -386,3 +386,29 @@ uint64_t HELPER(st2g_parallel)(CPUARMState *env, uint64_t ptr)
 {
     return do_st2g(env, ptr, GETPC(), store_tag1_parallel);
 }
+
+void HELPER(dc_gva)(CPUARMState *env, uint64_t ptr)
+{
+    ARMCPU *cpu = arm_env_get_cpu(env);
+    int el = arm_current_el(env);
+    uint64_t sctlr = arm_sctlr(env, el);
+    size_t blocklen = 4 << cpu->dcz_blocksize;
+    uint8_t *mem;
+    int rtag;
+
+    ptr = QEMU_ALIGN_DOWN(ptr, blocklen);
+
+    /* Trap if accessing an invalid page.  */
+    mem = allocation_tag_mem(env, ptr, true, GETPC());
+
+    /* No action if page does not support tags, or if access is disabled.  */
+    if (!mem || !allocation_tag_access_enabled(env, el, sctlr)) {
+        return;
+    }
+
+    rtag = allocation_tag_from_addr(ptr);
+    rtag |= rtag << 4;
+
+    assert(blocklen % (2 << LOG2_TAG_GRANULE) == 0);
+    memset(mem, rtag, blocklen / (2 << LOG2_TAG_GRANULE));
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 9bd68d522c..a3bd2e27ef 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1811,6 +1811,15 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
         tcg_rt = cpu_reg(s, rt);
         gen_helper_dc_zva(cpu_env, tcg_rt);
         return;
+    case ARM_CP_DC_GVA:
+        tcg_rt = cpu_reg(s, rt);
+        gen_helper_dc_gva(cpu_env, tcg_rt);
+        return;
+    case ARM_CP_DC_GZVA:
+        tcg_rt = cpu_reg(s, rt);
+        gen_helper_dc_zva(cpu_env, tcg_rt);
+        gen_helper_dc_gva(cpu_env, tcg_rt);
+        return;
     default:
         break;
     }
-- 
2.17.2
