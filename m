Received: from eggs.gnu.org ([2001:4830:134:3::10]:60776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFh5V-0004Uf-Nx
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:58:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFgum-0007mL-MZ
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:17 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:52773)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFgui-0007ew-UK
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:10 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 10:45:45 -0400
Message-Id: <20181025144644.15464-12-cota@braap.org>
In-Reply-To: <20181025144644.15464-1-cota@braap.org>
References: <20181025144644.15464-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v4 12/71] alpha: convert to helper_cpu_halted_set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/alpha/translate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index e5d62850c5..25cd95931d 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -1226,8 +1226,7 @@ static DisasJumpType gen_call_pal(DisasContext *ctx, int palcode)
             /* WTINT */
             {
                 TCGv_i32 tmp = tcg_const_i32(1);
-                tcg_gen_st_i32(tmp, cpu_env, -offsetof(AlphaCPU, env) +
-                                             offsetof(CPUState, halted));
+                gen_helper_cpu_halted_set(cpu_env, tmp);
                 tcg_temp_free_i32(tmp);
             }
             tcg_gen_movi_i64(ctx->ir[IR_V0], 0);
@@ -1382,8 +1381,7 @@ static DisasJumpType gen_mtpr(DisasContext *ctx, TCGv vb, int regno)
         /* WAIT */
         {
             TCGv_i32 tmp = tcg_const_i32(1);
-            tcg_gen_st_i32(tmp, cpu_env, -offsetof(AlphaCPU, env) +
-                                         offsetof(CPUState, halted));
+            gen_helper_cpu_halted_set(cpu_env, tmp);
             tcg_temp_free_i32(tmp);
         }
         return gen_excp(ctx, EXCP_HALTED, 0);
-- 
2.17.1
