Received: from eggs.gnu.org ([2001:4830:134:3::10]:57933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f8Krt-0003Ra-Cd
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 03:17:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f8Krq-0008SM-6y
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 03:17:33 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 17 Apr 2018 17:17:15 +1000
Message-Id: <20180417071722.9399-4-david@gibson.dropbear.id.au>
In-Reply-To: <20180417071722.9399-1-david@gibson.dropbear.id.au>
References: <20180417071722.9399-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH for-2.13 03/10] target/ppc: Remove unnecessary
 initialization of LPCR_UPRT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org
Cc: benh@kernel.crashing.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

In cpu_ppc_set_papr() the UPRT and GTSE bits of the LPCR are initialized
based on on ppc64_radix_guest().  Which seems reasonable, except that
ppc64_radix_guest() is based on spapr->patb_entry which is only set up
in spapr_machine_reset, called much later than cpu_ppc_set_papr().

So the initialization here is pointless.  The base cpu initialization
already sets a value that's good enough until the guest uses an hcall to
configure it's preferred MMU mode.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate_init.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index bb79d23b50..14f346f441 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8897,22 +8897,6 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
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
2.14.3
