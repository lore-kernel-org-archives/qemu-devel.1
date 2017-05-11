Received: from eggs.gnu.org ([2001:4830:134:3::10]:37929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tcP-0002g9-A9
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tcO-0007uR-BO
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d8tcO-0007tx-5G
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:20 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 11 May 2017 16:18:31 -0300
Message-Id: <20170511191843.13784-18-ehabkost@redhat.com>
In-Reply-To: <20170511191843.13784-1-ehabkost@redhat.com>
References: <20170511191843.13784-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 17/29] spapr: get numa node mapping from
 possible_cpus instead of numa_get_node_for_cpu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

it's safe to remove thread node_id != core node_id error
branch as machine_set_cpu_numa_node() also does mismatch
check and is called even before any CPU is created.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <1494415802-227633-10-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/ppc/spapr.c          |  4 ++--
 hw/ppc/spapr_cpu_core.c | 14 ++------------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a952a39836..504161fa45 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2863,8 +2863,8 @@ static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         goto out;
     }
 
-    node_id = numa_get_node_for_cpu(cc->core_id);
-    if (node_id == nb_numa_nodes) {
+    node_id = core_slot->props.node_id;
+    if (!core_slot->props.has_node_id) {
         /* by default CPUState::numa_node was 0 if it's not set via CLI
          * keep it this way for now but in future we probably should
          * refuse to start up with incomplete numa mapping */
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 9de7a5610c..a17ea07ef1 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -181,7 +181,6 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
 
     sc->threads = g_malloc0(size * cc->nr_threads);
     for (i = 0; i < cc->nr_threads; i++) {
-        int node_id;
         char id[32];
         CPUState *cs;
 
@@ -191,17 +190,8 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
         cs = CPU(obj);
         cs->cpu_index = cc->core_id + i;
 
-        /* Set NUMA node for the added CPUs  */
-        node_id = numa_get_node_for_cpu(cs->cpu_index);
-        if (node_id != sc->node_id) {
-            error_setg(&local_err, "Invalid node-id=%d of thread[cpu-index: %d]"
-                " on CPU[core-id: %d, node-id: %d], node-id must be the same",
-                 node_id, cs->cpu_index, cc->core_id, sc->node_id);
-            goto err;
-        }
-        if (node_id < nb_numa_nodes) {
-            cs->numa_node = node_id;
-        }
+        /* Set NUMA node for the threads belonged to core  */
+        cs->numa_node = sc->node_id;
 
         snprintf(id, sizeof(id), "thread[%d]", i);
         object_property_add_child(OBJECT(sc), id, obj, &local_err);
-- 
2.11.0.259.g40922b1
