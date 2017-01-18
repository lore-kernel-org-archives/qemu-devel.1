Received: from eggs.gnu.org ([2001:4830:134:3::10]:56984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTto6-0002Cs-69
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:13:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTto3-0007NP-Mz
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:13:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cTto3-0007Mg-ES
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:13:55 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 18 Jan 2017 18:13:24 +0100
Message-Id: <1484759609-264075-9-git-send-email-imammedo@redhat.com>
In-Reply-To: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
References: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC 08/13] pc: add writeonly 'cpu' property to
 PCMachine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>, fanc.fnst@cn.fujitsu.com, caoj.fnst@cn.fujitsu.com, stefanha@redhat.com, izumi.taku@jp.fujitsu.com, vilanova@ac.upc.edu, ehabkost@redhat.com, peter.maydell@linaro.org, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>

it will allow generic numa code to set cpu to numa node mapping
in target independent manner in the next patch.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/pc.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f8ea635..1d33a5e 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2201,6 +2201,56 @@ static void pc_machine_set_pit(Object *obj, bool value, Error **errp)
     pcms->pit = value;
 }
 
+static void pc_machine_set_cpu(Object *obj, Visitor *v, const char *name,
+                               void *opaque, Error **errp)
+{
+    uint32_t apic_id;
+    X86CPUTopoInfo topo;
+    CPUArchId *cpu_slot;
+    Error *local_err = NULL;
+    CpuInstanceProperties *cpu_props = NULL;
+    PCMachineState *pcms = PC_MACHINE(obj);
+    MachineClass *mc = MACHINE_GET_CLASS(obj);
+
+    visit_type_CpuInstanceProperties(v, name, &cpu_props, &local_err);
+    if (local_err) {
+        goto out;
+    }
+
+    if (!cpu_props->has_node_id) {
+        error_setg(&local_err, "node-id property is not specified");
+        goto out;
+    }
+
+    /*
+     * make sure that possible_cpus is initialized
+     * as property setter might be called before machine init is called
+     */
+    mc->possible_cpu_arch_ids(MACHINE(obj));
+
+    topo.pkg_id = cpu_props->socket_id;
+    topo.core_id = cpu_props->core_id;
+    topo.smt_id = cpu_props->thread_id;
+    apic_id = apicid_from_topo_ids(smp_cores, smp_threads, &topo);
+    cpu_slot = pc_find_cpu_slot(pcms, apic_id, NULL);
+    if (!cpu_slot) {
+        error_setg(&local_err, "unable to find CPU");
+        goto out;
+    }
+
+    if (cpu_slot->props.has_node_id) {
+        error_setg(&local_err, "CPU has already been assigned to node: %"PRId64,
+                   cpu_slot->props.node_id);
+        goto out;
+    }
+    cpu_slot->props.has_node_id = true;
+    cpu_slot->props.node_id = cpu_props->node_id;
+
+ out:
+    error_propagate(errp, local_err);
+    qapi_free_CpuInstanceProperties(cpu_props);
+}
+
 static void pc_machine_initfn(Object *obj)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
@@ -2395,6 +2445,12 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
 
     object_class_property_add_bool(oc, PC_MACHINE_PIT,
         pc_machine_get_pit, pc_machine_set_pit, &error_abort);
+
+    object_class_property_add(oc, "cpu", "CpuInstanceProperties",
+        NULL, pc_machine_set_cpu,
+        NULL, NULL, &error_abort);
+    object_class_property_set_description(oc, "cpu",
+        "Possible cpu placement", &error_abort);
 }
 
 static const TypeInfo pc_machine_info = {
-- 
2.7.4
