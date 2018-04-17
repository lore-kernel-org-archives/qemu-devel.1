Received: from eggs.gnu.org ([2001:4830:134:3::10]:44918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f8YqM-0000Ea-Ll
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 18:12:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f8YqJ-0006MD-Ru
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 18:12:54 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:46097)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f8YqJ-0006K7-Lc
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 18:12:51 -0400
Received: by mail-pl0-x244.google.com with SMTP id 59-v6so12763915plc.13
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 15:12:51 -0700 (PDT)
Received: from cloudburst.ASUS (cpe-66-75-76-48.hawaii.res.rr.com.
	[66.75.76.48]) by smtp.gmail.com with ESMTPSA id
	d4sm27941610pgc.43.2018.04.17.15.12.48 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 17 Apr 2018 15:12:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 17 Apr 2018 12:12:46 -1000
Message-Id: <20180417221246.14672-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.13] tcg: Allow wider vectors for cmp and
 mul
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In db432672, we allow wide inputs for operations such as add.
However, in 212be173 and 3774030a we didn't do the same for
compare and multiply.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-vec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 70ec889bc1..2ca219734d 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -355,8 +355,8 @@ void tcg_gen_cmp_vec(TCGCond cond, unsigned vece,
     TCGType type = rt->base_type;
     int can;
 
-    tcg_debug_assert(at->base_type == type);
-    tcg_debug_assert(bt->base_type == type);
+    tcg_debug_assert(at->base_type >= type);
+    tcg_debug_assert(bt->base_type >= type);
     can = tcg_can_emit_vec_op(INDEX_op_cmp_vec, type, vece);
     if (can > 0) {
         vec_gen_4(INDEX_op_cmp_vec, type, vece, ri, ai, bi, cond);
@@ -377,8 +377,8 @@ void tcg_gen_mul_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
     TCGType type = rt->base_type;
     int can;
 
-    tcg_debug_assert(at->base_type == type);
-    tcg_debug_assert(bt->base_type == type);
+    tcg_debug_assert(at->base_type >= type);
+    tcg_debug_assert(bt->base_type >= type);
     can = tcg_can_emit_vec_op(INDEX_op_mul_vec, type, vece);
     if (can > 0) {
         vec_gen_3(INDEX_op_mul_vec, type, vece, ri, ai, bi);
-- 
2.14.3
