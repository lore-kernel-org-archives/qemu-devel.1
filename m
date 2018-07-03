Received: from eggs.gnu.org ([2001:4830:134:3::10]:39945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKZ-0002u7-Eu
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKU-000706-Ov
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:27 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  3 Jul 2018 15:57:52 +1000
Message-Id: <20180703055804.13449-24-david@gibson.dropbear.id.au>
In-Reply-To: <20180703055804.13449-1-david@gibson.dropbear.id.au>
References: <20180703055804.13449-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 23/35] target/ppc: Implement the rest of
 gen_st_atomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, Richard Henderson <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

From: Richard Henderson <richard.henderson@linaro.org>

The store twin case was stubbed out.  For now, implement it only within
a serial context, forcing parallel execution to synchronize.  It would
be possible to implement with a cmpxchg loop, if we care, but the loose
alignment requirements (simply no crossing 32-byte boundary) might send
us back to the serial context anyway.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 597a37d3ec..e120f2ed0b 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3254,7 +3254,31 @@ static void gen_st_atomic(DisasContext *ctx, TCGMemOp memop)
         tcg_gen_atomic_smin_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
         break;
     case 24: /* Store twin  */
-        gen_invalid(ctx);
+        if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
+            /* Restart with exclusive lock.  */
+            gen_helper_exit_atomic(cpu_env);
+            ctx->base.is_jmp = DISAS_NORETURN;
+        } else {
+            TCGv t = tcg_temp_new();
+            TCGv t2 = tcg_temp_new();
+            TCGv s = tcg_temp_new();
+            TCGv s2 = tcg_temp_new();
+            TCGv ea_plus_s = tcg_temp_new();
+
+            tcg_gen_qemu_ld_tl(t, EA, ctx->mem_idx, memop);
+            tcg_gen_addi_tl(ea_plus_s, EA, MEMOP_GET_SIZE(memop));
+            tcg_gen_qemu_ld_tl(t2, ea_plus_s, ctx->mem_idx, memop);
+            tcg_gen_movcond_tl(TCG_COND_EQ, s, t, t2, src, t);
+            tcg_gen_movcond_tl(TCG_COND_EQ, s2, t, t2, src, t2);
+            tcg_gen_qemu_st_tl(s, EA, ctx->mem_idx, memop);
+            tcg_gen_qemu_st_tl(s2, ea_plus_s, ctx->mem_idx, memop);
+
+            tcg_temp_free(ea_plus_s);
+            tcg_temp_free(s2);
+            tcg_temp_free(s);
+            tcg_temp_free(t2);
+            tcg_temp_free(t);
+        }
         break;
     default:
         /* invoke data storage error handler */
-- 
2.17.1
