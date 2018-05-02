Received: from eggs.gnu.org ([2001:4830:134:3::10]:51720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDvs1-0005WR-C8
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:48:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDvrz-0004Bf-2g
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:48:49 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:38399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fDvry-0004BQ-SZ
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:48:46 -0400
Received: by mail-pf0-x244.google.com with SMTP id o76so12408866pfi.5
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 10:48:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  2 May 2018 10:48:40 -0700
Message-Id: <20180502174842.16253-2-richard.henderson@linaro.org>
In-Reply-To: <20180502174842.16253-1-richard.henderson@linaro.org>
References: <20180502174842.16253-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 3/5] tcg: Allow wider vectors for cmp and mul
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

In db432672, we allow wide inputs for operations such as add.
However, in 212be173 and 3774030a we didn't do the same for
compare and multiply.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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
