Received: from eggs.gnu.org ([209.51.188.92]:50310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h24md-0006WB-Eg
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:58:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h24mZ-0007du-5P
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:58:45 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:36856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h24mU-0007Vw-N2
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:58:39 -0500
Received: by mail-pg1-x535.google.com with SMTP id r124so12795041pgr.3
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 17:58:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Mar 2019 17:58:30 -0800
Message-Id: <20190308015830.10980-3-richard.henderson@linaro.org>
In-Reply-To: <20190308015830.10980-1-richard.henderson@linaro.org>
References: <20190308015830.10980-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 2/2] target/hppa: Optimize blr r0,rn
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

We can eliminate an extra TB in this case, which merely
loads a "return address" into rn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index dad8ce563c..dc5636fe94 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3488,12 +3488,16 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
 
 static bool trans_blr(DisasContext *ctx, arg_blr *a)
 {
-    TCGv_reg tmp = get_temp(ctx);
-
-    tcg_gen_shli_reg(tmp, load_gpr(ctx, a->x), 3);
-    tcg_gen_addi_reg(tmp, tmp, ctx->iaoq_f + 8);
-    /* The computation here never changes privilege level.  */
-    return do_ibranch(ctx, tmp, a->l, a->n);
+    if (a->x) {
+        TCGv_reg tmp = get_temp(ctx);
+        tcg_gen_shli_reg(tmp, load_gpr(ctx, a->x), 3);
+        tcg_gen_addi_reg(tmp, tmp, ctx->iaoq_f + 8);
+        /* The computation here never changes privilege level.  */
+        return do_ibranch(ctx, tmp, a->l, a->n);
+    } else {
+        /* BLR R0,RX is a good way to load PC+8 into RX.  */
+        return do_dbranch(ctx, ctx->iaoq_f + 8, a->l, a->n);
+    }
 }
 
 static bool trans_bv(DisasContext *ctx, arg_bv *a)
-- 
2.17.2
