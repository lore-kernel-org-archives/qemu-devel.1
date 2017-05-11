Received: from eggs.gnu.org ([2001:4830:134:3::10]:37829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tcE-0002Vn-Ar
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tcD-0007p4-0I
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d8tcC-0007oq-N5
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:08 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 11 May 2017 16:18:25 -0300
Message-Id: <20170511191843.13784-12-ehabkost@redhat.com>
In-Reply-To: <20170511191843.13784-1-ehabkost@redhat.com>
References: <20170511191843.13784-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 11/29] pc: add node-id property to CPU
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

PS:
patch changes default value of CPUState::numa_node from 0
to CPU_UNSET_NUMA_NODE_ID. The only place for x86 that
would affected is monitor's 'infor numa' command which
uses that field. However legacy 0 value is still preserved
by pc_cpu_pre_plug() in this patch if user/numa.c hasn't
set it explicitly, so there is no change in behavior.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1494415802-227633-4-git-send-email-imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/pc.c      | 17 +++++++++++++++++
 target/i386/cpu.c |  1 +
 2 files changed, 18 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 01693d54ca..455300f776 100644
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
index e3182b296f..5e768404a1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3986,6 +3986,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_INT32("core-id", X86CPU, core_id, -1),
     DEFINE_PROP_INT32("socket-id", X86CPU, socket_id, -1),
 #endif
+    DEFINE_PROP_INT32("node-id", CPUState, numa_node, CPU_UNSET_NUMA_NODE_ID),
     DEFINE_PROP_BOOL("pmu", X86CPU, enable_pmu, false),
     { .name  = "hv-spinlocks", .info  = &qdev_prop_spinlocks },
     DEFINE_PROP_BOOL("hv-relaxed", X86CPU, hyperv_relaxed_timing, false),
-- 
2.11.0.259.g40922b1
