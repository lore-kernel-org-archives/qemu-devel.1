Received: from eggs.gnu.org ([209.51.188.92]:38157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLOG-0005R2-Vv
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLOE-0004aE-HN
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:32 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:42473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtLOC-0004Rt-BZ
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:30 -0500
Received: by mail-pf1-x442.google.com with SMTP id n74so324893pfi.9
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 15:53:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 15:52:42 -0800
Message-Id: <20190211235258.542-13-richard.henderson@linaro.org>
In-Reply-To: <20190211235258.542-1-richard.henderson@linaro.org>
References: <20190211235258.542-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 12/28] target/arm: Implement the GMI
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-a64.h    | 1 +
 target/arm/mte_helper.c    | 6 ++++++
 target/arm/translate-a64.c | 6 ++++++
 3 files changed, 13 insertions(+)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 6ad23bf9ee..3b78e19279 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -108,3 +108,4 @@ DEF_HELPER_FLAGS_3(mte_check2, TCG_CALL_NO_WG, i64, env, i64, i32)
 DEF_HELPER_FLAGS_3(irg, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_4(addg, TCG_CALL_NO_RWG_SE, i64, env, i64, i32, i32)
 DEF_HELPER_FLAGS_4(subg, TCG_CALL_NO_RWG_SE, i64, env, i64, i32, i32)
+DEF_HELPER_FLAGS_2(gmi, TCG_CALL_NO_RWG_SE, i64, i64, i64)
diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index 7aca5b074f..e60c6f48eb 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -220,3 +220,9 @@ uint64_t HELPER(subg)(CPUARMState *env, uint64_t ptr,
 
     return address_with_allocation_tag(ptr - offset, rtag);
 }
+
+uint64_t HELPER(gmi)(uint64_t ptr, uint64_t mask)
+{
+    int tag = allocation_tag_from_addr(ptr);
+    return mask | (1ULL << tag);
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 8e322bd6a0..791bcc3b66 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5165,6 +5165,12 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
         gen_helper_irg(cpu_reg_sp(s, rd), cpu_env,
                        cpu_reg_sp(s, rn), cpu_reg(s, rm));
         break;
+    case 5: /* GMI */
+        if (sf == 0 || !dc_isar_feature(aa64_mte_insn_reg, s)) {
+            goto do_unallocated;
+        }
+        gen_helper_gmi(cpu_reg(s, rd), cpu_reg_sp(s, rn), cpu_reg(s, rm));
+        break;
     case 8: /* LSLV */
         handle_shift_reg(s, A64_SHIFT_TYPE_LSL, sf, rm, rn, rd);
         break;
-- 
2.17.2
