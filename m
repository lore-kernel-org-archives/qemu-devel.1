Received: from eggs.gnu.org ([209.51.188.92]:48106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1gyqrj-0000fg-1k
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 23:30:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1gyqrh-0008Tn-50
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 23:30:42 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Wed, 27 Feb 2019 15:30:08 +1100
Message-Id: <20190227043008.12059-4-sjitindarsingh@gmail.com>
In-Reply-To: <20190227043008.12059-1-sjitindarsingh@gmail.com>
References: <20190227043008.12059-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH v2 4/4] target/ppc/spapr: Enable the
 large decrementer for pseries-4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au, clg@kaod.org, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Enable the large decrementer by default for the pseries-4.0 machine type.
It is disabled again by default_caps_with_cpu() for pre-POWER9 cpus
since they don't support the large decrementer.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr.c      | 3 ++-
 hw/ppc/spapr_caps.c | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ff5ba59cc0..bbfaca3b05 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4297,7 +4297,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_BROKEN;
     smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] = 16; /* 64kiB */
     smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
-    smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = 0;
+    smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = 1;
     spapr_caps_add_properties(smc, &error_abort);
     smc->irq = &spapr_irq_xics;
     smc->dr_phb_enabled = true;
@@ -4373,6 +4373,7 @@ static void spapr_machine_3_1_class_options(MachineClass *mc)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power8_v2.0");
     smc->update_dt_enabled = false;
     smc->dr_phb_enabled = false;
+    smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = 0;
 }
 
 DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 1e76685199..fbd5d35cd0 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -536,6 +536,11 @@ static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
 
     caps = smc->default_caps;
 
+    if (!ppc_type_check_compat(cputype, CPU_POWERPC_LOGICAL_3_00,
+                               0, spapr->max_compat_pvr)) {
+        caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = 0;
+    }
+
     if (!ppc_type_check_compat(cputype, CPU_POWERPC_LOGICAL_2_07,
                                0, spapr->max_compat_pvr)) {
         caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
-- 
2.13.6
