Received: from eggs.gnu.org ([2001:4830:134:3::10]:52551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dtb8z-00082B-AQ
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:06:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dtb8v-0008DI-UP
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:06:01 -0400
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:45116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dtb8v-0008CY-Mw
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:05:57 -0400
Received: by mail-oi0-x230.google.com with SMTP id z73so3685527oia.2
	for <qemu-devel@nongnu.org>; Sun, 17 Sep 2017 08:05:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 17 Sep 2017 08:05:27 -0700
Message-Id: <20170917150535.8284-10-richard.henderson@linaro.org>
In-Reply-To: <20170917150535.8284-1-richard.henderson@linaro.org>
References: <20170917150535.8284-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/17] tcg: Remove tcg_regset_set
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

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.h                 |  1 -
 tcg/mips/tcg-target.inc.c | 47 ++++++++++++++++++++++++-----------------------
 tcg/tcg.c                 |  8 ++++----
 3 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 6525e51c21..5bf67678d5 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -186,7 +186,6 @@ typedef enum TCGOpcode {
     NB_OPS,
 } TCGOpcode;
 
-#define tcg_regset_set(d, s) (d) = (s)
 #define tcg_regset_set32(d, reg, val32) (d) |= (val32) << (reg)
 #define tcg_regset_set_reg(d, r) (d) |= 1L << (r)
 #define tcg_regset_reset_reg(d, r) (d) &= ~(1L << (r))
diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index 85c1abd14b..1c09ec7d5b 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -195,11 +195,11 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
     switch(*ct_str++) {
     case 'r':
         ct->ct |= TCG_CT_REG;
-        tcg_regset_set(ct->u.regs, 0xffffffff);
+        ct->u.regs = 0xffffffff;
         break;
     case 'L': /* qemu_ld input arg constraint */
         ct->ct |= TCG_CT_REG;
-        tcg_regset_set(ct->u.regs, 0xffffffff);
+        ct->u.regs = 0xffffffff;
         tcg_regset_reset_reg(ct->u.regs, TCG_REG_A0);
 #if defined(CONFIG_SOFTMMU)
         if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
@@ -209,7 +209,7 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
         break;
     case 'S': /* qemu_st constraint */
         ct->ct |= TCG_CT_REG;
-        tcg_regset_set(ct->u.regs, 0xffffffff);
+        ct->u.regs = 0xffffffff;
         tcg_regset_reset_reg(ct->u.regs, TCG_REG_A0);
 #if defined(CONFIG_SOFTMMU)
         if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
@@ -2607,27 +2607,28 @@ static void tcg_target_qemu_prologue(TCGContext *s)
 static void tcg_target_init(TCGContext *s)
 {
     tcg_target_detect_isa();
-    tcg_regset_set(tcg_target_available_regs[TCG_TYPE_I32], 0xffffffff);
+    tcg_target_available_regs[TCG_TYPE_I32] = 0xffffffff;
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_regset_set(tcg_target_available_regs[TCG_TYPE_I64], 0xffffffff);
-    }
-    tcg_regset_set(tcg_target_call_clobber_regs,
-                   (1 << TCG_REG_V0) |
-                   (1 << TCG_REG_V1) |
-                   (1 << TCG_REG_A0) |
-                   (1 << TCG_REG_A1) |
-                   (1 << TCG_REG_A2) |
-                   (1 << TCG_REG_A3) |
-                   (1 << TCG_REG_T0) |
-                   (1 << TCG_REG_T1) |
-                   (1 << TCG_REG_T2) |
-                   (1 << TCG_REG_T3) |
-                   (1 << TCG_REG_T4) |
-                   (1 << TCG_REG_T5) |
-                   (1 << TCG_REG_T6) |
-                   (1 << TCG_REG_T7) |
-                   (1 << TCG_REG_T8) |
-                   (1 << TCG_REG_T9));
+        tcg_target_available_regs[TCG_TYPE_I64] = 0xffffffff;
+    }
+
+    tcg_target_call_clobber_regs = 0;
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V0);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V1);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_A0);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_A1);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_A2);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_A3);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_T0);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_T1);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_T2);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_T3);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_T4);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_T5);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_T6);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_T7);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_T8);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_T9);
 
     s->reserved_regs = 0;
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_ZERO); /* zero register */
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 9eeaba9529..a4badcc85f 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2362,7 +2362,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOpDef *def,
     TCGTemp *ts, *ots;
     TCGType otype, itype;
 
-    tcg_regset_set(allocated_regs, s->reserved_regs);
+    allocated_regs = s->reserved_regs;
     ots = &s->temps[args[0]];
     ts = &s->temps[args[1]];
 
@@ -2450,8 +2450,8 @@ static void tcg_reg_alloc_op(TCGContext *s,
            args + nb_oargs + nb_iargs, 
            sizeof(TCGArg) * def->nb_cargs);
 
-    tcg_regset_set(i_allocated_regs, s->reserved_regs);
-    tcg_regset_set(o_allocated_regs, s->reserved_regs);
+    i_allocated_regs = s->reserved_regs;
+    o_allocated_regs = s->reserved_regs;
 
     /* satisfy input constraints */ 
     for(k = 0; k < nb_iargs; k++) {
@@ -2651,7 +2651,7 @@ static void tcg_reg_alloc_call(TCGContext *s, int nb_oargs, int nb_iargs,
     }
     
     /* assign input registers */
-    tcg_regset_set(allocated_regs, s->reserved_regs);
+    allocated_regs = s->reserved_regs;
     for(i = 0; i < nb_regs; i++) {
         arg = args[nb_oargs + i];
         if (arg != TCG_CALL_DUMMY_ARG) {
-- 
2.13.5
