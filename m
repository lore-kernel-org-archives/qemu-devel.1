Received: from eggs.gnu.org ([2001:4830:134:3::10]:35203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d8Pp0-0007UE-R1
	for qemu-devel@nongnu.org; Wed, 10 May 2017 07:30:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d8Poz-0001hE-Sw
	for qemu-devel@nongnu.org; Wed, 10 May 2017 07:30:22 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 10 May 2017 13:29:47 +0200
Message-Id: <1494415802-227633-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1494415802-227633-1-git-send-email-imammedo@redhat.com>
References: <1494415802-227633-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 03/18] pc: add node-id property to CPU
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

PS:
patch changes default value of CPUState::numa_node from 0
to CPU_UNSET_NUMA_NODE_ID. The only place for x86 that
would affected is monitor's 'infor numa' command which
uses that field. However legacy 0 value is still preserved
by pc_cpu_pre_plug() in this patch if user/numa.c hasn't
set it explicitly, so there is no change in behavior.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/pc.c      | 17 +++++++++++++++++
 target/i386/cpu.c |  1 +
 2 files changed, 18 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 01693d5..455300f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1893,6 +1893,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
                             DeviceState *dev, Error **errp)
 {
     int idx;
+    int node_id;
     CPUState *cs;
     CPUArchId *cpu_slot;
     X86CPUTopoInfo topo;
@@ -1982,6 +1983,22 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
 
     cs = CPU(cpu);
     cs->cpu_index = idx;
+
+    node_id = numa_get_node_for_cpu(cs->cpu_index);
+    if (node_id == nb_numa_nodes) {
+        /* by default CPUState::numa_node was 0 if it's not set via CLI
+         * keep it this way for now but in future we probably should
+         * refuse to start up with incomplete numa mapping */
+        node_id = 0;
+    }
+    if (cs->numa_node == CPU_UNSET_NUMA_NODE_ID) {
+        cs->numa_node = node_id;
+    } else if (cs->numa_node != node_id) {
+            error_setg(errp, "node-id %d must match numa node specified"
+                "with -numa option for cpu-index %d",
+                cs->numa_node, cs->cpu_index);
+            return;
+    }
 }
 
 static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 13c0985..007a5bd 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3982,6 +3982,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_INT32("core-id", X86CPU, core_id, -1),
     DEFINE_PROP_INT32("socket-id", X86CPU, socket_id, -1),
 #endif
+    DEFINE_PROP_INT32("node-id", CPUState, numa_node, CPU_UNSET_NUMA_NODE_ID),
     DEFINE_PROP_BOOL("pmu", X86CPU, enable_pmu, false),
     { .name  = "hv-spinlocks", .info  = &qdev_prop_spinlocks },
     DEFINE_PROP_BOOL("hv-relaxed", X86CPU, hyperv_relaxed_timing, false),
-- 
2.7.4
