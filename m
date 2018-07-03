Received: from eggs.gnu.org ([2001:4830:134:3::10]:39956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKZ-0002uj-Ro
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKV-00070i-5P
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:27 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  3 Jul 2018 15:57:50 +1000
Message-Id: <20180703055804.13449-22-david@gibson.dropbear.id.au>
In-Reply-To: <20180703055804.13449-1-david@gibson.dropbear.id.au>
References: <20180703055804.13449-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 21/35] target/ppc: Use atomic min/max helpers
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

These operations were previously unimplemented for ppc.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index c2a28be6d7..79285b6698 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3102,13 +3102,21 @@ static void gen_ld_atomic(DisasContext *ctx, TCGMemOp memop)
     case 3: /* Fetch and 'and' */
         tcg_gen_atomic_fetch_and_tl(dst, EA, src, ctx->mem_idx, memop);
         break;
-    case 8: /* Swap */
-        tcg_gen_atomic_xchg_tl(dst, EA, src, ctx->mem_idx, memop);
-        break;
     case 4:  /* Fetch and max unsigned */
+        tcg_gen_atomic_fetch_umax_tl(dst, EA, src, ctx->mem_idx, memop);
+        break;
     case 5:  /* Fetch and max signed */
+        tcg_gen_atomic_fetch_smax_tl(dst, EA, src, ctx->mem_idx, memop);
+        break;
     case 6:  /* Fetch and min unsigned */
+        tcg_gen_atomic_fetch_umin_tl(dst, EA, src, ctx->mem_idx, memop);
+        break;
     case 7:  /* Fetch and min signed */
+        tcg_gen_atomic_fetch_smin_tl(dst, EA, src, ctx->mem_idx, memop);
+        break;
+    case 8: /* Swap */
+        tcg_gen_atomic_xchg_tl(dst, EA, src, ctx->mem_idx, memop);
+        break;
     case 16: /* compare and swap not equal */
     case 24: /* Fetch and increment bounded */
     case 25: /* Fetch and increment equal */
@@ -3159,9 +3167,17 @@ static void gen_st_atomic(DisasContext *ctx, TCGMemOp memop)
         tcg_gen_atomic_and_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
         break;
     case 4:  /* Store max unsigned */
+        tcg_gen_atomic_umax_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
+        break;
     case 5:  /* Store max signed */
+        tcg_gen_atomic_smax_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
+        break;
     case 6:  /* Store min unsigned */
+        tcg_gen_atomic_umin_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
+        break;
     case 7:  /* Store min signed */
+        tcg_gen_atomic_smin_fetch_tl(discard, EA, src, ctx->mem_idx, memop);
+        break;
     case 24: /* Store twin  */
         gen_invalid(ctx);
         break;
-- 
2.17.1
