Received: from eggs.gnu.org ([2001:4830:134:3::10]:49874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYjE-0006dR-B5
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYjD-0004rE-H0
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:20 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:32992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXYjD-0004r2-D0
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:19 -0400
Received: by mail-qk0-x244.google.com with SMTP id u126so2856721qka.0
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 13:04:19 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 10:02:44 -1000
Message-Id: <20170718200255.31647-20-rth@twiddle.net>
In-Reply-To: <20170718200255.31647-1-rth@twiddle.net>
References: <20170718200255.31647-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 19/30] target/sh4: Unify code for
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
Cc: aurelien@aurel32.net

We do not need to emit N copies of raising an exception.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sh4/translate.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index b0a3d79..b40e52b 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -374,16 +374,9 @@ static inline void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
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
@@ -1805,6 +1798,7 @@ static void _decode_opc(DisasContext * ctx)
 	    ctx->opcode, ctx->pc);
     fflush(stderr);
 #endif
+ do_illegal:
     if (ctx->envflags & DELAY_SLOT_MASK) {
  do_illegal_slot:
         gen_save_cpu_state(ctx, true);
-- 
2.9.4
