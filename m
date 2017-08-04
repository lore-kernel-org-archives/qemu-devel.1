Received: from eggs.gnu.org ([2001:4830:134:3::10]:51595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddW17-0003Yl-LG
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 02:23:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddW15-0005Tk-RS
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 02:23:25 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ddW15-0005St-Jl
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 02:23:23 -0400
Received: by mail-pf0-x244.google.com with SMTP id c65so958053pfl.0
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 23:23:23 -0700 (PDT)
Received: from bigtime.twiddle.net (97-126-108-236.tukw.qwest.net.
	[97.126.108.236]) by smtp.gmail.com with ESMTPSA id
	q199sm1335819pfq.135.2017.08.03.23.23.21 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 03 Aug 2017 23:23:21 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  3 Aug 2017 23:23:13 -0700
Message-Id: <20170804062314.12594-6-rth@twiddle.net>
In-Reply-To: <20170804062314.12594-1-rth@twiddle.net>
References: <20170804062314.12594-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH for-2.11 5/6] tcg/i386: Use pext for extract
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
 tcg/i386/tcg-target.h     |   6 +-
 tcg/i386/tcg-target.inc.c | 147 +++++++++++++++++++++++++++++++++-------------
 2 files changed, 109 insertions(+), 44 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index b89dababf4..85b0ccd98c 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -76,6 +76,7 @@ typedef enum {
 #endif
 
 extern bool have_bmi1;
+extern bool have_bmi2;
 extern bool have_popcnt;
 
 /* optional instructions */
@@ -153,9 +154,10 @@ extern bool have_popcnt;
 
 /* Check for the possibility of high-byte extraction and, for 64-bit,
    zero-extending 32-bit right-shift.  */
-#define TCG_TARGET_extract_i32_valid(ofs, len) ((ofs) == 8 && (len) == 8)
+#define TCG_TARGET_extract_i32_valid(ofs, len) \
+    (have_bmi2 || ((ofs) == 8 && (len) == 8))
 #define TCG_TARGET_extract_i64_valid(ofs, len) \
-    (((ofs) == 8 && (len) == 8) || ((ofs) + (len)) == 32)
+    (have_bmi2 || ((ofs) == 8 && (len) == 8) || ((ofs) + (len)) == 32)
 
 #if TCG_TARGET_REG_BITS == 64
 # define TCG_AREG0 TCG_REG_R14
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 5231056fd3..69587c82de 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -124,11 +124,11 @@ static bool have_cmov;
 /* We need these symbols in tcg-target.h, and we can't properly conditionalize
    it there.  Therefore we always define the variable.  */
 bool have_bmi1;
+bool have_bmi2;
 bool have_popcnt;
 
 #ifdef CONFIG_CPUID_H
 static bool have_movbe;
-static bool have_bmi2;
 static bool have_lzcnt;
 #else
 # define have_movbe 0
@@ -275,13 +275,14 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 
 #define P_EXT		0x100		/* 0x0f opcode prefix */
 #define P_EXT38         0x200           /* 0x0f 0x38 opcode prefix */
-#define P_DATA16        0x400           /* 0x66 opcode prefix */
+#define P_EXT3A         0x400           /* 0x0f 0x3a opcode prefix */
+#define P_DATA16        0x800           /* 0x66 opcode prefix */
 #if TCG_TARGET_REG_BITS == 64
-# define P_ADDR32       0x800           /* 0x67 opcode prefix */
-# define P_REXW         0x1000          /* Set REX.W = 1 */
-# define P_REXB_R       0x2000          /* REG field as byte register */
-# define P_REXB_RM      0x4000          /* R/M field as byte register */
-# define P_GS           0x8000          /* gs segment override */
+# define P_ADDR32       0x1000          /* 0x67 opcode prefix */
+# define P_REXW         0x2000          /* Set REX.W = 1 */
+# define P_REXB_R       0x4000          /* REG field as byte register */
+# define P_REXB_RM      0x8000          /* R/M field as byte register */
+# define P_GS           0x10000         /* gs segment override */
 #else
 # define P_ADDR32	0
 # define P_REXW		0
@@ -289,14 +290,15 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 # define P_REXB_RM	0
 # define P_GS           0
 #endif
-#define P_SIMDF3        0x10000         /* 0xf3 opcode prefix */
-#define P_SIMDF2        0x20000         /* 0xf2 opcode prefix */
+#define P_SIMDF3        0x20000         /* 0xf3 opcode prefix */
+#define P_SIMDF2        0x40000         /* 0xf2 opcode prefix */
 
 #define OPC_ARITH_EvIz	(0x81)
 #define OPC_ARITH_EvIb	(0x83)
 #define OPC_ARITH_GvEv	(0x03)		/* ... plus (ARITH_FOO << 3) */
 #define OPC_ANDN        (0xf2 | P_EXT38)
 #define OPC_ADD_GvEv	(OPC_ARITH_GvEv | (ARITH_ADD << 3))
+#define OPC_BEXTR       (0xf7 | P_EXT38)
 #define OPC_BSF         (0xbc | P_EXT)
 #define OPC_BSR         (0xbd | P_EXT)
 #define OPC_BSWAP	(0xc8 | P_EXT)
@@ -327,12 +329,14 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_MOVSLQ	(0x63 | P_REXW)
 #define OPC_MOVZBL	(0xb6 | P_EXT)
 #define OPC_MOVZWL	(0xb7 | P_EXT)
+#define OPC_PEXT        (0xf5 | P_EXT38 | P_SIMDF3)
 #define OPC_POP_r32	(0x58)
 #define OPC_POPCNT      (0xb8 | P_EXT | P_SIMDF3)
 #define OPC_PUSH_r32	(0x50)
 #define OPC_PUSH_Iv	(0x68)
 #define OPC_PUSH_Ib	(0x6a)
 #define OPC_RET		(0xc3)
+#define OPC_RORX        (0xf0 | P_EXT3A | P_SIMDF2)
 #define OPC_SETCC	(0x90 | P_EXT | P_REXB_RM) /* ... plus cc */
 #define OPC_SHIFT_1	(0xd1)
 #define OPC_SHIFT_Ib	(0xc1)
@@ -455,6 +459,8 @@ static void tcg_out_opc(TCGContext *s, int opc, int r, int rm, int x)
         tcg_out8(s, 0x0f);
         if (opc & P_EXT38) {
             tcg_out8(s, 0x38);
+        } else if (opc & P_EXT3A) {
+            tcg_out8(s, 0x3a);
         }
     }
 
@@ -475,6 +481,8 @@ static void tcg_out_opc(TCGContext *s, int opc)
         tcg_out8(s, 0x0f);
         if (opc & P_EXT38) {
             tcg_out8(s, 0x38);
+        } else if (opc & P_EXT3A) {
+            tcg_out8(s, 0x3a);
         }
     }
     tcg_out8(s, opc);
@@ -491,34 +499,29 @@ static void tcg_out_modrm(TCGContext *s, int opc, int r, int rm)
     tcg_out8(s, 0xc0 | (LOWREGMASK(r) << 3) | LOWREGMASK(rm));
 }
 
-static void tcg_out_vex_modrm(TCGContext *s, int opc, int r, int v, int rm)
+static void tcg_out_vex_pfx_opc(TCGContext *s, int opc, int r, int v, int rm)
 {
     int tmp;
 
-    if ((opc & (P_REXW | P_EXT | P_EXT38)) || (rm & 8)) {
-        /* Three byte VEX prefix.  */
-        tcg_out8(s, 0xc4);
-
-        /* VEX.m-mmmm */
-        if (opc & P_EXT38) {
-            tmp = 2;
-        } else if (opc & P_EXT) {
-            tmp = 1;
-        } else {
-            tcg_abort();
-        }
-        tmp |= 0x40;                       /* VEX.X */
-        tmp |= (r & 8 ? 0 : 0x80);         /* VEX.R */
-        tmp |= (rm & 8 ? 0 : 0x20);        /* VEX.B */
-        tcg_out8(s, tmp);
+    /* Three byte VEX prefix.  */
+    tcg_out8(s, 0xc4);
 
-        tmp = (opc & P_REXW ? 0x80 : 0);   /* VEX.W */
+    /* VEX.m-mmmm */
+    if (opc & P_EXT3A) {
+        tmp = 3;
+    } else if (opc & P_EXT38) {
+        tmp = 2;
+    } else if (opc & P_EXT) {
+        tmp = 1;
     } else {
-        /* Two byte VEX prefix.  */
-        tcg_out8(s, 0xc5);
-
-        tmp = (r & 8 ? 0 : 0x80);          /* VEX.R */
+        tcg_abort();
     }
+    tmp |= 0x40;                           /* VEX.X */
+    tmp |= (r & 8 ? 0 : 0x80);             /* VEX.R */
+    tmp |= (rm & 8 ? 0 : 0x20);            /* VEX.B */
+    tcg_out8(s, tmp);
+
+    tmp = (opc & P_REXW ? 0x80 : 0);       /* VEX.W */
     /* VEX.pp */
     if (opc & P_DATA16) {
         tmp |= 1;                          /* 0x66 */
@@ -530,9 +533,43 @@ static void tcg_out_vex_modrm(TCGContext *s, int opc, int r, int v, int rm)
     tmp |= (~v & 15) << 3;                 /* VEX.vvvv */
     tcg_out8(s, tmp);
     tcg_out8(s, opc);
+}
+
+static void tcg_out_vex_modrm(TCGContext *s, int opc, int r, int v, int rm)
+{
+    tcg_out_vex_pfx_opc(s, opc, r, v, rm);
     tcg_out8(s, 0xc0 | (LOWREGMASK(r) << 3) | LOWREGMASK(rm));
 }
 
+static void tcg_out_sfx_pool_imm(TCGContext *s, int r, tcg_target_ulong data)
+{
+    /* modrm for 64-bit rip-relative, or 32-bit absolute addressing.  */
+    tcg_out8(s, (LOWREGMASK(r) << 3) | 5);
+
+    if (TCG_TARGET_REG_BITS == 64) {
+        new_pool_label(s, data, R_386_PC32, s->code_ptr, -4);
+    } else {
+        new_pool_label(s, data, R_386_32, s->code_ptr, 0);
+    }
+    tcg_out32(s, 0);
+}
+
+#if 0
+static void tcg_out_opc_pool_imm(TCGContext *s, int opc, int r,
+                                 tcg_target_ulong data)
+{
+    tcg_out_opc(s, opc, r, 0, 0);
+    tcg_out_sfx_pool_imm(s, r, data);
+}
+#endif
+
+static void tcg_out_vex_pool_imm(TCGContext *s, int opc, int r, int v,
+                                 tcg_target_ulong data)
+{
+    tcg_out_vex_pfx_opc(s, opc, r, v, 0);
+    tcg_out_sfx_pool_imm(s, r, data);
+}
+
 /* Output an opcode with a full "rm + (index<<shift) + offset" address mode.
    We handle either RM and INDEX missing with a negative value.  In 64-bit
    mode for absolute addresses, ~RM is the size of the immediate operand
@@ -877,6 +914,13 @@ static void tcg_out_addi(TCGContext *s, int reg, tcg_target_long val)
     }
 }
 
+static void tcg_out_rorx(TCGContext *s, int rexw,
+                         TCGReg dst, TCGReg src, int c)
+{
+    tcg_out_vex_modrm(s, OPC_RORX + rexw, dst, 0, src);
+    tcg_out8(s, c);
+}
+
 /* Use SMALL != 0 to force a short forward branch.  */
 static void tcg_out_jxx(TCGContext *s, int opc, TCGLabel *l, int small)
 {
@@ -1858,7 +1902,7 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is64)
 static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
                               const TCGArg *args, const int *const_args)
 {
-    TCGArg a0, a1, a2;
+    TCGArg a0, a1, a2, a3;
     int c, const_a2, vexop, rexw = 0;
 
 #if TCG_TARGET_REG_BITS == 64
@@ -2244,12 +2288,18 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         /* On the off-chance that we can use the high-byte registers.
            Otherwise we emit the same ext16 + shift pattern that we
            would have gotten from the normal tcg-op.c expansion.  */
-        tcg_debug_assert(a2 == 8 && args[3] == 8);
-        if (a1 < 4 && a0 < 8) {
-            tcg_out_modrm(s, OPC_MOVZBL, a0, a1 + 4);
+        a3 = args[3];
+        if (a2 == 8 && a3 == 8) {
+            if (a1 < 4 && a0 < 8) {
+                tcg_out_modrm(s, OPC_MOVZBL, a0, a1 + 4);
+            } else {
+                tcg_out_ext16u(s, a0, a1);
+                tcg_out_shifti(s, SHIFT_SHR, a0, 8);
+            }
         } else {
-            tcg_out_ext16u(s, a0, a1);
-            tcg_out_shifti(s, SHIFT_SHR, a0, 8);
+            tcg_debug_assert(have_bmi2);
+            tcg_out_vex_pool_imm(s, OPC_PEXT + (a2 + a3 > 32) * P_REXW,
+                                 a0, a1, deposit64(0, a2, a3, -1));
         }
         break;
 
@@ -2257,12 +2307,25 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         /* We don't implement sextract_i64, as we cannot sign-extend to
            64-bits without using the REX prefix that explicitly excludes
            access to the high-byte registers.  */
-        tcg_debug_assert(a2 == 8 && args[3] == 8);
-        if (a1 < 4 && a0 < 8) {
-            tcg_out_modrm(s, OPC_MOVSBL, a0, a1 + 4);
+        a3 = args[3];
+        if (a2 == 8 && a3 == 8) {
+            if (a1 < 4 && a0 < 8) {
+                tcg_out_modrm(s, OPC_MOVSBL, a0, a1 + 4);
+            } else {
+                tcg_out_ext16s(s, a0, a1, 0);
+                tcg_out_shifti(s, SHIFT_SAR, a0, 8);
+            }
         } else {
-            tcg_out_ext16s(s, a0, a1, 0);
-            tcg_out_shifti(s, SHIFT_SAR, a0, 8);
+            /* ??? We only have one extract_i32_valid macro.  But as it
+               happens we can perform a useful 3-operand shift.  */
+            tcg_debug_assert(have_bmi2);
+            if (a2 + a3 < 32) {
+                /* Rotate the field in A1 to the MSB of A0.  */
+                tcg_out_rorx(s, 0, a0, a1, a2 + a3);
+            } else {
+                tcg_out_mov(s, TCG_TYPE_I32, a0, a1);
+            }
+            tcg_out_shifti(s, SHIFT_SAR, a0, 32 - a3);
         }
         break;
 
-- 
2.13.3
