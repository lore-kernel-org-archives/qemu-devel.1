Received: from eggs.gnu.org ([2001:4830:134:3::10]:45121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwn-0006po-LY
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwk-0005se-RX
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:41 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:42105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gAhwk-0005UB-A7
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:38 -0400
Received: by mail-pg1-x530.google.com with SMTP id i4-v6so4724898pgq.9
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 13:52:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 11 Oct 2018 13:52:03 -0700
Message-Id: <20181011205206.3552-18-richard.henderson@linaro.org>
In-Reply-To: <20181011205206.3552-1-richard.henderson@linaro.org>
References: <20181011205206.3552-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 17/20] target/arm: Use gvec for NEON VLD all
 lanes
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
 target/arm/translate.c | 81 ++++++++++++++----------------------------
 1 file changed, 26 insertions(+), 55 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index a9bd93bba1..1e79a1eec0 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -2993,19 +2993,6 @@ static void gen_vfp_msr(TCGv_i32 tmp)
     tcg_temp_free_i32(tmp);
 }
 
-static void gen_neon_dup_u8(TCGv_i32 var, int shift)
-{
-    TCGv_i32 tmp = tcg_temp_new_i32();
-    if (shift)
-        tcg_gen_shri_i32(var, var, shift);
-    tcg_gen_ext8u_i32(var, var);
-    tcg_gen_shli_i32(tmp, var, 8);
-    tcg_gen_or_i32(var, var, tmp);
-    tcg_gen_shli_i32(tmp, var, 16);
-    tcg_gen_or_i32(var, var, tmp);
-    tcg_temp_free_i32(tmp);
-}
-
 static void gen_neon_dup_low16(TCGv_i32 var)
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
@@ -3024,28 +3011,6 @@ static void gen_neon_dup_high16(TCGv_i32 var)
     tcg_temp_free_i32(tmp);
 }
 
-static TCGv_i32 gen_load_and_replicate(DisasContext *s, TCGv_i32 addr, int size)
-{
-    /* Load a single Neon element and replicate into a 32 bit TCG reg */
-    TCGv_i32 tmp = tcg_temp_new_i32();
-    switch (size) {
-    case 0:
-        gen_aa32_ld8u(s, tmp, addr, get_mem_index(s));
-        gen_neon_dup_u8(tmp, 0);
-        break;
-    case 1:
-        gen_aa32_ld16u(s, tmp, addr, get_mem_index(s));
-        gen_neon_dup_low16(tmp);
-        break;
-    case 2:
-        gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
-        break;
-    default: /* Avoid compiler warnings.  */
-        abort();
-    }
-    return tmp;
-}
-
 static int handle_vsel(uint32_t insn, uint32_t rd, uint32_t rn, uint32_t rm,
                        uint32_t dp)
 {
@@ -4949,6 +4914,7 @@ static int disas_neon_ls_insn(DisasContext *s, uint32_t insn)
     int load;
     int shift;
     int n;
+    int vec_size;
     TCGv_i32 addr;
     TCGv_i32 tmp;
     TCGv_i32 tmp2;
@@ -5118,28 +5084,33 @@ static int disas_neon_ls_insn(DisasContext *s, uint32_t insn)
             }
             addr = tcg_temp_new_i32();
             load_reg_var(s, addr, rn);
-            if (nregs == 1) {
-                /* VLD1 to all lanes: bit 5 indicates how many Dregs to write */
-                tmp = gen_load_and_replicate(s, addr, size);
-                tcg_gen_st_i32(tmp, cpu_env, neon_reg_offset(rd, 0));
-                tcg_gen_st_i32(tmp, cpu_env, neon_reg_offset(rd, 1));
-                if (insn & (1 << 5)) {
-                    tcg_gen_st_i32(tmp, cpu_env, neon_reg_offset(rd + 1, 0));
-                    tcg_gen_st_i32(tmp, cpu_env, neon_reg_offset(rd + 1, 1));
-                }
-                tcg_temp_free_i32(tmp);
-            } else {
-                /* VLD2/3/4 to all lanes: bit 5 indicates register stride */
-                stride = (insn & (1 << 5)) ? 2 : 1;
-                for (reg = 0; reg < nregs; reg++) {
-                    tmp = gen_load_and_replicate(s, addr, size);
-                    tcg_gen_st_i32(tmp, cpu_env, neon_reg_offset(rd, 0));
-                    tcg_gen_st_i32(tmp, cpu_env, neon_reg_offset(rd, 1));
-                    tcg_temp_free_i32(tmp);
-                    tcg_gen_addi_i32(addr, addr, 1 << size);
-                    rd += stride;
+
+            /* VLD1 to all lanes: bit 5 indicates how many Dregs to write.
+             * VLD2/3/4 to all lanes: bit 5 indicates register stride.
+             */
+            stride = insn & (1 << 5) ? 2 : 1;
+            vec_size = nregs == 1 ? stride * 8 : 8;
+
+            tmp = tcg_temp_new_i32();
+            for (reg = 0; reg < nregs; reg++) {
+                gen_aa32_ld_i32(s, tmp, addr, get_mem_index(s),
+                                s->be_data | size);
+                if ((rd & 1) && vec_size == 16) {
+                    /* We cannot write 16 bytes at once because the
+                     * destination is unaligned.
+                     */
+                    tcg_gen_gvec_dup_i32(size, neon_reg_offset(rd, 0),
+                                         8, 8, tmp);
+                    tcg_gen_gvec_mov(0, neon_reg_offset(rd + 1, 0),
+                                     neon_reg_offset(rd, 0), 8, 8);
+                } else {
+                    tcg_gen_gvec_dup_i32(size, neon_reg_offset(rd, 0),
+                                         vec_size, vec_size, tmp);
                 }
+                tcg_gen_addi_i32(addr, addr, 1 << size);
+                rd += stride;
             }
+            tcg_temp_free_i32(tmp);
             tcg_temp_free_i32(addr);
             stride = (1 << size) * nregs;
         } else {
-- 
2.17.1
