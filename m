Received: from eggs.gnu.org ([2001:4830:134:3::10]:35765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d8PpY-00086e-TH
	for qemu-devel@nongnu.org; Wed, 10 May 2017 07:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d8PpX-0001ue-Kt
	for qemu-devel@nongnu.org; Wed, 10 May 2017 07:30:56 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 10 May 2017 13:30:01 +0200
Message-Id: <1494415802-227633-18-git-send-email-imammedo@redhat.com>
In-Reply-To: <1494415802-227633-1-git-send-email-imammedo@redhat.com>
References: <1494415802-227633-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 17/18] numa: add '-numa cpu,
 ...' option for property based node mapping
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

legacy cpu to node mapping is using cpu index values to map
VCPU to node with help of '-numa node,nodeid=node,cpus=x[-y]'
option. However cpu index is internal concept and QEMU users
have to guess /reimplement qemu's logic/ to map it to
a concrete cpu socket/core/thread to make sane CPUs
placement across numa nodes.

This patch allows to map cpu objects to numa nodes using
the same properties as used for cpus with -device/device_add
(socket-id/core-id/thread-id/node-id).

At present valid properties/values to address CPUs could be
fetched using hotpluggable-cpus monitor/qmp command, it will
require user to start qemu twice when creating domain to fetch
possible CPUs for a machine type/-smp layout first and
then the second time with numa explicit mapping for actual
usage. The first step results could be saved and reused to
set/change mapping later as far as machine type/-smp stays
the same.

Proposed impl. supports exact and wildcard matching to
simplify CLI and allow to set mapping for a specific cpu
or group of cpu objects specified by matched properties.

For example:

   # exact mapping x86
   -numa cpu,node-id=x,socket-id=y,core-id=z,thread-id=n

   # exact mapping SPAPR
   -numa cpu,node-id=x,core-id=y

   # wildcard mapping, all cpu objects that match socket-id=y
   # are mapped to node-id=x
   -numa cpu,node-id=x,socket-id=y

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v3:
  - use qapi_NumaCpuOptions_base() instead of copying fields manually
    (Eduardo)
v2:
  - use new NumaCpuOptions instead of CpuInstanceProperties in
    NumaOptions, so that in future we could decouple both
    if needed. (Eduardo Habkost <ehabkost@redhat.com>)
  - clarify effect of NumaCpuOptions.node-id in qapi-schema.json
---
 numa.c           | 15 +++++++++++++++
 qapi-schema.json | 21 +++++++++++++++++++--
 qemu-options.hx  | 20 ++++++++++++++++++++
 3 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/numa.c b/numa.c
index ca122cc..84ce2af 100644
--- a/numa.c
+++ b/numa.c
@@ -290,6 +290,21 @@ static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
             goto end;
         }
         break;
+    case NUMA_OPTIONS_TYPE_CPU:
+        if (!object->u.cpu.has_node_id) {
+            error_setg(&err, "Missing mandatory node-id property");
+            goto end;
+        }
+        if (!numa_info[object->u.cpu.node_id].present) {
+            error_setg(&err, "Invalid node-id=%" PRId64 ", NUMA node must be "
+                "defined with -numa node,nodeid=ID before it's used with "
+                "-numa cpu,node-id=ID", object->u.cpu.node_id);
+            goto end;
+        }
+
+        machine_set_cpu_numa_node(ms, qapi_NumaCpuOptions_base(&object->u.cpu),
+                                  &err);
+        break;
     default:
         abort();
     }
diff --git a/qapi-schema.json b/qapi-schema.json
index f1bcebe..c9fdbc3 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -5684,10 +5684,12 @@
 #
 # @dist: NUMA distance configuration (since 2.10)
 #
+# @cpu: property based CPU(s) to node mapping (Since: 2.10)
+#
 # Since: 2.1
 ##
 { 'enum': 'NumaOptionsType',
-  'data': [ 'node', 'dist' ] }
+  'data': [ 'node', 'dist', 'cpu' ] }
 
 ##
 # @NumaOptions:
@@ -5701,7 +5703,8 @@
   'discriminator': 'type',
   'data': {
     'node': 'NumaNodeOptions',
-    'dist': 'NumaDistOptions' }}
+    'dist': 'NumaDistOptions',
+    'cpu': 'NumaCpuOptions' }}
 
 ##
 # @NumaNodeOptions:
@@ -5751,6 +5754,20 @@
    'val': 'uint8' }}
 
 ##
+# @NumaCpuOptions:
+#
+# Option "-numa cpu" overrides default cpu to node mapping.
+# It accepts the same set of cpu properties as returned by
+# query-hotpluggable-cpus[].props, where node-id could be used to
+# override default node mapping.
+#
+# Since: 2.10
+##
+{ 'struct': 'NumaCpuOptions',
+   'base': 'CpuInstanceProperties',
+   'data' : {} }
+
+##
 # @HostMemPolicy:
 #
 # Host memory policy types
diff --git a/qemu-options.hx b/qemu-options.hx
index cfe4dc3..731f1bd 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -145,10 +145,12 @@ STEXI
 @item -numa node[,mem=@var{size}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}]
 @itemx -numa node[,memdev=@var{id}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}]
 @itemx -numa dist,src=@var{source},dst=@var{destination},val=@var{distance}
+@itemx -numa cpu,node-id=@var{node}[,socket-id=@var{x}][,core-id=@var{y}][,thread-id=@var{z}]
 @findex -numa
 Define a NUMA node and assign RAM and VCPUs to it.
 Set the NUMA distance from a source node to a destination node.
 
+Legacy VCPU assignment uses @samp{cpus} option where
 @var{firstcpu} and @var{lastcpu} are CPU indexes. Each
 @samp{cpus} option represent a contiguous range of CPU indexes
 (or a single VCPU if @var{lastcpu} is omitted). A non-contiguous
@@ -162,6 +164,24 @@ a NUMA node:
 -numa node,cpus=0-2,cpus=5
 @end example
 
+@samp{cpu} option is a new alternative to @samp{cpus} option
+which uses @samp{socket-id|core-id|thread-id} properties to assign
+CPU objects to a @var{node} using topology layout properties of CPU.
+The set of properties is machine specific, and depends on used
+machine type/@samp{smp} options. It could be queried with
+@samp{hotpluggable-cpus} monitor command.
+@samp{node-id} property specifies @var{node} to which CPU object
+will be assigned, it's required for @var{node} to be declared
+with @samp{node} option before it's used with @samp{cpu} option.
+
+For example:
+@example
+-M pc \
+-smp 1,sockets=2,maxcpus=2 \
+-numa node,nodeid=0 -numa node,nodeid=1 \
+-numa cpu,node-id=0,socket-id=0 -numa cpu,node-id=1,socket-id=1
+@end example
+
 @samp{mem} assigns a given RAM amount to a node. @samp{memdev}
 assigns RAM from a given memory backend device to a node. If
 @samp{mem} and @samp{memdev} are omitted in all nodes, RAM is
-- 
2.7.4
