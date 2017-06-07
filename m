Received: from eggs.gnu.org ([2001:4830:134:3::10]:47684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIV4A-0001cE-Db
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:07:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIV47-0007Oe-8m
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:07:42 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  7 Jun 2017 17:07:32 +1000
Message-Id: <20170607070732.23312-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH] pseries: Correct panic behaviour for pseries
 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com, thuth@redhat.com, lvivier@redhat.com
Cc: pbonzini@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The pseries machine type doesn't usually use the 'pvpanic' device as such,
because it has a firmware/hypervisor facility with roughly the same
purpose.  The 'ibm,os-term' RTAS call notifies the hypervisor that the
guest has crashed.

Our implementation of this call was sending a GUEST_PANICKED qmp event;
however, it was not doing the other usual panic actions, making its
behaviour different from pvpanic for no good reason.

To correct this, we should call qemu_system_guest_panicked() rather than
directly sending the panic event.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_rtas.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 707c4d4..94a2799 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -293,12 +293,9 @@ static void rtas_ibm_os_term(PowerPCCPU *cpu,
                             target_ulong args,
                             uint32_t nret, target_ulong rets)
 {
-    target_ulong ret = 0;
+    qemu_system_guest_panicked(NULL);
 
-    qapi_event_send_guest_panicked(GUEST_PANIC_ACTION_PAUSE, false, NULL,
-                                   &error_abort);
-
-    rtas_st(rets, 0, ret);
+    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
 }
 
 static void rtas_set_power_level(PowerPCCPU *cpu, sPAPRMachineState *spapr,
-- 
2.9.4
