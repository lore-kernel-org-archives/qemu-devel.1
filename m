Received: from eggs.gnu.org ([2001:4830:134:3::10]:54183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMK3G-0003dp-8A
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMK3D-00050O-UD
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:21 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gMK3D-0004zj-5P
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:19 -0500
Received: by mail-wr1-x443.google.com with SMTP id v18-v6so11019146wrt.8
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 13:47:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 12 Nov 2018 22:44:56 +0100
Message-Id: <20181112214503.22941-11-richard.henderson@linaro.org>
In-Reply-To: <20181112214503.22941-1-richard.henderson@linaro.org>
References: <20181112214503.22941-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 10/17] tcg/aarch64: Parameterize the
 temp for tcg_out_goto_long
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

We cannot use TCG_REG_LR (aka TCG_REG_TMP) for tail calls.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index c0ba9a6d50..ea5fe33fca 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -1134,14 +1134,15 @@ static inline void tcg_out_goto(TCGContext *s, tcg_insn_unit *target)
     tcg_out_insn(s, 3206, B, offset);
 }
 
-static inline void tcg_out_goto_long(TCGContext *s, tcg_insn_unit *target)
+static inline void tcg_out_goto_long(TCGContext *s, tcg_insn_unit *target,
+                                     TCGReg scratch)
 {
     ptrdiff_t offset = target - s->code_ptr;
     if (offset == sextract64(offset, 0, 26)) {
         tcg_out_insn(s, 3206, BL, offset);
     } else {
-        tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP, (intptr_t)target);
-        tcg_out_insn(s, 3207, BR, TCG_REG_TMP);
+        tcg_out_movi(s, TCG_TYPE_I64, scratch, (intptr_t)target);
+        tcg_out_insn(s, 3207, BR, scratch);
     }
 }
 
@@ -1716,10 +1717,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_exit_tb:
         /* Reuse the zeroing that exists for goto_ptr.  */
         if (a0 == 0) {
-            tcg_out_goto_long(s, s->code_gen_epilogue);
+            tcg_out_goto_long(s, s->code_gen_epilogue, TCG_REG_TMP);
         } else {
             tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_X0, a0);
-            tcg_out_goto_long(s, tb_ret_addr);
+            tcg_out_goto_long(s, tb_ret_addr, TCG_REG_TMP);
         }
         break;
 
-- 
2.17.2
