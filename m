Received: from eggs.gnu.org ([2001:4830:134:3::10]:51149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9jh-0007Aj-6p
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9je-0003Wu-4S
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:09 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:13:14 +1100
Message-Id: <20170202051445.5735-17-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 016/107] pseries: Make cpu_update during CAS
 unconditional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

spapr_h_cas_compose_response() includes a cpu_update parameter which
controls whether it includes updated information on the CPUs in the device
tree fragment returned from the ibm,client-architecture-support (CAS) call.

Providing the updated information is essential when CAS has negotiated
compatibility options which require different cpu information to be
presented to the guest.  However, it should be safe to provide in other
cases (it will just override the existing data in the device tree with
identical data).  This simplifies the code by removing the parameter and
always providing the cpu update information.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 hw/ppc/spapr.c         | 5 +----
 hw/ppc/spapr_hcall.c   | 8 ++------
 include/hw/ppc/spapr.h | 1 -
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index cef696c..ca78e31 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -685,7 +685,6 @@ out:
 
 int spapr_h_cas_compose_response(sPAPRMachineState *spapr,
                                  target_ulong addr, target_ulong size,
-                                 bool cpu_update,
                                  sPAPROptionVector *ov5_updates)
 {
     void *fdt, *fdt_skel;
@@ -704,9 +703,7 @@ int spapr_h_cas_compose_response(sPAPRMachineState *spapr,
     g_free(fdt_skel);
 
     /* Fixup cpu nodes */
-    if (cpu_update) {
-        _FDT((spapr_fixup_cpu_dt(fdt, spapr)));
-    }
+    _FDT((spapr_fixup_cpu_dt(fdt, spapr)));
 
     if (spapr_dt_cas_updates(spapr, fdt, ov5_updates)) {
         return -1;
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index b2a8e48..1333110 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -945,7 +945,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu_,
     target_ulong ov_table;
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu_);
     CPUState *cs;
-    bool cpu_match = false, cpu_update = true;
+    bool cpu_match = false;
     unsigned old_cpu_version = cpu_->cpu_version;
     unsigned compat_lvl = 0, cpu_version = 0;
     unsigned max_lvl = get_compat_level(cpu_->max_compat);
@@ -999,10 +999,6 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu_,
         }
     }
 
-    if (!cpu_version) {
-        cpu_update = false;
-    }
-
     /* For the future use: here @ov_table points to the first option vector */
     ov_table = list;
 
@@ -1028,7 +1024,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu_,
 
     if (!spapr->cas_reboot) {
         spapr->cas_reboot =
-            (spapr_h_cas_compose_response(spapr, args[1], args[2], cpu_update,
+            (spapr_h_cas_compose_response(spapr, args[1], args[2],
                                           ov5_updates) != 0);
     }
     spapr_ovec_cleanup(ov5_updates);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index f8d444d..04d2821 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -589,7 +589,6 @@ void spapr_events_init(sPAPRMachineState *sm);
 void spapr_dt_events(sPAPRMachineState *sm, void *fdt);
 int spapr_h_cas_compose_response(sPAPRMachineState *sm,
                                  target_ulong addr, target_ulong size,
-                                 bool cpu_update,
                                  sPAPROptionVector *ov5_updates);
 sPAPRTCETable *spapr_tce_new_table(DeviceState *owner, uint32_t liobn);
 void spapr_tce_table_enable(sPAPRTCETable *tcet,
-- 
2.9.3
