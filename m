Received: from eggs.gnu.org ([2001:4830:134:3::10]:45168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cqgPI-0008JO-Og
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:34:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cqgPH-00027X-OL
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:34:32 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 22 Mar 2017 14:32:40 +0100
Message-Id: <1490189568-167621-16-git-send-email-imammedo@redhat.com>
In-Reply-To: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 15/23] QMP: include
 CpuInstanceProperties into query_cpus output output
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

if board supports CpuInstanceProperties, report them for
each CPU thread listed. Main motivation for this is to
provide these properties introspection via QMP interface
for using in test cases to verify numa node to cpu mapping,
which includes not only boards that support cpu hotplug
and have this info in query-hotpluggable-cpus (pc/spapr)
but also for boards that don't not support hotpluggable-cpus
but support numa mapping (virt-arm).

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 cpus.c           | 9 +++++++++
 qapi-schema.json | 6 +++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/cpus.c b/cpus.c
index 167d961..03aa12c 100644
--- a/cpus.c
+++ b/cpus.c
@@ -50,6 +50,7 @@
 #include "qapi-event.h"
 #include "hw/nmi.h"
 #include "sysemu/replay.h"
+#include "hw/boards.h"
 
 #ifdef CONFIG_LINUX
 
@@ -1810,6 +1811,8 @@ void list_cpus(FILE *f, fprintf_function cpu_fprintf, const char *optarg)
 
 CpuInfoList *qmp_query_cpus(Error **errp)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
     CpuInfoList *head = NULL, *cur_item = NULL;
     CPUState *cpu;
 
@@ -1860,6 +1863,12 @@ CpuInfoList *qmp_query_cpus(Error **errp)
 #else
         info->value->arch = CPU_INFO_ARCH_OTHER;
 #endif
+        if ((info->value->has_props = !!mc->cpu_index_to_instance_props)) {
+            CpuInstanceProperties *props;
+            props = g_malloc0(sizeof(*props));
+            *props = mc->cpu_index_to_instance_props(ms, cpu->cpu_index);
+            info->value->props =  props;
+        }
 
         /* XXX: waiting for the qapi to support GSList */
         if (!cur_item) {
diff --git a/qapi-schema.json b/qapi-schema.json
index 68a4327..a6b5955 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1322,6 +1322,9 @@
 #
 # @thread_id: ID of the underlying host thread
 #
+# @props: properties describing to which node/socket/core/thread
+#         virtual CPU belongs to, provided if supported by board (since 2.10)
+#
 # @arch: architecture of the cpu, which determines which additional fields
 #        will be listed (since 2.6)
 #
@@ -1332,7 +1335,8 @@
 ##
 { 'union': 'CpuInfo',
   'base': {'CPU': 'int', 'current': 'bool', 'halted': 'bool',
-           'qom_path': 'str', 'thread_id': 'int', 'arch': 'CpuInfoArch' },
+           'qom_path': 'str', 'thread_id': 'int',
+           '*props': 'CpuInstanceProperties', 'arch': 'CpuInfoArch' },
   'discriminator': 'arch',
   'data': { 'x86': 'CpuInfoX86',
             'sparc': 'CpuInfoSPARC',
-- 
2.7.4
