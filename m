Received: from eggs.gnu.org ([2001:4830:134:3::10]:59797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dSubF-0007hw-3e
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 20:24:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dSubB-0002TE-Uz
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 20:24:53 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dSubB-0002T5-QH
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 20:24:49 -0400
Received: by mail-qt0-x242.google.com with SMTP id m54so645959qtb.1
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 17:24:49 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed,  5 Jul 2017 14:23:59 -1000
Message-Id: <20170706002401.10507-10-rth@twiddle.net>
In-Reply-To: <20170706002401.10507-1-rth@twiddle.net>
References: <20170706002401.10507-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 09/11] target/sh4: Avoid a potential translator
 crash for malformed FPR64
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

Produce valid, but nonsensical, code given an odd register index.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sh4/translate.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 05657a9..7f015c3 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -359,14 +359,18 @@ static void gen_delayed_conditional_jump(DisasContext * ctx)
     gen_jump(ctx);
 }
 
-static inline void gen_load_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
+/* Assumes lsb of (x) is always 0.  */
+/* ??? Should the translator should signal an invalid opc?
+   In the meantime, using OR instead of PLUS to form the index of the
+   low register means we can't crash the translator for REG==15.  */
+static void gen_load_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
 {
-    tcg_gen_concat_i32_i64(t, cpu_fregs[reg + 1], cpu_fregs[reg]);
+    tcg_gen_concat_i32_i64(t, cpu_fregs[reg | 1], cpu_fregs[reg]);
 }
 
-static inline void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
+static void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
 {
-    tcg_gen_extr_i64_i32(cpu_fregs[reg + 1], cpu_fregs[reg], t);
+    tcg_gen_extr_i64_i32(cpu_fregs[reg | 1], cpu_fregs[reg], t);
 }
 
 #define B3_0 (ctx->opcode & 0xf)
@@ -385,7 +389,6 @@ static inline void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
 #define FREG(x) cpu_fregs[ctx->tbflags & FPSCR_FR ? (x) ^ 0x10 : (x)]
 #define XHACK(x) ((((x) & 1 ) << 4) | ((x) & 0xe))
 #define XREG(x) FREG(XHACK(x))
-/* Assumes lsb of (x) is always 0 */
 #define DREG(x) (ctx->tbflags & FPSCR_FR ? (x) ^ 0x10 : (x))
 
 #define CHECK_NOT_DELAY_SLOT \
-- 
2.9.4
