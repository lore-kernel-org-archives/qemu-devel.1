Received: from eggs.gnu.org ([2001:4830:134:3::10]:35161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcX-00016S-H8
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcW-0006Ai-AK
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:49 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dGTcW-00067A-2w
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:48 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcU-0007Ra-UL
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:10:46 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Jun 2017 18:10:24 +0100
Message-Id: <1496337035-30213-17-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
References: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/27] arm: All M profile cores are PMSA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

All M profile CPUs are PMSA, so set the feature bit.
(We haven't actually implemented the M profile MPU register
interface yet, but setting this feature bit gives us closer
to correct behaviour for the MPU-disabled case.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 1493122030-32191-11-git-send-email-peter.maydell@linaro.org
---
 target/arm/cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 76a5e20..e748097 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -550,6 +550,14 @@ static void arm_cpu_post_init(Object *obj)
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
