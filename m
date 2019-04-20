Received: from eggs.gnu.org ([209.51.188.92]:40042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWP-0008K8-Rg
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:34:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWP-0007dk-0C
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:34:49 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkWO-0007d9-Qo
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:34:48 -0400
Received: by mail-pg1-x544.google.com with SMTP id j26so3592082pgl.5
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:34:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 19 Apr 2019 21:34:05 -1000
Message-Id: <20190420073442.7488-2-richard.henderson@linaro.org>
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 01/38] target/arm: Fill in .opc for cmtst_op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@redhat.com

This allows us to fall back to integers if the tcg backend
does not support comparisons in the given vece.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index d408e4d7ef..13e2dc6562 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -6140,16 +6140,20 @@ static void gen_cmtst_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
 const GVecGen3 cmtst_op[4] = {
     { .fni4 = gen_helper_neon_tst_u8,
       .fniv = gen_cmtst_vec,
+      .opc = INDEX_op_cmp_vec,
       .vece = MO_8 },
     { .fni4 = gen_helper_neon_tst_u16,
       .fniv = gen_cmtst_vec,
+      .opc = INDEX_op_cmp_vec,
       .vece = MO_16 },
     { .fni4 = gen_cmtst_i32,
       .fniv = gen_cmtst_vec,
+      .opc = INDEX_op_cmp_vec,
       .vece = MO_32 },
     { .fni8 = gen_cmtst_i64,
       .fniv = gen_cmtst_vec,
       .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+      .opc = INDEX_op_cmp_vec,
       .vece = MO_64 },
 };
 
-- 
2.17.1
