Received: from eggs.gnu.org ([2001:4830:134:3::10]:43231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVoJk-0003JA-7I
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 20:18:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVoJi-0000A0-Nt
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 20:18:48 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33569)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dVoJi-00009v-JZ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 20:18:46 -0400
Received: by mail-qk0-x243.google.com with SMTP id a66so9259162qkb.0
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 17:18:46 -0700 (PDT)
Received: from bigtime.twiddle.net.com (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	v47sm5647206qtb.11.2017.07.13.17.18.44 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 13 Jul 2017 17:18:45 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu, 13 Jul 2017 14:18:18 -1000
Message-Id: <20170714001819.1660-8-rth@twiddle.net>
In-Reply-To: <20170714001819.1660-1-rth@twiddle.net>
References: <20170714001819.1660-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 7/8] target/alpha: Fix temp leak in gen_fbcond
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
 target/alpha/translate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 326af7f..aaaf28f 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -613,8 +613,12 @@ static ExitStatus gen_fbcond(DisasContext *ctx, TCGCond cond, int ra,
                              int32_t disp)
 {
     TCGv cmp_tmp = tcg_temp_new();
+    ExitStatus ret;
+
     gen_fold_mzero(cond, cmp_tmp, load_fpr(ctx, ra));
-    return gen_bcond_internal(ctx, cond, cmp_tmp, disp);
+    ret = gen_bcond_internal(ctx, cond, cmp_tmp, disp);
+    tcg_temp_free(cmp_tmp);
+    return ret;
 }
 
 static void gen_fcmov(DisasContext *ctx, TCGCond cond, int ra, int rb, int rc)
-- 
2.9.4
