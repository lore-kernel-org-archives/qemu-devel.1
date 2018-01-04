Received: from eggs.gnu.org ([2001:4830:134:3::10]:55291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eX8ba-0007Xt-EA
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:43:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eX8bX-0003Ua-4U
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:42:58 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:54921)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eX8bW-0003Sy-P6
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:42:55 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu,  4 Jan 2018 17:42:35 +0100
Message-Id: <20180104164251.26494-2-laurent@vivier.eu>
In-Reply-To: <20180104164251.26494-1-laurent@vivier.eu>
References: <20180104164251.26494-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 01/17] target-m68k: sync CC_OP before
 gen_jmp_tb()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

And remove update_cc_op() from gen_exception() because there is
one in gen_jmp_im().

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20180104012913.30763-2-laurent@vivier.eu>
---
 target/m68k/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index bbda7399ec..0e9d651a2a 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -270,7 +270,6 @@ static void gen_raise_exception(int nr)
 
 static void gen_exception(DisasContext *s, uint32_t where, int nr)
 {
-    update_cc_op(s);
     gen_jmp_im(s, where);
     gen_raise_exception(nr);
 }
@@ -2897,6 +2896,7 @@ DISAS_INSN(branch)
         gen_jmp_tb(s, 0, s->pc);
     } else {
         /* Unconditional branch.  */
+        update_cc_op(s);
         gen_jmp_tb(s, 0, base + offset);
     }
 }
@@ -4875,6 +4875,7 @@ static void gen_fjmpcc(DisasContext *s, int cond, TCGLabel *l1)
     DisasCompare c;
 
     gen_fcc_cond(&c, s, cond);
+    update_cc_op(s);
     tcg_gen_brcond_i32(c.tcond, c.v1, c.v2, l1);
     free_cond(&c);
 }
-- 
2.14.3
