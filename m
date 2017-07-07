Received: from eggs.gnu.org ([2001:4830:134:3::10]:34490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTIvI-0001uB-7M
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:23:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTIvH-0000DV-4M
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:23:12 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35261)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dTIvH-0000DG-04
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:23:11 -0400
Received: by mail-qt0-x243.google.com with SMTP id w12so2709738qta.2
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 19:23:10 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  6 Jul 2017 16:20:54 -1000
Message-Id: <20170707022111.21836-11-rth@twiddle.net>
In-Reply-To: <20170707022111.21836-1-rth@twiddle.net>
References: <20170707022111.21836-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 10/27] target/sh4: Hoist register bank
 selection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, laurent@vivier.eu, bruno@clisp.org, glaubitz@debian.org

Compute which register bank to use once at the start of translation.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sh4/translate.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 73b3e02..0ac101e 100644
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
@@ -99,16 +100,19 @@ void sh4_translate_init(void)
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
@@ -359,13 +363,8 @@ static inline void gen_store_fpr64 (TCGv_i64 t, int reg)
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
@@ -2272,6 +2271,8 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
     ctx.singlestep_enabled = cs->singlestep_enabled;
     ctx.features = env->features;
     ctx.has_movcal = (ctx.tbflags & TB_FLAG_PENDING_MOVCA);
+    ctx.gbank = ((ctx.tbflags & (1 << SR_MD)) &&
+                 (ctx.tbflags & (1 << SR_RB))) * 0x10;
 
     max_insns = tb->cflags & CF_COUNT_MASK;
     if (max_insns == 0) {
-- 
2.9.4
