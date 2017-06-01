Received: from eggs.gnu.org ([2001:4830:134:3::10]:35203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcY-00017C-DH
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcX-0006BU-AW
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:50 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dGTcX-00067A-1b
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:49 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcN-0007OB-00
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:10:39 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Jun 2017 18:10:12 +0100
Message-Id: <1496337035-30213-5-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
References: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/27] hw/intc/arm_gicv3_cpuif: Don't let BPR be
 set below its minimum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

icc_bpr_write() was not enforcing that writing a value below the
minimum for the BPR should behave as if the BPR was set to the
minimum value. This doesn't make a difference for the secure
BPRs (since we define the minimum for the QEMU implementation
as zero) but did mean we were allowing the NS BPR1 to be set to
0 when 1 should be the lowest value.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 1493226792-3237-3-git-send-email-peter.maydell@linaro.org
---
 hw/intc/arm_gicv3_cpuif.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index d31eba0..e660b3f 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -1388,6 +1388,7 @@ static void icc_bpr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     GICv3CPUState *cs = icc_cs_from_env(env);
     int grp = (ri->crm == 8) ? GICV3_G0 : GICV3_G1;
+    uint64_t minval;
 
     if (icv_access(env, grp == GICV3_G0 ? HCR_FMO : HCR_IMO)) {
         icv_bpr_write(env, ri, value);
@@ -1415,6 +1416,11 @@ static void icc_bpr_write(CPUARMState *env, const ARMCPRegInfo *ri,
         return;
     }
 
+    minval = (grp == GICV3_G1NS) ? GIC_MIN_BPR_NS : GIC_MIN_BPR;
+    if (value < minval) {
+        value = minval;
+    }
+
     cs->icc_bpr[grp] = value & 7;
     gicv3_cpuif_update(cs);
 }
-- 
2.7.4
