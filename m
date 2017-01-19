Received: from eggs.gnu.org ([2001:4830:134:3::10]:47713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPx-00014p-2s
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPs-0005Ea-7t
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:21 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cUDPr-00055o-W6
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:16 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPa-00035V-Si
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:09:58 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 14:09:25 +0000
Message-Id: <1484834995-26826-7-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
References: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 06/36] target/arm: Implement DBGVCR32_EL2 system
 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The DBGVCR_EL2 system register is needed to run a 32-bit
EL1 guest under a Linux EL2 64-bit hypervisor. Its only
purpose is to provide AArch64 with access to the state of
the DBGVCR AArch32 register. Since we only have a dummy
DBGVCR, implement a corresponding dummy DBGVCR32_EL2.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/arm/helper.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ba72ebb..7111c8c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4066,6 +4066,13 @@ static const ARMCPRegInfo debug_cp_reginfo[] = {
       .cp = 14, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tda,
       .type = ARM_CP_NOP },
+    /* Dummy DBGVCR32_EL2 (which is only for a 64-bit hypervisor
+     * to save and restore a 32-bit guest's DBGVCR)
+     */
+    { .name = "DBGVCR32_EL2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 2, .opc1 = 4, .crn = 0, .crm = 7, .opc2 = 0,
+      .access = PL2_RW, .accessfn = access_tda,
+      .type = ARM_CP_NOP },
     /* Dummy MDCCINT_EL1, since we don't implement the Debug Communications
      * Channel but Linux may try to access this register. The 32-bit
      * alias is DBGDCCINT.
-- 
2.7.4
