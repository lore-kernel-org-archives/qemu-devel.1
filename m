Received: from eggs.gnu.org ([2001:4830:134:3::10]:44165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fWH1v-00028c-Sl
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:02:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fWH1s-0002f0-Jc
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:02:51 -0400
Received: from smtp58.i.mail.ru ([217.69.128.38]:40232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fWH1s-0002eN-CU
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:02:48 -0400
From: Julia Suvorova <jusual@mail.ru>
Date: Fri, 22 Jun 2018 11:01:38 +0300
Message-Id: <20180622080138.17702-3-jusual@mail.ru>
In-Reply-To: <20180622080138.17702-1-jusual@mail.ru>
References: <20180622080138.17702-1-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH v2 2/2] target/arm: Strict alignment for
 ARMv6-M and ARMv8-M Baseline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <mail@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

Unlike ARMv7-M, ARMv6-M and ARMv8-M Baseline only supports naturally
aligned memory accesses for load/store instructions.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
---
 target/arm/translate.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index b988d379e7..2a3e4f5d4c 100644
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
2.17.0
