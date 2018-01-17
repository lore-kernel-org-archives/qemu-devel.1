Received: from eggs.gnu.org ([2001:4830:134:3::10]:38845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ebjtm-0000qM-7R
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 04:20:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ebjti-0006ra-Up
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 04:20:46 -0500
Received: from 6.mo179.mail-out.ovh.net ([46.105.56.76]:57945)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ebjti-0006pS-OO
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 04:20:42 -0500
Received: from player716.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id B888E913C1
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 10:20:37 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 17 Jan 2018 10:20:35 +0100
Message-ID: <151618083506.20461.14178623580944316317.stgit@bahia.lan>
In-Reply-To: <151618081462.20461.3393245354775542888.stgit@bahia.lan>
References: <151618081462.20461.3393245354775542888.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 2/3] spapr_cpu_core: don't reset CPUs during
 realization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

When QEMU is started, all cold-plugged CPUs are reset twice: first
during initialization and then during machine reset. This is sub-
optimal.

The first reset is only needed for hot-plugged CPUs because the CPU
hotplug code doesn't reset them. This patch adds the necessary code
to reset hot-plugged CPUs on the CPU core hotplug path, and removes
the now useless initial CPU reset.

We just need to mark the newly created CPU as halted to prevent it
to run until it is put online later.

Full CPU reset is now explicitely triggered from the machine code
only, either during system reset or during CPU hotplug.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c                  |    8 ++++++++
 hw/ppc/spapr_cpu_core.c         |    8 ++++++--
 include/hw/ppc/spapr_cpu_core.h |    2 ++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index bca838fce638..a2ff401f738a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3336,6 +3336,14 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         void *fdt;
         int fdt_offset;
 
+        if (hotplugged) {
+            int i;
+
+            for (i = 0; i < cc->nr_threads; i++) {
+                spapr_cpu_reset(core->threads[i]);
+            }
+        }
+
         fdt = spapr_populate_hotplug_cpu_dt(cs, &fdt_offset, spapr);
 
         spapr_drc_attach(drc, dev, fdt, fdt_offset, &local_err);
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index ac19b2e0b72c..268be7784efb 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -22,7 +22,7 @@
 #include "sysemu/hw_accel.h"
 #include "qemu/error-report.h"
 
-static void spapr_cpu_reset(void *opaque)
+void spapr_cpu_reset(void *opaque)
 {
     PowerPCCPU *cpu = opaque;
     CPUState *cs = CPU(cpu);
@@ -63,7 +63,11 @@ static void spapr_cpu_init(sPAPRMachineState *spapr, PowerPCCPU *cpu,
     cpu_ppc_set_papr(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
 
     qemu_register_reset(spapr_cpu_reset, cpu);
-    spapr_cpu_reset(cpu);
+
+    /* CPU must not execute anything until explicitely started otherwise the
+     * guest will crash.
+     */
+    CPU(cpu)->halted = 1;
 }
 
 /*
diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
index 1129f344aa0c..763a2168461e 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -38,4 +38,6 @@ typedef struct sPAPRCPUCoreClass {
 } sPAPRCPUCoreClass;
 
 const char *spapr_get_cpu_core_type(const char *cpu_type);
+void spapr_cpu_reset(void *opaque);
+
 #endif
