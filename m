Received: from eggs.gnu.org ([2001:4830:134:3::10]:56821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dE7ik-00080v-J6
	for qemu-devel@nongnu.org; Fri, 26 May 2017 01:23:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dE7ij-0007U2-EC
	for qemu-devel@nongnu.org; Fri, 26 May 2017 01:23:30 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 26 May 2017 15:23:18 +1000
Message-Id: <20170526052319.28096-5-david@gibson.dropbear.id.au>
In-Reply-To: <20170526052319.28096-1-david@gibson.dropbear.id.au>
References: <20170526052319.28096-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCHv4 4/5] pseries: Reset CPU compatibility mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org, clg@kaod.org, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com
Cc: agraf@suse.de, abologna@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, sursingh@redhat.com, sbobroff@redhat.com, David Gibson <david@gibson.dropbear.id.au>

Currently, the CPU compatibility mode is set when the cpu is initialized,
then again when the guest negotiates features.  This means if a guest
negotiates a compatibility mode, then reboots, that compatibility mode
will be retained across the reset.

Usually that will get overridden when features are negotiated on the next
boot, but it's still not really correct.  This patch moves the initial set
up of the compatibility mode from cpu init to reset time.  The mode *is*
retained if the reboot was caused by the feature negotiation (it might
be important in that case, though it's unlikely).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c          |  2 ++
 hw/ppc/spapr_cpu_core.c | 10 ----------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 3c4e88f..2821b7e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1348,6 +1348,8 @@ static void ppc_spapr_reset(void)
     if (!spapr->cas_reboot) {
         spapr_ovec_cleanup(spapr->ov5_cas);
         spapr->ov5_cas = spapr_ovec_new();
+
+        ppc_set_compat_all(spapr->max_compat_pvr, &error_abort);
     }
 
     fdt = spapr_build_fdt(spapr, rtas_addr, spapr->rtas_size);
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index ab4102b..7cc7320 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -122,16 +122,6 @@ static void spapr_cpu_init(sPAPRMachineState *spapr, PowerPCCPU *cpu,
     /* Enable PAPR mode in TCG or KVM */
     cpu_ppc_set_papr(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
 
-    if (spapr->max_compat_pvr) {
-        Error *local_err = NULL;
-
-        ppc_set_compat(cpu, spapr->max_compat_pvr, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return;
-        }
-    }
-
     qemu_register_reset(spapr_cpu_reset, cpu);
     spapr_cpu_reset(cpu);
 }
-- 
2.9.4
