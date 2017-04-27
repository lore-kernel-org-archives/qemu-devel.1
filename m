Received: from eggs.gnu.org ([2001:4830:134:3::10]:52361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d3i6A-0004AX-AE
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 08:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d3i66-0001Yi-DX
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 08:00:38 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36505)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d3i66-0001YR-6i
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 08:00:34 -0400
Received: by mail-wm0-x244.google.com with SMTP id u65so4062254wmu.3
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 05:00:33 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu, 27 Apr 2017 14:00:04 +0200
Message-Id: <20170427120006.20564-18-rth@twiddle.net>
In-Reply-To: <20170427120006.20564-1-rth@twiddle.net>
References: <20170427120006.20564-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v5 17/19] tcg/aarch64: Implement goto_ptr
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
 tcg/aarch64/tcg-target.h     |  2 +-
 tcg/aarch64/tcg-target.inc.c | 22 ++++++++++++++++++++--
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index b82eac4..55a46ac 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -77,7 +77,7 @@ typedef enum {
 #define TCG_TARGET_HAS_mulsh_i32        0
 #define TCG_TARGET_HAS_extrl_i64_i32    0
 #define TCG_TARGET_HAS_extrh_i64_i32    0
-#define TCG_TARGET_HAS_goto_ptr         0
+#define TCG_TARGET_HAS_goto_ptr         1
 
 #define TCG_TARGET_HAS_div_i64          1
 #define TCG_TARGET_HAS_rem_i64          1
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 290de6d..5f18545 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -1357,8 +1357,13 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
 
     switch (opc) {
     case INDEX_op_exit_tb:
-        tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_X0, a0);
-        tcg_out_goto(s, tb_ret_addr);
+        /* Reuse the zeroing that exists for goto_ptr.  */
+        if (a0 == 0) {
+            tcg_out_goto(s, s->code_gen_epilogue);
+        } else {
+            tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_X0, a0);
+            tcg_out_goto(s, tb_ret_addr);
+        }
         break;
 
     case INDEX_op_goto_tb:
@@ -1374,6 +1379,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         s->tb_jmp_reset_offset[a0] = tcg_current_code_size(s);
         break;
 
+    case INDEX_op_goto_ptr:
+        tcg_out_insn(s, 3207, BR, a0);
+        break;
+
     case INDEX_op_br:
         tcg_out_goto_label(s, arg_label(a0));
         break;
@@ -1735,6 +1744,7 @@ static const TCGTargetOpDef aarch64_op_defs[] = {
     { INDEX_op_exit_tb, { } },
     { INDEX_op_goto_tb, { } },
     { INDEX_op_br, { } },
+    { INDEX_op_goto_ptr, { "r" } },
 
     { INDEX_op_ld8u_i32, { "r", "r" } },
     { INDEX_op_ld8s_i32, { "r", "r" } },
@@ -1942,6 +1952,14 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     tcg_out_mov(s, TCG_TYPE_PTR, TCG_AREG0, tcg_target_call_iarg_regs[0]);
     tcg_out_insn(s, 3207, BR, tcg_target_call_iarg_regs[1]);
 
+    /*
+     * Return path for goto_ptr. Set return value to 0, a-la exit_tb,
+     * and fall through to the rest of the epilogue.
+     */
+    s->code_gen_epilogue = s->code_ptr;
+    tcg_out_movi(s, TCG_TYPE_REG, TCG_REG_X0, 0);
+
+    /* TB epilogue */
     tb_ret_addr = s->code_ptr;
 
     /* Remove TCG locals stack space.  */
-- 
2.9.3
