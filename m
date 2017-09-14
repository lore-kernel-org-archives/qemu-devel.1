Received: from eggs.gnu.org ([2001:4830:134:3::10]:60493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dsVi3-00078N-ON
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dsVi0-0002oK-G0
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:05:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dsVi0-0002nS-7h
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:05:40 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 14 Sep 2017 16:04:45 +0100
Message-Id: <20170914150447.19352-6-dgilbert@redhat.com>
In-Reply-To: <20170914150447.19352-1-dgilbert@redhat.com>
References: <20170914150447.19352-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 5/7] hmp: extend "info numa" with hotplugged
 memory information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, lvivier@redhat.com, cohuck@redhat.com, vadim.galitsyn@profitbricks.com
Cc: imammedo@redhat.com, thuth@redhat.com, peterx@redhat.com, groug@kaod.org

From: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>

Report amount of hotplugged memory in addition to total
amount per NUMA node.

Signed-off-by: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org
Message-Id: <20170829153022.27004-2-vadim.galitsyn@profitbricks.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/qemu/typedefs.h |  1 +
 include/sysemu/numa.h   |  7 ++++++-
 monitor.c               |  9 ++++++---
 numa.c                  | 18 +++++++++++++-----
 4 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 39bc8351a3..163550214c 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -58,6 +58,7 @@ typedef struct MSIMessage MSIMessage;
 typedef struct NetClientState NetClientState;
 typedef struct NetFilterState NetFilterState;
 typedef struct NICInfo NICInfo;
+typedef struct NumaNodeMem NumaNodeMem;
 typedef struct PcGuestInfo PcGuestInfo;
 typedef struct PCIBridge PCIBridge;
 typedef struct PCIBus PCIBus;
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 610eece211..5c6df2820b 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -24,9 +24,14 @@ struct node_info {
     uint8_t distance[MAX_NODES];
 };
 
+struct NumaNodeMem {
+    uint64_t node_mem;
+    uint64_t node_plugged_mem;
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
index 9239f7adde..058045b3cb 100644
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
+        monitor_printf(mon, "node %d plugged: %" PRId64 " MB\n", i,
+                       node_mem[i].node_plugged_mem >> 20);
     }
     qapi_free_CpuInfoList(cpu_list);
     g_free(node_mem);
diff --git a/numa.c b/numa.c
index e32af04cd2..fe066ad2f8 100644
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
+                    node_mem[pcdimm_info->node].node_plugged_mem +=
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
2.13.5
