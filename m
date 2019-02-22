Received: from eggs.gnu.org ([209.51.188.92]:33816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gx3sX-0001BB-RU
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 01:00:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gx3sU-0007p1-4s
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 01:00:09 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:46242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gx3sR-0007hj-Vt
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 01:00:06 -0500
Received: by mail-pl1-x641.google.com with SMTP id o6so566340pls.13
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 21:59:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 21 Feb 2019 21:59:50 -0800
Message-Id: <20190222055950.17403-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH] tcg/ppc: Add vector opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au, mark.cave-ayland@ilande.co.uk

This requires VSX, not just Altivec, so Power7 or later.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

At present there are no tunables that can avoid the 64-bit element
load/store requirement.  As with requiring AVX1 for x86 hosts, I'm
not sure it's worth inventing such a tunable for pre-power7 hosts.

Tested vs aarch64 risu test cases.  It's probably worth testing
this vs Mark's target/ppc conversion.


r~

---
 tcg/ppc/tcg-target.h     |  31 +-
 tcg/ppc/tcg-target.opc.h |   3 +
 tcg/ppc/tcg-target.inc.c | 604 +++++++++++++++++++++++++++++++++++----
 3 files changed, 577 insertions(+), 61 deletions(-)
 create mode 100644 tcg/ppc/tcg-target.opc.h

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 52c1bb04b1..0b9943e7e6 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -31,7 +31,7 @@
 # define TCG_TARGET_REG_BITS  32
 #endif
 
-#define TCG_TARGET_NB_REGS 32
+#define TCG_TARGET_NB_REGS 64
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 16
 
@@ -45,12 +45,22 @@ typedef enum {
     TCG_REG_R24, TCG_REG_R25, TCG_REG_R26, TCG_REG_R27,
     TCG_REG_R28, TCG_REG_R29, TCG_REG_R30, TCG_REG_R31,
 
+    TCG_REG_V0,  TCG_REG_V1,  TCG_REG_V2,  TCG_REG_V3,
+    TCG_REG_V4,  TCG_REG_V5,  TCG_REG_V6,  TCG_REG_V7,
+    TCG_REG_V8,  TCG_REG_V9,  TCG_REG_V10, TCG_REG_V11,
+    TCG_REG_V12, TCG_REG_V13, TCG_REG_V14, TCG_REG_V15,
+    TCG_REG_V16, TCG_REG_V17, TCG_REG_V18, TCG_REG_V19,
+    TCG_REG_V20, TCG_REG_V21, TCG_REG_V22, TCG_REG_V23,
+    TCG_REG_V24, TCG_REG_V25, TCG_REG_V26, TCG_REG_V27,
+    TCG_REG_V28, TCG_REG_V29, TCG_REG_V30, TCG_REG_V31,
+
     TCG_REG_CALL_STACK = TCG_REG_R1,
     TCG_AREG0 = TCG_REG_R27
 } TCGReg;
 
 extern bool have_isa_2_06;
 extern bool have_isa_3_00;
+extern bool have_isa_2_07_vsx;
 
 /* optional instructions automatically implemented */
 #define TCG_TARGET_HAS_ext8u_i32        0 /* andi */
@@ -124,6 +134,25 @@ extern bool have_isa_3_00;
 #define TCG_TARGET_HAS_mulsh_i64        1
 #endif
 
+/* VSX required over ALTIVEC to perform 64-bit loads.  */
+#if TCG_TARGET_REG_BITS == 64
+#define TCG_TARGET_HAS_v64              have_isa_2_07_vsx
+#define TCG_TARGET_HAS_v128             have_isa_2_07_vsx
+#define TCG_TARGET_HAS_v256             0
+#endif
+
+#define TCG_TARGET_HAS_andc_vec         1
+#define TCG_TARGET_HAS_orc_vec          1
+#define TCG_TARGET_HAS_not_vec          1
+#define TCG_TARGET_HAS_neg_vec          0
+#define TCG_TARGET_HAS_shi_vec          0
+#define TCG_TARGET_HAS_shs_vec          0
+#define TCG_TARGET_HAS_shv_vec          0
+#define TCG_TARGET_HAS_cmp_vec          1
+#define TCG_TARGET_HAS_mul_vec          1
+#define TCG_TARGET_HAS_sat_vec          1
+#define TCG_TARGET_HAS_minmax_vec       1
+
 void flush_icache_range(uintptr_t start, uintptr_t stop);
 void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
 
diff --git a/tcg/ppc/tcg-target.opc.h b/tcg/ppc/tcg-target.opc.h
new file mode 100644
index 0000000000..4816a6c3d4
--- /dev/null
+++ b/tcg/ppc/tcg-target.opc.h
@@ -0,0 +1,3 @@
+/* Target-specific opcodes for host vector expansion.  These will be
+   emitted by tcg_expand_vec_op.  For those familiar with GCC internals,
+   consider these to be UNSPEC with names.  */
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 773690f1d9..d0782e2eb2 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -42,6 +42,9 @@
 # define TCG_REG_TMP1   TCG_REG_R12
 #endif
 
+#define TCG_VEC_TMP1    TCG_REG_V0
+#define TCG_VEC_TMP2    TCG_REG_V1
+
 #define TCG_REG_TB     TCG_REG_R31
 #define USE_REG_TB     (TCG_TARGET_REG_BITS == 64)
 
@@ -63,6 +66,7 @@ static tcg_insn_unit *tb_ret_addr;
 
 bool have_isa_2_06;
 bool have_isa_3_00;
+bool have_isa_2_07_vsx;
 
 #define HAVE_ISA_2_06  have_isa_2_06
 #define HAVE_ISEL      have_isa_2_06
@@ -72,39 +76,15 @@ bool have_isa_3_00;
 #endif
 
 #ifdef CONFIG_DEBUG_TCG
-static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
-    "r0",
-    "r1",
-    "r2",
-    "r3",
-    "r4",
-    "r5",
-    "r6",
-    "r7",
-    "r8",
-    "r9",
-    "r10",
-    "r11",
-    "r12",
-    "r13",
-    "r14",
-    "r15",
-    "r16",
-    "r17",
-    "r18",
-    "r19",
-    "r20",
-    "r21",
-    "r22",
-    "r23",
-    "r24",
-    "r25",
-    "r26",
-    "r27",
-    "r28",
-    "r29",
-    "r30",
-    "r31"
+static const char tcg_target_reg_names[TCG_TARGET_NB_REGS][4] = {
+    "r0",  "r1",  "r2",  "r3",  "r4",  "r5",  "r6",  "r7",
+    "r8",  "r9",  "r10", "r11", "r12", "r13", "r14", "r15",
+    "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
+    "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31",
+    "v0",  "v1",  "v2",  "v3",  "v4",  "v5",  "v6",  "v7",
+    "v8",  "v9",  "v10", "v11", "v12", "v13", "v14", "v15",
+    "v16", "v17", "v18", "v19", "v20", "v21", "v22", "v23",
+    "v24", "v25", "v26", "v27", "v28", "v29", "v30", "v31",
 };
 #endif
 
@@ -139,6 +119,26 @@ static const int tcg_target_reg_alloc_order[] = {
     TCG_REG_R5,
     TCG_REG_R4,
     TCG_REG_R3,
+
+    /* V0 and V1 reserved as temporaries; V20 - V31 are call-saved */
+    TCG_REG_V2,   /* call clobbered, vectors */
+    TCG_REG_V3,
+    TCG_REG_V4,
+    TCG_REG_V5,
+    TCG_REG_V6,
+    TCG_REG_V7,
+    TCG_REG_V8,
+    TCG_REG_V9,
+    TCG_REG_V10,
+    TCG_REG_V11,
+    TCG_REG_V12,
+    TCG_REG_V13,
+    TCG_REG_V14,
+    TCG_REG_V15,
+    TCG_REG_V16,
+    TCG_REG_V17,
+    TCG_REG_V18,
+    TCG_REG_V19,
 };
 
 static const int tcg_target_call_iarg_regs[] = {
@@ -233,6 +233,10 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
         ct->ct |= TCG_CT_REG;
         ct->u.regs = 0xffffffff;
         break;
+    case 'v':
+        ct->ct |= TCG_CT_REG;
+        ct->u.regs = 0xffffffff00000000ull;
+        break;
     case 'L':                   /* qemu_ld constraint */
         ct->ct |= TCG_CT_REG;
         ct->u.regs = 0xffffffff;
@@ -320,6 +324,7 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define XO31(opc) (OPCD(31)|((opc)<<1))
 #define XO58(opc) (OPCD(58)|(opc))
 #define XO62(opc) (OPCD(62)|(opc))
+#define VX4(opc)  (OPCD(4)|(opc))
 
 #define B      OPCD( 18)
 #define BC     OPCD( 16)
@@ -461,6 +466,101 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 
 #define NOP    ORI  /* ori 0,0,0 */
 
+#define MTVSRD     XO31(179)                          /* 2.07 */
+#define MTVSRWZ    XO31(243)                          /* 2.07 */
+#define MFVSRD     XO31(51)                           /* 2.07 */
+#define MFVSRWZ    XO31(115)                          /* 2.07 */
+
+#define LVX        XO31(103)                          /* Altivec */
+#define LXSIWZX    XO31(12)                           /* 2.07 */
+#define LXSD       (OPCD(57) | 2)                     /* 3.0 */
+#define LXSDX      XO31(588)                          /* 2.06 */
+#define LXV        (OPCD(61) | 1)                     /* 3.0 */
+#define LXVX       (OPCD(31) | (4 << 7) | (12 << 1))  /* 3.0 */
+#define LXVDSX     XO31(332)                          /* 2.06 */
+
+#define STVX       XO31(231)                          /* Altivec */
+#define STXSIWX    XO31(140)                          /* 2.07 */
+#define STXSD      (OPCD(61) | 2)                     /* 3.0 */
+#define STXSDX     XO31(716)                          /* 2.06 */
+#define STXVD2X    XO31(972)                          /* 2.06 */
+#define STXV       (OPCD(61) | 5)                     /* 3.0 */
+#define STXVX      XO31(396)                          /* 3.0 */
+
+#define VADDSBS    VX4(768)
+#define VADDUBS    VX4(512)
+#define VADDUBM    VX4(0)
+#define VADDSHS    VX4(832)
+#define VADDUHS    VX4(576)
+#define VADDUHM    VX4(64)
+#define VADDSWS    VX4(896)
+#define VADDUWS    VX4(640)
+#define VADDUWM    VX4(128)
+#define VADDUDM    VX4(192)
+#define VSUBSBS    VX4(1792)
+#define VSUBUBS    VX4(1536)
+#define VSUBUBM    VX4(1024)
+#define VSUBSHS    VX4(1856)
+#define VSUBUHS    VX4(1600)
+#define VSUBUHM    VX4(1088)
+#define VSUBSWS    VX4(1920)
+#define VSUBUWS    VX4(1664)
+#define VSUBUWM    VX4(1152)
+#define VSUBUDM    VX4(1216)
+
+#define VMAXSB     VX4(258)
+#define VMAXSH     VX4(322)
+#define VMAXSW     VX4(386)
+#define VMAXSD     VX4(450)
+#define VMAXUB     VX4(2)
+#define VMAXUH     VX4(66)
+#define VMAXUW     VX4(130)
+#define VMAXUD     VX4(194)
+#define VMINSB     VX4(770)
+#define VMINSH     VX4(834)
+#define VMINSW     VX4(898)
+#define VMINSD     VX4(962)
+#define VMINUB     VX4(514)
+#define VMINUH     VX4(578)
+#define VMINUW     VX4(642)
+#define VMINUD     VX4(706)
+
+#define VMULUWM    VX4(137)
+
+#define VCMPEQUB   VX4(6)
+#define VCMPEQUH   VX4(70)
+#define VCMPEQUW   VX4(134)
+#define VCMPEQUD   VX4(199)
+#define VCMPGTSB   VX4(774)
+#define VCMPGTSH   VX4(838)
+#define VCMPGTSW   VX4(902)
+#define VCMPGTSD   VX4(967)
+#define VCMPGTUB   VX4(518)
+#define VCMPGTUH   VX4(582)
+#define VCMPGTUW   VX4(646)
+#define VCMPGTUD   VX4(711)
+#define VCMPNEB    VX4(7)
+#define VCMPNEH    VX4(71)
+#define VCMPNEW    VX4(135)
+
+#define VAND       VX4(1028)
+#define VANDC      VX4(1092)
+#define VEQV       VX4(1668)
+#define VNAND      VX4(1412)
+#define VORC       VX4(1348)
+#define VNOR       VX4(1284)
+#define VOR        VX4(1156)
+#define VXOR       VX4(1220)
+
+#define VSPLTB     VX4(524)
+#define VSPLTH     VX4(588)
+#define VSPLTW     VX4(652)
+#define XXPERMDI   (OPCD(60) | (10 << 3))
+#define VSPLTISB   VX4(780)
+#define VSPLTISH   VX4(844)
+#define VSPLTISW   VX4(908)
+#define XXSPLTIB   (OPCD(60) | (360 << 1))
+
 #define RT(r) ((r)<<21)
 #define RS(r) ((r)<<21)
 #define RA(r) ((r)<<16)
@@ -473,6 +573,10 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define MB64(b) ((b)<<5)
 #define FXM(b) (1 << (19 - (b)))
 
+#define VRT(r)  (((r) & 31) << 21)
+#define VRA(r)  (((r) & 31) << 16)
+#define VRB(r)  (((r) & 31) << 11)
+
 #define LK    1
 
 #define TAB(t, a, b) (RT(t) | RA(a) | RB(b))
@@ -568,9 +672,32 @@ static void tcg_out_mem_long(TCGContext *s, int opi, int opx, TCGReg rt,
 
 static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
 {
-    tcg_debug_assert(TCG_TARGET_REG_BITS == 64 || type == TCG_TYPE_I32);
-    if (ret != arg) {
-        tcg_out32(s, OR | SAB(arg, ret, arg));
+    if (ret == arg) {
+        return;
+    }
+    switch (type) {
+    case TCG_TYPE_I64:
+        tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
+        /* fallthru */
+    case TCG_TYPE_I32:
+        if (ret < 32 && arg < 32) {
+            tcg_out32(s, OR | SAB(arg, ret, arg));
+            break;
+        } else if (ret < 32) {
+            tcg_out32(s, MFVSRD | VRT(arg) | 1 | RA(ret));
+            break;
+        } else if (arg < 32) {
+            tcg_out32(s, MTVSRD | VRT(ret) | 1 | RA(arg));
+            break;
+        }
+        /* fallthru */
+    case TCG_TYPE_V64:
+    case TCG_TYPE_V128:
+        tcg_debug_assert(ret >= 32 && arg >= 32);
+        tcg_out32(s, VOR | VRT(ret) | VRA(arg) | VRB(arg));
+        break;
+    default:
+        g_assert_not_reached();
     }
 }
 
@@ -719,10 +846,45 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
     }
 }
 
-static inline void tcg_out_movi(TCGContext *s, TCGType type, TCGReg ret,
-                                tcg_target_long arg)
+static void tcg_out_dupi_vec(TCGContext *s, TCGType type, TCGReg ret,
+                             tcg_target_long val)
 {
-    tcg_out_movi_int(s, type, ret, arg, false);
+    if (val == (tcg_target_long)dup_const(MO_8, val)) {
+        tcg_out32(s, XXSPLTIB | VRT(ret) | ((val & 0xff) << 11) | 1);
+    } else if (val == (tcg_target_long)dup_const(MO_16, val)
+               && (int16_t)val >= -16 && (int16_t)val < 16) {
+        tcg_out32(s, VSPLTISH | VRT(ret) | ((val & 31) << 16));
+    } else if (val == (tcg_target_long)dup_const(MO_32, val)
+               && (int32_t)val >= -16 && (int32_t)val < 16) {
+        tcg_out32(s, VSPLTISW | VRT(ret) | ((val & 31) << 16));
+    } else {
+        new_pool_label(s, val, R_PPC_ADDR16, s->code_ptr,
+                       -(intptr_t)s->code_gen_ptr);
+        tcg_out32(s, ADDIS | TAI(TCG_REG_TMP1, TCG_REG_TB, 0));
+        tcg_out32(s, ADDI | TAI(TCG_REG_TMP1, TCG_REG_TMP1, 0));
+        tcg_out32(s, LXVDSX | VRT(ret) | RB(TCG_REG_TMP1) | 1);
+    }
+}
+
+static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg ret,
+                         tcg_target_long arg)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+    case TCG_TYPE_I64:
+        tcg_debug_assert(ret < 32);
+        tcg_out_movi_int(s, type, ret, arg, false);
+        break;
+
+    case TCG_TYPE_V64:
+    case TCG_TYPE_V128:
+        tcg_debug_assert(ret >= 32);
+        tcg_out_dupi_vec(s, type, ret, arg);
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
 }
 
 static bool mask_operand(uint32_t c, int *mb, int *me)
@@ -872,10 +1034,18 @@ static void tcg_out_mem_long(TCGContext *s, int opi, int opx, TCGReg rt,
     case STB: case STH: case STW:
         is_store = true;
         break;
+    case LXSD: case STXSD:
+        align = 3;
+        break;
+    case LXV: case LXV | 8:
+    case STXV: case STXV | 8:
+        /* The "|8" forces the Altivec regiter.  */
+        align = 15;
+        break;
     }
 
     /* For unaligned, or very large offsets, use the indexed form.  */
-    if (offset & align || offset != (int32_t)offset) {
+    if (offset & align || offset != (int32_t)offset || opi == 0) {
         if (rs == base) {
             rs = TCG_REG_R0;
         }
@@ -906,32 +1076,74 @@ static void tcg_out_mem_long(TCGContext *s, int opi, int opx, TCGReg rt,
     }
 }
 
-static inline void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret,
-                              TCGReg arg1, intptr_t arg2)
+static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret,
+                       TCGReg base, intptr_t offset)
 {
-    int opi, opx;
-
-    tcg_debug_assert(TCG_TARGET_REG_BITS == 64 || type == TCG_TYPE_I32);
-    if (type == TCG_TYPE_I32) {
-        opi = LWZ, opx = LWZX;
-    } else {
-        opi = LD, opx = LDX;
+    switch (type) {
+    case TCG_TYPE_I32:
+        if (ret < 32) {
+            tcg_out_mem_long(s, LWZ, LWZX, ret, base, offset);
+        } else {
+            tcg_out_mem_long(s, 0, LXSIWZX | 1, ret & 31, base, offset);
+        }
+        break;
+    case TCG_TYPE_I64:
+        if (ret < 32) {
+            tcg_out_mem_long(s, LD, LDX, ret, base, offset);
+            break;
+        }
+        /* fallthru */
+    case TCG_TYPE_V64:
+        tcg_debug_assert(ret >= 32);
+        tcg_out_mem_long(s, have_isa_3_00 ? LXSD : 0, LXSDX | 1,
+                         ret & 31, base, offset);
+        break;
+    case TCG_TYPE_V128:
+        tcg_debug_assert(ret >= 32);
+        if (have_isa_3_00) {
+            tcg_out_mem_long(s, LXV | 8, LVX, ret & 31, base, offset);
+        } else {
+            tcg_out_mem_long(s, 0, LVX, ret & 31, base, offset);
+        }
+        break;
+    default:
+        g_assert_not_reached();
     }
-    tcg_out_mem_long(s, opi, opx, ret, arg1, arg2);
 }
 
-static inline void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
-                              TCGReg arg1, intptr_t arg2)
+static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
+                              TCGReg base, intptr_t offset)
 {
-    int opi, opx;
-
-    tcg_debug_assert(TCG_TARGET_REG_BITS == 64 || type == TCG_TYPE_I32);
-    if (type == TCG_TYPE_I32) {
-        opi = STW, opx = STWX;
-    } else {
-        opi = STD, opx = STDX;
+    switch (type) {
+    case TCG_TYPE_I32:
+        if (arg < 32) {
+            tcg_out_mem_long(s, STW, STWX, arg, base, offset);
+        } else {
+            tcg_out_mem_long(s, 0, STXSIWX | 1, arg & 31, base, offset);
+        }
+        break;
+    case TCG_TYPE_I64:
+        if (arg < 32) {
+            tcg_out_mem_long(s, STD, STDX, arg, base, offset);
+            break;
+        }
+        /* fallthru */
+    case TCG_TYPE_V64:
+        tcg_debug_assert(arg >= 32);
+        tcg_out_mem_long(s, have_isa_3_00 ? STXSD : 0, STXSDX | 1,
+                         arg & 31, base, offset);
+        break;
+    case TCG_TYPE_V128:
+        tcg_debug_assert(arg >= 32);
+        if (have_isa_3_00) {
+            tcg_out_mem_long(s, STXV | 8, STVX, arg & 31, base, offset);
+        } else {
+            tcg_out_mem_long(s, 0, STVX, arg & 31, base, offset);
+        }
+        break;
+    default:
+        g_assert_not_reached();
     }
-    tcg_out_mem_long(s, opi, opx, arg, arg1, arg2);
 }
 
 static inline bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
@@ -2617,6 +2829,220 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
     }
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
+    case INDEX_op_orc_vec:
+    case INDEX_op_not_vec:
+    case INDEX_op_cmp_vec:
+    case INDEX_op_smax_vec:
+    case INDEX_op_smin_vec:
+    case INDEX_op_umax_vec:
+    case INDEX_op_umin_vec:
+        return 1;
+    case INDEX_op_ssadd_vec:
+    case INDEX_op_sssub_vec:
+    case INDEX_op_usadd_vec:
+    case INDEX_op_ussub_vec:
+        return vece <= MO_32;
+    case INDEX_op_mul_vec:
+        return vece == MO_32;
+    default:
+        return 0;
+    }
+}
+
+static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
+                           unsigned vecl, unsigned vece,
+                           const TCGArg *args, const int *const_args)
+{
+    static const uint32_t
+        add_op[4] = { VADDUBM, VADDUHM, VADDUWM, VADDUDM },
+        sub_op[4] = { VSUBUBM, VSUBUHM, VSUBUWM, VSUBUDM },
+        eq_op[4]  = { VCMPEQUB, VCMPEQUH, VCMPEQUW, VCMPEQUD },
+        gts_op[4] = { VCMPGTSB, VCMPGTSH, VCMPGTSW, VCMPGTSD },
+        gtu_op[4] = { VCMPGTUB, VCMPGTUH, VCMPGTUW, VCMPGTUD },
+        ne_op[4]  = { VCMPNEB, VCMPNEH, VCMPNEW, 0 },
+        ssadd_op[4] = { VADDSBS, VADDSHS, VADDSWS, 0 },
+        usadd_op[4] = { VADDUBS, VADDUHS, VADDUWS, 0 },
+        sssub_op[4] = { VSUBSBS, VSUBSHS, VSUBSWS, 0 },
+        ussub_op[4] = { VSUBUBS, VSUBUHS, VSUBUWS, 0 },
+        umin_op[4] = { VMINUB, VMINUH, VMINUW, VMINUD }, 
+        smin_op[4] = { VMINSB, VMINSH, VMINSW, VMINSD }, 
+        umax_op[4] = { VMAXUB, VMAXUH, VMAXUW, VMAXUD }, 
+        smax_op[4] = { VMAXSB, VMAXSH, VMAXSW, VMAXSD };
+
+    TCGType type = vecl + TCG_TYPE_V64;
+    TCGArg a0 = args[0], a1 = args[1], a2 = args[2];
+    uint32_t insn;
+
+    switch (opc) {
+    case INDEX_op_ld_vec:
+        tcg_out_ld(s, type, a0, a1, a2);
+        return;
+    case INDEX_op_st_vec:
+        tcg_out_st(s, type, a0, a1, a2);
+        return;
+
+    case INDEX_op_add_vec:
+        insn = add_op[vece];
+        break;
+    case INDEX_op_sub_vec:
+        insn = sub_op[vece];
+        break;
+    case INDEX_op_ssadd_vec:
+        insn = ssadd_op[vece];
+        break;
+    case INDEX_op_sssub_vec:
+        insn = sssub_op[vece];
+        break;
+    case INDEX_op_usadd_vec:
+        insn = usadd_op[vece];
+        break;
+    case INDEX_op_ussub_vec:
+        insn = ussub_op[vece];
+        break;
+    case INDEX_op_smin_vec:
+        insn = smin_op[vece];
+        break;
+    case INDEX_op_umin_vec:
+        insn = umin_op[vece];
+        break;
+    case INDEX_op_smax_vec:
+        insn = smax_op[vece];
+        break;
+    case INDEX_op_umax_vec:
+        insn = umax_op[vece];
+        break;
+    case INDEX_op_mul_vec:
+        insn = VMULUWM;
+        break;
+    case INDEX_op_and_vec:
+        insn = VAND;
+        break;
+    case INDEX_op_or_vec:
+        insn = VOR;
+        break;
+    case INDEX_op_xor_vec:
+        insn = VXOR;
+        break;
+    case INDEX_op_andc_vec:
+        insn = VANDC;
+        break;
+    case INDEX_op_orc_vec:
+        insn = VORC;
+        break;
+    case INDEX_op_not_vec:
+        insn = VNOR;
+        a2 = a1;
+        break;
+
+    case INDEX_op_dup_vec:
+        /* Recall we use VSX integer loads, so the integer is right
+           justified within the left (zero-index) double-word.  */
+        switch (vece) {
+        case MO_8:
+            tcg_out32(s, VSPLTB | VRT(a0) | VRB(a1) | (7 << 16));
+            break;
+        case MO_16:
+            tcg_out32(s, VSPLTH | VRT(a0) | VRB(a1) | (3 << 16));
+            break;
+        case MO_32:
+            tcg_out32(s, VSPLTW | VRT(a0) | VRB(a1) | (1 << 16));
+            break;
+        case MO_64:
+            tcg_out32(s, XXPERMDI | VRT(a0) | VRA(a1) | VRB(a1) | (0 << 8) | 7);
+            break;
+        }
+        return;
+
+    case INDEX_op_cmp_vec:
+        {
+            TCGCond cond = args[3];
+            bool need_swap = false;
+            bool need_inv = false;
+
+            switch (cond) {
+            case TCG_COND_EQ:
+                break;
+            case TCG_COND_NE:
+                if (vece == MO_64) {
+                    need_inv = true;
+                }
+                break;
+            case TCG_COND_GT:
+            case TCG_COND_GTU:
+                break;
+            case TCG_COND_LT:
+            case TCG_COND_LTU:
+                need_swap = true;
+                break;
+            case TCG_COND_LE:
+            case TCG_COND_LEU:
+                need_inv = true;
+                break;
+            case TCG_COND_GE:
+            case TCG_COND_GEU:
+                need_swap = need_inv = true;
+                break;
+            default:
+                g_assert_not_reached();
+            }
+
+            if (need_swap) {
+                cond = tcg_swap_cond(cond);
+                a1 = args[2];
+                a2 = args[1];
+            }
+            if (need_inv) {
+                cond = tcg_invert_cond(cond);
+            }
+
+            switch (cond) {
+            case TCG_COND_EQ:
+                insn = eq_op[vece];
+                break;
+            case TCG_COND_NE:
+                insn = ne_op[vece];
+                break;
+            case TCG_COND_GT:
+                insn = gts_op[vece];
+                break;
+            case TCG_COND_GTU:
+                insn = gtu_op[vece];
+                break;
+            default:
+                g_assert_not_reached();
+            }
+            tcg_debug_assert(insn != 0);
+
+            tcg_out32(s, insn | VRT(a0) | VRA(a1) | VRB(a2));
+            if (need_inv) {
+                tcg_out32(s, VNOR | VRT(a0) | VRA(a0) | VRB(a0));
+            }
+        }
+        return;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    tcg_debug_assert(insn != 0);
+    tcg_out32(s, insn | VRT(a0) | VRA(a1) | VRB(a2));
+}
+
+void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
+                       TCGArg a0, ...)
+{
+    g_assert_not_reached();
+}
+
 static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
 {
     static const TCGTargetOpDef r = { .args_ct_str = { "r" } };
@@ -2654,6 +3080,9 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         = { .args_ct_str = { "r", "r", "r", "r", "rI", "rZM" } };
     static const TCGTargetOpDef sub2
         = { .args_ct_str = { "r", "r", "rI", "rZM", "r", "r" } };
+    static const TCGTargetOpDef v_r = { .args_ct_str = { "v", "r" } };
+    static const TCGTargetOpDef v_v = { .args_ct_str = { "v", "v" } };
+    static const TCGTargetOpDef v_v_v = { .args_ct_str = { "v", "v", "v" } };
 
     switch (op) {
     case INDEX_op_goto_ptr:
@@ -2789,6 +3218,31 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         return (TCG_TARGET_REG_BITS == 64 ? &S_S
                 : TARGET_LONG_BITS == 32 ? &S_S_S : &S_S_S_S);
 
+    case INDEX_op_add_vec:
+    case INDEX_op_sub_vec:
+    case INDEX_op_mul_vec:
+    case INDEX_op_and_vec:
+    case INDEX_op_or_vec:
+    case INDEX_op_xor_vec:
+    case INDEX_op_andc_vec:
+    case INDEX_op_orc_vec:
+    case INDEX_op_cmp_vec:
+    case INDEX_op_ssadd_vec:
+    case INDEX_op_sssub_vec:
+    case INDEX_op_usadd_vec:
+    case INDEX_op_ussub_vec:
+    case INDEX_op_smax_vec:
+    case INDEX_op_smin_vec:
+    case INDEX_op_umax_vec:
+    case INDEX_op_umin_vec:
+        return &v_v_v;
+    case INDEX_op_not_vec:
+    case INDEX_op_dup_vec:
+        return &v_v;
+    case INDEX_op_ld_vec:
+    case INDEX_op_st_vec:
+        return &v_r;
+
     default:
         return NULL;
     }
@@ -2807,9 +3261,16 @@ static void tcg_target_init(TCGContext *s)
         have_isa_3_00 = true;
     }
 #endif
+    if ((hwcap & PPC_FEATURE_HAS_VSX) && (hwcap2 & PPC_FEATURE2_ARCH_2_07)) {
+        have_isa_2_07_vsx = true;
+    }
 
     tcg_target_available_regs[TCG_TYPE_I32] = 0xffffffff;
     tcg_target_available_regs[TCG_TYPE_I64] = 0xffffffff;
+    if (have_isa_2_07_vsx) {
+        tcg_target_available_regs[TCG_TYPE_V64] = 0xffffffff00000000ull;
+        tcg_target_available_regs[TCG_TYPE_V128] = 0xffffffff00000000ull;
+    }
 
     tcg_target_call_clobber_regs = 0;
     tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R0);
@@ -2825,6 +3286,27 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R11);
     tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R12);
 
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V0);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V1);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V2);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V3);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V4);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V5);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V6);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V7);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V8);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V9);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V10);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V11);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V12);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V13);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V14);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V15);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V16);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V17);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V18);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V19);
+
     s->reserved_regs = 0;
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_R0); /* tcg temp */
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_R1); /* stack pointer */
@@ -2835,6 +3317,8 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_R13); /* thread pointer */
 #endif
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP1); /* mem temp */
+    tcg_regset_set_reg(s->reserved_regs, TCG_VEC_TMP1);
+    tcg_regset_set_reg(s->reserved_regs, TCG_VEC_TMP2);
     if (USE_REG_TB) {
         tcg_regset_set_reg(s->reserved_regs, TCG_REG_TB);  /* tb->tc_ptr */
     }
-- 
2.17.2
