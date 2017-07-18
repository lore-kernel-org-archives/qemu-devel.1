Received: from eggs.gnu.org ([2001:4830:134:3::10]:48125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaOZ-0004kl-9g
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:51:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaOY-0003WV-7a
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:51:07 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:48430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dXaOY-0003Uv-1Z
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:51:06 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue, 18 Jul 2017 23:50:33 +0200
Message-Id: <20170718215050.3812-15-aurelien@aurel32.net>
In-Reply-To: <20170718215050.3812-1-aurelien@aurel32.net>
References: <20170718215050.3812-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PULL 14/31] target/sh4: Hoist register bank selection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>

From: Richard Henderson <rth@twiddle.net>

Compute which register bank to use once at the start of translation.

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-Id: <20170718200255.31647-11-rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/translate.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 385b69ef14..d6e05f77fe 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -41,6 +41,7 @@ typedef struct DisasContext {
     uint32_t envflags;   /* should stay in sync with env->flags using TCG ops */
     int bstate;
     int memidx;
+    int gbank;
     uint32_t delayed_pc;
     int singlestep_enabled;
     uint32_t features;
@@ -64,7 +65,7 @@ enum {
 
 /* global register indexes */
 static TCGv_env cpu_env;
-static TCGv cpu_gregs[24];
+static TCGv cpu_gregs[32];
 static TCGv cpu_sr, cpu_sr_m, cpu_sr_q, cpu_sr_t;
 static TCGv cpu_pc, cpu_ssr, cpu_spc, cpu_gbr;
 static TCGv cpu_vbr, cpu_sgr, cpu_dbr, cpu_mach, cpu_macl;
@@ -98,16 +99,19 @@ void sh4_translate_init(void)
         "FPR12_BANK1", "FPR13_BANK1", "FPR14_BANK1", "FPR15_BANK1",
     };
 
-    if (done_init)
+    if (done_init) {
         return;
+    }
 
     cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
     tcg_ctx.tcg_env = cpu_env;
 
-    for (i = 0; i < 24; i++)
+    for (i = 0; i < 24; i++) {
         cpu_gregs[i] = tcg_global_mem_new_i32(cpu_env,
                                               offsetof(CPUSH4State, gregs[i]),
                                               gregnames[i]);
+    }
+    memcpy(cpu_gregs + 24, cpu_gregs + 8, 8 * sizeof(TCGv));
 
     cpu_pc = tcg_global_mem_new_i32(cpu_env,
                                     offsetof(CPUSH4State, pc), "PC");
@@ -347,13 +351,8 @@ static inline void gen_store_fpr64 (TCGv_i64 t, int reg)
 #define B11_8 ((ctx->opcode >> 8) & 0xf)
 #define B15_12 ((ctx->opcode >> 12) & 0xf)
 
-#define REG(x) ((x) < 8 && (ctx->tbflags & (1u << SR_MD))\
-                        && (ctx->tbflags & (1u << SR_RB))\
-                ? (cpu_gregs[x + 16]) : (cpu_gregs[x]))
-
-#define ALTREG(x) ((x) < 8 && (!(ctx->tbflags & (1u << SR_MD))\
-                               || !(ctx->tbflags & (1u << SR_RB)))\
-		? (cpu_gregs[x + 16]) : (cpu_gregs[x]))
+#define REG(x)     cpu_gregs[(x) ^ ctx->gbank]
+#define ALTREG(x)  cpu_gregs[(x) ^ ctx->gbank ^ 0x10]
 
 #define FREG(x) (ctx->tbflags & FPSCR_FR ? (x) ^ 0x10 : (x))
 #define XHACK(x) ((((x) & 1 ) << 4) | ((x) & 0xe))
@@ -2252,6 +2251,8 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
     ctx.singlestep_enabled = cs->singlestep_enabled;
     ctx.features = env->features;
     ctx.has_movcal = (ctx.tbflags & TB_FLAG_PENDING_MOVCA);
+    ctx.gbank = ((ctx.tbflags & (1 << SR_MD)) &&
+                 (ctx.tbflags & (1 << SR_RB))) * 0x10;
 
     max_insns = tb->cflags & CF_COUNT_MASK;
     if (max_insns == 0) {
-- 
2.11.0
