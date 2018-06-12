Received: from eggs.gnu.org ([2001:4830:134:3::10]:53620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fSqCB-0006wJ-HT
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 16:47:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fSqC6-0004Ub-Lv
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 16:47:15 -0400
Received: from smtp57.i.mail.ru ([217.69.128.37]:44492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fSqC6-0004S0-AR
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 16:47:10 -0400
From: Julia Suvorova <jusual@mail.ru>
Date: Tue, 12 Jun 2018 23:46:32 +0300
Message-Id: <20180612204632.28780-1-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH] target/arm: Allow ARMv6-M Thumb2 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <mail@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

ARMv6-M supports 6 Thumb2 instructions. This patch checks for these
instructions and allows their execution.
Like Thumb2 cores, ARMv6-M always interprets BL instruction as 32-bit.

This patch is required for future Cortex-M0 support.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
---
 target/arm/translate.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 0ff5edf2ce..8cae3f5ed0 100644
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
@@ -10075,6 +10076,11 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 {
     uint32_t imm, shift, offset;
     uint32_t rd, rn, rm, rs;
+    uint32_t armv6m_insn[] = {0xf3808000 /* msr */, 0xf3b08040 /* dsb */,
+                              0xf3b08050 /* dmb */, 0xf3b08060 /* isb */,
+                              0xf3e08000 /* mrs */, 0xf000d000 /* bl */};
+    uint32_t armv6m_mask[] = {0xffe0d000, 0xfff0d0f0, 0xfff0d0f0,
+                              0xfff0d0f0, 0xffe0d000, 0xf800d000};
     TCGv_i32 tmp;
     TCGv_i32 tmp2;
     TCGv_i32 tmp3;
@@ -10085,10 +10091,25 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
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
+    if (arm_dc_feature(s, ARM_FEATURE_M) && arm_dc_feature(s, ARM_FEATURE_V6)) {
+        int i;
+        bool found = false;
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
 
@@ -11009,7 +11030,11 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
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
2.17.0
