Received: from eggs.gnu.org ([2001:4830:134:3::10]:39504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXgrj-0004aw-II
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXgrf-0006ag-Qq
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:45:39 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:32932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXgrf-0006aM-Al
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:45:35 -0400
Received: by mail-pf0-x244.google.com with SMTP id e199so5068270pfh.0
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 21:45:35 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 18:45:16 -1000
Message-Id: <20170719044522.21114-3-rth@twiddle.net>
In-Reply-To: <20170719044522.21114-1-rth@twiddle.net>
References: <20170719044522.21114-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 2/8] target/alpha: Copy tb->flags into
 DisasContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Tested-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/alpha/translate.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 4a627fc..48be19a 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -49,6 +49,7 @@ struct DisasContext {
 #ifndef CONFIG_USER_ONLY
     uint64_t palbr;
 #endif
+    uint32_t tbflags;
     int mem_idx;
 
     /* implver and amask values for this CPU.  */
@@ -452,7 +453,7 @@ static ExitStatus gen_store_conditional(DisasContext *ctx, int ra, int rb,
 static bool in_superpage(DisasContext *ctx, int64_t addr)
 {
 #ifndef CONFIG_USER_ONLY
-    return ((ctx->tb->flags & TB_FLAGS_USER_MODE) == 0
+    return ((ctx->tbflags & TB_FLAGS_USER_MODE) == 0
             && addr >> TARGET_VIRT_ADDR_SPACE_BITS == -1
             && ((addr >> 41) & 3) == 2);
 #else
@@ -1167,7 +1168,7 @@ static ExitStatus gen_call_pal(DisasContext *ctx, int palcode)
 
 #ifndef CONFIG_USER_ONLY
     /* Privileged PAL code */
-    if (palcode < 0x40 && (ctx->tb->flags & TB_FLAGS_USER_MODE) == 0) {
+    if (palcode < 0x40 && (ctx->tbflags & TB_FLAGS_USER_MODE) == 0) {
         TCGv tmp;
         switch (palcode) {
         case 0x01:
@@ -1258,7 +1259,7 @@ static ExitStatus gen_call_pal(DisasContext *ctx, int palcode)
         uint64_t exc_addr = ctx->pc;
         uint64_t entry = ctx->palbr;
 
-        if (ctx->tb->flags & TB_FLAGS_PAL_MODE) {
+        if (ctx->tbflags & TB_FLAGS_PAL_MODE) {
             exc_addr |= 1;
         } else {
             tcg_gen_movi_i64(tmp, 1);
@@ -1452,7 +1453,7 @@ static ExitStatus gen_mtpr(DisasContext *ctx, TCGv vb, int regno)
 
 #define REQUIRE_TB_FLAG(FLAG)                   \
     do {                                        \
-        if ((ctx->tb->flags & (FLAG)) == 0) {   \
+        if ((ctx->tbflags & (FLAG)) == 0) {     \
             goto invalid_opc;                   \
         }                                       \
     } while (0)
@@ -2932,6 +2933,7 @@ void gen_intermediate_code(CPUAlphaState *env, struct TranslationBlock *tb)
 
     ctx.tb = tb;
     ctx.pc = pc_start;
+    ctx.tbflags = tb->flags;
     ctx.mem_idx = cpu_mmu_index(env, false);
     ctx.implver = env->implver;
     ctx.amask = env->amask;
@@ -2941,7 +2943,7 @@ void gen_intermediate_code(CPUAlphaState *env, struct TranslationBlock *tb)
     ctx.ir = cpu_std_ir;
 #else
     ctx.palbr = env->palbr;
-    ctx.ir = (tb->flags & TB_FLAGS_PAL_MODE ? cpu_pal_ir : cpu_std_ir);
+    ctx.ir = (ctx.tbflags & TB_FLAGS_PAL_MODE ? cpu_pal_ir : cpu_std_ir);
 #endif
 
     /* ??? Every TB begins with unset rounding mode, to be initialized on
-- 
2.9.4
