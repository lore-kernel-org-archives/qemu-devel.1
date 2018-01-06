Received: from eggs.gnu.org ([2001:4830:134:3::10]:48426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eXew5-0007eQ-Ea
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:14:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eXew4-0005UU-Di
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:14:17 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:35385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eXew4-0005SW-5W
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:14:16 -0500
Received: by mail-pf0-x241.google.com with SMTP id t12so138813pfg.2
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 19:14:16 -0800 (PST)
Received: from cloudburst.twiddle.net (97-113-183-164.tukw.qwest.net.
	[97.113.183.164]) by smtp.gmail.com with ESMTPSA id
	g10sm17740595pfe.77.2018.01.05.19.14.13 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 05 Jan 2018 19:14:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  5 Jan 2018 19:13:39 -0800
Message-Id: <20180106031346.6650-17-richard.henderson@linaro.org>
In-Reply-To: <20180106031346.6650-1-richard.henderson@linaro.org>
References: <20180106031346.6650-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v8 16/23] target/arm: Use vector infrastructure
 for aa64 dup/movi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 83 +++++++++++++++++++---------------------------
 1 file changed, 34 insertions(+), 49 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index bc14c28e71..55a4902fc2 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5846,38 +5846,24 @@ static void disas_simd_across_lanes(DisasContext *s, uint32_t insn)
  *
  * size: encoded in imm5 (see ARM ARM LowestSetBit())
  */
+
 static void handle_simd_dupe(DisasContext *s, int is_q, int rd, int rn,
                              int imm5)
 {
     int size = ctz32(imm5);
-    int esize = 8 << size;
-    int elements = (is_q ? 128 : 64) / esize;
-    int index, i;
-    TCGv_i64 tmp;
+    int index = imm5 >> (size + 1);
 
     if (size > 3 || (size == 3 && !is_q)) {
         unallocated_encoding(s);
         return;
     }
-
     if (!fp_access_check(s)) {
         return;
     }
 
-    index = imm5 >> (size + 1);
-
-    tmp = tcg_temp_new_i64();
-    read_vec_element(s, tmp, rn, index, size);
-
-    for (i = 0; i < elements; i++) {
-        write_vec_element(s, tmp, rd, i, size);
-    }
-
-    if (!is_q) {
-        clear_vec_high(s, rd);
-    }
-
-    tcg_temp_free_i64(tmp);
+    tcg_gen_gvec_dup_mem(size, vec_full_reg_offset(s, rd),
+                         vec_reg_offset(s, rn, index, size),
+                         is_q ? 16 : 8, vec_full_reg_size(s));
 }
 
 /* DUP (element, scalar)
@@ -5926,9 +5912,7 @@ static void handle_simd_dupg(DisasContext *s, int is_q, int rd, int rn,
                              int imm5)
 {
     int size = ctz32(imm5);
-    int esize = 8 << size;
-    int elements = (is_q ? 128 : 64)/esize;
-    int i = 0;
+    uint32_t dofs, oprsz, maxsz;
 
     if (size > 3 || ((size == 3) && !is_q)) {
         unallocated_encoding(s);
@@ -5939,12 +5923,11 @@ static void handle_simd_dupg(DisasContext *s, int is_q, int rd, int rn,
         return;
     }
 
-    for (i = 0; i < elements; i++) {
-        write_vec_element(s, cpu_reg(s, rn), rd, i, size);
-    }
-    if (!is_q) {
-        clear_vec_high(s, rd);
-    }
+    dofs = vec_full_reg_offset(s, rd);
+    oprsz = is_q ? 16 : 8;
+    maxsz = vec_full_reg_size(s);
+
+    tcg_gen_gvec_dup_i64(size, dofs, oprsz, maxsz, cpu_reg(s, rn));
 }
 
 /* INS (Element)
@@ -6135,7 +6118,6 @@ static void disas_simd_mod_imm(DisasContext *s, uint32_t insn)
     bool is_neg = extract32(insn, 29, 1);
     bool is_q = extract32(insn, 30, 1);
     uint64_t imm = 0;
-    TCGv_i64 tcg_rd, tcg_imm;
     int i;
 
     if (o2 != 0 || ((cmode == 0xf) && is_neg && !is_q)) {
@@ -6217,32 +6199,35 @@ static void disas_simd_mod_imm(DisasContext *s, uint32_t insn)
         imm = ~imm;
     }
 
-    tcg_imm = tcg_const_i64(imm);
-    tcg_rd = new_tmp_a64(s);
+    if (!((cmode & 0x9) == 0x1 || (cmode & 0xd) == 0x9)) {
+        /* MOVI or MVNI, with MVNI negation handled above.  */
+        tcg_gen_gvec_dup64i(vec_full_reg_offset(s, rd), is_q ? 16 : 8,
+                            vec_full_reg_size(s), imm);
+    } else {
+        TCGv_i64 tcg_imm = tcg_const_i64(imm);
+        TCGv_i64 tcg_rd = new_tmp_a64(s);
 
-    for (i = 0; i < 2; i++) {
-        int foffs = i ? fp_reg_hi_offset(s, rd) : fp_reg_offset(s, rd, MO_64);
+        for (i = 0; i < 2; i++) {
+            int foffs = vec_reg_offset(s, rd, i, MO_64);
 
-        if (i == 1 && !is_q) {
-            /* non-quad ops clear high half of vector */
-            tcg_gen_movi_i64(tcg_rd, 0);
-        } else if ((cmode & 0x9) == 0x1 || (cmode & 0xd) == 0x9) {
-            tcg_gen_ld_i64(tcg_rd, cpu_env, foffs);
-            if (is_neg) {
-                /* AND (BIC) */
-                tcg_gen_and_i64(tcg_rd, tcg_rd, tcg_imm);
+            if (i == 1 && !is_q) {
+                /* non-quad ops clear high half of vector */
+                tcg_gen_movi_i64(tcg_rd, 0);
             } else {
-                /* ORR */
-                tcg_gen_or_i64(tcg_rd, tcg_rd, tcg_imm);
+                tcg_gen_ld_i64(tcg_rd, cpu_env, foffs);
+                if (is_neg) {
+                    /* AND (BIC) */
+                    tcg_gen_and_i64(tcg_rd, tcg_rd, tcg_imm);
+                } else {
+                    /* ORR */
+                    tcg_gen_or_i64(tcg_rd, tcg_rd, tcg_imm);
+                }
             }
-        } else {
-            /* MOVI */
-            tcg_gen_mov_i64(tcg_rd, tcg_imm);
+            tcg_gen_st_i64(tcg_rd, cpu_env, foffs);
         }
-        tcg_gen_st_i64(tcg_rd, cpu_env, foffs);
-    }
 
-    tcg_temp_free_i64(tcg_imm);
+        tcg_temp_free_i64(tcg_imm);
+    }
 }
 
 /* AdvSIMD scalar copy
-- 
2.14.3
