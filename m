Received: from eggs.gnu.org ([2001:4830:134:3::10]:45122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwn-0006pr-Lq
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwl-0005ux-Cq
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:41 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:36424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gAhwk-0005d6-Su
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:39 -0400
Received: by mail-pf1-x435.google.com with SMTP id l81-v6so5011983pfg.3
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 13:52:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 11 Oct 2018 13:52:04 -0700
Message-Id: <20181011205206.3552-19-richard.henderson@linaro.org>
In-Reply-To: <20181011205206.3552-1-richard.henderson@linaro.org>
References: <20181011205206.3552-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 18/20] target/arm: Reorg NEON VLD/VST all
 elements
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

Instead of shifts and masks, use direct loads and stores from the neon
register file.  Mirror the iteration structure of the ARM pseudocode
more closely.  Correct the parameters of the VLD2 A2 insn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 170 ++++++++++++++++++-----------------------
 1 file changed, 74 insertions(+), 96 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 1e79a1eec0..12a744b3c3 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1611,12 +1611,56 @@ static TCGv_i32 neon_load_reg(int reg, int pass)
     return tmp;
 }
 
+static void neon_load_element64(TCGv_i64 var, int reg, int ele, TCGMemOp mop)
+{
+    long offset = neon_element_offset(reg, ele, mop & MO_SIZE);
+
+    switch (mop) {
+    case MO_UB:
+        tcg_gen_ld8u_i64(var, cpu_env, offset);
+        break;
+    case MO_UW:
+        tcg_gen_ld16u_i64(var, cpu_env, offset);
+        break;
+    case MO_UL:
+        tcg_gen_ld32u_i64(var, cpu_env, offset);
+        break;
+    case MO_Q:
+        tcg_gen_ld_i64(var, cpu_env, offset);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static void neon_store_reg(int reg, int pass, TCGv_i32 var)
 {
     tcg_gen_st_i32(var, cpu_env, neon_reg_offset(reg, pass));
     tcg_temp_free_i32(var);
 }
 
+static void neon_store_element64(int reg, int ele, TCGMemOp size, TCGv_i64 var)
+{
+    long offset = neon_element_offset(reg, ele, size);
+
+    switch (size) {
+    case MO_8:
+        tcg_gen_st8_i64(var, cpu_env, offset);
+        break;
+    case MO_16:
+        tcg_gen_st16_i64(var, cpu_env, offset);
+        break;
+    case MO_32:
+        tcg_gen_st32_i64(var, cpu_env, offset);
+        break;
+    case MO_64:
+        tcg_gen_st_i64(var, cpu_env, offset);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static inline void neon_load_reg64(TCGv_i64 var, int reg)
 {
     tcg_gen_ld_i64(var, cpu_env, vfp_reg_offset(1, reg));
@@ -4885,16 +4929,16 @@ static struct {
     int interleave;
     int spacing;
 } const neon_ls_element_type[11] = {
-    {4, 4, 1},
-    {4, 4, 2},
+    {1, 4, 1},
+    {1, 4, 2},
     {4, 1, 1},
-    {4, 2, 1},
-    {3, 3, 1},
-    {3, 3, 2},
+    {2, 2, 2},
+    {1, 3, 1},
+    {1, 3, 2},
     {3, 1, 1},
     {1, 1, 1},
-    {2, 2, 1},
-    {2, 2, 2},
+    {1, 2, 1},
+    {1, 2, 2},
     {2, 1, 1}
 };
 
@@ -4915,6 +4959,8 @@ static int disas_neon_ls_insn(DisasContext *s, uint32_t insn)
     int shift;
     int n;
     int vec_size;
+    int mmu_idx;
+    TCGMemOp endian;
     TCGv_i32 addr;
     TCGv_i32 tmp;
     TCGv_i32 tmp2;
@@ -4936,6 +4982,8 @@ static int disas_neon_ls_insn(DisasContext *s, uint32_t insn)
     rn = (insn >> 16) & 0xf;
     rm = insn & 0xf;
     load = (insn & (1 << 21)) != 0;
+    endian = s->be_data;
+    mmu_idx = get_mem_index(s);
     if ((insn & (1 << 23)) == 0) {
         /* Load store all elements.  */
         op = (insn >> 8) & 0xf;
@@ -4960,104 +5008,34 @@ static int disas_neon_ls_insn(DisasContext *s, uint32_t insn)
         nregs = neon_ls_element_type[op].nregs;
         interleave = neon_ls_element_type[op].interleave;
         spacing = neon_ls_element_type[op].spacing;
-        if (size == 3 && (interleave | spacing) != 1)
+        if (size == 3 && (interleave | spacing) != 1) {
             return 1;
+        }
+        tmp64 = tcg_temp_new_i64();
         addr = tcg_temp_new_i32();
+        tmp2 = tcg_const_i32(1 << size);
         load_reg_var(s, addr, rn);
-        stride = (1 << size) * interleave;
         for (reg = 0; reg < nregs; reg++) {
-            if (interleave > 2 || (interleave == 2 && nregs == 2)) {
-                load_reg_var(s, addr, rn);
-                tcg_gen_addi_i32(addr, addr, (1 << size) * reg);
-            } else if (interleave == 2 && nregs == 4 && reg == 2) {
-                load_reg_var(s, addr, rn);
-                tcg_gen_addi_i32(addr, addr, 1 << size);
-            }
-            if (size == 3) {
-                tmp64 = tcg_temp_new_i64();
-                if (load) {
-                    gen_aa32_ld64(s, tmp64, addr, get_mem_index(s));
-                    neon_store_reg64(tmp64, rd);
-                } else {
-                    neon_load_reg64(tmp64, rd);
-                    gen_aa32_st64(s, tmp64, addr, get_mem_index(s));
-                }
-                tcg_temp_free_i64(tmp64);
-                tcg_gen_addi_i32(addr, addr, stride);
-            } else {
-                for (pass = 0; pass < 2; pass++) {
-                    if (size == 2) {
-                        if (load) {
-                            tmp = tcg_temp_new_i32();
-                            gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
-                            neon_store_reg(rd, pass, tmp);
-                        } else {
-                            tmp = neon_load_reg(rd, pass);
-                            gen_aa32_st32(s, tmp, addr, get_mem_index(s));
-                            tcg_temp_free_i32(tmp);
-                        }
-                        tcg_gen_addi_i32(addr, addr, stride);
-                    } else if (size == 1) {
-                        if (load) {
-                            tmp = tcg_temp_new_i32();
-                            gen_aa32_ld16u(s, tmp, addr, get_mem_index(s));
-                            tcg_gen_addi_i32(addr, addr, stride);
-                            tmp2 = tcg_temp_new_i32();
-                            gen_aa32_ld16u(s, tmp2, addr, get_mem_index(s));
-                            tcg_gen_addi_i32(addr, addr, stride);
-                            tcg_gen_shli_i32(tmp2, tmp2, 16);
-                            tcg_gen_or_i32(tmp, tmp, tmp2);
-                            tcg_temp_free_i32(tmp2);
-                            neon_store_reg(rd, pass, tmp);
-                        } else {
-                            tmp = neon_load_reg(rd, pass);
-                            tmp2 = tcg_temp_new_i32();
-                            tcg_gen_shri_i32(tmp2, tmp, 16);
-                            gen_aa32_st16(s, tmp, addr, get_mem_index(s));
-                            tcg_temp_free_i32(tmp);
-                            tcg_gen_addi_i32(addr, addr, stride);
-                            gen_aa32_st16(s, tmp2, addr, get_mem_index(s));
-                            tcg_temp_free_i32(tmp2);
-                            tcg_gen_addi_i32(addr, addr, stride);
-                        }
-                    } else /* size == 0 */ {
-                        if (load) {
-                            tmp2 = NULL;
-                            for (n = 0; n < 4; n++) {
-                                tmp = tcg_temp_new_i32();
-                                gen_aa32_ld8u(s, tmp, addr, get_mem_index(s));
-                                tcg_gen_addi_i32(addr, addr, stride);
-                                if (n == 0) {
-                                    tmp2 = tmp;
-                                } else {
-                                    tcg_gen_shli_i32(tmp, tmp, n * 8);
-                                    tcg_gen_or_i32(tmp2, tmp2, tmp);
-                                    tcg_temp_free_i32(tmp);
-                                }
-                            }
-                            neon_store_reg(rd, pass, tmp2);
-                        } else {
-                            tmp2 = neon_load_reg(rd, pass);
-                            for (n = 0; n < 4; n++) {
-                                tmp = tcg_temp_new_i32();
-                                if (n == 0) {
-                                    tcg_gen_mov_i32(tmp, tmp2);
-                                } else {
-                                    tcg_gen_shri_i32(tmp, tmp2, n * 8);
-                                }
-                                gen_aa32_st8(s, tmp, addr, get_mem_index(s));
-                                tcg_temp_free_i32(tmp);
-                                tcg_gen_addi_i32(addr, addr, stride);
-                            }
-                            tcg_temp_free_i32(tmp2);
-                        }
+            for (n = 0; n < 8 >> size; n++) {
+                int xs;
+                for (xs = 0; xs < interleave; xs++) {
+                    int tt = rd + reg + spacing * xs;
+
+                    if (load) {
+                        gen_aa32_ld_i64(s, tmp64, addr, mmu_idx, endian | size);
+                        neon_store_element64(tt, n, size, tmp64);
+                    } else {
+                        neon_load_element64(tmp64, tt, n, size);
+                        gen_aa32_st_i64(s, tmp64, addr, mmu_idx, endian | size);
                     }
+                    tcg_gen_add_i32(addr, addr, tmp2);
                 }
             }
-            rd += spacing;
         }
         tcg_temp_free_i32(addr);
-        stride = nregs * 8;
+        tcg_temp_free_i32(tmp2);
+        tcg_temp_free_i64(tmp64);
+        stride = nregs * interleave * 8;
     } else {
         size = (insn >> 10) & 3;
         if (size == 3) {
-- 
2.17.1
