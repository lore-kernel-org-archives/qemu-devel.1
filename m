Received: from eggs.gnu.org ([2001:4830:134:3::10]:57914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f8Krr-0003QE-S7
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 03:17:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f8Krq-0008SY-7Z
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 03:17:31 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 17 Apr 2018 17:17:13 +1000
Message-Id: <20180417071722.9399-2-david@gibson.dropbear.id.au>
In-Reply-To: <20180417071722.9399-1-david@gibson.dropbear.id.au>
References: <20180417071722.9399-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH for-2.13 01/10] spapr: Avoid redundant calls to
 spapr_cpu_reset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org
Cc: benh@kernel.crashing.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

af81cf323c1 "spapr: CPU hotplug support" added a direct call to
spapr_cpu_reset() in spapr_cpu_init(), as well as registering it as a
reset callback.  That was in order to make sure that the reset function
got called for a newly hotplugged cpu, which would miss the global machine
reset.

However, this change means that spapr_cpu_reset() gets called twice for
normal cold-plugged cpus: once from spapr_cpu_init(), then again during
the system reset.  As well as being ugly in its redundancy, the first call
happens before the machine reset calls have happened, which will cause
problems for some things we're going to want to add.

So, we remove the reset call from spapr_cpu_init().  We instead put an
explicit reset call in the hotplug specific path.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c                  |  6 ++++--
 hw/ppc/spapr_cpu_core.c         | 13 ++++++++++++-
 include/hw/ppc/spapr_cpu_core.h |  2 ++
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 7b2bc4e25d..81b50af3b5 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3370,9 +3370,11 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 
         if (hotplugged) {
             /*
-             * Send hotplug notification interrupt to the guest only
-             * in case of hotplugged CPUs.
+             * For hotplugged CPUs, we need to reset them (they missed
+             * out on the system reset), and send the guest a
+             * notification
              */
+            spapr_cpu_core_reset(core);
             spapr_hotplug_req_add_by_index(drc);
         } else {
             spapr_drc_reset(drc);
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 94afeb399e..aa17626cda 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -70,7 +70,6 @@ static void spapr_cpu_init(sPAPRMachineState *spapr, PowerPCCPU *cpu,
     cpu_ppc_set_papr(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
 
     qemu_register_reset(spapr_cpu_reset, cpu);
-    spapr_cpu_reset(cpu);
 }
 
 /*
@@ -208,6 +207,18 @@ err:
     error_propagate(errp, local_err);
 }
 
+void spapr_cpu_core_reset(sPAPRCPUCore *sc)
+{
+    CPUCore *cc = CPU_CORE(sc);
+    int i;
+
+    for (i = 0; i < cc->nr_threads; i++) {
+        PowerPCCPU *cpu = sc->threads[i];
+
+        spapr_cpu_reset(cpu);
+    }
+}
+
 static Property spapr_cpu_core_properties[] = {
     DEFINE_PROP_INT32("node-id", sPAPRCPUCore, node_id, CPU_UNSET_NUMA_NODE_ID),
     DEFINE_PROP_END_OF_LIST()
diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
index 1129f344aa..1a38544706 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -38,4 +38,6 @@ typedef struct sPAPRCPUCoreClass {
 } sPAPRCPUCoreClass;
 
 const char *spapr_get_cpu_core_type(const char *cpu_type);
+void spapr_cpu_core_reset(sPAPRCPUCore *sc);
+
 #endif
-- 
2.14.3
