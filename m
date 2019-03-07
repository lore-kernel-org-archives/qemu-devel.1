Received: from eggs.gnu.org ([209.51.188.92]:59233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1wTV-0007U8-Tv
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:06:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1wTU-0006Yl-OX
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:06:29 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:33217)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1wTT-0004Vy-DE
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:06:28 -0500
Received: by mail-pg1-x543.google.com with SMTP id h11so11749714pgl.0
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:04:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Mar 2019 09:04:30 -0800
Message-Id: <20190307170440.3113-13-richard.henderson@linaro.org>
In-Reply-To: <20190307170440.3113-1-richard.henderson@linaro.org>
References: <20190307170440.3113-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4 12/22] target/arm: Implement the STGP
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
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Handle atomicity, require pre-cleaned address.
---
 target/arm/translate-a64.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index b94a5571e0..b7175897e4 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -2787,7 +2787,7 @@ static void disas_ld_lit(DisasContext *s, uint32_t insn)
  * +-----+-------+---+---+-------+---+-------+-------+------+------+
  *
  * opc: LDP/STP/LDNP/STNP        00 -> 32 bit, 10 -> 64 bit
- *      LDPSW                    01
+ *      LDPSW/STGP               01
  *      LDP/STP/LDNP/STNP (SIMD) 00 -> 32 bit, 01 -> 64 bit, 10 -> 128 bit
  *   V: 0 -> GPR, 1 -> Vector
  * idx: 00 -> signed offset with non-temporal hint, 01 -> post-index,
@@ -2812,6 +2812,7 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
     bool is_signed = false;
     bool postindex = false;
     bool wback = false;
+    bool set_tag = false;
 
     TCGv_i64 clean_addr, dirty_addr;
 
@@ -2824,6 +2825,14 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
 
     if (is_vector) {
         size = 2 + opc;
+    } else if (opc == 1 && !is_load) {
+        /* STGP */
+        if (!dc_isar_feature(aa64_mte_insn_reg, s) || index == 0) {
+            unallocated_encoding(s);
+            return;
+        }
+        size = 3;
+        set_tag = true;
     } else {
         size = 2 + extract32(opc, 1, 1);
         is_signed = extract32(opc, 0, 1);
@@ -2876,6 +2885,15 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
     }
     clean_addr = clean_data_tbi(s, dirty_addr, wback || rn != 31);
 
+    if (set_tag) {
+        TCGv_i64 tcg_rn = cpu_reg_sp(s, rn);
+        if (tb_cflags(s->base.tb) & CF_PARALLEL) {
+            gen_helper_stg_parallel(cpu_env, clean_addr, tcg_rn);
+        } else {
+            gen_helper_stg(cpu_env, clean_addr, tcg_rn);
+        }
+    }
+
     if (is_vector) {
         if (is_load) {
             do_fp_ld(s, rt, clean_addr, size);
-- 
2.17.2
