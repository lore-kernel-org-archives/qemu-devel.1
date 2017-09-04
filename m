Received: from eggs.gnu.org ([2001:4830:134:3::10]:37949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dotXt-0004tT-Ey
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:44:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dotXo-0001Pr-IX
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:44:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dotXo-0001PR-AD
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:44:12 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon,  4 Sep 2017 17:43:15 +0200
Message-Id: <20170904154316.4148-19-david@redhat.com>
In-Reply-To: <20170904154316.4148-1-david@redhat.com>
References: <20170904154316.4148-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 18/19] s390x: implement
 query-hotpluggable-cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>

CPU hotplug is only possible on a per core basis on s390x.

As we now have ms->possible_cpus, we can get rid of the global variable
cpu_states.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 90 +++++++++++++++++++++++++++++++++-------------
 qapi-schema.json           | 16 +++++++++
 2 files changed, 81 insertions(+), 25 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index dd149567bb..458615252c 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -36,22 +36,40 @@
 #include "qapi/qmp/qerror.h"
 #include "hw/nmi.h"
 
-static S390CPU **cpu_states;
+static CPUArchId *s390_find_cpu_slot(MachineState *ms, uint32_t core_id,
+                                     int *idx)
+{
+    if (core_id >= ms->possible_cpus->len) {
+        return NULL;
+    }
+    /* core_id corresponds to the index */
+    if (idx) {
+        *idx = core_id;
+    }
+    return &ms->possible_cpus->cpus[core_id];
+}
 
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
 {
-    if (cpu_addr >= max_cpus) {
-        return NULL;
+    static MachineState *ms;
+    CPUArchId *found;
+
+    if (!ms) {
+        ms = MACHINE(qdev_get_machine());
     }
 
-    /* Fast lookup via CPU ID */
-    return cpu_states[cpu_addr];
+    /* CPU address corresponds to core_id */
+    found = s390_find_cpu_slot(ms, cpu_addr, NULL);
+    if (!found) {
+        return NULL;
+    }
+    return S390_CPU(found->cpu);
 }
 
 static void s390_init_cpus(MachineState *machine)
 {
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
     int i;
-    gchar *name;
 
     if (machine->cpu_model == NULL) {
         machine->cpu_model = s390_default_cpu_model_name();
@@ -63,17 +81,8 @@ static void s390_init_cpus(MachineState *machine)
         exit(1);
     }
 
-    cpu_states = g_new0(S390CPU *, max_cpus);
-
-    for (i = 0; i < max_cpus; i++) {
-        name = g_strdup_printf("cpu[%i]", i);
-        object_property_add_link(OBJECT(machine), name, TYPE_S390_CPU,
-                                 (Object **) &cpu_states[i],
-                                 object_property_allow_set_link,
-                                 OBJ_PROP_LINK_UNREF_ON_RELEASE,
-                                 &error_abort);
-        g_free(name);
-    }
+    /* initialize possible_cpus */
+    mc->possible_cpu_arch_ids(machine);
 
     for (i = 0; i < smp_cpus; i++) {
         s390x_new_cpu(machine->cpu_model, i, &error_fatal);
@@ -304,17 +313,14 @@ static void ccw_init(MachineState *machine)
     register_savevm_live(NULL, "todclock", 0, 1, &savevm_gtod, NULL);
 }
 
-static void s390_cpu_plug(HotplugHandler *hotplug_dev,
-                        DeviceState *dev, Error **errp)
+static void s390_cpu_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
+                          Error **errp)
 {
-    gchar *name;
+    MachineState *ms = MACHINE(hotplug_dev);
     S390CPU *cpu = S390_CPU(dev);
-    CPUState *cs = CPU(dev);
 
-    name = g_strdup_printf("cpu[%i]", cpu->env.core_id);
-    object_property_set_link(OBJECT(hotplug_dev), OBJECT(cs), name,
-                             errp);
-    g_free(name);
+    g_assert(!ms->possible_cpus->cpus[cpu->env.core_id].cpu);
+    ms->possible_cpus->cpus[cpu->env.core_id].cpu = OBJECT(dev);
 }
 
 static void s390_machine_reset(void)
@@ -347,6 +353,37 @@ static void s390_machine_device_unplug_request(HotplugHandler *hotplug_dev,
     }
 }
 
+static CpuInstanceProperties s390_cpu_index_to_props(MachineState *machine,
+                                                     unsigned cpu_index)
+{
+    CPUArchId *slot = s390_find_cpu_slot(machine, cpu_index, NULL);
+
+    assert(slot);
+    return slot->props;
+}
+
+static const CPUArchIdList *s390_possible_cpu_arch_ids(MachineState *ms)
+{
+    int i;
+
+    if (ms->possible_cpus) {
+        g_assert(ms->possible_cpus && ms->possible_cpus->len == max_cpus);
+        return ms->possible_cpus;
+    }
+
+    ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
+                                  sizeof(CPUArchId) * max_cpus);
+    ms->possible_cpus->len = max_cpus;
+    for (i = 0; i < ms->possible_cpus->len; i++) {
+        ms->possible_cpus->cpus[i].vcpus_count = 1;
+        ms->possible_cpus->cpus[i].arch_id = i;
+        ms->possible_cpus->cpus[i].props.has_core_id = true;
+        ms->possible_cpus->cpus[i].props.core_id = i;
+    }
+
+    return ms->possible_cpus;
+}
+
 static HotplugHandler *s390_get_hotplug_handler(MachineState *machine,
                                                 DeviceState *dev)
 {
@@ -394,7 +431,10 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
     mc->no_sdcard = 1;
     mc->use_sclp = 1;
     mc->max_cpus = 248;
+    mc->has_hotpluggable_cpus = true;
     mc->get_hotplug_handler = s390_get_hotplug_handler;
+    mc->cpu_index_to_instance_props = s390_cpu_index_to_props;
+    mc->possible_cpu_arch_ids = s390_possible_cpu_arch_ids;
     hc->plug = s390_machine_device_plug;
     hc->unplug_request = s390_machine_device_unplug_request;
     nc->nmi_monitor_handler = s390_nmi;
diff --git a/qapi-schema.json b/qapi-schema.json
index f3af2cb851..79e9f85404 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3121,6 +3121,22 @@
 #      }
 #    ]}
 #
+# For s390x-virtio-ccw machine type started with -smp 1,maxcpus=2 -cpu qemu
+# (Since: 2.11):
+#
+# -> { "execute": "query-hotpluggable-cpus" }
+# <- {"return": [
+#      {
+#         "type": "qemu-s390-cpu", "vcpus-count": 1,
+#         "props": { "core-id": 1 }
+#      },
+#      {
+#         "qom-path": "/machine/unattached/device[0]",
+#         "type": "qemu-s390-cpu", "vcpus-count": 1,
+#         "props": { "core-id": 0 }
+#      }
+#    ]}
+#
 ##
 { 'command': 'query-hotpluggable-cpus', 'returns': ['HotpluggableCPU'] }
 
-- 
2.13.5
