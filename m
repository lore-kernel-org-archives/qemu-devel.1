Received: from eggs.gnu.org ([2001:4830:134:3::10]:58265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1cZNUI-0004ie-Gn
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 14:56:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1cZNUF-00065i-DL
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 14:56:10 -0500
From: Stefan Weil <sw@weilnetz.de>
Date: Thu,  2 Feb 2017 20:56:01 +0100
Message-Id: <20170202195601.11286-1-sw@weilnetz.de>
Subject: [Qemu-devel] [PATCH] tci: Remove invalid assertions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Stefan Weil <sw@weilnetz.de>

tb_jmp_insn_offset and tb_jmp_reset_offset are pointers
and cannot be used with ARRAY_SIZE.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---
 tcg/tci/tcg-target.inc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tcg/tci/tcg-target.inc.c b/tcg/tci/tcg-target.inc.c
index 26ee9b1664..b6a15569f8 100644
--- a/tcg/tci/tcg-target.inc.c
+++ b/tcg/tci/tcg-target.inc.c
@@ -566,7 +566,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
     case INDEX_op_goto_tb:
         if (s->tb_jmp_insn_offset) {
             /* Direct jump method. */
-            tcg_debug_assert(args[0] < ARRAY_SIZE(s->tb_jmp_insn_offset));
             /* Align for atomic patching and thread safety */
             s->code_ptr = QEMU_ALIGN_PTR_UP(s->code_ptr, 4);
             s->tb_jmp_insn_offset[args[0]] = tcg_current_code_size(s);
@@ -575,7 +574,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
             /* Indirect jump method. */
             TODO();
         }
-        tcg_debug_assert(args[0] < ARRAY_SIZE(s->tb_jmp_reset_offset));
         s->tb_jmp_reset_offset[args[0]] = tcg_current_code_size(s);
         break;
     case INDEX_op_br:
-- 
2.11.0
