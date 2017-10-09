Received: from eggs.gnu.org ([2001:4830:134:3::10]:43528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e1YQT-0001MS-56
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 09:48:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e1YQS-0004A3-2d
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 09:48:57 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Oct 2017 14:48:35 +0100
Message-Id: <1507556919-24992-6-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1507556919-24992-1-git-send-email-peter.maydell@linaro.org>
References: <1507556919-24992-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 5/9] target-arm: Don't check for "Thumb2 or M
 profile" for not-Thumb1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, patches@linaro.org

The code which implements the Thumb1 split BL/BLX instructions
is guarded by a check on "not M or THUMB2". All we really need
to check here is "not THUMB2" (and we assume that elsewhere too,
eg in the ARCH(6T2) test that UNDEFs the Thumb2 insns).

This doesn't change behaviour because all M profile cores
have Thumb2 and so ARM_FEATURE_M implies ARM_FEATURE_THUMB2.
(v6M implements a very restricted subset of Thumb2, but we
can cross that bridge when we get to it with appropriate
feature bits.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 58d706c..f5ca87f 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9722,8 +9722,7 @@ static int disas_thumb2_insn(CPUARMState *env, DisasContext *s, uint16_t insn_hw
     int conds;
     int logic_cc;
 
-    if (!(arm_dc_feature(s, ARM_FEATURE_THUMB2)
-          || arm_dc_feature(s, ARM_FEATURE_M))) {
+    if (!arm_dc_feature(s, ARM_FEATURE_THUMB2)) {
         /* Thumb-1 cores may need to treat bl and blx as a pair of
            16-bit instructions to get correct prefetch abort behavior.  */
         insn = insn_hw1;
-- 
2.7.4
