Received: from eggs.gnu.org ([2001:4830:134:3::10]:52301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSD-0004qS-CC
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqS3-0004cb-IL
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:13 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1doqS3-0004Yp-BM
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:03 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1doqRt-0005Pu-Rz
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:25:53 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Sep 2017 13:25:33 +0100
Message-Id: <1504527967-29248-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
References: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 02/36] target/arm: Don't trap WFI/WFE for M
 profile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

M profile cores can never trap on WFI or WFE instructions. Check for
M profile in check_wfx_trap() to ensure this.

The existing code will do the right thing for v7M cores because
the hcr_el2 and scr_el3 registers will be all-zeroes and so we
won't attempt to trap, but when we start setting ARM_FEATURE_V8
for v8M cores the v8A handling of SCTLR.nTWE and .nTWI will not
give the right results.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1501692241-23310-3-git-send-email-peter.maydell@linaro.org
---
 target/arm/op_helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 2a85666..5a94a5f 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -370,6 +370,11 @@ static inline int check_wfx_trap(CPUARMState *env, bool is_wfe)
     int cur_el = arm_current_el(env);
     uint64_t mask;
 
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        /* M profile cores can never trap WFI/WFE. */
+        return 0;
+    }
+
     /* If we are currently in EL0 then we need to check if SCTLR is set up for
      * WFx instructions being trapped to EL1. These trap bits don't exist in v7.
      */
-- 
2.7.4
