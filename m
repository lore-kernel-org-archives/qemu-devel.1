Received: from eggs.gnu.org ([2001:4830:134:3::10]:55920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8fUr-0005HO-Dd
	for qemu-devel@nongnu.org; Thu, 11 May 2017 00:14:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8fUq-0001Lf-Cm
	for qemu-devel@nongnu.org; Thu, 11 May 2017 00:14:37 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 11 May 2017 14:14:07 +1000
Message-Id: <20170511041426.6488-5-david@gibson.dropbear.id.au>
In-Reply-To: <20170511041426.6488-1-david@gibson.dropbear.id.au>
References: <20170511041426.6488-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 04/23] target/ppc: Generate fence operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, agraf@suse.de, aik@ozlabs.ru, sjitindarsingh@gmail.com, mark.cave-ayland@ilande.co.uk, sam.bobroff@au1.ibm.com, nikunj@linux.vnet.ibm.com, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 50b6d4d..4a1f24a 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2971,6 +2971,7 @@ static void gen_stswx(DisasContext *ctx)
 /* eieio */
 static void gen_eieio(DisasContext *ctx)
 {
+    tcg_gen_mb(TCG_MO_LD_ST | TCG_BAR_SC);
 }
 
 #if !defined(CONFIG_USER_ONLY)
@@ -3008,6 +3009,7 @@ static void gen_isync(DisasContext *ctx)
     if (!ctx->pr) {
         gen_check_tlb_flush(ctx, false);
     }
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
     gen_stop_exception(ctx);
 }
 
@@ -3028,6 +3030,7 @@ static void gen_##name(DisasContext *ctx)                            \
     tcg_gen_qemu_ld_tl(gpr, t0, ctx->mem_idx, memop);                \
     tcg_gen_mov_tl(cpu_reserve, t0);                                 \
     tcg_gen_mov_tl(cpu_reserve_val, gpr);                            \
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);                           \
     tcg_temp_free(t0);                                               \
 }
 
@@ -3177,6 +3180,10 @@ static void gen_conditional_store(DisasContext *ctx, TCGv EA,
     tcg_gen_br(l2);
 
     gen_set_label(l1);
+
+    /* Address mismatch implies failure.  But we still need to provide the
+       memory barrier semantics of the instruction.  */
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
     tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
 
     gen_set_label(l2);
@@ -3308,6 +3315,7 @@ static void gen_sync(DisasContext *ctx)
     if (((l == 2) || !(ctx->insns_flags & PPC_64B)) && !ctx->pr) {
         gen_check_tlb_flush(ctx, true);
     }
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
 }
 
 /* wait */
-- 
2.9.3
