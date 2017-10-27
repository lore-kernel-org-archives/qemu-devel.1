Received: from eggs.gnu.org ([2001:4830:134:3::10]:33717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e87xn-0007ly-A3
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e87xj-0001hY-5w
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:58:31 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:53722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e87xi-0001W5-Td
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:58:27 -0400
Received: by mail-wm0-x244.google.com with SMTP id r196so5028858wmf.2
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 09:58:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 27 Oct 2017 18:58:14 +0200
Message-Id: <20171027165814.29122-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2] target/ppc: Use tcg_gen_lookup_and_goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
Rebased and updated for changes to tcg_gen_lookup_and_goto_ptr.

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
2.13.6
