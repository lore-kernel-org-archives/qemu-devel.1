Received: from eggs.gnu.org ([2001:4830:134:3::10]:49923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLd1-0003SW-R2
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLd0-0005I8-Tp
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:27 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fWLd0-00053n-KM
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:26 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLcp-0003pr-8j
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:57:15 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 13:56:47 +0100
Message-Id: <20180622125713.15303-3-peter.maydell@linaro.org>
In-Reply-To: <20180622125713.15303-1-peter.maydell@linaro.org>
References: <20180622125713.15303-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 02/28] target/arm: Minor cleanup for ARMv6-M
 32-bit instructions
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

The arrays were made static, "if" was simplified because V7M and V8M
define V6 feature.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20180618214604.6777-1-jusual@mail.ru
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index f405c82fb24..b988d379e7c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10095,18 +10095,18 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
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
@@ -11039,8 +11039,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
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
2.17.1
