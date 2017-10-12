Received: from eggs.gnu.org ([2001:4830:134:3::10]:44109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fxR-0003IG-CG
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:03:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fxQ-0004aa-B3
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:03:37 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1e2fxQ-0004a8-4V
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:03:36 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fxP-0000eD-3m
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:03:35 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Oct 2017 17:03:30 +0100
Message-Id: <1507824216-29058-8-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1507824216-29058-1-git-send-email-peter.maydell@linaro.org>
References: <1507824216-29058-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 07/13] target-arm: Don't check for "Thumb2 or M
 profile" for not-Thumb1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1507556919-24992-6-git-send-email-peter.maydell@linaro.org
---
 target/arm/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 5c6f9fe..530a5c4 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9719,8 +9719,7 @@ static int disas_thumb2_insn(CPUARMState *env, DisasContext *s, uint16_t insn_hw
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
