Received: from eggs.gnu.org ([2001:4830:134:3::10]:34856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTIwR-00033D-Pt
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTIwO-0000st-MW
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:24:23 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35577)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dTIwO-0000sg-I6
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:24:20 -0400
Received: by mail-qk0-x241.google.com with SMTP id 16so2745566qkg.2
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 19:24:20 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  6 Jul 2017 16:20:57 -1000
Message-Id: <20170707022111.21836-14-rth@twiddle.net>
In-Reply-To: <20170707022111.21836-1-rth@twiddle.net>
References: <20170707022111.21836-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 13/27] target/sh4: Hoist fp register bank
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
 target/sh4/translate.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 878c0bd..fc743da 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -42,6 +42,7 @@ typedef struct DisasContext {
     int bstate;
     int memidx;
     int gbank;
+    int fbank;
     uint32_t delayed_pc;
     int singlestep_enabled;
     uint32_t features;
@@ -365,12 +366,12 @@ static inline void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
 
 #define REG(x)     cpu_gregs[(x) ^ ctx->gbank]
 #define ALTREG(x)  cpu_gregs[(x) ^ ctx->gbank ^ 0x10]
+#define FREG(x)    cpu_fregs[(x) ^ ctx->fbank]
 
-#define FREG(x) cpu_fregs[ctx->tbflags & FPSCR_FR ? (x) ^ 0x10 : (x)]
 #define XHACK(x) ((((x) & 1 ) << 4) | ((x) & 0xe))
-#define XREG(x) FREG(XHACK(x))
+#define XREG(x)  FREG(XHACK(x))
 /* Assumes lsb of (x) is always 0 */
-#define DREG(x) (ctx->tbflags & FPSCR_FR ? (x) ^ 0x10 : (x))
+#define DREG(x)  ((x) ^ ctx->fbank)
 
 #define CHECK_NOT_DELAY_SLOT \
     if (ctx->envflags & DELAY_SLOT_MASK) {                           \
@@ -2252,6 +2253,7 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
     ctx.has_movcal = (ctx.tbflags & TB_FLAG_PENDING_MOVCA);
     ctx.gbank = ((ctx.tbflags & (1 << SR_MD)) &&
                  (ctx.tbflags & (1 << SR_RB))) * 0x10;
+    ctx.fbank = ctx.tbflags & FPSCR_FR ? 0x10 : 0;
 
     max_insns = tb->cflags & CF_COUNT_MASK;
     if (max_insns == 0) {
-- 
2.9.4
