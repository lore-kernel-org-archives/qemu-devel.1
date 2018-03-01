Received: from eggs.gnu.org ([2001:4830:134:3::10]:57643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erNoG-0001LS-Ue
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 07:59:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erNoF-0005xw-Rr
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 07:59:45 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  1 Mar 2018 13:58:23 +0100
Message-Id: <20180301125830.24377-21-cohuck@redhat.com>
In-Reply-To: <20180301125830.24377-1-cohuck@redhat.com>
References: <20180301125830.24377-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL v2 20/27] qmp: add query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Luiz Capitulino <lcapitulino@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Luiz Capitulino <lcapitulino@redhat.com>

The query-cpus command has an extremely serious side effect:
it always interrupts all running vCPUs so that they can run
ioctl calls. This can cause a huge performance degradation for
some workloads. And most of the information retrieved by the
ioctl calls are not even used by query-cpus.

This commit introduces a replacement for query-cpus called
query-cpus-fast, which has the following features:

 o Never interrupt vCPUs threads. query-cpus-fast only returns
   vCPU information maintained by QEMU itself, which should be
   sufficient for most management software needs

 o Drop "halted" field as it can not be retrieved in a fast
   way on most architectures

 o Drop irrelevant fields such as "current", "pc" and "arch"

 o Rename some fields for better clarification & proper naming
   standard

Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Message-Id: <1518797321-28356-3-git-send-email-mihajlov@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 cpus.c           | 38 ++++++++++++++++++++++++++++++
 qapi-schema.json | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)

diff --git a/cpus.c b/cpus.c
index 6006931d3a..6df6660ccf 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2156,6 +2156,44 @@ CpuInfoList *qmp_query_cpus(Error **errp)
     return head;
 }
 
+/*
+ * fast means: we NEVER interrupt vCPU threads to retrieve
+ * information from KVM.
+ */
+CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    CpuInfoFastList *head = NULL, *cur_item = NULL;
+    CPUState *cpu;
+
+    CPU_FOREACH(cpu) {
+        CpuInfoFastList *info = g_malloc0(sizeof(*info));
+        info->value = g_malloc0(sizeof(*info->value));
+
+        info->value->cpu_index = cpu->cpu_index;
+        info->value->qom_path = object_get_canonical_path(OBJECT(cpu));
+        info->value->thread_id = cpu->thread_id;
+
+        info->value->has_props = !!mc->cpu_index_to_instance_props;
+        if (info->value->has_props) {
+            CpuInstanceProperties *props;
+            props = g_malloc0(sizeof(*props));
+            *props = mc->cpu_index_to_instance_props(ms, cpu->cpu_index);
+            info->value->props = props;
+        }
+
+        if (!cur_item) {
+            head = cur_item = info;
+        } else {
+            cur_item->next = info;
+            cur_item = info;
+        }
+    }
+
+    return head;
+}
+
 void qmp_memsave(int64_t addr, int64_t size, const char *filename,
                  bool has_cpu, int64_t cpu_index, Error **errp)
 {
diff --git a/qapi-schema.json b/qapi-schema.json
index 94d560ed13..815f072876 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -552,6 +552,12 @@
 #
 # Returns a list of information about each virtual CPU.
 #
+# This command causes vCPU threads to exit to userspace, which causes
+# a small interruption to guest CPU execution. This will have a negative
+# impact on realtime guests and other latency sensitive guest workloads.
+# It is recommended to use @query-cpus-fast instead of this command to
+# avoid the vCPU interruption.
+#
 # Returns: a list of @CpuInfo for each virtual CPU
 #
 # Since: 0.14.0
@@ -585,6 +591,70 @@
 { 'command': 'query-cpus', 'returns': ['CpuInfo'] }
 
 ##
+# @CpuInfoFast:
+#
+# Information about a virtual CPU
+#
+# @cpu-index: index of the virtual CPU
+#
+# @qom-path: path to the CPU object in the QOM tree
+#
+# @thread-id: ID of the underlying host thread
+#
+# @props: properties describing to which node/socket/core/thread
+#         virtual CPU belongs to, provided if supported by board
+#
+# Since: 2.12
+#
+##
+{ 'struct': 'CpuInfoFast',
+  'data': {'cpu-index': 'int', 'qom-path': 'str',
+           'thread-id': 'int', '*props': 'CpuInstanceProperties' } }
+
+##
+# @query-cpus-fast:
+#
+# Returns information about all virtual CPUs. This command does not
+# incur a performance penalty and should be used in production
+# instead of query-cpus.
+#
+# Returns: list of @CpuInfoFast
+#
+# Notes: The CPU architecture name is not returned by query-cpus-fast.
+#        Use query-target to retrieve that information.
+#
+# Since: 2.12
+#
+# Example:
+#
+# -> { "execute": "query-cpus-fast" }
+# <- { "return": [
+#         {
+#             "thread-id": 25627,
+#             "props": {
+#                 "core-id": 0,
+#                 "thread-id": 0,
+#                 "socket-id": 0
+#             },
+#             "qom-path": "/machine/unattached/device[0]",
+#             "cpu-index": 0
+#         },
+#         {
+#             "thread-id": 25628,
+#             "props": {
+#                 "core-id": 0,
+#                 "thread-id": 0,
+#                 "socket-id": 1
+#             },
+#             "qom-path": "/machine/unattached/device[2]",
+#             "cpu-index": 1
+#         }
+#     ]
+# }
+##
+{ 'command': 'query-cpus-fast', 'returns': [ 'CpuInfoFast' ] }
+
+##
 # @IOThreadInfo:
 #
 # Information about an iothread
-- 
2.13.6
