Received: from eggs.gnu.org ([2001:4830:134:3::10]:43230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVoJk-0003J9-7E
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 20:18:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVoJh-00009U-1v
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 20:18:48 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dVoJg-00009F-Tz
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 20:18:44 -0400
Received: by mail-qk0-x243.google.com with SMTP id a66so9259128qkb.0
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 17:18:44 -0700 (PDT)
Received: from bigtime.twiddle.net.com (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	v47sm5647206qtb.11.2017.07.13.17.18.42 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 13 Jul 2017 17:18:43 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu, 13 Jul 2017 14:18:17 -1000
Message-Id: <20170714001819.1660-7-rth@twiddle.net>
In-Reply-To: <20170714001819.1660-1-rth@twiddle.net>
References: <20170714001819.1660-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 6/8] target/alpha: Fix temp leak in gen_call_pal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
