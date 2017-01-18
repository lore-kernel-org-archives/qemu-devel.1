Received: from eggs.gnu.org ([2001:4830:134:3::10]:57067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTtoC-0002Ij-FM
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:14:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTtoB-0007RE-Di
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:14:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37269)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cTtoB-0007Qr-5k
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:14:03 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 18 Jan 2017 18:13:27 +0100
Message-Id: <1484759609-264075-12-git-send-email-imammedo@redhat.com>
In-Reply-To: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
References: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC 11/13] numa: use new machine.cpu property with
 -numa cpus=... CLI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>, fanc.fnst@cn.fujitsu.com, caoj.fnst@cn.fujitsu.com, stefanha@redhat.com, izumi.taku@jp.fujitsu.com, vilanova@ac.upc.edu, ehabkost@redhat.com, peter.maydell@linaro.org, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>

add compat layer to legacy cpu_index based '-numa cpus=...'
CLI option, which will use new machine.cpu property to set
numa mapping if that propety is available.

This way machine that supports machine.cpu property will
not break legacy CLI but will be able to move away from
using numa_info[node_id].node_cpu bitmaps and use only
possible_cpus instead.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 numa.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 48 insertions(+), 15 deletions(-)

diff --git a/numa.c b/numa.c
index 887ee58..0c34130 100644
--- a/numa.c
+++ b/numa.c
@@ -141,10 +141,35 @@ uint32_t numa_get_node(ram_addr_t addr, Error **errp)
     return -1;
 }
 
-static void numa_node_parse(NumaNodeOptions *node, QemuOpts *opts, Error **errp)
+static void numa_cpu_set_nid(MachineState *ms, CpuInstanceProperties *props,
+                             Error **errp)
+{
+    Visitor *v;
+    QObject *qobj;
+    Error *local_error = NULL;
+
+    v = qobject_output_visitor_new(&qobj);
+    visit_type_CpuInstanceProperties(v, "cpu", &props, &local_error);
+    visit_complete(v, &qobj);
+    visit_free(v);
+    if (local_error) {
+        goto end;
+    }
+    v = qobject_input_visitor_new(qobj, true);
+    object_property_set(OBJECT(ms), v, "cpu", &local_error);
+    visit_free(v);
+    qobject_decref(qobj);
+end:
+    error_propagate(errp, local_error);
+}
+
+static void numa_node_parse(MachineState *ms, NumaNodeOptions *node,
+                            QemuOpts *opts, Error **errp)
 {
     uint16_t nodenr;
     uint16List *cpus = NULL;
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    bool has_cpu_prop = object_property_find(OBJECT(ms), "cpu", NULL);
 
     if (node->has_nodeid) {
         nodenr = node->nodeid;
@@ -172,6 +197,19 @@ static void numa_node_parse(NumaNodeOptions *node, QemuOpts *opts, Error **errp)
             return;
         }
         bitmap_set(numa_info[nodenr].node_cpu, cpus->value, 1);
+        if (mc->cpu_index_to_instance_props && has_cpu_prop) {
+            CpuInstanceProperties props;
+            Error *local_error = NULL;
+
+            props = mc->cpu_index_to_instance_props(ms, cpus->value);
+            props.has_node_id = true;
+            props.node_id = nodenr;
+            numa_cpu_set_nid(ms, &props, &local_error);
+            if (local_error) {
+                error_propagate(errp, local_error);
+                return;
+            }
+        }
     }
 
     if (node->has_mem && node->has_memdev) {
@@ -232,26 +270,14 @@ static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
 
     switch (object->type) {
     case NUMA_OPTIONS_KIND_NODE:
-        numa_node_parse(object->u.node.data, opts, &err);
+        numa_node_parse(ms, object->u.node.data, opts, &err);
         if (err) {
             goto end;
         }
         nb_numa_nodes++;
         break;
     case NUMA_OPTIONS_KIND_CPU: {
-        QObject *qobj;
-
-        v = qobject_output_visitor_new(&qobj);
-        visit_type_CpuInstanceProperties(v, "cpu", &object->u.cpu.data, &err);
-        visit_complete(v, &qobj);
-        visit_free(v);
-        if (err) {
-            goto end;
-        }
-        v = qobject_input_visitor_new(qobj, true);
-        object_property_set(OBJECT(ms), v, "cpu", &err);
-        visit_free(v);
-        qobject_decref(qobj);
+        numa_cpu_set_nid(ms, object->u.cpu.data, &err);
         if (err) {
             goto end;
         }
@@ -402,6 +428,8 @@ void parse_numa_opts(MachineState *ms)
          * would be on the same node.
          */
         if (i == nb_numa_nodes) {
+            bool has_cpu_prop = object_property_find(OBJECT(ms), "cpu", NULL);
+
             for (i = 0; i < max_cpus; i++) {
                 unsigned node_id = i % nb_numa_nodes;
                 if (mc->cpu_index_to_instance_props) {
@@ -409,6 +437,11 @@ void parse_numa_opts(MachineState *ms)
                     topo = mc->cpu_index_to_instance_props(ms, i);
                     assert(topo.has_socket_id);
                     node_id = topo.socket_id % nb_numa_nodes;
+                    if (has_cpu_prop) {
+                        topo.has_node_id = true;
+                        topo.node_id = node_id;
+                        numa_cpu_set_nid(ms, &topo, &error_fatal);
+                    }
                 }
 
                 set_bit(i, numa_info[node_id].node_cpu);
-- 
2.7.4
