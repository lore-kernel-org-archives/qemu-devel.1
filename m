Received: from eggs.gnu.org ([2001:4830:134:3::10]:45236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwr-0006tM-A5
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwn-00066o-2N
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:45 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:37227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gAhwm-0005u6-MY
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:40 -0400
Received: by mail-pl1-x62f.google.com with SMTP id u6-v6so2053111plz.4
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 13:52:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 11 Oct 2018 13:52:06 -0700
Message-Id: <20181011205206.3552-21-richard.henderson@linaro.org>
In-Reply-To: <20181011205206.3552-1-richard.henderson@linaro.org>
References: <20181011205206.3552-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 20/20] target/arm: Reorg NEON VLD/VST single
 element to one lane
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

Instead of shifts and masks, use direct loads and stores from
the neon register file.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 92 +++++++++++++++++++++++-------------------
 1 file changed, 50 insertions(+), 42 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 09f2d648b7..0b21c2d201 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1611,6 +1611,25 @@ static TCGv_i32 neon_load_reg(int reg, int pass)
     return tmp;
 }
 
+static void neon_load_element(TCGv_i32 var, int reg, int ele, TCGMemOp mop)
+{
+    long offset = neon_element_offset(reg, ele, mop & MO_SIZE);
+
+    switch (mop) {
+    case MO_UB:
+        tcg_gen_ld8u_i32(var, cpu_env, offset);
+        break;
+    case MO_UW:
+        tcg_gen_ld16u_i32(var, cpu_env, offset);
+        break;
+    case MO_UL:
+        tcg_gen_ld_i32(var, cpu_env, offset);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static void neon_load_element64(TCGv_i64 var, int reg, int ele, TCGMemOp mop)
 {
     long offset = neon_element_offset(reg, ele, mop & MO_SIZE);
@@ -1639,6 +1658,25 @@ static void neon_store_reg(int reg, int pass, TCGv_i32 var)
     tcg_temp_free_i32(var);
 }
 
+static void neon_store_element(int reg, int ele, TCGMemOp size, TCGv_i32 var)
+{
+    long offset = neon_element_offset(reg, ele, size);
+
+    switch (size) {
+    case MO_8:
+        tcg_gen_st8_i32(var, cpu_env, offset);
+        break;
+    case MO_16:
+        tcg_gen_st16_i32(var, cpu_env, offset);
+        break;
+    case MO_32:
+        tcg_gen_st_i32(var, cpu_env, offset);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static void neon_store_element64(int reg, int ele, TCGMemOp size, TCGv_i64 var)
 {
     long offset = neon_element_offset(reg, ele, size);
@@ -4954,9 +4992,7 @@ static int disas_neon_ls_insn(DisasContext *s, uint32_t insn)
     int stride;
     int size;
     int reg;
-    int pass;
     int load;
-    int shift;
     int n;
     int vec_size;
     int mmu_idx;
@@ -5104,18 +5140,18 @@ static int disas_neon_ls_insn(DisasContext *s, uint32_t insn)
         } else {
             /* Single element.  */
             int idx = (insn >> 4) & 0xf;
-            pass = (insn >> 7) & 1;
+            int reg_idx;
             switch (size) {
             case 0:
-                shift = ((insn >> 5) & 3) * 8;
+                reg_idx = (insn >> 5) & 7;
                 stride = 1;
                 break;
             case 1:
-                shift = ((insn >> 6) & 1) * 16;
+                reg_idx = (insn >> 6) & 3;
                 stride = (insn & (1 << 5)) ? 2 : 1;
                 break;
             case 2:
-                shift = 0;
+                reg_idx = (insn >> 7) & 1;
                 stride = (insn & (1 << 6)) ? 2 : 1;
                 break;
             default:
@@ -5155,52 +5191,24 @@ static int disas_neon_ls_insn(DisasContext *s, uint32_t insn)
                  */
                 return 1;
             }
+            tmp = tcg_temp_new_i32();
             addr = tcg_temp_new_i32();
             load_reg_var(s, addr, rn);
             for (reg = 0; reg < nregs; reg++) {
                 if (load) {
-                    tmp = tcg_temp_new_i32();
-                    switch (size) {
-                    case 0:
-                        gen_aa32_ld8u(s, tmp, addr, get_mem_index(s));
-                        break;
-                    case 1:
-                        gen_aa32_ld16u(s, tmp, addr, get_mem_index(s));
-                        break;
-                    case 2:
-                        gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
-                        break;
-                    default: /* Avoid compiler warnings.  */
-                        abort();
-                    }
-                    if (size != 2) {
-                        tmp2 = neon_load_reg(rd, pass);
-                        tcg_gen_deposit_i32(tmp, tmp2, tmp,
-                                            shift, size ? 16 : 8);
-                        tcg_temp_free_i32(tmp2);
-                    }
-                    neon_store_reg(rd, pass, tmp);
+                    gen_aa32_ld_i32(s, tmp, addr, get_mem_index(s),
+                                    s->be_data | size);
+                    neon_store_element(rd, reg_idx, size, tmp);
                 } else { /* Store */
-                    tmp = neon_load_reg(rd, pass);
-                    if (shift)
-                        tcg_gen_shri_i32(tmp, tmp, shift);
-                    switch (size) {
-                    case 0:
-                        gen_aa32_st8(s, tmp, addr, get_mem_index(s));
-                        break;
-                    case 1:
-                        gen_aa32_st16(s, tmp, addr, get_mem_index(s));
-                        break;
-                    case 2:
-                        gen_aa32_st32(s, tmp, addr, get_mem_index(s));
-                        break;
-                    }
-                    tcg_temp_free_i32(tmp);
+                    neon_load_element(tmp, rd, reg_idx, size);
+                    gen_aa32_st_i32(s, tmp, addr, get_mem_index(s),
+                                    s->be_data | size);
                 }
                 rd += stride;
                 tcg_gen_addi_i32(addr, addr, 1 << size);
             }
             tcg_temp_free_i32(addr);
+            tcg_temp_free_i32(tmp);
             stride = nregs * (1 << size);
         }
     }
-- 
2.17.1
