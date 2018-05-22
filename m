Received: from eggs.gnu.org ([2001:4830:134:3::10]:43259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1fL1A6-0006Wu-AK
	for qemu-devel@nongnu.org; Tue, 22 May 2018 02:52:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1fL1A2-0005dg-Bs
	for qemu-devel@nongnu.org; Tue, 22 May 2018 02:52:46 -0400
Received: from david.siemens.de ([192.35.17.14]:58427)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
	id 1fL1A2-0005d1-13
	for qemu-devel@nongnu.org; Tue, 22 May 2018 02:52:42 -0400
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <28b927d3-da58-bce4-cc13-bfec7f9b1cb9@siemens.com>
Date: Tue, 22 May 2018 08:52:37 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] hw/intc/arm_gicv3: Fix APxR<n> register
 dispatching
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>

There was a nasty flip in identifying which register group an access is
targeting. The issue caused spuriously raised priorities of the guest
when handing CPUs over in the Jailhouse hypervisor.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 hw/intc/arm_gicv3_cpuif.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index cb9a3a542d..5c89be1af0 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -427,7 +427,7 @@ static uint64_t icv_ap_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     GICv3CPUState *cs = icc_cs_from_env(env);
     int regno = ri->opc2 & 3;
-    int grp = ri->crm & 1 ? GICV3_G0 : GICV3_G1NS;
+    int grp = (ri->crm & 1) ? GICV3_G1NS : GICV3_G0;
     uint64_t value = cs->ich_apr[grp][regno];
 
     trace_gicv3_icv_ap_read(ri->crm & 1, regno, gicv3_redist_affid(cs), value);
@@ -439,7 +439,7 @@ static void icv_ap_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     GICv3CPUState *cs = icc_cs_from_env(env);
     int regno = ri->opc2 & 3;
-    int grp = ri->crm & 1 ? GICV3_G0 : GICV3_G1NS;
+    int grp = (ri->crm & 1) ? GICV3_G1NS : GICV3_G0;
 
     trace_gicv3_icv_ap_write(ri->crm & 1, regno, gicv3_redist_affid(cs), value);
 
@@ -1461,7 +1461,7 @@ static uint64_t icc_ap_read(CPUARMState *env, const ARMCPRegInfo *ri)
     uint64_t value;
 
     int regno = ri->opc2 & 3;
-    int grp = ri->crm & 1 ? GICV3_G0 : GICV3_G1;
+    int grp = (ri->crm & 1) ? GICV3_G1 : GICV3_G0;
 
     if (icv_access(env, grp == GICV3_G0 ? HCR_FMO : HCR_IMO)) {
         return icv_ap_read(env, ri);
@@ -1483,7 +1483,7 @@ static void icc_ap_write(CPUARMState *env, const ARMCPRegInfo *ri,
     GICv3CPUState *cs = icc_cs_from_env(env);
 
     int regno = ri->opc2 & 3;
-    int grp = ri->crm & 1 ? GICV3_G0 : GICV3_G1;
+    int grp = (ri->crm & 1) ? GICV3_G1 : GICV3_G0;
 
     if (icv_access(env, grp == GICV3_G0 ? HCR_FMO : HCR_IMO)) {
         icv_ap_write(env, ri, value);
@@ -2292,7 +2292,7 @@ static uint64_t ich_ap_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     GICv3CPUState *cs = icc_cs_from_env(env);
     int regno = ri->opc2 & 3;
-    int grp = ri->crm & 1 ? GICV3_G0 : GICV3_G1NS;
+    int grp = (ri->crm & 1) ? GICV3_G1NS : GICV3_G0;
     uint64_t value;
 
     value = cs->ich_apr[grp][regno];
@@ -2305,7 +2305,7 @@ static void ich_ap_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     GICv3CPUState *cs = icc_cs_from_env(env);
     int regno = ri->opc2 & 3;
-    int grp = ri->crm & 1 ? GICV3_G0 : GICV3_G1NS;
+    int grp = (ri->crm & 1) ? GICV3_G1NS : GICV3_G0;
 
     trace_gicv3_ich_ap_write(ri->crm & 1, regno, gicv3_redist_affid(cs), value);
 
-- 
2.13.6
