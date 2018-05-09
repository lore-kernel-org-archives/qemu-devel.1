Received: from eggs.gnu.org ([2001:4830:134:3::10]:47774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fGKas-00068z-EH
	for qemu-devel@nongnu.org; Wed, 09 May 2018 04:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fGKao-0001iz-DO
	for qemu-devel@nongnu.org; Wed, 09 May 2018 04:37:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:17048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
	id 1fGKao-0001ez-1W
	for qemu-devel@nongnu.org; Wed, 09 May 2018 04:36:58 -0400
From: Liu Jingqi <jingqi.liu@intel.com>
Date: Wed,  9 May 2018 16:36:29 +0800
Message-Id: <1525854989-14165-1-git-send-email-jingqi.liu@intel.com>
Subject: [Qemu-devel] [PATCH v1 4/7] numa: Classify the numa nodes as memory
 initiators and memory targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: mst@redhat.com, imammedo@redhat.com, marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org, Liu Jingqi <jingqi.liu@intel.com>

An initiator proximity domain (memory initiator) is any device
such as a CPU or a separate memory I/O device that can initiate
a memory request. A target proximity domain (memory target)
is a CPU-accessible physical address range.

Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
---
 numa.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/numa.c b/numa.c
index 70b150e..fe0009c 100644
--- a/numa.c
+++ b/numa.c
@@ -40,6 +40,7 @@
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "qemu/cutils.h"
+#include "hw/acpi/hmat.h"
 
 QemuOptsList qemu_numa_opts = {
     .name = "numa",
@@ -100,6 +101,10 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
         machine_set_cpu_numa_node(ms, &props, &error_fatal);
     }
 
+    if (node->cpus) {
+        initiator_pxm[num_initiator++] = nodenr;
+    }
+
     if (node->has_mem && node->has_memdev) {
         error_setg(errp, "cannot specify both mem= and memdev=");
         return;
@@ -116,6 +121,7 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
 
     if (node->has_mem) {
         numa_info[nodenr].node_mem = node->mem;
+        target_pxm[num_target++] = nodenr;
     }
     if (node->has_memdev) {
         Object *o;
@@ -128,6 +134,7 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
         object_ref(o);
         numa_info[nodenr].node_mem = object_property_get_uint(o, "size", NULL);
         numa_info[nodenr].node_memdev = MEMORY_BACKEND(o);
+        target_pxm[num_target++] = nodenr;
     }
     numa_info[nodenr].present = true;
     max_numa_nodeid = MAX(max_numa_nodeid, nodenr + 1);
-- 
2.7.4
