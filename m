Received: from eggs.gnu.org ([2001:4830:134:3::10]:55841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d3gQ8-0005Zr-14
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 06:13:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d3gQ5-0008Qw-0Z
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 06:13:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1d3gQ4-0008QD-Na
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 06:13:04 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Thu, 27 Apr 2017 12:12:58 +0200
Message-Id: <20170427101259.13798-2-lvivier@redhat.com>
In-Reply-To: <20170427101259.13798-1-lvivier@redhat.com>
References: <20170427101259.13798-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] numa: introduce numa_auto_assign_ram()
 function in MachineClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>

We need to change the way we distribute the memory across
the nodes. To keep compatibility between machine type version
introduce a  machine type dependent function.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 include/hw/boards.h |  2 ++
 numa.c              | 44 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 31d9c72..e571b22 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -136,6 +136,8 @@ struct MachineClass {
     int minimum_page_bits;
     bool has_hotpluggable_cpus;
     int numa_mem_align_shift;
+    void (*numa_auto_assign_ram)(uint64_t *nodes,
+                                 int nb_nodes, ram_addr_t size);
 
     HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
                                            DeviceState *dev);
diff --git a/numa.c b/numa.c
index 6fc2393..2770c18 100644
--- a/numa.c
+++ b/numa.c
@@ -294,6 +294,38 @@ static void validate_numa_cpus(void)
     g_free(seen_cpus);
 }
 
+static void numa_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
+                                 int nb_nodes, ram_addr_t size)
+{
+    int i;
+    uint64_t usedmem = 0;
+
+    if (mc->numa_auto_assign_ram) {
+        uint64_t *mem = g_new(uint64_t, nb_nodes);
+
+        mc->numa_auto_assign_ram(mem, nb_nodes, size);
+
+        for (i = 0; i < nb_nodes; i++) {
+            nodes[i].node_mem = mem[i];
+        }
+
+        g_free(mem);
+
+        return;
+    }
+
+    /* Align each node according to the alignment
+     * requirements of the machine class
+     */
+
+    for (i = 0; i < nb_nodes - 1; i++) {
+        nodes[i].node_mem = (size / nb_nodes) &
+                            ~((1 << mc->numa_mem_align_shift) - 1);
+        usedmem += nodes[i].node_mem;
+    }
+    nodes[i].node_mem = size - usedmem;
+}
+
 void parse_numa_opts(MachineClass *mc)
 {
     int i;
@@ -336,17 +368,7 @@ void parse_numa_opts(MachineClass *mc)
             }
         }
         if (i == nb_numa_nodes) {
-            uint64_t usedmem = 0;
-
-            /* Align each node according to the alignment
-             * requirements of the machine class
-             */
-            for (i = 0; i < nb_numa_nodes - 1; i++) {
-                numa_info[i].node_mem = (ram_size / nb_numa_nodes) &
-                                        ~((1 << mc->numa_mem_align_shift) - 1);
-                usedmem += numa_info[i].node_mem;
-            }
-            numa_info[i].node_mem = ram_size - usedmem;
+            numa_auto_assign_ram(mc, numa_info, nb_numa_nodes, ram_size);
         }
 
         numa_total = 0;
-- 
2.9.3
