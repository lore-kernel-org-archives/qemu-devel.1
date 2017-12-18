Received: from eggs.gnu.org ([2001:4830:134:3::10]:37147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz3Y-0000RL-O3
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz3P-0000zl-RA
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:24 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:43230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQz3P-0000yE-9Y
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:15 -0500
Received: by mail-pl0-x243.google.com with SMTP id z5so5199011plo.10
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:18:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:17:40 -0800
Message-Id: <20171218171758.16964-9-richard.henderson@linaro.org>
In-Reply-To: <20171218171758.16964-1-richard.henderson@linaro.org>
References: <20171218171758.16964-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v7 08/26] tcg/i386: Add vector operations
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

The x86 vector instruction set is extremely irregular.  With newer
editions, Intel has filled in some of the blanks.  However, we don't
get many 64-bit operations until SSE4.2, introduced in 2009.

The subsequent edition was for AVX1, introduced in 2011, which added
three-operand addressing, and adjusts how all instructions should be
encoded.

Given the relatively narrow 2 year window between possible to support
and desirable to support, and to vastly simplify code maintainence,
I am only planning to support AVX1 and later cpus.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.h     |  36 ++-
 tcg/i386/tcg-target.inc.c | 561 ++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 546 insertions(+), 51 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index b89dababf4..f9d3fc4a93 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -30,10 +30,10 @@
 
 #ifdef __x86_64__
 # define TCG_TARGET_REG_BITS  64
-# define TCG_TARGET_NB_REGS   16
+# define TCG_TARGET_NB_REGS   32
 #else
 # define TCG_TARGET_REG_BITS  32
-# define TCG_TARGET_NB_REGS    8
+# define TCG_TARGET_NB_REGS   24
 #endif
 
 typedef enum {
@@ -56,6 +56,26 @@ typedef enum {
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
+
+    /* 64-bit registers; likewise always define.  */
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
@@ -77,6 +97,8 @@ typedef enum {
 
 extern bool have_bmi1;
 extern bool have_popcnt;
+extern bool have_avx1;
+extern bool have_avx2;
 
 /* optional instructions */
 #define TCG_TARGET_HAS_div2_i32         1
@@ -146,6 +168,16 @@ extern bool have_popcnt;
 #define TCG_TARGET_HAS_mulsh_i64        0
 #endif
 
+/* We do not support older SSE systems, only beginning with AVX1.  */
+#define TCG_TARGET_HAS_v64              have_avx1
+#define TCG_TARGET_HAS_v128             have_avx1
+#define TCG_TARGET_HAS_v256             have_avx2
+
+#define TCG_TARGET_HAS_andc_vec         1
+#define TCG_TARGET_HAS_orc_vec          0
+#define TCG_TARGET_HAS_not_vec          0
+#define TCG_TARGET_HAS_neg_vec          0
+
 #define TCG_TARGET_deposit_i32_valid(ofs, len) \
     (((ofs) == 0 && (len) == 8) || ((ofs) == 8 && (len) == 8) || \
      ((ofs) == 0 && (len) == 16))
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 63d27f10e7..e9a4d92598 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -28,9 +28,14 @@
 static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
 #if TCG_TARGET_REG_BITS == 64
     "%rax", "%rcx", "%rdx", "%rbx", "%rsp", "%rbp", "%rsi", "%rdi",
-    "%r8",  "%r9",  "%r10", "%r11", "%r12", "%r13", "%r14", "%r15",
 #else
     "%eax", "%ecx", "%edx", "%ebx", "%esp", "%ebp", "%esi", "%edi",
+#endif
+    "%r8",  "%r9",  "%r10", "%r11", "%r12", "%r13", "%r14", "%r15",
+    "%xmm0", "%xmm1", "%xmm2", "%xmm3", "%xmm4", "%xmm5", "%xmm6", "%xmm7",
+#if TCG_TARGET_REG_BITS == 64
+    "%xmm8", "%xmm9", "%xmm10", "%xmm11",
+    "%xmm12", "%xmm13", "%xmm14", "%xmm15",
 #endif
 };
 #endif
@@ -60,6 +65,28 @@ static const int tcg_target_reg_alloc_order[] = {
     TCG_REG_ECX,
     TCG_REG_EDX,
     TCG_REG_EAX,
+#endif
+    TCG_REG_XMM0,
+    TCG_REG_XMM1,
+    TCG_REG_XMM2,
+    TCG_REG_XMM3,
+    TCG_REG_XMM4,
+    TCG_REG_XMM5,
+#ifndef _WIN64
+    /* The Win64 ABI has xmm6-xmm15 as caller-saves, and we do not save
+       any of them.  Therefore only allow xmm0-xmm5 to be allocated.  */
+    TCG_REG_XMM6,
+    TCG_REG_XMM7,
+#if TCG_TARGET_REG_BITS == 64
+    TCG_REG_XMM8,
+    TCG_REG_XMM9,
+    TCG_REG_XMM10,
+    TCG_REG_XMM11,
+    TCG_REG_XMM12,
+    TCG_REG_XMM13,
+    TCG_REG_XMM14,
+    TCG_REG_XMM15,
+#endif
 #endif
 };
 
@@ -94,7 +121,7 @@ static const int tcg_target_call_oarg_regs[] = {
 #define TCG_CT_CONST_I32 0x400
 #define TCG_CT_CONST_WSZ 0x800
 
-/* Registers used with L constraint, which are the first argument 
+/* Registers used with L constraint, which are the first argument
    registers on x86_64, and two random call clobbered registers on
    i386. */
 #if TCG_TARGET_REG_BITS == 64
@@ -125,6 +152,8 @@ static bool have_cmov;
    it there.  Therefore we always define the variable.  */
 bool have_bmi1;
 bool have_popcnt;
+bool have_avx1;
+bool have_avx2;
 
 #ifdef CONFIG_CPUID_H
 static bool have_movbe;
@@ -148,6 +177,8 @@ static void patch_reloc(tcg_insn_unit *code_ptr, int type,
         if (value != (int32_t)value) {
             tcg_abort();
         }
+        /* FALLTHRU */
+    case R_386_32:
         tcg_patch32(code_ptr, value);
         break;
     case R_386_PC8:
@@ -162,6 +193,14 @@ static void patch_reloc(tcg_insn_unit *code_ptr, int type,
     }
 }
 
+#if TCG_TARGET_REG_BITS == 64
+#define ALL_GENERAL_REGS   0x0000ffffu
+#define ALL_VECTOR_REGS    0xffff0000u
+#else
+#define ALL_GENERAL_REGS   0x000000ffu
+#define ALL_VECTOR_REGS    0x00ff0000u
+#endif
+
 /* parse target specific constraints */
 static const char *target_parse_constraint(TCGArgConstraint *ct,
                                            const char *ct_str, TCGType type)
@@ -192,21 +231,29 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
         tcg_regset_set_reg(ct->u.regs, TCG_REG_EDI);
         break;
     case 'q':
+        /* A register that can be used as a byte operand.  */
         ct->ct |= TCG_CT_REG;
         ct->u.regs = TCG_TARGET_REG_BITS == 64 ? 0xffff : 0xf;
         break;
     case 'Q':
+        /* A register with an addressable second byte (e.g. %ah).  */
         ct->ct |= TCG_CT_REG;
         ct->u.regs = 0xf;
         break;
     case 'r':
+        /* A general register.  */
         ct->ct |= TCG_CT_REG;
-        ct->u.regs = TCG_TARGET_REG_BITS == 64 ? 0xffff : 0xff;
+        ct->u.regs |= ALL_GENERAL_REGS;
         break;
     case 'W':
         /* With TZCNT/LZCNT, we can have operand-size as an input.  */
         ct->ct |= TCG_CT_CONST_WSZ;
         break;
+    case 'x':
+        /* A vector register.  */
+        ct->ct |= TCG_CT_REG;
+        ct->u.regs |= ALL_VECTOR_REGS;
+        break;
 
         /* qemu_ld/st address constraint */
     case 'L':
@@ -277,8 +324,9 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
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
@@ -310,11 +358,38 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_MOVL_Iv     (0xb8)
 #define OPC_MOVBE_GyMy  (0xf0 | P_EXT38)
 #define OPC_MOVBE_MyGy  (0xf1 | P_EXT38)
+#define OPC_MOVD_VyEy   (0x6e | P_EXT | P_DATA16)
+#define OPC_MOVD_EyVy   (0x7e | P_EXT | P_DATA16)
+#define OPC_MOVDDUP     (0x12 | P_EXT | P_SIMDF2)
+#define OPC_MOVDQA_VxWx (0x6f | P_EXT | P_DATA16)
+#define OPC_MOVDQA_WxVx (0x7f | P_EXT | P_DATA16)
+#define OPC_MOVDQU_VxWx (0x6f | P_EXT | P_SIMDF3)
+#define OPC_MOVDQU_WxVx (0x7f | P_EXT | P_SIMDF3)
+#define OPC_MOVQ_VqWq   (0x7e | P_EXT | P_SIMDF3)
+#define OPC_MOVQ_WqVq   (0xd6 | P_EXT | P_DATA16)
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
+#define OPC_PCMPEQB     (0x74 | P_EXT | P_DATA16)
+#define OPC_POR         (0xeb | P_EXT | P_DATA16)
+#define OPC_PSHUFD      (0x70 | P_EXT | P_DATA16)
+#define OPC_PSUBB       (0xf8 | P_EXT | P_DATA16)
+#define OPC_PSUBW       (0xf9 | P_EXT | P_DATA16)
+#define OPC_PSUBD       (0xfa | P_EXT | P_DATA16)
+#define OPC_PSUBQ       (0xfb | P_EXT | P_DATA16)
+#define OPC_PUNPCKLBW   (0x60 | P_EXT | P_DATA16)
+#define OPC_PUNPCKLWD   (0x61 | P_EXT | P_DATA16)
+#define OPC_PUNPCKLDQ   (0x62 | P_EXT | P_DATA16)
+#define OPC_PUNPCKLQDQ  (0x6c | P_EXT | P_DATA16)
+#define OPC_PXOR        (0xef | P_EXT | P_DATA16)
 #define OPC_POP_r32	(0x58)
 #define OPC_POPCNT      (0xb8 | P_EXT | P_SIMDF3)
 #define OPC_PUSH_r32	(0x50)
@@ -330,6 +405,11 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_SHRX        (0xf7 | P_EXT38 | P_SIMDF2)
 #define OPC_TESTL	(0x85)
 #define OPC_TZCNT       (0xbc | P_EXT | P_SIMDF3)
+#define OPC_VPBROADCASTB (0x78 | P_EXT38 | P_DATA16)
+#define OPC_VPBROADCASTW (0x79 | P_EXT38 | P_DATA16)
+#define OPC_VPBROADCASTD (0x58 | P_EXT38 | P_DATA16)
+#define OPC_VPBROADCASTQ (0x59 | P_EXT38 | P_DATA16)
+#define OPC_VZEROUPPER  (0x77 | P_EXT)
 #define OPC_XCHG_ax_r32	(0x90)
 
 #define OPC_GRP3_Ev	(0xf7)
@@ -479,11 +559,20 @@ static void tcg_out_modrm(TCGContext *s, int opc, int r, int rm)
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
 
@@ -493,20 +582,17 @@ static void tcg_out_vex_modrm(TCGContext *s, int opc, int r, int v, int rm)
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
@@ -518,6 +604,11 @@ static void tcg_out_vex_modrm(TCGContext *s, int opc, int r, int v, int rm)
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
 
@@ -526,8 +617,8 @@ static void tcg_out_vex_modrm(TCGContext *s, int opc, int r, int v, int rm)
    mode for absolute addresses, ~RM is the size of the immediate operand
    that will follow the instruction.  */
 
-static void tcg_out_modrm_sib_offset(TCGContext *s, int opc, int r, int rm,
-                                     int index, int shift, intptr_t offset)
+static void tcg_out_sib_offset(TCGContext *s, int r, int rm, int index,
+                               int shift, intptr_t offset)
 {
     int mod, len;
 
@@ -538,7 +629,6 @@ static void tcg_out_modrm_sib_offset(TCGContext *s, int opc, int r, int rm,
             intptr_t pc = (intptr_t)s->code_ptr + 5 + ~rm;
             intptr_t disp = offset - pc;
             if (disp == (int32_t)disp) {
-                tcg_out_opc(s, opc, r, 0, 0);
                 tcg_out8(s, (LOWREGMASK(r) << 3) | 5);
                 tcg_out32(s, disp);
                 return;
@@ -548,7 +638,6 @@ static void tcg_out_modrm_sib_offset(TCGContext *s, int opc, int r, int rm,
                use of the MODRM+SIB encoding and is therefore larger than
                rip-relative addressing.  */
             if (offset == (int32_t)offset) {
-                tcg_out_opc(s, opc, r, 0, 0);
                 tcg_out8(s, (LOWREGMASK(r) << 3) | 4);
                 tcg_out8(s, (4 << 3) | 5);
                 tcg_out32(s, offset);
@@ -556,10 +645,9 @@ static void tcg_out_modrm_sib_offset(TCGContext *s, int opc, int r, int rm,
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
@@ -582,7 +670,6 @@ static void tcg_out_modrm_sib_offset(TCGContext *s, int opc, int r, int rm,
        that would be used for %esp is the escape to the two byte form.  */
     if (index < 0 && LOWREGMASK(rm) != TCG_REG_ESP) {
         /* Single byte MODRM format.  */
-        tcg_out_opc(s, opc, r, rm, 0);
         tcg_out8(s, mod | (LOWREGMASK(r) << 3) | LOWREGMASK(rm));
     } else {
         /* Two byte MODRM+SIB format.  */
@@ -596,7 +683,6 @@ static void tcg_out_modrm_sib_offset(TCGContext *s, int opc, int r, int rm,
             tcg_debug_assert(index != TCG_REG_ESP);
         }
 
-        tcg_out_opc(s, opc, r, rm, index);
         tcg_out8(s, mod | (LOWREGMASK(r) << 3) | 4);
         tcg_out8(s, (shift << 6) | (LOWREGMASK(index) << 3) | LOWREGMASK(rm));
     }
@@ -608,6 +694,21 @@ static void tcg_out_modrm_sib_offset(TCGContext *s, int opc, int r, int rm,
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
@@ -615,6 +716,30 @@ static inline void tcg_out_modrm_offset(TCGContext *s, int opc, int r,
     tcg_out_modrm_sib_offset(s, opc, r, rm, -1, 0, offset);
 }
 
+static inline void tcg_out_vex_modrm_offset(TCGContext *s, int opc, int r,
+                                            int v, int rm, intptr_t offset)
+{
+    tcg_out_vex_modrm_sib_offset(s, opc, r, v, rm, -1, 0, offset);
+}
+
+/* Output an opcode with an expected reference to the constant pool.  */
+static inline void tcg_out_modrm_pool(TCGContext *s, int opc, int r)
+{
+    tcg_out_opc(s, opc, r, 0, 0);
+    /* Absolute for 32-bit, pc-relative for 64-bit.  */
+    tcg_out8(s, LOWREGMASK(r) << 3 | 5);
+    tcg_out32(s, 0);
+}
+
+/* Output an opcode with an expected reference to the constant pool.  */
+static inline void tcg_out_vex_modrm_pool(TCGContext *s, int opc, int r)
+{
+    tcg_out_vex_opc(s, opc, r, 0, 0, 0);
+    /* Absolute for 32-bit, pc-relative for 64-bit.  */
+    tcg_out8(s, LOWREGMASK(r) << 3 | 5);
+    tcg_out32(s, 0);
+}
+
 /* Generate dest op= src.  Uses the same ARITH_* codes as tgen_arithi.  */
 static inline void tgen_arithr(TCGContext *s, int subop, int dest, int src)
 {
@@ -625,12 +750,114 @@ static inline void tgen_arithr(TCGContext *s, int subop, int dest, int src)
     tcg_out_modrm(s, OPC_ARITH_GvEv + (subop << 3) + ext, dest, src);
 }
 
-static inline void tcg_out_mov(TCGContext *s, TCGType type,
-                               TCGReg ret, TCGReg arg)
+static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
+{
+    int rexw = 0;
+
+    if (arg == ret) {
+        return;
+    }
+    switch (type) {
+    case TCG_TYPE_I64:
+        rexw = P_REXW;
+        /* fallthru */
+    case TCG_TYPE_I32:
+        if (ret < 16) {
+            if (arg < 16) {
+                tcg_out_modrm(s, OPC_MOVL_GvEv + rexw, ret, arg);
+            } else {
+                tcg_out_vex_modrm(s, OPC_MOVD_EyVy + rexw, ret, 0, arg);
+            }
+        } else {
+            if (arg < 16) {
+                tcg_out_vex_modrm(s, OPC_MOVD_VyEy + rexw, ret, 0, arg);
+            } else {
+                tcg_out_vex_modrm(s, OPC_MOVQ_VqWq, ret, 0, arg);
+            }
+        }
+        break;
+
+    case TCG_TYPE_V64:
+        tcg_debug_assert(ret >= 16 && arg >= 16);
+        tcg_out_vex_modrm(s, OPC_MOVQ_VqWq, ret, 0, arg);
+        break;
+    case TCG_TYPE_V128:
+        tcg_debug_assert(ret >= 16 && arg >= 16);
+        tcg_out_vex_modrm(s, OPC_MOVDQA_VxWx, ret, 0, arg);
+        break;
+    case TCG_TYPE_V256:
+        tcg_debug_assert(ret >= 16 && arg >= 16);
+        tcg_out_vex_modrm(s, OPC_MOVDQA_VxWx | P_VEXL, ret, 0, arg);
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
+                            TCGReg r, TCGReg a)
 {
-    if (arg != ret) {
-        int opc = OPC_MOVL_GvEv + (type == TCG_TYPE_I64 ? P_REXW : 0);
-        tcg_out_modrm(s, opc, ret, arg);
+    if (have_avx2) {
+        static const int dup_insn[4] = {
+            OPC_VPBROADCASTB, OPC_VPBROADCASTW,
+            OPC_VPBROADCASTD, OPC_VPBROADCASTQ,
+        };
+        int vex_l = (type == TCG_TYPE_V256 ? P_VEXL : 0);
+        tcg_out_vex_modrm(s, dup_insn[vece] + vex_l, r, 0, a);
+    } else {
+        switch (vece) {
+        case MO_8:
+            /* ??? With zero in a register, use PSHUFB.  */
+            tcg_out_vex_modrm(s, OPC_PUNPCKLBW, r, 0, a);
+            a = r;
+            /* FALLTHRU */
+        case MO_16:
+            tcg_out_vex_modrm(s, OPC_PUNPCKLWD, r, 0, a);
+            a = r;
+            /* FALLTHRU */
+        case MO_32:
+            tcg_out_vex_modrm(s, OPC_PSHUFD, r, 0, a);
+            /* imm8 operand: all output lanes selected from input lane 0.  */
+            tcg_out8(s, 0);
+            break;
+        case MO_64:
+            tcg_out_vex_modrm(s, OPC_PUNPCKLQDQ, r, 0, a);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+}
+
+static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
+                             TCGReg ret, tcg_target_long arg)
+{
+    int vex_l = (type == TCG_TYPE_V256 ? P_VEXL : 0);
+
+    if (arg == 0) {
+        tcg_out_vex_modrm(s, OPC_PXOR, ret, ret, ret);
+        return;
+    }
+    if (arg == -1) {
+        tcg_out_vex_modrm(s, OPC_PCMPEQB + vex_l, ret, ret, ret);
+        return;
+    }
+
+    if (TCG_TARGET_REG_BITS == 64) {
+        if (have_avx2) {
+            tcg_out_vex_modrm_pool(s, OPC_VPBROADCASTQ + vex_l, ret);
+        } else {
+            tcg_out_vex_modrm_pool(s, OPC_MOVDDUP, ret);
+        }
+        new_pool_label(s, arg, R_386_PC32, s->code_ptr - 4, -4);
+    } else if (have_avx2) {
+        tcg_out_vex_modrm_pool(s, OPC_VPBROADCASTD + vex_l, ret);
+        new_pool_label(s, arg, R_386_32, s->code_ptr - 4, 0);
+    } else {
+        tcg_out_vex_modrm_pool(s, OPC_MOVD_VyEy, ret);
+        new_pool_label(s, arg, R_386_32, s->code_ptr - 4, 0);
+        tcg_out_dup_vec(s, type, MO_32, ret, ret);
     }
 }
 
@@ -639,6 +866,25 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
 {
     tcg_target_long diff;
 
+    switch (type) {
+    case TCG_TYPE_I32:
+#if TCG_TARGET_REG_BITS == 64
+    case TCG_TYPE_I64:
+#endif
+        if (ret < 16) {
+            break;
+        }
+        /* fallthru */
+    case TCG_TYPE_V64:
+    case TCG_TYPE_V128:
+    case TCG_TYPE_V256:
+        tcg_debug_assert(ret >= 16);
+        tcg_out_dupi_vec(s, type, ret, arg);
+        return;
+    default:
+        g_assert_not_reached();
+    }
+
     if (arg == 0) {
         tgen_arithr(s, ARITH_XOR, ret, ret);
         return;
@@ -667,6 +913,59 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
     tcg_out64(s, arg);
 }
 
+static void tcg_out_movi_vec(TCGContext *s, TCGType type,
+                             TCGReg ret, const TCGArg *a)
+{
+    int n = (64 / TCG_TARGET_REG_BITS) << (type - TCG_TYPE_V64);
+    int opc, ofs, rel;
+
+    tcg_debug_assert(ret >= 16);
+    tcg_debug_assert(type >= TCG_TYPE_V64);
+
+    /* We assume that INDEX_op_dupi could not be used and therefore
+       we must use a constant pool entry.  */
+
+    switch (type) {
+    case TCG_TYPE_V64:
+        opc = OPC_MOVQ_VqWq;
+        break;
+    case TCG_TYPE_V128:
+        opc = OPC_MOVDQU_VxWx;
+        break;
+    case TCG_TYPE_V256:
+        opc = OPC_MOVDQU_VxWx | P_VEXL;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    tcg_out_vex_modrm_pool(s, opc, ret);
+
+    if (TCG_TARGET_REG_BITS == 64) {
+        rel = R_386_PC32, ofs = -4;
+    } else {
+        rel = R_386_32, ofs = 0;
+    }
+    switch (n) {
+    case 1:
+        new_pool_label(s, a[0], rel, s->code_ptr - 4, rel);
+        break;
+    case 2:
+        new_pool_l2(s, rel, s->code_ptr - 4, ofs, a[0], a[1]);
+        break;
+    case 4:
+        new_pool_l4(s, rel, s->code_ptr - 4, ofs, a[0], a[1], a[2], a[3]);
+        break;
+#if TCG_TARGET_REG_BITS == 32
+    case 8:
+        new_pool_l8(s, rel, s->code_ptr - 4, ofs,
+                    a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7]);
+        break;
+#endif
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static inline void tcg_out_pushi(TCGContext *s, tcg_target_long val)
 {
     if (val == (int8_t)val) {
@@ -702,18 +1001,74 @@ static inline void tcg_out_pop(TCGContext *s, int reg)
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
+    case TCG_TYPE_I32:
+        if (ret < 16) {
+            tcg_out_modrm_offset(s, OPC_MOVL_GvEv, ret, arg1, arg2);
+        } else {
+            tcg_out_vex_modrm_offset(s, OPC_MOVD_VyEy, ret, 0, arg1, arg2);
+        }
+        break;
+    case TCG_TYPE_I64:
+        if (ret < 16) {
+            tcg_out_modrm_offset(s, OPC_MOVL_GvEv | P_REXW, ret, arg1, arg2);
+            break;
+        }
+        /* FALLTHRU */
+    case TCG_TYPE_V64:
+        tcg_debug_assert(ret >= 16);
+        tcg_out_vex_modrm_offset(s, OPC_MOVQ_VqWq, ret, 0, arg1, arg2);
+        break;
+    case TCG_TYPE_V128:
+        tcg_debug_assert(ret >= 16);
+        tcg_out_vex_modrm_offset(s, OPC_MOVDQU_VxWx, ret, 0, arg1, arg2);
+        break;
+    case TCG_TYPE_V256:
+        tcg_debug_assert(ret >= 16);
+        tcg_out_vex_modrm_offset(s, OPC_MOVDQU_VxWx | P_VEXL,
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
+    case TCG_TYPE_I32:
+        if (arg < 16) {
+            tcg_out_modrm_offset(s, OPC_MOVL_EvGv, arg, arg1, arg2);
+        } else {
+            tcg_out_vex_modrm_offset(s, OPC_MOVD_EyVy, arg, 0, arg1, arg2);
+        }
+        break;
+    case TCG_TYPE_I64:
+        if (arg < 16) {
+            tcg_out_modrm_offset(s, OPC_MOVL_EvGv | P_REXW, arg, arg1, arg2);
+            break;
+        }
+        /* FALLTHRU */
+    case TCG_TYPE_V64:
+        tcg_debug_assert(arg >= 16);
+        tcg_out_vex_modrm_offset(s, OPC_MOVQ_WqVq, arg, 0, arg1, arg2);
+        break;
+    case TCG_TYPE_V128:
+        tcg_debug_assert(arg >= 16);
+        tcg_out_vex_modrm_offset(s, OPC_MOVDQU_WxVx, arg, 0, arg1, arg2);
+        break;
+    case TCG_TYPE_V256:
+        tcg_debug_assert(arg >= 16);
+        tcg_out_vex_modrm_offset(s, OPC_MOVDQU_WxVx | P_VEXL,
+                                 arg, 0, arg1, arg2);
+        break;
+    default:
+        g_assert_not_reached();
+    }
 }
 
 static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
@@ -725,6 +1080,8 @@ static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
             return false;
         }
         rexw = P_REXW;
+    } else if (type != TCG_TYPE_I32) {
+        return false;
     }
     tcg_out_modrm_offset(s, OPC_MOVL_EvIz | rexw, 0, base, ofs);
     tcg_out32(s, val);
@@ -2259,8 +2616,10 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_mov_i64:
+    case INDEX_op_mov_vec:
     case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
     case INDEX_op_movi_i64:
+    case INDEX_op_dupi_vec:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     default:
         tcg_abort();
@@ -2269,6 +2628,73 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
 #undef OP_32_64
 }
 
+static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
+                           unsigned vecl, unsigned vece,
+                           const TCGArg *args, const int *const_args)
+{
+    static int const add_insn[4] = {
+        OPC_PADDB, OPC_PADDW, OPC_PADDD, OPC_PADDQ
+    };
+    static int const sub_insn[4] = {
+        OPC_PSUBB, OPC_PSUBW, OPC_PSUBD, OPC_PSUBQ
+    };
+
+    TCGType type = vecl + TCG_TYPE_V64;
+    int insn;
+    TCGArg a0, a1, a2;
+
+    a0 = args[0];
+    a1 = args[1];
+    a2 = args[2];
+
+    switch (opc) {
+    case INDEX_op_add_vec:
+        insn = add_insn[vece];
+        goto gen_simd;
+    case INDEX_op_sub_vec:
+        insn = sub_insn[vece];
+        goto gen_simd;
+    case INDEX_op_and_vec:
+        insn = OPC_PAND;
+        goto gen_simd;
+    case INDEX_op_or_vec:
+        insn = OPC_POR;
+        goto gen_simd;
+    case INDEX_op_xor_vec:
+        insn = OPC_PXOR;
+    gen_simd:
+        if (type == TCG_TYPE_V256) {
+            insn |= P_VEXL;
+        }
+        tcg_out_vex_modrm(s, insn, a0, a1, a2);
+        break;
+
+    case INDEX_op_andc_vec:
+        insn = OPC_PANDN;
+        if (type == TCG_TYPE_V256) {
+            insn |= P_VEXL;
+        }
+        tcg_out_vex_modrm(s, insn, a0, a2, a1);
+        break;
+
+    case INDEX_op_ld_vec:
+        tcg_out_ld(s, type, a0, a1, a2);
+        break;
+    case INDEX_op_st_vec:
+        tcg_out_st(s, type, a0, a1, a2);
+        break;
+    case INDEX_op_movi_vec:
+        tcg_out_movi_vec(s, type, a0, args + 1);
+        break;
+    case INDEX_op_dup_vec:
+        tcg_out_dup_vec(s, type, vece, a0, a1);
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
 {
     static const TCGTargetOpDef r = { .args_ct_str = { "r" } };
@@ -2292,6 +2718,9 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         = { .args_ct_str = { "r", "r", "L", "L" } };
     static const TCGTargetOpDef L_L_L_L
         = { .args_ct_str = { "L", "L", "L", "L" } };
+    static const TCGTargetOpDef x_x = { .args_ct_str = { "x", "x" } };
+    static const TCGTargetOpDef x_x_x = { .args_ct_str = { "x", "x", "x" } };
+    static const TCGTargetOpDef x_r = { .args_ct_str = { "x", "r" } };
 
     switch (op) {
     case INDEX_op_goto_ptr:
@@ -2493,6 +2922,20 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
             return &s2;
         }
 
+    case INDEX_op_ld_vec:
+    case INDEX_op_st_vec:
+        return &x_r;
+
+    case INDEX_op_add_vec:
+    case INDEX_op_sub_vec:
+    case INDEX_op_and_vec:
+    case INDEX_op_or_vec:
+    case INDEX_op_xor_vec:
+    case INDEX_op_andc_vec:
+        return &x_x_x;
+    case INDEX_op_dup_vec:
+        return &x_x;
+
     default:
         break;
     }
@@ -2577,6 +3020,9 @@ static void tcg_target_qemu_prologue(TCGContext *s)
 
     tcg_out_addi(s, TCG_REG_CALL_STACK, stack_addend);
 
+    if (have_avx2) {
+        tcg_out_vex_opc(s, OPC_VZEROUPPER, 0, 0, 0, 0);
+    }
     for (i = ARRAY_SIZE(tcg_target_callee_save_regs) - 1; i >= 0; i--) {
         tcg_out_pop(s, tcg_target_callee_save_regs[i]);
     }
@@ -2598,9 +3044,16 @@ static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
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
@@ -2609,17 +3062,22 @@ static void tcg_target_init(TCGContext *s)
            available, we'll use a small forward branch.  */
         have_cmov = (d & bit_CMOV) != 0;
 #endif
+
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
     }
 
     max = __get_cpuid_max(0x8000000, 0);
@@ -2630,11 +3088,16 @@ static void tcg_target_init(TCGContext *s)
     }
 #endif /* CONFIG_CPUID_H */
 
+    tcg_target_available_regs[TCG_TYPE_I32] = ALL_GENERAL_REGS;
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_target_available_regs[TCG_TYPE_I32] = 0xffff;
-        tcg_target_available_regs[TCG_TYPE_I64] = 0xffff;
-    } else {
-        tcg_target_available_regs[TCG_TYPE_I32] = 0xff;
+        tcg_target_available_regs[TCG_TYPE_I64] = ALL_GENERAL_REGS;
+    }
+    if (have_avx1) {
+        tcg_target_available_regs[TCG_TYPE_V64] = ALL_VECTOR_REGS;
+        tcg_target_available_regs[TCG_TYPE_V128] = ALL_VECTOR_REGS;
+    }
+    if (have_avx2) {
+        tcg_target_available_regs[TCG_TYPE_V256] = ALL_VECTOR_REGS;
     }
 
     tcg_target_call_clobber_regs = 0;
-- 
2.14.3
