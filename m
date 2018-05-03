Received: from eggs.gnu.org ([2001:4830:134:3::10]:40961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE7cs-00074y-2Y
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE7cq-0002On-9A
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:21:58 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  3 May 2018 16:21:43 +1000
Message-Id: <20180503062145.17899-7-david@gibson.dropbear.id.au>
In-Reply-To: <20180503062145.17899-1-david@gibson.dropbear.id.au>
References: <20180503062145.17899-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 6/8] target/ppc: Delay initialization of
 LPCR_UPRT for secondary cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org, clg@kaod.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

In cpu_ppc_set_papr() the UPRT and GTSE bits of the LPCR default value are
initialized based on on ppc64_radix_guest().  Which seems reasonable,
except that ppc64_radix_guest() is based on spapr->patb_entry which is
only set up in spapr_machine_reset, called _after_ cpu_ppc_set_papr() for
boot cpus.  Well, and the fact that modifying the SPR default value for an
instance rather than a class is kind of yucky.

The initialization here is really only necessary or valid for
hotplugged cpus; the base cpu initialization already sets a value
that's good enough for the boot cpus until the guest uses an hcall to
configure it's preferred MMU mode.

So, move this initialization to the rtas_start_cpu() path, at which point
ppc64_radix_guest() will have a sensible value, to make sure secondary cpus
come up in an MMU mode matching the existing cpus.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_rtas.c         | 12 ++++++++++++
 target/ppc/translate_init.c | 16 ----------------
 2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 840d198a8d..652233bdf1 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -47,6 +47,7 @@
 #include "trace.h"
 #include "hw/ppc/fdt.h"
 #include "target/ppc/mmu-hash64.h"
+#include "target/ppc/mmu-book3s-v3.h"
 
 static void rtas_display_character(PowerPCCPU *cpu, sPAPRMachineState *spapr,
                                    uint32_t token, uint32_t nargs,
@@ -165,6 +166,17 @@ static void rtas_start_cpu(PowerPCCPU *callcpu, sPAPRMachineState *spapr,
     if (!pcc->interrupts_big_endian(callcpu)) {
         lpcr |= LPCR_ILE;
     }
+    if (env->mmu_model == POWERPC_MMU_3_00) {
+        /*
+         * New cpus are expected to start in the same radix/hash mode
+         * as the existing CPUs
+         */
+        if (ppc64_radix_guest(callcpu)) {
+            lpcr |= LPCR_UPRT | LPCR_GTSE;
+        } else {
+            lpcr &= ~(LPCR_UPRT | LPCR_GTSE);
+        }
+    }
     ppc_store_lpcr(newcpu, lpcr);
 
     /*
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 3fd380dad6..d92a84c622 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8914,22 +8914,6 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
     lpcr->default_value &= ~LPCR_RMLS;
     lpcr->default_value |= 1ull << LPCR_RMLS_SHIFT;
 
-    if (env->mmu_model == POWERPC_MMU_3_00) {
-        /* By default we choose legacy mode and switch to new hash or radix
-         * when a register process table hcall is made. So disable process
-         * tables and guest translation shootdown by default
-         *
-         * Hot-plugged CPUs inherit from the guest radix setting under
-         * KVM but not under TCG. Update the default LPCR to keep new
-         * CPUs in sync when radix is enabled.
-         */
-        if (ppc64_radix_guest(cpu)) {
-            lpcr->default_value |= LPCR_UPRT | LPCR_GTSE;
-        } else {
-            lpcr->default_value &= ~(LPCR_UPRT | LPCR_GTSE);
-        }
-    }
-
     /* Only enable Power-saving mode Exit Cause exceptions on the boot
      * CPU. The RTAS command start-cpu will enable them on secondaries.
      */
-- 
2.17.0
