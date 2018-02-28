Received: from eggs.gnu.org ([2001:4830:134:3::10]:35814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er7SB-0003Yf-Nn
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:31:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er7SA-0006VC-RT
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:31:51 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:36888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1er7SA-0006Ug-Lj
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:31:50 -0500
Received: by mail-pl0-x244.google.com with SMTP id ay8-v6so2120098plb.4
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 11:31:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 28 Feb 2018 11:31:24 -0800
Message-Id: <20180228193125.20577-16-richard.henderson@linaro.org>
In-Reply-To: <20180228193125.20577-1-richard.henderson@linaro.org>
References: <20180228193125.20577-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 15/16] target/arm: Decode t32 simd 3reg and
 2reg_scalar extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

Happily, the bits are in the same places compared to a32.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 3ad8b4031c..ba6ab7d287 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10774,7 +10774,19 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                                default_exception_el(s));
             break;
         }
-        if (((insn >> 24) & 3) == 3) {
+        if ((insn & 0xfe000a00) == 0xfc000800
+            && arm_dc_feature(s, ARM_FEATURE_V8)) {
+            /* The Thumb2 and ARM encodings are identical.  */
+            if (disas_neon_insn_3same_ext(s, insn)) {
+                goto illegal_op;
+            }
+        } else if ((insn & 0xff000a00) == 0xfe000800
+                   && arm_dc_feature(s, ARM_FEATURE_V8)) {
+            /* The Thumb2 and ARM encodings are identical.  */
+            if (disas_neon_insn_2reg_scalar_ext(s, insn)) {
+                goto illegal_op;
+            }
+        } else if (((insn >> 24) & 3) == 3) {
             /* Translate into the equivalent ARM encoding.  */
             insn = (insn & 0xe2ffffff) | ((insn & (1 << 28)) >> 4) | (1 << 28);
             if (disas_neon_data_insn(s, insn)) {
-- 
2.14.3
