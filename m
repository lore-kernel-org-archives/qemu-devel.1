Received: from eggs.gnu.org ([2001:4830:134:3::10]:44145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCj1-0000EH-Mb
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCiz-0003da-OJ
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:31 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gQCiy-0003ZO-0I
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:29 -0500
Received: by mail-wr1-x444.google.com with SMTP id z5so8281528wrt.11
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 06:46:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 23 Nov 2018 15:45:48 +0100
Message-Id: <20181123144558.5048-28-richard.henderson@linaro.org>
In-Reply-To: <20181123144558.5048-1-richard.henderson@linaro.org>
References: <20181123144558.5048-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 v2 27/37] tcg: Clean up generic bswap64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com

Based on the only current user, Sparc:

New code uses 2 constants that take 2 insns to load from constant pool,
plus 13.  Old code used 6 constants that took 1 or 2 insns to create,
plus 21.  The result is a new total of 17 vs an old total of 29.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 43 ++++++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index a956499e46..887b371a81 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1678,37 +1678,30 @@ void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg)
     } else {
         TCGv_i64 t0 = tcg_temp_new_i64();
         TCGv_i64 t1 = tcg_temp_new_i64();
+        TCGv_i64 t2 = tcg_temp_new_i64();
 
-        tcg_gen_shli_i64(t0, arg, 56);
+                                        /* arg = abcdefgh */
+        tcg_gen_movi_i64(t2, 0x00ff00ff00ff00ffull);
+        tcg_gen_shri_i64(t0, arg, 8);   /*  t0 = .abcdefg */
+        tcg_gen_and_i64(t1, arg, t2);   /*  t1 = .b.d.f.h */
+        tcg_gen_and_i64(t0, t0, t2);    /*  t0 = .a.c.e.g */
+        tcg_gen_shli_i64(t1, t1, 8);    /*  t1 = b.d.f.h. */
+        tcg_gen_or_i64(ret, t0, t1);    /* ret = badcfehg */
 
-        tcg_gen_andi_i64(t1, arg, 0x0000ff00);
-        tcg_gen_shli_i64(t1, t1, 40);
-        tcg_gen_or_i64(t0, t0, t1);
+        tcg_gen_movi_i64(t2, 0x0000ffff0000ffffull);
+        tcg_gen_shri_i64(t0, ret, 16);  /*  t0 = ..badcfe */
+        tcg_gen_and_i64(t1, ret, t2);   /*  t1 = ..dc..hg */
+        tcg_gen_and_i64(t0, t0, t2);    /*  t0 = ..ba..fe */
+        tcg_gen_shli_i64(t1, t1, 16);   /*  t1 = dc..hg.. */
+        tcg_gen_or_i64(ret, t0, t1);    /* ret = dcbahgfe */
 
-        tcg_gen_andi_i64(t1, arg, 0x00ff0000);
-        tcg_gen_shli_i64(t1, t1, 24);
-        tcg_gen_or_i64(t0, t0, t1);
+        tcg_gen_shri_i64(t0, ret, 32);  /*  t0 = ....dcba */
+        tcg_gen_shli_i64(t1, ret, 32);  /*  t1 = hgfe.... */
+        tcg_gen_or_i64(ret, t0, t1);    /* ret = hgfedcba */
 
-        tcg_gen_andi_i64(t1, arg, 0xff000000);
-        tcg_gen_shli_i64(t1, t1, 8);
-        tcg_gen_or_i64(t0, t0, t1);
-
-        tcg_gen_shri_i64(t1, arg, 8);
-        tcg_gen_andi_i64(t1, t1, 0xff000000);
-        tcg_gen_or_i64(t0, t0, t1);
-
-        tcg_gen_shri_i64(t1, arg, 24);
-        tcg_gen_andi_i64(t1, t1, 0x00ff0000);
-        tcg_gen_or_i64(t0, t0, t1);
-
-        tcg_gen_shri_i64(t1, arg, 40);
-        tcg_gen_andi_i64(t1, t1, 0x0000ff00);
-        tcg_gen_or_i64(t0, t0, t1);
-
-        tcg_gen_shri_i64(t1, arg, 56);
-        tcg_gen_or_i64(ret, t0, t1);
         tcg_temp_free_i64(t0);
         tcg_temp_free_i64(t1);
+        tcg_temp_free_i64(t2);
     }
 }
 
-- 
2.17.2
