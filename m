Received: from eggs.gnu.org ([2001:4830:134:3::10]:47136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d2zFd-0002Yb-7W
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 08:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d2zFc-0004eE-D5
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 08:07:25 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Apr 2017 13:07:02 +0100
Message-Id: <1493122030-32191-6-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1493122030-32191-1-git-send-email-peter.maydell@linaro.org>
References: <1493122030-32191-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 05/13] arm: Don't clear ARM_FEATURE_PMSA for
 no-mpu configs
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

Fix the handling of QOM properties for PMSA CPUs with no MPU:

Allow no-MPU to be specified by either:
 * has-mpu = false
 * pmsav7_dregion = 0
and make setting one imply the other. Don't clear the PMSA
feature bit in this situation.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f17e279..8e57498 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -757,8 +757,14 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         cpu->id_pfr1 &= ~0xf000;
     }
 
+    /* MPU can be configured out of a PMSA CPU either by setting has-mpu
+     * to false or by setting pmsav7-dregion to 0.
+     */
     if (!cpu->has_mpu) {
-        unset_feature(ARM_FEATURE_PMSA);
+        cpu->pmsav7_dregion = 0;
+    }
+    if (cpu->pmsav7_dregion == 0) {
+        cpu->has_mpu = false;
     }
 
     if (arm_feature(env, ARM_FEATURE_PMSA) &&
-- 
2.7.4
