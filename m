Received: from eggs.gnu.org ([2001:4830:134:3::10]:49923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYjK-0006iu-Ez
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYjG-0004sN-4O
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:26 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33373)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXYjG-0004s7-03
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:22 -0400
Received: by mail-qt0-x242.google.com with SMTP id 50so2613085qtz.0
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 13:04:21 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 10:02:45 -1000
Message-Id: <20170718200255.31647-21-rth@twiddle.net>
In-Reply-To: <20170718200255.31647-1-rth@twiddle.net>
References: <20170718200255.31647-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 20/30] target/sh4: Unify code for
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
Cc: aurelien@aurel32.net

We do not need to emit N copies of raising an exception.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sh4/translate.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index b40e52b..4c32248 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -379,16 +379,9 @@ static inline void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
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
@@ -1808,6 +1801,17 @@ static void _decode_opc(DisasContext * ctx)
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
