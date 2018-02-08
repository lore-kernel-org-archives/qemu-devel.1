Received: from eggs.gnu.org ([2001:4830:134:3::10]:40700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lcapitulino@redhat.com>) id 1ejpIc-0003qI-9w
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:43:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lcapitulino@redhat.com>) id 1ejpIa-0007xl-P1
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:43:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47874 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lcapitulino@redhat.com>)
	id 1ejpIa-0007xS-II
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:43:48 -0500
Date: Thu, 8 Feb 2018 11:17:32 -0500
From: Luiz Capitulino <lcapitulino@redhat.com>
Message-ID: <20180208111732.09869f84@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2] qmp: add query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, ehabkost@redhat.com, mihajlov@linux.vnet.ibm.com, eblake@redhat.com, berrange@redhat.com


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

 o Drop irrelevant fields such as "current", "pc" and "arch"

 o Rename some fields for better clarification & proper naming
   standard

The "halted" field is somewhat controversial. On the one hand,
it offers a convenient way to know if a guest CPU is idle or
running. On the other hand, it's a field that can change many
times a second. In fact, the halted state can change even
before query-cpus-fast has returned. This makes one wonder if
this field should be dropped all together. Having the "halted"
field as optional gives a better option for dropping it in
the future, since we can just stop returning it.

Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
---

o v2

 - Many English and naming corrections by Eric
 - Adopt query-cpus text from Daniel
 - squash query-cpus text change into this patch

 cpus.c               | 44 ++++++++++++++++++++++++++++++
 hmp-commands-info.hx | 14 ++++++++++
 hmp.c                | 24 ++++++++++++++++
 hmp.h                |  1 +
 qapi-schema.json     | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 160 insertions(+)

diff --git a/cpus.c b/cpus.c
index 182caf764e..905b1f4d79 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2150,6 +2150,50 @@ CpuInfoList *qmp_query_cpus(Error **errp)
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
+        /* if in kernel irqchip is used, we don't have 'halted' */
+        info->value->has_halted = !kvm_irqchip_in_kernel();
+        if (info->value->has_halted) {
+            info->value->halted = cpu->halted;
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
index ad590a4ffb..16ac60285f 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -157,6 +157,20 @@ STEXI
 @item info cpus
 @findex info cpus
 Show infos for each CPU.
+ETEXI
+
+    {
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
 ETEXI
 
     {
diff --git a/hmp.c b/hmp.c
index b3de32d219..90717c13b2 100644
--- a/hmp.c
+++ b/hmp.c
@@ -404,6 +404,30 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdict)
     qapi_free_CpuInfoList(cpu_list);
 }
 
+void hmp_info_cpus_fast(Monitor *mon, const QDict *qdict)
+{
+    CpuInfoFastList *head, *cpu;
+    TargetInfo *target;
+
+    target = qmp_query_target(NULL);
+    monitor_printf(mon, "CPU architecture is '%s'\n\n", target->arch);
+    qapi_free_TargetInfo(target);
+
+    head = qmp_query_cpus_fast(NULL);
+
+    for (cpu = head; cpu; cpu = cpu->next) {
+        monitor_printf(mon, "CPU%" PRId64 "\n", cpu->value->cpu_index);
+        monitor_printf(mon, " thread-id=%" PRId64 "\n", cpu->value->thread_id);
+        if (cpu->value->has_halted) {
+            monitor_printf(mon, " halted=%d\n", cpu->value->halted);
+        }
+        monitor_printf(mon, " qom-path=%s\n", cpu->value->qom_path);
+        monitor_printf(mon, "\n");
+    }
+
+    qapi_free_CpuInfoFastList(head);
+}
+
 static void print_block_info(Monitor *mon, BlockInfo *info,
                              BlockDeviceInfo *inserted, bool verbose)
 {
diff --git a/hmp.h b/hmp.h
index 536cb91caa..f4ceba5cc8 100644
--- a/hmp.h
+++ b/hmp.h
@@ -31,6 +31,7 @@ void hmp_info_migrate_capabilities(Monitor *mon, const QDict *qdict);
 void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict);
 void hmp_info_migrate_cache_size(Monitor *mon, const QDict *qdict);
 void hmp_info_cpus(Monitor *mon, const QDict *qdict);
+void hmp_info_cpus_fast(Monitor *mon, const QDict *qdict);
 void hmp_info_block(Monitor *mon, const QDict *qdict);
 void hmp_info_blockstats(Monitor *mon, const QDict *qdict);
 void hmp_info_vnc(Monitor *mon, const QDict *qdict);
diff --git a/qapi-schema.json b/qapi-schema.json
index 5c06745c79..9bc37ea604 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -526,6 +526,12 @@
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
@@ -558,6 +564,77 @@
 ##
 { 'command': 'query-cpus', 'returns': ['CpuInfo'] }
 
+##
+# @CpuInfoFast:
+#
+# Information about a virtual CPU
+#
+# @cpu-index: index of the virtual CPU
+#
+# @halted: true if the virtual CPU is in the halt state.  Halt usually refers
+#          to a processor specific low power mode. This field is optional,
+#          it is only present if the halted state can be retrieved without
+#          a performance penalty
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
+# Notes: @halted is a transient state that changes frequently.  By the time the
+#        data is sent to the client, the guest may no longer be halted.
+##
+{ 'struct': 'CpuInfoFast',
+  'data': {'cpu-index': 'int', '*halted': 'bool', 'qom-path': 'str',
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
 ##
 # @IOThreadInfo:
 #
-- 
2.14.3
