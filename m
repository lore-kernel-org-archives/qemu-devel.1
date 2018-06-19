Received: from eggs.gnu.org ([2001:4830:134:3::10]:45108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hG-0000ni-UM
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:44:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hF-0007zO-SS
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:44:38 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:41:42 -0500
Message-Id: <20180619014319.28272-17-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 016/113] spapr: make pseries-2.11 the default
 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>

From: Greg Kurz <groug@kaod.org>

The spapr capability framework was introduced in QEMU 2.12. It allows
to have an explicit control on how host features are exposed to the
guest. This is especially needed to handle migration between hetero-
geneous hosts (eg, POWER8 to POWER9). It is also used to expose fixes/
workarounds against speculative execution vulnerabilities to guests.
The framework was hence backported to QEMU 2.11.1, especially these
commits:

0fac4aa93074 spapr: Add pseries-2.12 machine type
9070f408f491 spapr: Treat Hardware Transactional Memory (HTM) as an
 optional capability

0fac4aa93074 has the confusing effect of making pseries-2.12 the default
machine type for QEMU 2.11.1, instead of the expected pseries-2.11. This
patch changes the default machine back to pseries-2.11.

Unfortunately, 9070f408f491 enforces the HTM capability for pseries-2.11.
This isn't supported by TCG and breaks 'make check'. So this patch also
adds a hack to turn HTM off when using TCG.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c      | 4 ++--
 hw/ppc/spapr_caps.c | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1a2dd1f597..6499a86752 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3820,7 +3820,7 @@ static void spapr_machine_2_12_class_options(MachineClass *mc)
     /* Defaults for the latest behaviour inherited from the base class */
 }
 
-DEFINE_SPAPR_MACHINE(2_12, "2.12", true);
+DEFINE_SPAPR_MACHINE(2_12, "2.12", false);
 
 /*
  * pseries-2.11
@@ -3842,7 +3842,7 @@ static void spapr_machine_2_11_class_options(MachineClass *mc)
     SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_11);
 }
 
-DEFINE_SPAPR_MACHINE(2_11, "2.11", false);
+DEFINE_SPAPR_MACHINE(2_11, "2.11", true);
 
 /*
  * pseries-2.10
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 7b229517be..82043e60e7 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -285,6 +285,11 @@ static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
 
     caps = smc->default_caps;
 
+    /* HACK for 2.11.2: fix make check */
+    if (tcg_enabled()) {
+        caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
+    }
+
     if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_07,
                           0, spapr->max_compat_pvr)) {
         caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
-- 
2.11.0
