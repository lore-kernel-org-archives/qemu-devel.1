Received: from eggs.gnu.org ([2001:4830:134:3::10]:41609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cTpYt-0000tf-E9
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:42:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cTpYs-0003aU-CK
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:41:59 -0500
Received: from [59.151.112.132] (port=23495 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cTpYr-0003Zg-SI
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:41:58 -0500
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Date: Wed, 18 Jan 2017 20:40:05 +0800
Message-ID: <1484743207-10721-2-git-send-email-douly.fnst@cn.fujitsu.com>
In-Reply-To: <1484743207-10721-1-git-send-email-douly.fnst@cn.fujitsu.com>
References: <1484743207-10721-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/3] cpu: Make the mapping of CPUs and NUMA
 nodes in cpu_common_realizefn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ehabkost@redhat.com, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org, vilanova@ac.upc.edu, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com, Dou Liyang <douly.fnst@cn.fujitsu.com>

Current default way of seting the CPUState::numa_node might be wrong
in case on cold/hot-plug CPUs. Making the users confused why the
NUMA info is different beetween the guests and monitor.

Make the mapping of CPUs and NUMA nodes in qom/cpu.c:
cpu_common_realizefn(), where each VCPUs need to realize.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 qom/cpu.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/qom/cpu.c b/qom/cpu.c
index 61ee0cb..e08dceb 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -23,6 +23,7 @@
 #include "qemu-common.h"
 #include "qom/cpu.h"
 #include "sysemu/kvm.h"
+#include "sysemu/numa.h"
 #include "qemu/notify.h"
 #include "qemu/log.h"
 #include "exec/log.h"
@@ -338,6 +339,18 @@ static void cpu_common_parse_features(const char *typename, char *features,
     }
 }
 
+static void cpu_common_map_numa_node(CPUState *cpu)
+{
+    int i;
+
+    for (i = 0; i < nb_numa_nodes; i++) {
+        assert(cpu->cpu_index < max_cpus);
+        if (test_bit(cpu->cpu_index, numa_info[i].node_cpu)) {
+            cpu->numa_node = i;
+        }
+    }
+}
+
 static void cpu_common_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cpu = CPU(dev);
@@ -347,6 +360,8 @@ static void cpu_common_realizefn(DeviceState *dev, Error **errp)
         cpu_resume(cpu);
     }
 
+    cpu_common_map_numa_node(cpu);
+
     /* NOTE: latest generic point where the cpu is fully realized */
     trace_init_vcpu(cpu);
 }
-- 
2.5.5
