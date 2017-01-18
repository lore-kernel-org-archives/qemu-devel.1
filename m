Received: from eggs.gnu.org ([2001:4830:134:3::10]:57003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTto7-0002E1-CO
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:14:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTto6-0007Oe-87
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:13:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cTto6-0007OE-0O
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:13:58 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 18 Jan 2017 18:13:25 +0100
Message-Id: <1484759609-264075-10-git-send-email-imammedo@redhat.com>
In-Reply-To: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
References: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC 09/13] numa: introduce '-numa cpu' cpu option
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

It allows to specify mapping of a CPU to NUMA node on CLI.
Option should be repeated for each present/possible CPU.
Example for PC machine:
  -numa node,nodeid=0 -numa node,nodeid=1 \
  -numa cpu,socket-id=0,core-id=0,thread-id=0,node-id=0 \
  -numa cpu,socket-id=1,core-id=0,thread-id=0,node-id=1

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/sysemu/numa.h |  2 +-
 numa.c                | 30 +++++++++++++++++++++++++++---
 qapi-schema.json      |  3 ++-
 vl.c                  |  2 +-
 4 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index b8015a5..d4b139e 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -24,7 +24,7 @@ typedef struct node_info {
 } NodeInfo;
 
 extern NodeInfo numa_info[MAX_NODES];
-void parse_numa_opts(MachineClass *mc);
+void parse_numa_opts(MachineState *ms);
 void query_numa_node_mem(uint64_t node_mem[]);
 extern QemuOptsList qemu_numa_opts;
 void numa_set_mem_node_id(ram_addr_t addr, uint64_t size, uint32_t node);
diff --git a/numa.c b/numa.c
index 5f68497..0164cd7 100644
--- a/numa.c
+++ b/numa.c
@@ -37,6 +37,8 @@
 #include "hw/mem/pc-dimm.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
+#include "qapi/qobject-output-visitor.h"
+#include "qapi/qobject-input-visitor.h"
 
 QemuOptsList qemu_numa_opts = {
     .name = "numa",
@@ -213,11 +215,13 @@ static void numa_node_parse(NumaNodeOptions *node, QemuOpts *opts, Error **errp)
 
 static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
 {
+    Visitor *v;
     NumaOptions *object = NULL;
+    MachineState *ms = MACHINE(opaque);
     Error *err = NULL;
 
     {
-        Visitor *v = opts_visitor_new(opts);
+        v = opts_visitor_new(opts);
         visit_type_NumaOptions(v, NULL, &object, &err);
         visit_free(v);
     }
@@ -234,6 +238,25 @@ static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
         }
         nb_numa_nodes++;
         break;
+    case NUMA_OPTIONS_KIND_CPU: {
+        QObject *qobj;
+
+        v = qobject_output_visitor_new(&qobj);
+        visit_type_CpuInstanceProperties(v, "cpu", &object->u.cpu.data, &err);
+        visit_complete(v, &qobj);
+        visit_free(v);
+        if (err) {
+            goto end;
+        }
+        v = qobject_input_visitor_new(qobj, true);
+        object_property_set(OBJECT(ms), v, "cpu", &err);
+        visit_free(v);
+        qobject_decref(qobj);
+        if (err) {
+            goto end;
+        }
+        break;
+    }
     default:
         abort();
     }
@@ -293,15 +316,16 @@ static void validate_numa_cpus(void)
     g_free(seen_cpus);
 }
 
-void parse_numa_opts(MachineClass *mc)
+void parse_numa_opts(MachineState *ms)
 {
     int i;
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
 
     for (i = 0; i < MAX_NODES; i++) {
         numa_info[i].node_cpu = bitmap_new(max_cpus);
     }
 
-    if (qemu_opts_foreach(qemu_find_opts("numa"), parse_numa, NULL, NULL)) {
+    if (qemu_opts_foreach(qemu_find_opts("numa"), parse_numa, ms, NULL)) {
         exit(1);
     }
 
diff --git a/qapi-schema.json b/qapi-schema.json
index ddc8783..69c059b 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -5543,7 +5543,8 @@
 ##
 { 'union': 'NumaOptions',
   'data': {
-    'node': 'NumaNodeOptions' }}
+    'node': 'NumaNodeOptions',
+    'cpu': 'CpuInstanceProperties' }}
 
 ##
 # @NumaNodeOptions:
diff --git a/vl.c b/vl.c
index afe40ce..d724523 100644
--- a/vl.c
+++ b/vl.c
@@ -4485,7 +4485,7 @@ int main(int argc, char **argv, char **envp)
     default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
     default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
 
-    parse_numa_opts(machine_class);
+    parse_numa_opts(current_machine);
 
     if (qemu_opts_foreach(qemu_find_opts("mon"),
                           mon_init_func, NULL, NULL)) {
-- 
2.7.4
