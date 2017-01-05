Received: from eggs.gnu.org ([2001:4830:134:3::10]:39928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jinguojie@loongson.cn>) id 1cP0Ee-000200-Sj
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 00:05:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jinguojie@loongson.cn>) id 1cP0Ec-0005gF-NU
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 00:05:08 -0500
Received: from [114.242.206.163] (port=60210 helo=mail.loongson.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jinguojie@loongson.cn>) id 1cP0Eb-0005ch-Ek
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 00:05:06 -0500
From: Jin Guojie <jinguojie@loongson.cn>
Date: Thu,  5 Jan 2017 12:57:48 +0800
Message-Id: <1483592275-4496-4-git-send-email-jinguojie@loongson.cn>
In-Reply-To: <1483592275-4496-1-git-send-email-jinguojie@loongson.cn>
References: <1483592275-4496-1-git-send-email-jinguojie@loongson.cn>
Subject: [Qemu-devel] [PATCH v6 RESEND 03/10] tcg-mips: Support 64-bit
 opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, James Hogan <james.hogan@imgtec.com>, YunQiang Su <wzssyqa@gmail.com>, Richard Henderson <rth@twiddle.net>, Jin Guojie <jinguojie@loongson.cn>

Bulk patch adding 64-bit opcodes into tcg_out_op.  Note that
mips64 is as yet neither complete nor enabled.

Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Tested-by: James Hogan <james.hogan@imgtec.com>
Tested-by: YunQiang Su <wzssyqa@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Jin Guojie <jinguojie@loongson.cn>
---
 tcg/mips/tcg-target.h     |  41 ++++++
 tcg/mips/tcg-target.inc.c | 322 ++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 353 insertions(+), 10 deletions(-)

diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index a6871fb..4b7d3ae 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -27,6 +27,7 @@
 #ifndef MIPS_TCG_TARGET_H
 #define MIPS_TCG_TARGET_H
 
+#define TCG_TARGET_REG_BITS 32
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 16
 #define TCG_TARGET_NB_REGS 32
@@ -119,6 +120,29 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_mulsh_i32        1
 #define TCG_TARGET_HAS_bswap32_i32      1
 
+#if TCG_TARGET_REG_BITS == 64
+#define TCG_TARGET_HAS_add2_i32         0
+#define TCG_TARGET_HAS_sub2_i32         0
+#define TCG_TARGET_HAS_extrl_i64_i32    1
+#define TCG_TARGET_HAS_extrh_i64_i32    1
+#define TCG_TARGET_HAS_div_i64          1
+#define TCG_TARGET_HAS_rem_i64          1
+#define TCG_TARGET_HAS_not_i64          1
+#define TCG_TARGET_HAS_nor_i64          1
+#define TCG_TARGET_HAS_andc_i64         0
+#define TCG_TARGET_HAS_orc_i64          0
+#define TCG_TARGET_HAS_eqv_i64          0
+#define TCG_TARGET_HAS_nand_i64         0
+#define TCG_TARGET_HAS_add2_i64         0
+#define TCG_TARGET_HAS_sub2_i64         0
+#define TCG_TARGET_HAS_mulu2_i64        (!use_mips32r6_instructions)
+#define TCG_TARGET_HAS_muls2_i64        (!use_mips32r6_instructions)
+#define TCG_TARGET_HAS_muluh_i64        1
+#define TCG_TARGET_HAS_mulsh_i64        1
+#define TCG_TARGET_HAS_ext32s_i64       1
+#define TCG_TARGET_HAS_ext32u_i64       1
+#endif
+
 /* optional instructions detected at runtime */
 #define TCG_TARGET_HAS_movcond_i32      use_movnz_instructions
 #define TCG_TARGET_HAS_bswap16_i32      use_mips32r2_instructions
@@ -127,11 +151,28 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_ext16s_i32       use_mips32r2_instructions
 #define TCG_TARGET_HAS_rot_i32          use_mips32r2_instructions
 
+#if TCG_TARGET_REG_BITS == 64
+#define TCG_TARGET_HAS_movcond_i64      use_movnz_instructions
+#define TCG_TARGET_HAS_bswap16_i64      use_mips32r2_instructions
+#define TCG_TARGET_HAS_bswap32_i64      use_mips32r2_instructions
+#define TCG_TARGET_HAS_bswap64_i64      use_mips32r2_instructions
+#define TCG_TARGET_HAS_deposit_i64      use_mips32r2_instructions
+#define TCG_TARGET_HAS_ext8s_i64        use_mips32r2_instructions
+#define TCG_TARGET_HAS_ext16s_i64       use_mips32r2_instructions
+#define TCG_TARGET_HAS_rot_i64          use_mips32r2_instructions
+#endif
+
 /* optional instructions automatically implemented */
 #define TCG_TARGET_HAS_neg_i32          0 /* sub  rd, zero, rt   */
 #define TCG_TARGET_HAS_ext8u_i32        0 /* andi rt, rs, 0xff   */
 #define TCG_TARGET_HAS_ext16u_i32       0 /* andi rt, rs, 0xffff */
 
+#if TCG_TARGET_REG_BITS == 64
+#define TCG_TARGET_HAS_neg_i64          0 /* sub  rd, zero, rt   */
+#define TCG_TARGET_HAS_ext8u_i64        0 /* andi rt, rs, 0xff   */
+#define TCG_TARGET_HAS_ext16u_i64       0 /* andi rt, rs, 0xffff */
+#endif
+
 #ifdef __OpenBSD__
 #include <machine/sysarch.h>
 #else
diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index fb84ea5..2d91d0c 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -437,6 +437,21 @@ static inline void tcg_out_opc_bf(TCGContext *s, MIPSInsn opc, TCGReg rt,
     tcg_out32(s, inst);
 }
 
+static inline void tcg_out_opc_bf64(TCGContext *s, MIPSInsn opc, MIPSInsn opm,
+                                    MIPSInsn oph, TCGReg rt, TCGReg rs,
+                                    int msb, int lsb)
+{
+    if (lsb >= 32) {
+        opc = oph;
+        msb -= 32;
+        lsb -= 32;
+    } else if (msb >= 32) {
+        opc = opm;
+        msb -= 32;
+    }
+    tcg_out_opc_bf(s, opc, rt, rs, msb, lsb);
+}
+
 /*
  * Type branch
  */
@@ -467,6 +482,18 @@ static inline void tcg_out_opc_sa(TCGContext *s, MIPSInsn opc,
 
 }
 
+static void tcg_out_opc_sa64(TCGContext *s, MIPSInsn opc1, MIPSInsn opc2,
+                             TCGReg rd, TCGReg rt, TCGArg sa)
+{
+    int32_t inst;
+
+    inst = (sa & 32 ? opc2 : opc1);
+    inst |= (rt & 0x1F) << 16;
+    inst |= (rd & 0x1F) << 11;
+    inst |= (sa & 0x1F) <<  6;
+    tcg_out32(s, inst);
+}
+
 /*
  * Type jump.
  * Returns true if the branch was in range and the insn was emitted.
@@ -495,6 +522,21 @@ static inline void tcg_out_nop(TCGContext *s)
     tcg_out32(s, 0);
 }
 
+static inline void tcg_out_dsll(TCGContext *s, TCGReg rd, TCGReg rt, TCGArg sa)
+{
+    tcg_out_opc_sa64(s, OPC_DSLL, OPC_DSLL32, rd, rt, sa);
+}
+
+static inline void tcg_out_dsrl(TCGContext *s, TCGReg rd, TCGReg rt, TCGArg sa)
+{
+    tcg_out_opc_sa64(s, OPC_DSRL, OPC_DSRL32, rd, rt, sa);
+}
+
+static inline void tcg_out_dsra(TCGContext *s, TCGReg rd, TCGReg rt, TCGArg sa)
+{
+    tcg_out_opc_sa64(s, OPC_DSRA, OPC_DSRA32, rd, rt, sa);
+}
+
 static inline void tcg_out_mov(TCGContext *s, TCGType type,
                                TCGReg ret, TCGReg arg)
 {
@@ -573,6 +615,27 @@ static void tcg_out_bswap32(TCGContext *s, TCGReg ret, TCGReg arg)
     }
 }
 
+static void tcg_out_bswap32u(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    if (use_mips32r2_instructions) {
+        tcg_out_opc_reg(s, OPC_DSBH, ret, 0, arg);
+        tcg_out_opc_reg(s, OPC_DSHD, ret, 0, ret);
+        tcg_out_dsrl(s, ret, ret, 32);
+    } else {
+        abort();
+    }
+}
+
+static void tcg_out_bswap64(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    if (use_mips32r2_instructions) {
+        tcg_out_opc_reg(s, OPC_DSBH, ret, 0, arg);
+        tcg_out_opc_reg(s, OPC_DSHD, ret, 0, ret);
+    } else {
+        abort();
+    }
+}
+
 static inline void tcg_out_ext8s(TCGContext *s, TCGReg ret, TCGReg arg)
 {
     if (use_mips32r2_instructions) {
@@ -593,6 +656,16 @@ static inline void tcg_out_ext16s(TCGContext *s, TCGReg ret, TCGReg arg)
     }
 }
 
+static inline void tcg_out_ext32u(TCGContext *s, TCGReg ret, TCGReg arg)
+{
+    if (use_mips32r2_instructions) {
+        tcg_out_opc_bf(s, OPC_DEXT, ret, arg, 31, 0);
+    } else {
+        tcg_out_dsll(s, ret, arg, 32);
+        tcg_out_dsrl(s, ret, ret, 32);
+    }
+}
+
 static void tcg_out_ldst(TCGContext *s, MIPSInsn opc, TCGReg data,
                          TCGReg addr, intptr_t ofs)
 {
@@ -1495,6 +1568,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         {
             TCGReg b0 = TCG_REG_ZERO;
 
+            a0 = (intptr_t)a0;
             if (a0 & ~0xffff) {
                 tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_V0, a0 & ~0xffff);
                 b0 = TCG_REG_V0;
@@ -1528,28 +1602,45 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
 
     case INDEX_op_ld8u_i32:
+    case INDEX_op_ld8u_i64:
         i1 = OPC_LBU;
         goto do_ldst;
     case INDEX_op_ld8s_i32:
+    case INDEX_op_ld8s_i64:
         i1 = OPC_LB;
         goto do_ldst;
     case INDEX_op_ld16u_i32:
+    case INDEX_op_ld16u_i64:
         i1 = OPC_LHU;
         goto do_ldst;
     case INDEX_op_ld16s_i32:
+    case INDEX_op_ld16s_i64:
         i1 = OPC_LH;
         goto do_ldst;
     case INDEX_op_ld_i32:
+    case INDEX_op_ld32s_i64:
         i1 = OPC_LW;
         goto do_ldst;
+    case INDEX_op_ld32u_i64:
+        i1 = OPC_LWU;
+        goto do_ldst;
+    case INDEX_op_ld_i64:
+        i1 = OPC_LD;
+        goto do_ldst;
     case INDEX_op_st8_i32:
+    case INDEX_op_st8_i64:
         i1 = OPC_SB;
         goto do_ldst;
     case INDEX_op_st16_i32:
+    case INDEX_op_st16_i64:
         i1 = OPC_SH;
         goto do_ldst;
     case INDEX_op_st_i32:
+    case INDEX_op_st32_i64:
         i1 = OPC_SW;
+        goto do_ldst;
+    case INDEX_op_st_i64:
+        i1 = OPC_SD;
     do_ldst:
         tcg_out_ldst(s, i1, a0, a1, a2);
         break;
@@ -1557,10 +1648,15 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_add_i32:
         i1 = OPC_ADDU, i2 = OPC_ADDIU;
         goto do_binary;
+    case INDEX_op_add_i64:
+        i1 = OPC_DADDU, i2 = OPC_DADDIU;
+        goto do_binary;
     case INDEX_op_or_i32:
+    case INDEX_op_or_i64:
         i1 = OPC_OR, i2 = OPC_ORI;
         goto do_binary;
     case INDEX_op_xor_i32:
+    case INDEX_op_xor_i64:
         i1 = OPC_XOR, i2 = OPC_XORI;
     do_binary:
         if (c2) {
@@ -1572,12 +1668,16 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
 
     case INDEX_op_sub_i32:
+        i1 = OPC_SUBU, i2 = OPC_ADDIU;
+        goto do_subtract;
+    case INDEX_op_sub_i64:
+        i1 = OPC_DSUBU, i2 = OPC_DADDIU;
+    do_subtract:
         if (c2) {
-            tcg_out_opc_imm(s, OPC_ADDIU, a0, a1, -a2);
+            tcg_out_opc_imm(s, i2, a0, a1, -a2);
             break;
         }
-        i1 = OPC_SUBU;
-        goto do_binary;
+        goto do_binaryv;
     case INDEX_op_and_i32:
         if (c2 && a2 != (uint16_t)a2) {
             int msb = ctz32(~a2) - 1;
@@ -1588,7 +1688,18 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         }
         i1 = OPC_AND, i2 = OPC_ANDI;
         goto do_binary;
+    case INDEX_op_and_i64:
+        if (c2 && a2 != (uint16_t)a2) {
+            int msb = ctz64(~a2) - 1;
+            tcg_debug_assert(use_mips32r2_instructions);
+            tcg_debug_assert(is_p2m1(a2));
+            tcg_out_opc_bf64(s, OPC_DEXT, OPC_DEXTM, OPC_DEXTU, a0, a1, msb, 0);
+            break;
+        }
+        i1 = OPC_AND, i2 = OPC_ANDI;
+        goto do_binary;
     case INDEX_op_nor_i32:
+    case INDEX_op_nor_i64:
         i1 = OPC_NOR;
         goto do_binaryv;
 
@@ -1640,6 +1751,55 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
             break;
         }
         i1 = OPC_DIVU, i2 = OPC_MFHI;
+        goto do_hilo1;
+    case INDEX_op_mul_i64:
+        if (use_mips32r6_instructions) {
+            tcg_out_opc_reg(s, OPC_DMUL, a0, a1, a2);
+            break;
+        }
+        i1 = OPC_DMULT, i2 = OPC_MFLO;
+        goto do_hilo1;
+    case INDEX_op_mulsh_i64:
+        if (use_mips32r6_instructions) {
+            tcg_out_opc_reg(s, OPC_DMUH, a0, a1, a2);
+            break;
+        }
+        i1 = OPC_DMULT, i2 = OPC_MFHI;
+        goto do_hilo1;
+    case INDEX_op_muluh_i64:
+        if (use_mips32r6_instructions) {
+            tcg_out_opc_reg(s, OPC_DMUHU, a0, a1, a2);
+            break;
+        }
+        i1 = OPC_DMULTU, i2 = OPC_MFHI;
+        goto do_hilo1;
+    case INDEX_op_div_i64:
+        if (use_mips32r6_instructions) {
+            tcg_out_opc_reg(s, OPC_DDIV_R6, a0, a1, a2);
+            break;
+        }
+        i1 = OPC_DDIV, i2 = OPC_MFLO;
+        goto do_hilo1;
+    case INDEX_op_divu_i64:
+        if (use_mips32r6_instructions) {
+            tcg_out_opc_reg(s, OPC_DDIVU_R6, a0, a1, a2);
+            break;
+        }
+        i1 = OPC_DDIVU, i2 = OPC_MFLO;
+        goto do_hilo1;
+    case INDEX_op_rem_i64:
+        if (use_mips32r6_instructions) {
+            tcg_out_opc_reg(s, OPC_DMOD, a0, a1, a2);
+            break;
+        }
+        i1 = OPC_DDIV, i2 = OPC_MFHI;
+        goto do_hilo1;
+    case INDEX_op_remu_i64:
+        if (use_mips32r6_instructions) {
+            tcg_out_opc_reg(s, OPC_DMODU, a0, a1, a2);
+            break;
+        }
+        i1 = OPC_DDIVU, i2 = OPC_MFHI;
     do_hilo1:
         tcg_out_opc_reg(s, i1, 0, a1, a2);
         tcg_out_opc_reg(s, i2, a0, 0, 0);
@@ -1650,6 +1810,12 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         goto do_hilo2;
     case INDEX_op_mulu2_i32:
         i1 = OPC_MULTU;
+        goto do_hilo2;
+    case INDEX_op_muls2_i64:
+        i1 = OPC_DMULT;
+        goto do_hilo2;
+    case INDEX_op_mulu2_i64:
+        i1 = OPC_DMULTU;
     do_hilo2:
         tcg_out_opc_reg(s, i1, 0, a2, args[3]);
         tcg_out_opc_reg(s, OPC_MFLO, a0, 0, 0);
@@ -1657,20 +1823,46 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
 
     case INDEX_op_not_i32:
+    case INDEX_op_not_i64:
         i1 = OPC_NOR;
         goto do_unary;
     case INDEX_op_bswap16_i32:
+    case INDEX_op_bswap16_i64:
         i1 = OPC_WSBH;
         goto do_unary;
     case INDEX_op_ext8s_i32:
+    case INDEX_op_ext8s_i64:
         i1 = OPC_SEB;
         goto do_unary;
     case INDEX_op_ext16s_i32:
+    case INDEX_op_ext16s_i64:
         i1 = OPC_SEH;
     do_unary:
         tcg_out_opc_reg(s, i1, a0, TCG_REG_ZERO, a1);
         break;
 
+    case INDEX_op_bswap32_i32:
+        tcg_out_bswap32(s, a0, a1);
+        break;
+    case INDEX_op_bswap32_i64:
+        tcg_out_bswap32u(s, a0, a1);
+        break;
+    case INDEX_op_bswap64_i64:
+        tcg_out_bswap64(s, a0, a1);
+        break;
+    case INDEX_op_extrh_i64_i32:
+        tcg_out_dsra(s, a0, a1, 32);
+        break;
+    case INDEX_op_ext32s_i64:
+    case INDEX_op_ext_i32_i64:
+    case INDEX_op_extrl_i64_i32:
+        tcg_out_opc_sa(s, OPC_SLL, a0, a1, 0);
+        break;
+    case INDEX_op_ext32u_i64:
+    case INDEX_op_extu_i32_i64:
+        tcg_out_ext32u(s, a0, a1);
+        break;
+
     case INDEX_op_sar_i32:
         i1 = OPC_SRAV, i2 = OPC_SRA;
         goto do_shift;
@@ -1685,9 +1877,10 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
     do_shift:
         if (c2) {
             tcg_out_opc_sa(s, i2, a0, a1, a2);
-        } else {
-            tcg_out_opc_reg(s, i1, a0, a2, a1);
+            break;
         }
+    do_shiftv:
+        tcg_out_opc_reg(s, i1, a0, a2, a1);
         break;
     case INDEX_op_rotl_i32:
         if (c2) {
@@ -1697,16 +1890,53 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
             tcg_out_opc_reg(s, OPC_ROTRV, a0, TCG_TMP0, a1);
         }
         break;
-
-    case INDEX_op_bswap32_i32:
-        tcg_out_bswap32(s, a0, a1);
+    case INDEX_op_sar_i64:
+        if (c2) {
+            tcg_out_dsra(s, a0, a1, a2);
+            break;
+        }
+        i1 = OPC_DSRAV;
+        goto do_shiftv;
+    case INDEX_op_shl_i64:
+        if (c2) {
+            tcg_out_dsll(s, a0, a1, a2);
+            break;
+        }
+        i1 = OPC_DSLLV;
+        goto do_shiftv;
+    case INDEX_op_shr_i64:
+        if (c2) {
+            tcg_out_dsrl(s, a0, a1, a2);
+            break;
+        }
+        i1 = OPC_DSRLV;
+        goto do_shiftv;
+    case INDEX_op_rotr_i64:
+        if (c2) {
+            tcg_out_opc_sa64(s, OPC_DROTR, OPC_DROTR32, a0, a1, a2);
+            break;
+        }
+        i1 = OPC_DROTRV;
+        goto do_shiftv;
+    case INDEX_op_rotl_i64:
+        if (c2) {
+            tcg_out_opc_sa64(s, OPC_DROTR, OPC_DROTR32, a0, a1, 64 - a2);
+        } else {
+            tcg_out_opc_reg(s, OPC_DSUBU, TCG_TMP0, TCG_REG_ZERO, a2);
+            tcg_out_opc_reg(s, OPC_DROTRV, a0, TCG_TMP0, a1);
+        }
         break;
 
     case INDEX_op_deposit_i32:
         tcg_out_opc_bf(s, OPC_INS, a0, a2, args[3] + args[4] - 1, args[3]);
         break;
+    case INDEX_op_deposit_i64:
+        tcg_out_opc_bf64(s, OPC_DINS, OPC_DINSM, OPC_DINSU, a0, a2,
+                         args[3] + args[4] - 1, args[3]);
+        break;
 
     case INDEX_op_brcond_i32:
+    case INDEX_op_brcond_i64:
         tcg_out_brcond(s, a2, a0, a1, arg_label(args[3]));
         break;
     case INDEX_op_brcond2_i32:
@@ -1714,10 +1944,12 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
 
     case INDEX_op_movcond_i32:
+    case INDEX_op_movcond_i64:
         tcg_out_movcond(s, args[5], a0, a1, a2, args[3], args[4]);
         break;
 
     case INDEX_op_setcond_i32:
+    case INDEX_op_setcond_i64:
         tcg_out_setcond(s, args[3], a0, a1, a2);
         break;
     case INDEX_op_setcond2_i32:
@@ -1750,7 +1982,9 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_mb(s, a0);
         break;
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
+    case INDEX_op_mov_i64:
     case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
+    case INDEX_op_movi_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     default:
         tcg_abort();
@@ -1812,13 +2046,81 @@ static const TCGTargetOpDef mips_op_defs[] = {
     { INDEX_op_movcond_i32, { "r", "rZ", "rZ", "rZ", "0" } },
 #endif
     { INDEX_op_setcond_i32, { "r", "rZ", "rZ" } },
-    { INDEX_op_setcond2_i32, { "r", "rZ", "rZ", "rZ", "rZ" } },
 
+#if TCG_TARGET_REG_BITS == 32
     { INDEX_op_add2_i32, { "r", "r", "rZ", "rZ", "rN", "rN" } },
     { INDEX_op_sub2_i32, { "r", "r", "rZ", "rZ", "rN", "rN" } },
+    { INDEX_op_setcond2_i32, { "r", "rZ", "rZ", "rZ", "rZ" } },
     { INDEX_op_brcond2_i32, { "rZ", "rZ", "rZ", "rZ" } },
+#endif
 
-#if TARGET_LONG_BITS == 32
+#if TCG_TARGET_REG_BITS == 64
+    { INDEX_op_ld8u_i64, { "r", "r" } },
+    { INDEX_op_ld8s_i64, { "r", "r" } },
+    { INDEX_op_ld16u_i64, { "r", "r" } },
+    { INDEX_op_ld16s_i64, { "r", "r" } },
+    { INDEX_op_ld32s_i64, { "r", "r" } },
+    { INDEX_op_ld32u_i64, { "r", "r" } },
+    { INDEX_op_ld_i64, { "r", "r" } },
+    { INDEX_op_st8_i64, { "rZ", "r" } },
+    { INDEX_op_st16_i64, { "rZ", "r" } },
+    { INDEX_op_st32_i64, { "rZ", "r" } },
+    { INDEX_op_st_i64, { "rZ", "r" } },
+
+    { INDEX_op_add_i64, { "r", "rZ", "rJ" } },
+    { INDEX_op_mul_i64, { "r", "rZ", "rZ" } },
+#if !use_mips32r6_instructions
+    { INDEX_op_muls2_i64, { "r", "r", "rZ", "rZ" } },
+    { INDEX_op_mulu2_i64, { "r", "r", "rZ", "rZ" } },
+#endif
+    { INDEX_op_mulsh_i64, { "r", "rZ", "rZ" } },
+    { INDEX_op_muluh_i64, { "r", "rZ", "rZ" } },
+    { INDEX_op_div_i64, { "r", "rZ", "rZ" } },
+    { INDEX_op_divu_i64, { "r", "rZ", "rZ" } },
+    { INDEX_op_rem_i64, { "r", "rZ", "rZ" } },
+    { INDEX_op_remu_i64, { "r", "rZ", "rZ" } },
+    { INDEX_op_sub_i64, { "r", "rZ", "rN" } },
+
+    { INDEX_op_and_i64, { "r", "rZ", "rIK" } },
+    { INDEX_op_nor_i64, { "r", "rZ", "rZ" } },
+    { INDEX_op_not_i64, { "r", "rZ" } },
+    { INDEX_op_or_i64, { "r", "rZ", "rI" } },
+    { INDEX_op_xor_i64, { "r", "rZ", "rI" } },
+
+    { INDEX_op_shl_i64, { "r", "rZ", "ri" } },
+    { INDEX_op_shr_i64, { "r", "rZ", "ri" } },
+    { INDEX_op_sar_i64, { "r", "rZ", "ri" } },
+    { INDEX_op_rotr_i64, { "r", "rZ", "ri" } },
+    { INDEX_op_rotl_i64, { "r", "rZ", "ri" } },
+
+    { INDEX_op_bswap16_i64, { "r", "r" } },
+    { INDEX_op_bswap32_i64, { "r", "r" } },
+    { INDEX_op_bswap64_i64, { "r", "r" } },
+
+    { INDEX_op_ext8s_i64, { "r", "rZ" } },
+    { INDEX_op_ext16s_i64, { "r", "rZ" } },
+    { INDEX_op_ext32s_i64, { "r", "rZ" } },
+    { INDEX_op_ext32u_i64, { "r", "rZ" } },
+    { INDEX_op_ext_i32_i64, { "r", "rZ" } },
+    { INDEX_op_extu_i32_i64, { "r", "rZ" } },
+    { INDEX_op_extrl_i64_i32, { "r", "rZ" } },
+    { INDEX_op_extrh_i64_i32, { "r", "rZ" } },
+
+    { INDEX_op_deposit_i64, { "r", "0", "rZ" } },
+
+    { INDEX_op_brcond_i64, { "rZ", "rZ" } },
+#if use_mips32r6_instructions
+    { INDEX_op_movcond_i64, { "r", "rZ", "rZ", "rZ", "rZ" } },
+#else
+    { INDEX_op_movcond_i64, { "r", "rZ", "rZ", "rZ", "0" } },
+#endif
+    { INDEX_op_setcond_i64, { "r", "rZ", "rZ" } },
+
+    { INDEX_op_qemu_ld_i32, { "r", "LZ" } },
+    { INDEX_op_qemu_st_i32, { "SZ", "SZ" } },
+    { INDEX_op_qemu_ld_i64, { "r", "LZ" } },
+    { INDEX_op_qemu_st_i64, { "SZ", "SZ" } },
+#elif TARGET_LONG_BITS == 32
     { INDEX_op_qemu_ld_i32, { "r", "LZ" } },
     { INDEX_op_qemu_st_i32, { "SZ", "SZ" } },
     { INDEX_op_qemu_ld_i64, { "r", "r", "LZ" } },
-- 
2.1.0
