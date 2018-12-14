Received: from eggs.gnu.org ([2001:4830:134:3::10]:58952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe1C-0006Gd-63
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:20:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe1B-0007fY-1q
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:20:01 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:37718)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXe18-0007KD-O1
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:59 -0500
Received: by mail-ot1-x32c.google.com with SMTP id 40so4122092oth.4
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 19:19:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 21:19:14 -0600
Message-Id: <20181214031923.29527-25-richard.henderson@linaro.org>
In-Reply-To: <20181214031923.29527-1-richard.henderson@linaro.org>
References: <20181214031923.29527-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 23/32] tcg: Clean up generic bswap32
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

Based on the only current user, Sparc:

New code uses 1 constant that takes 2 insns to create, plus 8.
Old code used 2 constants that took 2 insns to create, plus 9.
The result is a new total of 10 vs an old total of 13.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 54 ++++++++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 7a8015c5a9..a956499e46 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1012,22 +1012,22 @@ void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg)
     if (TCG_TARGET_HAS_bswap32_i32) {
         tcg_gen_op2_i32(INDEX_op_bswap32_i32, ret, arg);
     } else {
-        TCGv_i32 t0, t1;
-        t0 = tcg_temp_new_i32();
-        t1 = tcg_temp_new_i32();
+        TCGv_i32 t0 = tcg_temp_new_i32();
+        TCGv_i32 t1 = tcg_temp_new_i32();
+        TCGv_i32 t2 = tcg_const_i32(0x00ff00ff);
 
-        tcg_gen_shli_i32(t0, arg, 24);
+                                        /* arg = abcd */
+        tcg_gen_shri_i32(t0, arg, 8);   /*  t0 = .abc */
+        tcg_gen_and_i32(t1, arg, t2);   /*  t1 = .b.d */
+        tcg_gen_and_i32(t0, t0, t2);    /*  t0 = .a.c */
+        tcg_temp_free_i32(t2);
+        tcg_gen_shli_i32(t1, t1, 8);    /*  t1 = b.d. */
+        tcg_gen_or_i32(ret, t0, t1);    /* ret = badc */
 
-        tcg_gen_andi_i32(t1, arg, 0x0000ff00);
-        tcg_gen_shli_i32(t1, t1, 8);
-        tcg_gen_or_i32(t0, t0, t1);
+        tcg_gen_shri_i32(t0, ret, 16);  /*  t0 = ..ba */
+        tcg_gen_shli_i32(t1, ret, 16);  /*  t1 = dc.. */
+        tcg_gen_or_i32(ret, t0, t1);    /* ret = dcba */
 
-        tcg_gen_shri_i32(t1, arg, 8);
-        tcg_gen_andi_i32(t1, t1, 0x0000ff00);
-        tcg_gen_or_i32(t0, t0, t1);
-
-        tcg_gen_shri_i32(t1, arg, 24);
-        tcg_gen_or_i32(ret, t0, t1);
         tcg_temp_free_i32(t0);
         tcg_temp_free_i32(t1);
     }
@@ -1638,23 +1638,23 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg)
     } else if (TCG_TARGET_HAS_bswap32_i64) {
         tcg_gen_op2_i64(INDEX_op_bswap32_i64, ret, arg);
     } else {
-        TCGv_i64 t0, t1;
-        t0 = tcg_temp_new_i64();
-        t1 = tcg_temp_new_i64();
+        TCGv_i64 t0 = tcg_temp_new_i64();
+        TCGv_i64 t1 = tcg_temp_new_i64();
+        TCGv_i64 t2 = tcg_const_i64(0x00ff00ff);
 
-        tcg_gen_shli_i64(t0, arg, 24);
-        tcg_gen_ext32u_i64(t0, t0);
+                                        /* arg = ....abcd */
+        tcg_gen_shri_i64(t0, arg, 8);   /*  t0 = .....abc */
+        tcg_gen_and_i64(t1, arg, t2);   /*  t1 = .....b.d */
+        tcg_gen_and_i64(t0, t0, t2);    /*  t0 = .....a.c */
+        tcg_temp_free_i64(t2);
+        tcg_gen_shli_i64(t1, t1, 8);    /*  t1 = ....b.d. */
+        tcg_gen_or_i64(ret, t0, t1);    /* ret = ....badc */
 
-        tcg_gen_andi_i64(t1, arg, 0x0000ff00);
-        tcg_gen_shli_i64(t1, t1, 8);
-        tcg_gen_or_i64(t0, t0, t1);
+        tcg_gen_shli_i64(t1, ret, 48);  /*  t1 = dc...... */
+        tcg_gen_shri_i64(t0, ret, 16);  /*  t0 = ......ba */
+        tcg_gen_shri_i64(t1, ret, 32);  /*  t1 = ....dc.. */
+        tcg_gen_or_i64(ret, t0, t1);    /* ret = ....dcba */
 
-        tcg_gen_shri_i64(t1, arg, 8);
-        tcg_gen_andi_i64(t1, t1, 0x0000ff00);
-        tcg_gen_or_i64(t0, t0, t1);
-
-        tcg_gen_shri_i64(t1, arg, 24);
-        tcg_gen_or_i64(ret, t0, t1);
         tcg_temp_free_i64(t0);
         tcg_temp_free_i64(t1);
     }
-- 
2.17.2
