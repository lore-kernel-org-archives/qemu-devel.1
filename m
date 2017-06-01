Received: from eggs.gnu.org ([2001:4830:134:3::10]:35193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcY-000171-3g
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcW-0006Av-Rn
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:50 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dGTcW-00068M-Ka
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:48 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcO-0007Om-Az
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:10:40 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Jun 2017 18:10:14 +0100
Message-Id: <1496337035-30213-7-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
References: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 06/27] target/arm: clear PMUVER field of
 AA64DFR0 when vPMU=off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Wei Huang <wei@redhat.com>

The PMUv3 driver of linux kernel (in arch/arm64/kernel/perf_event.c)
relies on the PMUVER field of id_aa64dfr0_el1 to decide if PMU support
is present or not. This patch clears the PMUVER field under TCG mode
when vPMU=off. Without it, PMUv3 will init insider guest VMs even
with vPMU=off. This patch also removes a redundant line inside the
if-statement.

Signed-off-by: Wei Huang <wei@redhat.com>
Message-id: 1495123889-32301-1-git-send-email-wei@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index c185eb1..4e8fe1c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -750,8 +750,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     if (!cpu->has_pmu) {
-        cpu->has_pmu = false;
         unset_feature(env, ARM_FEATURE_PMU);
+        cpu->id_aa64dfr0 &= ~0xf00;
     }
 
     if (!arm_feature(env, ARM_FEATURE_EL2)) {
-- 
2.7.4
