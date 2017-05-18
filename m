Received: from eggs.gnu.org ([2001:4830:134:3::10]:44646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dBEFk-00084a-03
	for qemu-devel@nongnu.org; Thu, 18 May 2017 01:45:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dBEFi-0003SC-Mp
	for qemu-devel@nongnu.org; Thu, 18 May 2017 01:45:35 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 18 May 2017 15:45:20 +1000
Message-Id: <20170518054522.13141-2-david@gibson.dropbear.id.au>
In-Reply-To: <20170518054522.13141-1-david@gibson.dropbear.id.au>
References: <20170518054522.13141-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 1/3] pseries: Split CAS PVR negotiation out
 into a separate function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: abologna@redhat.com, thuth@redhat.com, lvivier@redhat.com
Cc: mdroth@linux.vnet.ibm.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Guests of the qemu machine type go through a feature negotiation process
known as "client architecture support" (CAS) during early boot.  This does
a number of things, one of which is finding a CPU compatibility mode which
can be supported by both guest and host.

In fact the CPU negotiation is probably the single most complex part of the
CAS process, so this splits it out into a helper function.  We've recently
made some mistakes in maintaining backward compatibility for old machine
types here.  Splitting this out will also make it easier to fix this.

This also adds a possibly useful error message if the negotiation fails
(i.e. if there isn't a CPU mode that's suitable for both guest and host).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_hcall.c | 49 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 2daace4..77d2d66 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1044,19 +1044,13 @@ static target_ulong h_signal_sys_reset(PowerPCCPU *cpu,
     }
 }
 
-static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
-                                                  sPAPRMachineState *spapr,
-                                                  target_ulong opcode,
-                                                  target_ulong *args)
+static uint32_t cas_check_pvr(PowerPCCPU *cpu, target_ulong *addr,
+                              Error **errp)
 {
-    target_ulong list = ppc64_phys_to_real(args[0]);
-    target_ulong ov_table;
     bool explicit_match = false; /* Matched the CPU's real PVR */
     uint32_t max_compat = cpu->max_compat;
     uint32_t best_compat = 0;
     int i;
-    sPAPROptionVector *ov1_guest, *ov5_guest, *ov5_cas_old, *ov5_updates;
-    bool guest_radix;
 
     /*
      * We scan the supplied table of PVRs looking for two things
@@ -1066,9 +1060,9 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     for (i = 0; i < 512; ++i) {
         uint32_t pvr, pvr_mask;
 
-        pvr_mask = ldl_be_phys(&address_space_memory, list);
-        pvr = ldl_be_phys(&address_space_memory, list + 4);
-        list += 8;
+        pvr_mask = ldl_be_phys(&address_space_memory, *addr);
+        pvr = ldl_be_phys(&address_space_memory, *addr + 4);
+        *addr += 8;
 
         if (~pvr_mask & pvr) {
             break; /* Terminator record */
@@ -1087,17 +1081,38 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
         /* We couldn't find a suitable compatibility mode, and either
          * the guest doesn't support "raw" mode for this CPU, or raw
          * mode is disabled because a maximum compat mode is set */
-        return H_HARDWARE;
+        error_setg(errp, "Couldn't negotiate a suitable PVR during CAS");
+        return 0;
     }
 
     /* Parsing finished */
     trace_spapr_cas_pvr(cpu->compat_pvr, explicit_match, best_compat);
 
-    /* Update CPUs */
-    if (cpu->compat_pvr != best_compat) {
-        Error *local_err = NULL;
+    return best_compat;
+}
 
-        ppc_set_compat_all(best_compat, &local_err);
+static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
+                                                  sPAPRMachineState *spapr,
+                                                  target_ulong opcode,
+                                                  target_ulong *args)
+{
+    /* Working address in data buffer */
+    target_ulong addr = ppc64_phys_to_real(args[0]);
+    target_ulong ov_table;
+    uint32_t cas_pvr;
+    sPAPROptionVector *ov1_guest, *ov5_guest, *ov5_cas_old, *ov5_updates;
+    bool guest_radix;
+    Error *local_err = NULL;
+
+    cas_pvr = cas_check_pvr(cpu, &addr, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        return H_HARDWARE;
+    }
+
+    /* Update CPUs */
+    if (cpu->compat_pvr != cas_pvr) {
+        ppc_set_compat_all(cas_pvr, &local_err);
         if (local_err) {
             error_report_err(local_err);
             return H_HARDWARE;
@@ -1105,7 +1120,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     }
 
     /* For the future use: here @ov_table points to the first option vector */
-    ov_table = list;
+    ov_table = addr;
 
     ov1_guest = spapr_ovec_parse_vector(ov_table, 1);
     ov5_guest = spapr_ovec_parse_vector(ov_table, 5);
-- 
2.9.4
