Received: from eggs.gnu.org ([2001:4830:134:3::10]:39568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXgrt-0004j6-Qn
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:45:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXgrs-0006dd-DI
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:45:49 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:35852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXgrs-0006dU-7g
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:45:48 -0400
Received: by mail-pf0-x243.google.com with SMTP id a11so5068007pfj.3
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 21:45:48 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 18:45:21 -1000
Message-Id: <20170719044522.21114-8-rth@twiddle.net>
In-Reply-To: <20170719044522.21114-1-rth@twiddle.net>
References: <20170719044522.21114-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 7/8] target/alpha: Fix temp leak in gen_fbcond
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
