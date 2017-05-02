Received: from eggs.gnu.org ([2001:4830:134:3::10]:59550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5dOT-0001vc-31
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5dOS-0001l2-2o
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:29 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d5dOR-0001kj-UV
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:28 -0400
Received: by mail-qt0-x244.google.com with SMTP id o36so21703902qtb.2
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 12:23:27 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  2 May 2017 12:22:52 -0700
Message-Id: <20170502192300.2124-18-rth@twiddle.net>
In-Reply-To: <20170502192300.2124-1-rth@twiddle.net>
References: <20170502192300.2124-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v6 17/25] tcg/arm: Implement goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/arm/tcg-target.h     |  2 +-
 tcg/arm/tcg-target.inc.c | 25 +++++++++++++++++++++----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index c114df7..5ef1086 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -123,7 +123,7 @@ extern bool use_idiv_instructions;
 #define TCG_TARGET_HAS_mulsh_i32        0
 #define TCG_TARGET_HAS_div_i32          use_idiv_instructions
 #define TCG_TARGET_HAS_rem_i32          0
-#define TCG_TARGET_HAS_goto_ptr         0
+#define TCG_TARGET_HAS_goto_ptr         1
 
 enum {
     TCG_AREG0 = TCG_REG_R6,
diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 590c57d..9f5cb66 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -1655,8 +1655,14 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
 
     switch (opc) {
     case INDEX_op_exit_tb:
-        tcg_out_movi32(s, COND_AL, TCG_REG_R0, args[0]);
-        tcg_out_goto(s, COND_AL, tb_ret_addr);
+        /* Reuse the zeroing that exists for goto_ptr.  */
+        a0 = args[0];
+        if (a0 == 0) {
+            tcg_out_goto(s, COND_AL, s->code_gen_epilogue);
+        } else {
+            tcg_out_movi32(s, COND_AL, TCG_REG_R0, args[0]);
+            tcg_out_goto(s, COND_AL, tb_ret_addr);
+        }
         break;
     case INDEX_op_goto_tb:
         if (s->tb_jmp_insn_offset) {
@@ -1671,6 +1677,9 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         }
         s->tb_jmp_reset_offset[args[0]] = tcg_current_code_size(s);
         break;
+    case INDEX_op_goto_ptr:
+        tcg_out_bx(s, COND_AL, args[0]);
+        break;
     case INDEX_op_br:
         tcg_out_goto_label(s, COND_AL, arg_label(args[0]));
         break;
@@ -1961,6 +1970,7 @@ static const TCGTargetOpDef arm_op_defs[] = {
     { INDEX_op_exit_tb, { } },
     { INDEX_op_goto_tb, { } },
     { INDEX_op_br, { } },
+    { INDEX_op_goto_ptr, { "r" } },
 
     { INDEX_op_ld8u_i32, { "r", "r" } },
     { INDEX_op_ld8s_i32, { "r", "r" } },
@@ -2136,9 +2146,16 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     tcg_out_mov(s, TCG_TYPE_PTR, TCG_AREG0, tcg_target_call_iarg_regs[0]);
 
     tcg_out_bx(s, COND_AL, tcg_target_call_iarg_regs[1]);
-    tb_ret_addr = s->code_ptr;
 
-    /* Epilogue.  We branch here via tb_ret_addr.  */
+    /*
+     * Return path for goto_ptr. Set return value to 0, a-la exit_tb,
+     * and fall through to the rest of the epilogue.
+     */
+    s->code_gen_epilogue = s->code_ptr;
+    tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_R0, 0);
+
+    /* TB epilogue */
+    tb_ret_addr = s->code_ptr;
     tcg_out_dat_rI(s, COND_AL, ARITH_ADD, TCG_REG_CALL_STACK,
                    TCG_REG_CALL_STACK, stack_addend, 1);
 
-- 
2.9.3
