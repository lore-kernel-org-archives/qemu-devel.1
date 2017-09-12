Received: from eggs.gnu.org ([2001:4830:134:3::10]:38203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dro0J-0001vG-Oi
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dro0G-0007Au-Tf
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:39 -0400
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:33743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dro0G-0007AM-KH
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:36 -0400
Received: by mail-pg0-x22c.google.com with SMTP id u18so5584034pgo.0
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 09:25:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 12 Sep 2017 09:25:11 -0700
Message-Id: <20170912162513.21694-15-richard.henderson@linaro.org>
In-Reply-To: <20170912162513.21694-1-richard.henderson@linaro.org>
References: <20170912162513.21694-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 14/16] tcg: Remove tcg_regset_set32
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

It's not even clear what the interface REG and VAL32 were supposed to mean.
All uses had REG = 0 and VAL32 was the bitset assigned to the destination.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.h                    |  1 -
 tcg/aarch64/tcg-target.inc.c | 33 +++++++++++++++---------------
 tcg/arm/tcg-target.inc.c     | 23 +++++++++++----------
 tcg/i386/tcg-target.inc.c    | 34 ++++++++++---------------------
 tcg/ppc/tcg-target.inc.c     | 37 +++++++++++++++++-----------------
 tcg/s390/tcg-target.inc.c    | 14 ++++++-------
 tcg/sparc/tcg-target.inc.c   | 48 ++++++++++++++++++++++----------------------
 tcg/tci/tcg-target.inc.c     | 11 ++++------
 8 files changed, 94 insertions(+), 107 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 8b4208ea03..d4412102ba 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -210,7 +210,6 @@ typedef enum TCGOpcode {
     NB_OPS,
 } TCGOpcode;
 
-#define tcg_regset_set32(d, reg, val32) (d) |= (val32) << (reg)
 #define tcg_regset_set_reg(d, r) (d) |= 1L << (r)
 #define tcg_regset_reset_reg(d, r) (d) &= ~(1L << (r))
 #define tcg_regset_test_reg(d, r) (((d) >> (r)) & 1)
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 141a86a57d..150530f30e 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -121,11 +121,11 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
     switch (*ct_str++) {
     case 'r':
         ct->ct |= TCG_CT_REG;
-        tcg_regset_set32(ct->u.regs, 0, (1ULL << TCG_TARGET_NB_REGS) - 1);
+        ct->u.regs = 0xffffffffu;
         break;
     case 'l': /* qemu_ld / qemu_st address, data_reg */
         ct->ct |= TCG_CT_REG;
-        tcg_regset_set32(ct->u.regs, 0, (1ULL << TCG_TARGET_NB_REGS) - 1);
+        ct->u.regs = 0xffffffffu;
 #ifdef CONFIG_SOFTMMU
         /* x0 and x1 will be overwritten when reading the tlb entry,
            and x2, and x3 for helper args, better to avoid using them. */
@@ -1945,20 +1945,21 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
 
 static void tcg_target_init(TCGContext *s)
 {
-    tcg_regset_set32(tcg_target_available_regs[TCG_TYPE_I32], 0, 0xffffffff);
-    tcg_regset_set32(tcg_target_available_regs[TCG_TYPE_I64], 0, 0xffffffff);
-
-    tcg_regset_set32(tcg_target_call_clobber_regs, 0,
-                     (1 << TCG_REG_X0) | (1 << TCG_REG_X1) |
-                     (1 << TCG_REG_X2) | (1 << TCG_REG_X3) |
-                     (1 << TCG_REG_X4) | (1 << TCG_REG_X5) |
-                     (1 << TCG_REG_X6) | (1 << TCG_REG_X7) |
-                     (1 << TCG_REG_X8) | (1 << TCG_REG_X9) |
-                     (1 << TCG_REG_X10) | (1 << TCG_REG_X11) |
-                     (1 << TCG_REG_X12) | (1 << TCG_REG_X13) |
-                     (1 << TCG_REG_X14) | (1 << TCG_REG_X15) |
-                     (1 << TCG_REG_X16) | (1 << TCG_REG_X17) |
-                     (1 << TCG_REG_X18) | (1 << TCG_REG_X30));
+    tcg_target_available_regs[TCG_TYPE_I32] = 0xffffffffu;
+    tcg_target_available_regs[TCG_TYPE_I64] = 0xffffffffu;
+
+    tcg_target_call_clobber_regs = 0xfffffffu;
+    tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_X19);
+    tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_X20);
+    tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_X21);
+    tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_X22);
+    tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_X23);
+    tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_X24);
+    tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_X25);
+    tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_X26);
+    tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_X27);
+    tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_X28);
+    tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_X29);
 
     s->reserved_regs = 0;
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_SP);
diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index f0c176554b..14599a8685 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -264,13 +264,13 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
 
     case 'r':
         ct->ct |= TCG_CT_REG;
-        tcg_regset_set32(ct->u.regs, 0, (1 << TCG_TARGET_NB_REGS) - 1);
+        ct->u.regs = 0xffff;
         break;
 
     /* qemu_ld address */
     case 'l':
         ct->ct |= TCG_CT_REG;
-        tcg_regset_set32(ct->u.regs, 0, (1 << TCG_TARGET_NB_REGS) - 1);
+        ct->u.regs = 0xffff;
 #ifdef CONFIG_SOFTMMU
         /* r0-r2,lr will be overwritten when reading the tlb entry,
            so don't use these. */
@@ -284,7 +284,7 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
     /* qemu_st address & data */
     case 's':
         ct->ct |= TCG_CT_REG;
-        tcg_regset_set32(ct->u.regs, 0, (1 << TCG_TARGET_NB_REGS) - 1);
+        ct->u.regs = 0xffff;
         /* r0-r2 will be overwritten when reading the tlb entry (softmmu only)
            and r0-r1 doing the byte swapping, so don't use these. */
         tcg_regset_reset_reg(ct->u.regs, TCG_REG_R0);
@@ -2164,14 +2164,15 @@ static void tcg_target_init(TCGContext *s)
         }
     }
 
-    tcg_regset_set32(tcg_target_available_regs[TCG_TYPE_I32], 0, 0xffff);
-    tcg_regset_set32(tcg_target_call_clobber_regs, 0,
-                     (1 << TCG_REG_R0) |
-                     (1 << TCG_REG_R1) |
-                     (1 << TCG_REG_R2) |
-                     (1 << TCG_REG_R3) |
-                     (1 << TCG_REG_R12) |
-                     (1 << TCG_REG_R14));
+    tcg_target_available_regs[TCG_TYPE_I32] = 0xffff;
+
+    tcg_target_call_clobber_regs = 0;
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R0);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R1);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R2);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R3);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R12);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R14);
 
     s->reserved_regs = 0;
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_CALL_STACK);
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index e9766f6686..feb490019b 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -213,25 +213,17 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
     case 'q':
         /* A register that can be used as a byte operand.  */
         ct->ct |= TCG_CT_REG;
-        if (TCG_TARGET_REG_BITS == 64) {
-            tcg_regset_set32(ct->u.regs, 0, 0xffff);
-        } else {
-            tcg_regset_set32(ct->u.regs, 0, 0xf);
-        }
+        ct->u.regs = TCG_TARGET_REG_BITS == 64 ? 0xffff : 0xf;
         break;
     case 'Q':
         /* A register with an addressable second byte (e.g. %ah).  */
         ct->ct |= TCG_CT_REG;
-        tcg_regset_set32(ct->u.regs, 0, 0xf);
+        ct->u.regs = 0xf;
         break;
     case 'r':
         /* A general register.  */
         ct->ct |= TCG_CT_REG;
-        if (TCG_TARGET_REG_BITS == 64) {
-            tcg_regset_set32(ct->u.regs, 0, 0xffff);
-        } else {
-            tcg_regset_set32(ct->u.regs, 0, 0xff);
-        }
+        ct->u.regs = TCG_TARGET_REG_BITS == 64 ? 0xffff : 0xff;
         break;
     case 'W':
         /* With TZCNT/LZCNT, we can have operand-size as an input.  */
@@ -240,17 +232,13 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
     case 'x':
         /* A vector register.  */
         ct->ct |= TCG_CT_REG;
-        tcg_regset_set32(ct->u.regs, 0, 0xff0000);
+        ct->u.regs = 0xff0000;
         break;
 
         /* qemu_ld/st address constraint */
     case 'L':
         ct->ct |= TCG_CT_REG;
-        if (TCG_TARGET_REG_BITS == 64) {
-            tcg_regset_set32(ct->u.regs, 0, 0xffff);
-        } else {
-            tcg_regset_set32(ct->u.regs, 0, 0xff);
-        }
+        ct->u.regs = TCG_TARGET_REG_BITS == 64 ? 0xffff : 0xff;
         tcg_regset_reset_reg(ct->u.regs, TCG_REG_L0);
         tcg_regset_reset_reg(ct->u.regs, TCG_REG_L1);
         break;
@@ -2986,17 +2974,17 @@ static void tcg_target_init(TCGContext *s)
 #endif /* CONFIG_CPUID_H */
 
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_regset_set32(tcg_target_available_regs[TCG_TYPE_I32], 0, 0xffff);
-        tcg_regset_set32(tcg_target_available_regs[TCG_TYPE_I64], 0, 0xffff);
+        tcg_target_available_regs[TCG_TYPE_I32] = 0xffff;
+        tcg_target_available_regs[TCG_TYPE_I64] = 0xffff;
     } else {
-        tcg_regset_set32(tcg_target_available_regs[TCG_TYPE_I32], 0, 0xff);
+        tcg_target_available_regs[TCG_TYPE_I32] = 0xff;
     }
     if (have_sse2) {
-        tcg_regset_set32(tcg_target_available_regs[TCG_TYPE_V64], 0, 0xff0000);
-        tcg_regset_set32(tcg_target_available_regs[TCG_TYPE_V128], 0, 0xff0000);
+        tcg_target_available_regs[TCG_TYPE_V64] = 0xff0000;
+        tcg_target_available_regs[TCG_TYPE_V128] = 0xff0000;
     }
     if (have_avx2) {
-        tcg_regset_set32(tcg_target_available_regs[TCG_TYPE_V256], 0, 0xff0000);
+        tcg_target_available_regs[TCG_TYPE_V256] = 0xff0000;
     }
 
     tcg_target_call_clobber_regs = 0;
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index b1df1e146a..4212cba5fd 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -260,11 +260,11 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
         break;
     case 'r':
         ct->ct |= TCG_CT_REG;
-        tcg_regset_set32(ct->u.regs, 0, 0xffffffff);
+        ct->u.regs = 0xffffffff;
         break;
     case 'L':                   /* qemu_ld constraint */
         ct->ct |= TCG_CT_REG;
-        tcg_regset_set32(ct->u.regs, 0, 0xffffffff);
+        ct->u.regs = 0xffffffff;
         tcg_regset_reset_reg(ct->u.regs, TCG_REG_R3);
 #ifdef CONFIG_SOFTMMU
         tcg_regset_reset_reg(ct->u.regs, TCG_REG_R4);
@@ -273,7 +273,7 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
         break;
     case 'S':                   /* qemu_st constraint */
         ct->ct |= TCG_CT_REG;
-        tcg_regset_set32(ct->u.regs, 0, 0xffffffff);
+        ct->u.regs = 0xffffffff;
         tcg_regset_reset_reg(ct->u.regs, TCG_REG_R3);
 #ifdef CONFIG_SOFTMMU
         tcg_regset_reset_reg(ct->u.regs, TCG_REG_R4);
@@ -2770,21 +2770,22 @@ static void tcg_target_init(TCGContext *s)
     }
 #endif
 
-    tcg_regset_set32(tcg_target_available_regs[TCG_TYPE_I32], 0, 0xffffffff);
-    tcg_regset_set32(tcg_target_available_regs[TCG_TYPE_I64], 0, 0xffffffff);
-    tcg_regset_set32(tcg_target_call_clobber_regs, 0,
-                     (1 << TCG_REG_R0) |
-                     (1 << TCG_REG_R2) |
-                     (1 << TCG_REG_R3) |
-                     (1 << TCG_REG_R4) |
-                     (1 << TCG_REG_R5) |
-                     (1 << TCG_REG_R6) |
-                     (1 << TCG_REG_R7) |
-                     (1 << TCG_REG_R8) |
-                     (1 << TCG_REG_R9) |
-                     (1 << TCG_REG_R10) |
-                     (1 << TCG_REG_R11) |
-                     (1 << TCG_REG_R12));
+    tcg_target_available_regs[TCG_TYPE_I32] = 0xffffffff;
+    tcg_target_available_regs[TCG_TYPE_I64] = 0xffffffff;
+
+    tcg_target_call_clobber_regs = 0;
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R0);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R2);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R3);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R4);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R5);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R6);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R7);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R8);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R9);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R10);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R11);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R12);
 
     s->reserved_regs = 0;
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_R0); /* tcg temp */
diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index 01baa33673..38a7cdab75 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -402,14 +402,14 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
     switch (*ct_str++) {
     case 'r':                  /* all registers */
         ct->ct |= TCG_CT_REG;
-        tcg_regset_set32(ct->u.regs, 0, 0xffff);
+        ct->u.regs = 0xffff;
         break;
     case 'L':                  /* qemu_ld/st constraint */
         ct->ct |= TCG_CT_REG;
-        tcg_regset_set32(ct->u.regs, 0, 0xffff);
-        tcg_regset_reset_reg (ct->u.regs, TCG_REG_R2);
-        tcg_regset_reset_reg (ct->u.regs, TCG_REG_R3);
-        tcg_regset_reset_reg (ct->u.regs, TCG_REG_R4);
+        ct->u.regs = 0xffff;
+        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R2);
+        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R3);
+        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R4);
         break;
     case 'a':                  /* force R2 for division */
         ct->ct |= TCG_CT_REG;
@@ -2519,8 +2519,8 @@ static void tcg_target_init(TCGContext *s)
 {
     query_s390_facilities();
 
-    tcg_regset_set32(tcg_target_available_regs[TCG_TYPE_I32], 0, 0xffff);
-    tcg_regset_set32(tcg_target_available_regs[TCG_TYPE_I64], 0, 0xffff);
+    tcg_target_available_regs[TCG_TYPE_I32] = 0xffff;
+    tcg_target_available_regs[TCG_TYPE_I64] = 0xffff;
 
     tcg_target_call_clobber_regs = 0;
     tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R0);
diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
index ccd83205d5..1da4debbaf 100644
--- a/tcg/sparc/tcg-target.inc.c
+++ b/tcg/sparc/tcg-target.inc.c
@@ -343,16 +343,15 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
     switch (*ct_str++) {
     case 'r':
         ct->ct |= TCG_CT_REG;
-        tcg_regset_set32(ct->u.regs, 0, 0xffffffff);
+        ct->u.regs = 0xffffffff;
         break;
     case 'R':
         ct->ct |= TCG_CT_REG;
-        tcg_regset_set32(ct->u.regs, 0, ALL_64);
+        ct->u.regs = ALL_64;
         break;
     case 'A': /* qemu_ld/st address constraint */
         ct->ct |= TCG_CT_REG;
-        tcg_regset_set32(ct->u.regs, 0,
-                         TARGET_LONG_BITS == 64 ? ALL_64 : 0xffffffff);
+        ct->u.regs = TARGET_LONG_BITS == 64 ? ALL_64 : 0xffffffff;
     reserve_helpers:
         tcg_regset_reset_reg(ct->u.regs, TCG_REG_O0);
         tcg_regset_reset_reg(ct->u.regs, TCG_REG_O1);
@@ -360,11 +359,11 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
         break;
     case 's': /* qemu_st data 32-bit constraint */
         ct->ct |= TCG_CT_REG;
-        tcg_regset_set32(ct->u.regs, 0, 0xffffffff);
+        ct->u.regs = 0xffffffff;
         goto reserve_helpers;
     case 'S': /* qemu_st data 64-bit constraint */
         ct->ct |= TCG_CT_REG;
-        tcg_regset_set32(ct->u.regs, 0, ALL_64);
+        ct->u.regs = ALL_64;
         goto reserve_helpers;
     case 'I':
         ct->ct |= TCG_CT_CONST_S11;
@@ -1752,24 +1751,25 @@ static void tcg_target_init(TCGContext *s)
     }
 #endif
 
-    tcg_regset_set32(tcg_target_available_regs[TCG_TYPE_I32], 0, 0xffffffff);
-    tcg_regset_set32(tcg_target_available_regs[TCG_TYPE_I64], 0, ALL_64);
-
-    tcg_regset_set32(tcg_target_call_clobber_regs, 0,
-                     (1 << TCG_REG_G1) |
-                     (1 << TCG_REG_G2) |
-                     (1 << TCG_REG_G3) |
-                     (1 << TCG_REG_G4) |
-                     (1 << TCG_REG_G5) |
-                     (1 << TCG_REG_G6) |
-                     (1 << TCG_REG_G7) |
-                     (1 << TCG_REG_O0) |
-                     (1 << TCG_REG_O1) |
-                     (1 << TCG_REG_O2) |
-                     (1 << TCG_REG_O3) |
-                     (1 << TCG_REG_O4) |
-                     (1 << TCG_REG_O5) |
-                     (1 << TCG_REG_O7));
+    tcg_target_available_regs[TCG_TYPE_I32] = 0xffffffff;
+    tcg_target_available_regs[TCG_TYPE_I64] = ALL_64;
+
+    tcg_target_call_clobber_regs = 0;
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_G1);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_G2);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_G3);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_G4);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_G5);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_G6);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_G7);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_O0);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_O1);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_O2);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_O3);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_O4);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_O5);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_O6);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_O7);
 
     s->reserved_regs = 0;
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_G0); /* zero */
diff --git a/tcg/tci/tcg-target.inc.c b/tcg/tci/tcg-target.inc.c
index f9644334cc..913c3802a3 100644
--- a/tcg/tci/tcg-target.inc.c
+++ b/tcg/tci/tcg-target.inc.c
@@ -390,7 +390,7 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
     case 'L':                   /* qemu_ld constraint */
     case 'S':                   /* qemu_st constraint */
         ct->ct |= TCG_CT_REG;
-        tcg_regset_set32(ct->u.regs, 0, BIT(TCG_TARGET_NB_REGS) - 1);
+        ct->u.regs = BIT(TCG_TARGET_NB_REGS) - 1;
         break;
     default:
         return NULL;
@@ -870,14 +870,11 @@ static void tcg_target_init(TCGContext *s)
     tcg_debug_assert(tcg_op_defs_max <= UINT8_MAX);
 
     /* Registers available for 32 bit operations. */
-    tcg_regset_set32(tcg_target_available_regs[TCG_TYPE_I32], 0,
-                     BIT(TCG_TARGET_NB_REGS) - 1);
+    tcg_target_available_regs[TCG_TYPE_I32] = BIT(TCG_TARGET_NB_REGS) - 1;
     /* Registers available for 64 bit operations. */
-    tcg_regset_set32(tcg_target_available_regs[TCG_TYPE_I64], 0,
-                     BIT(TCG_TARGET_NB_REGS) - 1);
+    tcg_target_available_regs[TCG_TYPE_I64] = BIT(TCG_TARGET_NB_REGS) - 1;
     /* TODO: Which registers should be set here? */
-    tcg_regset_set32(tcg_target_call_clobber_regs, 0,
-                     BIT(TCG_TARGET_NB_REGS) - 1);
+    tcg_target_call_clobber_regs = BIT(TCG_TARGET_NB_REGS) - 1;
 
     s->reserved_regs = 0;
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_CALL_STACK);
-- 
2.13.5
