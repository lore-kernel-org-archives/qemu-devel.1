Received: from eggs.gnu.org ([2001:4830:134:3::10]:49928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1em7fp-0003Yk-8X
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 19:45:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1em7fo-0005Sp-EP
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 19:45:17 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Thu, 15 Feb 2018 11:44:43 +1100
Message-Id: <20180215004443.18013-3-sjitindarsingh@gmail.com>
In-Reply-To: <20180215004443.18013-1-sjitindarsingh@gmail.com>
References: <20180215004443.18013-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH V3 3/3] ppc/spapr-caps: For
 pseries-2.12 change spapr-cap defaults
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, aik@ozlabs.ru, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

For the pseries-2.12 machine type, make the spapr-caps SPAPR_CAP_CFPC
and SPAPR_CAP_SBBC default to workaround. Thus if the host is capable
the guest will be able to take advantage of these workarounds by default.
Otherwise if the host doesn't have these capabilities qemu will fail to
start and they will have to be explicitly disabled on the command line
with:
-machine pseries,cap-cfpc=broken,cap-sbbc=broken

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

---

V2 -> V3:
 - Set caps to workaround in the class default rather than the
   pseries-2.12 initialiser.
---
 hw/ppc/spapr.c      |  6 ++++--
 hw/ppc/spapr_caps.c | 10 ++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 969db6cde2..4fe2c3b90c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3884,8 +3884,8 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
     smc->default_caps.caps[SPAPR_CAP_VSX] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_DFP] = SPAPR_CAP_ON;
-    smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_BROKEN;
-    smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_BROKEN;
+    smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_WORKAROUND;
+    smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_WORKAROUND;
     smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_OFF;
     spapr_caps_add_properties(smc, &error_abort);
 }
@@ -3969,6 +3969,8 @@ static void spapr_machine_2_11_class_options(MachineClass *mc)
 
     spapr_machine_2_12_class_options(mc);
     smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_ON;
+    smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_BROKEN;
+    smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_BROKEN;
     SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_11);
 }
 
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 05997b0842..c25c2bca52 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -281,11 +281,21 @@ static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
 
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
-- 
2.13.6
