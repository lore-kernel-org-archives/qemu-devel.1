Received: from eggs.gnu.org ([2001:4830:134:3::10]:39621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWDcv-0007gl-Jw
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:24:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWDcu-0003Xw-JN
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:24:49 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 22 Jun 2018 14:24:17 +1000
Message-Id: <20180622042437.14259-3-david@gibson.dropbear.id.au>
In-Reply-To: <20180622042437.14259-1-david@gibson.dropbear.id.au>
References: <20180622042437.14259-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 03/23] spapr_cpu_core: migrate per-CPU data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, aik@ozlabs.ru, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

A per-CPU machine data pointer was recently added to PowerPCCPU. The
motivation is to to hide platform specific details from the core CPU
code. This per-CPU data can hold state which is relevant to the guest
though, eg, Virtual Processor Areas, and we should migrate this state.

This patch adds the plumbing so that we can migrate the per-CPU data
for PAPR guests. We only do this for newer machine types for the sake
of backward compatibility. No state is migrated for the moment: the
vmstate_spapr_cpu_state structure will be populated by subsequent
patches.

Signed-off-by: Greg Kurz <groug@kaod.org>
[dwg: Fix some trivial spelling and spacing errors]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c                  |  7 ++++++-
 hw/ppc/spapr_cpu_core.c         | 22 ++++++++++++++++++++--
 include/hw/ppc/spapr_cpu_core.h |  1 +
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index db0fb385d4..3174468fc5 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4115,7 +4115,12 @@ DEFINE_SPAPR_MACHINE(3_0, "3.0", true);
     HW_COMPAT_2_12                                                     \
     {                                                                  \
         .driver = TYPE_POWERPC_CPU,                                    \
-        .property = "pre-3.0-migration",                              \
+        .property = "pre-3.0-migration",                               \
+        .value    = "on",                                              \
+    },                                                                 \
+    {                                                                  \
+        .driver = TYPE_SPAPR_CPU_CORE,                                 \
+        .property = "pre-3.0-migration",                               \
         .value    = "on",                                              \
     },
 
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index aef3be33a3..f129ac884e 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -129,6 +129,15 @@ static void spapr_cpu_core_unrealize(DeviceState *dev, Error **errp)
     g_free(sc->threads);
 }
 
+static const VMStateDescription vmstate_spapr_cpu_state = {
+    .name = "spapr_cpu",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static void spapr_realize_vcpu(PowerPCCPU *cpu, sPAPRMachineState *spapr,
                                Error **errp)
 {
@@ -194,6 +203,10 @@ static PowerPCCPU *spapr_create_vcpu(sPAPRCPUCore *sc, int i, Error **errp)
     }
 
     cpu->machine_data = g_new0(sPAPRCPUState, 1);
+    if (!sc->pre_3_0_migration) {
+        vmstate_register(NULL, cs->cpu_index, &vmstate_spapr_cpu_state,
+                         cpu->machine_data);
+    }
 
     object_unref(obj);
     return cpu;
@@ -204,10 +217,13 @@ err:
     return NULL;
 }
 
-static void spapr_delete_vcpu(PowerPCCPU *cpu)
+static void spapr_delete_vcpu(PowerPCCPU *cpu, sPAPRCPUCore *sc)
 {
     sPAPRCPUState *spapr_cpu = spapr_cpu_state(cpu);
 
+    if (!sc->pre_3_0_migration) {
+        vmstate_unregister(NULL, &vmstate_spapr_cpu_state, cpu->machine_data);
+    }
     cpu->machine_data = NULL;
     g_free(spapr_cpu);
     object_unparent(OBJECT(cpu));
@@ -253,7 +269,7 @@ err_unrealize:
     }
 err:
     while (--i >= 0) {
-        spapr_delete_vcpu(sc->threads[i]);
+        spapr_delete_vcpu(sc->threads[i], sc);
     }
     g_free(sc->threads);
     error_propagate(errp, local_err);
@@ -261,6 +277,8 @@ err:
 
 static Property spapr_cpu_core_properties[] = {
     DEFINE_PROP_INT32("node-id", sPAPRCPUCore, node_id, CPU_UNSET_NUMA_NODE_ID),
+    DEFINE_PROP_BOOL("pre-3.0-migration", sPAPRCPUCore, pre_3_0_migration,
+                     false),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
index 8ceea2973a..9e2821e4b3 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -31,6 +31,7 @@ typedef struct sPAPRCPUCore {
     /*< public >*/
     PowerPCCPU **threads;
     int node_id;
+    bool pre_3_0_migration; /* older machine don't know about sPAPRCPUState */
 } sPAPRCPUCore;
 
 typedef struct sPAPRCPUCoreClass {
-- 
2.17.1
