Received: from eggs.gnu.org ([2001:4830:134:3::10]:36826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eloRb-0001aN-I3
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 23:13:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eloRa-0007Sp-Ex
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 23:13:19 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Wed, 14 Feb 2018 15:12:56 +1100
Message-Id: <20180214041256.25473-3-sjitindarsingh@gmail.com>
In-Reply-To: <20180214041256.25473-1-sjitindarsingh@gmail.com>
References: <20180214041256.25473-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC PATCH 3/3] ppc/spapr-caps: For pseries-2.12
 change spapr-cap defaults
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
and SPAPR_CAP_SBBC default to workaround. This means the guest will
be able to take advantage of these workarounds by default, so long
as the host is capable.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr.c      | 11 ++++++++++-
 hw/ppc/spapr_caps.c | 10 ++++++++++
 include/hw/compat.h |  2 ++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 32a876be56..cd4a024660 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3941,13 +3941,20 @@ static const TypeInfo spapr_machine_info = {
 /*
  * pseries-2.12
  */
+#define SPAPR_COMPAT_2_12                                              \
+    HW_COMPAT_2_12
+
 static void spapr_machine_2_12_instance_options(MachineState *machine)
 {
 }
 
 static void spapr_machine_2_12_class_options(MachineClass *mc)
 {
-    /* Defaults for the latest behaviour inherited from the base class */
+    sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
+
+    smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_WORKAROUND;
+    smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_WORKAROUND;
+    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_12);
 }
 
 DEFINE_SPAPR_MACHINE(2_12, "2.12", true);
@@ -3969,6 +3976,8 @@ static void spapr_machine_2_11_class_options(MachineClass *mc)
 
     spapr_machine_2_12_class_options(mc);
     smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_ON;
+    smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_BROKEN;
+    smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_BROKEN;
     SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_11);
 }
 
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 1cd73b617f..3dda1db812 100644
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
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 7f31850dfa..13238239da 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -1,6 +1,8 @@
 #ifndef HW_COMPAT_H
 #define HW_COMPAT_H
 
+#define HW_COMPAT_2_12
+
 #define HW_COMPAT_2_11 \
     {\
         .driver   = "hpet",\
-- 
2.13.6
