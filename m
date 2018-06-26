Received: from eggs.gnu.org ([2001:4830:134:3::10]:42683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXqh1-00016u-5K
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:19:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXqh0-00061w-3q
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:19:47 -0400
Received: from mail-pl0-x22d.google.com ([2607:f8b0:400e:c01::22d]:38635)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXqgz-00061M-T0
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:19:46 -0400
Received: by mail-pl0-x22d.google.com with SMTP id d10-v6so8792861plo.5
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 09:19:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 26 Jun 2018 09:19:21 -0700
Message-Id: <20180626161921.27941-14-richard.henderson@linaro.org>
In-Reply-To: <20180626161921.27941-1-richard.henderson@linaro.org>
References: <20180626161921.27941-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 13/13] target/ppc: Implement the rest of
 gen_st_atomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

The store twin case was stubbed out.  For now, implement it only within
a serial context, forcing parallel execution to synchronize.  It would
be possible to implement with a cmpxchg loop, if we care, but the loose
alignment requirements (simply no crossing 32-byte boundary) might send
us back to the serial context anyway.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
