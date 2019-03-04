Received: from eggs.gnu.org ([209.51.188.92]:44254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0sAO-00089A-KW
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:18:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0sAN-0000e5-6F
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:18:20 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  4 Mar 2019 13:17:09 -0500
Message-Id: <20190304181813.8075-10-cota@braap.org>
In-Reply-To: <20190304181813.8075-1-cota@braap.org>
References: <20190304181813.8075-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 09/73] ppc: convert to helper_cpu_halted_set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org

Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/ppc/translate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 819221f246..5835e85a2f 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1572,8 +1572,7 @@ GEN_LOGICAL2(nor, tcg_gen_nor_tl, 0x03, PPC_INTEGER);
 static void gen_pause(DisasContext *ctx)
 {
     TCGv_i32 t0 = tcg_const_i32(0);
-    tcg_gen_st_i32(t0, cpu_env,
-                   -offsetof(PowerPCCPU, env) + offsetof(CPUState, halted));
+    gen_helper_cpu_halted_set(cpu_env, t0);
     tcg_temp_free_i32(t0);
 
     /* Stop translation, this gives other CPUs a chance to run */
@@ -3547,8 +3546,7 @@ static void gen_sync(DisasContext *ctx)
 static void gen_wait(DisasContext *ctx)
 {
     TCGv_i32 t0 = tcg_const_i32(1);
-    tcg_gen_st_i32(t0, cpu_env,
-                   -offsetof(PowerPCCPU, env) + offsetof(CPUState, halted));
+    gen_helper_cpu_halted_set(cpu_env, t0);
     tcg_temp_free_i32(t0);
     /* Stop translation, as the CPU is supposed to sleep from now */
     gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
-- 
2.17.1
