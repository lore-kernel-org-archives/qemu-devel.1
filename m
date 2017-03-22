Received: from eggs.gnu.org ([2001:4830:134:3::10]:45072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cqgP8-0008A9-TM
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:34:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cqgP7-000254-Gb
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:34:22 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 22 Mar 2017 14:32:38 +0100
Message-Id: <1490189568-167621-14-git-send-email-imammedo@redhat.com>
In-Reply-To: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 13/23] spapr: get numa node mapping
 from possible_cpus instead of numa_get_node_for_cpu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

it's safe to remove thread node_id != core node_id error
branch as machine_set_cpu_numa_node() also does mismatch
check and is called even before any CPU is created.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/ppc/spapr.c          |  4 ++--
 hw/ppc/spapr_cpu_core.c | 14 ++------------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9c61721..42cef3d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2803,8 +2803,8 @@ static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
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
index 25988f8..8d48468 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -168,7 +168,6 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
 
     sc->threads = g_malloc0(size * cc->nr_threads);
     for (i = 0; i < cc->nr_threads; i++) {
-        int node_id;
         char id[32];
         CPUState *cs;
 
@@ -178,17 +177,8 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
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
2.7.4
