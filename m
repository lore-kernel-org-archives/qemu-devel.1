Received: from eggs.gnu.org ([2001:4830:134:3::10]:48608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaPl-0005jd-F2
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaPk-000400-CN
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:21 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:48478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dXaOY-0003V8-3f
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:20 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue, 18 Jul 2017 23:50:36 +0200
Message-Id: <20170718215050.3812-18-aurelien@aurel32.net>
In-Reply-To: <20170718215050.3812-1-aurelien@aurel32.net>
References: <20170718215050.3812-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PULL 17/31] target/sh4: Hoist fp register bank
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
Cc: Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>

From: Richard Henderson <rth@twiddle.net>

Compute which register bank to use once at the start of translation.

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-Id: <20170718200255.31647-14-rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/translate.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index b706a6a153..bc6f33970b 100644
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
@@ -353,12 +354,12 @@ static inline void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
 
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
@@ -2232,6 +2233,7 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
     ctx.has_movcal = (ctx.tbflags & TB_FLAG_PENDING_MOVCA);
     ctx.gbank = ((ctx.tbflags & (1 << SR_MD)) &&
                  (ctx.tbflags & (1 << SR_RB))) * 0x10;
+    ctx.fbank = ctx.tbflags & FPSCR_FR ? 0x10 : 0;
 
     max_insns = tb->cflags & CF_COUNT_MASK;
     if (max_insns == 0) {
-- 
2.11.0
