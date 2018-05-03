Received: from eggs.gnu.org ([2001:4830:134:3::10]:40960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE7cs-00074w-2T
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE7cq-0002Oe-7C
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:21:58 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  3 May 2018 16:21:42 +1000
Message-Id: <20180503062145.17899-6-david@gibson.dropbear.id.au>
In-Reply-To: <20180503062145.17899-1-david@gibson.dropbear.id.au>
References: <20180503062145.17899-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 5/8] spapr: Clean up LPCR updates from
 hypercalls
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

There are several places in spapr_hcall.c where we need to update the LPCR
value on all CPUs.  We do this with the set_spr() helper.  That's not
really correct because this directly sets the SPR value, without going
through the ppc_store_lpcr() helper which may need to update state based
on the LPCR change.

In fact, set_spr() is only ever used for the LPCR, so replace it with an
explicit LPCR updated which uses the right low-level helper.  While we're
there, move the CPU_FOREACH() which was in every one of the callers into
the new helper: set_all_lpcrs().

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_hcall.c | 50 ++++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 30 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 16bccdd5c0..ca9702e667 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -15,32 +15,35 @@
 #include "hw/ppc/spapr_ovec.h"
 #include "mmu-book3s-v3.h"
 
-struct SPRSyncState {
-    int spr;
+struct LPCRSyncState {
     target_ulong value;
     target_ulong mask;
 };
 
-static void do_spr_sync(CPUState *cs, run_on_cpu_data arg)
+static void do_lpcr_sync(CPUState *cs, run_on_cpu_data arg)
 {
-    struct SPRSyncState *s = arg.host_ptr;
+    struct LPCRSyncState *s = arg.host_ptr;
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
+    target_ulong lpcr;
 
     cpu_synchronize_state(cs);
-    env->spr[s->spr] &= ~s->mask;
-    env->spr[s->spr] |= s->value;
+    lpcr = env->spr[SPR_LPCR];
+    lpcr &= ~s->mask;
+    lpcr |= s->value;
+    ppc_store_lpcr(cpu, lpcr);
 }
 
-static void set_spr(CPUState *cs, int spr, target_ulong value,
-                    target_ulong mask)
+static void set_all_lpcrs(target_ulong value, target_ulong mask)
 {
-    struct SPRSyncState s = {
-        .spr = spr,
+    CPUState *cs;
+    struct LPCRSyncState s = {
         .value = value,
         .mask = mask
     };
-    run_on_cpu(cs, do_spr_sync, RUN_ON_CPU_HOST_PTR(&s));
+    CPU_FOREACH(cs) {
+        run_on_cpu(cs, do_lpcr_sync, RUN_ON_CPU_HOST_PTR(&s));
+    }
 }
 
 static bool has_spr(PowerPCCPU *cpu, int spr)
@@ -1235,8 +1238,6 @@ static target_ulong h_set_mode_resource_le(PowerPCCPU *cpu,
                                            target_ulong value1,
                                            target_ulong value2)
 {
-    CPUState *cs;
-
     if (value1) {
         return H_P3;
     }
@@ -1246,16 +1247,12 @@ static target_ulong h_set_mode_resource_le(PowerPCCPU *cpu,
 
     switch (mflags) {
     case H_SET_MODE_ENDIAN_BIG:
-        CPU_FOREACH(cs) {
-            set_spr(cs, SPR_LPCR, 0, LPCR_ILE);
-        }
+        set_all_lpcrs(0, LPCR_ILE);
         spapr_pci_switch_vga(true);
         return H_SUCCESS;
 
     case H_SET_MODE_ENDIAN_LITTLE:
-        CPU_FOREACH(cs) {
-            set_spr(cs, SPR_LPCR, LPCR_ILE, LPCR_ILE);
-        }
+        set_all_lpcrs(LPCR_ILE, LPCR_ILE);
         spapr_pci_switch_vga(false);
         return H_SUCCESS;
     }
@@ -1268,7 +1265,6 @@ static target_ulong h_set_mode_resource_addr_trans_mode(PowerPCCPU *cpu,
                                                         target_ulong value1,
                                                         target_ulong value2)
 {
-    CPUState *cs;
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
 
     if (!(pcc->insns_flags2 & PPC2_ISA207S)) {
@@ -1285,9 +1281,7 @@ static target_ulong h_set_mode_resource_addr_trans_mode(PowerPCCPU *cpu,
         return H_UNSUPPORTED_FLAG;
     }
 
-    CPU_FOREACH(cs) {
-        set_spr(cs, SPR_LPCR, mflags << LPCR_AIL_SHIFT, LPCR_AIL);
-    }
+    set_all_lpcrs(mflags << LPCR_AIL_SHIFT, LPCR_AIL);
 
     return H_SUCCESS;
 }
@@ -1364,7 +1358,6 @@ static target_ulong h_register_process_table(PowerPCCPU *cpu,
                                              target_ulong opcode,
                                              target_ulong *args)
 {
-    CPUState *cs;
     target_ulong flags = args[0];
     target_ulong proc_tbl = args[1];
     target_ulong page_size = args[2];
@@ -1422,12 +1415,9 @@ static target_ulong h_register_process_table(PowerPCCPU *cpu,
     spapr->patb_entry = cproc; /* Save new process table */
 
     /* Update the UPRT and GTSE bits in the LPCR for all cpus */
-    CPU_FOREACH(cs) {
-        set_spr(cs, SPR_LPCR,
-                ((flags & (FLAG_RADIX | FLAG_HASH_PROC_TBL)) ? LPCR_UPRT : 0) |
-                ((flags & FLAG_GTSE) ? LPCR_GTSE : 0),
-                LPCR_UPRT | LPCR_GTSE);
-    }
+    set_all_lpcrs(((flags & (FLAG_RADIX | FLAG_HASH_PROC_TBL)) ? LPCR_UPRT : 0) |
+                  ((flags & FLAG_GTSE) ? LPCR_GTSE : 0),
+                  LPCR_UPRT | LPCR_GTSE);
 
     if (kvm_enabled()) {
         return kvmppc_configure_v3_mmu(cpu, flags & FLAG_RADIX,
-- 
2.17.0
