Received: from eggs.gnu.org ([209.51.188.92]:37108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1giqnQ-0005p8-JB
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 20:12:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1giqnP-00012K-Na
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 20:12:08 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:42151)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1giqnP-00011v-Ia
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 20:12:07 -0500
Received: by mail-pf1-x444.google.com with SMTP id 64so9532245pfr.9
	for <qemu-devel@nongnu.org>; Sun, 13 Jan 2019 17:12:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 14 Jan 2019 12:11:16 +1100
Message-Id: <20190114011122.5995-12-richard.henderson@linaro.org>
In-Reply-To: <20190114011122.5995-1-richard.henderson@linaro.org>
References: <20190114011122.5995-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 11/17] target/arm: Implement the STGP
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
 target/arm/translate-a64.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 60865945e4..911d6f06b3 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -2696,7 +2696,7 @@ static void disas_ld_lit(DisasContext *s, uint32_t insn)
  * +-----+-------+---+---+-------+---+-------+-------+------+------+
  *
  * opc: LDP/STP/LDNP/STNP        00 -> 32 bit, 10 -> 64 bit
- *      LDPSW                    01
+ *      LDPSW/STGP               01
  *      LDP/STP/LDNP/STNP (SIMD) 00 -> 32 bit, 01 -> 64 bit, 10 -> 128 bit
  *   V: 0 -> GPR, 1 -> Vector
  * idx: 00 -> signed offset with non-temporal hint, 01 -> post-index,
@@ -2721,6 +2721,7 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
     bool is_signed = false;
     bool postindex = false;
     bool wback = false;
+    bool set_tag = false;
 
     TCGv_i64 clean_addr, dirty_addr;
 
@@ -2733,6 +2734,14 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
 
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
@@ -2783,7 +2792,12 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
     if (!postindex) {
         tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
     }
-    clean_addr = clean_data_tbi(s, dirty_addr, rn == 31);
+    if (set_tag) {
+        clean_addr = new_tmp_a64(s);
+        gen_helper_stg(clean_addr, cpu_env, dirty_addr);
+    } else {
+        clean_addr = clean_data_tbi(s, dirty_addr, rn == 31);
+    }
 
     if (is_vector) {
         if (is_load) {
-- 
2.17.2
