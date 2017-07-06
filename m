Received: from eggs.gnu.org ([2001:4830:134:3::10]:59729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dSub6-0007aP-CX
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 20:24:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dSub3-0002R0-7S
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 20:24:44 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dSub3-0002Qs-3B
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 20:24:41 -0400
Received: by mail-qk0-x244.google.com with SMTP id p21so661623qke.0
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 17:24:41 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed,  5 Jul 2017 14:23:56 -1000
Message-Id: <20170706002401.10507-7-rth@twiddle.net>
In-Reply-To: <20170706002401.10507-1-rth@twiddle.net>
References: <20170706002401.10507-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 06/11] target/sh4: Hoist register bank selection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, bruno@clisp.org

Compute which register bank to use once at the start of translation.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sh4/translate.c | 43 ++++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 9ab7d6e..20e24d5 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -35,6 +35,8 @@
 
 typedef struct DisasContext {
     struct TranslationBlock *tb;
+    TCGv *gregs;         /* active bank */
+    TCGv *altregs;       /* inactive, alternate, bank */
     target_ulong pc;
     uint16_t opcode;
     uint32_t tbflags;    /* should stay unmodified during the TB translation */
@@ -64,7 +66,7 @@ enum {
 
 /* global register indexes */
 static TCGv_env cpu_env;
-static TCGv cpu_gregs[24];
+static TCGv cpu_gregs[2][16];
 static TCGv cpu_sr, cpu_sr_m, cpu_sr_q, cpu_sr_t;
 static TCGv cpu_pc, cpu_ssr, cpu_spc, cpu_gbr;
 static TCGv cpu_vbr, cpu_sgr, cpu_dbr, cpu_mach, cpu_macl;
@@ -99,16 +101,31 @@ void sh4_translate_init(void)
         "FPR12_BANK1", "FPR13_BANK1", "FPR14_BANK1", "FPR15_BANK1",
     };
 
-    if (done_init)
+    if (done_init) {
         return;
+    }
 
     cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
     tcg_ctx.tcg_env = cpu_env;
 
-    for (i = 0; i < 24; i++)
-        cpu_gregs[i] = tcg_global_mem_new_i32(cpu_env,
-                                              offsetof(CPUSH4State, gregs[i]),
-                                              gregnames[i]);
+    for (i = 0; i < 8; i++) {
+        cpu_gregs[0][i]
+            = tcg_global_mem_new_i32(cpu_env,
+                                     offsetof(CPUSH4State, gregs[i]),
+                                     gregnames[i]);
+    }
+    for (i = 8; i < 16; i++) {
+        cpu_gregs[0][i] = cpu_gregs[1][i]
+            = tcg_global_mem_new_i32(cpu_env,
+                                     offsetof(CPUSH4State, gregs[i]),
+                                     gregnames[i]);
+    }
+    for (i = 16; i < 24; i++) {
+        cpu_gregs[1][i - 16]
+            = tcg_global_mem_new_i32(cpu_env,
+                                     offsetof(CPUSH4State, gregs[i]),
+                                     gregnames[i]);
+    }
 
     cpu_pc = tcg_global_mem_new_i32(cpu_env,
                                     offsetof(CPUSH4State, pc), "PC");
@@ -362,13 +379,8 @@ static inline void gen_store_fpr64 (TCGv_i64 t, int reg)
 #define B11_8 ((ctx->opcode >> 8) & 0xf)
 #define B15_12 ((ctx->opcode >> 12) & 0xf)
 
-#define REG(x) ((x) < 8 && (ctx->tbflags & (1u << SR_MD))\
-                        && (ctx->tbflags & (1u << SR_RB))\
-                ? (cpu_gregs[x + 16]) : (cpu_gregs[x]))
-
-#define ALTREG(x) ((x) < 8 && (!(ctx->tbflags & (1u << SR_MD))\
-                               || !(ctx->tbflags & (1u << SR_RB)))\
-		? (cpu_gregs[x + 16]) : (cpu_gregs[x]))
+#define REG(x)     ctx->gregs[x]
+#define ALTREG(x)  ctx->altregs[x]
 
 #define FREG(x) (ctx->tbflags & FPSCR_FR ? (x) ^ 0x10 : (x))
 #define XHACK(x) ((((x) & 1 ) << 4) | ((x) & 0xe))
@@ -2214,6 +2226,7 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
     target_ulong pc_start;
     int num_insns;
     int max_insns;
+    int bank;
 
     pc_start = tb->pc;
     ctx.pc = pc_start;
@@ -2229,6 +2242,10 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
     ctx.features = env->features;
     ctx.has_movcal = (ctx.tbflags & TB_FLAG_PENDING_MOVCA);
 
+    bank = (ctx.tbflags & (1 << SR_MD)) && (ctx.tbflags & (1 << SR_RB));
+    ctx.gregs = cpu_gregs[bank];
+    ctx.altregs = cpu_gregs[bank ^ 1];
+
     max_insns = tb->cflags & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
-- 
2.9.4
