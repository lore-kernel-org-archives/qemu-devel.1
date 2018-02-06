Received: from eggs.gnu.org ([2001:4830:134:3::10]:44435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8j0-0005cD-4b
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8iu-00089i-0t
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8it-00088q-LL
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:07 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JEOlk053344
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:16:06 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fyg4xphd5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:16:06 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:16:04 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:15:03 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180206191515.25830-43-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 42/54] spapr: Handle VMX/VSX presence as an
 spapr capability flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, David Gibson <david@gibson.dropbear.id.au>

From: David Gibson <david@gibson.dropbear.id.au>

We currently have some conditionals in the spapr device tree code to decide
whether or not to advertise the availability of the VMX (aka Altivec) and
VSX vector extensions to the guest, based on whether the guest cpu has
those features.

This can lead to confusion and subtle failures on migration, since it makes
a guest visible change based only on host capabilities.  We now have a
better mechanism for this, in spapr capabilities flags, which explicitly
depend on user options rather than host capabilities.

Rework the advertisement of VSX and VMX based on a new VSX capability.  We
no longer bother with a conditional for VMX support, because every CPU
that's ever been supported by the pseries machine type supports VMX.

NOTE: Some userspace distributions (e.g. RHEL7.4) already rely on
availability of VSX in libc, so using cap-vsx=off may lead to a fatal
SIGILL in init.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
(cherry picked from commit 2938664286499c0c30d6e455a7e2e5d3e6c3f63d)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c         | 20 +++++++++++---------
 hw/ppc/spapr_caps.c    | 25 +++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  3 +++
 3 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 69ddc4bb23..f006662c5c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -557,14 +557,16 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
                           segs, sizeof(segs))));
     }
 
-    /* Advertise VMX/VSX (vector extensions) if available
-     *   0 / no property == no vector extensions
+    /* Advertise VSX (vector extensions) if available
      *   1               == VMX / Altivec available
-     *   2               == VSX available */
-    if (env->insns_flags & PPC_ALTIVEC) {
-        uint32_t vmx = (env->insns_flags2 & PPC2_VSX) ? 2 : 1;
-
-        _FDT((fdt_setprop_cell(fdt, offset, "ibm,vmx", vmx)));
+     *   2               == VSX available
+     *
+     * Only CPUs for which we create core types in spapr_cpu_core.c
+     * are possible, and all of those have VMX */
+    if (spapr_has_cap(spapr, SPAPR_CAP_VSX)) {
+        _FDT((fdt_setprop_cell(fdt, offset, "ibm,vmx", 2)));
+    } else {
+        _FDT((fdt_setprop_cell(fdt, offset, "ibm,vmx", 1)));
     }
 
     /* Advertise DFP (Decimal Floating Point) if available
@@ -3678,7 +3680,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
      */
     mc->numa_mem_align_shift = 28;
 
-    smc->default_caps = spapr_caps(0);
+    smc->default_caps = spapr_caps(SPAPR_CAP_VSX);
     spapr_caps_add_properties(smc, &error_abort);
 }
 
@@ -3760,7 +3762,7 @@ static void spapr_machine_2_11_class_options(MachineClass *mc)
     sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
 
     spapr_machine_2_12_class_options(mc);
-    smc->default_caps = spapr_caps(SPAPR_CAP_HTM);
+    smc->default_caps = spapr_caps(SPAPR_CAP_HTM | SPAPR_CAP_VSX);
     SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_11);
 }
 
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index cad40fe49a..7c855c67ad 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -57,6 +57,19 @@ static void cap_htm_allow(sPAPRMachineState *spapr, Error **errp)
     }
 }
 
+static void cap_vsx_allow(sPAPRMachineState *spapr, Error **errp)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
+    CPUPPCState *env = &cpu->env;
+
+    /* Allowable CPUs in spapr_cpu_core.c should already have gotten
+     * rid of anything that doesn't do VMX */
+    g_assert(env->insns_flags & PPC_ALTIVEC);
+    if (!(env->insns_flags2 & PPC2_VSX)) {
+        error_setg(errp, "VSX support not available, try cap-vsx=off");
+    }
+}
+
 static sPAPRCapabilityInfo capability_table[] = {
     {
         .name = "htm",
@@ -65,6 +78,13 @@ static sPAPRCapabilityInfo capability_table[] = {
         .allow = cap_htm_allow,
         /* TODO: add cap_htm_disallow */
     },
+    {
+        .name = "vsx",
+        .description = "Allow Vector Scalar Extensions (VSX)",
+        .flag = SPAPR_CAP_VSX,
+        .allow = cap_vsx_allow,
+        /* TODO: add cap_vsx_disallow */
+    },
 };
 
 static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
@@ -81,6 +101,11 @@ static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
         caps.mask &= ~SPAPR_CAP_HTM;
     }
 
+    if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_06,
+                          0, spapr->max_compat_pvr)) {
+        caps.mask &= ~SPAPR_CAP_VSX;
+    }
+
     return caps;
 }
 
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 985948b622..7765f3439d 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -59,6 +59,9 @@ typedef enum {
 /* Hardware Transactional Memory */
 #define SPAPR_CAP_HTM               0x0000000000000001ULL
 
+/* Vector Scalar Extensions */
+#define SPAPR_CAP_VSX               0x0000000000000002ULL
+
 typedef struct sPAPRCapabilities sPAPRCapabilities;
 struct sPAPRCapabilities {
     uint64_t mask;
-- 
2.11.0
