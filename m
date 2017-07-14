Received: from eggs.gnu.org ([2001:4830:134:3::10]:43189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVoJe-0003EW-Pj
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 20:18:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVoJe-00008C-1a
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 20:18:42 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:34518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dVoJd-000083-TX
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 20:18:41 -0400
Received: by mail-qk0-x244.google.com with SMTP id q66so10270706qki.1
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 17:18:41 -0700 (PDT)
Received: from bigtime.twiddle.net.com (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	v47sm5647206qtb.11.2017.07.13.17.18.39 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 13 Jul 2017 17:18:40 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu, 13 Jul 2017 14:18:15 -1000
Message-Id: <20170714001819.1660-5-rth@twiddle.net>
In-Reply-To: <20170714001819.1660-1-rth@twiddle.net>
References: <20170714001819.1660-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 4/8] target/alpha: Fix temp leak in gen_bcond
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
