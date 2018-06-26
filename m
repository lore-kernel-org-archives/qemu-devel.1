Received: from eggs.gnu.org ([2001:4830:134:3::10]:42624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXqgz-00014q-Gp
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXqgw-000606-LW
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:19:45 -0400
Received: from mail-pl0-x22f.google.com ([2607:f8b0:400e:c01::22f]:42590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXqgw-0005zr-Am
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:19:42 -0400
Received: by mail-pl0-x22f.google.com with SMTP id w17-v6so8772374pll.9
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 09:19:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 26 Jun 2018 09:19:19 -0700
Message-Id: <20180626161921.27941-12-richard.henderson@linaro.org>
In-Reply-To: <20180626161921.27941-1-richard.henderson@linaro.org>
References: <20180626161921.27941-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 11/13] target/ppc: Use atomic min/max helpers
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

These operations were previously unimplemented for ppc.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/translate.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index c2a28be6d7..79285b6698 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3102,13 +3102,21 @@ static void gen_ld_atomic(DisasContext *ctx, TCGMemOp memop)
     case 3: /* Fetch and 'and' */
         tcg_gen_atomic_fetch_and_tl(dst, EA, src, ctx->mem_idx, memop);
         break;
+    case 4:  /* Fetch and max unsigned */
+        tcg_gen_atomic_fetch_umax_tl(dst, EA, src, ctx->mem_idx, memop);
+        break;
+    case 5:  /* Fetch and max signed */
+        tcg_gen_atomic_fetch_smax_tl(dst, EA, src, ctx->mem_idx, memop);
+        break;
+    case 6:  /* Fetch and min unsigned */
+        tcg_gen_atomic_fetch_umin_tl(dst, EA, src, ctx->mem_idx, memop);
+        break;
+    case 7:  /* Fetch and min signed */
+        tcg_gen_atomic_fetch_smin_tl(dst, EA, src, ctx->mem_idx, memop);
+        break;
     case 8: /* Swap */
         tcg_gen_atomic_xchg_tl(dst, EA, src, ctx->mem_idx, memop);
         break;
-    case 4:  /* Fetch and max unsigned */
-    case 5:  /* Fetch and max signed */
-    case 6:  /* Fetch and min unsigned */
-    case 7:  /* Fetch and min signed */
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
