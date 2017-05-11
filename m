Received: from eggs.gnu.org ([2001:4830:134:3::10]:37847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tcG-0002Xl-8n
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tcF-0007pq-7e
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d8tcF-0007pY-1O
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:11 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 11 May 2017 16:18:26 -0300
Message-Id: <20170511191843.13784-13-ehabkost@redhat.com>
In-Reply-To: <20170511191843.13784-1-ehabkost@redhat.com>
References: <20170511191843.13784-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 12/29] virt-arm: add node-id property to CPU
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

it will allow switching from cpu_index to property based
numa mapping in follow up patches.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Message-Id: <1494415802-227633-5-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/arm/virt.c    | 15 +++++++++++++++
 target/arm/cpu.c |  1 +
 2 files changed, 16 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index dfd6fd446c..653b4d76fd 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1350,6 +1350,7 @@ static void machvirt_init(MachineState *machine)
     for (n = 0; n < possible_cpus->len; n++) {
         Object *cpuobj;
         CPUState *cs;
+        int node_id;
 
         if (n >= smp_cpus) {
             break;
@@ -1362,6 +1363,20 @@ static void machvirt_init(MachineState *machine)
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
index ee1406da12..c185eb19ac 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1573,6 +1573,7 @@ static Property arm_cpu_properties[] = {
     DEFINE_PROP_UINT32("midr", ARMCPU, midr, 0),
     DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
                         mp_affinity, ARM64_AFFINITY_INVALID),
+    DEFINE_PROP_INT32("node-id", CPUState, numa_node, CPU_UNSET_NUMA_NODE_ID),
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.11.0.259.g40922b1
