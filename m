Received: from eggs.gnu.org ([2001:4830:134:3::10]:60087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@de.ibm.com>) id 1eleET-0006Ds-69
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:19:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@de.ibm.com>) id 1eleEP-0000ZB-04
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:19:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55436
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@de.ibm.com>) id 1eleEO-0000Xz-Qm
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:19:00 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1DHG3sa143341
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 12:18:58 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g40xk1f03-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 12:18:57 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@de.ibm.com>;
	Tue, 13 Feb 2018 17:18:55 -0000
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Tue, 13 Feb 2018 18:18:47 +0100
In-Reply-To: <1518542328-25741-1-git-send-email-mihajlov@linux.vnet.ibm.com>
References: <1518542328-25741-1-git-send-email-mihajlov@linux.vnet.ibm.com>
Message-Id: <1518542328-25741-3-git-send-email-mihajlov@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCHv2 2/3] qmp: add query-cpus-fast
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

 o Make "halted" field optional: we only return it if the
   halted state is maintained by QEMU. But this also gives
   the option of dropping the field in the future (see below)

 o Drop irrelevant fields such as "current", "pc", "arch"
   and "halted"

 o Rename some fields for better clarification & proper naming
   standard

Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
---
 cpus.c               | 38 ++++++++++++++++++++++++++++
 hmp-commands-info.hx | 14 +++++++++++
 hmp.c                | 14 +++++++++++
 hmp.h                |  1 +
 qapi-schema.json     | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 137 insertions(+)

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
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index ad590a4..16ac602 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -160,6 +160,20 @@ Show infos for each CPU.
 ETEXI
 
     {
+        .name       = "cpus_fast",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show information for each CPU without interrupting them",
+        .cmd        = hmp_info_cpus_fast,
+    },
+
+STEXI
+@item info cpus_fast
+@findex info cpus_fast
+Show infos for each CPU without performance penalty.
+ETEXI
+
+    {
         .name       = "history",
         .args_type  = "",
         .params     = "",
diff --git a/hmp.c b/hmp.c
index a6b94b7..0bd3b3a 100644
--- a/hmp.c
+++ b/hmp.c
@@ -410,6 +410,20 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdict)
     qapi_free_CpuInfoList(cpu_list);
 }
 
+void hmp_info_cpus_fast(Monitor *mon, const QDict *qdict)
+{
+    CpuInfoFastList *head, *cpu;
+
+    head = qmp_query_cpus_fast(NULL);
+
+    for (cpu = head; cpu; cpu = cpu->next) {
+        monitor_printf(mon, "  CPU #%" PRId64 ":", cpu->value->cpu_index);
+        monitor_printf(mon, " thread-id=%" PRId64 "\n", cpu->value->thread_id);
+    }
+
+    qapi_free_CpuInfoFastList(head);
+}
+
 static void print_block_info(Monitor *mon, BlockInfo *info,
                              BlockDeviceInfo *inserted, bool verbose)
 {
diff --git a/hmp.h b/hmp.h
index 1143db4..93fb4e4 100644
--- a/hmp.h
+++ b/hmp.h
@@ -29,6 +29,7 @@ void hmp_info_migrate_capabilities(Monitor *mon, const QDict *qdict);
 void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict);
 void hmp_info_migrate_cache_size(Monitor *mon, const QDict *qdict);
 void hmp_info_cpus(Monitor *mon, const QDict *qdict);
+void hmp_info_cpus_fast(Monitor *mon, const QDict *qdict);
 void hmp_info_block(Monitor *mon, const QDict *qdict);
 void hmp_info_blockstats(Monitor *mon, const QDict *qdict);
 void hmp_info_vnc(Monitor *mon, const QDict *qdict);
diff --git a/qapi-schema.json b/qapi-schema.json
index 94d560e..dc07729 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -552,6 +552,12 @@
 #
 # Returns a list of information about each virtual CPU.
 #
+# This command causes vCPU threads to exit to userspace, which causes
+# an small interruption guest CPU execution. This will have a negative
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
