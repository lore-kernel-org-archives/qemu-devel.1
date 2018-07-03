Received: from eggs.gnu.org ([2001:4830:134:3::10]:39881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKY-0002sV-2w
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKV-00071s-OZ
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:26 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  3 Jul 2018 15:57:51 +1000
Message-Id: <20180703055804.13449-23-david@gibson.dropbear.id.au>
In-Reply-To: <20180703055804.13449-1-david@gibson.dropbear.id.au>
References: <20180703055804.13449-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 22/35] target/ppc: Implement the rest of
 gen_ld_atomic
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

These cases were stubbed out.  For now, implement them only within
a serial context, forcing parallel execution to synchronize.  It
would be possible to implement these with cmpxchg loops, if we care.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c | 83 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 4 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 79285b6698..597a37d3ec 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3078,16 +3078,45 @@ LARX(lbarx, DEF_MEMOP(MO_UB))
 LARX(lharx, DEF_MEMOP(MO_UW))
 LARX(lwarx, DEF_MEMOP(MO_UL))
 
+static void gen_fetch_inc_conditional(DisasContext *ctx, TCGMemOp memop,
+                                      TCGv EA, TCGCond cond, int addend)
+{
+    TCGv t = tcg_temp_new();
+    TCGv t2 = tcg_temp_new();
+    TCGv u = tcg_temp_new();
+
+    tcg_gen_qemu_ld_tl(t, EA, ctx->mem_idx, memop);
+    tcg_gen_addi_tl(t2, EA, MEMOP_GET_SIZE(memop));
+    tcg_gen_qemu_ld_tl(t2, t2, ctx->mem_idx, memop);
+    tcg_gen_addi_tl(u, t, addend);
+
+    /* E.g. for fetch and increment bounded... */
+    /* mem(EA,s) = (t != t2 ? u = t + 1 : t) */
+    tcg_gen_movcond_tl(cond, u, t, t2, u, t);
+    tcg_gen_qemu_st_tl(u, EA, ctx->mem_idx, memop);
+
+    /* RT = (t != t2 ? t : u = 1<<(s*8-1)) */
+    tcg_gen_movi_tl(u, 1 << (MEMOP_GET_SIZE(memop) * 8 - 1));
+    tcg_gen_movcond_tl(cond, cpu_gpr[rD(ctx->opcode)], t, t2, t, u);
+
+    tcg_temp_free(t);
+    tcg_temp_free(t2);
+    tcg_temp_free(u);
+}
+
 static void gen_ld_atomic(DisasContext *ctx, TCGMemOp memop)
 {
     uint32_t gpr_FC = FC(ctx->opcode);
     TCGv EA = tcg_temp_new();
+    int rt = rD(ctx->opcode);
+    bool need_serial;
     TCGv src, dst;
 
     gen_addr_register(ctx, EA);
-    dst = cpu_gpr[rD(ctx->opcode)];
-    src = cpu_gpr[rD(ctx->opcode) + 1];
+    dst = cpu_gpr[rt];
+    src = cpu_gpr[(rt + 1) & 31];
 
+    need_serial = false;
     memop |= MO_ALIGN;
     switch (gpr_FC) {
     case 0: /* Fetch and add */
@@ -3117,17 +3146,63 @@ static void gen_ld_atomic(DisasContext *ctx, TCGMemOp memop)
     case 8: /* Swap */
         tcg_gen_atomic_xchg_tl(dst, EA, src, ctx->mem_idx, memop);
         break;
-    case 16: /* compare and swap not equal */
+
+    case 16: /* Compare and swap not equal */
+        if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
+            need_serial = true;
+        } else {
+            TCGv t0 = tcg_temp_new();
+            TCGv t1 = tcg_temp_new();
+
+            tcg_gen_qemu_ld_tl(t0, EA, ctx->mem_idx, memop);
+            if ((memop & MO_SIZE) == MO_64 || TARGET_LONG_BITS == 32) {
+                tcg_gen_mov_tl(t1, src);
+            } else {
+                tcg_gen_ext32u_tl(t1, src);
+            }
+            tcg_gen_movcond_tl(TCG_COND_NE, t1, t0, t1,
+                               cpu_gpr[(rt + 2) & 31], t0);
+            tcg_gen_qemu_st_tl(t1, EA, ctx->mem_idx, memop);
+            tcg_gen_mov_tl(dst, t0);
+
+            tcg_temp_free(t0);
+            tcg_temp_free(t1);
+        }
+        break;
+
     case 24: /* Fetch and increment bounded */
+        if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
+            need_serial = true;
+        } else {
+            gen_fetch_inc_conditional(ctx, memop, EA, TCG_COND_NE, 1);
+        }
+        break;
     case 25: /* Fetch and increment equal */
+        if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
+            need_serial = true;
+        } else {
+            gen_fetch_inc_conditional(ctx, memop, EA, TCG_COND_EQ, 1);
+        }
+        break;
     case 28: /* Fetch and decrement bounded */
-        gen_invalid(ctx);
+        if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
+            need_serial = true;
+        } else {
+            gen_fetch_inc_conditional(ctx, memop, EA, TCG_COND_NE, -1);
+        }
         break;
+
     default:
         /* invoke data storage error handler */
         gen_exception_err(ctx, POWERPC_EXCP_DSI, POWERPC_EXCP_INVAL);
     }
     tcg_temp_free(EA);
+
+    if (need_serial) {
+        /* Restart with exclusive lock.  */
+        gen_helper_exit_atomic(cpu_env);
+        ctx->base.is_jmp = DISAS_NORETURN;
+    }
 }
 
 static void gen_lwat(DisasContext *ctx)
-- 
2.17.1
