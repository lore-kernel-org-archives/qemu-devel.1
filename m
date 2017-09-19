Received: from eggs.gnu.org ([2001:4830:134:3::10]:46547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duK07-0004kJ-HK
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:59:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duK01-00013V-JA
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:59:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48575)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duK01-00012d-AS
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:59:45 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Sep 2017 16:56:26 +0200
Message-Id: <20170919145636.9389-29-cohuck@redhat.com>
In-Reply-To: <20170919145636.9389-1-cohuck@redhat.com>
References: <20170919145636.9389-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 28/38] s390x: implement query-hotpluggable-cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

CPU hotplug is only possible on a per core basis on s390x. So let's
add possible_cpus and wire everything up properly.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170913132417.24384-19-david@redhat.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 41 +++++++++++++++++++++++++++++++++++++++++
 qapi-schema.json           | 16 ++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 3be81d96af..cc64a81321 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -50,6 +50,7 @@ S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
 
 static void s390_init_cpus(MachineState *machine)
 {
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
     int i;
     gchar *name;
 
@@ -74,6 +75,9 @@ static void s390_init_cpus(MachineState *machine)
         g_free(name);
     }
 
+    /* initialize possible_cpus */
+    mc->possible_cpu_arch_ids(machine);
+
     for (i = 0; i < smp_cpus; i++) {
         s390x_new_cpu(machine->cpu_model, i, &error_fatal);
     }
@@ -307,6 +311,7 @@ static void s390_cpu_plug(HotplugHandler *hotplug_dev,
                         DeviceState *dev, Error **errp)
 {
     gchar *name;
+    MachineState *ms = MACHINE(hotplug_dev);
     S390CPU *cpu = S390_CPU(dev);
     CPUState *cs = CPU(dev);
 
@@ -314,6 +319,9 @@ static void s390_cpu_plug(HotplugHandler *hotplug_dev,
     object_property_set_link(OBJECT(hotplug_dev), OBJECT(cs), name,
                              errp);
     g_free(name);
+
+    g_assert(!ms->possible_cpus->cpus[cpu->env.core_id].cpu);
+    ms->possible_cpus->cpus[cpu->env.core_id].cpu = OBJECT(dev);
 }
 
 static void s390_machine_reset(void)
@@ -346,6 +354,36 @@ static void s390_machine_device_unplug_request(HotplugHandler *hotplug_dev,
     }
 }
 
+static CpuInstanceProperties s390_cpu_index_to_props(MachineState *machine,
+                                                     unsigned cpu_index)
+{
+    g_assert(machine->possible_cpus && cpu_index < machine->possible_cpus->len);
+
+    return machine->possible_cpus->cpus[cpu_index].props;
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
@@ -393,7 +431,10 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
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
index cdff39a456..a3ba1c9a1c 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3153,6 +3153,22 @@
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
