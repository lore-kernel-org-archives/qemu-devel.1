Received: from eggs.gnu.org ([2001:4830:134:3::10]:48694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaPn-0005m9-G6
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaPk-000415-HS
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:23 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:48412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dXaOY-0003Ur-1x
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:20 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue, 18 Jul 2017 23:50:41 +0200
Message-Id: <20170718215050.3812-23-aurelien@aurel32.net>
In-Reply-To: <20170718215050.3812-1-aurelien@aurel32.net>
References: <20170718215050.3812-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 22/31] target/sh4: Unify code for
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
Cc: Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>

From: Richard Henderson <rth@twiddle.net>

We do not need to emit N copies of raising an exception.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-Id: <20170718200255.31647-19-rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/translate.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 792a46804b..acd756e18a 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -365,11 +365,8 @@ static inline void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
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
@@ -1796,10 +1793,12 @@ static void _decode_opc(DisasContext * ctx)
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
2.11.0
