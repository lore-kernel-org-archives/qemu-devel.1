Received: from eggs.gnu.org ([2001:4830:134:3::10]:36687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dR0na-0005Ix-Nt
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 14:37:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dR0nX-0005Xp-JB
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 14:37:46 -0400
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 30 Jun 2017 11:37:36 -0700
Message-Id: <20170630183736.13222-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH] target/ppc: Use tcg_gen_lookup_and_goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org

Cc: qemu-ppc@nongnu.org
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/ppc/translate.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index c0cd64d..9aa66f5 100644
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
+        tcg_gen_lookup_and_goto_ptr(cpu_nip);
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
+        tcg_gen_lookup_and_goto_ptr(cpu_nip);
         tcg_temp_free(target);
     }
+    if ((bo & 0x14) != 0x14) {
+        gen_set_label(l1);
+        gen_goto_tb(ctx, 1, ctx->nip);
+    }
 }
 
 static void gen_bc(DisasContext *ctx)
-- 
2.9.4
