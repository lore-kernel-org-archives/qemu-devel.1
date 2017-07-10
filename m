Received: from eggs.gnu.org ([2001:4830:134:3::10]:37707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUTFV-0007y6-Jx
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:36:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUTFQ-0007fe-Ln
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:36:53 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35891)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUTFQ-0007fX-FZ
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:36:48 -0400
Received: by mail-pg0-f68.google.com with SMTP id u36so11708966pgn.3
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 00:36:48 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun,  9 Jul 2017 21:34:57 -1000
Message-Id: <20170710073501.5207-2-rth@twiddle.net>
In-Reply-To: <20170710073501.5207-1-rth@twiddle.net>
References: <20170710073501.5207-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/5] tcg/aarch64: Introduce and use long branch
 to register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Pranith Kumar <bobby.prani@gmail.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Pranith Kumar <bobby.prani@gmail.com>

We can use a branch to register instruction for exit_tb for offsets
greater than 128MB.

CC: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
Message-Id: <20170630143614.31059-1-bobby.prani@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/aarch64/tcg-target.inc.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 1fa3bcc..8fce11a 100644
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
2.9.4
