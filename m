Received: from eggs.gnu.org ([209.51.188.92]:38249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLOJ-0005UG-L4
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLOH-0004f8-1L
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:35 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtLOE-0004U1-BM
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:30 -0500
Received: by mail-pg1-x543.google.com with SMTP id r11so318906pgp.6
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 15:53:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 15:52:46 -0800
Message-Id: <20190211235258.542-17-richard.henderson@linaro.org>
In-Reply-To: <20190211235258.542-1-richard.henderson@linaro.org>
References: <20190211235258.542-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 16/28] target/arm: Implement the STGP
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
v3: Handle atomicity, require pre-cleaned address.
---
 target/arm/translate-a64.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index feed325083..ef3fc3a397 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -2708,7 +2708,7 @@ static void disas_ld_lit(DisasContext *s, uint32_t insn)
  * +-----+-------+---+---+-------+---+-------+-------+------+------+
  *
  * opc: LDP/STP/LDNP/STNP        00 -> 32 bit, 10 -> 64 bit
- *      LDPSW                    01
+ *      LDPSW/STGP               01
  *      LDP/STP/LDNP/STNP (SIMD) 00 -> 32 bit, 01 -> 64 bit, 10 -> 128 bit
  *   V: 0 -> GPR, 1 -> Vector
  * idx: 00 -> signed offset with non-temporal hint, 01 -> post-index,
@@ -2733,6 +2733,7 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
     bool is_signed = false;
     bool postindex = false;
     bool wback = false;
+    bool set_tag = false;
 
     TCGv_i64 clean_addr, dirty_addr;
 
@@ -2745,6 +2746,14 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
 
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
@@ -2797,6 +2806,15 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
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
