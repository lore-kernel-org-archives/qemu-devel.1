Received: from eggs.gnu.org ([209.51.188.92]:38405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLOc-0005lK-2o
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLOK-0004je-MB
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:43 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtLOJ-0004RN-KC
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:36 -0500
Received: by mail-pg1-x543.google.com with SMTP id w7so301261pgp.13
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 15:53:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 15:52:40 -0800
Message-Id: <20190211235258.542-11-richard.henderson@linaro.org>
In-Reply-To: <20190211235258.542-1-richard.henderson@linaro.org>
References: <20190211235258.542-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 10/28] target/arm: Implement the IRG
 instruction
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
v2: Update to 00eac5.
    Merge choose_random_nonexcluded_tag into helper_irg since
    that pseudo function no longer exists separately.
---
 target/arm/helper-a64.h    |  1 +
 target/arm/mte_helper.c    | 57 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c |  7 +++++
 3 files changed, 65 insertions(+)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index c88797a922..0f6e78c77e 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -105,3 +105,4 @@ DEF_HELPER_FLAGS_2(xpacd, TCG_CALL_NO_RWG_SE, i64, env, i64)
 
 DEF_HELPER_FLAGS_2(mte_check1, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_3(mte_check2, TCG_CALL_NO_WG, i64, env, i64, i32)
+DEF_HELPER_FLAGS_3(irg, TCG_CALL_NO_RWG, i64, env, i64, i64)
diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index bcd82a9be0..cd04e4954b 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -37,6 +37,31 @@ static int allocation_tag_from_addr(uint64_t ptr)
     return extract64(ptr, 56, 4);
 }
 
+static int choose_nonexcluded_tag(int tag, int offset, uint16_t exclude)
+{
+    if (exclude == 0xffff) {
+        return 0;
+    }
+    if (offset == 0) {
+        while (exclude & (1 << tag)) {
+            tag = (tag + 1) & 15;
+        }
+    } else {
+        do {
+            do {
+                tag = (tag + 1) & 15;
+            } while (exclude & (1 << tag));
+        } while (--offset > 0);
+    }
+    return tag;
+}
+
+static uint64_t address_with_allocation_tag(uint64_t ptr, int rtag)
+{
+    rtag -= extract64(ptr, 55, 1);
+    return deposit64(ptr, 56, 4, rtag);
+}
+
 /*
  * Perform a checked access for MTE.
  * On arrival, TBI is known to enabled, as is allocation_tag_access_enabled.
@@ -131,3 +156,35 @@ uint64_t HELPER(mte_check2)(CPUARMState *env, uint64_t dirty_ptr, uint32_t tbi)
         return dirty_ptr;
     }
 }
+
+uint64_t HELPER(irg)(CPUARMState *env, uint64_t rn, uint64_t rm)
+{
+    int el = arm_current_el(env);
+    uint64_t sctlr = arm_sctlr(env, el);
+    int rtag = 0;
+
+    if (allocation_tag_access_enabled(env, el, sctlr)) {
+        /*
+         * Our IMPDEF choice for GCR_EL1.RRND==1 is to behave as if
+         * GCR_EL1.RRND==0, always producing deterministic results.
+         */
+        uint16_t exclude = extract32(rm | env->cp15.gcr_el1, 0, 16);
+        int start = extract32(env->cp15.rgsr_el1, 0, 4);
+        int seed = extract32(env->cp15.rgsr_el1, 8, 16);
+        int offset, i;
+
+        /* RandomTag */
+        for (i = offset = 0; i < 4; ++i) {
+            /* NextRandomTagBit */
+            int top = (extract32(seed, 5, 1) ^ extract32(seed, 3, 1) ^
+                       extract32(seed, 2, 1) ^ extract32(seed, 0, 1));
+            seed = (top << 15) | (seed >> 1);
+            offset |= top << i;
+        }
+        rtag = choose_nonexcluded_tag(start, offset, exclude);
+
+        env->cp15.rgsr_el1 = rtag | (seed << 8);
+    }
+
+    return address_with_allocation_tag(rn, rtag);
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 27ceea66d1..141a03a88f 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5133,6 +5133,13 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
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
