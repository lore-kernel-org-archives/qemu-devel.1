Received: from eggs.gnu.org ([2001:4830:134:3::10]:47192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d2zFg-0002aK-AG
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 08:07:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d2zFf-0004gC-Cx
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 08:07:28 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Apr 2017 13:07:07 +0100
Message-Id: <1493122030-32191-11-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1493122030-32191-1-git-send-email-peter.maydell@linaro.org>
References: <1493122030-32191-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 10/13] arm: All M profile cores are PMSA
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

All M profile CPUs are PMSA, so set the feature bit.
(We haven't actually implemented the M profile MPU register
interface yet, but setting this feature bit gives us closer
to correct behaviour for the MPU-disabled case.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 8e57498..df8b835 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -543,6 +543,14 @@ static void arm_cpu_post_init(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
 
+    /* M profile implies PMSA. We have to do this here rather than
+     * in realize with the other feature-implication checks because
+     * we look at the PMSA bit to see if we should add some properties.
+     */
+    if (arm_feature(&cpu->env, ARM_FEATURE_M)) {
+        set_feature(&cpu->env, ARM_FEATURE_PMSA);
+    }
+
     if (arm_feature(&cpu->env, ARM_FEATURE_CBAR) ||
         arm_feature(&cpu->env, ARM_FEATURE_CBAR_RO)) {
         qdev_property_add_static(DEVICE(obj), &arm_cpu_reset_cbar_property,
-- 
2.7.4
