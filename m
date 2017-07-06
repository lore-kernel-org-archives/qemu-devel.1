Received: from eggs.gnu.org ([2001:4830:134:3::10]:59807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dSubF-0007ih-W9
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 20:24:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dSubF-0002UK-2R
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 20:24:53 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dSubE-0002UC-U0
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 20:24:52 -0400
Received: by mail-qk0-x243.google.com with SMTP id v143so639842qkb.3
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 17:24:52 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed,  5 Jul 2017 14:24:00 -1000
Message-Id: <20170706002401.10507-11-rth@twiddle.net>
In-Reply-To: <20170706002401.10507-1-rth@twiddle.net>
References: <20170706002401.10507-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 10/11] target/sh4: Hoist fp bank selection
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

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sh4/translate.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 7f015c3..a45d0ee 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -37,6 +37,7 @@ typedef struct DisasContext {
     struct TranslationBlock *tb;
     TCGv *gregs;         /* active bank */
     TCGv *altregs;       /* inactive, alternate, bank */
+    TCGv *fregs;         /* active bank */
     target_ulong pc;
     uint16_t opcode;
     uint32_t tbflags;    /* should stay unmodified during the TB translation */
@@ -72,7 +73,7 @@ static TCGv cpu_pc, cpu_ssr, cpu_spc, cpu_gbr;
 static TCGv cpu_vbr, cpu_sgr, cpu_dbr, cpu_mach, cpu_macl;
 static TCGv cpu_pr, cpu_fpscr, cpu_fpul;
 static TCGv cpu_lock_addr, cpu_lock_value;
-static TCGv cpu_fregs[32];
+static TCGv cpu_fregs[2][16];
 
 /* internal register indexes */
 static TCGv cpu_flags, cpu_delayed_pc, cpu_delayed_cond;
@@ -176,10 +177,18 @@ void sh4_translate_init(void)
 				            offsetof(CPUSH4State, lock_value),
                                             "_lock_value_");
 
-    for (i = 0; i < 32; i++)
-        cpu_fregs[i] = tcg_global_mem_new_i32(cpu_env,
-                                              offsetof(CPUSH4State, fregs[i]),
-                                              fregnames[i]);
+    for (i = 0; i < 16; i++) {
+        cpu_fregs[0][i]
+            = tcg_global_mem_new_i32(cpu_env,
+                                     offsetof(CPUSH4State, fregs[i]),
+                                     fregnames[i]);
+    }
+    for (i = 16; i < 32; i++) {
+        cpu_fregs[1][i - 16]
+            = tcg_global_mem_new_i32(cpu_env,
+                                     offsetof(CPUSH4State, fregs[i]),
+                                     fregnames[i]);
+    }
 
     done_init = 1;
 }
@@ -365,12 +374,12 @@ static void gen_delayed_conditional_jump(DisasContext * ctx)
    low register means we can't crash the translator for REG==15.  */
 static void gen_load_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
 {
-    tcg_gen_concat_i32_i64(t, cpu_fregs[reg | 1], cpu_fregs[reg]);
+    tcg_gen_concat_i32_i64(t, ctx->fregs[reg | 1], ctx->fregs[reg]);
 }
 
 static void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
 {
-    tcg_gen_extr_i64_i32(cpu_fregs[reg | 1], cpu_fregs[reg], t);
+    tcg_gen_extr_i64_i32(ctx->fregs[reg | 1], ctx->fregs[reg], t);
 }
 
 #define B3_0 (ctx->opcode & 0xf)
@@ -386,10 +395,10 @@ static void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
 #define REG(x)     ctx->gregs[x]
 #define ALTREG(x)  ctx->altregs[x]
 
-#define FREG(x) cpu_fregs[ctx->tbflags & FPSCR_FR ? (x) ^ 0x10 : (x)]
-#define XHACK(x) ((((x) & 1 ) << 4) | ((x) & 0xe))
-#define XREG(x) FREG(XHACK(x))
-#define DREG(x) (ctx->tbflags & FPSCR_FR ? (x) ^ 0x10 : (x))
+#define FREG(x)    ctx->fregs[x]
+#define XHACK(x)   ((((x) & 1 ) << 4) | ((x) & 0xe))
+#define XREG(x)    FREG(XHACK(x))
+#define DREG(x)    (x)
 
 #define CHECK_NOT_DELAY_SLOT \
     if (ctx->envflags & DELAY_SLOT_MASK) {                           \
@@ -2230,6 +2239,9 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
     ctx.gregs = cpu_gregs[bank];
     ctx.altregs = cpu_gregs[bank ^ 1];
 
+    bank = (ctx.tbflags & FPSCR_FR) != 0;
+    ctx.fregs = cpu_fregs[bank];
+
     max_insns = tb->cflags & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
-- 
2.9.4
