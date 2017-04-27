Received: from eggs.gnu.org ([2001:4830:134:3::10]:37466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d3a7c-0007xa-3J
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 23:29:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d3a7a-0001xh-T8
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 23:29:36 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 26 Apr 2017 23:29:18 -0400
Message-Id: <1493263764-18657-6-git-send-email-cota@braap.org>
In-Reply-To: <1493263764-18657-1-git-send-email-cota@braap.org>
References: <1493263764-18657-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v4 05/11] tcg/i386: implement goto_ptr op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>

Suggested-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg/i386/tcg-target.h     |  2 +-
 tcg/i386/tcg-target.inc.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

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
index 5918008..d0bf53a 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -1906,6 +1906,10 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
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
@@ -2277,6 +2281,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
 
 static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
 {
+    static const TCGTargetOpDef r = { .args_ct_str = { "r" } };
     static const TCGTargetOpDef ri_r = { .args_ct_str = { "ri", "r" } };
     static const TCGTargetOpDef re_r = { .args_ct_str = { "re", "r" } };
     static const TCGTargetOpDef qi_r = { .args_ct_str = { "qi", "r" } };
@@ -2299,6 +2304,9 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         = { .args_ct_str = { "L", "L", "L", "L" } };
 
     switch (op) {
+    case INDEX_op_goto_ptr:
+        return &r;
+
     case INDEX_op_ld8u_i32:
     case INDEX_op_ld8u_i64:
     case INDEX_op_ld8s_i32:
@@ -2567,6 +2575,13 @@ static void tcg_target_qemu_prologue(TCGContext *s)
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
2.7.4
