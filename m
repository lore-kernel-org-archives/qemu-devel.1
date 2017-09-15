Received: from eggs.gnu.org ([2001:4830:134:3::10]:54125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfK-0006dF-Iz
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfJ-0003MZ-Bb
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:42 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Sep 2017 13:51:18 +1000
Message-Id: <20170915035130.8354-7-david@gibson.dropbear.id.au>
In-Reply-To: <20170915035130.8354-1-david@gibson.dropbear.id.au>
References: <20170915035130.8354-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 06/18] spapr: only update SDR1 once per-cpu
 during CAS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, gkurz@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Commit b55d295e3ec9 added the possibility to support HPT resizing with KVM.
In the case of PR, we need to pass the userspace address of the HPT to KVM
using the SDR1 slot.
This is handled by kvmppc_update_sdr1() which uses CPU_FOREACH() to update
all CPUs. It is hence not needed to call kvmppc_update_sdr1() for each CPU.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_hcall.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 8b3c0e17e7..6ab8c188f3 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1559,20 +1559,16 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
         }
 
         if (spapr->htab_shift < maxshift) {
-            CPUState *cs;
-
             /* Guest doesn't know about HPT resizing, so we
              * pre-emptively resize for the maximum permitted RAM.  At
              * the point this is called, nothing should have been
              * entered into the existing HPT */
             spapr_reallocate_hpt(spapr, maxshift, &error_fatal);
-            CPU_FOREACH(cs) {
-                if (kvm_enabled()) {
-                    /* For KVM PR, update the HPT pointer */
-                    target_ulong sdr1 = (target_ulong)(uintptr_t)spapr->htab
-                        | (spapr->htab_shift - 18);
-                    kvmppc_update_sdr1(sdr1);
-                }
+            if (kvm_enabled()) {
+                /* For KVM PR, update the HPT pointer */
+                target_ulong sdr1 = (target_ulong)(uintptr_t)spapr->htab
+                    | (spapr->htab_shift - 18);
+                kvmppc_update_sdr1(sdr1);
             }
         }
     }
-- 
2.13.5
