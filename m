Received: from eggs.gnu.org ([2001:4830:134:3::10]:60912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1emVqa-0000sY-O7
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 21:34:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1emVqZ-0004Am-Ro
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 21:34:00 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 16 Feb 2018 13:33:28 +1100
Message-Id: <20180216023328.8407-2-sjitindarsingh@gmail.com>
In-Reply-To: <20180216023328.8407-1-sjitindarsingh@gmail.com>
References: <20180216023328.8407-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH V4 2/2] ppc/spapr-caps: For
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
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, groug@kaod.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

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
index 83c9d66dd5..69f59aabf1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3915,8 +3915,8 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
     smc->default_caps.caps[SPAPR_CAP_VSX] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_DFP] = SPAPR_CAP_ON;
-    smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_BROKEN;
-    smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_BROKEN;
+    smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_WORKAROUND;
+    smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_WORKAROUND;
     smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_BROKEN;
     spapr_caps_add_properties(smc, &error_abort);
 }
@@ -4000,6 +4000,8 @@ static void spapr_machine_2_11_class_options(MachineClass *mc)
 
     spapr_machine_2_12_class_options(mc);
     smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_ON;
+    smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_BROKEN;
+    smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_BROKEN;
     SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_11);
 }
 
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 99a4b71d19..7b0ecb3eca 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -283,11 +283,21 @@ static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
 
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
