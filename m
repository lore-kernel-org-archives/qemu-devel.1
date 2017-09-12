Received: from eggs.gnu.org ([2001:4830:134:3::10]:38111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dro0E-0001pL-44
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dro0A-00075X-Is
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:34 -0400
Received: from mail-pf0-x233.google.com ([2607:f8b0:400e:c00::233]:35556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dro0A-00074W-7q
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:30 -0400
Received: by mail-pf0-x233.google.com with SMTP id q76so5835189pfq.2
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 09:25:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 12 Sep 2017 09:25:06 -0700
Message-Id: <20170912162513.21694-10-richard.henderson@linaro.org>
In-Reply-To: <20170912162513.21694-1-richard.henderson@linaro.org>
References: <20170912162513.21694-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 09/16] tcg/i386: Add vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, f4bug@amsat.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.h     |  46 ++++-
 tcg/i386/tcg-target.inc.c | 438 +++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 438 insertions(+), 46 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index b89dababf4..03f2506223 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -30,11 +30,10 @@
 
 #ifdef __x86_64__
 # define TCG_TARGET_REG_BITS  64
-# define TCG_TARGET_NB_REGS   16
 #else
 # define TCG_TARGET_REG_BITS  32
-# define TCG_TARGET_NB_REGS    8
 #endif
+# define TCG_TARGET_NB_REGS   24
 
 typedef enum {
     TCG_REG_EAX = 0,
@@ -56,6 +55,19 @@ typedef enum {
     TCG_REG_R13,
     TCG_REG_R14,
     TCG_REG_R15,
+
+    /* SSE registers; 64-bit has access to 8 more, but we won't
+       need more than a few and using only the first 8 minimizes
+       the need for a rex prefix on the sse instructions.  */
+    TCG_REG_XMM0,
+    TCG_REG_XMM1,
+    TCG_REG_XMM2,
+    TCG_REG_XMM3,
+    TCG_REG_XMM4,
+    TCG_REG_XMM5,
+    TCG_REG_XMM6,
+    TCG_REG_XMM7,
+
     TCG_REG_RAX = TCG_REG_EAX,
     TCG_REG_RCX = TCG_REG_ECX,
     TCG_REG_RDX = TCG_REG_EDX,
@@ -78,6 +90,17 @@ typedef enum {
 extern bool have_bmi1;
 extern bool have_popcnt;
 
+#ifdef __SSE2__
+#define have_sse2  true
+#else
+extern bool have_sse2;
+#endif
+#ifdef __AVX2__
+#define have_avx2  true
+#else
+extern bool have_avx2;
+#endif
+
 /* optional instructions */
 #define TCG_TARGET_HAS_div2_i32         1
 #define TCG_TARGET_HAS_rot_i32          1
@@ -146,6 +169,25 @@ extern bool have_popcnt;
 #define TCG_TARGET_HAS_mulsh_i64        0
 #endif
 
+#define TCG_TARGET_HAS_v64              have_sse2
+#define TCG_TARGET_HAS_v128             have_sse2
+#define TCG_TARGET_HAS_v256             have_avx2
+
+#define TCG_TARGET_HAS_andc_v64         TCG_TARGET_HAS_v64
+#define TCG_TARGET_HAS_orc_v64          0
+#define TCG_TARGET_HAS_not_v64          0
+#define TCG_TARGET_HAS_neg_v64          0
+
+#define TCG_TARGET_HAS_andc_v128        TCG_TARGET_HAS_v128
+#define TCG_TARGET_HAS_orc_v128         0
+#define TCG_TARGET_HAS_not_v128         0
+#define TCG_TARGET_HAS_neg_v128         0
+
+#define TCG_TARGET_HAS_andc_v256        TCG_TARGET_HAS_v256
+#define TCG_TARGET_HAS_orc_v256         0
+#define TCG_TARGET_HAS_not_v256         0
+#define TCG_TARGET_HAS_neg_v256         0
+
 #define TCG_TARGET_deposit_i32_valid(ofs, len) \
     (((ofs) == 0 && (len) == 8) || ((ofs) == 8 && (len) == 8) || \
      ((ofs) == 0 && (len) == 16))
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 5231056fd3..fbb41c3b7a 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -28,10 +28,11 @@
 static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
 #if TCG_TARGET_REG_BITS == 64
     "%rax", "%rcx", "%rdx", "%rbx", "%rsp", "%rbp", "%rsi", "%rdi",
-    "%r8",  "%r9",  "%r10", "%r11", "%r12", "%r13", "%r14", "%r15",
 #else
     "%eax", "%ecx", "%edx", "%ebx", "%esp", "%ebp", "%esi", "%edi",
 #endif
+    "%r8",  "%r9",  "%r10", "%r11", "%r12", "%r13", "%r14", "%r15",
+    "%xmm0", "%xmm1", "%xmm2", "%xmm3", "%xmm4", "%xmm5", "%xmm6", "%xmm7",
 };
 #endif
 
@@ -61,6 +62,14 @@ static const int tcg_target_reg_alloc_order[] = {
     TCG_REG_EDX,
     TCG_REG_EAX,
 #endif
+    TCG_REG_XMM0,
+    TCG_REG_XMM1,
+    TCG_REG_XMM2,
+    TCG_REG_XMM3,
+    TCG_REG_XMM4,
+    TCG_REG_XMM5,
+    TCG_REG_XMM6,
+    TCG_REG_XMM7,
 };
 
 static const int tcg_target_call_iarg_regs[] = {
@@ -94,7 +103,7 @@ static const int tcg_target_call_oarg_regs[] = {
 #define TCG_CT_CONST_I32 0x400
 #define TCG_CT_CONST_WSZ 0x800
 
-/* Registers used with L constraint, which are the first argument 
+/* Registers used with L constraint, which are the first argument
    registers on x86_64, and two random call clobbered registers on
    i386. */
 #if TCG_TARGET_REG_BITS == 64
@@ -126,6 +135,16 @@ static bool have_cmov;
 bool have_bmi1;
 bool have_popcnt;
 
+#ifndef have_sse2
+bool have_sse2;
+#endif
+#ifdef have_avx2
+#define have_avx1  have_avx2
+#else
+static bool have_avx1;
+bool have_avx2;
+#endif
+
 #ifdef CONFIG_CPUID_H
 static bool have_movbe;
 static bool have_bmi2;
@@ -192,6 +211,7 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
         tcg_regset_set_reg(ct->u.regs, TCG_REG_EDI);
         break;
     case 'q':
+        /* A register that can be used as a byte operand.  */
         ct->ct |= TCG_CT_REG;
         if (TCG_TARGET_REG_BITS == 64) {
             tcg_regset_set32(ct->u.regs, 0, 0xffff);
@@ -200,10 +220,12 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
         }
         break;
     case 'Q':
+        /* A register with an addressable second byte (e.g. %ah).  */
         ct->ct |= TCG_CT_REG;
         tcg_regset_set32(ct->u.regs, 0, 0xf);
         break;
     case 'r':
+        /* A general register.  */
         ct->ct |= TCG_CT_REG;
         if (TCG_TARGET_REG_BITS == 64) {
             tcg_regset_set32(ct->u.regs, 0, 0xffff);
@@ -215,6 +237,11 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
         /* With TZCNT/LZCNT, we can have operand-size as an input.  */
         ct->ct |= TCG_CT_CONST_WSZ;
         break;
+    case 'x':
+        /* A vector register.  */
+        ct->ct |= TCG_CT_REG;
+        tcg_regset_set32(ct->u.regs, 0, 0xff0000);
+        break;
 
         /* qemu_ld/st address constraint */
     case 'L':
@@ -289,8 +316,9 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 # define P_REXB_RM	0
 # define P_GS           0
 #endif
-#define P_SIMDF3        0x10000         /* 0xf3 opcode prefix */
-#define P_SIMDF2        0x20000         /* 0xf2 opcode prefix */
+#define P_SIMDF3        0x20000         /* 0xf3 opcode prefix */
+#define P_SIMDF2        0x40000         /* 0xf2 opcode prefix */
+#define P_VEXL          0x80000         /* Set VEX.L = 1 */
 
 #define OPC_ARITH_EvIz	(0x81)
 #define OPC_ARITH_EvIb	(0x83)
@@ -322,11 +350,29 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_MOVL_Iv     (0xb8)
 #define OPC_MOVBE_GyMy  (0xf0 | P_EXT38)
 #define OPC_MOVBE_MyGy  (0xf1 | P_EXT38)
+#define OPC_MOVDQA_GyMy (0x6f | P_EXT | P_DATA16)
+#define OPC_MOVDQA_MyGy (0x7f | P_EXT | P_DATA16)
+#define OPC_MOVDQU_GyMy (0x6f | P_EXT | P_SIMDF3)
+#define OPC_MOVDQU_MyGy (0x7f | P_EXT | P_SIMDF3)
+#define OPC_MOVQ_GyMy   (0x7e | P_EXT | P_SIMDF3)
+#define OPC_MOVQ_MyGy   (0xd6 | P_EXT | P_DATA16)
 #define OPC_MOVSBL	(0xbe | P_EXT)
 #define OPC_MOVSWL	(0xbf | P_EXT)
 #define OPC_MOVSLQ	(0x63 | P_REXW)
 #define OPC_MOVZBL	(0xb6 | P_EXT)
 #define OPC_MOVZWL	(0xb7 | P_EXT)
+#define OPC_PADDB       (0xfc | P_EXT | P_DATA16)
+#define OPC_PADDW       (0xfd | P_EXT | P_DATA16)
+#define OPC_PADDD       (0xfe | P_EXT | P_DATA16)
+#define OPC_PADDQ       (0xd4 | P_EXT | P_DATA16)
+#define OPC_PAND        (0xdb | P_EXT | P_DATA16)
+#define OPC_PANDN       (0xdf | P_EXT | P_DATA16)
+#define OPC_POR         (0xeb | P_EXT | P_DATA16)
+#define OPC_PSUBB       (0xf8 | P_EXT | P_DATA16)
+#define OPC_PSUBW       (0xf9 | P_EXT | P_DATA16)
+#define OPC_PSUBD       (0xfa | P_EXT | P_DATA16)
+#define OPC_PSUBQ       (0xfb | P_EXT | P_DATA16)
+#define OPC_PXOR        (0xef | P_EXT | P_DATA16)
 #define OPC_POP_r32	(0x58)
 #define OPC_POPCNT      (0xb8 | P_EXT | P_SIMDF3)
 #define OPC_PUSH_r32	(0x50)
@@ -342,6 +388,7 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_SHRX        (0xf7 | P_EXT38 | P_SIMDF2)
 #define OPC_TESTL	(0x85)
 #define OPC_TZCNT       (0xbc | P_EXT | P_SIMDF3)
+#define OPC_VZEROUPPER  (0x77 | P_EXT)
 #define OPC_XCHG_ax_r32	(0x90)
 
 #define OPC_GRP3_Ev	(0xf7)
@@ -491,11 +538,20 @@ static void tcg_out_modrm(TCGContext *s, int opc, int r, int rm)
     tcg_out8(s, 0xc0 | (LOWREGMASK(r) << 3) | LOWREGMASK(rm));
 }
 
-static void tcg_out_vex_modrm(TCGContext *s, int opc, int r, int v, int rm)
+static void tcg_out_vex_opc(TCGContext *s, int opc, int r, int v,
+                            int rm, int index)
 {
     int tmp;
 
-    if ((opc & (P_REXW | P_EXT | P_EXT38)) || (rm & 8)) {
+    /* Use the two byte form if possible, which cannot encode
+       VEX.W, VEX.B, VEX.X, or an m-mmmm field other than P_EXT.  */
+    if ((opc & (P_EXT | P_EXT38 | P_REXW)) == P_EXT
+        && ((rm | index) & 8) == 0) {
+        /* Two byte VEX prefix.  */
+        tcg_out8(s, 0xc5);
+
+        tmp = (r & 8 ? 0 : 0x80);              /* VEX.R */
+    } else {
         /* Three byte VEX prefix.  */
         tcg_out8(s, 0xc4);
 
@@ -505,20 +561,17 @@ static void tcg_out_vex_modrm(TCGContext *s, int opc, int r, int v, int rm)
         } else if (opc & P_EXT) {
             tmp = 1;
         } else {
-            tcg_abort();
+            g_assert_not_reached();
         }
-        tmp |= 0x40;                       /* VEX.X */
-        tmp |= (r & 8 ? 0 : 0x80);         /* VEX.R */
-        tmp |= (rm & 8 ? 0 : 0x20);        /* VEX.B */
+        tmp |= (r & 8 ? 0 : 0x80);             /* VEX.R */
+        tmp |= (index & 8 ? 0 : 0x40);         /* VEX.X */
+        tmp |= (rm & 8 ? 0 : 0x20);            /* VEX.B */
         tcg_out8(s, tmp);
 
-        tmp = (opc & P_REXW ? 0x80 : 0);   /* VEX.W */
-    } else {
-        /* Two byte VEX prefix.  */
-        tcg_out8(s, 0xc5);
-
-        tmp = (r & 8 ? 0 : 0x80);          /* VEX.R */
+        tmp = (opc & P_REXW ? 0x80 : 0);       /* VEX.W */
     }
+
+    tmp |= (opc & P_VEXL ? 0x04 : 0);      /* VEX.L */
     /* VEX.pp */
     if (opc & P_DATA16) {
         tmp |= 1;                          /* 0x66 */
@@ -530,6 +583,11 @@ static void tcg_out_vex_modrm(TCGContext *s, int opc, int r, int v, int rm)
     tmp |= (~v & 15) << 3;                 /* VEX.vvvv */
     tcg_out8(s, tmp);
     tcg_out8(s, opc);
+}
+
+static void tcg_out_vex_modrm(TCGContext *s, int opc, int r, int v, int rm)
+{
+    tcg_out_vex_opc(s, opc, r, v, rm, 0);
     tcg_out8(s, 0xc0 | (LOWREGMASK(r) << 3) | LOWREGMASK(rm));
 }
 
@@ -538,8 +596,8 @@ static void tcg_out_vex_modrm(TCGContext *s, int opc, int r, int v, int rm)
    mode for absolute addresses, ~RM is the size of the immediate operand
    that will follow the instruction.  */
 
-static void tcg_out_modrm_sib_offset(TCGContext *s, int opc, int r, int rm,
-                                     int index, int shift, intptr_t offset)
+static void tcg_out_sib_offset(TCGContext *s, int r, int rm, int index,
+                               int shift, intptr_t offset)
 {
     int mod, len;
 
@@ -550,7 +608,6 @@ static void tcg_out_modrm_sib_offset(TCGContext *s, int opc, int r, int rm,
             intptr_t pc = (intptr_t)s->code_ptr + 5 + ~rm;
             intptr_t disp = offset - pc;
             if (disp == (int32_t)disp) {
-                tcg_out_opc(s, opc, r, 0, 0);
                 tcg_out8(s, (LOWREGMASK(r) << 3) | 5);
                 tcg_out32(s, disp);
                 return;
@@ -560,7 +617,6 @@ static void tcg_out_modrm_sib_offset(TCGContext *s, int opc, int r, int rm,
                use of the MODRM+SIB encoding and is therefore larger than
                rip-relative addressing.  */
             if (offset == (int32_t)offset) {
-                tcg_out_opc(s, opc, r, 0, 0);
                 tcg_out8(s, (LOWREGMASK(r) << 3) | 4);
                 tcg_out8(s, (4 << 3) | 5);
                 tcg_out32(s, offset);
@@ -568,10 +624,9 @@ static void tcg_out_modrm_sib_offset(TCGContext *s, int opc, int r, int rm,
             }
 
             /* ??? The memory isn't directly addressable.  */
-            tcg_abort();
+            g_assert_not_reached();
         } else {
             /* Absolute address.  */
-            tcg_out_opc(s, opc, r, 0, 0);
             tcg_out8(s, (r << 3) | 5);
             tcg_out32(s, offset);
             return;
@@ -594,7 +649,6 @@ static void tcg_out_modrm_sib_offset(TCGContext *s, int opc, int r, int rm,
        that would be used for %esp is the escape to the two byte form.  */
     if (index < 0 && LOWREGMASK(rm) != TCG_REG_ESP) {
         /* Single byte MODRM format.  */
-        tcg_out_opc(s, opc, r, rm, 0);
         tcg_out8(s, mod | (LOWREGMASK(r) << 3) | LOWREGMASK(rm));
     } else {
         /* Two byte MODRM+SIB format.  */
@@ -608,7 +662,6 @@ static void tcg_out_modrm_sib_offset(TCGContext *s, int opc, int r, int rm,
             tcg_debug_assert(index != TCG_REG_ESP);
         }
 
-        tcg_out_opc(s, opc, r, rm, index);
         tcg_out8(s, mod | (LOWREGMASK(r) << 3) | 4);
         tcg_out8(s, (shift << 6) | (LOWREGMASK(index) << 3) | LOWREGMASK(rm));
     }
@@ -620,6 +673,21 @@ static void tcg_out_modrm_sib_offset(TCGContext *s, int opc, int r, int rm,
     }
 }
 
+static void tcg_out_modrm_sib_offset(TCGContext *s, int opc, int r, int rm,
+                                     int index, int shift, intptr_t offset)
+{
+    tcg_out_opc(s, opc, r, rm < 0 ? 0 : rm, index < 0 ? 0 : index);
+    tcg_out_sib_offset(s, r, rm, index, shift, offset);
+}
+
+static void tcg_out_vex_modrm_sib_offset(TCGContext *s, int opc, int r, int v,
+                                         int rm, int index, int shift,
+                                         intptr_t offset)
+{
+    tcg_out_vex_opc(s, opc, r, v, rm < 0 ? 0 : rm, index < 0 ? 0 : index);
+    tcg_out_sib_offset(s, r, rm, index, shift, offset);
+}
+
 /* A simplification of the above with no index or shift.  */
 static inline void tcg_out_modrm_offset(TCGContext *s, int opc, int r,
                                         int rm, intptr_t offset)
@@ -627,6 +695,31 @@ static inline void tcg_out_modrm_offset(TCGContext *s, int opc, int r,
     tcg_out_modrm_sib_offset(s, opc, r, rm, -1, 0, offset);
 }
 
+static inline void tcg_out_vex_modrm_offset(TCGContext *s, int opc, int r,
+                                            int v, int rm, intptr_t offset)
+{
+    tcg_out_vex_modrm_sib_offset(s, opc, r, v, rm, -1, 0, offset);
+}
+
+static void tcg_out_maybe_vex_modrm(TCGContext *s, int opc, int r, int rm)
+{
+    if (have_avx1) {
+        tcg_out_vex_modrm(s, opc, r, 0, rm);
+    } else {
+        tcg_out_modrm(s, opc, r, rm);
+    }
+}
+
+static void tcg_out_maybe_vex_modrm_offset(TCGContext *s, int opc, int r,
+                                           int rm, intptr_t offset)
+{
+    if (have_avx1) {
+        tcg_out_vex_modrm_offset(s, opc, r, 0, rm, offset);
+    } else {
+        tcg_out_modrm_offset(s, opc, r, rm, offset);
+    }
+}
+
 /* Generate dest op= src.  Uses the same ARITH_* codes as tgen_arithi.  */
 static inline void tgen_arithr(TCGContext *s, int subop, int dest, int src)
 {
@@ -637,12 +730,33 @@ static inline void tgen_arithr(TCGContext *s, int subop, int dest, int src)
     tcg_out_modrm(s, OPC_ARITH_GvEv + (subop << 3) + ext, dest, src);
 }
 
-static inline void tcg_out_mov(TCGContext *s, TCGType type,
-                               TCGReg ret, TCGReg arg)
+static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
 {
-    if (arg != ret) {
-        int opc = OPC_MOVL_GvEv + (type == TCG_TYPE_I64 ? P_REXW : 0);
-        tcg_out_modrm(s, opc, ret, arg);
+    if (arg == ret) {
+        return;
+    }
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_debug_assert(ret < 16 && arg < 16);
+        tcg_out_modrm(s, OPC_MOVL_GvEv, ret, arg);
+        break;
+    case TCG_TYPE_I64:
+        tcg_debug_assert(ret < 16 && arg < 16);
+        tcg_out_modrm(s, OPC_MOVL_GvEv | P_REXW, ret, arg);
+        break;
+
+    case TCG_TYPE_V256:
+        tcg_debug_assert(ret >= 16 && arg >= 16);
+        tcg_out_vex_modrm(s, OPC_MOVDQA_GyMy | P_VEXL, ret, 0, arg);
+        break;
+    case TCG_TYPE_V128:
+    case TCG_TYPE_V64:
+        tcg_debug_assert(ret >= 16 && arg >= 16);
+        tcg_out_maybe_vex_modrm(s, OPC_MOVDQA_GyMy, ret, arg);
+        break;
+
+    default:
+        g_assert_not_reached();
     }
 }
 
@@ -651,6 +765,29 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
 {
     tcg_target_long diff;
 
+    switch (type) {
+    case TCG_TYPE_I32:
+    case TCG_TYPE_I64:
+        tcg_debug_assert(ret < 16);
+        break;
+
+    case TCG_TYPE_V64:
+    case TCG_TYPE_V128:
+    case TCG_TYPE_V256:
+        tcg_debug_assert(ret >= 16);
+        /* ??? Revisit this as the implementation progresses.  */
+        tcg_debug_assert(arg == 0);
+        if (have_avx1) {
+            tcg_out_vex_modrm(s, OPC_PXOR, ret, ret, ret);
+        } else {
+            tcg_out_modrm(s, OPC_PXOR, ret, ret);
+        }
+        return;
+
+    default:
+        g_assert_not_reached();
+    }
+
     if (arg == 0) {
         tgen_arithr(s, ARITH_XOR, ret, ret);
         return;
@@ -714,18 +851,64 @@ static inline void tcg_out_pop(TCGContext *s, int reg)
     tcg_out_opc(s, OPC_POP_r32 + LOWREGMASK(reg), 0, reg, 0);
 }
 
-static inline void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret,
-                              TCGReg arg1, intptr_t arg2)
+static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret,
+                       TCGReg arg1, intptr_t arg2)
 {
-    int opc = OPC_MOVL_GvEv + (type == TCG_TYPE_I64 ? P_REXW : 0);
-    tcg_out_modrm_offset(s, opc, ret, arg1, arg2);
+    switch (type) {
+    case TCG_TYPE_I64:
+        tcg_debug_assert(ret < 16);
+        tcg_out_modrm_offset(s, OPC_MOVL_GvEv | P_REXW, ret, arg1, arg2);
+        break;
+    case TCG_TYPE_I32:
+        tcg_debug_assert(ret < 16);
+        tcg_out_modrm_offset(s, OPC_MOVL_GvEv, ret, arg1, arg2);
+        break;
+    case TCG_TYPE_V64:
+        tcg_debug_assert(ret >= 16);
+        tcg_out_maybe_vex_modrm_offset(s, OPC_MOVQ_GyMy, ret, arg1, arg2);
+        break;
+    case TCG_TYPE_V128:
+        tcg_debug_assert(ret >= 16);
+        tcg_out_maybe_vex_modrm_offset(s, OPC_MOVDQU_GyMy, ret, arg1, arg2);
+        break;
+    case TCG_TYPE_V256:
+        tcg_debug_assert(ret >= 16);
+        tcg_out_vex_modrm_offset(s, OPC_MOVDQU_GyMy | P_VEXL,
+                                 ret, 0, arg1, arg2);
+        break;
+    default:
+        g_assert_not_reached();
+    }
 }
 
-static inline void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
-                              TCGReg arg1, intptr_t arg2)
+static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
+                       TCGReg arg1, intptr_t arg2)
 {
-    int opc = OPC_MOVL_EvGv + (type == TCG_TYPE_I64 ? P_REXW : 0);
-    tcg_out_modrm_offset(s, opc, arg, arg1, arg2);
+    switch (type) {
+    case TCG_TYPE_I64:
+        tcg_debug_assert(arg < 16);
+        tcg_out_modrm_offset(s, OPC_MOVL_EvGv | P_REXW, arg, arg1, arg2);
+        break;
+    case TCG_TYPE_I32:
+        tcg_debug_assert(arg < 16);
+        tcg_out_modrm_offset(s, OPC_MOVL_EvGv, arg, arg1, arg2);
+        break;
+    case TCG_TYPE_V64:
+        tcg_debug_assert(arg >= 16);
+        tcg_out_maybe_vex_modrm_offset(s, OPC_MOVQ_MyGy, arg, arg1, arg2);
+        break;
+    case TCG_TYPE_V128:
+        tcg_debug_assert(arg >= 16);
+        tcg_out_maybe_vex_modrm_offset(s, OPC_MOVDQU_MyGy, arg, arg1, arg2);
+        break;
+    case TCG_TYPE_V256:
+        tcg_debug_assert(arg >= 16);
+        tcg_out_vex_modrm_offset(s, OPC_MOVDQU_MyGy | P_VEXL,
+                                 arg, 0, arg1, arg2);
+        break;
+    default:
+        g_assert_not_reached();
+    }
 }
 
 static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
@@ -737,6 +920,8 @@ static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
             return false;
         }
         rexw = P_REXW;
+    } else if (type != TCG_TYPE_I32) {
+        return false;
     }
     tcg_out_modrm_offset(s, OPC_MOVL_EvIz | rexw, 0, base, ofs);
     tcg_out32(s, val);
@@ -1871,6 +2056,15 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         case glue(glue(INDEX_op_, x), _i32)
 #endif
 
+#define OP_128_256(x) \
+        case glue(glue(INDEX_op_, x), _v256): \
+            rexw = P_VEXL; /* FALLTHRU */     \
+        case glue(glue(INDEX_op_, x), _v128)
+
+#define OP_64_128_256(x) \
+        OP_128_256(x):   \
+        case glue(glue(INDEX_op_, x), _v64)
+
     /* Hoist the loads of the most common arguments.  */
     a0 = args[0];
     a1 = args[1];
@@ -2266,19 +2460,98 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
+    OP_64_128_256(add8):
+        c = OPC_PADDB;
+        goto gen_simd;
+    OP_64_128_256(add16):
+        c = OPC_PADDW;
+        goto gen_simd;
+    OP_64_128_256(add32):
+        c = OPC_PADDD;
+        goto gen_simd;
+    OP_128_256(add64):
+        c = OPC_PADDQ;
+        goto gen_simd;
+    OP_64_128_256(sub8):
+        c = OPC_PSUBB;
+        goto gen_simd;
+    OP_64_128_256(sub16):
+        c = OPC_PSUBW;
+        goto gen_simd;
+    OP_64_128_256(sub32):
+        c = OPC_PSUBD;
+        goto gen_simd;
+    OP_128_256(sub64):
+        c = OPC_PSUBQ;
+        goto gen_simd;
+    OP_64_128_256(and):
+        c = OPC_PAND;
+        goto gen_simd;
+    OP_64_128_256(or):
+        c = OPC_POR;
+        goto gen_simd;
+    OP_64_128_256(xor):
+        c = OPC_PXOR;
+    gen_simd:
+        if (have_avx1) {
+            tcg_out_vex_modrm(s, c, a0, a1, a2);
+        } else {
+            tcg_out_modrm(s, c, a0, a2);
+        }
+        break;
+    OP_64_128_256(andc):
+        if (have_avx1) {
+            tcg_out_vex_modrm(s, OPC_PANDN, a0, a2, a1);
+        } else {
+            tcg_out_modrm(s, c, a0, a1);
+        }
+        break;
+
+    case INDEX_op_ld_v64:
+        c = TCG_TYPE_V64;
+        goto gen_simd_ld;
+    case INDEX_op_ld_v128:
+        c = TCG_TYPE_V128;
+        goto gen_simd_ld;
+    case INDEX_op_ld_v256:
+        c = TCG_TYPE_V256;
+    gen_simd_ld:
+        tcg_out_ld(s, c, a0, a1, a2);
+        break;
+
+    case INDEX_op_st_v64:
+        c = TCG_TYPE_V64;
+        goto gen_simd_st;
+    case INDEX_op_st_v128:
+        c = TCG_TYPE_V128;
+        goto gen_simd_st;
+    case INDEX_op_st_v256:
+        c = TCG_TYPE_V256;
+    gen_simd_st:
+        tcg_out_st(s, c, a0, a1, a2);
+        break;
+
     case INDEX_op_mb:
         tcg_out_mb(s, a0);
         break;
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_mov_i64:
+    case INDEX_op_mov_v64:
+    case INDEX_op_mov_v128:
+    case INDEX_op_mov_v256:
     case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
     case INDEX_op_movi_i64:
+    case INDEX_op_movi_v64:
+    case INDEX_op_movi_v128:
+    case INDEX_op_movi_v256:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     default:
         tcg_abort();
     }
 
 #undef OP_32_64
+#undef OP_128_256
+#undef OP_64_128_256
 }
 
 static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
@@ -2304,6 +2577,10 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         = { .args_ct_str = { "r", "r", "L", "L" } };
     static const TCGTargetOpDef L_L_L_L
         = { .args_ct_str = { "L", "L", "L", "L" } };
+    static const TCGTargetOpDef x_0_x = { .args_ct_str = { "x", "0", "x" } };
+    static const TCGTargetOpDef x_x_0 = { .args_ct_str = { "x", "x", "0" } };
+    static const TCGTargetOpDef x_x_x = { .args_ct_str = { "x", "x", "x" } };
+    static const TCGTargetOpDef x_r = { .args_ct_str = { "x", "r" } };
 
     switch (op) {
     case INDEX_op_goto_ptr:
@@ -2505,6 +2782,53 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
             return &s2;
         }
 
+    case INDEX_op_ld_v64:
+    case INDEX_op_ld_v128:
+    case INDEX_op_ld_v256:
+    case INDEX_op_st_v64:
+    case INDEX_op_st_v128:
+    case INDEX_op_st_v256:
+        return &x_r;
+
+    case INDEX_op_add8_v64:
+    case INDEX_op_add8_v128:
+    case INDEX_op_add16_v64:
+    case INDEX_op_add16_v128:
+    case INDEX_op_add32_v64:
+    case INDEX_op_add32_v128:
+    case INDEX_op_add64_v128:
+    case INDEX_op_sub8_v64:
+    case INDEX_op_sub8_v128:
+    case INDEX_op_sub16_v64:
+    case INDEX_op_sub16_v128:
+    case INDEX_op_sub32_v64:
+    case INDEX_op_sub32_v128:
+    case INDEX_op_sub64_v128:
+    case INDEX_op_and_v64:
+    case INDEX_op_and_v128:
+    case INDEX_op_or_v64:
+    case INDEX_op_or_v128:
+    case INDEX_op_xor_v64:
+    case INDEX_op_xor_v128:
+        return have_avx1 ? &x_x_x : &x_0_x;
+    case INDEX_op_andc_v64:
+    case INDEX_op_andc_v128:
+        return have_avx1 ? &x_x_x : &x_x_0;
+
+    case INDEX_op_add8_v256:
+    case INDEX_op_add16_v256:
+    case INDEX_op_add32_v256:
+    case INDEX_op_add64_v256:
+    case INDEX_op_sub8_v256:
+    case INDEX_op_sub16_v256:
+    case INDEX_op_sub32_v256:
+    case INDEX_op_sub64_v256:
+    case INDEX_op_and_v256:
+    case INDEX_op_andc_v256:
+    case INDEX_op_or_v256:
+    case INDEX_op_xor_v256:
+        return &x_x_x;
+
     default:
         break;
     }
@@ -2589,6 +2913,9 @@ static void tcg_target_qemu_prologue(TCGContext *s)
 
     tcg_out_addi(s, TCG_REG_CALL_STACK, stack_addend);
 
+    if (have_avx2) {
+        tcg_out_vex_opc(s, OPC_VZEROUPPER, 0, 0, 0, 0);
+    }
     for (i = ARRAY_SIZE(tcg_target_callee_save_regs) - 1; i >= 0; i--) {
         tcg_out_pop(s, tcg_target_callee_save_regs[i]);
     }
@@ -2610,9 +2937,16 @@ static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
 static void tcg_target_init(TCGContext *s)
 {
 #ifdef CONFIG_CPUID_H
-    unsigned a, b, c, d;
+    unsigned a, b, c, d, b7 = 0;
     int max = __get_cpuid_max(0, 0);
 
+    if (max >= 7) {
+        /* BMI1 is available on AMD Piledriver and Intel Haswell CPUs.  */
+        __cpuid_count(7, 0, a, b7, c, d);
+        have_bmi1 = (b7 & bit_BMI) != 0;
+        have_bmi2 = (b7 & bit_BMI2) != 0;
+    }
+
     if (max >= 1) {
         __cpuid(1, a, b, c, d);
 #ifndef have_cmov
@@ -2621,17 +2955,26 @@ static void tcg_target_init(TCGContext *s)
            available, we'll use a small forward branch.  */
         have_cmov = (d & bit_CMOV) != 0;
 #endif
+#ifndef have_sse2
+        have_sse2 = (d & bit_SSE2) != 0;
+#endif
         /* MOVBE is only available on Intel Atom and Haswell CPUs, so we
            need to probe for it.  */
         have_movbe = (c & bit_MOVBE) != 0;
         have_popcnt = (c & bit_POPCNT) != 0;
-    }
 
-    if (max >= 7) {
-        /* BMI1 is available on AMD Piledriver and Intel Haswell CPUs.  */
-        __cpuid_count(7, 0, a, b, c, d);
-        have_bmi1 = (b & bit_BMI) != 0;
-        have_bmi2 = (b & bit_BMI2) != 0;
+#ifndef have_avx2
+        /* There are a number of things we must check before we can be
+           sure of not hitting invalid opcode.  */
+        if (c & bit_OSXSAVE) {
+            unsigned xcrl, xcrh;
+            asm ("xgetbv" : "=a" (xcrl), "=d" (xcrh) : "c" (0));
+            if ((xcrl & 6) == 6) {
+                have_avx1 = (c & bit_AVX) != 0;
+                have_avx2 = (b7 & bit_AVX2) != 0;
+            }
+        }
+#endif
     }
 
     max = __get_cpuid_max(0x8000000, 0);
@@ -2648,6 +2991,13 @@ static void tcg_target_init(TCGContext *s)
     } else {
         tcg_regset_set32(tcg_target_available_regs[TCG_TYPE_I32], 0, 0xff);
     }
+    if (have_sse2) {
+        tcg_regset_set32(tcg_target_available_regs[TCG_TYPE_V64], 0, 0xff0000);
+        tcg_regset_set32(tcg_target_available_regs[TCG_TYPE_V128], 0, 0xff0000);
+    }
+    if (have_avx2) {
+        tcg_regset_set32(tcg_target_available_regs[TCG_TYPE_V256], 0, 0xff0000);
+    }
 
     tcg_regset_clear(tcg_target_call_clobber_regs);
     tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_EAX);
-- 
2.13.5
