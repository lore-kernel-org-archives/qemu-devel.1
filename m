Received: from eggs.gnu.org ([2001:4830:134:3::10]:48517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eXewK-0007sJ-TG
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:14:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eXewF-0005u4-20
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:14:32 -0500
Received: from mail-pg0-x22e.google.com ([2607:f8b0:400e:c05::22e]:35108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eXewE-0005re-JC
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:14:26 -0500
Received: by mail-pg0-x22e.google.com with SMTP id d6so1651660pgv.2
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 19:14:26 -0800 (PST)
Received: from cloudburst.twiddle.net (97-113-183-164.tukw.qwest.net.
	[97.113.183.164]) by smtp.gmail.com with ESMTPSA id
	g10sm17740595pfe.77.2018.01.05.19.14.22 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 05 Jan 2018 19:14:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  5 Jan 2018 19:13:45 -0800
Message-Id: <20180106031346.6650-23-richard.henderson@linaro.org>
In-Reply-To: <20180106031346.6650-1-richard.henderson@linaro.org>
References: <20180106031346.6650-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v8 22/23] tcg/i386: Add vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
 tcg/i386/tcg-target.h     |   46 +-
 tcg/i386/tcg-target.opc.h |   13 +
 tcg/i386/tcg-target.inc.c | 1331 +++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 1336 insertions(+), 54 deletions(-)
 create mode 100644 tcg/i386/tcg-target.opc.h

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index b89dababf4..e77b95cc2c 100644
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
@@ -146,6 +168,26 @@ extern bool have_popcnt;
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
+#define TCG_TARGET_HAS_shi_vec          1
+#define TCG_TARGET_HAS_shs_vec          0
+#define TCG_TARGET_HAS_shv_vec          0
+#define TCG_TARGET_HAS_zip_vec          1
+#define TCG_TARGET_HAS_uzp_vec          0
+#define TCG_TARGET_HAS_trn_vec          0
+#define TCG_TARGET_HAS_cmp_vec          1
+#define TCG_TARGET_HAS_mul_vec          1
+#define TCG_TARGET_HAS_extl_vec         1
+#define TCG_TARGET_HAS_exth_vec         0
+
 #define TCG_TARGET_deposit_i32_valid(ofs, len) \
     (((ofs) == 0 && (len) == 8) || ((ofs) == 8 && (len) == 8) || \
      ((ofs) == 0 && (len) == 16))
diff --git a/tcg/i386/tcg-target.opc.h b/tcg/i386/tcg-target.opc.h
new file mode 100644
index 0000000000..e5fa88ba25
--- /dev/null
+++ b/tcg/i386/tcg-target.opc.h
@@ -0,0 +1,13 @@
+/* Target-specific opcodes for host vector expansion.  These will be
+   emitted by tcg_expand_vec_op.  For those familiar with GCC internals,
+   consider these to be UNSPEC with names.  */
+
+DEF(x86_shufps_vec, 1, 2, 1, IMPLVEC)
+DEF(x86_vpblendvb_vec, 1, 3, 0, IMPLVEC)
+DEF(x86_blend_vec, 1, 2, 1, IMPLVEC)
+DEF(x86_packss_vec, 1, 2, 0, IMPLVEC)
+DEF(x86_packus_vec, 1, 2, 0, IMPLVEC)
+DEF(x86_psrldq_vec, 1, 1, 1, IMPLVEC)
+DEF(x86_vperm2i128_vec, 1, 2, 1, IMPLVEC)
+DEF(x86_punpckl_vec, 1, 2, 0, IMPLVEC)
+DEF(x86_punpckh_vec, 1, 2, 0, IMPLVEC)
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 63d27f10e7..4805da6130 100644
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
@@ -277,14 +324,17 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 # define P_REXB_RM	0
 # define P_GS           0
 #endif
-#define P_SIMDF3        0x10000         /* 0xf3 opcode prefix */
-#define P_SIMDF2        0x20000         /* 0xf2 opcode prefix */
+#define P_EXT3A         0x10000         /* 0x0f 0x3a opcode prefix */
+#define P_SIMDF3        0x20000         /* 0xf3 opcode prefix */
+#define P_SIMDF2        0x40000         /* 0xf2 opcode prefix */
+#define P_VEXL          0x80000         /* Set VEX.L = 1 */
 
 #define OPC_ARITH_EvIz	(0x81)
 #define OPC_ARITH_EvIb	(0x83)
 #define OPC_ARITH_GvEv	(0x03)		/* ... plus (ARITH_FOO << 3) */
 #define OPC_ANDN        (0xf2 | P_EXT38)
 #define OPC_ADD_GvEv	(OPC_ARITH_GvEv | (ARITH_ADD << 3))
+#define OPC_BLENDPS     (0x0c | P_EXT3A | P_DATA16)
 #define OPC_BSF         (0xbc | P_EXT)
 #define OPC_BSR         (0xbd | P_EXT)
 #define OPC_BSWAP	(0xc8 | P_EXT)
@@ -310,11 +360,68 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
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
+#define OPC_PACKSSDW    (0x6b | P_EXT | P_DATA16)
+#define OPC_PACKSSWB    (0x63 | P_EXT | P_DATA16)
+#define OPC_PACKUSDW    (0x2b | P_EXT38 | P_DATA16)
+#define OPC_PACKUSWB    (0x67 | P_EXT | P_DATA16)
+#define OPC_PADDB       (0xfc | P_EXT | P_DATA16)
+#define OPC_PADDW       (0xfd | P_EXT | P_DATA16)
+#define OPC_PADDD       (0xfe | P_EXT | P_DATA16)
+#define OPC_PADDQ       (0xd4 | P_EXT | P_DATA16)
+#define OPC_PAND        (0xdb | P_EXT | P_DATA16)
+#define OPC_PANDN       (0xdf | P_EXT | P_DATA16)
+#define OPC_PBLENDW     (0x0e | P_EXT3A | P_DATA16)
+#define OPC_PCMPEQB     (0x74 | P_EXT | P_DATA16)
+#define OPC_PCMPEQW     (0x75 | P_EXT | P_DATA16)
+#define OPC_PCMPEQD     (0x76 | P_EXT | P_DATA16)
+#define OPC_PCMPEQQ     (0x29 | P_EXT38 | P_DATA16)
+#define OPC_PCMPGTB     (0x64 | P_EXT | P_DATA16)
+#define OPC_PCMPGTW     (0x65 | P_EXT | P_DATA16)
+#define OPC_PCMPGTD     (0x66 | P_EXT | P_DATA16)
+#define OPC_PCMPGTQ     (0x37 | P_EXT38 | P_DATA16)
+#define OPC_PMOVSXBW    (0x20 | P_EXT38 | P_DATA16)
+#define OPC_PMOVSXWD    (0x23 | P_EXT38 | P_DATA16)
+#define OPC_PMOVSXDQ    (0x25 | P_EXT38 | P_DATA16)
+#define OPC_PMOVZXBW    (0x30 | P_EXT38 | P_DATA16)
+#define OPC_PMOVZXWD    (0x33 | P_EXT38 | P_DATA16)
+#define OPC_PMOVZXDQ    (0x35 | P_EXT38 | P_DATA16)
+#define OPC_PMULLW      (0xd5 | P_EXT | P_DATA16)
+#define OPC_PMULLD      (0x40 | P_EXT38 | P_DATA16)
+#define OPC_POR         (0xeb | P_EXT | P_DATA16)
+#define OPC_PSHUFB      (0x00 | P_EXT38 | P_DATA16)
+#define OPC_PSHUFD      (0x70 | P_EXT | P_DATA16)
+#define OPC_PSHUFLW     (0x70 | P_EXT | P_SIMDF2)
+#define OPC_PSHUFHW     (0x70 | P_EXT | P_SIMDF3)
+#define OPC_PSHIFTW_Ib  (0x71 | P_EXT | P_DATA16) /* /2 /6 /4 */
+#define OPC_PSHIFTD_Ib  (0x72 | P_EXT | P_DATA16) /* /2 /6 /4 */
+#define OPC_PSHIFTQ_Ib  (0x73 | P_EXT | P_DATA16) /* /2 /6 /4 */
+#define OPC_PSUBB       (0xf8 | P_EXT | P_DATA16)
+#define OPC_PSUBW       (0xf9 | P_EXT | P_DATA16)
+#define OPC_PSUBD       (0xfa | P_EXT | P_DATA16)
+#define OPC_PSUBQ       (0xfb | P_EXT | P_DATA16)
+#define OPC_PUNPCKLBW   (0x60 | P_EXT | P_DATA16)
+#define OPC_PUNPCKLWD   (0x61 | P_EXT | P_DATA16)
+#define OPC_PUNPCKLDQ   (0x62 | P_EXT | P_DATA16)
+#define OPC_PUNPCKLQDQ  (0x6c | P_EXT | P_DATA16)
+#define OPC_PUNPCKHBW   (0x68 | P_EXT | P_DATA16)
+#define OPC_PUNPCKHWD   (0x69 | P_EXT | P_DATA16)
+#define OPC_PUNPCKHDQ   (0x6a | P_EXT | P_DATA16)
+#define OPC_PUNPCKHQDQ  (0x6d | P_EXT | P_DATA16)
+#define OPC_PXOR        (0xef | P_EXT | P_DATA16)
 #define OPC_POP_r32	(0x58)
 #define OPC_POPCNT      (0xb8 | P_EXT | P_SIMDF3)
 #define OPC_PUSH_r32	(0x50)
@@ -326,14 +433,26 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_SHIFT_Ib	(0xc1)
 #define OPC_SHIFT_cl	(0xd3)
 #define OPC_SARX        (0xf7 | P_EXT38 | P_SIMDF3)
+#define OPC_SHUFPS      (0xc6 | P_EXT)
 #define OPC_SHLX        (0xf7 | P_EXT38 | P_DATA16)
 #define OPC_SHRX        (0xf7 | P_EXT38 | P_SIMDF2)
 #define OPC_TESTL	(0x85)
 #define OPC_TZCNT       (0xbc | P_EXT | P_SIMDF3)
+#define OPC_UD2         (0x0b | P_EXT)
+#define OPC_VPBLENDD    (0x02 | P_EXT3A | P_DATA16)
+#define OPC_VPBLENDVB   (0x4c | P_EXT3A | P_DATA16)
+#define OPC_VPBROADCASTB (0x78 | P_EXT38 | P_DATA16)
+#define OPC_VPBROADCASTW (0x79 | P_EXT38 | P_DATA16)
+#define OPC_VPBROADCASTD (0x58 | P_EXT38 | P_DATA16)
+#define OPC_VPBROADCASTQ (0x59 | P_EXT38 | P_DATA16)
+#define OPC_VPERMQ      (0x00 | P_EXT3A | P_DATA16 | P_REXW)
+#define OPC_VPERM2I128  (0x46 | P_EXT3A | P_DATA16 | P_VEXL)
+#define OPC_VZEROUPPER  (0x77 | P_EXT)
 #define OPC_XCHG_ax_r32	(0x90)
 
 #define OPC_GRP3_Ev	(0xf7)
 #define OPC_GRP5	(0xff)
+#define OPC_GRP14       (0x73 | P_EXT | P_DATA16)
 
 /* Group 1 opcode extensions for 0x80-0x83.
    These are also used as modifiers for OPC_ARITH.  */
@@ -439,10 +558,12 @@ static void tcg_out_opc(TCGContext *s, int opc, int r, int rm, int x)
         tcg_out8(s, (uint8_t)(rex | 0x40));
     }
 
-    if (opc & (P_EXT | P_EXT38)) {
+    if (opc & (P_EXT | P_EXT38 | P_EXT3A)) {
         tcg_out8(s, 0x0f);
         if (opc & P_EXT38) {
             tcg_out8(s, 0x38);
+        } else if (opc & P_EXT3A) {
+            tcg_out8(s, 0x3a);
         }
     }
 
@@ -459,10 +580,12 @@ static void tcg_out_opc(TCGContext *s, int opc)
     } else if (opc & P_SIMDF2) {
         tcg_out8(s, 0xf2);
     }
-    if (opc & (P_EXT | P_EXT38)) {
+    if (opc & (P_EXT | P_EXT38 | P_EXT3A)) {
         tcg_out8(s, 0x0f);
         if (opc & P_EXT38) {
             tcg_out8(s, 0x38);
+        } else if (opc & P_EXT3A) {
+            tcg_out8(s, 0x3a);
         }
     }
     tcg_out8(s, opc);
@@ -479,34 +602,42 @@ static void tcg_out_modrm(TCGContext *s, int opc, int r, int rm)
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
+    if ((opc & (P_EXT | P_EXT38 | P_EXT3A | P_REXW)) == P_EXT
+        && ((rm | index) & 8) == 0) {
+        /* Two byte VEX prefix.  */
+        tcg_out8(s, 0xc5);
+
+        tmp = (r & 8 ? 0 : 0x80);              /* VEX.R */
+    } else {
         /* Three byte VEX prefix.  */
         tcg_out8(s, 0xc4);
 
         /* VEX.m-mmmm */
-        if (opc & P_EXT38) {
+        if (opc & P_EXT3A) {
+            tmp = 3;
+        } else if (opc & P_EXT38) {
             tmp = 2;
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
@@ -518,6 +649,11 @@ static void tcg_out_vex_modrm(TCGContext *s, int opc, int r, int v, int rm)
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
 
@@ -526,8 +662,8 @@ static void tcg_out_vex_modrm(TCGContext *s, int opc, int r, int v, int rm)
    mode for absolute addresses, ~RM is the size of the immediate operand
    that will follow the instruction.  */
 
-static void tcg_out_modrm_sib_offset(TCGContext *s, int opc, int r, int rm,
-                                     int index, int shift, intptr_t offset)
+static void tcg_out_sib_offset(TCGContext *s, int r, int rm, int index,
+                               int shift, intptr_t offset)
 {
     int mod, len;
 
@@ -538,7 +674,6 @@ static void tcg_out_modrm_sib_offset(TCGContext *s, int opc, int r, int rm,
             intptr_t pc = (intptr_t)s->code_ptr + 5 + ~rm;
             intptr_t disp = offset - pc;
             if (disp == (int32_t)disp) {
-                tcg_out_opc(s, opc, r, 0, 0);
                 tcg_out8(s, (LOWREGMASK(r) << 3) | 5);
                 tcg_out32(s, disp);
                 return;
@@ -548,7 +683,6 @@ static void tcg_out_modrm_sib_offset(TCGContext *s, int opc, int r, int rm,
                use of the MODRM+SIB encoding and is therefore larger than
                rip-relative addressing.  */
             if (offset == (int32_t)offset) {
-                tcg_out_opc(s, opc, r, 0, 0);
                 tcg_out8(s, (LOWREGMASK(r) << 3) | 4);
                 tcg_out8(s, (4 << 3) | 5);
                 tcg_out32(s, offset);
@@ -556,10 +690,9 @@ static void tcg_out_modrm_sib_offset(TCGContext *s, int opc, int r, int rm,
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
@@ -582,7 +715,6 @@ static void tcg_out_modrm_sib_offset(TCGContext *s, int opc, int r, int rm,
        that would be used for %esp is the escape to the two byte form.  */
     if (index < 0 && LOWREGMASK(rm) != TCG_REG_ESP) {
         /* Single byte MODRM format.  */
-        tcg_out_opc(s, opc, r, rm, 0);
         tcg_out8(s, mod | (LOWREGMASK(r) << 3) | LOWREGMASK(rm));
     } else {
         /* Two byte MODRM+SIB format.  */
@@ -596,7 +728,6 @@ static void tcg_out_modrm_sib_offset(TCGContext *s, int opc, int r, int rm,
             tcg_debug_assert(index != TCG_REG_ESP);
         }
 
-        tcg_out_opc(s, opc, r, rm, index);
         tcg_out8(s, mod | (LOWREGMASK(r) << 3) | 4);
         tcg_out8(s, (shift << 6) | (LOWREGMASK(index) << 3) | LOWREGMASK(rm));
     }
@@ -608,6 +739,21 @@ static void tcg_out_modrm_sib_offset(TCGContext *s, int opc, int r, int rm,
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
@@ -615,6 +761,30 @@ static inline void tcg_out_modrm_offset(TCGContext *s, int opc, int r,
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
@@ -625,12 +795,116 @@ static inline void tgen_arithr(TCGContext *s, int subop, int dest, int src)
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
+                tcg_out_vex_modrm(s, OPC_MOVD_EyVy + rexw, arg, 0, ret);
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
+{
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
 {
-    if (arg != ret) {
-        int opc = OPC_MOVL_GvEv + (type == TCG_TYPE_I64 ? P_REXW : 0);
-        tcg_out_modrm(s, opc, ret, arg);
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
+        if (type == TCG_TYPE_V64) {
+            tcg_out_vex_modrm_pool(s, OPC_MOVQ_VqWq, ret);
+        } else if (have_avx2) {
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
 
@@ -639,6 +913,25 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
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
@@ -667,6 +960,59 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
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
@@ -702,18 +1048,74 @@ static inline void tcg_out_pop(TCGContext *s, int reg)
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
@@ -725,6 +1127,8 @@ static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
             return false;
         }
         rexw = P_REXW;
+    } else if (type != TCG_TYPE_I32) {
+        return false;
     }
     tcg_out_modrm_offset(s, OPC_MOVL_EvIz | rexw, 0, base, ofs);
     tcg_out32(s, val);
@@ -2259,8 +2663,10 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
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
@@ -2269,6 +2675,206 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
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
+    static int const mul_insn[4] = {
+        OPC_UD2, OPC_PMULLW, OPC_PMULLD, OPC_UD2
+    };
+    static int const shift_imm_insn[4] = {
+        OPC_UD2, OPC_PSHIFTW_Ib, OPC_PSHIFTD_Ib, OPC_PSHIFTQ_Ib
+    };
+    static int const cmpeq_insn[4] = {
+        OPC_PCMPEQB, OPC_PCMPEQW, OPC_PCMPEQD, OPC_PCMPEQQ
+    };
+    static int const cmpgt_insn[4] = {
+        OPC_PCMPGTB, OPC_PCMPGTW, OPC_PCMPGTD, OPC_PCMPGTQ
+    };
+    static int const punpckl_insn[4] = {
+        OPC_PUNPCKLBW, OPC_PUNPCKLWD, OPC_PUNPCKLDQ, OPC_PUNPCKLQDQ
+    };
+    static int const punpckh_insn[4] = {
+        OPC_PUNPCKHBW, OPC_PUNPCKHWD, OPC_PUNPCKHDQ, OPC_PUNPCKHQDQ
+    };
+    static int const packss_insn[4] = {
+        OPC_PACKSSWB, OPC_PACKSSDW, OPC_UD2, OPC_UD2
+    };
+    static int const packus_insn[4] = {
+        OPC_PACKUSWB, OPC_PACKUSDW, OPC_UD2, OPC_UD2
+    };
+    static int const pmovsx_insn[3] = {
+        OPC_PMOVSXBW, OPC_PMOVSXWD, OPC_PMOVSXDQ
+    };
+    static int const pmovzx_insn[3] = {
+        OPC_PMOVZXBW, OPC_PMOVZXWD, OPC_PMOVZXDQ
+    };
+
+    TCGType type = vecl + TCG_TYPE_V64;
+    int insn, sub;
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
+    case INDEX_op_mul_vec:
+        insn = mul_insn[vece];
+        goto gen_simd;
+    case INDEX_op_and_vec:
+        insn = OPC_PAND;
+        goto gen_simd;
+    case INDEX_op_or_vec:
+        insn = OPC_POR;
+        goto gen_simd;
+    case INDEX_op_xor_vec:
+        insn = OPC_PXOR;
+        goto gen_simd;
+    case INDEX_op_zipl_vec:
+    case INDEX_op_x86_punpckl_vec:
+        insn = punpckl_insn[vece];
+        goto gen_simd;
+    case INDEX_op_ziph_vec:
+    case INDEX_op_x86_punpckh_vec:
+        insn = punpckh_insn[vece];
+        goto gen_simd;
+    case INDEX_op_x86_packss_vec:
+        insn = packss_insn[vece];
+        goto gen_simd;
+    case INDEX_op_x86_packus_vec:
+        insn = packus_insn[vece];
+        goto gen_simd;
+    gen_simd:
+        tcg_debug_assert(insn != OPC_UD2);
+        if (type == TCG_TYPE_V256) {
+            insn |= P_VEXL;
+        }
+        tcg_out_vex_modrm(s, insn, a0, a1, a2);
+        break;
+
+    case INDEX_op_extsl_vec:
+        insn = pmovsx_insn[vece];
+        goto gen_simd2;
+    case INDEX_op_extul_vec:
+        insn = pmovzx_insn[vece];
+        goto gen_simd2;
+    gen_simd2:
+        tcg_debug_assert(vece < MO_64);
+        if (type == TCG_TYPE_V256) {
+            insn |= P_VEXL;
+        }
+        tcg_out_vex_modrm(s, insn, a0, 0, a1);
+        break;
+
+    case INDEX_op_cmp_vec:
+        sub = args[3];
+        if (sub == TCG_COND_EQ) {
+            insn = cmpeq_insn[vece];
+        } else if (sub == TCG_COND_GT) {
+            insn = cmpgt_insn[vece];
+        } else {
+            g_assert_not_reached();
+        }
+        goto gen_simd;
+
+    case INDEX_op_andc_vec:
+        insn = OPC_PANDN;
+        if (type == TCG_TYPE_V256) {
+            insn |= P_VEXL;
+        }
+        tcg_out_vex_modrm(s, insn, a0, a2, a1);
+        break;
+
+    case INDEX_op_shli_vec:
+        sub = 6;
+        goto gen_shift;
+    case INDEX_op_shri_vec:
+        sub = 2;
+        goto gen_shift;
+    case INDEX_op_sari_vec:
+        tcg_debug_assert(vece != MO_64);
+        sub = 4;
+    gen_shift:
+        tcg_debug_assert(vece != MO_8);
+        insn = shift_imm_insn[vece];
+        if (type == TCG_TYPE_V256) {
+            insn |= P_VEXL;
+        }
+        tcg_out_vex_modrm(s, insn, sub, a0, a1);
+        tcg_out8(s, a2);
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
+    case INDEX_op_x86_shufps_vec:
+        insn = OPC_SHUFPS;
+        sub = args[3];
+        goto gen_simd_imm8;
+    case INDEX_op_x86_blend_vec:
+        if (vece == MO_16) {
+            insn = OPC_PBLENDW;
+        } else if (vece == MO_32) {
+            insn = (have_avx2 ? OPC_VPBLENDD : OPC_BLENDPS);
+        } else {
+            g_assert_not_reached();
+        }
+        sub = args[3];
+        goto gen_simd_imm8;
+    case INDEX_op_x86_vperm2i128_vec:
+        insn = OPC_VPERM2I128;
+        sub = args[3];
+        goto gen_simd_imm8;
+    gen_simd_imm8:
+        if (type == TCG_TYPE_V256) {
+            insn |= P_VEXL;
+        }
+        tcg_out_vex_modrm(s, insn, a0, a1, a2);
+        tcg_out8(s, sub);
+        break;
+
+    case INDEX_op_x86_vpblendvb_vec:
+        insn = OPC_VPBLENDVB;
+        if (type == TCG_TYPE_V256) {
+            insn |= P_VEXL;
+        }
+        tcg_out_vex_modrm(s, insn, a0, a1, a2);
+        tcg_out8(s, args[3] << 4);
+        break;
+
+    case INDEX_op_x86_psrldq_vec:
+        tcg_out_vex_modrm(s, OPC_GRP14, 3, a0, a1);
+        tcg_out8(s, a2);
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
@@ -2292,6 +2898,11 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         = { .args_ct_str = { "r", "r", "L", "L" } };
     static const TCGTargetOpDef L_L_L_L
         = { .args_ct_str = { "L", "L", "L", "L" } };
+    static const TCGTargetOpDef x_x = { .args_ct_str = { "x", "x" } };
+    static const TCGTargetOpDef x_x_x = { .args_ct_str = { "x", "x", "x" } };
+    static const TCGTargetOpDef x_x_x_x
+        = { .args_ct_str = { "x", "x", "x", "x" } };
+    static const TCGTargetOpDef x_r = { .args_ct_str = { "x", "r" } };
 
     switch (op) {
     case INDEX_op_goto_ptr:
@@ -2493,12 +3104,608 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
             return &s2;
         }
 
+    case INDEX_op_ld_vec:
+    case INDEX_op_st_vec:
+        return &x_r;
+
+    case INDEX_op_add_vec:
+    case INDEX_op_sub_vec:
+    case INDEX_op_mul_vec:
+    case INDEX_op_and_vec:
+    case INDEX_op_or_vec:
+    case INDEX_op_xor_vec:
+    case INDEX_op_andc_vec:
+    case INDEX_op_cmp_vec:
+    case INDEX_op_zipl_vec:
+    case INDEX_op_ziph_vec:
+    case INDEX_op_x86_shufps_vec:
+    case INDEX_op_x86_blend_vec:
+    case INDEX_op_x86_packss_vec:
+    case INDEX_op_x86_packus_vec:
+    case INDEX_op_x86_vperm2i128_vec:
+    case INDEX_op_x86_punpckl_vec:
+    case INDEX_op_x86_punpckh_vec:
+        return &x_x_x;
+    case INDEX_op_dup_vec:
+    case INDEX_op_shli_vec:
+    case INDEX_op_shri_vec:
+    case INDEX_op_sari_vec:
+    case INDEX_op_extsl_vec:
+    case INDEX_op_extul_vec:
+    case INDEX_op_x86_psrldq_vec:
+        return &x_x;
+    case INDEX_op_x86_vpblendvb_vec:
+        return &x_x_x_x;
+
     default:
         break;
     }
     return NULL;
 }
 
+int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
+{
+    switch (opc) {
+    case INDEX_op_add_vec:
+    case INDEX_op_sub_vec:
+    case INDEX_op_and_vec:
+    case INDEX_op_or_vec:
+    case INDEX_op_xor_vec:
+    case INDEX_op_andc_vec:
+    case INDEX_op_extsl_vec:
+    case INDEX_op_extul_vec:
+        return 1;
+    case INDEX_op_cmp_vec:
+    case INDEX_op_extsh_vec:
+    case INDEX_op_extuh_vec:
+    case INDEX_op_trne_vec:
+    case INDEX_op_trno_vec:
+        return -1;
+
+    case INDEX_op_shli_vec:
+    case INDEX_op_shri_vec:
+        /* We must expand the operation for MO_8.  */
+        return vece == MO_8 ? -1 : 1;
+
+    case INDEX_op_sari_vec:
+        /* We must expand the operation for MO_8.  */
+        if (vece == MO_8) {
+            return -1;
+        }
+        /* We can emulate this for MO_64, but it does not pay off
+           unless we're producing at least 4 values.  */
+        if (vece == MO_64) {
+            return type >= TCG_TYPE_V256 ? -1 : 0;
+        }
+        return 1;
+
+    case INDEX_op_mul_vec:
+        if (vece == MO_8) {
+            /* We can expand the operation for MO_8.  */
+            return -1;
+        }
+        if (vece == MO_64) {
+            return 0;
+        }
+        return 1;
+
+    case INDEX_op_zipl_vec:
+        /* We could support v256, but with 3 insns per opcode.
+           It is better to expand with v128 instead.  */
+        return type <= TCG_TYPE_V128;
+    case INDEX_op_ziph_vec:
+        if (type == TCG_TYPE_V64) {
+            return -1;
+        }
+        return type == TCG_TYPE_V128;
+
+    case INDEX_op_uzpe_vec:
+    case INDEX_op_uzpo_vec:
+        /* ??? Not implemented for V256.  */
+        return -(type <= TCG_TYPE_V128);
+
+    default:
+        return 0;
+    }
+}
+
+void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
+                       TCGArg a0, ...)
+{
+    va_list va;
+    TCGArg a1, a2;
+    TCGv_vec v0, v1, v2, t1, t2, t3, t4;
+
+    va_start(va, a0);
+    v0 = temp_tcgv_vec(arg_temp(a0));
+
+    switch (opc) {
+    case INDEX_op_shli_vec:
+    case INDEX_op_shri_vec:
+        tcg_debug_assert(vece == MO_8);
+        a1 = va_arg(va, TCGArg);
+        a2 = va_arg(va, TCGArg);
+        /* Unpack to W, shift, and repack.  Tricky bits:
+           (1) Use punpck*bw x,x to produce DDCCBBAA,
+               i.e. duplicate in other half of the 16-bit lane.
+           (2) For right-shift, add 8 so that the high half of
+               the lane becomes zero.  For left-shift, we must
+               shift up and down again.
+           (3) Step 2 leaves high half zero such that PACKUSWB
+               (pack with unsigned saturation) does not modify
+               the quantity.  */
+        t1 = tcg_temp_new_vec(type);
+        t2 = tcg_temp_new_vec(type);
+        vec_gen_3(INDEX_op_zipl_vec, type, MO_8, tcgv_vec_arg(t1), a1, a1);
+        vec_gen_3(INDEX_op_ziph_vec, type, MO_8, tcgv_vec_arg(t2), a1, a1);
+        if (opc == INDEX_op_shri_vec) {
+            vec_gen_3(INDEX_op_shri_vec, type, MO_16,
+                     tcgv_vec_arg(t1), tcgv_vec_arg(t1), a2 + 8);
+            vec_gen_3(INDEX_op_shri_vec, type, MO_16,
+                     tcgv_vec_arg(t2), tcgv_vec_arg(t2), a2 + 8);
+        } else {
+            vec_gen_3(INDEX_op_shli_vec, type, MO_16,
+                     tcgv_vec_arg(t1), tcgv_vec_arg(t1), a2 + 8);
+            vec_gen_3(INDEX_op_shli_vec, type, MO_16,
+                     tcgv_vec_arg(t2), tcgv_vec_arg(t2), a2 + 8);
+            vec_gen_3(INDEX_op_shri_vec, type, MO_16,
+                     tcgv_vec_arg(t1), tcgv_vec_arg(t1), 8);
+            vec_gen_3(INDEX_op_shri_vec, type, MO_16,
+                     tcgv_vec_arg(t2), tcgv_vec_arg(t2), 8);
+        }
+        vec_gen_3(INDEX_op_x86_packus_vec, type, MO_8,
+                 a0, tcgv_vec_arg(t1), tcgv_vec_arg(t2));
+        tcg_temp_free_vec(t1);
+        tcg_temp_free_vec(t2);
+        break;
+
+    case INDEX_op_sari_vec:
+        a1 = va_arg(va, TCGArg);
+        a2 = va_arg(va, TCGArg);
+        if (vece == MO_8) {
+            /* Unpack to W, shift, and repack, as above.  */
+            t1 = tcg_temp_new_vec(type);
+            t2 = tcg_temp_new_vec(type);
+            vec_gen_3(INDEX_op_zipl_vec, type, MO_8, tcgv_vec_arg(t1), a1, a1);
+            vec_gen_3(INDEX_op_ziph_vec, type, MO_8, tcgv_vec_arg(t2), a1, a1);
+            vec_gen_3(INDEX_op_sari_vec, type, MO_16,
+                      tcgv_vec_arg(t1), tcgv_vec_arg(t1), a2 + 8);
+            vec_gen_3(INDEX_op_sari_vec, type, MO_16,
+                      tcgv_vec_arg(t2), tcgv_vec_arg(t2), a2 + 8);
+            vec_gen_3(INDEX_op_x86_packss_vec, type, MO_8,
+                      a0, tcgv_vec_arg(t1), tcgv_vec_arg(t2));
+            tcg_temp_free_vec(t1);
+            tcg_temp_free_vec(t2);
+            break;
+        }
+        tcg_debug_assert(vece == MO_64);
+        /* MO_64: If the shift is <= 32, we can emulate the sign extend by
+           performing an arithmetic 32-bit shift and overwriting the high
+           half of the result (note that the ISA says shift of 32 is valid). */
+        if (a2 <= 32) {
+            t1 = tcg_temp_new_vec(type);
+            vec_gen_3(INDEX_op_sari_vec, type, MO_32, tcgv_vec_arg(t1), a1, a2);
+            vec_gen_3(INDEX_op_shri_vec, type, MO_64, a0, a1, a2);
+            vec_gen_4(INDEX_op_x86_blend_vec, type, MO_32,
+                      a0, a0, tcgv_vec_arg(t1), 0xaa);
+            tcg_temp_free_vec(t1);
+            break;
+        }
+        /* Otherwise we will need to use a compare vs 0 to produce the
+           sign-extend, shift and merge.  */
+        t1 = tcg_temp_new_vec(type);
+        t2 = tcg_const_zeros_vec(type);
+        vec_gen_4(INDEX_op_cmp_vec, type, MO_64,
+                  tcgv_vec_arg(t1), tcgv_vec_arg(t2), a1, TCG_COND_GT);
+        tcg_temp_free_vec(t2);
+        vec_gen_3(INDEX_op_shri_vec, type, MO_64, a0, a1, a2);
+        vec_gen_3(INDEX_op_shli_vec, type, MO_64,
+                  tcgv_vec_arg(t1), tcgv_vec_arg(t1), 64 - a2);
+        vec_gen_3(INDEX_op_or_vec, type, MO_64, a0, a0, tcgv_vec_arg(t1));
+        tcg_temp_free_vec(t1);
+        break;
+
+    case INDEX_op_mul_vec:
+        tcg_debug_assert(vece == MO_8);
+        a1 = va_arg(va, TCGArg);
+        a2 = va_arg(va, TCGArg);
+        switch (type) {
+        case TCG_TYPE_V64:
+            t1 = tcg_temp_new_vec(TCG_TYPE_V128);
+            t2 = tcg_temp_new_vec(TCG_TYPE_V128);
+            tcg_gen_dup16i_vec(t2, 0);
+            vec_gen_3(INDEX_op_zipl_vec, TCG_TYPE_V128, MO_8,
+                      tcgv_vec_arg(t1), a1, tcgv_vec_arg(t2));
+            vec_gen_3(INDEX_op_zipl_vec, TCG_TYPE_V128, MO_8,
+                      tcgv_vec_arg(t2), tcgv_vec_arg(t2), a2);
+            tcg_gen_mul_vec(MO_16, t1, t1, t2);
+            tcg_gen_shri_vec(MO_16, t1, t1, 8);
+            vec_gen_3(INDEX_op_x86_packus_vec, TCG_TYPE_V128, MO_8,
+                      a0, tcgv_vec_arg(t1), tcgv_vec_arg(t1));
+            tcg_temp_free_vec(t1);
+            tcg_temp_free_vec(t2);
+            break;
+
+        case TCG_TYPE_V128:
+            t1 = tcg_temp_new_vec(TCG_TYPE_V128);
+            t2 = tcg_temp_new_vec(TCG_TYPE_V128);
+            t3 = tcg_temp_new_vec(TCG_TYPE_V128);
+            t4 = tcg_temp_new_vec(TCG_TYPE_V128);
+            tcg_gen_dup16i_vec(t4, 0);
+            vec_gen_3(INDEX_op_zipl_vec, TCG_TYPE_V128, MO_8,
+                      tcgv_vec_arg(t1), a1, tcgv_vec_arg(t4));
+            vec_gen_3(INDEX_op_zipl_vec, TCG_TYPE_V128, MO_8,
+                      tcgv_vec_arg(t2), tcgv_vec_arg(t4), a2);
+            vec_gen_3(INDEX_op_ziph_vec, TCG_TYPE_V128, MO_8,
+                      tcgv_vec_arg(t3), a1, tcgv_vec_arg(t4));
+            vec_gen_3(INDEX_op_ziph_vec, TCG_TYPE_V128, MO_8,
+                      tcgv_vec_arg(t4), tcgv_vec_arg(t4), a2);
+            tcg_gen_mul_vec(MO_16, t1, t1, t2);
+            tcg_gen_mul_vec(MO_16, t3, t3, t4);
+            tcg_gen_shri_vec(MO_16, t1, t1, 8);
+            tcg_gen_shri_vec(MO_16, t3, t3, 8);
+            vec_gen_3(INDEX_op_x86_packus_vec, TCG_TYPE_V128, MO_8,
+                      a0, tcgv_vec_arg(t1), tcgv_vec_arg(t3));
+            tcg_temp_free_vec(t1);
+            tcg_temp_free_vec(t2);
+            tcg_temp_free_vec(t3);
+            tcg_temp_free_vec(t4);
+            break;
+
+        case TCG_TYPE_V256:
+            t1 = tcg_temp_new_vec(TCG_TYPE_V256);
+            t2 = tcg_temp_new_vec(TCG_TYPE_V256);
+            t3 = tcg_temp_new_vec(TCG_TYPE_V256);
+            t4 = tcg_temp_new_vec(TCG_TYPE_V256);
+            tcg_gen_dup16i_vec(t4, 0);
+            /* a1: A[0-7] ... D[0-7]; a2: W[0-7] ... Z[0-7]
+               t1: extends of B[0-7], D[0-7]
+               t2: extends of X[0-7], Z[0-7]
+               t3: extends of A[0-7], C[0-7]
+               t4: extends of W[0-7], Y[0-7].  */
+            vec_gen_3(INDEX_op_zipl_vec, TCG_TYPE_V256, MO_8,
+                      tcgv_vec_arg(t1), a1, tcgv_vec_arg(t4));
+            vec_gen_3(INDEX_op_zipl_vec, TCG_TYPE_V256, MO_8,
+                      tcgv_vec_arg(t2), tcgv_vec_arg(t4), a2);
+            vec_gen_3(INDEX_op_ziph_vec, TCG_TYPE_V256, MO_8,
+                      tcgv_vec_arg(t3), a1, tcgv_vec_arg(t4));
+            vec_gen_3(INDEX_op_ziph_vec, TCG_TYPE_V256, MO_8,
+                      tcgv_vec_arg(t4), tcgv_vec_arg(t4), a2);
+            /* t1: BX DZ; t2: AW CY.  */
+            tcg_gen_mul_vec(MO_16, t1, t1, t2);
+            tcg_gen_mul_vec(MO_16, t3, t3, t4);
+            tcg_gen_shri_vec(MO_16, t1, t1, 8);
+            tcg_gen_shri_vec(MO_16, t3, t3, 8);
+            /* a0: AW BX CY DZ.  */
+            vec_gen_3(INDEX_op_x86_packus_vec, TCG_TYPE_V256, MO_8,
+                      a0, tcgv_vec_arg(t1), tcgv_vec_arg(t3));
+            tcg_temp_free_vec(t1);
+            tcg_temp_free_vec(t2);
+            tcg_temp_free_vec(t3);
+            tcg_temp_free_vec(t4);
+            break;
+
+        default:
+            g_assert_not_reached();
+        }
+        break;
+
+    case INDEX_op_ziph_vec:
+        tcg_debug_assert(type == TCG_TYPE_V64);
+        a1 = va_arg(va, TCGArg);
+        a2 = va_arg(va, TCGArg);
+        vec_gen_3(INDEX_op_zipl_vec, TCG_TYPE_V128, vece, a0, a1, a2);
+        vec_gen_3(INDEX_op_x86_psrldq_vec, TCG_TYPE_V128, MO_64, a0, a0, 8);
+        break;
+
+    case INDEX_op_extsh_vec:
+    case INDEX_op_extuh_vec:
+        a1 = va_arg(va, TCGArg);
+        switch (type) {
+        case TCG_TYPE_V64:
+            vec_gen_3(INDEX_op_x86_psrldq_vec, type, MO_64, a0, a1, 4);
+            break;
+        case TCG_TYPE_V128:
+            vec_gen_3(INDEX_op_x86_psrldq_vec, type, MO_64, a0, a1, 8);
+            break;
+        case TCG_TYPE_V256:
+            vec_gen_4(INDEX_op_x86_vperm2i128_vec, type, 4, a0, a1, a1, 0x81);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        vec_gen_2(opc == INDEX_op_extsh_vec ? INDEX_op_extsl_vec
+                  : INDEX_op_extul_vec, type, vece, a0, a0);
+        break;
+
+    case INDEX_op_uzpe_vec:
+        a1 = va_arg(va, TCGArg);
+        a2 = va_arg(va, TCGArg);
+        v1 = temp_tcgv_vec(arg_temp(a1));
+        v2 = temp_tcgv_vec(arg_temp(a2));
+
+        if (type == TCG_TYPE_V128) {
+            switch (vece) {
+            case MO_8:
+                t1 = tcg_temp_new_vec(type);
+                t2 = tcg_temp_new_vec(type);
+                tcg_gen_dup16i_vec(t2, 0x00ff);
+                tcg_gen_and_vec(MO_16, t1, v2, t2);
+                tcg_gen_and_vec(MO_16, v0, v1, t2);
+                vec_gen_3(INDEX_op_x86_packus_vec, type, MO_8,
+                          a0, a0, tcgv_vec_arg(t1));
+                tcg_temp_free_vec(t1);
+                tcg_temp_free_vec(t2);
+                break;
+            case MO_16:
+                t1 = tcg_temp_new_vec(type);
+                t2 = tcg_temp_new_vec(type);
+                tcg_gen_dup32i_vec(t2, 0x0000ffff);
+                tcg_gen_and_vec(MO_32, t1, v2, t2);
+                tcg_gen_and_vec(MO_32, v0, v1, t2);
+                vec_gen_3(INDEX_op_x86_packus_vec, type, MO_16,
+                          a0, a0, tcgv_vec_arg(t1));
+                tcg_temp_free_vec(t1);
+                tcg_temp_free_vec(t2);
+                break;
+            case MO_32:
+                vec_gen_4(INDEX_op_x86_shufps_vec, type, MO_32,
+                          a0, a1, a2, 0x88);
+                break;
+            case MO_64:
+                tcg_gen_zipl_vec(vece, v0, v1, v2);
+                break;
+            default:
+                g_assert_not_reached();
+            }
+        } else {
+            tcg_debug_assert(type == TCG_TYPE_V64);
+            switch (vece) {
+            case MO_8:
+                t1 = tcg_temp_new_vec(TCG_TYPE_V128);
+                vec_gen_3(INDEX_op_zipl_vec, TCG_TYPE_V128, MO_64,
+                          tcgv_vec_arg(t1), a1, a2);
+                t2 = tcg_temp_new_vec(TCG_TYPE_V128);
+                tcg_gen_dup16i_vec(t2, 0x00ff);
+                tcg_gen_and_vec(MO_16, t1, t1, t2);
+                vec_gen_3(INDEX_op_x86_packus_vec, TCG_TYPE_V128, MO_8,
+                          a0, tcgv_vec_arg(t1), tcgv_vec_arg(t1));
+                tcg_temp_free_vec(t1);
+                tcg_temp_free_vec(t2);
+                break;
+            case MO_16:
+                t1 = tcg_temp_new_vec(TCG_TYPE_V128);
+                vec_gen_3(INDEX_op_zipl_vec, TCG_TYPE_V128, MO_64,
+                          tcgv_vec_arg(t1), a1, a2);
+                t2 = tcg_temp_new_vec(TCG_TYPE_V128);
+                tcg_gen_dup32i_vec(t2, 0x0000ffff);
+                tcg_gen_and_vec(MO_32, t1, t1, t2);
+                vec_gen_3(INDEX_op_x86_packus_vec, TCG_TYPE_V128, MO_16,
+                          a0, tcgv_vec_arg(t1), tcgv_vec_arg(t1));
+                tcg_temp_free_vec(t1);
+                tcg_temp_free_vec(t2);
+                break;
+            case MO_32:
+                tcg_gen_zipl_vec(vece, v0, v1, v2);
+                break;
+            default:
+                g_assert_not_reached();
+            }
+        }
+        break;
+
+    case INDEX_op_uzpo_vec:
+        a1 = va_arg(va, TCGArg);
+        a2 = va_arg(va, TCGArg);
+        v1 = temp_tcgv_vec(arg_temp(a1));
+        v2 = temp_tcgv_vec(arg_temp(a2));
+
+        if (type == TCG_TYPE_V128) {
+            switch (vece) {
+            case MO_8:
+                t1 = tcg_temp_new_vec(type);
+                tcg_gen_shri_vec(MO_16, t1, v2, 8);
+                tcg_gen_shri_vec(MO_16, v0, v1, 8);
+                vec_gen_3(INDEX_op_x86_packus_vec, type, MO_8,
+                          a0, a0, tcgv_vec_arg(t1));
+                tcg_temp_free_vec(t1);
+                break;
+            case MO_16:
+                t1 = tcg_temp_new_vec(type);
+                tcg_gen_shri_vec(MO_32, t1, v2, 16);
+                tcg_gen_shri_vec(MO_32, v0, v1, 16);
+                vec_gen_3(INDEX_op_x86_packus_vec, type, MO_16,
+                          a0, a0, tcgv_vec_arg(t1));
+                tcg_temp_free_vec(t1);
+                break;
+            case MO_32:
+                vec_gen_4(INDEX_op_x86_shufps_vec, type, MO_32,
+                          a0, a1, a2, 0xdd);
+                break;
+            case MO_64:
+                tcg_gen_ziph_vec(vece, v0, v1, v2);
+                break;
+            default:
+                g_assert_not_reached();
+            }
+        } else {
+            switch (vece) {
+            case MO_8:
+                t1 = tcg_temp_new_vec(TCG_TYPE_V128);
+                vec_gen_3(INDEX_op_zipl_vec, TCG_TYPE_V128, MO_64,
+                          tcgv_vec_arg(t1), a1, a2);
+                tcg_gen_shri_vec(MO_16, t1, t1, 8);
+                vec_gen_3(INDEX_op_x86_packus_vec, TCG_TYPE_V128, MO_8,
+                          a0, tcgv_vec_arg(t1), tcgv_vec_arg(t1));
+                tcg_temp_free_vec(t1);
+                break;
+            case MO_16:
+                t1 = tcg_temp_new_vec(TCG_TYPE_V128);
+                vec_gen_3(INDEX_op_zipl_vec, TCG_TYPE_V128, MO_64,
+                          tcgv_vec_arg(t1), a1, a2);
+                tcg_gen_shri_vec(MO_32, t1, t1, 16);
+                vec_gen_3(INDEX_op_x86_packus_vec, TCG_TYPE_V128, MO_16,
+                          a0, tcgv_vec_arg(t1), tcgv_vec_arg(t1));
+                tcg_temp_free_vec(t1);
+                break;
+            case MO_32:
+                tcg_gen_ziph_vec(vece, v0, v1, v2);
+                break;
+            default:
+                g_assert_not_reached();
+            }
+        }
+        break;
+
+    case INDEX_op_trne_vec:
+        a1 = va_arg(va, TCGArg);
+        a2 = va_arg(va, TCGArg);
+        switch (vece) {
+        case MO_8:
+            t1 = tcg_temp_new_vec(type);
+            t2 = tcg_temp_new_vec(type);
+            vec_gen_3(INDEX_op_shli_vec, type, MO_16,
+                      tcgv_vec_arg(t1), a2, 8);
+            tcg_gen_dup16i_vec(t2, 0xff00);
+            vec_gen_4(INDEX_op_x86_vpblendvb_vec, type, MO_8,
+                      a0, a1, tcgv_vec_arg(t1), tcgv_vec_arg(t2));
+            tcg_temp_free_vec(t1);
+            tcg_temp_free_vec(t2);
+            break;
+        case MO_16:
+            t1 = tcg_temp_new_vec(type);
+            vec_gen_3(INDEX_op_shli_vec, type, MO_32,
+                      tcgv_vec_arg(t1), a2, 16);
+            vec_gen_4(INDEX_op_x86_blend_vec, type, MO_16,
+                      a0, a1, tcgv_vec_arg(t1), 0xaa);
+            tcg_temp_free_vec(t1);
+            break;
+        case MO_32:
+            t1 = tcg_temp_new_vec(type);
+            vec_gen_3(INDEX_op_shli_vec, type, MO_64,
+                      tcgv_vec_arg(t1), a2, 32);
+            vec_gen_4(INDEX_op_x86_blend_vec, type, MO_32,
+                      a0, a1, tcgv_vec_arg(t1), 0xaa);
+            tcg_temp_free_vec(t1);
+            break;
+        case MO_64:
+            vec_gen_3(INDEX_op_x86_punpckl_vec, type, MO_64, a0, a1, a2);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        break;
+
+    case INDEX_op_trno_vec:
+        a1 = va_arg(va, TCGArg);
+        a2 = va_arg(va, TCGArg);
+        switch (vece) {
+        case MO_8:
+            t1 = tcg_temp_new_vec(type);
+            t2 = tcg_temp_new_vec(type);
+            vec_gen_3(INDEX_op_shri_vec, type, MO_16,
+                      tcgv_vec_arg(t1), a1, 8);
+            tcg_gen_dup16i_vec(t2, 0xff00);
+            vec_gen_4(INDEX_op_x86_vpblendvb_vec, type, MO_8,
+                      a0, tcgv_vec_arg(t1), a2, tcgv_vec_arg(t2));
+            tcg_temp_free_vec(t1);
+            tcg_temp_free_vec(t2);
+            break;
+        case MO_16:
+            t1 = tcg_temp_new_vec(type);
+            vec_gen_3(INDEX_op_shri_vec, type, MO_32,
+                      tcgv_vec_arg(t1), a1, 16);
+            vec_gen_4(INDEX_op_x86_blend_vec, type, MO_16,
+                      a0, tcgv_vec_arg(t1), a2, 0xaa);
+            tcg_temp_free_vec(t1);
+            break;
+        case MO_32:
+            t1 = tcg_temp_new_vec(type);
+            vec_gen_3(INDEX_op_shri_vec, type, MO_64,
+                      tcgv_vec_arg(t1), a1, 32);
+            vec_gen_4(INDEX_op_x86_blend_vec, type, MO_32,
+                      a0, tcgv_vec_arg(t1), a2, 0xaa);
+            tcg_temp_free_vec(t1);
+            break;
+        case MO_64:
+            vec_gen_3(INDEX_op_x86_punpckh_vec, type, MO_64, a0, a1, a2);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        break;
+
+    case INDEX_op_cmp_vec:
+        {
+            enum {
+                NEED_SWAP = 1,
+                NEED_INV  = 2,
+                NEED_BIAS = 4
+            };
+            static const uint8_t fixups[16] = {
+                [0 ... 15] = -1,
+                [TCG_COND_EQ] = 0,
+                [TCG_COND_NE] = NEED_INV,
+                [TCG_COND_GT] = 0,
+                [TCG_COND_LT] = NEED_SWAP,
+                [TCG_COND_LE] = NEED_INV,
+                [TCG_COND_GE] = NEED_SWAP | NEED_INV,
+                [TCG_COND_GTU] = NEED_BIAS,
+                [TCG_COND_LTU] = NEED_BIAS | NEED_SWAP,
+                [TCG_COND_LEU] = NEED_BIAS | NEED_INV,
+                [TCG_COND_GEU] = NEED_BIAS | NEED_SWAP | NEED_INV,
+            };
+
+            TCGCond cond;
+            uint8_t fixup;
+
+            a1 = va_arg(va, TCGArg);
+            a2 = va_arg(va, TCGArg);
+            cond = va_arg(va, TCGArg);
+            fixup = fixups[cond & 15];
+            tcg_debug_assert(fixup != 0xff);
+
+            if (fixup & NEED_INV) {
+                cond = tcg_invert_cond(cond);
+            }
+            if (fixup & NEED_SWAP) {
+                TCGArg t;
+                t = a1, a1 = a2, a2 = t;
+                cond = tcg_swap_cond(cond);
+            }
+
+            t1 = t2 = NULL;
+            if (fixup & NEED_BIAS) {
+                t1 = tcg_temp_new_vec(type);
+                t2 = tcg_temp_new_vec(type);
+                tcg_gen_dupi_vec(vece, t2, 1ull << ((8 << vece) - 1));
+                tcg_gen_sub_vec(vece, t1, temp_tcgv_vec(arg_temp(a1)), t2);
+                tcg_gen_sub_vec(vece, t2, temp_tcgv_vec(arg_temp(a2)), t2);
+                a1 = tcgv_vec_arg(t1);
+                a2 = tcgv_vec_arg(t2);
+                cond = tcg_signed_cond(cond);
+            }
+
+            tcg_debug_assert(cond == TCG_COND_EQ || cond == TCG_COND_GT);
+            vec_gen_4(INDEX_op_cmp_vec, type, vece, a0, a1, a2, cond);
+
+            if (fixup & NEED_BIAS) {
+                tcg_temp_free_vec(t1);
+                tcg_temp_free_vec(t2);
+            }
+            if (fixup & NEED_INV) {
+                tcg_gen_not_vec(vece, v0, v0);
+            }
+        }
+        break;
+
+    default:
+        break;
+    }
+
+    va_end(va);
+}
+
 static const int tcg_target_callee_save_regs[] = {
 #if TCG_TARGET_REG_BITS == 64
     TCG_REG_RBP,
@@ -2577,6 +3784,9 @@ static void tcg_target_qemu_prologue(TCGContext *s)
 
     tcg_out_addi(s, TCG_REG_CALL_STACK, stack_addend);
 
+    if (have_avx2) {
+        tcg_out_vex_opc(s, OPC_VZEROUPPER, 0, 0, 0, 0);
+    }
     for (i = ARRAY_SIZE(tcg_target_callee_save_regs) - 1; i >= 0; i--) {
         tcg_out_pop(s, tcg_target_callee_save_regs[i]);
     }
@@ -2598,9 +3808,16 @@ static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
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
@@ -2609,17 +3826,22 @@ static void tcg_target_init(TCGContext *s)
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
@@ -2630,11 +3852,16 @@ static void tcg_target_init(TCGContext *s)
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
