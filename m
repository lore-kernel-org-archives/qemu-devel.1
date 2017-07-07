Received: from eggs.gnu.org ([2001:4830:134:3::10]:35056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTIwo-0003NW-B4
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:24:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTIwn-00016S-Ht
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:24:46 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dTIwn-00016G-Cz
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:24:45 -0400
Received: by mail-qk0-x244.google.com with SMTP id 16so2746613qkg.2
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 19:24:45 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  6 Jul 2017 16:21:03 -1000
Message-Id: <20170707022111.21836-20-rth@twiddle.net>
In-Reply-To: <20170707022111.21836-1-rth@twiddle.net>
References: <20170707022111.21836-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 19/27] target/sh4: Unify code for
 CHECK_PRIVILEGED
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
 target/sh4/translate.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 41157a0..dd14b43 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -381,16 +381,9 @@ static inline void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
         goto do_illegal_slot;               \
     }
 
-#define CHECK_PRIVILEGED                                             \
-    if (IS_USER(ctx)) {                                              \
-        gen_save_cpu_state(ctx, true);                               \
-        if (ctx->envflags & DELAY_SLOT_MASK) {                       \
-            gen_helper_raise_slot_illegal_instruction(cpu_env);      \
-        } else {                                                     \
-            gen_helper_raise_illegal_instruction(cpu_env);           \
-        }                                                            \
-        ctx->bstate = BS_EXCP;                                       \
-        return;                                                      \
+#define CHECK_PRIVILEGED \
+    if (IS_USER(ctx)) {                     \
+        goto do_illegal;                    \
     }
 
 #define CHECK_FPU_ENABLED                                            \
@@ -1817,6 +1810,7 @@ static void _decode_opc(DisasContext * ctx)
 	    ctx->opcode, ctx->pc);
     fflush(stderr);
 #endif
+ do_illegal:
     if (ctx->envflags & DELAY_SLOT_MASK) {
  do_illegal_slot:
         gen_save_cpu_state(ctx, true);
-- 
2.9.4
