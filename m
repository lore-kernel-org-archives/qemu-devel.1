Received: from eggs.gnu.org ([2001:4830:134:3::10]:55062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJCN-0007PP-HQ
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJCI-0001AK-A3
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:09 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 13 Dec 2018 00:03:49 -0500
Message-Id: <20181213050453.9677-10-cota@braap.org>
In-Reply-To: <20181213050453.9677-1-cota@braap.org>
References: <20181213050453.9677-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 09/73] ppc: convert to helper_cpu_halted_set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>
Cc: qemu-ppc@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/ppc/translate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 2b37910248..4bb78f403e 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1609,8 +1609,7 @@ GEN_LOGICAL2(nor, tcg_gen_nor_tl, 0x03, PPC_INTEGER);
 static void gen_pause(DisasContext *ctx)
 {
     TCGv_i32 t0 = tcg_const_i32(0);
-    tcg_gen_st_i32(t0, cpu_env,
-                   -offsetof(PowerPCCPU, env) + offsetof(CPUState, halted));
+    gen_helper_cpu_halted_set(cpu_env, t0);
     tcg_temp_free_i32(t0);
 
     /* Stop translation, this gives other CPUs a chance to run */
@@ -3584,8 +3583,7 @@ static void gen_sync(DisasContext *ctx)
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
