Received: from eggs.gnu.org ([2001:4830:134:3::10]:58310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWuLR-0000p9-Kp
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 20:29:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWuLO-00073N-Dv
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 20:29:21 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:60041)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eWuLO-00070P-4P
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 20:29:18 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu,  4 Jan 2018 02:28:57 +0100
Message-Id: <20180104012913.30763-2-laurent@vivier.eu>
In-Reply-To: <20180104012913.30763-1-laurent@vivier.eu>
References: <20180104012913.30763-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v7 01/17] target-m68k: sync CC_OP before
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
Cc: Richard Henderson <richard.henderson@linaro.org>, Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>

And remove update_cc_op() from gen_exception() because there is
one in gen_jmp_im().

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
