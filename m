Received: from eggs.gnu.org ([2001:4830:134:3::10]:39522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXgrl-0004bu-Kj
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXgrk-0006c2-Tw
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:45:41 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33645)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXgrk-0006bq-LP
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:45:40 -0400
Received: by mail-pg0-x241.google.com with SMTP id z1so5409668pgs.0
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 21:45:40 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 18:45:18 -1000
Message-Id: <20170719044522.21114-5-rth@twiddle.net>
In-Reply-To: <20170719044522.21114-1-rth@twiddle.net>
References: <20170719044522.21114-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 4/8] target/alpha: Fix temp leak in gen_bcond
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
 target/alpha/translate.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 140d6f3..d684a7b 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -565,16 +565,16 @@ static ExitStatus gen_bcond_internal(DisasContext *ctx, TCGCond cond,
 static ExitStatus gen_bcond(DisasContext *ctx, TCGCond cond, int ra,
                             int32_t disp, int mask)
 {
-    TCGv cmp_tmp;
-
     if (mask) {
-        cmp_tmp = tcg_temp_new();
-        tcg_gen_andi_i64(cmp_tmp, load_gpr(ctx, ra), 1);
-    } else {
-        cmp_tmp = load_gpr(ctx, ra);
-    }
+        TCGv tmp = tcg_temp_new();
+        ExitStatus ret;
 
-    return gen_bcond_internal(ctx, cond, cmp_tmp, disp);
+        tcg_gen_andi_i64(tmp, load_gpr(ctx, ra), 1);
+        ret = gen_bcond_internal(ctx, cond, tmp, disp);
+        tcg_temp_free(tmp);
+        return ret;
+    }
+    return gen_bcond_internal(ctx, cond, load_gpr(ctx, ra), disp);
 }
 
 /* Fold -0.0 for comparison with COND.  */
-- 
2.9.4
