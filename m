Received: from eggs.gnu.org ([2001:4830:134:3::10]:49862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYjB-0006ay-Ul
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYjB-0004oA-3O
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:17 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXYjB-0004nh-01
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:17 -0400
Received: by mail-qt0-x244.google.com with SMTP id 19so3682001qty.1
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 13:04:16 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 10:02:43 -1000
Message-Id: <20170718200255.31647-19-rth@twiddle.net>
In-Reply-To: <20170718200255.31647-1-rth@twiddle.net>
References: <20170718200255.31647-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 18/30] target/sh4: Unify code for
 CHECK_NOT_DELAY_SLOT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net

We do not need to emit N copies of raising an exception.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sh4/translate.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 1164f73..b0a3d79 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -370,11 +370,8 @@ static inline void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
 #define XHACK(x) ((((x) & 1 ) << 4) | ((x) & 0xe))
 
 #define CHECK_NOT_DELAY_SLOT \
-    if (ctx->envflags & DELAY_SLOT_MASK) {                           \
-        gen_save_cpu_state(ctx, true);                               \
-        gen_helper_raise_slot_illegal_instruction(cpu_env);          \
-        ctx->bstate = BS_EXCP;                                       \
-        return;                                                      \
+    if (ctx->envflags & DELAY_SLOT_MASK) {  \
+        goto do_illegal_slot;               \
     }
 
 #define CHECK_PRIVILEGED                                             \
@@ -1808,10 +1805,12 @@ static void _decode_opc(DisasContext * ctx)
 	    ctx->opcode, ctx->pc);
     fflush(stderr);
 #endif
-    gen_save_cpu_state(ctx, true);
     if (ctx->envflags & DELAY_SLOT_MASK) {
+ do_illegal_slot:
+        gen_save_cpu_state(ctx, true);
         gen_helper_raise_slot_illegal_instruction(cpu_env);
     } else {
+        gen_save_cpu_state(ctx, true);
         gen_helper_raise_illegal_instruction(cpu_env);
     }
     ctx->bstate = BS_EXCP;
-- 
2.9.4
