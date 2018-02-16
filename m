Received: from eggs.gnu.org ([2001:4830:134:3::10]:38627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@de.ibm.com>) id 1emelH-0002DO-KF
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 07:05:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@de.ibm.com>) id 1emelD-0002wT-DY
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 07:05:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38992
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@de.ibm.com>) id 1emelD-0002w4-8W
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 07:05:03 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1GBuJNx101853
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 07:05:00 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g5u9x0rr5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 07:05:00 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@de.ibm.com>;
	Fri, 16 Feb 2018 12:04:58 -0000
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Fri, 16 Feb 2018 13:04:49 +0100
In-Reply-To: <1518782691-1232-1-git-send-email-mihajlov@linux.vnet.ibm.com>
References: <1518782691-1232-1-git-send-email-mihajlov@linux.vnet.ibm.com>
Message-Id: <1518782691-1232-3-git-send-email-mihajlov@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCHv4 2/4] qmp: add query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: agraf@suse.de, ehabkost@redhat.com, armbru@redhat.com, cohuck@redhat.com, david@redhat.com, dgilbert@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, eblake@redhat.com

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

Further, the HMP "info cpus" implementation is changed to
use the new QMP interface to avoid the side effects caused
by query-cpus. This means that only a reduced subset of cpu
information will be reported, which is acceptable as
the content of "info cpus" is not documented or guaranteed
to be stable.

Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Eric Blake <eblake@redhat.com>
---
 cpus.c           | 38 ++++++++++++++++++++++++++++++
 hmp.c            | 46 +++++--------------------------------
 qapi-schema.json | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 114 insertions(+), 40 deletions(-)

diff --git a/cpus.c b/cpus.c
index 6006931..6df6660 100644
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
diff --git a/hmp.c b/hmp.c
index 7870d6a..28b1070 100644
--- a/hmp.c
+++ b/hmp.c
@@ -360,50 +360,16 @@ void hmp_info_migrate_cache_size(Monitor *mon, const QDict *qdict)
 
 void hmp_info_cpus(Monitor *mon, const QDict *qdict)
 {
-    CpuInfoList *cpu_list, *cpu;
+    CpuInfoFastList *head, *cpu;
 
-    cpu_list = qmp_query_cpus(NULL);
+    head = qmp_query_cpus_fast(NULL);
 
-    for (cpu = cpu_list; cpu; cpu = cpu->next) {
-        int active = ' ';
-
-        if (cpu->value->CPU == monitor_get_cpu_index()) {
-            active = '*';
-        }
-
-        monitor_printf(mon, "%c CPU #%" PRId64 ":", active, cpu->value->CPU);
-
-        switch (cpu->value->arch) {
-        case CPU_INFO_ARCH_X86:
-            monitor_printf(mon, " pc=0x%016" PRIx64, cpu->value->u.x86.pc);
-            break;
-        case CPU_INFO_ARCH_PPC:
-            monitor_printf(mon, " nip=0x%016" PRIx64, cpu->value->u.ppc.nip);
-            break;
-        case CPU_INFO_ARCH_SPARC:
-            monitor_printf(mon, " pc=0x%016" PRIx64,
-                           cpu->value->u.q_sparc.pc);
-            monitor_printf(mon, " npc=0x%016" PRIx64,
-                           cpu->value->u.q_sparc.npc);
-            break;
-        case CPU_INFO_ARCH_MIPS:
-            monitor_printf(mon, " PC=0x%016" PRIx64, cpu->value->u.q_mips.PC);
-            break;
-        case CPU_INFO_ARCH_TRICORE:
-            monitor_printf(mon, " PC=0x%016" PRIx64, cpu->value->u.tricore.PC);
-            break;
-        default:
-            break;
-        }
-
-        if (cpu->value->halted) {
-            monitor_printf(mon, " (halted)");
-        }
-
-        monitor_printf(mon, " thread_id=%" PRId64 "\n", cpu->value->thread_id);
+    for (cpu = head; cpu; cpu = cpu->next) {
+        monitor_printf(mon, "  CPU #%" PRId64 ":", cpu->value->cpu_index);
+        monitor_printf(mon, " thread-id=%" PRId64 "\n", cpu->value->thread_id);
     }
 
-    qapi_free_CpuInfoList(cpu_list);
+    qapi_free_CpuInfoFastList(head);
 }
 
 static void print_block_info(Monitor *mon, BlockInfo *info,
diff --git a/qapi-schema.json b/qapi-schema.json
index 94d560e..815f072 100644
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
1.9.1
