Received: from eggs.gnu.org ([2001:4830:134:3::10]:47093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d2zFb-0002X7-LC
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 08:07:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d2zFW-0004ZK-0T
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 08:07:23 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Apr 2017 13:07:03 +0100
Message-Id: <1493122030-32191-7-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1493122030-32191-1-git-send-email-peter.maydell@linaro.org>
References: <1493122030-32191-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 06/13] arm: Don't let no-MPU PMSA cores write
 to SCTLR.M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>

If the CPU is a PMSA config with no MPU implemented, then the
SCTLR.M bit should be RAZ/WI, so that the guest can never
turn on the non-existent MPU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 404bfdb..f0f25c8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3258,6 +3258,11 @@ static void sctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
         return;
     }
 
+    if (arm_feature(env, ARM_FEATURE_PMSA) && !cpu->has_mpu) {
+        /* M bit is RAZ/WI for PMSA with no MPU implemented */
+        value &= ~SCTLR_M;
+    }
+
     raw_write(env, ri, value);
     /* ??? Lots of these bits are not implemented.  */
     /* This may enable/disable the MMU, so do a TLB flush.  */
-- 
2.7.4
