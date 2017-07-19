Received: from eggs.gnu.org ([2001:4830:134:3::10]:39535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXgro-0004e4-NI
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:45:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXgrn-0006ca-DQ
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:45:44 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:36232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXgrn-0006cK-2x
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:45:43 -0400
Received: by mail-pg0-x243.google.com with SMTP id y129so5392063pgy.3
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 21:45:42 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 18:45:19 -1000
Message-Id: <20170719044522.21114-6-rth@twiddle.net>
In-Reply-To: <20170719044522.21114-1-rth@twiddle.net>
References: <20170719044522.21114-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 5/8] target/alpha: Fix temp leak in gen_mtpr
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
 target/alpha/translate.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index d684a7b..5e37b1a 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -1392,7 +1392,6 @@ static ExitStatus gen_mfpr(DisasContext *ctx, TCGv va, int regno)
 
 static ExitStatus gen_mtpr(DisasContext *ctx, TCGv vb, int regno)
 {
-    TCGv tmp;
     int data;
 
     switch (regno) {
@@ -1408,9 +1407,12 @@ static ExitStatus gen_mtpr(DisasContext *ctx, TCGv vb, int regno)
 
     case 253:
         /* WAIT */
-        tmp = tcg_const_i64(1);
-        tcg_gen_st32_i64(tmp, cpu_env, -offsetof(AlphaCPU, env) +
-                                       offsetof(CPUState, halted));
+        {
+            TCGv_i32 tmp = tcg_const_i32(1);
+            tcg_gen_st_i32(tmp, cpu_env, -offsetof(AlphaCPU, env) +
+                                         offsetof(CPUState, halted));
+            tcg_temp_free_i32(tmp);
+        }
         return gen_excp(ctx, EXCP_HALTED, 0);
 
     case 252:
-- 
2.9.4
