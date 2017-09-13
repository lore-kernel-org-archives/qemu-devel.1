Received: from eggs.gnu.org ([2001:4830:134:3::10]:39560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ds7fz-00069A-A6
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 09:26:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ds7fv-0003T0-7w
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 09:25:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1ds7fu-0003SK-Vy
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 09:25:55 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 13 Sep 2017 15:24:14 +0200
Message-Id: <20170913132417.24384-20-david@redhat.com>
In-Reply-To: <20170913132417.24384-1-david@redhat.com>
References: <20170913132417.24384-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v5 19/22] s390x: get rid of cpu_states and use
 possible_cpus instead
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Now that we have possible_cpus, we can get rid of the global variable
and rewrite s390_cpu_addr2state() to use it.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 36 ++++++++++--------------------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index cc64a81321..720f145054 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -36,23 +36,26 @@
 #include "qapi/qmp/qerror.h"
 #include "hw/nmi.h"
 
-static S390CPU **cpu_states;
-
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
 {
-    if (cpu_addr >= max_cpus) {
-        return NULL;
+    static MachineState *ms;
+
+    if (!ms) {
+        ms = MACHINE(qdev_get_machine());
+        g_assert(ms->possible_cpus);
     }
 
-    /* Fast lookup via CPU ID */
-    return cpu_states[cpu_addr];
+    /* CPU address corresponds to the core_id and the index */
+    if (cpu_addr >= ms->possible_cpus->len) {
+        return NULL;
+    }
+    return S390_CPU(ms->possible_cpus->cpus[cpu_addr].cpu);
 }
 
 static void s390_init_cpus(MachineState *machine)
 {
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     int i;
-    gchar *name;
 
     if (machine->cpu_model == NULL) {
         machine->cpu_model = s390_default_cpu_model_name();
@@ -63,18 +66,6 @@ static void s390_init_cpus(MachineState *machine)
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
-
     /* initialize possible_cpus */
     mc->possible_cpu_arch_ids(machine);
 
@@ -310,15 +301,8 @@ static void ccw_init(MachineState *machine)
 static void s390_cpu_plug(HotplugHandler *hotplug_dev,
                         DeviceState *dev, Error **errp)
 {
-    gchar *name;
     MachineState *ms = MACHINE(hotplug_dev);
     S390CPU *cpu = S390_CPU(dev);
-    CPUState *cs = CPU(dev);
-
-    name = g_strdup_printf("cpu[%i]", cpu->env.core_id);
-    object_property_set_link(OBJECT(hotplug_dev), OBJECT(cs), name,
-                             errp);
-    g_free(name);
 
     g_assert(!ms->possible_cpus->cpus[cpu->env.core_id].cpu);
     ms->possible_cpus->cpus[cpu->env.core_id].cpu = OBJECT(dev);
-- 
2.13.5
