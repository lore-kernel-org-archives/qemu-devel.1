Received: from eggs.gnu.org ([2001:4830:134:3::10]:39566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXgrt-0004j3-Pz
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:45:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXgrq-0006dD-3p
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:45:49 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:33654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXgrp-0006d2-Qe
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:45:46 -0400
Received: by mail-pg0-x242.google.com with SMTP id z1so5409883pgs.0
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 21:45:45 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 18:45:20 -1000
Message-Id: <20170719044522.21114-7-rth@twiddle.net>
In-Reply-To: <20170719044522.21114-1-rth@twiddle.net>
References: <20170719044522.21114-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 6/8] target/alpha: Fix temp leak in gen_call_pal
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
 target/alpha/translate.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 5e37b1a..326af7f 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -1189,7 +1189,6 @@ static ExitStatus gen_call_pal(DisasContext *ctx, int palcode)
 #ifndef CONFIG_USER_ONLY
     /* Privileged PAL code */
     if (palcode < 0x40 && (ctx->tbflags & ENV_FLAG_PS_USER) == 0) {
-        TCGv tmp;
         switch (palcode) {
         case 0x01:
             /* CFLUSH */
@@ -1222,10 +1221,12 @@ static ExitStatus gen_call_pal(DisasContext *ctx, int palcode)
             ld_flag_byte(ctx->ir[IR_V0], ENV_FLAG_PS_SHIFT);
 
             /* But make sure and store only the 3 IPL bits from the user.  */
-            tmp = tcg_temp_new();
-            tcg_gen_andi_i64(tmp, ctx->ir[IR_A0], PS_INT_MASK);
-            st_flag_byte(tmp, ENV_FLAG_PS_SHIFT);
-            tcg_temp_free(tmp);
+            {
+                TCGv tmp = tcg_temp_new();
+                tcg_gen_andi_i64(tmp, ctx->ir[IR_A0], PS_INT_MASK);
+                st_flag_byte(tmp, ENV_FLAG_PS_SHIFT);
+                tcg_temp_free(tmp);
+            }
 
             /* Allow interrupts to be recognized right away.  */
             tcg_gen_movi_i64(cpu_pc, ctx->pc);
@@ -1254,9 +1255,12 @@ static ExitStatus gen_call_pal(DisasContext *ctx, int palcode)
 
         case 0x3E:
             /* WTINT */
-            tmp = tcg_const_i64(1);
-            tcg_gen_st32_i64(tmp, cpu_env, -offsetof(AlphaCPU, env) +
-                                           offsetof(CPUState, halted));
+            {
+                TCGv_i32 tmp = tcg_const_i32(1);
+                tcg_gen_st_i32(tmp, cpu_env, -offsetof(AlphaCPU, env) +
+                                             offsetof(CPUState, halted));
+                tcg_temp_free_i32(tmp);
+            }
             tcg_gen_movi_i64(ctx->ir[IR_V0], 0);
             return gen_excp(ctx, EXCP_HALTED, 0);
 
-- 
2.9.4
