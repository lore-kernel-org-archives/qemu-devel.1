Received: from eggs.gnu.org ([2001:4830:134:3::10]:55792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dQUFs-0006H7-It
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 03:52:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dQUFq-0005wB-Gv
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 03:52:48 -0400
Received: from mail-yb0-x242.google.com ([2607:f8b0:4002:c09::242]:34576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1dQUFq-0005w4-CT
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 03:52:46 -0400
Received: by mail-yb0-x242.google.com with SMTP id b189so3583667yba.1
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 00:52:46 -0700 (PDT)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Thu, 29 Jun 2017 03:52:41 -0400
Message-Id: <20170629075243.26984-2-bobby.prani@gmail.com>
In-Reply-To: <20170629075243.26984-1-bobby.prani@gmail.com>
References: <20170629075243.26984-1-bobby.prani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/3] tcg/aarch64: Introduce and use long
 branch to register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net

We can use a branch to register instruction for exit_tb for offsets
greater than 128MB.

CC: Richard Henderson <rth@twiddle.net>
CC: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 tcg/aarch64/tcg-target.inc.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 1fa3bccc89..8fce11ace7 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -819,6 +819,17 @@ static inline void tcg_out_goto(TCGContext *s, tcg_insn_unit *target)
     tcg_out_insn(s, 3206, B, offset);
 }
 
+static inline void tcg_out_goto_long(TCGContext *s, tcg_insn_unit *target)
+{
+    ptrdiff_t offset = target - s->code_ptr;
+    if (offset == sextract64(offset, 0, 26)) {
+        tcg_out_insn(s, 3206, BL, offset);
+    } else {
+        tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP, (intptr_t)target);
+        tcg_out_insn(s, 3207, BR, TCG_REG_TMP);
+    }
+}
+
 static inline void tcg_out_goto_noaddr(TCGContext *s)
 {
     /* We pay attention here to not modify the branch target by reading from
@@ -1364,10 +1375,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_exit_tb:
         /* Reuse the zeroing that exists for goto_ptr.  */
         if (a0 == 0) {
-            tcg_out_goto(s, s->code_gen_epilogue);
+            tcg_out_goto_long(s, s->code_gen_epilogue);
         } else {
             tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_X0, a0);
-            tcg_out_goto(s, tb_ret_addr);
+            tcg_out_goto_long(s, tb_ret_addr);
         }
         break;
 
-- 
2.13.0
