Received: from eggs.gnu.org ([2001:4830:134:3::10]:39989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1fSbg7-0000t5-Q7
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 01:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1fSbg6-0005vy-VF
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 01:17:11 -0400
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Tue, 12 Jun 2018 15:16:30 +1000
Message-Id: <20180612051630.17854-2-sjitindarsingh@gmail.com>
In-Reply-To: <20180612051630.17854-1-sjitindarsingh@gmail.com>
References: <20180612051630.17854-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH V2 2/2] ppc/spapr_caps: Don't
 disable cap_cfpc on POWER8 by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, groug@kaod.org, muriloo@linux.ibm.com, sjitindarsingh@gmail.com

In default_caps_with_cpu() we set spapr_cap_cfpc to broken for POWER8
processors and before.

Since we no longer require private l1d cache on POWER8 for this cap to
be set to workaround change this to default to broken for POWER7
processors and before.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

---

V1 -> V2:
- No Change

---
 hw/ppc/spapr_caps.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 531e145114..00e43a9ba7 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -335,14 +335,10 @@ static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
 
     caps = smc->default_caps;
 
-    if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00,
-                          0, spapr->max_compat_pvr)) {
-        caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_BROKEN;
-    }
-
     if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_07,
                           0, spapr->max_compat_pvr)) {
         caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
+        caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_BROKEN;
     }
 
     if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_06_PLUS,
-- 
2.13.6
