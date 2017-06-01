Received: from eggs.gnu.org ([2001:4830:134:3::10]:35343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcb-0001Ac-W9
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcX-0006Bi-RW
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:53 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dGTcX-00064g-Ix
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:49 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcM-0007Nx-Cw
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:10:38 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Jun 2017 18:10:11 +0100
Message-Id: <1496337035-30213-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
References: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/27] hw/intc/arm_gicv3_cpuif: Fix reset value
 for VMCR_EL2.VBPR1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We were setting the VBPR1 field of VMCR_EL2 to icv_min_vbpr()
on reset, but this is not correct. The field should reset to
the minimum value of ICV_BPR0_EL1 plus one.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 1493226792-3237-2-git-send-email-peter.maydell@linaro.org
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
