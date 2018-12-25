Received: from eggs.gnu.org ([208.118.235.92]:50952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtoD-0000Oj-Ux
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 16:00:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtoB-00029x-Sw
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 16:00:13 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:36700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbto9-00023z-Sv
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 16:00:10 -0500
Received: by mail-pg1-x536.google.com with SMTP id n2so6828510pgm.3
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 13:00:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 26 Dec 2018 07:55:27 +1100
Message-Id: <20181225205529.10874-41-richard.henderson@linaro.org>
In-Reply-To: <20181225205529.10874-1-richard.henderson@linaro.org>
References: <20181225205529.10874-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 40/42] tcg: Add TCG_OPF_BB_EXIT
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

Use this to notice the opcodes that exit the TB, which implies
that local temps are really dead and need not be synced.

Previously we so marked the true end of the TB, but that was
immediately overwritten by the la_bb_end invoked by any
TCG_OPF_BB_END opcode, like exit_tb.

Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-opc.h |  7 ++++---
 tcg/tcg.h     | 14 ++++++++------
 tcg/tcg.c     |  5 ++++-
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
index e3a43aabb6..7a8a3edb5b 100644
--- a/tcg/tcg-opc.h
+++ b/tcg/tcg-opc.h
@@ -191,9 +191,10 @@ DEF(mulsh_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_mulsh_i64))
 /* QEMU specific */
 DEF(insn_start, 0, 0, TLADDR_ARGS * TARGET_INSN_START_WORDS,
     TCG_OPF_NOT_PRESENT)
-DEF(exit_tb, 0, 0, 1, TCG_OPF_BB_END)
-DEF(goto_tb, 0, 0, 1, TCG_OPF_BB_END)
-DEF(goto_ptr, 0, 1, 0, TCG_OPF_BB_END | IMPL(TCG_TARGET_HAS_goto_ptr))
+DEF(exit_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
+DEF(goto_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
+DEF(goto_ptr, 0, 1, 0,
+    TCG_OPF_BB_EXIT | TCG_OPF_BB_END | IMPL(TCG_TARGET_HAS_goto_ptr))
 
 DEF(qemu_ld_i32, 1, TLADDR_ARGS, 1,
     TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 5e5cf686a3..3a629991ca 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -1030,20 +1030,22 @@ typedef struct TCGArgConstraint {
 
 /* Bits for TCGOpDef->flags, 8 bits available.  */
 enum {
+    /* Instruction exits the translation block.  */
+    TCG_OPF_BB_EXIT      = 0x01,
     /* Instruction defines the end of a basic block.  */
-    TCG_OPF_BB_END       = 0x01,
+    TCG_OPF_BB_END       = 0x02,
     /* Instruction clobbers call registers and potentially update globals.  */
-    TCG_OPF_CALL_CLOBBER = 0x02,
+    TCG_OPF_CALL_CLOBBER = 0x04,
     /* Instruction has side effects: it cannot be removed if its outputs
        are not used, and might trigger exceptions.  */
-    TCG_OPF_SIDE_EFFECTS = 0x04,
+    TCG_OPF_SIDE_EFFECTS = 0x08,
     /* Instruction operands are 64-bits (otherwise 32-bits).  */
-    TCG_OPF_64BIT        = 0x08,
+    TCG_OPF_64BIT        = 0x10,
     /* Instruction is optional and not implemented by the host, or insn
        is generic and should not be implemened by the host.  */
-    TCG_OPF_NOT_PRESENT  = 0x10,
+    TCG_OPF_NOT_PRESENT  = 0x20,
     /* Instruction operands are vectors.  */
-    TCG_OPF_VECTOR       = 0x20,
+    TCG_OPF_VECTOR       = 0x40,
 };
 
 typedef struct TCGOpDef {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 4f0acf8863..d40edb4f57 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2424,6 +2424,7 @@ static void liveness_pass_1(TCGContext *s)
     int nb_temps = s->nb_temps;
     TCGOp *op, *op_prev;
 
+    /* ??? Should be redundant with the exit_tb that ends the TB.  */
     la_func_end(s, nb_globals, nb_temps);
 
     QTAILQ_FOREACH_REVERSE_SAFE(op, &s->ops, TCGOpHead, link, op_prev) {
@@ -2612,7 +2613,9 @@ static void liveness_pass_1(TCGContext *s)
             }
 
             /* if end of basic block, update */
-            if (def->flags & TCG_OPF_BB_END) {
+            if (def->flags & TCG_OPF_BB_EXIT) {
+                la_func_end(s, nb_globals, nb_temps);
+            } else if (def->flags & TCG_OPF_BB_END) {
                 la_bb_end(s, nb_globals, nb_temps);
             } else if (def->flags & TCG_OPF_SIDE_EFFECTS) {
                 la_global_sync(s, nb_globals);
-- 
2.17.2
