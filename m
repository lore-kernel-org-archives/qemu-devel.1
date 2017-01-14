Received: from eggs.gnu.org ([2001:4830:134:3::10]:50512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cSKJv-00036W-6f
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 04:08:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cSKJu-00037X-1g
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 04:08:19 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:50003)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cSKJt-00037H-Nc
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 04:08:17 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Sat, 14 Jan 2017 10:07:52 +0100
Message-Id: <1484384878-29179-4-git-send-email-laurent@vivier.eu>
In-Reply-To: <1484384878-29179-1-git-send-email-laurent@vivier.eu>
References: <1484384878-29179-1-git-send-email-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL v2 3/9] target-m68k: Implement bfffo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

From: Richard Henderson <rth@twiddle.net>

Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-Id: <1479242669-25852-1-git-send-email-rth@twiddle.net>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/helper.h    |  3 +++
 target/m68k/op_helper.c | 21 +++++++++++++++++++++
 target/m68k/translate.c | 39 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index eb11945..d7a4bf1 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -51,9 +51,12 @@ DEF_HELPER_2(set_ccr, void, env, i32)
 DEF_HELPER_FLAGS_1(get_ccr, TCG_CALL_NO_WG_SE, i32, env)
 DEF_HELPER_2(raise_exception, void, env, i32)
 
+DEF_HELPER_FLAGS_3(bfffo_reg, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
+
 DEF_HELPER_FLAGS_4(bfexts_mem, TCG_CALL_NO_WG, i32, env, i32, s32, i32)
 DEF_HELPER_FLAGS_4(bfextu_mem, TCG_CALL_NO_WG, i64, env, i32, s32, i32)
 DEF_HELPER_FLAGS_5(bfins_mem, TCG_CALL_NO_WG, i32, env, i32, i32, s32, i32)
 DEF_HELPER_FLAGS_4(bfchg_mem, TCG_CALL_NO_WG, i32, env, i32, s32, i32)
 DEF_HELPER_FLAGS_4(bfclr_mem, TCG_CALL_NO_WG, i32, env, i32, s32, i32)
 DEF_HELPER_FLAGS_4(bfset_mem, TCG_CALL_NO_WG, i32, env, i32, s32, i32)
+DEF_HELPER_FLAGS_4(bfffo_mem, TCG_CALL_NO_WG, i64, env, i32, s32, i32)
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 51b9e00..7b5126c 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -654,3 +654,24 @@ uint32_t HELPER(bfset_mem)(CPUM68KState *env, uint32_t addr,
 
     return ((data & mask) << d.bofs) >> 32;
 }
+
+uint32_t HELPER(bfffo_reg)(uint32_t n, uint32_t ofs, uint32_t len)
+{
+    return (n ? clz32(n) : len) + ofs;
+}
+
+uint64_t HELPER(bfffo_mem)(CPUM68KState *env, uint32_t addr,
+                           int32_t ofs, uint32_t len)
+{
+    uintptr_t ra = GETPC();
+    struct bf_data d = bf_prep(addr, ofs, len);
+    uint64_t data = bf_load(env, d.addr, d.blen, ra);
+    uint64_t mask = -1ull << (64 - d.len) >> d.bofs;
+    uint64_t n = (data & mask) << d.bofs;
+    uint32_t ffo = helper_bfffo_reg(n >> 32, ofs, d.len);
+
+    /* Return FFO in the low word and N in the high word.
+       Note that because of MASK and the shift, the low word
+       is already zero.  */
+    return n | ffo;
+}
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index fe44fda..5f7357e 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -3625,7 +3625,14 @@ DISAS_INSN(bfop_reg)
     TCGv src = DREG(insn, 0);
     int len = ((extract32(ext, 0, 5) - 1) & 31) + 1;
     int ofs = extract32(ext, 6, 5);  /* big bit-endian */
-    TCGv mask;
+    TCGv mask, tofs, tlen;
+
+    TCGV_UNUSED(tofs);
+    TCGV_UNUSED(tlen);
+    if ((insn & 0x0f00) == 0x0d00) { /* bfffo */
+        tofs = tcg_temp_new();
+        tlen = tcg_temp_new();
+    }
 
     if ((ext & 0x820) == 0) {
         /* Immediate width and offset.  */
@@ -3637,6 +3644,10 @@ DISAS_INSN(bfop_reg)
         }
         tcg_gen_andi_i32(QREG_CC_N, QREG_CC_N, ~maski);
         mask = tcg_const_i32(ror32(maski, ofs));
+        if (!TCGV_IS_UNUSED(tofs)) {
+            tcg_gen_movi_i32(tofs, ofs);
+            tcg_gen_movi_i32(tlen, len);
+        }
     } else {
         TCGv tmp = tcg_temp_new();
         if (ext & 0x20) {
@@ -3645,9 +3656,15 @@ DISAS_INSN(bfop_reg)
             tcg_gen_andi_i32(tmp, tmp, 31);
             mask = tcg_const_i32(0x7fffffffu);
             tcg_gen_shr_i32(mask, mask, tmp);
+            if (!TCGV_IS_UNUSED(tlen)) {
+                tcg_gen_addi_i32(tlen, tmp, 1);
+            }
         } else {
             /* Immediate width */
             mask = tcg_const_i32(0x7fffffffu >> (len - 1));
+            if (!TCGV_IS_UNUSED(tlen)) {
+                tcg_gen_movi_i32(tlen, len);
+            }
         }
         if (ext & 0x800) {
             /* Variable offset */
@@ -3655,11 +3672,17 @@ DISAS_INSN(bfop_reg)
             tcg_gen_rotl_i32(QREG_CC_N, src, tmp);
             tcg_gen_andc_i32(QREG_CC_N, QREG_CC_N, mask);
             tcg_gen_rotr_i32(mask, mask, tmp);
+            if (!TCGV_IS_UNUSED(tofs)) {
+                tcg_gen_mov_i32(tofs, tmp);
+            }
         } else {
             /* Immediate offset (and variable width) */
             tcg_gen_rotli_i32(QREG_CC_N, src, ofs);
             tcg_gen_andc_i32(QREG_CC_N, QREG_CC_N, mask);
             tcg_gen_rotri_i32(mask, mask, ofs);
+            if (!TCGV_IS_UNUSED(tofs)) {
+                tcg_gen_movi_i32(tofs, ofs);
+            }
         }
         tcg_temp_free(tmp);
     }
@@ -3672,6 +3695,11 @@ DISAS_INSN(bfop_reg)
     case 0x0c00: /* bfclr */
         tcg_gen_and_i32(src, src, mask);
         break;
+    case 0x0d00: /* bfffo */
+        gen_helper_bfffo_reg(DREG(ext, 12), QREG_CC_N, tofs, tlen);
+        tcg_temp_free(tlen);
+        tcg_temp_free(tofs);
+        break;
     case 0x0e00: /* bfset */
         tcg_gen_orc_i32(src, src, mask);
         break;
@@ -3688,6 +3716,7 @@ DISAS_INSN(bfop_mem)
 {
     int ext = read_im16(env, s);
     TCGv addr, len, ofs;
+    TCGv_i64 t64;
 
     addr = gen_lea(env, s, insn, OS_UNSIZED);
     if (IS_NULL_QREG(addr)) {
@@ -3713,6 +3742,12 @@ DISAS_INSN(bfop_mem)
     case 0x0c00: /* bfclr */
         gen_helper_bfclr_mem(QREG_CC_N, cpu_env, addr, ofs, len);
         break;
+    case 0x0d00: /* bfffo */
+        t64 = tcg_temp_new_i64();
+        gen_helper_bfffo_mem(t64, cpu_env, addr, ofs, len);
+        tcg_gen_extr_i64_i32(DREG(ext, 12), QREG_CC_N, t64);
+        tcg_temp_free_i64(t64);
+        break;
     case 0x0e00: /* bfset */
         gen_helper_bfset_mem(QREG_CC_N, cpu_env, addr, ofs, len);
         break;
@@ -4939,6 +4974,8 @@ void register_m68k_insns (CPUM68KState *env)
     INSN(bfop_reg, eac0, fff8, BITFIELD);   /* bfchg */
     INSN(bfop_mem, ecc0, ffc0, BITFIELD);   /* bfclr */
     INSN(bfop_reg, ecc0, fff8, BITFIELD);   /* bfclr */
+    INSN(bfop_mem, edc0, ffc0, BITFIELD);   /* bfffo */
+    INSN(bfop_reg, edc0, fff8, BITFIELD);   /* bfffo */
     INSN(bfop_mem, eec0, ffc0, BITFIELD);   /* bfset */
     INSN(bfop_reg, eec0, fff8, BITFIELD);   /* bfset */
     INSN(bfop_mem, e8c0, ffc0, BITFIELD);   /* bftst */
-- 
2.7.4
