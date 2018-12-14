Received: from eggs.gnu.org ([2001:4830:134:3::10]:58726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe0m-0005tp-JL
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe0l-0006Yu-K3
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:36 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:42982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXe0l-0006W0-Dk
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:35 -0500
Received: by mail-ot1-x329.google.com with SMTP id v23so4096170otk.9
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 19:19:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 21:18:58 -0600
Message-Id: <20181214031923.29527-9-richard.henderson@linaro.org>
In-Reply-To: <20181214031923.29527-1-richard.henderson@linaro.org>
References: <20181214031923.29527-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/32] tcg/ppc: Fold away "noaddr" branch
 routines
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

There is no longer a need for preserving branch offset operands,
as we no longer re-translate.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.inc.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index c2f729ee8f..2e2a22f579 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -210,18 +210,6 @@ static void reloc_pc14(tcg_insn_unit *pc, tcg_insn_unit *target)
     *pc = (*pc & ~0xfffc) | reloc_pc14_val(pc, target);
 }
 
-static inline void tcg_out_b_noaddr(TCGContext *s, int insn)
-{
-    unsigned retrans = *s->code_ptr & 0x3fffffc;
-    tcg_out32(s, insn | retrans);
-}
-
-static inline void tcg_out_bc_noaddr(TCGContext *s, int insn)
-{
-    unsigned retrans = *s->code_ptr & 0xfffc;
-    tcg_out32(s, insn | retrans);
-}
-
 /* parse target specific constraints */
 static const char *target_parse_constraint(TCGArgConstraint *ct,
                                            const char *ct_str, TCGType type)
@@ -1179,11 +1167,11 @@ static void tcg_out_setcond(TCGContext *s, TCGType type, TCGCond cond,
 static void tcg_out_bc(TCGContext *s, int bc, TCGLabel *l)
 {
     if (l->has_value) {
-        tcg_out32(s, bc | reloc_pc14_val(s->code_ptr, l->u.value_ptr));
+        bc |= reloc_pc14_val(s->code_ptr, l->u.value_ptr);
     } else {
         tcg_out_reloc(s, s->code_ptr, R_PPC_REL14, l, 0);
-        tcg_out_bc_noaddr(s, bc);
     }
+    tcg_out32(s, bc);
 }
 
 static void tcg_out_brcond(TCGContext *s, TCGCond cond,
@@ -1771,7 +1759,7 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is_64)
 
     /* Load a pointer into the current opcode w/conditional branch-link. */
     label_ptr = s->code_ptr;
-    tcg_out_bc_noaddr(s, BC | BI(7, CR_EQ) | BO_COND_FALSE | LK);
+    tcg_out32(s, BC | BI(7, CR_EQ) | BO_COND_FALSE | LK);
 
     rbase = TCG_REG_R3;
 #else  /* !CONFIG_SOFTMMU */
@@ -1846,7 +1834,7 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is_64)
 
     /* Load a pointer into the current opcode w/conditional branch-link. */
     label_ptr = s->code_ptr;
-    tcg_out_bc_noaddr(s, BC | BI(7, CR_EQ) | BO_COND_FALSE | LK);
+    tcg_out32(s, BC | BI(7, CR_EQ) | BO_COND_FALSE | LK);
 
     rbase = TCG_REG_R3;
 #else  /* !CONFIG_SOFTMMU */
@@ -2044,13 +2032,14 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
     case INDEX_op_br:
         {
             TCGLabel *l = arg_label(args[0]);
+            uint32_t insn = B;
 
             if (l->has_value) {
-                tcg_out_b(s, 0, l->u.value_ptr);
+                insn |= reloc_pc24_val(s->code_ptr, l->u.value_ptr);
             } else {
                 tcg_out_reloc(s, s->code_ptr, R_PPC_REL24, l, 0);
-                tcg_out_b_noaddr(s, B);
             }
+            tcg_out32(s, insn);
         }
         break;
     case INDEX_op_ld8u_i32:
-- 
2.17.2
