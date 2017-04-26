Received: from eggs.gnu.org ([2001:4830:134:3::10]:43572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d3QVK-00025b-DO
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 13:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d3QVJ-0000Mf-Is
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 13:13:26 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Apr 2017 18:13:10 +0100
Message-Id: <1493226792-3237-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1493226792-3237-1-git-send-email-peter.maydell@linaro.org>
References: <1493226792-3237-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/3] hw/intc/arm_gicv3_cpuif: Fix reset value
 for VMCR_EL2.VBPR1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

We were setting the VBPR1 field of VMCR_EL2 to icv_min_vbpr()
on reset, but this is not correct. The field should reset to
the minimum value of ICV_BPR0_EL1 plus one.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_cpuif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 0b20856..d31eba0 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -2014,7 +2014,7 @@ static void icc_reset(CPUARMState *env, const ARMCPRegInfo *ri)
     cs->ich_hcr_el2 = 0;
     memset(cs->ich_lr_el2, 0, sizeof(cs->ich_lr_el2));
     cs->ich_vmcr_el2 = ICH_VMCR_EL2_VFIQEN |
-        (icv_min_vbpr(cs) << ICH_VMCR_EL2_VBPR1_SHIFT) |
+        ((icv_min_vbpr(cs) + 1) << ICH_VMCR_EL2_VBPR1_SHIFT) |
         (icv_min_vbpr(cs) << ICH_VMCR_EL2_VBPR0_SHIFT);
 }
 
-- 
2.7.4
