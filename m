Received: from eggs.gnu.org ([2001:4830:134:3::10]:55751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWS-00074Z-F7
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWO-0005xi-S6
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:26 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:33314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cKdWO-0005xR-LP
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:24 -0500
Received: by mail-pg0-x244.google.com with SMTP id g1so2480016pgn.0
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 20:01:24 -0800 (PST)
Received: from bigtime.domain ([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	n25sm65339316pfi.33.2016.12.23.20.01.22 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 23 Dec 2016 20:01:22 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 20:00:25 -0800
Message-Id: <20161224040042.12654-49-rth@twiddle.net>
In-Reply-To: <20161224040042.12654-1-rth@twiddle.net>
References: <20161224040042.12654-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 48/65] tcg/i386: Handle ctz and clz opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/i386/tcg-target.h     |   8 +--
 tcg/i386/tcg-target.inc.c | 125 ++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 120 insertions(+), 13 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index f2d9955..8fff287 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -93,8 +93,8 @@ extern bool have_bmi1;
 #define TCG_TARGET_HAS_eqv_i32          0
 #define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_nor_i32          0
-#define TCG_TARGET_HAS_clz_i32          0
-#define TCG_TARGET_HAS_ctz_i32          0
+#define TCG_TARGET_HAS_clz_i32          1
+#define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract_i32      1
 #define TCG_TARGET_HAS_sextract_i32     1
@@ -127,8 +127,8 @@ extern bool have_bmi1;
 #define TCG_TARGET_HAS_eqv_i64          0
 #define TCG_TARGET_HAS_nand_i64         0
 #define TCG_TARGET_HAS_nor_i64          0
-#define TCG_TARGET_HAS_clz_i64          0
-#define TCG_TARGET_HAS_ctz_i64          0
+#define TCG_TARGET_HAS_clz_i64          1
+#define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract_i64      1
 #define TCG_TARGET_HAS_sextract_i64     0
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 651d96c..3ed8cd1 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -92,6 +92,7 @@ static const int tcg_target_call_oarg_regs[] = {
 #define TCG_CT_CONST_S32 0x100
 #define TCG_CT_CONST_U32 0x200
 #define TCG_CT_CONST_I32 0x400
+#define TCG_CT_CONST_WSZ 0x800
 
 /* Registers used with L constraint, which are the first argument 
    registers on x86_64, and two random call clobbered registers on
@@ -138,6 +139,11 @@ static bool have_bmi2;
 #else
 # define have_bmi2 0
 #endif
+#if defined(CONFIG_CPUID_H) && defined(bit_LZCNT)
+static bool have_lzcnt;
+#else
+# define have_lzcnt 0
+#endif
 
 static tcg_insn_unit *tb_ret_addr;
 
@@ -214,6 +220,10 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
             tcg_regset_set32(ct->u.regs, 0, 0xff);
         }
         break;
+    case 'W':
+        /* With TZCNT/LZCNT, we can have operand-size as an input.  */
+        ct->ct |= TCG_CT_CONST_WSZ;
+        break;
 
         /* qemu_ld/st address constraint */
     case 'L':
@@ -260,6 +270,9 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
     if ((ct & TCG_CT_CONST_I32) && ~val == (int32_t)~val) {
         return 1;
     }
+    if ((ct & TCG_CT_CONST_WSZ) && val == (type == TCG_TYPE_I32 ? 32 : 64)) {
+        return 1;
+    }
     return 0;
 }
 
@@ -293,6 +306,8 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_ARITH_GvEv	(0x03)		/* ... plus (ARITH_FOO << 3) */
 #define OPC_ANDN        (0xf2 | P_EXT38)
 #define OPC_ADD_GvEv	(OPC_ARITH_GvEv | (ARITH_ADD << 3))
+#define OPC_BSF         (0xbc | P_EXT)
+#define OPC_BSR         (0xbd | P_EXT)
 #define OPC_BSWAP	(0xc8 | P_EXT)
 #define OPC_CALL_Jz	(0xe8)
 #define OPC_CMOVCC      (0x40 | P_EXT)  /* ... plus condition code */
@@ -307,6 +322,7 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_JMP_long	(0xe9)
 #define OPC_JMP_short	(0xeb)
 #define OPC_LEA         (0x8d)
+#define OPC_LZCNT       (0xbd | P_EXT | P_SIMDF3)
 #define OPC_MOVB_EvGv	(0x88)		/* stores, more or less */
 #define OPC_MOVL_EvGv	(0x89)		/* stores, more or less */
 #define OPC_MOVL_GvEv	(0x8b)		/* loads, more or less */
@@ -333,6 +349,7 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_SHLX        (0xf7 | P_EXT38 | P_DATA16)
 #define OPC_SHRX        (0xf7 | P_EXT38 | P_SIMDF2)
 #define OPC_TESTL	(0x85)
+#define OPC_TZCNT       (0xbc | P_EXT | P_SIMDF3)
 #define OPC_XCHG_ax_r32	(0x90)
 
 #define OPC_GRP3_Ev	(0xf7)
@@ -418,6 +435,11 @@ static void tcg_out_opc(TCGContext *s, int opc, int r, int rm, int x)
     if (opc & P_ADDR32) {
         tcg_out8(s, 0x67);
     }
+    if (opc & P_SIMDF3) {
+        tcg_out8(s, 0xf3);
+    } else if (opc & P_SIMDF2) {
+        tcg_out8(s, 0xf2);
+    }
 
     rex = 0;
     rex |= (opc & P_REXW) ? 0x8 : 0x0;  /* REX.W */
@@ -452,6 +474,11 @@ static void tcg_out_opc(TCGContext *s, int opc)
     if (opc & P_DATA16) {
         tcg_out8(s, 0x66);
     }
+    if (opc & P_SIMDF3) {
+        tcg_out8(s, 0xf3);
+    } else if (opc & P_SIMDF2) {
+        tcg_out8(s, 0xf2);
+    }
     if (opc & (P_EXT | P_EXT38)) {
         tcg_out8(s, 0x0f);
         if (opc & P_EXT38) {
@@ -1080,13 +1107,11 @@ static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
 }
 #endif
 
-static void tcg_out_movcond32(TCGContext *s, TCGCond cond, TCGArg dest,
-                              TCGArg c1, TCGArg c2, int const_c2,
-                              TCGArg v1)
+static void tcg_out_cmov(TCGContext *s, TCGCond cond, int rexw,
+                         TCGReg dest, TCGReg v1)
 {
-    tcg_out_cmp(s, c1, c2, const_c2, 0);
     if (have_cmov) {
-        tcg_out_modrm(s, OPC_CMOVCC | tcg_cond_to_jcc[cond], dest, v1);
+        tcg_out_modrm(s, OPC_CMOVCC | tcg_cond_to_jcc[cond] | rexw, dest, v1);
     } else {
         TCGLabel *over = gen_new_label();
         tcg_out_jxx(s, tcg_cond_to_jcc[tcg_invert_cond(cond)], over, 1);
@@ -1095,16 +1120,64 @@ static void tcg_out_movcond32(TCGContext *s, TCGCond cond, TCGArg dest,
     }
 }
 
+static void tcg_out_movcond32(TCGContext *s, TCGCond cond, TCGReg dest,
+                              TCGReg c1, TCGArg c2, int const_c2,
+                              TCGReg v1)
+{
+    tcg_out_cmp(s, c1, c2, const_c2, 0);
+    tcg_out_cmov(s, cond, 0, dest, v1);
+}
+
 #if TCG_TARGET_REG_BITS == 64
-static void tcg_out_movcond64(TCGContext *s, TCGCond cond, TCGArg dest,
-                              TCGArg c1, TCGArg c2, int const_c2,
-                              TCGArg v1)
+static void tcg_out_movcond64(TCGContext *s, TCGCond cond, TCGReg dest,
+                              TCGReg c1, TCGArg c2, int const_c2,
+                              TCGReg v1)
 {
     tcg_out_cmp(s, c1, c2, const_c2, P_REXW);
-    tcg_out_modrm(s, OPC_CMOVCC | tcg_cond_to_jcc[cond] | P_REXW, dest, v1);
+    tcg_out_cmov(s, cond, P_REXW, dest, v1);
 }
 #endif
 
+static void tcg_out_ctz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
+                        TCGArg arg2, bool const_a2)
+{
+    if (const_a2) {
+        tcg_debug_assert(have_bmi1);
+        tcg_debug_assert(arg2 == (rexw ? 64 : 32));
+        tcg_out_modrm(s, OPC_TZCNT + rexw, dest, arg1);
+    } else {
+        tcg_debug_assert(dest != arg2);
+        tcg_out_modrm(s, OPC_BSF + rexw, dest, arg1);
+        tcg_out_cmov(s, TCG_COND_EQ, rexw, dest, arg2);
+    }
+}
+
+static void tcg_out_clz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
+                        TCGArg arg2, bool const_a2)
+{
+    if (have_lzcnt) {
+        tcg_out_modrm(s, OPC_LZCNT + rexw, dest, arg1);
+        if (const_a2) {
+            tcg_debug_assert(arg2 == (rexw ? 64 : 32));
+        } else {
+            tcg_debug_assert(dest != arg2);
+            tcg_out_cmov(s, TCG_COND_LTU, rexw, dest, arg2);
+        }
+    } else {
+        tcg_debug_assert(!const_a2);
+        tcg_debug_assert(dest != arg1);
+        tcg_debug_assert(dest != arg2);
+
+        /* Recall that the output of BSR is the index not the count.  */
+        tcg_out_modrm(s, OPC_BSR + rexw, dest, arg1);
+        tgen_arithi(s, ARITH_XOR + rexw, dest, rexw ? 63 : 31, 0);
+
+        /* Since we have destroyed the flags from BSR, we have to re-test.  */
+        tcg_out_cmp(s, arg1, 0, 1, rexw);
+        tcg_out_cmov(s, TCG_COND_EQ, rexw, dest, arg2);
+    }
+}
+
 static void tcg_out_branch(TCGContext *s, int call, tcg_insn_unit *dest)
 {
     intptr_t disp = tcg_pcrel_diff(s, dest) - 5;
@@ -1995,6 +2068,13 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
+    OP_32_64(ctz):
+        tcg_out_ctz(s, rexw, args[0], args[1], args[2], const_args[2]);
+        break;
+    OP_32_64(clz):
+        tcg_out_clz(s, rexw, args[0], args[1], args[2], const_args[2]);
+        break;
+
     case INDEX_op_brcond_i32:
         tcg_out_brcond32(s, a2, a0, a1, const_args[1], arg_label(args[3]), 0);
         break;
@@ -2359,6 +2439,24 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
                 = { .args_ct_str = { "r", "r", "0", "1", "re", "re" } };
             return &arith2;
         }
+    case INDEX_op_ctz_i32:
+    case INDEX_op_ctz_i64:
+        {
+            static const TCGTargetOpDef ctz[2] = {
+                { .args_ct_str = { "&r", "r", "r" } },
+                { .args_ct_str = { "&r", "r", "rW" } },
+            };
+            return &ctz[have_bmi1];
+        }
+    case INDEX_op_clz_i32:
+    case INDEX_op_clz_i64:
+        {
+            static const TCGTargetOpDef clz[2] = {
+                { .args_ct_str = { "&r", "r", "r" } },
+                { .args_ct_str = { "&r", "r", "rW" } },
+            };
+            return &clz[have_lzcnt];
+        }
 
     case INDEX_op_qemu_ld_i32:
         return TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? &r_L : &r_L_L;
@@ -2509,6 +2607,15 @@ static void tcg_target_init(TCGContext *s)
     }
 #endif
 
+#ifndef have_lzcnt
+    max = __get_cpuid_max(0x8000000, 0);
+    if (max >= 1) {
+        __cpuid(0x80000001, a, b, c, d);
+        /* LZCNT was introduced with AMD Barcelona and Intel Haswell CPUs.  */
+        have_lzcnt = (c & bit_LZCNT) != 0;
+    }
+#endif
+
     if (TCG_TARGET_REG_BITS == 64) {
         tcg_regset_set32(tcg_target_available_regs[TCG_TYPE_I32], 0, 0xffff);
         tcg_regset_set32(tcg_target_available_regs[TCG_TYPE_I64], 0, 0xffff);
-- 
2.9.3
