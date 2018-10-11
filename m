Received: from eggs.gnu.org ([2001:4830:134:3::10]:45177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwp-0006rX-Br
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwm-00060Z-7r
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:43 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:46461)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gAhwl-0003tU-NU
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:39 -0400
Received: by mail-pf1-x430.google.com with SMTP id r64-v6so4992364pfb.13
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 13:52:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 11 Oct 2018 13:51:53 -0700
Message-Id: <20181011205206.3552-8-richard.henderson@linaro.org>
In-Reply-To: <20181011205206.3552-1-richard.henderson@linaro.org>
References: <20181011205206.3552-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 07/20] target/arm: Use gvec for NEON VMOV, VMVN,
 VBIC & VORR (immediate)
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
 target/arm/translate.c | 67 ++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 28 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4ac526e298..109689a286 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -6641,7 +6641,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 return 1;
             }
         } else { /* (insn & 0x00380080) == 0 */
-            int invert;
+            int invert, reg_ofs, vec_size;
+
             if (q && (rd & 1)) {
                 return 1;
             }
@@ -6681,8 +6682,9 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 break;
             case 14:
                 imm |= (imm << 8) | (imm << 16) | (imm << 24);
-                if (invert)
+                if (invert) {
                     imm = ~imm;
+                }
                 break;
             case 15:
                 if (invert) {
@@ -6692,36 +6694,45 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                       | ((imm & 0x40) ? (0x1f << 25) : (1 << 30));
                 break;
             }
-            if (invert)
+            if (invert) {
                 imm = ~imm;
+            }
 
-            for (pass = 0; pass < (q ? 4 : 2); pass++) {
-                if (op & 1 && op < 12) {
-                    tmp = neon_load_reg(rd, pass);
-                    if (invert) {
-                        /* The immediate value has already been inverted, so
-                           BIC becomes AND.  */
-                        tcg_gen_andi_i32(tmp, tmp, imm);
-                    } else {
-                        tcg_gen_ori_i32(tmp, tmp, imm);
-                    }
+            reg_ofs = neon_reg_offset(rd, 0);
+            vec_size = q ? 16 : 8;
+
+            if (op & 1 && op < 12) {
+                if (invert) {
+                    /* The immediate value has already been inverted,
+                     * so BIC becomes AND.
+                     */
+                    tcg_gen_gvec_andi(MO_32, reg_ofs, reg_ofs, imm,
+                                      vec_size, vec_size);
                 } else {
-                    /* VMOV, VMVN.  */
-                    tmp = tcg_temp_new_i32();
-                    if (op == 14 && invert) {
-                        int n;
-                        uint32_t val;
-                        val = 0;
-                        for (n = 0; n < 4; n++) {
-                            if (imm & (1 << (n + (pass & 1) * 4)))
-                                val |= 0xff << (n * 8);
-                        }
-                        tcg_gen_movi_i32(tmp, val);
-                    } else {
-                        tcg_gen_movi_i32(tmp, imm);
-                    }
+                    tcg_gen_gvec_ori(MO_32, reg_ofs, reg_ofs, imm,
+                                     vec_size, vec_size);
+                }
+            } else {
+                /* VMOV, VMVN.  */
+                if (op == 14 && invert) {
+                    TCGv_i64 t64 = tcg_temp_new_i64();
+
+                    for (pass = 0; pass <= q; ++pass) {
+                        uint64_t val = 0;
+                        int n;
+
+                        for (n = 0; n < 8; n++) {
+                            if (imm & (1 << (n + pass * 8))) {
+                                val |= 0xffull << (n * 8);
+                            }
+                        }
+                        tcg_gen_movi_i64(t64, val);
+                        neon_store_reg64(t64, rd + pass);
+                    }
+                    tcg_temp_free_i64(t64);
+                } else {
+                    tcg_gen_gvec_dup32i(reg_ofs, vec_size, vec_size, imm);
                 }
-                neon_store_reg(rd, pass, tmp);
             }
         }
     } else { /* (insn & 0x00800010 == 0x00800000) */
-- 
2.17.1
