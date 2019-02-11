Received: from eggs.gnu.org ([209.51.188.92]:38063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLOE-0005Mj-H3
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLOC-0004Xm-0t
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:30 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c]:47054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtLOB-0004Ph-Pl
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:27 -0500
Received: by mail-pl1-x62c.google.com with SMTP id o6so314943pls.13
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 15:53:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 15:52:37 -0800
Message-Id: <20190211235258.542-8-richard.henderson@linaro.org>
In-Reply-To: <20190211235258.542-1-richard.henderson@linaro.org>
References: <20190211235258.542-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 07/28] target/arm: Assert no manual change
 to CACHED_PSTATE_BITS
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

These bits are stored elsewhere; changing env->pstate has no effect.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index a24757d3d7..296d1ac72c 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -209,6 +209,8 @@ static inline void set_pstate_bits(uint32_t bits)
 {
     TCGv_i32 p = tcg_temp_new_i32();
 
+    tcg_debug_assert(!(bits & CACHED_PSTATE_BITS));
+
     tcg_gen_ld_i32(p, cpu_env, offsetof(CPUARMState, pstate));
     tcg_gen_ori_i32(p, p, bits);
     tcg_gen_st_i32(p, cpu_env, offsetof(CPUARMState, pstate));
@@ -220,6 +222,8 @@ static inline void clear_pstate_bits(uint32_t bits)
 {
     TCGv_i32 p = tcg_temp_new_i32();
 
+    tcg_debug_assert(!(bits & CACHED_PSTATE_BITS));
+
     tcg_gen_ld_i32(p, cpu_env, offsetof(CPUARMState, pstate));
     tcg_gen_andi_i32(p, p, ~bits);
     tcg_gen_st_i32(p, cpu_env, offsetof(CPUARMState, pstate));
-- 
2.17.2
