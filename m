Received: from eggs.gnu.org ([2001:4830:134:3::10]:44236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fUtFD-0001h3-RC
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 08:26:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fUtF9-0000PE-Rs
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 08:26:51 -0400
Received: from 6.mo68.mail-out.ovh.net ([46.105.63.100]:35510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fUtF9-0000NN-Jx
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 08:26:47 -0400
Received: from player792.ha.ovh.net (unknown [10.109.108.92])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 79CB6E5050
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 14:26:45 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 18 Jun 2018 14:26:35 +0200
Message-ID: <152932479544.500483.1342368406182952616.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 1/2] spapr_cpu_core: migrate per-CPU data
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

A per-CPU machine data pointer was recently added to PowerPCCPU. The
motivation is to to hide platform specific details from the core CPU
code. This per-CPU data can hold state which is revelant to the guest
though, eg, Virtual Processor Areas, and we whould migrate this state.

This patch adds the plumbing so that we can migrate the per-CPU data
for PAPR guests. We only do this for newer machine types for the sake
of backword compatibility. No state is migrated for the moment: the
vmstate_spapr_cpu_state structure will be populated by subsequent
patches.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c                  |    5 +++++
 hw/ppc/spapr_cpu_core.c         |   27 +++++++++++++++++++++++----
 include/hw/ppc/spapr_cpu_core.h |    1 +
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index db0fb385d4e0..37db3e8bc6ca 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4116,6 +4116,11 @@ DEFINE_SPAPR_MACHINE(3_0, "3.0", true);
     {                                                                  \
         .driver = TYPE_POWERPC_CPU,                                    \
         .property = "pre-3.0-migration",                              \
+        .value    = "on",                                              \
+            },                                                         \
+    {                                                                  \
+        .driver = TYPE_SPAPR_CPU_CORE,                                 \
+        .property = "pre-3.0-migration",                               \
         .value    = "on",                                              \
     },
 
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index aef3be33a3bb..96d1dfad00e1 100644
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
@@ -164,7 +173,8 @@ error:
     error_propagate(errp, local_err);
 }
 
-static PowerPCCPU *spapr_create_vcpu(sPAPRCPUCore *sc, int i, Error **errp)
+static PowerPCCPU *spapr_create_vcpu(sPAPRCPUCore *sc, int i,
+                                     sPAPRMachineState *spapr, Error **errp)
 {
     sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(sc);
     CPUCore *cc = CPU_CORE(sc);
@@ -194,6 +204,10 @@ static PowerPCCPU *spapr_create_vcpu(sPAPRCPUCore *sc, int i, Error **errp)
     }
 
     cpu->machine_data = g_new0(sPAPRCPUState, 1);
+    if (!sc->pre_3_0_migration) {
+        vmstate_register(NULL, cs->cpu_index, &vmstate_spapr_cpu_state,
+                         cpu->machine_data);
+    }
 
     object_unref(obj);
     return cpu;
@@ -204,10 +218,13 @@ err:
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
@@ -233,7 +250,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
 
     sc->threads = g_new(PowerPCCPU *, cc->nr_threads);
     for (i = 0; i < cc->nr_threads; i++) {
-        sc->threads[i] = spapr_create_vcpu(sc, i, &local_err);
+        sc->threads[i] = spapr_create_vcpu(sc, i, spapr, &local_err);
         if (local_err) {
             goto err;
         }
@@ -253,7 +270,7 @@ err_unrealize:
     }
 err:
     while (--i >= 0) {
-        spapr_delete_vcpu(sc->threads[i]);
+        spapr_delete_vcpu(sc->threads[i], sc);
     }
     g_free(sc->threads);
     error_propagate(errp, local_err);
@@ -261,6 +278,8 @@ err:
 
 static Property spapr_cpu_core_properties[] = {
     DEFINE_PROP_INT32("node-id", sPAPRCPUCore, node_id, CPU_UNSET_NUMA_NODE_ID),
+    DEFINE_PROP_BOOL("pre-3.0-migration", sPAPRCPUCore, pre_3_0_migration,
+                     false),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
index 8ceea2973a93..9e2821e4b31f 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -31,6 +31,7 @@ typedef struct sPAPRCPUCore {
     /*< public >*/
     PowerPCCPU **threads;
     int node_id;
+    bool pre_3_0_migration; /* older machine don't know about sPAPRCPUState */
 } sPAPRCPUCore;
 
 typedef struct sPAPRCPUCoreClass {
