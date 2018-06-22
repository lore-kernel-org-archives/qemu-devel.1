Received: from eggs.gnu.org ([2001:4830:134:3::10]:50082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLd9-0003aq-0m
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLd8-0005QC-7K
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:35 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fWLd7-0005OZ-V7
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:34 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLd6-00040n-Oj
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:57:32 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 13:57:11 +0100
Message-Id: <20180622125713.15303-27-peter.maydell@linaro.org>
In-Reply-To: <20180622125713.15303-1-peter.maydell@linaro.org>
References: <20180622125713.15303-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 26/28] target/arm: Strict alignment for ARMv6-M
 and ARMv8-M Baseline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Julia Suvorova <jusual@mail.ru>

Unlike ARMv7-M, ARMv6-M and ARMv8-M Baseline only supports naturally
aligned memory accesses for load/store instructions.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
Message-id: 20180622080138.17702-3-jusual@mail.ru
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index b988d379e7c..2a3e4f5d4c9 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1100,7 +1100,14 @@ static inline TCGv gen_aa32_addr(DisasContext *s, TCGv_i32 a32, TCGMemOp op)
 static void gen_aa32_ld_i32(DisasContext *s, TCGv_i32 val, TCGv_i32 a32,
                             int index, TCGMemOp opc)
 {
-    TCGv addr = gen_aa32_addr(s, a32, opc);
+    TCGv addr;
+
+    if (arm_dc_feature(s, ARM_FEATURE_M) &&
+        !arm_dc_feature(s, ARM_FEATURE_M_MAIN)) {
+        opc |= MO_ALIGN;
+    }
+
+    addr = gen_aa32_addr(s, a32, opc);
     tcg_gen_qemu_ld_i32(val, addr, index, opc);
     tcg_temp_free(addr);
 }
@@ -1108,7 +1115,14 @@ static void gen_aa32_ld_i32(DisasContext *s, TCGv_i32 val, TCGv_i32 a32,
 static void gen_aa32_st_i32(DisasContext *s, TCGv_i32 val, TCGv_i32 a32,
                             int index, TCGMemOp opc)
 {
-    TCGv addr = gen_aa32_addr(s, a32, opc);
+    TCGv addr;
+
+    if (arm_dc_feature(s, ARM_FEATURE_M) &&
+        !arm_dc_feature(s, ARM_FEATURE_M_MAIN)) {
+        opc |= MO_ALIGN;
+    }
+
+    addr = gen_aa32_addr(s, a32, opc);
     tcg_gen_qemu_st_i32(val, addr, index, opc);
     tcg_temp_free(addr);
 }
-- 
2.17.1
