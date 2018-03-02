Received: from eggs.gnu.org ([2001:4830:134:3::10]:38664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1erdne-0000lq-3m
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:04:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1erdnb-00048T-VV
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:04:10 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  2 Mar 2018 17:03:49 +1100
Message-Id: <20180302060350.24330-24-david@gibson.dropbear.id.au>
In-Reply-To: <20180302060350.24330-1-david@gibson.dropbear.id.au>
References: <20180302060350.24330-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 23/24] ppc/spapr-caps: Define the
 pseries-2.12-sxxm machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, groug@kaod.org, surajjs@au1.ibm.com, mark.cave-ayland@ilande.co.uk, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The sxxm (speculative execution exploit mitigation) machine type is a
variant of the 2.12 machine type with workarounds for speculative
execution vulnerabilities enabled by default.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c      | 17 +++++++++++++++++
 hw/ppc/spapr_caps.c | 11 +++++++++++
 2 files changed, 28 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1c2703cb6b..1b6ddd827e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3983,6 +3983,23 @@ static void spapr_machine_2_12_class_options(MachineClass *mc)
 
 DEFINE_SPAPR_MACHINE(2_12, "2.12", true);
 
+static void spapr_machine_2_12_sxxm_instance_options(MachineState *machine)
+{
+    spapr_machine_2_12_instance_options(machine);
+}
+
+static void spapr_machine_2_12_sxxm_class_options(MachineClass *mc)
+{
+    sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
+
+    spapr_machine_2_12_class_options(mc);
+    smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_WORKAROUND;
+    smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_WORKAROUND;
+    smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_FIXED_CCD;
+}
+
+DEFINE_SPAPR_MACHINE(2_12_sxxm, "2.12-sxxm", false);
+
 /*
  * pseries-2.11
  */
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index c09febcf12..9e729251df 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -320,15 +320,26 @@ static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
 
     caps = smc->default_caps;
 
+    if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00,
+                          0, spapr->max_compat_pvr)) {
+        caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_BROKEN;
+    }
+
     if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_07,
                           0, spapr->max_compat_pvr)) {
         caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
     }
 
+    if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_06_PLUS,
+                          0, spapr->max_compat_pvr)) {
+        caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_BROKEN;
+    }
+
     if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_06,
                           0, spapr->max_compat_pvr)) {
         caps.caps[SPAPR_CAP_VSX] = SPAPR_CAP_OFF;
         caps.caps[SPAPR_CAP_DFP] = SPAPR_CAP_OFF;
+        caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_BROKEN;
     }
 
     return caps;
-- 
2.14.3
