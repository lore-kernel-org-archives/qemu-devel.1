Received: from eggs.gnu.org ([2001:4830:134:3::10]:35063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcT-00012u-Pl
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcS-00067g-Uv
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:45 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dGTcS-00064g-Ne
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:44 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcR-0007Q3-Jm
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:10:43 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Jun 2017 18:10:19 +0100
Message-Id: <1496337035-30213-12-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
References: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/27] arm: Don't clear ARM_FEATURE_PMSA for
 no-mpu configs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Fix the handling of QOM properties for PMSA CPUs with no MPU:

Allow no-MPU to be specified by either:
 * has-mpu = false
 * pmsav7_dregion = 0
and make setting one imply the other. Don't clear the PMSA
feature bit in this situation.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 1493122030-32191-6-git-send-email-peter.maydell@linaro.org
---
 target/arm/cpu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f844af5..76a5e20 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -763,8 +763,14 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         cpu->id_pfr1 &= ~0xf000;
     }
 
+    /* MPU can be configured out of a PMSA CPU either by setting has-mpu
+     * to false or by setting pmsav7-dregion to 0.
+     */
     if (!cpu->has_mpu) {
-        unset_feature(env, ARM_FEATURE_PMSA);
+        cpu->pmsav7_dregion = 0;
+    }
+    if (cpu->pmsav7_dregion == 0) {
+        cpu->has_mpu = false;
     }
 
     if (arm_feature(env, ARM_FEATURE_PMSA) &&
-- 
2.7.4
