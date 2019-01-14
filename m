Received: from eggs.gnu.org ([209.51.188.92]:36949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1giqnB-0005aX-FC
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 20:11:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1giqnA-0000rk-JG
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 20:11:53 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1giqnA-0000rI-Di
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 20:11:52 -0500
Received: by mail-pl1-x643.google.com with SMTP id u18so9345531plq.7
	for <qemu-devel@nongnu.org>; Sun, 13 Jan 2019 17:11:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 14 Jan 2019 12:11:11 +1100
Message-Id: <20190114011122.5995-7-richard.henderson@linaro.org>
In-Reply-To: <20190114011122.5995-1-richard.henderson@linaro.org>
References: <20190114011122.5995-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 06/17] target/arm: Implement the IRG instruction
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-a64.h    |  1 +
 target/arm/mte_helper.c    | 55 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c |  7 +++++
 3 files changed, 63 insertions(+)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index fa4c371a47..7a6051fdab 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -104,3 +104,4 @@ DEF_HELPER_FLAGS_2(xpaci, TCG_CALL_NO_RWG_SE, i64, env, i64)
 DEF_HELPER_FLAGS_2(xpacd, TCG_CALL_NO_RWG_SE, i64, env, i64)
 
 DEF_HELPER_FLAGS_2(mte_check, TCG_CALL_NO_WG, i64, env, i64)
+DEF_HELPER_FLAGS_3(irg, TCG_CALL_NO_RWG, i64, env, i64, i64)
diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index 6f4bc0aa04..1878393fc4 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -36,6 +36,48 @@ static int allocation_tag_from_addr(uint64_t ptr)
     return (extract64(ptr, 56, 4) + extract64(ptr, 55, 1)) & 15;
 }
 
+/* Like ChooseNonExcludedTag, except that GCR_EL1 is already in.  */
+static int choose_nonexcluded_tag(int tag, int offset, uint16_t exclude)
+{
+    if (exclude != 0xffff) {
+        int i;
+        for (i = 0; i < offset; ++i) {
+            do {
+                tag = (tag + 1) & 15;
+            } while (exclude & (1 << tag));
+        }
+    }
+    return tag;
+}
+
+static int choose_random_nonexcluded_tag(CPUARMState *env, uint16_t exclude)
+{
+    /* Ignore GCR_EL1.RRND.  Always produce deterministic results.  */
+    int start = extract32(env->cp15.rgsr_el1, 0, 4);
+    int seed = extract32(env->cp15.rgsr_el1, 8, 16);
+    int offset, rtag, i;
+
+    /* RandomTag */
+    for (i = offset = 0; i < 4; ++i) {
+        /* NextRandomTagBit */
+        int top = (extract32(seed, 5, 1) ^ extract32(seed, 3, 1) ^
+                   extract32(seed, 2, 1) ^ extract32(seed, 0, 1));
+        seed = (top << 15) | (seed >> 1);
+        offset |= top << i;
+    }
+    rtag = choose_nonexcluded_tag(start, offset, exclude);
+
+    env->cp15.rgsr_el1 = rtag | (seed << 8);
+
+    return rtag;
+}
+
+static uint64_t address_with_allocation_tag(uint64_t ptr, int rtag)
+{
+    rtag -= extract64(ptr, 55, 1);
+    return deposit64(ptr, 56, 4, rtag);
+}
+
 uint64_t HELPER(mte_check)(CPUARMState *env, uint64_t ptr)
 {
     ARMMMUIdx mmu_idx = arm_stage1_mmu_idx(env);
@@ -108,3 +150,16 @@ uint64_t HELPER(mte_check)(CPUARMState *env, uint64_t ptr)
     /* Unchecked, or tag check pass.  Ignore the top byte.  */
     return sextract64(ptr, 0, 55);
 }
+
+uint64_t HELPER(irg)(CPUARMState *env, uint64_t rn, uint64_t rm)
+{
+    int el = arm_current_el(env);
+    uint64_t sctlr = arm_sctlr(env, el);
+    int rtag = 0;
+
+    if (allocation_tag_access_enabled(env, el, sctlr)) {
+        uint16_t exclude = rm | env->cp15.gcr_el1;
+        rtag = choose_random_nonexcluded_tag(env, exclude);
+    }
+    return address_with_allocation_tag(rn, rtag);
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index ee95ba7165..b0349bffc4 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5105,6 +5105,13 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
     case 3: /* SDIV */
         handle_div(s, true, sf, rm, rn, rd);
         break;
+    case 4: /* IRG */
+        if (sf == 0 || !dc_isar_feature(aa64_mte_insn_reg, s)) {
+            goto do_unallocated;
+        }
+        gen_helper_irg(cpu_reg_sp(s, rd), cpu_env,
+                       cpu_reg_sp(s, rn), cpu_reg(s, rm));
+        break;
     case 8: /* LSLV */
         handle_shift_reg(s, A64_SHIFT_TYPE_LSL, sf, rm, rn, rd);
         break;
-- 
2.17.2
