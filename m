Received: from eggs.gnu.org ([209.51.188.92]:35174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe3O-00084l-8F
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe3J-0000n7-N4
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:31 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46775)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1goe3H-0000fe-8X
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:28 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 29 Jan 2019 19:47:11 -0500
Message-Id: <20190130004811.27372-14-cota@braap.org>
In-Reply-To: <20190130004811.27372-1-cota@braap.org>
References: <20190130004811.27372-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 13/73] alpha: convert to
 helper_cpu_halted_set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/alpha/translate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 9d8f9b3eea..a75413e9b5 100644
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
