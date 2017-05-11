Received: from eggs.gnu.org ([2001:4830:134:3::10]:37791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tc7-0002OX-07
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tc5-0007n2-Ia
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d8tc5-0007mj-9f
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:01 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 11 May 2017 16:18:21 -0300
Message-Id: <20170511191843.13784-8-ehabkost@redhat.com>
In-Reply-To: <20170511191843.13784-1-ehabkost@redhat.com>
References: <20170511191843.13784-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 07/29] hw/arm/virt: use machine->possible_cpus
 for storing possible topology info
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

for now precalculate and store mp_afinity in possible_cpus
as ARM cpus don't have socket/core/thread-id properties yet.
In follow patches possible_cpus will be used for storing
and setting NUMA node mapping and replace legacy bitmap
based numa_info[node_id].node_cpu/numa_get_node_for_cpu()

For the lack of better idea, this patch cannibalizes
possible_cpus.cpus[x].props.thread_id so that
*_cpu_index_to_props() callback could return addressable
by props CPU which will be used by machine_set_cpu_numa_node()
in follow up patches to assign a CPU to node. But
cannibalizing is fine for now as that thread_id isn't exposed
to users (no hotpluggable_cpus callback support for ARM yet)
and it will be used only internally until 'device_add cpu'
is supported where we can decide on which properties to use.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1493816238-33120-4-git-send-email-imammedo@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/arm/virt.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 61ae43762a..e2c5626c52 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1221,6 +1221,8 @@ static void machvirt_init(MachineState *machine)
 {
     VirtMachineState *vms = VIRT_MACHINE(machine);
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(machine);
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    const CPUArchIdList *possible_cpus;
     qemu_irq pic[NUM_IRQS];
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *secure_sysmem = NULL;
@@ -1344,10 +1346,16 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    for (n = 0; n < smp_cpus; n++) {
-        Object *cpuobj = object_new(typename);
+    possible_cpus = mc->possible_cpu_arch_ids(machine);
+    for (n = 0; n < possible_cpus->len; n++) {
+        Object *cpuobj;
 
-        object_property_set_int(cpuobj, virt_cpu_mp_affinity(vms, n),
+        if (n >= smp_cpus) {
+            break;
+        }
+
+        cpuobj = object_new(typename);
+        object_property_set_int(cpuobj, possible_cpus->cpus[n].arch_id,
                                 "mp-affinity", NULL);
 
         if (!vms->secure) {
@@ -1527,6 +1535,31 @@ static void virt_set_gic_version(Object *obj, const char *value, Error **errp)
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
+            virt_cpu_mp_affinity(vms, n);
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
@@ -1543,6 +1576,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->pci_allow_0_address = true;
     /* We know we will never create a pre-ARMv7 CPU which needs 1K pages */
     mc->minimum_page_bits = 12;
+    mc->possible_cpu_arch_ids = virt_possible_cpu_arch_ids;
 }
 
 static const TypeInfo virt_machine_info = {
-- 
2.11.0.259.g40922b1
