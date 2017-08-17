Received: from eggs.gnu.org ([2001:4830:134:3::10]:44537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1diTn4-0004wR-J8
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 19:01:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1diTn3-0000x0-9E
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 19:01:26 -0400
Received: from mail-pg0-x22b.google.com ([2607:f8b0:400e:c05::22b]:36971)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1diTn3-0000va-24
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 19:01:25 -0400
Received: by mail-pg0-x22b.google.com with SMTP id y129so51925581pgy.4
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 16:01:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 17 Aug 2017 16:01:11 -0700
Message-Id: <20170817230114.3655-6-richard.henderson@linaro.org>
In-Reply-To: <20170817230114.3655-1-richard.henderson@linaro.org>
References: <20170817230114.3655-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 5/8] tcg: Add tcg_op_supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.h |   2 +
 tcg/tcg.c | 310 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 312 insertions(+)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index b9e15da13b..b443143b21 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -962,6 +962,8 @@ do {\
 #define tcg_temp_free_ptr(T) tcg_temp_free_i64(TCGV_PTR_TO_NAT(T))
 #endif
 
+bool tcg_op_supported(TCGOpcode op);
+
 void tcg_gen_callN(TCGContext *s, void *func,
                    TCGArg ret, int nargs, TCGArg *args);
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index ea78d47fad..3c3cdda938 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -751,6 +751,316 @@ int tcg_check_temp_count(void)
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
+    case INDEX_op_mov_v64:
+    case INDEX_op_movi_v64:
+    case INDEX_op_ld_v64:
+    case INDEX_op_st_v64:
+    case INDEX_op_and_v64:
+    case INDEX_op_or_v64:
+    case INDEX_op_xor_v64:
+    case INDEX_op_add8_v64:
+    case INDEX_op_add16_v64:
+    case INDEX_op_add32_v64:
+    case INDEX_op_sub8_v64:
+    case INDEX_op_sub16_v64:
+    case INDEX_op_sub32_v64:
+        return TCG_TARGET_HAS_v64;
+
+    case INDEX_op_mov_v128:
+    case INDEX_op_movi_v128:
+    case INDEX_op_ld_v128:
+    case INDEX_op_st_v128:
+    case INDEX_op_and_v128:
+    case INDEX_op_or_v128:
+    case INDEX_op_xor_v128:
+    case INDEX_op_add8_v128:
+    case INDEX_op_add16_v128:
+    case INDEX_op_add32_v128:
+    case INDEX_op_add64_v128:
+    case INDEX_op_sub8_v128:
+    case INDEX_op_sub16_v128:
+    case INDEX_op_sub32_v128:
+    case INDEX_op_sub64_v128:
+        return TCG_TARGET_HAS_v128;
+
+    case INDEX_op_mov_v256:
+    case INDEX_op_movi_v256:
+    case INDEX_op_ld_v256:
+    case INDEX_op_st_v256:
+    case INDEX_op_and_v256:
+    case INDEX_op_or_v256:
+    case INDEX_op_xor_v256:
+    case INDEX_op_add8_v256:
+    case INDEX_op_add16_v256:
+    case INDEX_op_add32_v256:
+    case INDEX_op_add64_v256:
+    case INDEX_op_sub8_v256:
+    case INDEX_op_sub16_v256:
+    case INDEX_op_sub32_v256:
+    case INDEX_op_sub64_v256:
+        return TCG_TARGET_HAS_v256;
+
+    case INDEX_op_not_v64:
+        return TCG_TARGET_HAS_not_v64;
+    case INDEX_op_not_v128:
+        return TCG_TARGET_HAS_not_v128;
+    case INDEX_op_not_v256:
+        return TCG_TARGET_HAS_not_v256;
+
+    case INDEX_op_andc_v64:
+        return TCG_TARGET_HAS_andc_v64;
+    case INDEX_op_andc_v128:
+        return TCG_TARGET_HAS_andc_v128;
+    case INDEX_op_andc_v256:
+        return TCG_TARGET_HAS_andc_v256;
+
+    case INDEX_op_orc_v64:
+        return TCG_TARGET_HAS_orc_v64;
+    case INDEX_op_orc_v128:
+        return TCG_TARGET_HAS_orc_v128;
+    case INDEX_op_orc_v256:
+        return TCG_TARGET_HAS_orc_v256;
+
+    case INDEX_op_neg8_v64:
+    case INDEX_op_neg16_v64:
+    case INDEX_op_neg32_v64:
+        return TCG_TARGET_HAS_neg_v64;
+
+    case INDEX_op_neg8_v128:
+    case INDEX_op_neg16_v128:
+    case INDEX_op_neg32_v128:
+    case INDEX_op_neg64_v128:
+        return TCG_TARGET_HAS_neg_v128;
+
+    case INDEX_op_neg8_v256:
+    case INDEX_op_neg16_v256:
+    case INDEX_op_neg32_v256:
+    case INDEX_op_neg64_v256:
+        return TCG_TARGET_HAS_neg_v256;
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
-- 
2.13.5
