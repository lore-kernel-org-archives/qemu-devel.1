Received: from eggs.gnu.org ([2001:4830:134:3::10]:35876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8VQ-0006oI-Go
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8VP-0003eP-ER
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:16 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:33475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8VP-0003dz-74
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:15 -0500
Received: by mail-pf0-x243.google.com with SMTP id 127so31459979pfg.0
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:19:15 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:18:18 -0800
Message-Id: <20170111021820.24416-64-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 63/65] tcg: Use ctpop to generate ctz if needed
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

Particularly when andc is also available, this is two insns
shorter than using clz to compute ctz.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/tcg-op.c | 100 +++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 60 insertions(+), 40 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 6f4b1b6..95a39b7 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -497,33 +497,27 @@ void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_extrl_i64_i32(ret, t1);
         tcg_temp_free_i64(t1);
         tcg_temp_free_i64(t2);
-    } else if (TCG_TARGET_HAS_clz_i32) {
-        TCGv_i32 t1 = tcg_temp_new_i32();
-        TCGv_i32 t2 = tcg_temp_new_i32();
-        tcg_gen_neg_i32(t1, arg1);
-        tcg_gen_xori_i32(t2, arg2, 31);
-        tcg_gen_and_i32(t1, t1, arg1);
-        tcg_gen_clz_i32(ret, t1, t2);
-        tcg_temp_free_i32(t1);
-        tcg_temp_free_i32(t2);
-        tcg_gen_xori_i32(ret, ret, 31);
-    } else if (TCG_TARGET_HAS_clz_i64) {
-        TCGv_i32 t1 = tcg_temp_new_i32();
-        TCGv_i32 t2 = tcg_temp_new_i32();
-        TCGv_i64 x1 = tcg_temp_new_i64();
-        TCGv_i64 x2 = tcg_temp_new_i64();
-        tcg_gen_neg_i32(t1, arg1);
-        tcg_gen_xori_i32(t2, arg2, 63);
-        tcg_gen_and_i32(t1, t1, arg1);
-        tcg_gen_extu_i32_i64(x1, t1);
-        tcg_gen_extu_i32_i64(x2, t2);
-        tcg_temp_free_i32(t1);
-        tcg_temp_free_i32(t2);
-        tcg_gen_clz_i64(x1, x1, x2);
-        tcg_gen_extrl_i64_i32(ret, x1);
-        tcg_temp_free_i64(x1);
-        tcg_temp_free_i64(x2);
-        tcg_gen_xori_i32(ret, ret, 63);
+    } else if (TCG_TARGET_HAS_ctpop_i32
+               || TCG_TARGET_HAS_ctpop_i64
+               || TCG_TARGET_HAS_clz_i32
+               || TCG_TARGET_HAS_clz_i64) {
+        TCGv_i32 z, t = tcg_temp_new_i32();
+
+        if (TCG_TARGET_HAS_ctpop_i32 || TCG_TARGET_HAS_ctpop_i64) {
+            tcg_gen_subi_i32(t, arg1, 1);
+            tcg_gen_andc_i32(t, t, arg1);
+            tcg_gen_ctpop_i32(t, t);
+        } else {
+            /* Since all non-x86 hosts have clz(0) == 32, don't fight it.  */
+            tcg_gen_neg_i32(t, arg1);
+            tcg_gen_and_i32(t, t, arg1);
+            tcg_gen_clzi_i32(t, t, 32);
+            tcg_gen_xori_i32(t, t, 31);
+        }
+        z = tcg_const_i32(0);
+        tcg_gen_movcond_i32(TCG_COND_EQ, ret, arg1, z, arg2, t);
+        tcg_temp_free_i32(t);
+        tcg_temp_free_i32(z);
     } else {
         gen_helper_ctz_i32(ret, arg1, arg2);
     }
@@ -531,9 +525,18 @@ void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
 {
-    TCGv_i32 t = tcg_const_i32(arg2);
-    tcg_gen_ctz_i32(ret, arg1, t);
-    tcg_temp_free_i32(t);
+    if (!TCG_TARGET_HAS_ctz_i32 && TCG_TARGET_HAS_ctpop_i32 && arg2 == 32) {
+        /* This equivalence has the advantage of not requiring a fixup.  */
+        TCGv_i32 t = tcg_temp_new_i32();
+        tcg_gen_subi_i32(t, arg1, 1);
+        tcg_gen_andc_i32(t, t, arg1);
+        tcg_gen_ctpop_i32(ret, t);
+        tcg_temp_free_i32(t);
+    } else {
+        TCGv_i32 t = tcg_const_i32(arg2);
+        tcg_gen_ctz_i32(ret, arg1, t);
+        tcg_temp_free_i32(t);
+    }
 }
 
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg)
@@ -1842,16 +1845,24 @@ void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_HAS_ctz_i64) {
         tcg_gen_op3_i64(INDEX_op_ctz_i64, ret, arg1, arg2);
-    } else if (TCG_TARGET_HAS_clz_i64) {
-        TCGv_i64 t1 = tcg_temp_new_i64();
-        TCGv_i64 t2 = tcg_temp_new_i64();
-        tcg_gen_neg_i64(t1, arg1);
-        tcg_gen_xori_i64(t2, arg2, 63);
-        tcg_gen_and_i64(t1, t1, arg1);
-        tcg_gen_clz_i64(ret, t1, t2);
-        tcg_temp_free_i64(t1);
-        tcg_temp_free_i64(t2);
-        tcg_gen_xori_i64(ret, ret, 63);
+    } else if (TCG_TARGET_HAS_ctpop_i64 || TCG_TARGET_HAS_clz_i64) {
+        TCGv_i64 z, t = tcg_temp_new_i64();
+
+        if (TCG_TARGET_HAS_ctpop_i64) {
+            tcg_gen_subi_i64(t, arg1, 1);
+            tcg_gen_andc_i64(t, t, arg1);
+            tcg_gen_ctpop_i64(t, t);
+        } else {
+            /* Since all non-x86 hosts have clz(0) == 64, don't fight it.  */
+            tcg_gen_neg_i64(t, arg1);
+            tcg_gen_and_i64(t, t, arg1);
+            tcg_gen_clzi_i64(t, t, 64);
+            tcg_gen_xori_i64(t, t, 63);
+        }
+        z = tcg_const_i64(0);
+        tcg_gen_movcond_i64(TCG_COND_EQ, ret, arg1, z, arg2, t);
+        tcg_temp_free_i64(t);
+        tcg_temp_free_i64(z);
     } else {
         gen_helper_ctz_i64(ret, arg1, arg2);
     }
@@ -1868,6 +1879,15 @@ void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
         tcg_gen_ctz_i32(TCGV_LOW(ret), TCGV_LOW(arg1), t32);
         tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
         tcg_temp_free_i32(t32);
+    } else if (!TCG_TARGET_HAS_ctz_i64
+               && TCG_TARGET_HAS_ctpop_i64
+               && arg2 == 64) {
+        /* This equivalence has the advantage of not requiring a fixup.  */
+        TCGv_i64 t = tcg_temp_new_i64();
+        tcg_gen_subi_i64(t, arg1, 1);
+        tcg_gen_andc_i64(t, t, arg1);
+        tcg_gen_ctpop_i64(ret, t);
+        tcg_temp_free_i64(t);
     } else {
         TCGv_i64 t64 = tcg_const_i64(arg2);
         tcg_gen_ctz_i64(ret, arg1, t64);
-- 
2.9.3
