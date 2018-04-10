Received: from eggs.gnu.org ([2001:4830:134:3::10]:45376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f5slV-00078S-Gx
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:52:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f5slS-0002eO-Vf
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:52:49 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 10 Apr 2018 22:52:27 +1000
Message-Id: <20180410125233.31618-2-david@gibson.dropbear.id.au>
In-Reply-To: <20180410125233.31618-1-david@gibson.dropbear.id.au>
References: <20180410125233.31618-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 1/7] target/ppc: Initialize lazy_tlb_flush
 correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

ppc_tr_init_disas_context() correctly sets lazy_tlb_flush to true on
certain CPU models.  However, it leaves it uninitialized, instead of
setting it to false on all others.

It wasn't caught before now because we didn't have examples in the tests
that exercised this path.  However it can now be caught using clang's
undefined behaviour sanitizer and the sam460ex board.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/translate.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 218665b408..3457d29f8e 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7237,10 +7237,9 @@ static int ppc_tr_init_disas_context(DisasContextBase *dcbase,
     ctx->sf_mode = msr_is_64bit(env, env->msr);
     ctx->has_cfar = !!(env->flags & POWERPC_FLAG_CFAR);
 #endif
-    if (env->mmu_model == POWERPC_MMU_32B ||
-        env->mmu_model == POWERPC_MMU_601 ||
-        (env->mmu_model & POWERPC_MMU_64B))
-            ctx->lazy_tlb_flush = true;
+    ctx->lazy_tlb_flush = env->mmu_model == POWERPC_MMU_32B
+        || env->mmu_model == POWERPC_MMU_601
+        || (env->mmu_model & POWERPC_MMU_64B);
 
     ctx->fpu_enabled = !!msr_fp;
     if ((env->flags & POWERPC_FLAG_SPE) && msr_spe)
-- 
2.14.3
