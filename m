Received: from eggs.gnu.org ([2001:4830:134:3::10]:59486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5dOM-0001q2-RZ
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5dOL-0001ep-VR
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:22 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36161)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d5dOL-0001eV-SD
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:21 -0400
Received: by mail-qt0-x244.google.com with SMTP id t52so21724850qtb.3
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 12:23:21 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  2 May 2017 12:22:47 -0700
Message-Id: <20170502192300.2124-13-rth@twiddle.net>
In-Reply-To: <20170502192300.2124-1-rth@twiddle.net>
References: <20170502192300.2124-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v6 12/25] tcg/ppc: Implement goto_ptr
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
 tcg/ppc/tcg-target.h     | 2 +-
 tcg/ppc/tcg-target.inc.c | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index a9aa974..5f4a40a 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -82,7 +82,7 @@ extern bool have_isa_3_00;
 #define TCG_TARGET_HAS_muls2_i32        0
 #define TCG_TARGET_HAS_muluh_i32        1
 #define TCG_TARGET_HAS_mulsh_i32        1
-#define TCG_TARGET_HAS_goto_ptr         0
+#define TCG_TARGET_HAS_goto_ptr         1
 
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_add2_i32         0
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 64f67d2..8d50f18 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -1932,6 +1932,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
 
     /* Epilogue */
     tcg_debug_assert(tb_ret_addr == s->code_ptr);
+    s->code_gen_epilogue = tb_ret_addr;
 
     tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_R0, TCG_REG_R1, FRAME_SIZE+LR_OFFSET);
     for (i = 0; i < ARRAY_SIZE(tcg_target_callee_save_regs); ++i) {
@@ -1986,6 +1987,11 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
 #endif
         s->tb_jmp_reset_offset[args[0]] = tcg_current_code_size(s);
         break;
+    case INDEX_op_goto_ptr:
+        tcg_out32(s, MTSPR | RS(args[0]) | CTR);
+        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_R3, 0);
+        tcg_out32(s, BCCTR | BO_ALWAYS);
+        break;
     case INDEX_op_br:
         {
             TCGLabel *l = arg_label(args[0]);
@@ -2555,6 +2561,7 @@ static const TCGTargetOpDef ppc_op_defs[] = {
     { INDEX_op_exit_tb, { } },
     { INDEX_op_goto_tb, { } },
     { INDEX_op_br, { } },
+    { INDEX_op_goto_ptr, { "r" } },
 
     { INDEX_op_ld8u_i32, { "r", "r" } },
     { INDEX_op_ld8s_i32, { "r", "r" } },
-- 
2.9.3
