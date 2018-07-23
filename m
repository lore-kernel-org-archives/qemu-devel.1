Received: from eggs.gnu.org ([2001:4830:134:3::10]:41045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhIf-0001nD-NR
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhIb-00031k-Es
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:21 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:16:33 -0500
Message-Id: <20180723201748.25573-25-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 24/99] hw/intc/arm_gicv3: Fix APxR<n> register
 dispatching
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jan Kiszka <jan.kiszka@siemens.com>, Peter Maydell <peter.maydell@linaro.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

There was a nasty flip in identifying which register group an access is
targeting. The issue caused spuriously raised priorities of the guest
when handing CPUs over in the Jailhouse hypervisor.

Cc: qemu-stable@nongnu.org
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Message-id: 28b927d3-da58-bce4-cc13-bfec7f9b1cb9@siemens.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 887aae10f6150dfdc71c45d7588e8efe6c144019)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/intc/arm_gicv3_cpuif.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 26f5eeda94..554be25cb7 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -431,7 +431,7 @@ static uint64_t icv_ap_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     GICv3CPUState *cs = icc_cs_from_env(env);
     int regno = ri->opc2 & 3;
-    int grp = ri->crm & 1 ? GICV3_G0 : GICV3_G1NS;
+    int grp = (ri->crm & 1) ? GICV3_G1NS : GICV3_G0;
     uint64_t value = cs->ich_apr[grp][regno];
 
     trace_gicv3_icv_ap_read(ri->crm & 1, regno, gicv3_redist_affid(cs), value);
@@ -443,7 +443,7 @@ static void icv_ap_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     GICv3CPUState *cs = icc_cs_from_env(env);
     int regno = ri->opc2 & 3;
-    int grp = ri->crm & 1 ? GICV3_G0 : GICV3_G1NS;
+    int grp = (ri->crm & 1) ? GICV3_G1NS : GICV3_G0;
 
     trace_gicv3_icv_ap_write(ri->crm & 1, regno, gicv3_redist_affid(cs), value);
 
@@ -1465,7 +1465,7 @@ static uint64_t icc_ap_read(CPUARMState *env, const ARMCPRegInfo *ri)
     uint64_t value;
 
     int regno = ri->opc2 & 3;
-    int grp = ri->crm & 1 ? GICV3_G0 : GICV3_G1;
+    int grp = (ri->crm & 1) ? GICV3_G1 : GICV3_G0;
 
     if (icv_access(env, grp == GICV3_G0 ? HCR_FMO : HCR_IMO)) {
         return icv_ap_read(env, ri);
@@ -1487,7 +1487,7 @@ static void icc_ap_write(CPUARMState *env, const ARMCPRegInfo *ri,
     GICv3CPUState *cs = icc_cs_from_env(env);
 
     int regno = ri->opc2 & 3;
-    int grp = ri->crm & 1 ? GICV3_G0 : GICV3_G1;
+    int grp = (ri->crm & 1) ? GICV3_G1 : GICV3_G0;
 
     if (icv_access(env, grp == GICV3_G0 ? HCR_FMO : HCR_IMO)) {
         icv_ap_write(env, ri, value);
@@ -2296,7 +2296,7 @@ static uint64_t ich_ap_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     GICv3CPUState *cs = icc_cs_from_env(env);
     int regno = ri->opc2 & 3;
-    int grp = ri->crm & 1 ? GICV3_G0 : GICV3_G1NS;
+    int grp = (ri->crm & 1) ? GICV3_G1NS : GICV3_G0;
     uint64_t value;
 
     value = cs->ich_apr[grp][regno];
@@ -2309,7 +2309,7 @@ static void ich_ap_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     GICv3CPUState *cs = icc_cs_from_env(env);
     int regno = ri->opc2 & 3;
-    int grp = ri->crm & 1 ? GICV3_G0 : GICV3_G1NS;
+    int grp = (ri->crm & 1) ? GICV3_G1NS : GICV3_G0;
 
     trace_gicv3_ich_ap_write(ri->crm & 1, regno, gicv3_redist_affid(cs), value);
 
-- 
2.17.1
