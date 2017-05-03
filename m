Received: from eggs.gnu.org ([2001:4830:134:3::10]:39878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d5trD-0000As-Dl
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d5trC-00017L-FQ
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:58:15 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed,  3 May 2017 14:57:10 +0200
Message-Id: <1493816238-33120-17-git-send-email-imammedo@redhat.com>
In-Reply-To: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
References: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v2 16/24] QMP: include CpuInstanceProperties
 into query_cpus output output
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
Reviewed-by: Eric Blake <eblake@redhat.com>
---
v2:
  * fix checkpatch error and remove extra space after = (Eric)
---
 cpus.c           | 10 ++++++++++
 qapi-schema.json |  6 +++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/cpus.c b/cpus.c
index 740b8dc..4f91d25 100644
--- a/cpus.c
+++ b/cpus.c
@@ -50,6 +50,7 @@
 #include "qapi-event.h"
 #include "hw/nmi.h"
 #include "sysemu/replay.h"
+#include "hw/boards.h"
 
 #ifdef CONFIG_LINUX
 
@@ -1859,6 +1860,8 @@ void list_cpus(FILE *f, fprintf_function cpu_fprintf, const char *optarg)
 
 CpuInfoList *qmp_query_cpus(Error **errp)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
     CpuInfoList *head = NULL, *cur_item = NULL;
     CPUState *cpu;
 
@@ -1909,6 +1912,13 @@ CpuInfoList *qmp_query_cpus(Error **errp)
 #else
         info->value->arch = CPU_INFO_ARCH_OTHER;
 #endif
+        info->value->has_props = !!mc->cpu_index_to_instance_props;
+        if (info->value->has_props) {
+            CpuInstanceProperties *props;
+            props = g_malloc0(sizeof(*props));
+            *props = mc->cpu_index_to_instance_props(ms, cpu->cpu_index);
+            info->value->props = props;
+        }
 
         /* XXX: waiting for the qapi to support GSList */
         if (!cur_item) {
diff --git a/qapi-schema.json b/qapi-schema.json
index 01b087f..76d137d 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1325,6 +1325,9 @@
 #
 # @thread_id: ID of the underlying host thread
 #
+# @props: properties describing to which node/socket/core/thread
+#         virtual CPU belongs to, provided if supported by board (since 2.10)
+#
 # @arch: architecture of the cpu, which determines which additional fields
 #        will be listed (since 2.6)
 #
@@ -1335,7 +1338,8 @@
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
