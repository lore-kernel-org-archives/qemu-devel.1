Received: from eggs.gnu.org ([2001:4830:134:3::10]:44270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cqgNq-0006wS-QL
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:33:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cqgNp-0001j2-Sq
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:33:02 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 22 Mar 2017 14:32:28 +0100
Message-Id: <1490189568-167621-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 03/23] hw/arm/virt: use
 machine->possible_cpus for storing possible topology info
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

for now precalculate and store mp_afinity in possible_cpus
as ARM cpus don't have socket/core/thread-id properties yet.
In follow patches possible_cpus will be used for storing
and setting NUMA node mapping and replace legacy bitmap
based numa_info[node_id].node_cpu/numa_get_node_for_cpu()

For the lack of better idea, this patch cannibalizes
possible_cpus.cpus[x].props.thread_id so that
*_cpu_index_to_props() callback could return addressable
by props CPU which will used by machine_set_cpu_numa_node()
in follow up patches to assign a CPU to node. But
cannibalizing is fine for now as that thread_id isn't exposed
to users (no hotpluggable_cpus callback support for ARM yet)
and it will be used only internally until 'device_add cpu'
is supported where we can decide on which properties to use.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/arm/virt.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 484754e..4de46b1 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1237,6 +1237,7 @@ static void machvirt_init(MachineState *machine)
 {
     VirtMachineState *vms = VIRT_MACHINE(machine);
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(machine);
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
     qemu_irq pic[NUM_IRQS];
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *secure_sysmem = NULL;
@@ -1360,10 +1361,16 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    for (n = 0; n < smp_cpus; n++) {
-        Object *cpuobj = object_new(typename);
+    mc->possible_cpu_arch_ids(machine);
+    for (n = 0; n < machine->possible_cpus->len; n++) {
+        Object *cpuobj;
 
-        object_property_set_int(cpuobj, virt_idx2mp_affinity(vms, n),
+        if (n >= smp_cpus) {
+            break;
+        }
+
+        cpuobj = object_new(typename);
+        object_property_set_int(cpuobj, machine->possible_cpus->cpus[n].arch_id,
                                 "mp-affinity", NULL);
 
         if (!vms->secure) {
@@ -1543,6 +1550,31 @@ static void virt_set_gic_version(Object *obj, const char *value, Error **errp)
     }
 }
 
+static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
+{
+    int n;
+    VirtMachineState *vms = VIRT_MACHINE(ms);
+
+    if (ms->possible_cpus) {
+        assert(ms->possible_cpus->len == max_cpus);
+        return ms->possible_cpus;
+    }
+
+    ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
+                                  sizeof(CPUArchId) * max_cpus);
+    ms->possible_cpus->len = max_cpus;
+    for (n = 0; n < ms->possible_cpus->len; n++) {
+        ms->possible_cpus->cpus[n].arch_id =
+            virt_idx2mp_affinity(vms, n);
+        ms->possible_cpus->cpus[n].props.has_thread_id = true;
+        ms->possible_cpus->cpus[n].props.thread_id = n;
+
+        /* TODO: add 'has_node/node' here to describe
+           to which node core belongs */
+    }
+    return ms->possible_cpus;
+}
+
 static void virt_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -1559,6 +1591,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->pci_allow_0_address = true;
     /* We know we will never create a pre-ARMv7 CPU which needs 1K pages */
     mc->minimum_page_bits = 12;
+    mc->possible_cpu_arch_ids = virt_possible_cpu_arch_ids;
 }
 
 static const TypeInfo virt_machine_info = {
-- 
2.7.4
