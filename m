Received: from eggs.gnu.org ([2001:4830:134:3::10]:32978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfo-000214-GD
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfn-0006UH-H9
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:56 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fTpfn-0006Tj-9c
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:55 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfm-0003td-AL
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:25:54 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 15:25:21 +0100
Message-Id: <20180615142521.19143-44-peter.maydell@linaro.org>
In-Reply-To: <20180615142521.19143-1-peter.maydell@linaro.org>
References: <20180615142521.19143-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 43/43] target/arm: Allow ARMv6-M Thumb2
 instructions
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

ARMv6-M supports 6 Thumb2 instructions. This patch checks for these
instructions and allows their execution.
Like Thumb2 cores, ARMv6-M always interprets BL instruction as 32-bit.

This patch is required for future Cortex-M0 support.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20180612204632.28780-1-jusual@mail.ru
[PMM: move armv6m_insn[] and armv6m_mask[] closer to
 point of use, and mark 'const'. Check for M-and-not-v7
 rather than M-and-6.]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 43 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 0ff5edf2cec..f405c82fb24 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9965,7 +9965,8 @@ static bool thumb_insn_is_16bit(DisasContext *s, uint32_t insn)
      * end up actually treating this as two 16-bit insns, though,
      * if it's half of a bl/blx pair that might span a page boundary.
      */
-    if (arm_dc_feature(s, ARM_FEATURE_THUMB2)) {
+    if (arm_dc_feature(s, ARM_FEATURE_THUMB2) ||
+        arm_dc_feature(s, ARM_FEATURE_M)) {
         /* Thumb2 cores (including all M profile ones) always treat
          * 32-bit insns as 32-bit.
          */
@@ -10085,10 +10086,38 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
     int conds;
     int logic_cc;
 
-    /* The only 32 bit insn that's allowed for Thumb1 is the combined
-     * BL/BLX prefix and suffix.
+    /*
+     * ARMv6-M supports a limited subset of Thumb2 instructions.
+     * Other Thumb1 architectures allow only 32-bit
+     * combined BL/BLX prefix and suffix.
      */
-    if ((insn & 0xf800e800) != 0xf000e800) {
+    if (arm_dc_feature(s, ARM_FEATURE_M) &&
+        !arm_dc_feature(s, ARM_FEATURE_V7)) {
+        int i;
+        bool found = false;
+        const uint32_t armv6m_insn[] = {0xf3808000 /* msr */,
+                                        0xf3b08040 /* dsb */,
+                                        0xf3b08050 /* dmb */,
+                                        0xf3b08060 /* isb */,
+                                        0xf3e08000 /* mrs */,
+                                        0xf000d000 /* bl */};
+        const uint32_t armv6m_mask[] = {0xffe0d000,
+                                        0xfff0d0f0,
+                                        0xfff0d0f0,
+                                        0xfff0d0f0,
+                                        0xffe0d000,
+                                        0xf800d000};
+
+        for (i = 0; i < ARRAY_SIZE(armv6m_insn); i++) {
+            if ((insn & armv6m_mask[i]) == armv6m_insn[i]) {
+                found = true;
+                break;
+            }
+        }
+        if (!found) {
+            goto illegal_op;
+        }
+    } else if ((insn & 0xf800e800) != 0xf000e800)  {
         ARCH(6T2);
     }
 
@@ -11009,7 +11038,11 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                         }
                         break;
                     case 3: /* Special control operations.  */
-                        ARCH(7);
+                        if (!arm_dc_feature(s, ARM_FEATURE_V7) &&
+                            !(arm_dc_feature(s, ARM_FEATURE_V6) &&
+                              arm_dc_feature(s, ARM_FEATURE_M))) {
+                            goto illegal_op;
+                        }
                         op = (insn >> 4) & 0xf;
                         switch (op) {
                         case 2: /* clrex */
-- 
2.17.1
