Received: from eggs.gnu.org ([2001:4830:134:3::10]:34788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dIjoI-0002gZ-7h
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 18:52:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dIjoF-0000he-L2
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 18:52:18 -0400
Received: from mail-yw0-x241.google.com ([2607:f8b0:4002:c05::241]:35105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1dIjoF-0000hV-H6
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 18:52:15 -0400
Received: by mail-yw0-x241.google.com with SMTP id p144so1302950ywp.2
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 15:52:15 -0700 (PDT)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Wed,  7 Jun 2017 18:52:10 -0400
Message-Id: <20170607225212.23714-2-bobby.prani@gmail.com>
In-Reply-To: <20170607225212.23714-1-bobby.prani@gmail.com>
References: <20170607225212.23714-1-bobby.prani@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 1/3] tcg/aarch64: Introduce and use jump to
 register
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

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 tcg/aarch64/tcg-target.inc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 1fa3bccc89..ab0a8caa03 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -819,6 +819,12 @@ static inline void tcg_out_goto(TCGContext *s, tcg_insn_unit *target)
     tcg_out_insn(s, 3206, B, offset);
 }
 
+static inline void tcg_out_goto_register(TCGContext *s, intptr_t target)
+{
+    tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP, target);
+    tcg_out_insn(s, 3207, BR, TCG_REG_TMP);
+}
+
 static inline void tcg_out_goto_noaddr(TCGContext *s)
 {
     /* We pay attention here to not modify the branch target by reading from
@@ -1364,10 +1370,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_exit_tb:
         /* Reuse the zeroing that exists for goto_ptr.  */
         if (a0 == 0) {
-            tcg_out_goto(s, s->code_gen_epilogue);
+            tcg_out_goto_register(s, (intptr_t)(s->code_gen_epilogue));
         } else {
             tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_X0, a0);
-            tcg_out_goto(s, tb_ret_addr);
+            tcg_out_goto_register(s, (intptr_t)(tb_ret_addr));
         }
         break;
 
-- 
2.13.0
