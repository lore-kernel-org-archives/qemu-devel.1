Received: from eggs.gnu.org ([2001:4830:134:3::10]:53061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePixI-0003Zv-Mu
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:54:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePixH-0004aO-Qz
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:54:44 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Dec 2017 16:54:12 +1100
Message-Id: <20171215055435.24204-2-david@gibson.dropbear.id.au>
In-Reply-To: <20171215055435.24204-1-david@gibson.dropbear.id.au>
References: <20171215055435.24204-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 01/24] target/ppc: Use
 tcg_gen_lookup_and_goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, mdroth@linux.vnet.ibm.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>

From: Richard Henderson <rth@twiddle.net>

Signed-off-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 998fbed848..4075fc8589 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3419,7 +3419,7 @@ static inline bool use_goto_tb(DisasContext *ctx, target_ulong dest)
 }
 
 /***                                Branch                                 ***/
-static inline void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
+static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
 {
     if (NARROW_MODE(ctx)) {
         dest = (uint32_t) dest;
@@ -3441,7 +3441,7 @@ static inline void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
                 gen_debug_exception(ctx);
             }
         }
-        tcg_gen_exit_tb(0);
+        tcg_gen_lookup_and_goto_ptr();
     }
 }
 
@@ -3479,7 +3479,7 @@ static void gen_b(DisasContext *ctx)
 #define BCOND_CTR 2
 #define BCOND_TAR 3
 
-static inline void gen_bcond(DisasContext *ctx, int type)
+static void gen_bcond(DisasContext *ctx, int type)
 {
     uint32_t bo = BO(ctx->opcode);
     TCGLabel *l1;
@@ -3543,26 +3543,19 @@ static inline void gen_bcond(DisasContext *ctx, int type)
         } else {
             gen_goto_tb(ctx, 0, li);
         }
-        if ((bo & 0x14) != 0x14) {
-            gen_set_label(l1);
-            gen_goto_tb(ctx, 1, ctx->nip);
-        }
     } else {
         if (NARROW_MODE(ctx)) {
             tcg_gen_andi_tl(cpu_nip, target, (uint32_t)~3);
         } else {
             tcg_gen_andi_tl(cpu_nip, target, ~3);
         }
-        tcg_gen_exit_tb(0);
-        if ((bo & 0x14) != 0x14) {
-            gen_set_label(l1);
-            gen_update_nip(ctx, ctx->nip);
-            tcg_gen_exit_tb(0);
-        }
-    }
-    if (type == BCOND_LR || type == BCOND_CTR || type == BCOND_TAR) {
+        tcg_gen_lookup_and_goto_ptr();
         tcg_temp_free(target);
     }
+    if ((bo & 0x14) != 0x14) {
+        gen_set_label(l1);
+        gen_goto_tb(ctx, 1, ctx->nip);
+    }
 }
 
 static void gen_bc(DisasContext *ctx)
-- 
2.14.3
