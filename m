Received: from eggs.gnu.org ([2001:4830:134:3::10]:41400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1gN8G3-0001sZ-Nf
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 22:23:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1gN8G2-0004iI-E9
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 22:23:55 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Thu, 15 Nov 2018 14:22:59 +1100
Message-Id: <20181115032259.23968-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH] target/ppc: tcg: Implement addex
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, tg@gmplib.org, sjitindarsingh@gmail.com

Implement the addex instruction introduced in ISA V3.00 in qemu tcg.

The add extended using alternate carry bit (addex) instruction performs
the same operation as the add extended (adde) instruction, but using the
overflow (ov) field in the fixed point exception register (xer) as the
carry in and out instead of the carry (ca) field.

The instruction has a Z23-form, not an XO form, as follows:

    ------------------------------------------------------------------
    |   31   |   RT   |   RA   |   RB   |   CY   |     170     |  0  |
    ------------------------------------------------------------------
    0        6        11       16       21       23            31    32

However since the only valid form of the instruction defined so far is
CY = 0, we can treat this like an XO form instruction.

There is no dot form (addex.) of the instruction and the summary overflow
(so) bit in the xer is not modified by this instruction.

For simplicity we reuse the gen_op_arith_add function and add a function
argument to specify where the carry in input should come from and the
carry out output be stored (note must be the same location).

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 disas/ppc.c            |  2 ++
 target/ppc/translate.c | 60 +++++++++++++++++++++++++++-----------------------
 2 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/disas/ppc.c b/disas/ppc.c
index 5ab9c35a84..da1140ba2b 100644
--- a/disas/ppc.c
+++ b/disas/ppc.c
@@ -3734,6 +3734,8 @@ const struct powerpc_opcode powerpc_opcodes[] = {
 { "addmeo.", XO(31,234,1,1), XORB_MASK, PPCCOM,		{ RT, RA } },
 { "ameo.",   XO(31,234,1,1), XORB_MASK, PWRCOM,		{ RT, RA } },
 
+{ "addex",   XO(31,170,0,0), XO_MASK,   POWER9,         { RT, RA, RB } },
+
 { "mullw",   XO(31,235,0,0), XO_MASK,	PPCCOM,		{ RT, RA, RB } },
 { "muls",    XO(31,235,0,0), XO_MASK,	PWRCOM,		{ RT, RA, RB } },
 { "mullw.",  XO(31,235,0,1), XO_MASK,	PPCCOM,		{ RT, RA, RB } },
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 2b37910248..96894ab9a8 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -849,7 +849,7 @@ static inline void gen_op_arith_compute_ov(DisasContext *ctx, TCGv arg0,
 
 static inline void gen_op_arith_compute_ca32(DisasContext *ctx,
                                              TCGv res, TCGv arg0, TCGv arg1,
-                                             int sub)
+                                             TCGv ca32, int sub)
 {
     TCGv t0;
 
@@ -864,13 +864,14 @@ static inline void gen_op_arith_compute_ca32(DisasContext *ctx,
         tcg_gen_xor_tl(t0, arg0, arg1);
     }
     tcg_gen_xor_tl(t0, t0, res);
-    tcg_gen_extract_tl(cpu_ca32, t0, 32, 1);
+    tcg_gen_extract_tl(ca32, t0, 32, 1);
     tcg_temp_free(t0);
 }
 
 /* Common add function */
 static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv arg1,
-                                    TCGv arg2, bool add_ca, bool compute_ca,
+                                    TCGv arg2, TCGv ca, TCGv ca32,
+                                    bool add_ca, bool compute_ca,
                                     bool compute_ov, bool compute_rc0)
 {
     TCGv t0 = ret;
@@ -888,29 +889,29 @@ static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv arg1,
             tcg_gen_xor_tl(t1, arg1, arg2);        /* add without carry */
             tcg_gen_add_tl(t0, arg1, arg2);
             if (add_ca) {
-                tcg_gen_add_tl(t0, t0, cpu_ca);
+                tcg_gen_add_tl(t0, t0, ca);
             }
-            tcg_gen_xor_tl(cpu_ca, t0, t1);        /* bits changed w/ carry */
+            tcg_gen_xor_tl(ca, t0, t1);        /* bits changed w/ carry */
             tcg_temp_free(t1);
-            tcg_gen_extract_tl(cpu_ca, cpu_ca, 32, 1);
+            tcg_gen_extract_tl(ca, ca, 32, 1);
             if (is_isa300(ctx)) {
-                tcg_gen_mov_tl(cpu_ca32, cpu_ca);
+                tcg_gen_mov_tl(ca32, ca);
             }
         } else {
             TCGv zero = tcg_const_tl(0);
             if (add_ca) {
-                tcg_gen_add2_tl(t0, cpu_ca, arg1, zero, cpu_ca, zero);
-                tcg_gen_add2_tl(t0, cpu_ca, t0, cpu_ca, arg2, zero);
+                tcg_gen_add2_tl(t0, ca, arg1, zero, ca, zero);
+                tcg_gen_add2_tl(t0, ca, t0, ca, arg2, zero);
             } else {
-                tcg_gen_add2_tl(t0, cpu_ca, arg1, zero, arg2, zero);
+                tcg_gen_add2_tl(t0, ca, arg1, zero, arg2, zero);
             }
-            gen_op_arith_compute_ca32(ctx, t0, arg1, arg2, 0);
+            gen_op_arith_compute_ca32(ctx, t0, arg1, arg2, ca32, 0);
             tcg_temp_free(zero);
         }
     } else {
         tcg_gen_add_tl(t0, arg1, arg2);
         if (add_ca) {
-            tcg_gen_add_tl(t0, t0, cpu_ca);
+            tcg_gen_add_tl(t0, t0, ca);
         }
     }
 
@@ -927,40 +928,44 @@ static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv arg1,
     }
 }
 /* Add functions with two operands */
-#define GEN_INT_ARITH_ADD(name, opc3, add_ca, compute_ca, compute_ov)         \
+#define GEN_INT_ARITH_ADD(name, opc3, ca, add_ca, compute_ca, compute_ov)     \
 static void glue(gen_, name)(DisasContext *ctx)                               \
 {                                                                             \
     gen_op_arith_add(ctx, cpu_gpr[rD(ctx->opcode)],                           \
                      cpu_gpr[rA(ctx->opcode)], cpu_gpr[rB(ctx->opcode)],      \
+                     ca, glue(ca, 32),                                        \
                      add_ca, compute_ca, compute_ov, Rc(ctx->opcode));        \
 }
 /* Add functions with one operand and one immediate */
-#define GEN_INT_ARITH_ADD_CONST(name, opc3, const_val,                        \
+#define GEN_INT_ARITH_ADD_CONST(name, opc3, const_val, ca,                    \
                                 add_ca, compute_ca, compute_ov)               \
 static void glue(gen_, name)(DisasContext *ctx)                               \
 {                                                                             \
     TCGv t0 = tcg_const_tl(const_val);                                        \
     gen_op_arith_add(ctx, cpu_gpr[rD(ctx->opcode)],                           \
                      cpu_gpr[rA(ctx->opcode)], t0,                            \
+                     ca, glue(ca, 32),                                        \
                      add_ca, compute_ca, compute_ov, Rc(ctx->opcode));        \
     tcg_temp_free(t0);                                                        \
 }
 
 /* add  add.  addo  addo. */
-GEN_INT_ARITH_ADD(add, 0x08, 0, 0, 0)
-GEN_INT_ARITH_ADD(addo, 0x18, 0, 0, 1)
+GEN_INT_ARITH_ADD(add, 0x08, cpu_ca, 0, 0, 0)
+GEN_INT_ARITH_ADD(addo, 0x18, cpu_ca, 0, 0, 1)
 /* addc  addc.  addco  addco. */
-GEN_INT_ARITH_ADD(addc, 0x00, 0, 1, 0)
-GEN_INT_ARITH_ADD(addco, 0x10, 0, 1, 1)
+GEN_INT_ARITH_ADD(addc, 0x00, cpu_ca, 0, 1, 0)
+GEN_INT_ARITH_ADD(addco, 0x10, cpu_ca, 0, 1, 1)
 /* adde  adde.  addeo  addeo. */
-GEN_INT_ARITH_ADD(adde, 0x04, 1, 1, 0)
-GEN_INT_ARITH_ADD(addeo, 0x14, 1, 1, 1)
+GEN_INT_ARITH_ADD(adde, 0x04, cpu_ca, 1, 1, 0)
+GEN_INT_ARITH_ADD(addeo, 0x14, cpu_ca, 1, 1, 1)
 /* addme  addme.  addmeo  addmeo.  */
-GEN_INT_ARITH_ADD_CONST(addme, 0x07, -1LL, 1, 1, 0)
-GEN_INT_ARITH_ADD_CONST(addmeo, 0x17, -1LL, 1, 1, 1)
+GEN_INT_ARITH_ADD_CONST(addme, 0x07, -1LL, cpu_ca, 1, 1, 0)
+GEN_INT_ARITH_ADD_CONST(addmeo, 0x17, -1LL, cpu_ca, 1, 1, 1)
+/* addex */
+GEN_INT_ARITH_ADD(addex, 0x05, cpu_ov, 1, 1, 0);
 /* addze  addze.  addzeo  addzeo.*/
-GEN_INT_ARITH_ADD_CONST(addze, 0x06, 0, 1, 1, 0)
-GEN_INT_ARITH_ADD_CONST(addzeo, 0x16, 0, 1, 1, 1)
+GEN_INT_ARITH_ADD_CONST(addze, 0x06, 0, cpu_ca, 1, 1, 0)
+GEN_INT_ARITH_ADD_CONST(addzeo, 0x16, 0, cpu_ca, 1, 1, 1)
 /* addi */
 static void gen_addi(DisasContext *ctx)
 {
@@ -979,7 +984,7 @@ static inline void gen_op_addic(DisasContext *ctx, bool compute_rc0)
 {
     TCGv c = tcg_const_tl(SIMM(ctx->opcode));
     gen_op_arith_add(ctx, cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
-                     c, 0, 1, 0, compute_rc0);
+                     c, cpu_ca, cpu_ca32, 0, 1, 0, compute_rc0);
     tcg_temp_free(c);
 }
 
@@ -1432,13 +1437,13 @@ static inline void gen_op_arith_subf(DisasContext *ctx, TCGv ret, TCGv arg1,
             zero = tcg_const_tl(0);
             tcg_gen_add2_tl(t0, cpu_ca, arg2, zero, cpu_ca, zero);
             tcg_gen_add2_tl(t0, cpu_ca, t0, cpu_ca, inv1, zero);
-            gen_op_arith_compute_ca32(ctx, t0, inv1, arg2, 0);
+            gen_op_arith_compute_ca32(ctx, t0, inv1, arg2, cpu_ca32, 0);
             tcg_temp_free(zero);
             tcg_temp_free(inv1);
         } else {
             tcg_gen_setcond_tl(TCG_COND_GEU, cpu_ca, arg2, arg1);
             tcg_gen_sub_tl(t0, arg2, arg1);
-            gen_op_arith_compute_ca32(ctx, t0, arg1, arg2, 1);
+            gen_op_arith_compute_ca32(ctx, t0, arg1, arg2, cpu_ca32, 1);
         }
     } else if (add_ca) {
         /* Since we're ignoring carry-out, we can simplify the
@@ -7087,6 +7092,7 @@ GEN_INT_ARITH_ADD(adde, 0x04, 1, 1, 0)
 GEN_INT_ARITH_ADD(addeo, 0x14, 1, 1, 1)
 GEN_INT_ARITH_ADD_CONST(addme, 0x07, -1LL, 1, 1, 0)
 GEN_INT_ARITH_ADD_CONST(addmeo, 0x17, -1LL, 1, 1, 1)
+GEN_HANDLER_E(addex, 0x1F, 0x0A, 0x05, 0x00000000, PPC_NONE, PPC2_ISA300),
 GEN_INT_ARITH_ADD_CONST(addze, 0x06, 0, 1, 1, 0)
 GEN_INT_ARITH_ADD_CONST(addzeo, 0x16, 0, 1, 1, 1)
 
-- 
2.13.6
