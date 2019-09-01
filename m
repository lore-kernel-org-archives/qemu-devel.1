Return-Path: <SRS0=Jh9c=W4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC55C3A5A4
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 14:27:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84A8C22CE9
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 14:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A8C22CE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4QpO-0001Xg-T5
	for qemu-devel@archiver.kernel.org; Sun, 01 Sep 2019 10:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39507)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1i4QjZ-0004bD-7M
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 10:21:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1i4QjX-0004jv-FX
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 10:21:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:16719)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1i4QjX-0004jJ-6g
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 10:21:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Sep 2019 07:21:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,455,1559545200"; d="scan'208";a="211453097"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.159.36])
 by fmsmga002.fm.intel.com with ESMTP; 01 Sep 2019 07:21:32 -0700
From: Tao Xu <tao3.xu@intel.com>
To: imammedo@redhat.com,
	eblake@redhat.com,
	ehabkost@redhat.com
Date: Sun,  1 Sep 2019 22:21:13 +0800
Message-Id: <20190901142119.20482-6-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190901142119.20482-1-tao3.xu@intel.com>
References: <20190901142119.20482-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.136
Subject: [Qemu-devel] [PATCH v10 05/11] numa: Extend CLI to provide
 initiator information for numa nodes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: jingqi.liu@intel.com, tao3.xu@intel.com, fan.du@intel.com,
 qemu-devel@nongnu.org, daniel@linux.ibm.com, jonathan.cameron@huawei.com,
 dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In ACPI 6.3 chapter 5.2.27 Heterogeneous Memory Attribute Table (HMAT),
The initiator represents processor which access to memory. And in 5.2.27.3
Memory Proximity Domain Attributes Structure, the attached initiator is
defined as where the memory controller responsible for a memory proximity
domain. With attached initiator information, the topology of heterogeneous
memory can be described.

Extend CLI of "-numa node" option to indicate the initiator numa node-id.
In the linux kernel, the codes in drivers/acpi/hmat/hmat.c parse and report
the platform's HMAT tables.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---

Changes in v10:
	- Add machine oprion properties "-machine hmat=on|off" for
	enabling or disabling HMAT in QEMU.
	- Add more description for initiator option.
	- Report error then HMAT is enalbe and initiator option is
	missing. Not allow invaild initiator now. (Igor)
---
 hw/core/machine.c     | 72 +++++++++++++++++++++++++++++++++++++++++++
 hw/core/numa.c        | 11 +++++++
 include/sysemu/numa.h |  6 ++++
 qapi/machine.json     | 10 +++++-
 qemu-options.hx       | 35 ++++++++++++++++++---
 5 files changed, 128 insertions(+), 6 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index c5e0d52fbc..852f05c8c5 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -516,6 +516,20 @@ static void machine_set_nvdimm(Object *obj, bool value, Error **errp)
     ms->nvdimms_state->is_enabled = value;
 }
 
+static bool machine_get_hmat(Object *obj, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    return ms->numa_state->hmat_enabled;
+}
+
+static void machine_set_hmat(Object *obj, bool value, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    ms->numa_state->hmat_enabled = value;
+}
+
 static char *machine_get_nvdimm_persistence(Object *obj, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
@@ -643,6 +657,7 @@ void machine_set_cpu_numa_node(MachineState *machine,
                                const CpuInstanceProperties *props, Error **errp)
 {
     MachineClass *mc = MACHINE_GET_CLASS(machine);
+    NodeInfo *numa_info = machine->numa_state->nodes;
     bool match = false;
     int i;
 
@@ -712,6 +727,16 @@ void machine_set_cpu_numa_node(MachineState *machine,
         match = true;
         slot->props.node_id = props->node_id;
         slot->props.has_node_id = props->has_node_id;
+
+        if (numa_info[props->node_id].initiator_valid &&
+            (props->node_id != numa_info[props->node_id].initiator)) {
+            error_setg(errp, "The initiator of CPU NUMA node %" PRId64
+                       " should be itself.", props->node_id);
+            return;
+        }
+        numa_info[props->node_id].initiator_valid = true;
+        numa_info[props->node_id].has_cpu = true;
+        numa_info[props->node_id].initiator = props->node_id;
     }
 
     if (!match) {
@@ -958,6 +983,13 @@ static void machine_initfn(Object *obj)
 
     if (mc->numa_mem_supported) {
         ms->numa_state = g_new0(NumaState, 1);
+        object_property_add_bool(obj, "hmat",
+                                 machine_get_hmat, machine_set_hmat,
+                                 &error_abort);
+        object_property_set_description(obj, "hmat",
+                                        "Set on/off to enable/disable "
+                                        "ACPI Heterogeneous Memory Attribute "
+                                        "Table (HMAT)", NULL);
     }
 
     /* Register notifier when init is done for sysbus sanity checks */
@@ -1046,6 +1078,41 @@ static char *cpu_slot_to_string(const CPUArchId *cpu)
     return g_string_free(s, false);
 }
 
+static void numa_validate_initiator(NumaState *nstat)
+{
+    int i;
+    NodeInfo *numa_info = nstat->nodes;
+
+    for (i = 0; i < nstat->num_nodes; i++) {
+        if (numa_info[i].initiator >= MAX_NODES) {
+            error_report("The initiator id %" PRIu16 " expects an integer "
+                         "between 0 and %d", numa_info[i].initiator,
+                         MAX_NODES - 1);
+            goto err;
+        }
+
+        if (!numa_info[numa_info[i].initiator].present) {
+            error_report("NUMA node %" PRIu16 " is missing, use "
+                         "'-numa node' option to declare it first.",
+                         numa_info[i].initiator);
+            goto err;
+        }
+
+        if (numa_info[numa_info[i].initiator].has_cpu) {
+            numa_info[i].initiator_valid = true;
+        } else {
+            error_report("The initiator of NUMA node %d is invalid.", i);
+            goto err;
+        }
+    }
+
+    return;
+
+err:
+    error_printf("\n");
+    exit(1);
+}
+
 static void machine_numa_finish_cpu_init(MachineState *machine)
 {
     int i;
@@ -1086,6 +1153,11 @@ static void machine_numa_finish_cpu_init(MachineState *machine)
             machine_set_cpu_numa_node(machine, &props, &error_fatal);
         }
     }
+
+    if (machine->numa_state->hmat_enabled) {
+        numa_validate_initiator(machine->numa_state);
+    }
+
     if (s->len && !qtest_enabled()) {
         warn_report("CPU(s) not present in any NUMA nodes: %s",
                     s->str);
diff --git a/hw/core/numa.c b/hw/core/numa.c
index 1cbaf590af..1e75c26e49 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -133,6 +133,17 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
         numa_info[nodenr].node_mem = object_property_get_uint(o, "size", NULL);
         numa_info[nodenr].node_memdev = MEMORY_BACKEND(o);
     }
+
+    if (node->has_initiator) {
+        if (!ms->numa_state->hmat_enabled) {
+            error_setg(errp, "ACPI Heterogeneous Memory Attribute Table "
+                       "(HMAT) is disabled, use -machine,hmat=yes before "
+                       "set initiator of NUMA");
+            return;
+        }
+
+        numa_info[nodenr].initiator = node->initiator;
+    }
     numa_info[nodenr].present = true;
     max_numa_nodeid = MAX(max_numa_nodeid, nodenr + 1);
     ms->numa_state->num_nodes++;
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index ae9c41d02b..a788c3b126 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -18,6 +18,9 @@ struct NodeInfo {
     uint64_t node_mem;
     struct HostMemoryBackend *node_memdev;
     bool present;
+    bool has_cpu;
+    bool initiator_valid;
+    uint16_t initiator;
     uint8_t distance[MAX_NODES];
 };
 
@@ -33,6 +36,9 @@ struct NumaState {
     /* Allow setting NUMA distance for different NUMA nodes */
     bool have_numa_distance;
 
+    /* Detect if HMAT support is enabled. */
+    bool hmat_enabled;
+
     /* NUMA nodes information */
     NodeInfo nodes[MAX_NODES];
 };
diff --git a/qapi/machine.json b/qapi/machine.json
index ca26779f1a..3c2914cd1c 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -463,6 +463,13 @@
 # @memdev: memory backend object.  If specified for one node,
 #          it must be specified for all nodes.
 #
+# @initiator: defined in ACPI 6.3 Chapter 5.2.27.3 Table 5-145,
+#             indicate the nodeid which has the memory controller
+#             responsible for this NUMA node. This field provides
+#             additional information as to the initiator node that
+#             is closest (as in directly attached) to this node, and
+#             therefore has the best performance (since 4.2)
+#
 # Since: 2.1
 ##
 { 'struct': 'NumaNodeOptions',
@@ -470,7 +477,8 @@
    '*nodeid': 'uint16',
    '*cpus':   ['uint16'],
    '*mem':    'size',
-   '*memdev': 'str' }}
+   '*memdev': 'str',
+   '*initiator': 'uint16' }}
 
 ##
 # @NumaDistOptions:
diff --git a/qemu-options.hx b/qemu-options.hx
index ea0638e92d..9f568c58d1 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -43,7 +43,8 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                suppress-vmdesc=on|off disables self-describing migration (default=off)\n"
     "                nvdimm=on|off controls NVDIMM support (default=off)\n"
     "                enforce-config-section=on|off enforce configuration section migration (default=off)\n"
-    "                memory-encryption=@var{} memory encryption object to use (default=none)\n",
+    "                memory-encryption=@var{} memory encryption object to use (default=none)\n"
+    "                hmat=on|off controls ACPI HMAT support (default=off)\n",
     QEMU_ARCH_ALL)
 STEXI
 @item -machine [type=]@var{name}[,prop=@var{value}[,...]]
@@ -103,6 +104,9 @@ NOTE: this parameter is deprecated. Please use @option{-global}
 @option{migration.send-configuration}=@var{on|off} instead.
 @item memory-encryption=@var{}
 Memory encryption object to use. The default is none.
+@item hmat=on|off
+Enables or disables ACPI Heterogeneous Memory Attribute Table (HMAT) support.
+The default is off.
 @end table
 ETEXI
 
@@ -161,14 +165,14 @@ If any on the three values is given, the total number of CPUs @var{n} can be omi
 ETEXI
 
 DEF("numa", HAS_ARG, QEMU_OPTION_numa,
-    "-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n"
-    "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n"
+    "-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=node]\n"
+    "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=node]\n"
     "-numa dist,src=source,dst=destination,val=distance\n"
     "-numa cpu,node-id=node[,socket-id=x][,core-id=y][,thread-id=z]\n",
     QEMU_ARCH_ALL)
 STEXI
-@item -numa node[,mem=@var{size}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}]
-@itemx -numa node[,memdev=@var{id}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}]
+@item -numa node[,mem=@var{size}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}][,initiator=@var{initiator}]
+@itemx -numa node[,memdev=@var{id}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}][,initiator=@var{initiator}]
 @itemx -numa dist,src=@var{source},dst=@var{destination},val=@var{distance}
 @itemx -numa cpu,node-id=@var{node}[,socket-id=@var{x}][,core-id=@var{y}][,thread-id=@var{z}]
 @findex -numa
@@ -215,6 +219,27 @@ split equally between them.
 @samp{mem} and @samp{memdev} are mutually exclusive. Furthermore,
 if one node uses @samp{memdev}, all of them have to use it.
 
+@samp{initiator} is an additional option indicate the @var{initiator}
+NUMA that has best performance (the lowest latency or largest bandwidth)
+to this NUMA @var{node}. Note that this option can be set only when
+the machine oprion properties "-machine hmat=on".
+
+Following example creates a machine with 2 NUMA nodes, node 0 has CPU.
+node 1 has only memory, and its' initiator is node 0. Note that because
+node 0 has CPU, by default the initiator of node 0 is itself and must be
+itself.
+@example
+-machine hmat=on \
+-m 2G,slots=2,maxmem=4G \
+-object memory-backend-ram,size=1G,id=m0 \
+-object memory-backend-ram,size=1G,id=m1 \
+-numa node,nodeid=0,memdev=m0 \
+-numa node,nodeid=1,memdev=m1,initiator=0 \
+-smp 2,sockets=2,maxcpus=2  \
+-numa cpu,node-id=0,socket-id=0 \
+-numa cpu,node-id=0,socket-id=1
+@end example
+
 @var{source} and @var{destination} are NUMA node IDs.
 @var{distance} is the NUMA distance from @var{source} to @var{destination}.
 The distance from a node to itself is always 10. If any pair of nodes is
-- 
2.20.1


