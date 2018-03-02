Received: from eggs.gnu.org ([2001:4830:134:3::10]:43681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWs-0003BG-7O
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:07:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWr-000568-Dh
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:07:10 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eriWr-00055M-6e
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:07:09 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWq-0001Ro-2y
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:07:08 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  2 Mar 2018 11:06:39 +0000
Message-Id: <20180302110640.28004-39-peter.maydell@linaro.org>
In-Reply-To: <20180302110640.28004-1-peter.maydell@linaro.org>
References: <20180302110640.28004-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 38/39] target/arm: Decode t32 simd 3reg and
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

From: Richard Henderson <richard.henderson@linaro.org>

Happily, the bits are in the same places compared to a32.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180228193125.20577-16-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.16.2
