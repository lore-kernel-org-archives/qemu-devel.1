Received: from eggs.gnu.org ([2001:4830:134:3::10]:39436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fV1yn-0003Ww-MO
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 17:46:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fV1yj-0001Tc-O2
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 17:46:29 -0400
Received: from smtp39.i.mail.ru ([94.100.177.99]:55166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fV1yj-0001Ri-Co
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 17:46:25 -0400
From: Julia Suvorova <jusual@mail.ru>
Date: Tue, 19 Jun 2018 00:46:04 +0300
Message-Id: <20180618214604.6777-1-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH] target/arm: Minor cleanup for ARMv6-M 32-bit
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <mail@steffen-goertz.de>, Richard Henderson <richard.henderson@linaro.org>, Julia Suvorova <jusual@mail.ru>

The arrays were made static, "if" was simplified because V7M and V8M
define V6 feature.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
---
 target/arm/translate.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index df26035863..e779942e9b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10107,18 +10107,18 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
         !arm_dc_feature(s, ARM_FEATURE_V7)) {
         int i;
         bool found = false;
-        const uint32_t armv6m_insn[] = {0xf3808000 /* msr */,
-                                        0xf3b08040 /* dsb */,
-                                        0xf3b08050 /* dmb */,
-                                        0xf3b08060 /* isb */,
-                                        0xf3e08000 /* mrs */,
-                                        0xf000d000 /* bl */};
-        const uint32_t armv6m_mask[] = {0xffe0d000,
-                                        0xfff0d0f0,
-                                        0xfff0d0f0,
-                                        0xfff0d0f0,
-                                        0xffe0d000,
-                                        0xf800d000};
+        static const uint32_t armv6m_insn[] = {0xf3808000 /* msr */,
+                                               0xf3b08040 /* dsb */,
+                                               0xf3b08050 /* dmb */,
+                                               0xf3b08060 /* isb */,
+                                               0xf3e08000 /* mrs */,
+                                               0xf000d000 /* bl */};
+        static const uint32_t armv6m_mask[] = {0xffe0d000,
+                                               0xfff0d0f0,
+                                               0xfff0d0f0,
+                                               0xfff0d0f0,
+                                               0xffe0d000,
+                                               0xf800d000};
 
         for (i = 0; i < ARRAY_SIZE(armv6m_insn); i++) {
             if ((insn & armv6m_mask[i]) == armv6m_insn[i]) {
@@ -11051,8 +11051,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                         break;
                     case 3: /* Special control operations.  */
                         if (!arm_dc_feature(s, ARM_FEATURE_V7) &&
-                            !(arm_dc_feature(s, ARM_FEATURE_V6) &&
-                              arm_dc_feature(s, ARM_FEATURE_M))) {
+                            !arm_dc_feature(s, ARM_FEATURE_M)) {
                             goto illegal_op;
                         }
                         op = (insn >> 4) & 0xf;
-- 
2.17.0
