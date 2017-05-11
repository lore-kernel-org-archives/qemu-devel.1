Received: from eggs.gnu.org ([2001:4830:134:3::10]:56272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8fUz-0005Ot-W2
	for qemu-devel@nongnu.org; Thu, 11 May 2017 00:14:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8fUx-0001Vl-26
	for qemu-devel@nongnu.org; Thu, 11 May 2017 00:14:45 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 11 May 2017 14:14:21 +1000
Message-Id: <20170511041426.6488-19-david@gibson.dropbear.id.au>
In-Reply-To: <20170511041426.6488-1-david@gibson.dropbear.id.au>
References: <20170511041426.6488-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 18/23] target/ppc: Enable RADIX mmu mode for
 pseries TCG guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, agraf@suse.de, aik@ozlabs.ru, sjitindarsingh@gmail.com, mark.cave-ayland@ilande.co.uk, sam.bobroff@au1.ibm.com, nikunj@linux.vnet.ibm.com, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Now that we have added all the infrastructure we can enable a pseries TCG
guest to use radix.

In order to do this we have to add the appropriate bits to the
ibm,arch-vec-5-platform-support vector to represent that we support both
hash and radix mmu models.

A radix guest can now be booted in pseries tcg mode by specifying:
-cpu POWER9

Note that we assume hash, that is we allocate a hpt, until a guest tells
us otherwise via a H_REGISTER_PROCESS_TABLE call with radix specified - in
which case we free the hpt. If we were right and the guest is hash then
there's nothing for us to do.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 80d12d0..e2dc77c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -855,6 +855,8 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr, void *fdt)
  * option vector 5: */
 static void spapr_dt_ov5_platform_support(void *fdt, int chosen)
 {
+    PowerPCCPU *first_ppc_cpu = POWERPC_CPU(first_cpu);
+
     char val[2 * 3] = {
         24, 0x00, /* Hash/Radix, filled in below. */
         25, 0x00, /* Hash options: Segment Tables == no, GTSE == no. */
@@ -870,8 +872,13 @@ static void spapr_dt_ov5_platform_support(void *fdt, int chosen)
             val[1] = 0x00; /* Hash */
         }
     } else {
-        /* TODO: TCG case, hash */
-        val[1] = 0x00;
+        if (first_ppc_cpu->env.mmu_model & POWERPC_MMU_V3) {
+            /* V3 MMU supports both hash and radix (with dynamic switching) */
+            val[1] = 0xC0;
+        } else {
+            /* Otherwise we can only do hash */
+            val[1] = 0x00;
+        }
     }
     _FDT(fdt_setprop(fdt, chosen, "ibm,arch-vec-5-platform-support",
                      val, sizeof(val)));
@@ -2101,8 +2108,8 @@ static void ppc_spapr_init(MachineState *machine)
     }
 
     spapr_ovec_set(spapr->ov5, OV5_FORM1_AFFINITY);
-    if (kvmppc_has_cap_mmu_radix()) {
-        /* KVM always allows GTSE with radix... */
+    if (!kvm_enabled() || kvmppc_has_cap_mmu_radix()) {
+        /* KVM and TCG always allow GTSE with radix... */
         spapr_ovec_set(spapr->ov5, OV5_MMU_RADIX_GTSE);
     }
     /* ... but not with hash (currently). */
-- 
2.9.3
