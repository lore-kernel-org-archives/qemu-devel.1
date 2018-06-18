Received: from eggs.gnu.org ([2001:4830:134:3::10]:41197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUnlz-0008Lw-BP
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 02:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUnly-0001O8-A8
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 02:36:19 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 18 Jun 2018 16:35:59 +1000
Message-Id: <20180618063606.2513-3-david@gibson.dropbear.id.au>
In-Reply-To: <20180618063606.2513-1-david@gibson.dropbear.id.au>
References: <20180618063606.2513-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 2/9] spapr: Compute effective capability values
 earlier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org, abologna@redhat.com
Cc: clg@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

Previously, the effective values of the various spapr capability flags
were only determined at machine reset time.  That was a lazy way of making
sure it was after cpu initialization so it could use the cpu object to
inform the defaults.

But we've now improved the compat checking code so that we don't need to
instantiate the cpus to use it.  That lets us move the resolution of the
capability defaults much earlier.

This is going to be necessary for some future capabilities.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c         | 6 ++++--
 hw/ppc/spapr_caps.c    | 9 ++++++---
 include/hw/ppc/spapr.h | 3 ++-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b0b94fc1f0..40858d047c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1612,7 +1612,7 @@ static void spapr_machine_reset(void)
     void *fdt;
     int rc;
 
-    spapr_caps_reset(spapr);
+    spapr_caps_apply(spapr);
 
     first_ppc_cpu = POWERPC_CPU(first_cpu);
     if (kvm_enabled() && kvmppc_has_cap_mmu_radix() &&
@@ -2526,7 +2526,9 @@ static void spapr_machine_init(MachineState *machine)
     QLIST_INIT(&spapr->phbs);
     QTAILQ_INIT(&spapr->pending_dimm_unplugs);
 
-    /* Check HPT resizing availability */
+    /* Determine capabilities to run with */
+    spapr_caps_init(spapr);
+
     kvmppc_check_papr_resize_hpt(&resize_hpt_err);
     if (spapr->resize_hpt == SPAPR_RESIZE_HPT_DEFAULT) {
         /*
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 469f38f0ef..dabed817d1 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -439,12 +439,12 @@ SPAPR_CAP_MIG_STATE(cfpc, SPAPR_CAP_CFPC);
 SPAPR_CAP_MIG_STATE(sbbc, SPAPR_CAP_SBBC);
 SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
 
-void spapr_caps_reset(sPAPRMachineState *spapr)
+void spapr_caps_init(sPAPRMachineState *spapr)
 {
     sPAPRCapabilities default_caps;
     int i;
 
-    /* First compute the actual set of caps we're running with.. */
+    /* Compute the actual set of caps we should run with */
     default_caps = default_caps_with_cpu(spapr, MACHINE(spapr)->cpu_type);
 
     for (i = 0; i < SPAPR_CAP_NUM; i++) {
@@ -455,8 +455,11 @@ void spapr_caps_reset(sPAPRMachineState *spapr)
             spapr->eff.caps[i] = default_caps.caps[i];
         }
     }
+}
 
-    /* .. then apply those caps to the virtual hardware */
+void spapr_caps_apply(sPAPRMachineState *spapr)
+{
+    int i;
 
     for (i = 0; i < SPAPR_CAP_NUM; i++) {
         sPAPRCapabilityInfo *info = &capability_table[i];
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 3388750fc7..9dbd6010f5 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -798,7 +798,8 @@ static inline uint8_t spapr_get_cap(sPAPRMachineState *spapr, int cap)
     return spapr->eff.caps[cap];
 }
 
-void spapr_caps_reset(sPAPRMachineState *spapr);
+void spapr_caps_init(sPAPRMachineState *spapr);
+void spapr_caps_apply(sPAPRMachineState *spapr);
 void spapr_caps_add_properties(sPAPRMachineClass *smc, Error **errp);
 int spapr_caps_post_migration(sPAPRMachineState *spapr);
 
-- 
2.17.1
