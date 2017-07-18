Received: from eggs.gnu.org ([2001:4830:134:3::10]:48518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaPi-0005h7-KB
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaPh-0003xZ-P3
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:18 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:48438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dXaOY-0003Ux-4c
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:17 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue, 18 Jul 2017 23:50:43 +0200
Message-Id: <20170718215050.3812-25-aurelien@aurel32.net>
In-Reply-To: <20170718215050.3812-1-aurelien@aurel32.net>
References: <20170718215050.3812-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 24/31] target/sh4: Unify code for
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
Cc: Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>

From: Richard Henderson <rth@twiddle.net>

We do not need to emit N copies of raising an exception.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-Id: <20170718200255.31647-21-rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/translate.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 2476b948b9..b90719717e 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -374,16 +374,9 @@ static inline void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
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
@@ -1796,6 +1789,17 @@ static void _decode_opc(DisasContext * ctx)
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
2.11.0
