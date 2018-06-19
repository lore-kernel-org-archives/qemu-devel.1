Received: from eggs.gnu.org ([2001:4830:134:3::10]:35005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fVNSv-0002nP-8S
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 16:43:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fVNSs-0003Su-2c
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 16:43:01 -0400
Received: from smtp62.i.mail.ru ([217.69.128.42]:33524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fVNSr-0003RB-Ma
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 16:42:57 -0400
From: Julia Suvorova <jusual@mail.ru>
Date: Tue, 19 Jun 2018 23:42:37 +0300
Message-Id: <20180619204237.9931-1-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH] target/arm: Set strict alignment for ARMv6-M
 load/store
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

Unlike ARMv7-M, ARMv6-M only supports naturally aligned memory accesses
for 16-bit halfword and 32-bit word accesses using the LDR, LDRH,
LDRSH, STR and STRH instructions.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
---
 target/arm/translate.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index b988d379e7..d923cbe98e 100644
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
+        !arm_dc_feature(s, ARM_FEATURE_V7)) {
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
+        !arm_dc_feature(s, ARM_FEATURE_V7)) {
+        opc |= MO_ALIGN;
+    }
+
+    addr = gen_aa32_addr(s, a32, opc);
     tcg_gen_qemu_st_i32(val, addr, index, opc);
     tcg_temp_free(addr);
 }
-- 
2.17.0
