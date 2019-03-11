Received: from eggs.gnu.org ([209.51.188.92]:34407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h3Qay-0004Gr-Up
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:28:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h3QPI-0007Wq-9m
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:16:17 -0400
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:60429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1h3QPH-0007VJ-Po
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:16:16 -0400
From: Sven Schnelle <svens@stackframe.org>
Date: Mon, 11 Mar 2019 20:16:01 +0100
Message-Id: <20190311191602.25796-11-svens@stackframe.org>
In-Reply-To: <20190311191602.25796-1-svens@stackframe.org>
References: <20190311191602.25796-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 10/11] target/hppa: exit TB if either Data or
 Instruction TLB changes
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

The current code assumes that we don't need to exit the TB
if a Data Cache Flush or Insert has happend. However, as we
have a shared Data/Instruction TLB, a Data cache flush also
flushes Instruction TLB entries, and a Data cache TLB insert
might also evict a Instruction TLB entry.

So exit the TB in all cases if Instruction translation is enabled.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 target/hppa/translate.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index a393a12252..fcacff963e 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2474,9 +2474,8 @@ static bool trans_ixtlbx(DisasContext *ctx, arg_ixtlbx *a)
         gen_helper_itlbp(cpu_env, addr, reg);
     }
 
-    /* Exit TB for ITLB change if mmu is enabled.  This *should* not be
-       the case, since the OS TLB fill handler runs with mmu disabled.  */
-    if (!a->data && (ctx->tb_flags & PSW_C)) {
+    /* Exit TB for TLB change if mmu is enabled.  */
+    if (ctx->tb_flags & PSW_C) {
         ctx->base.is_jmp = DISAS_IAQ_N_STALE;
     }
     return nullify_end(ctx);
@@ -2503,7 +2502,7 @@ static bool trans_pxtlbx(DisasContext *ctx, arg_pxtlbx *a)
     }
 
     /* Exit TB for TLB change if mmu is enabled.  */
-    if (!a->data && (ctx->tb_flags & PSW_C)) {
+    if (ctx->tb_flags & PSW_C) {
         ctx->base.is_jmp = DISAS_IAQ_N_STALE;
     }
     return nullify_end(ctx);
-- 
2.20.1
