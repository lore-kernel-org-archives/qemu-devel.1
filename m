Received: from eggs.gnu.org ([2001:4830:134:3::10]:49624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlEU-0005ID-J0
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlET-0003w7-Pq
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:34 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 18 Jun 2018 13:52:58 +1000
Message-Id: <20180618035324.19907-3-david@gibson.dropbear.id.au>
In-Reply-To: <20180618035324.19907-1-david@gibson.dropbear.id.au>
References: <20180618035324.19907-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 02/28] ppc/spapr_caps: Don't disable cap_cfpc on
 POWER8 by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, aik@ozlabs.ru, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

In default_caps_with_cpu() we set spapr_cap_cfpc to broken for POWER8
processors and before.

Since we no longer require private l1d cache on POWER8 for this cap to
be set to workaround change this to default to broken for POWER7
processors and before.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
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
2.17.1
