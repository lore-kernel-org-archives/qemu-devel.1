Received: from eggs.gnu.org ([2001:4830:134:3::10]:35036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTIwj-0003Jv-VF
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:24:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTIwj-000151-5P
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:24:41 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:33211)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dTIwj-00014o-0n
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:24:41 -0400
Received: by mail-qk0-x241.google.com with SMTP id p21so2760478qke.0
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 19:24:40 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  6 Jul 2017 16:21:02 -1000
Message-Id: <20170707022111.21836-19-rth@twiddle.net>
In-Reply-To: <20170707022111.21836-1-rth@twiddle.net>
References: <20170707022111.21836-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 18/27] target/sh4: Unify code for
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
Cc: aurelien@aurel32.net, laurent@vivier.eu, bruno@clisp.org, glaubitz@debian.org

We do not need to emit N copies of raising an exception.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sh4/translate.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 3453f19..41157a0 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -377,11 +377,8 @@ static inline void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
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
@@ -1820,10 +1817,12 @@ static void _decode_opc(DisasContext * ctx)
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
