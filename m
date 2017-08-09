Received: from eggs.gnu.org ([2001:4830:134:3::10]:46712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dfL2W-0006Dn-B4
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 03:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dfL2V-00040l-8t
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 03:04:24 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  9 Aug 2017 17:03:57 +1000
Message-Id: <20170809070357.28723-7-david@gibson.dropbear.id.au>
In-Reply-To: <20170809070357.28723-1-david@gibson.dropbear.id.au>
References: <20170809070357.28723-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 6/6] spapr: Fix bug in h_signal_sys_reset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, Sam Bobroff <sam.bobroff@au1.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Sam Bobroff <sam.bobroff@au1.ibm.com>

The unicast case in h_signal_sys_reset() seems to be broken:
rather than selecting the target CPU, it looks like it will pick
either the first CPU or fail to find one at all.

Fix it by using the search function rather than open coding the
search.

This was found by inspection; the code appears to be unused because
the Linux kernel only uses the broadcast target.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_hcall.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 72ea5a8247..07b3da8dc4 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1431,11 +1431,10 @@ static target_ulong h_signal_sys_reset(PowerPCCPU *cpu,
 
     } else {
         /* Unicast */
-        CPU_FOREACH(cs) {
-            if (cpu->cpu_dt_id == target) {
-                run_on_cpu(cs, spapr_do_system_reset_on_cpu, RUN_ON_CPU_NULL);
-                return H_SUCCESS;
-            }
+        cs = CPU(ppc_get_vcpu_by_dt_id(target));
+        if (cs) {
+            run_on_cpu(cs, spapr_do_system_reset_on_cpu, RUN_ON_CPU_NULL);
+            return H_SUCCESS;
         }
         return H_PARAMETER;
     }
-- 
2.13.4
