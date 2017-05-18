Received: from eggs.gnu.org ([2001:4830:134:3::10]:33254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1dBO1a-00029G-4r
	for qemu-devel@nongnu.org; Thu, 18 May 2017 12:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1dBO1Z-00055s-BT
	for qemu-devel@nongnu.org; Thu, 18 May 2017 12:11:38 -0400
From: Wei Huang <wei@redhat.com>
Date: Thu, 18 May 2017 11:11:29 -0500
Message-Id: <1495123889-32301-1-git-send-email-wei@redhat.com>
Subject: [Qemu-devel] [PATCH 1/1] target/arm: clear PMUVER field of AA64DFR0
 when vPMU=off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

The PMUv3 driver of linux kernel (in arch/arm64/kernel/perf_event.c)
relies on the PMUVER field of id_aa64dfr0_el1 to decide if PMU support
is present or not. This patch clears the PMUVER field under TCG mode
when vPMU=off. Without it, PMUv3 will init insider guest VMs even
with vPMU=off. This patch also removes a redundant line inside the
if-statement.

Signed-off-by: Wei Huang <wei@redhat.com>
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
1.8.3.1
