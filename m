Received: from eggs.gnu.org ([2001:4830:134:3::10]:43204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVoJg-0003Fb-5l
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 20:18:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVoJf-00008s-EQ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 20:18:44 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35015)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dVoJf-00008h-9n
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 20:18:43 -0400
Received: by mail-qk0-x244.google.com with SMTP id c18so129381qkb.2
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 17:18:43 -0700 (PDT)
Received: from bigtime.twiddle.net.com (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	v47sm5647206qtb.11.2017.07.13.17.18.41 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 13 Jul 2017 17:18:42 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu, 13 Jul 2017 14:18:16 -1000
Message-Id: <20170714001819.1660-6-rth@twiddle.net>
In-Reply-To: <20170714001819.1660-1-rth@twiddle.net>
References: <20170714001819.1660-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 5/8] target/alpha: Fix temp leak in gen_mtpr
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
