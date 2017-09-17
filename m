Received: from eggs.gnu.org ([2001:4830:134:3::10]:52471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dtb8u-0007zg-LO
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:06:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dtb8t-0008BY-9X
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:05:56 -0400
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:44063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dtb8t-0008BJ-3F
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:05:55 -0400
Received: by mail-oi0-x234.google.com with SMTP id l74so3684483oih.1
	for <qemu-devel@nongnu.org>; Sun, 17 Sep 2017 08:05:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 17 Sep 2017 08:05:25 -0700
Message-Id: <20170917150535.8284-8-richard.henderson@linaro.org>
In-Reply-To: <20170917150535.8284-1-richard.henderson@linaro.org>
References: <20170917150535.8284-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/17] tcg: Add tcg_op_supported
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

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.h |   2 +
 tcg/tcg.c | 227 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 226 insertions(+), 3 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index ac94133870..e342fe614f 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -932,6 +932,8 @@ do {\
 #define tcg_temp_free_ptr(T) tcg_temp_free_i64(TCGV_PTR_TO_NAT(T))
 #endif
 
+bool tcg_op_supported(TCGOpcode op);
+
 void tcg_gen_callN(TCGContext *s, void *func,
                    TCGArg ret, int nargs, TCGArg *args);
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index fd8a3dfe93..b65a73208f 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -749,6 +749,229 @@ int tcg_check_temp_count(void)
 }
 #endif
 
+/* Return true if OP may appear in the opcode stream.
+   Test the runtime variable that controls each opcode.  */
+bool tcg_op_supported(TCGOpcode op)
+{
+    switch (op) {
+    case INDEX_op_discard:
+    case INDEX_op_set_label:
+    case INDEX_op_call:
+    case INDEX_op_br:
+    case INDEX_op_mb:
+    case INDEX_op_insn_start:
+    case INDEX_op_exit_tb:
+    case INDEX_op_goto_tb:
+    case INDEX_op_qemu_ld_i32:
+    case INDEX_op_qemu_st_i32:
+    case INDEX_op_qemu_ld_i64:
+    case INDEX_op_qemu_st_i64:
+        return true;
+
+    case INDEX_op_goto_ptr:
+        return TCG_TARGET_HAS_goto_ptr;
+
+    case INDEX_op_mov_i32:
+    case INDEX_op_movi_i32:
+    case INDEX_op_setcond_i32:
+    case INDEX_op_brcond_i32:
+    case INDEX_op_ld8u_i32:
+    case INDEX_op_ld8s_i32:
+    case INDEX_op_ld16u_i32:
+    case INDEX_op_ld16s_i32:
+    case INDEX_op_ld_i32:
+    case INDEX_op_st8_i32:
+    case INDEX_op_st16_i32:
+    case INDEX_op_st_i32:
+    case INDEX_op_add_i32:
+    case INDEX_op_sub_i32:
+    case INDEX_op_mul_i32:
+    case INDEX_op_and_i32:
+    case INDEX_op_or_i32:
+    case INDEX_op_xor_i32:
+    case INDEX_op_shl_i32:
+    case INDEX_op_shr_i32:
+    case INDEX_op_sar_i32:
+        return true;
+
+    case INDEX_op_movcond_i32:
+        return TCG_TARGET_HAS_movcond_i32;
+    case INDEX_op_div_i32:
+    case INDEX_op_divu_i32:
+        return TCG_TARGET_HAS_div_i32;
+    case INDEX_op_rem_i32:
+    case INDEX_op_remu_i32:
+        return TCG_TARGET_HAS_rem_i32;
+    case INDEX_op_div2_i32:
+    case INDEX_op_divu2_i32:
+        return TCG_TARGET_HAS_div2_i32;
+    case INDEX_op_rotl_i32:
+    case INDEX_op_rotr_i32:
+        return TCG_TARGET_HAS_rot_i32;
+    case INDEX_op_deposit_i32:
+        return TCG_TARGET_HAS_deposit_i32;
+    case INDEX_op_extract_i32:
+        return TCG_TARGET_HAS_extract_i32;
+    case INDEX_op_sextract_i32:
+        return TCG_TARGET_HAS_sextract_i32;
+    case INDEX_op_add2_i32:
+        return TCG_TARGET_HAS_add2_i32;
+    case INDEX_op_sub2_i32:
+        return TCG_TARGET_HAS_sub2_i32;
+    case INDEX_op_mulu2_i32:
+        return TCG_TARGET_HAS_mulu2_i32;
+    case INDEX_op_muls2_i32:
+        return TCG_TARGET_HAS_muls2_i32;
+    case INDEX_op_muluh_i32:
+        return TCG_TARGET_HAS_muluh_i32;
+    case INDEX_op_mulsh_i32:
+        return TCG_TARGET_HAS_mulsh_i32;
+    case INDEX_op_ext8s_i32:
+        return TCG_TARGET_HAS_ext8s_i32;
+    case INDEX_op_ext16s_i32:
+        return TCG_TARGET_HAS_ext16s_i32;
+    case INDEX_op_ext8u_i32:
+        return TCG_TARGET_HAS_ext8u_i32;
+    case INDEX_op_ext16u_i32:
+        return TCG_TARGET_HAS_ext16u_i32;
+    case INDEX_op_bswap16_i32:
+        return TCG_TARGET_HAS_bswap16_i32;
+    case INDEX_op_bswap32_i32:
+        return TCG_TARGET_HAS_bswap32_i32;
+    case INDEX_op_not_i32:
+        return TCG_TARGET_HAS_not_i32;
+    case INDEX_op_neg_i32:
+        return TCG_TARGET_HAS_neg_i32;
+    case INDEX_op_andc_i32:
+        return TCG_TARGET_HAS_andc_i32;
+    case INDEX_op_orc_i32:
+        return TCG_TARGET_HAS_orc_i32;
+    case INDEX_op_eqv_i32:
+        return TCG_TARGET_HAS_eqv_i32;
+    case INDEX_op_nand_i32:
+        return TCG_TARGET_HAS_nand_i32;
+    case INDEX_op_nor_i32:
+        return TCG_TARGET_HAS_nor_i32;
+    case INDEX_op_clz_i32:
+        return TCG_TARGET_HAS_clz_i32;
+    case INDEX_op_ctz_i32:
+        return TCG_TARGET_HAS_ctz_i32;
+    case INDEX_op_ctpop_i32:
+        return TCG_TARGET_HAS_ctpop_i32;
+
+    case INDEX_op_brcond2_i32:
+    case INDEX_op_setcond2_i32:
+        return TCG_TARGET_REG_BITS == 32;
+
+    case INDEX_op_mov_i64:
+    case INDEX_op_movi_i64:
+    case INDEX_op_setcond_i64:
+    case INDEX_op_brcond_i64:
+    case INDEX_op_ld8u_i64:
+    case INDEX_op_ld8s_i64:
+    case INDEX_op_ld16u_i64:
+    case INDEX_op_ld16s_i64:
+    case INDEX_op_ld32u_i64:
+    case INDEX_op_ld32s_i64:
+    case INDEX_op_ld_i64:
+    case INDEX_op_st8_i64:
+    case INDEX_op_st16_i64:
+    case INDEX_op_st32_i64:
+    case INDEX_op_st_i64:
+    case INDEX_op_add_i64:
+    case INDEX_op_sub_i64:
+    case INDEX_op_mul_i64:
+    case INDEX_op_and_i64:
+    case INDEX_op_or_i64:
+    case INDEX_op_xor_i64:
+    case INDEX_op_shl_i64:
+    case INDEX_op_shr_i64:
+    case INDEX_op_sar_i64:
+    case INDEX_op_ext_i32_i64:
+    case INDEX_op_extu_i32_i64:
+        return TCG_TARGET_REG_BITS == 64;
+
+    case INDEX_op_movcond_i64:
+        return TCG_TARGET_HAS_movcond_i64;
+    case INDEX_op_div_i64:
+    case INDEX_op_divu_i64:
+        return TCG_TARGET_HAS_div_i64;
+    case INDEX_op_rem_i64:
+    case INDEX_op_remu_i64:
+        return TCG_TARGET_HAS_rem_i64;
+    case INDEX_op_div2_i64:
+    case INDEX_op_divu2_i64:
+        return TCG_TARGET_HAS_div2_i64;
+    case INDEX_op_rotl_i64:
+    case INDEX_op_rotr_i64:
+        return TCG_TARGET_HAS_rot_i64;
+    case INDEX_op_deposit_i64:
+        return TCG_TARGET_HAS_deposit_i64;
+    case INDEX_op_extract_i64:
+        return TCG_TARGET_HAS_extract_i64;
+    case INDEX_op_sextract_i64:
+        return TCG_TARGET_HAS_sextract_i64;
+    case INDEX_op_extrl_i64_i32:
+        return TCG_TARGET_HAS_extrl_i64_i32;
+    case INDEX_op_extrh_i64_i32:
+        return TCG_TARGET_HAS_extrh_i64_i32;
+    case INDEX_op_ext8s_i64:
+        return TCG_TARGET_HAS_ext8s_i64;
+    case INDEX_op_ext16s_i64:
+        return TCG_TARGET_HAS_ext16s_i64;
+    case INDEX_op_ext32s_i64:
+        return TCG_TARGET_HAS_ext32s_i64;
+    case INDEX_op_ext8u_i64:
+        return TCG_TARGET_HAS_ext8u_i64;
+    case INDEX_op_ext16u_i64:
+        return TCG_TARGET_HAS_ext16u_i64;
+    case INDEX_op_ext32u_i64:
+        return TCG_TARGET_HAS_ext32u_i64;
+    case INDEX_op_bswap16_i64:
+        return TCG_TARGET_HAS_bswap16_i64;
+    case INDEX_op_bswap32_i64:
+        return TCG_TARGET_HAS_bswap32_i64;
+    case INDEX_op_bswap64_i64:
+        return TCG_TARGET_HAS_bswap64_i64;
+    case INDEX_op_not_i64:
+        return TCG_TARGET_HAS_not_i64;
+    case INDEX_op_neg_i64:
+        return TCG_TARGET_HAS_neg_i64;
+    case INDEX_op_andc_i64:
+        return TCG_TARGET_HAS_andc_i64;
+    case INDEX_op_orc_i64:
+        return TCG_TARGET_HAS_orc_i64;
+    case INDEX_op_eqv_i64:
+        return TCG_TARGET_HAS_eqv_i64;
+    case INDEX_op_nand_i64:
+        return TCG_TARGET_HAS_nand_i64;
+    case INDEX_op_nor_i64:
+        return TCG_TARGET_HAS_nor_i64;
+    case INDEX_op_clz_i64:
+        return TCG_TARGET_HAS_clz_i64;
+    case INDEX_op_ctz_i64:
+        return TCG_TARGET_HAS_ctz_i64;
+    case INDEX_op_ctpop_i64:
+        return TCG_TARGET_HAS_ctpop_i64;
+    case INDEX_op_add2_i64:
+        return TCG_TARGET_HAS_add2_i64;
+    case INDEX_op_sub2_i64:
+        return TCG_TARGET_HAS_sub2_i64;
+    case INDEX_op_mulu2_i64:
+        return TCG_TARGET_HAS_mulu2_i64;
+    case INDEX_op_muls2_i64:
+        return TCG_TARGET_HAS_muls2_i64;
+    case INDEX_op_muluh_i64:
+        return TCG_TARGET_HAS_muluh_i64;
+    case INDEX_op_mulsh_i64:
+        return TCG_TARGET_HAS_mulsh_i64;
+
+    case NB_OPS:
+        break;
+    }
+    g_assert_not_reached();
+}
+
 /* Note: we convert the 64 bit args to 32 bit and do some alignment
    and endian swap. Maybe it would be better to do the alignment
    and endian swap in tcg_reg_alloc_call(). */
@@ -2673,9 +2896,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
             break;
         default:
             /* Sanity check that we've not introduced any unhandled opcodes. */
-            if (def->flags & TCG_OPF_NOT_PRESENT) {
-                tcg_abort();
-            }
+            tcg_debug_assert(tcg_op_supported(opc));
             /* Note: in order to speed up the code, it would be much
                faster to have specialized register allocator functions for
                some common argument patterns */
-- 
2.13.5
