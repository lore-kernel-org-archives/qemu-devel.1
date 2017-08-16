Received: from eggs.gnu.org ([2001:4830:134:3::10]:44937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vadim.galitsyn@profitbricks.com>) id 1dhw9v-0000lB-2P
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 07:06:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vadim.galitsyn@profitbricks.com>) id 1dhw9q-0008CV-SN
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 07:06:47 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:33944)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vadim.galitsyn@profitbricks.com>)
	id 1dhw9q-0008Aq-HR
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 07:06:42 -0400
Received: by mail-wr0-x232.google.com with SMTP id y96so9027039wrc.1
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 04:06:42 -0700 (PDT)
From: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Date: Wed, 16 Aug 2017 13:06:24 +0200
Message-Id: <1502881586-25044-1-git-send-email-vadim.galitsyn@profitbricks.com>
Subject: [Qemu-devel] [PATCH v6 1/3] Extend "info numa" with hotplugged
 memory information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>

Report amount of hotplugged memory in addition to total
amount per NUMA node.

Signed-off-by: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org
---
 include/qemu/typedefs.h |  1 +
 include/sysemu/numa.h   |  7 ++++++-
 monitor.c               |  9 ++++++---
 numa.c                  | 18 +++++++++++++-----
 4 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 39bc835..e5f5347 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -100,6 +100,7 @@ typedef struct uWireSlave uWireSlave;
 typedef struct VirtIODevice VirtIODevice;
 typedef struct Visitor Visitor;
 typedef struct node_info NodeInfo;
+typedef struct numa_node_mem NumaNodeMem;
 typedef void SaveStateHandler(QEMUFile *f, void *opaque);
 typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id);
 
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 610eece..af2e2d3 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -24,9 +24,14 @@ struct node_info {
     uint8_t distance[MAX_NODES];
 };
 
+struct numa_node_mem {
+    uint64_t node_mem;
+    uint64_t node_hotpluggable_mem;
+};
+
 extern NodeInfo numa_info[MAX_NODES];
 void parse_numa_opts(MachineState *ms);
-void query_numa_node_mem(uint64_t node_mem[]);
+void query_numa_node_mem(NumaNodeMem node_mem[]);
 extern QemuOptsList qemu_numa_opts;
 void numa_set_mem_node_id(ram_addr_t addr, uint64_t size, uint32_t node);
 void numa_unset_mem_node_id(ram_addr_t addr, uint64_t size, uint32_t node);
diff --git a/monitor.c b/monitor.c
index e0f8801..46506ba 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1710,11 +1710,12 @@ static void hmp_info_mtree(Monitor *mon, const QDict *qdict)
 static void hmp_info_numa(Monitor *mon, const QDict *qdict)
 {
     int i;
-    uint64_t *node_mem;
+    NumaNodeMem *node_mem;
     CpuInfoList *cpu_list, *cpu;
 
     cpu_list = qmp_query_cpus(&error_abort);
-    node_mem = g_new0(uint64_t, nb_numa_nodes);
+    node_mem = g_new0(NumaNodeMem, nb_numa_nodes);
+
     query_numa_node_mem(node_mem);
     monitor_printf(mon, "%d nodes\n", nb_numa_nodes);
     for (i = 0; i < nb_numa_nodes; i++) {
@@ -1727,7 +1728,9 @@ static void hmp_info_numa(Monitor *mon, const QDict *qdict)
         }
         monitor_printf(mon, "\n");
         monitor_printf(mon, "node %d size: %" PRId64 " MB\n", i,
-                       node_mem[i] >> 20);
+                       node_mem[i].node_mem >> 20);
+        monitor_printf(mon, "node %d hotplugged: %" PRId64 " MB\n", i,
+                       node_mem[i].node_hotpluggable_mem >> 20);
     }
     qapi_free_CpuInfoList(cpu_list);
     g_free(node_mem);
diff --git a/numa.c b/numa.c
index e32af04..e3b4013 100644
--- a/numa.c
+++ b/numa.c
@@ -591,11 +591,12 @@ void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
     }
 }
 
-static void numa_stat_memory_devices(uint64_t node_mem[])
+static void numa_stat_memory_devices(NumaNodeMem node_mem[])
 {
     MemoryDeviceInfoList *info_list = NULL;
     MemoryDeviceInfoList **prev = &info_list;
     MemoryDeviceInfoList *info;
+    PCDIMMDeviceInfo     *pcdimm_info;
 
     qmp_pc_dimm_device_list(qdev_get_machine(), &prev);
     for (info = info_list; info; info = info->next) {
@@ -603,9 +604,16 @@ static void numa_stat_memory_devices(uint64_t node_mem[])
 
         if (value) {
             switch (value->type) {
-            case MEMORY_DEVICE_INFO_KIND_DIMM:
-                node_mem[value->u.dimm.data->node] += value->u.dimm.data->size;
+            case MEMORY_DEVICE_INFO_KIND_DIMM: {
+                pcdimm_info = value->u.dimm.data;
+                node_mem[pcdimm_info->node].node_mem += pcdimm_info->size;
+                if (pcdimm_info->hotpluggable && pcdimm_info->hotplugged) {
+                    node_mem[pcdimm_info->node].node_hotpluggable_mem +=
+                        pcdimm_info->size;
+                }
                 break;
+            }
+
             default:
                 break;
             }
@@ -614,7 +622,7 @@ static void numa_stat_memory_devices(uint64_t node_mem[])
     qapi_free_MemoryDeviceInfoList(info_list);
 }
 
-void query_numa_node_mem(uint64_t node_mem[])
+void query_numa_node_mem(NumaNodeMem node_mem[])
 {
     int i;
 
@@ -624,7 +632,7 @@ void query_numa_node_mem(uint64_t node_mem[])
 
     numa_stat_memory_devices(node_mem);
     for (i = 0; i < nb_numa_nodes; i++) {
-        node_mem[i] += numa_info[i].node_mem;
+        node_mem[i].node_mem += numa_info[i].node_mem;
     }
 }
 
-- 
2.1.4
