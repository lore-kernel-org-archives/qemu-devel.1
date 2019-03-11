Received: from eggs.gnu.org ([209.51.188.92]:34252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h3Qb0-00042z-5s
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h3QPI-0007Wv-AN
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:16:17 -0400
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:42532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1h3QPH-0007V7-U7
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:16:16 -0400
From: Sven Schnelle <svens@stackframe.org>
Date: Mon, 11 Mar 2019 20:15:58 +0100
Message-Id: <20190311191602.25796-8-svens@stackframe.org>
In-Reply-To: <20190311191602.25796-1-svens@stackframe.org>
References: <20190311191602.25796-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 07/11] target/hppa: fix b,gate instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>

b,gate does GR[t] ← cat(GR[t]{0..29},IAOQ_Front{30..31});
instead of saving the link address to register t.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 target/hppa/translate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 441f0ea9d6..a393a12252 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3464,6 +3464,7 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
     }
 
 #ifndef CONFIG_USER_ONLY
+    TCGv_reg tmp;
     if (ctx->tb_flags & PSW_C) {
         CPUHPPAState *env = ctx->cs->env_ptr;
         int type = hppa_artype_for_page(env, ctx->base.pc_next);
@@ -3480,12 +3481,13 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
         if (type >= 4 && type - 4 < ctx->privilege) {
             dest = deposit32(dest, 0, 2, type - 4);
         }
+        tmp = dest_gpr(ctx, a->l);
+        tcg_gen_deposit_reg(tmp, tmp, cpu_iaoq_f, 0, 2);
     } else {
         dest &= -4;  /* priv = 0 */
     }
 #endif
-
-    return do_dbranch(ctx, dest, a->l, a->n);
+    return do_dbranch(ctx, dest, 0, a->n);
 }
 
 static bool trans_blr(DisasContext *ctx, arg_blr *a)
-- 
2.20.1
