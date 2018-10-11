Received: from eggs.gnu.org ([2001:4830:134:3::10]:45197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwq-0006sC-2O
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwm-0005zz-72
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:43 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gAhwl-0003SW-Mi
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:39 -0400
Received: by mail-pf1-x443.google.com with SMTP id s5-v6so5005658pfj.7
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 13:52:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 11 Oct 2018 13:51:50 -0700
Message-Id: <20181011205206.3552-5-richard.henderson@linaro.org>
In-Reply-To: <20181011205206.3552-1-richard.henderson@linaro.org>
References: <20181011205206.3552-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 04/20] target/arm: Promote consecutive memory
 ops for aa64
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

For a sequence of loads or stores from a single register,
little-endian operations can be promoted to an 8-byte op.
This can reduce the number of operations by a factor of 8.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 66 +++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 26 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index fff99ca303..2f4041462e 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1200,25 +1200,23 @@ static void write_vec_element_i32(DisasContext *s, TCGv_i32 tcg_src,
 
 /* Store from vector register to memory */
 static void do_vec_st(DisasContext *s, int srcidx, int element,
-                      TCGv_i64 tcg_addr, int size)
+                      TCGv_i64 tcg_addr, int size, TCGMemOp endian)
 {
-    TCGMemOp memop = s->be_data + size;
     TCGv_i64 tcg_tmp = tcg_temp_new_i64();
 
     read_vec_element(s, tcg_tmp, srcidx, element, size);
-    tcg_gen_qemu_st_i64(tcg_tmp, tcg_addr, get_mem_index(s), memop);
+    tcg_gen_qemu_st_i64(tcg_tmp, tcg_addr, get_mem_index(s), endian | size);
 
     tcg_temp_free_i64(tcg_tmp);
 }
 
 /* Load from memory to vector register */
 static void do_vec_ld(DisasContext *s, int destidx, int element,
-                      TCGv_i64 tcg_addr, int size)
+                      TCGv_i64 tcg_addr, int size, TCGMemOp endian)
 {
-    TCGMemOp memop = s->be_data + size;
     TCGv_i64 tcg_tmp = tcg_temp_new_i64();
 
-    tcg_gen_qemu_ld_i64(tcg_tmp, tcg_addr, get_mem_index(s), memop);
+    tcg_gen_qemu_ld_i64(tcg_tmp, tcg_addr, get_mem_index(s), endian | size);
     write_vec_element(s, tcg_tmp, destidx, element, size);
 
     tcg_temp_free_i64(tcg_tmp);
@@ -3013,9 +3011,10 @@ static void disas_ldst_multiple_struct(DisasContext *s, uint32_t insn)
     bool is_postidx = extract32(insn, 23, 1);
     bool is_q = extract32(insn, 30, 1);
     TCGv_i64 tcg_addr, tcg_rn, tcg_ebytes;
+    TCGMemOp endian = s->be_data;
 
-    int ebytes = 1 << size;
-    int elements = (is_q ? 128 : 64) / (8 << size);
+    int ebytes;   /* bytes per element */
+    int elements; /* elements per vector */
     int rpt;    /* num iterations */
     int selem;  /* structure elements */
     int r;
@@ -3074,6 +3073,20 @@ static void disas_ldst_multiple_struct(DisasContext *s, uint32_t insn)
         gen_check_sp_alignment(s);
     }
 
+    /* For our purposes, bytes are always little-endian.  */
+    if (size == 0) {
+        endian = MO_LE;
+    }
+
+    /* Consecutive little-endian elements from a single register
+     * can be promoted to a larger little-endian operation.
+     */
+    if (selem == 1 && endian == MO_LE) {
+        size = 3;
+    }
+    ebytes = 1 << size;
+    elements = (is_q ? 16 : 8) / ebytes;
+
     tcg_rn = cpu_reg_sp(s, rn);
     tcg_addr = tcg_temp_new_i64();
     tcg_gen_mov_i64(tcg_addr, tcg_rn);
@@ -3082,32 +3095,33 @@ static void disas_ldst_multiple_struct(DisasContext *s, uint32_t insn)
     for (r = 0; r < rpt; r++) {
         int e;
         for (e = 0; e < elements; e++) {
-            int tt = (rt + r) % 32;
             int xs;
             for (xs = 0; xs < selem; xs++) {
+                int tt = (rt + r + xs) % 32;
                 if (is_store) {
-                    do_vec_st(s, tt, e, tcg_addr, size);
+                    do_vec_st(s, tt, e, tcg_addr, size, endian);
                 } else {
-                    do_vec_ld(s, tt, e, tcg_addr, size);
-
-                    /* For non-quad operations, setting a slice of the low
-                     * 64 bits of the register clears the high 64 bits (in
-                     * the ARM ARM pseudocode this is implicit in the fact
-                     * that 'rval' is a 64 bit wide variable).
-                     * For quad operations, we might still need to zero the
-                     * high bits of SVE.  We optimize by noticing that we only
-                     * need to do this the first time we touch a register.
-                     */
-                    if (e == 0 && (r == 0 || xs == selem - 1)) {
-                        clear_vec_high(s, is_q, tt);
-                    }
+                    do_vec_ld(s, tt, e, tcg_addr, size, endian);
                 }
                 tcg_gen_add_i64(tcg_addr, tcg_addr, tcg_ebytes);
-                tt = (tt + 1) % 32;
             }
         }
     }
 
+    if (!is_store) {
+        /* For non-quad operations, setting a slice of the low
+         * 64 bits of the register clears the high 64 bits (in
+         * the ARM ARM pseudocode this is implicit in the fact
+         * that 'rval' is a 64 bit wide variable).
+         * For quad operations, we might still need to zero the
+         * high bits of SVE.
+         */
+        for (r = 0; r < rpt * selem; r++) {
+            int tt = (rt + r) % 32;
+            clear_vec_high(s, is_q, tt);
+        }
+    }
+
     if (is_postidx) {
         int rm = extract32(insn, 16, 5);
         if (rm == 31) {
@@ -3228,9 +3242,9 @@ static void disas_ldst_single_struct(DisasContext *s, uint32_t insn)
         } else {
             /* Load/store one element per register */
             if (is_load) {
-                do_vec_ld(s, rt, index, tcg_addr, scale);
+                do_vec_ld(s, rt, index, tcg_addr, scale, s->be_data);
             } else {
-                do_vec_st(s, rt, index, tcg_addr, scale);
+                do_vec_st(s, rt, index, tcg_addr, scale, s->be_data);
             }
         }
         tcg_gen_add_i64(tcg_addr, tcg_addr, tcg_ebytes);
-- 
2.17.1
