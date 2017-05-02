Received: from eggs.gnu.org ([2001:4830:134:3::10]:59389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5dOE-0001fh-17
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5dOD-0001Wx-29
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:14 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:32957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d5dOC-0001Wb-TR
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:12 -0400
Received: by mail-qk0-x244.google.com with SMTP id o85so22940158qkh.0
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 12:23:12 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  2 May 2017 12:22:40 -0700
Message-Id: <20170502192300.2124-6-rth@twiddle.net>
In-Reply-To: <20170502192300.2124-1-rth@twiddle.net>
References: <20170502192300.2124-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v6 05/25] tcg/i386: implement goto_ptr
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

From: "Emilio G. Cota" <cota@braap.org>

Suggested-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <1493263764-18657-6-git-send-email-cota@braap.org>
[rth: Reuse goto_ptr epilogue for exit_tb 0.]
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/i386/tcg-target.h     |  2 +-
 tcg/i386/tcg-target.inc.c | 24 ++++++++++++++++++++++--
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 59d9835..73a15f7 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -107,7 +107,7 @@ extern bool have_popcnt;
 #define TCG_TARGET_HAS_muls2_i32        1
 #define TCG_TARGET_HAS_muluh_i32        0
 #define TCG_TARGET_HAS_mulsh_i32        0
-#define TCG_TARGET_HAS_goto_ptr         0
+#define TCG_TARGET_HAS_goto_ptr         1
 
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extrl_i64_i32    0
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 5918008..01e3b4e 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -1882,8 +1882,13 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
 
     switch (opc) {
     case INDEX_op_exit_tb:
-        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_EAX, a0);
-        tcg_out_jmp(s, tb_ret_addr);
+        /* Reuse the zeroing that exists for goto_ptr.  */
+        if (a0 == 0) {
+            tcg_out_jmp(s, s->code_gen_epilogue);
+        } else {
+            tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_EAX, a0);
+            tcg_out_jmp(s, tb_ret_addr);
+        }
         break;
     case INDEX_op_goto_tb:
         if (s->tb_jmp_insn_offset) {
@@ -1906,6 +1911,10 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         }
         s->tb_jmp_reset_offset[a0] = tcg_current_code_size(s);
         break;
+    case INDEX_op_goto_ptr:
+        /* jmp to the given host address (could be epilogue) */
+        tcg_out_modrm(s, OPC_GRP5, EXT5_JMPN_Ev, a0);
+        break;
     case INDEX_op_br:
         tcg_out_jxx(s, JCC_JMP, arg_label(a0), 0);
         break;
@@ -2277,6 +2286,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
 
 static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
 {
+    static const TCGTargetOpDef r = { .args_ct_str = { "r" } };
     static const TCGTargetOpDef ri_r = { .args_ct_str = { "ri", "r" } };
     static const TCGTargetOpDef re_r = { .args_ct_str = { "re", "r" } };
     static const TCGTargetOpDef qi_r = { .args_ct_str = { "qi", "r" } };
@@ -2299,6 +2309,9 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         = { .args_ct_str = { "L", "L", "L", "L" } };
 
     switch (op) {
+    case INDEX_op_goto_ptr:
+        return &r;
+
     case INDEX_op_ld8u_i32:
     case INDEX_op_ld8u_i64:
     case INDEX_op_ld8s_i32:
@@ -2567,6 +2580,13 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     tcg_out_modrm(s, OPC_GRP5, EXT5_JMPN_Ev, tcg_target_call_iarg_regs[1]);
 #endif
 
+    /*
+     * Return path for goto_ptr. Set return value to 0, a-la exit_tb,
+     * and fall through to the rest of the epilogue.
+     */
+    s->code_gen_epilogue = s->code_ptr;
+    tcg_out_movi(s, TCG_TYPE_REG, TCG_REG_EAX, 0);
+
     /* TB epilogue */
     tb_ret_addr = s->code_ptr;
 
-- 
2.9.3
