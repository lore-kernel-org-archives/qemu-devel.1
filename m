Received: from eggs.gnu.org ([2001:4830:134:3::10]:44634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cqgOY-0007dK-4X
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:33:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cqgOS-0001t3-Gf
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:33:42 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 22 Mar 2017 14:32:33 +0100
Message-Id: <1490189568-167621-9-git-send-email-imammedo@redhat.com>
In-Reply-To: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 08/23] virt-arm: add node-id property
 to CPU
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

it will allow switching from cpu_index to property based
numa mapping in follow up patches.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/arm/virt.c    | 15 +++++++++++++++
 target/arm/cpu.c |  1 +
 2 files changed, 16 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 8748d25..68d44f3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1365,6 +1365,7 @@ static void machvirt_init(MachineState *machine)
     for (n = 0; n < machine->possible_cpus->len; n++) {
         Object *cpuobj;
         CPUState *cs;
+        int node_id;
 
         if (n >= smp_cpus) {
             break;
@@ -1377,6 +1378,20 @@ static void machvirt_init(MachineState *machine)
         cs = CPU(cpuobj);
         cs->cpu_index = n;
 
+        node_id = numa_get_node_for_cpu(cs->cpu_index);
+        if (node_id == nb_numa_nodes) {
+            /* by default CPUState::numa_node was 0 if it's not set via CLI
+             * keep it this way for now but in future we probably should
+             * refuse to start up with incomplete numa mapping */
+             node_id = 0;
+        }
+        if (cs->numa_node == CPU_UNSET_NUMA_NODE_ID) {
+            cs->numa_node = node_id;
+        } else {
+            /* CPU isn't device_add compatible yet, this shouldn't happen */
+            error_setg(&error_abort, "user set node-id not implemented");
+        }
+
         if (!vms->secure) {
             object_property_set_bool(cpuobj, false, "has_el3", NULL);
         }
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 04b062c..a635048 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1606,6 +1606,7 @@ static Property arm_cpu_properties[] = {
     DEFINE_PROP_UINT32("midr", ARMCPU, midr, 0),
     DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
                         mp_affinity, ARM64_AFFINITY_INVALID),
+    DEFINE_PROP_INT32("node-id", CPUState, numa_node, CPU_UNSET_NUMA_NODE_ID),
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.7.4
