Received: from eggs.gnu.org ([2001:4830:134:3::10]:35104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTIwu-0003R8-Ii
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:24:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTIwr-00018V-FO
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:24:52 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dTIwr-00018H-Al
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:24:49 -0400
Received: by mail-qk0-x242.google.com with SMTP id 91so2764714qkq.1
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 19:24:49 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  6 Jul 2017 16:21:04 -1000
Message-Id: <20170707022111.21836-21-rth@twiddle.net>
In-Reply-To: <20170707022111.21836-1-rth@twiddle.net>
References: <20170707022111.21836-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 20/27] target/sh4: Unify code for
 CHECK_FPU_ENABLED
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
 target/sh4/translate.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index dd14b43..a4370c6 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -386,16 +386,9 @@ static inline void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
         goto do_illegal;                    \
     }
 
-#define CHECK_FPU_ENABLED                                            \
-    if (ctx->tbflags & (1u << SR_FD)) {                              \
-        gen_save_cpu_state(ctx, true);                               \
-        if (ctx->envflags & DELAY_SLOT_MASK) {                       \
-            gen_helper_raise_slot_fpu_disable(cpu_env);              \
-        } else {                                                     \
-            gen_helper_raise_fpu_disable(cpu_env);                   \
-        }                                                            \
-        ctx->bstate = BS_EXCP;                                       \
-        return;                                                      \
+#define CHECK_FPU_ENABLED \
+    if (ctx->tbflags & (1u << SR_FD)) {     \
+        goto do_fpu_disabled;               \
     }
 
 static void _decode_opc(DisasContext * ctx)
@@ -1820,6 +1813,17 @@ static void _decode_opc(DisasContext * ctx)
         gen_helper_raise_illegal_instruction(cpu_env);
     }
     ctx->bstate = BS_EXCP;
+    return;
+
+ do_fpu_disabled:
+    gen_save_cpu_state(ctx, true);
+    if (ctx->envflags & DELAY_SLOT_MASK) {
+        gen_helper_raise_slot_fpu_disable(cpu_env);
+    } else {
+        gen_helper_raise_fpu_disable(cpu_env);
+    }
+    ctx->bstate = BS_EXCP;
+    return;
 }
 
 static void decode_opc(DisasContext * ctx)
-- 
2.9.4
