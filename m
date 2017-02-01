Received: from eggs.gnu.org ([2001:4830:134:3::10]:53284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cYtsE-00063p-34
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:18:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cYts8-0005db-Vb
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:18:54 -0500
Received: from bran.ispras.ru ([83.149.199.196]:46118 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cYts8-0005co-GM
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:18:48 -0500
From: Kirill Batuzov <batuzovk@ispras.ru>
Date: Wed,  1 Feb 2017 15:18:13 +0300
Message-Id: <1485951502-28774-12-git-send-email-batuzovk@ispras.ru>
In-Reply-To: <1485951502-28774-1-git-send-email-batuzovk@ispras.ru>
References: <1485951502-28774-1-git-send-email-batuzovk@ispras.ru>
Subject: [Qemu-devel] [PATCH v2 11/20] tcg/i386: add support for vector
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
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Kirill Batuzov <batuzovk@ispras.ru>

To be able to generate vector operations in a TCG backend we need to do
several things.

1. We need to tell the register allocator about vector target's register.
   In case of x86 we'll use xmm0..xmm7. xmm7 is designated as a scratch
   register, others can be used by the register allocator.

2. We need a new constraint to indicate where to use vector registers. In
   this commit the 'V' constraint is introduced.

3. We need to be able to generate bare minimum: load, store and reg-to-reg
   move. MOVDQU is used for loads and stores. MOVDQA is used for reg-to-reg
   moves.

4. Finally we need to support any other opcodes we want. INDEX_op_add_i32x4
   is the only one for now. The PADDD instruction handles it perfectly.

Signed-off-by: Kirill Batuzov <batuzovk@ispras.ru>
---
 tcg/i386/tcg-target.h     |  34 +++++++++++++-
 tcg/i386/tcg-target.inc.c | 111 +++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 137 insertions(+), 8 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 21d96ec..b0704e8 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -29,8 +29,16 @@
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 31
 
 #ifdef __x86_64__
-# define TCG_TARGET_REG_BITS  64
-# define TCG_TARGET_NB_REGS   16
+# if defined(TARGET_WORDS_BIGENDIAN) == defined(HOST_WORDS_BIGENDIAN)
+#  define TCG_TARGET_HAS_REG128 1
+# endif
+# ifdef TCG_TARGET_HAS_REG128
+#  define TCG_TARGET_REG_BITS  64
+#  define TCG_TARGET_NB_REGS   32
+# else
+#  define TCG_TARGET_REG_BITS  64
+#  define TCG_TARGET_NB_REGS   16
+# endif
 #else
 # define TCG_TARGET_REG_BITS  32
 # define TCG_TARGET_NB_REGS    8
@@ -56,6 +64,24 @@ typedef enum {
     TCG_REG_R13,
     TCG_REG_R14,
     TCG_REG_R15,
+
+    TCG_REG_XMM0,
+    TCG_REG_XMM1,
+    TCG_REG_XMM2,
+    TCG_REG_XMM3,
+    TCG_REG_XMM4,
+    TCG_REG_XMM5,
+    TCG_REG_XMM6,
+    TCG_REG_XMM7,
+    TCG_REG_XMM8,
+    TCG_REG_XMM9,
+    TCG_REG_XMM10,
+    TCG_REG_XMM11,
+    TCG_REG_XMM12,
+    TCG_REG_XMM13,
+    TCG_REG_XMM14,
+    TCG_REG_XMM15,
+
     TCG_REG_RAX = TCG_REG_EAX,
     TCG_REG_RCX = TCG_REG_ECX,
     TCG_REG_RDX = TCG_REG_EDX,
@@ -144,6 +170,10 @@ extern bool have_popcnt;
 #define TCG_TARGET_HAS_mulsh_i64        0
 #endif
 
+#ifdef TCG_TARGET_HAS_REG128
+#define TCG_TARGET_HAS_add_i32x4        1
+#endif
+
 #define TCG_TARGET_deposit_i32_valid(ofs, len) \
     (((ofs) == 0 && (len) == 8) || ((ofs) == 8 && (len) == 8) || \
      ((ofs) == 0 && (len) == 16))
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 5918008..3e718f3 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -32,6 +32,11 @@ static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
 #else
     "%eax", "%ecx", "%edx", "%ebx", "%esp", "%ebp", "%esi", "%edi",
 #endif
+#ifdef TCG_TARGET_HAS_REG128
+    "%xmm0", "%xmm1", "%xmm2", "%xmm3", "%xmm4", "%xmm5", "%xmm6", "%xmm7",
+    "%xmm8", "%xmm9", "%xmm10", "%xmm11", "%xmm12", "%xmm13", "%xmm14",
+    "%xmm15",
+#endif
 };
 #endif
 
@@ -61,6 +66,24 @@ static const int tcg_target_reg_alloc_order[] = {
     TCG_REG_EDX,
     TCG_REG_EAX,
 #endif
+#ifdef TCG_TARGET_HAS_REG128
+    TCG_REG_XMM0,
+    TCG_REG_XMM1,
+    TCG_REG_XMM2,
+    TCG_REG_XMM3,
+    TCG_REG_XMM4,
+    TCG_REG_XMM5,
+    TCG_REG_XMM6,
+/*  TCG_REG_XMM7, <- scratch register */
+    TCG_REG_XMM8,
+    TCG_REG_XMM9,
+    TCG_REG_XMM10,
+    TCG_REG_XMM11,
+    TCG_REG_XMM12,
+    TCG_REG_XMM13,
+    TCG_REG_XMM14,
+    TCG_REG_XMM15,
+#endif
 };
 
 static const int tcg_target_call_iarg_regs[] = {
@@ -247,6 +270,10 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
     case 'I':
         ct->ct |= (type == TCG_TYPE_I32 ? TCG_CT_CONST : TCG_CT_CONST_I32);
         break;
+    case 'V':
+        ct->ct |= TCG_CT_REG;
+        tcg_regset_set32(ct->u.regs, 0, 0xff0000);
+        break;
 
     default:
         return NULL;
@@ -302,6 +329,9 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define P_SIMDF3        0x10000         /* 0xf3 opcode prefix */
 #define P_SIMDF2        0x20000         /* 0xf2 opcode prefix */
 
+#define P_SSE_660F      (P_DATA16 | P_EXT)
+#define P_SSE_F30F      (P_SIMDF3 | P_EXT)
+
 #define OPC_ARITH_EvIz	(0x81)
 #define OPC_ARITH_EvIb	(0x83)
 #define OPC_ARITH_GvEv	(0x03)		/* ... plus (ARITH_FOO << 3) */
@@ -357,6 +387,11 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_GRP3_Ev	(0xf7)
 #define OPC_GRP5	(0xff)
 
+#define OPC_MOVDQU_M2R  (0x6f | P_SSE_F30F)  /* store 128-bit value */
+#define OPC_MOVDQU_R2M  (0x7f | P_SSE_F30F)  /* load 128-bit value */
+#define OPC_MOVDQA_R2R  (0x6f | P_SSE_660F)  /* reg-to-reg 128-bit mov */
+#define OPC_PADDD       (0xfe | P_SSE_660F)
+
 /* Group 1 opcode extensions for 0x80-0x83.
    These are also used as modifiers for OPC_ARITH.  */
 #define ARITH_ADD 0
@@ -434,6 +469,9 @@ static void tcg_out_opc(TCGContext *s, int opc, int r, int rm, int x)
         tcg_debug_assert((opc & P_REXW) == 0);
         tcg_out8(s, 0x66);
     }
+    if (opc & P_SIMDF3) {
+        tcg_out8(s, 0xf3);
+    }
     if (opc & P_ADDR32) {
         tcg_out8(s, 0x67);
     }
@@ -650,9 +688,26 @@ static inline void tgen_arithr(TCGContext *s, int subop, int dest, int src)
 static inline void tcg_out_mov(TCGContext *s, TCGType type,
                                TCGReg ret, TCGReg arg)
 {
+    int opc;
     if (arg != ret) {
-        int opc = OPC_MOVL_GvEv + (type == TCG_TYPE_I64 ? P_REXW : 0);
-        tcg_out_modrm(s, opc, ret, arg);
+        switch (type) {
+        case TCG_TYPE_V128:
+            ret -= TCG_REG_XMM0;
+            arg -= TCG_REG_XMM0;
+            if (have_avx) {
+                tcg_out_vex_modrm(s, OPC_MOVDQA_R2R, ret, 15, arg);
+            } else {
+                tcg_out_modrm(s, OPC_MOVDQA_R2R, ret, arg);
+            }
+            break;
+        case TCG_TYPE_I32:
+        case TCG_TYPE_I64:
+            opc = OPC_MOVL_GvEv + (type == TCG_TYPE_I64 ? P_REXW : 0);
+            tcg_out_modrm(s, opc, ret, arg);
+            break;
+        default:
+            g_assert_not_reached();
+        }
     }
 }
 
@@ -727,15 +782,39 @@ static inline void tcg_out_pop(TCGContext *s, int reg)
 static inline void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret,
                               TCGReg arg1, intptr_t arg2)
 {
-    int opc = OPC_MOVL_GvEv + (type == TCG_TYPE_I64 ? P_REXW : 0);
-    tcg_out_modrm_offset(s, opc, ret, arg1, arg2);
+    int opc;
+    switch (type) {
+    case TCG_TYPE_V128:
+        ret -= TCG_REG_XMM0;
+        tcg_out_modrm_offset(s, OPC_MOVDQU_M2R, ret, arg1, arg2);
+        break;
+    case TCG_TYPE_I32:
+    case TCG_TYPE_I64:
+        opc = OPC_MOVL_GvEv + (type == TCG_TYPE_I64 ? P_REXW : 0);
+        tcg_out_modrm_offset(s, opc, ret, arg1, arg2);
+        break;
+    default:
+        g_assert_not_reached();
+    }
 }
 
 static inline void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
                               TCGReg arg1, intptr_t arg2)
 {
-    int opc = OPC_MOVL_EvGv + (type == TCG_TYPE_I64 ? P_REXW : 0);
-    tcg_out_modrm_offset(s, opc, arg, arg1, arg2);
+    int opc;
+    switch (type) {
+    case TCG_TYPE_V128:
+        arg -= TCG_REG_XMM0;
+        tcg_out_modrm_offset(s, OPC_MOVDQU_R2M, arg, arg1, arg2);
+        break;
+    case TCG_TYPE_I32:
+    case TCG_TYPE_I64:
+        opc = OPC_MOVL_EvGv + (type == TCG_TYPE_I64 ? P_REXW : 0);
+        tcg_out_modrm_offset(s, opc, arg, arg1, arg2);
+        break;
+    default:
+        g_assert_not_reached();
+    }
 }
 
 static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
@@ -1929,6 +2008,9 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_ld_i32:
         tcg_out_ld(s, TCG_TYPE_I32, a0, a1, a2);
         break;
+    case INDEX_op_ld_v128:
+        tcg_out_ld(s, TCG_TYPE_V128, args[0], args[1], args[2]);
+        break;
 
     OP_32_64(st8):
         if (const_args[0]) {
@@ -1957,6 +2039,9 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
             tcg_out_st(s, TCG_TYPE_I32, a0, a1, a2);
         }
         break;
+    case INDEX_op_st_v128:
+        tcg_out_st(s, TCG_TYPE_V128, args[0], args[1], args[2]);
+        break;
 
     OP_32_64(add):
         /* For 3-operand addition, use LEA.  */
@@ -2263,6 +2348,11 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_mb:
         tcg_out_mb(s, a0);
         break;
+
+    case INDEX_op_add_i32x4:
+        tcg_out_modrm(s, OPC_PADDD, args[0], args[2]);
+        break;
+
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_mov_i64:
     case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
@@ -2297,6 +2387,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         = { .args_ct_str = { "r", "r", "L", "L" } };
     static const TCGTargetOpDef L_L_L_L
         = { .args_ct_str = { "L", "L", "L", "L" } };
+    static const TCGTargetOpDef V_r = { .args_ct_str  = { "V", "r" } };
+    static const TCGTargetOpDef V_0_V = { .args_ct_str  = { "V", "0", "V" } };
 
     switch (op) {
     case INDEX_op_ld8u_i32:
@@ -2313,6 +2405,10 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ld_i64:
         return &r_r;
 
+    case INDEX_op_ld_v128:
+    case INDEX_op_st_v128:
+        return &V_r;
+
     case INDEX_op_st8_i32:
     case INDEX_op_st8_i64:
         return &qi_r;
@@ -2495,6 +2591,9 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
             return &s2;
         }
 
+    case INDEX_op_add_i32x4:
+        return &V_0_V;
+
     default:
         break;
     }
-- 
2.1.4
